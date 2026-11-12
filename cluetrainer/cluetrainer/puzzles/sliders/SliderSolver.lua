-- SliderSolver.lua
-- This is an AI assited translation of the coroutine based PDBSolver.
-- It's less efficient, but at least is doesn't crash the client
local zyklib          = require("zyklib")
local schema          = require("cluetrainer/util/schema")
local storage         = require("cluetrainer/util/storage")
local SliderState     = require("cluetrainer/puzzles/sliders/SliderState")
local Move            = require("cluetrainer/puzzles/sliders/Move")
local RegionGraph     = require("cluetrainer/puzzles/sliders/pdb/RegionGraph")
local PdbData         = require("cluetrainer/puzzles/sliders/pdb/PdbData")
local util            = require("cluetrainer/util")
local PdbSolverTicked = require("cluetrainer/puzzles/sliders/pdb/PdbSolverTicked")



---@class ct.sliders.SliderSolver
local slider_solver    = {}

---@class ct.sliders.slider_solver.settings
slider_solver.settings = {
  enabled = ctGlobal.persistence:profileVariable("sliders/enabled", schema.bool({ default = true })),
  mode = ctGlobal.persistence:profileVariable("sliders/mode",
    schema.choices({ choices = { "keyboard", "mouse", "hybrid" }, default = "mouse" })),
  prevent_overlap = ctGlobal.persistence:profileVariable("sliders/prevent_overlap", schema.bool({ default = true })),
  lookahead = ctGlobal.persistence:profileVariable("sliders/lookahead", schema.int({ min = 2, max = 10, default = 5 })),
  show_recovery_moves = ctGlobal.persistence:profileVariable("sliders/show_recovery_moves",
    schema.bool({ default = true })),
  color_mainline = ctGlobal.persistence:profileVariable("sliders/color_mainline",
    schema.colour({ default = 0x00FF00FF, allow_transparency = false })),
  color_recovery = ctGlobal.persistence:profileVariable("sliders/color_recovery",
    schema.colour({ default = 0xff6600FF, allow_transparency = false })),
  solve_time = ctGlobal.persistence:profileVariable("sliders/solve_time",
    schema.int({ min = 100, max = 5000, default = 200 })),
  estimate_slider_speed = ctGlobal.persistence:profileVariable("sliders/estimate_slider_speed",
    schema.bool({ default = true })),
}

---@alias ct.sliders.PdbLoadState {progress: number, data: zyklib.async.Promise<ct.sliders.pdb.RegionGraph>}

---Loads the slider tables that ship with the plugin, one part file per tick, so no tick comes near the client's time
---limit per callback.
---@return ct.sliders.PdbLoadState
local function loadPDB()
  local loading = {
    progress = 0,
    data = zyklib.async.Promise.new()
  }
  local pdb_data = PdbData.new()

  local function step()
    local loaded, done = pcall(pdb_data.step, pdb_data)
    if not loaded then
      loading.data:reject("Failed to load the slider tables: " .. tostring(done))
      return
    end
    loading.progress = pdb_data:progress()

    if not done then
      zyklib.game_events.native.Logic:once(step)
      return
    end

    -- `true` also uses every table on the board mirrored along its diagonal (rows become columns), which doubles the
    -- routes the solver can take without extra data.
    local built, graph = pcall(function() return RegionGraph.new(pdb_data.tables, true) end)
    if built then
      loading.data:resolve(graph)
    else
      loading.data:reject("Failed to read the slider tables")
    end
  end

  zyklib.game_events.native.Logic:once(step)

  return loading
end

---@type ct.sliders.PdbLoadState?
local current_load = nil

---The running or finished load, which keeps the tables for the session. Starts a new one when the last one failed, so
---the next slider tries again without reloading the plugin.
---@return ct.sliders.PdbLoadState
local function pdb()
  local loading = current_load
  if loading == nil then
    loading = loadPDB()
    current_load = loading
    loading.data:onFailure(function()
      if current_load == loading then current_load = nil end
    end)
  end
  return loading
end

local STROKE = 3
local CONTRAST_BORDER = 2
local COLOR_CONTRAST = 0x000000FF

-- Offset of the canvas content's top-left corner. Applied to everything drawn on the canvases.
-- Lazily determined by the position of the puzzle layer within the UI.
local CANVAS_OFFSET = zyklib.util.lazy(function()
  -- Create the canvas for the solution overlay
  local layer = ui.Interfaces:GetComponent(id.Component.SLIDE_PUZZLE__PUZZLE_LAYER) --[[@as ui.ComponentCollection]]

  return { x = layer.xyLocal.x, y = layer.xyLocal.y }
end)

-- Canvas-relative positions of the solving overlay (the canvas covers the 5x5 tile area)
local PROGRESS_VERTICAL_OFFSET = -7
-- Center of the first statistics line at the bottom of the canvas. Further lines follow 20px below.
local STATS_POSITION = { x = 137, y = 260 }
local TICK_SECONDS = 0.02

local SMALL_TEXT_CONFIG = ui.TextDataConfig.new()
SMALL_TEXT_CONFIG.alignHorizontal = ui.AlignMode.CENTRE
SMALL_TEXT_CONFIG.alignVertical = ui.AlignMode.CENTRE
SMALL_TEXT_CONFIG.font = id.Font.NOTOSANS_14
SMALL_TEXT_CONFIG.rgba = 0xFFFFFFFF
SMALL_TEXT_CONFIG.shadowRGBA = 0x000000FF
SMALL_TEXT_CONFIG.isShadowed = true

---@class ct.sliders.RecoverySolution
---@field sequence ct.sliders.AugmentedMove[] Moves leading back to the mainline. Empty while the player is on the mainline
---@field last_known_state ct.sliders.SliderState? The last state the player was in while recovering
---@field recovering_to_mainline_index integer The mainline entry the recovery leads back to

---@alias ct.sliders.ct.sliders.ActiveSliderPuzzle.State
---           | {state: "waitingforpdb", last_drawn_progress: number?, progress: ct.sliders.PdbLoadState}
---           | {state: "solving", start_tick: number, solver: ct.sliders.pdb.PdbSolverTicked}
---           | {state: "executing", start_tick: number, solution: ct.sliders.AugmentedMove[], mainline_index: integer, last_mainline_state: ct.sliders.SliderState, finished_tick: integer?, last_drawn_state: ct.sliders.SliderState?, last_drawn_arrows_inverted: boolean?, recovery_solution: ct.sliders.RecoverySolution}
---           | {state: "failed", reason: string}


---@class ct.sliders.ActiveSliderPuzzle: zyklib.disposable.IDisposable
---@field solution_canvas ui.Canvas
---@field progress_canvas ui.Canvas
---@field solution ct.sliders.AugmentedMove[]
---@field lifetime zyklib.disposable.DisposableGroup
---@field ticks number
---@field state ct.sliders.ct.sliders.ActiveSliderPuzzle.State
local ActivePuzzle = {}
ActivePuzzle.__index = ActivePuzzle

---Draws the slider puzzle overlay.
---@param state ct.sliders.SliderState The current puzzle state
function ActivePuzzle:drawSolution(state)
  assert(self.state.state == "executing")

  local arrows_inverted = var.VarPlayer.SLIDE_PUZZLE_KEYBOARD_INVERT.value ~= 0

  local canvas = self.solution_canvas
  canvas:Clear()

  --- Center of a tile index (1-25) in canvas coordinates
  local function centerOfTile(index)
    return ((index - 1) % 5) * 56 + 24 + CANVAS_OFFSET().x, ((index - 1) // 5) * 56 + 24 + CANVAS_OFFSET().y
  end

  local s = self.state
  local solution = s.solution
  local mainline_index = s.mainline_index

  -- The current state is not on the solution path (the player is lost), so there is nothing meaningful to show
  if mainline_index < 0 then return end

  -- Tiles to click next. While recovering, the way back to the mainline comes first
  ---@type {tile: integer, color: integer}[]
  local steps = {}
  local lookahead = slider_solver.settings.lookahead:get()
  local recovery = s.recovery_solution
  local base_state = state

  if recovery ~= nil and #recovery.sequence > 0 then
    if slider_solver.settings.show_recovery_moves:get() then
      for _, entry in ipairs(recovery.sequence) do
        steps[#steps + 1] = {
          tile = entry.post[SliderState.BLANK_TILE_INDEX],
          color = slider_solver.settings
              .color_recovery:get()
        }
      end
    else
      -- Recovery moves are hidden, so the mainline is drawn as seen from the last state that was on it
      base_state = s.last_mainline_state or state
    end
  end

  for move_index = mainline_index, #solution do
    if #steps >= lookahead then break end
    steps[#steps + 1] = {
      tile = solution[move_index].post[SliderState.BLANK_TILE_INDEX],
      color = slider_solver.settings
          .color_mainline:get()
    }
  end

  local last_size = 10
  local overlap_map = {}
  local blank = base_state[SliderState.BLANK_TILE_INDEX]
  local mode = slider_solver.settings.mode:get()

  for i = 0, math.min(lookahead, #steps) - 1 do
    local step = steps[i + 1]
    local clicked = step.tile

    if (slider_solver.settings.prevent_overlap:get()) then
      if (overlap_map[clicked]) then break end
      local passed = blank

      for _, m in ipairs(Move.split(clicked - blank)) do
        passed = passed + m
        overlap_map[passed] = true
      end
    end

    local size = 20 * (1 - i / lookahead)

    local ax, ay = centerOfTile(blank)
    local bx, by = centerOfTile(clicked)

    -- Connecting line from the previous marker to this one
    local dx, dy = bx - ax, by - ay
    local length = math.sqrt(dx * dx + dy * dy)
    local ux, uy = dx / length, dy / length

    local x1, y1 = ax + ux * last_size, ay + uy * last_size
    local x2, y2 = bx - ux * size, by - uy * size

    canvas:AddLine(x1, y1, x2, y2, 2, COLOR_CONTRAST)
    canvas:AddLine(x1, y1, x2, y2, 1, step.color)

    if mode ~= "mouse" and Move.isSmallStep(clicked - blank) then
      -- Normal arrows point towards the blank; inverted arrows point the other way.
      local direction = arrows_inverted and 1 or -1
      local arrow_x, arrow_y = direction * ux, direction * uy
      local shaft = size / 3
      local points = {
        { -size, -shaft },
        { 0,     -shaft },
        { 0,     -size },
        { size,  0 },
        { 0,     size },
        { 0,     shaft },
        { -size, shaft },
      }

      for _, point in ipairs(points) do
        local x, y = point[1], point[2]
        point[1] = bx + arrow_x * x - arrow_y * y
        point[2] = by + arrow_y * x + arrow_x * y
      end

      for _, stroke in ipairs({
        { width = STROKE + 2 * CONTRAST_BORDER, color = COLOR_CONTRAST,
          extension = (STROKE + 2 * CONTRAST_BORDER) / 4 + 0.5,
          corner_extension = (STROKE + 2 * CONTRAST_BORDER) / 4 + 0.25 },
        { width = STROKE, color = step.color, extension = STROKE / 4 + 0.25, corner_extension = STROKE / 8 },
      }) do
        for index, point in ipairs(points) do
          local next_index = index % #points + 1
          local next_point = points[next_index]
          local line_dx, line_dy = next_point[1] - point[1], next_point[2] - point[2]
          local line_length = math.sqrt(line_dx * line_dx + line_dy * line_dy)
          local unit_x, unit_y = line_dx / line_length, line_dy / line_length
          local start_extension = (index == 3 or index == 5) and stroke.corner_extension or stroke.extension
          local end_extension = (next_index == 3 or next_index == 5) and stroke.corner_extension or stroke.extension
          canvas:AddLine(point[1] - unit_x * start_extension, point[2] - unit_y * start_extension,
            next_point[1] + unit_x * end_extension, next_point[2] + unit_y * end_extension,
            stroke.width / 2, stroke.color)
        end
      end
    else
      local outer = size + CONTRAST_BORDER
      canvas:AddOutline(bx - outer, by - outer, outer * 2, outer * 2, STROKE + 2 * CONTRAST_BORDER, COLOR_CONTRAST)
      canvas:AddOutline(bx - size, by - size, size * 2, size * 2, STROKE, step.color)
    end

    last_size = size
    blank = clicked
  end
end

---Draws a horizontal progress bar with a contrast border.
---@param canvas ui.Canvas
---@param center_x number
---@param center_y number
---@param length number
---@param progress number Fraction between 0 and 1
---@param thickness number?
---@param contrast_border number?
---@param done_color integer?
---@param remaining_color integer?
local function drawProgressBar(canvas, center_x, center_y, length, progress, thickness, contrast_border, done_color,
                               remaining_color)
  thickness = thickness or 5
  contrast_border = contrast_border or 2
  done_color = done_color or 0x00FF00FF
  remaining_color = remaining_color or 0xFF0000FF

  local start_x = center_x - length // 2
  local end_x = start_x + length
  local mid_x = math.floor(start_x + math.max(0, math.min(1, progress)) * length + 0.5)

  canvas:AddLine(start_x - 2 * contrast_border, center_y, end_x + 2 * contrast_border, center_y,
    thickness + 2 * contrast_border, COLOR_CONTRAST)
  canvas:AddLine(start_x, center_y, mid_x, center_y, thickness, done_color)
  canvas:AddLine(mid_x, center_y, end_x, center_y, thickness, remaining_color)
end

---Draws centered text around a point.
---@param canvas ui.Canvas
---@param x number
---@param y number
---@param text string
---@param text_config ui.TextDataConfig
local function drawCenteredText(canvas, x, y, text, text_config)
  local estimated_width = config.Font.FromID(text_config.font):GetStringWidth(text)

  canvas:AddText(x - estimated_width // 2, y - 10, estimated_width, 20, text, text_config)
end


local CENTER_TEXT_CONFIG = ui.TextDataConfig.new()
CENTER_TEXT_CONFIG.alignHorizontal = ui.AlignMode.CENTRE
CENTER_TEXT_CONFIG.alignVertical = ui.AlignMode.CENTRE
CENTER_TEXT_CONFIG.font = id.Font.NOTOSANS_20
CENTER_TEXT_CONFIG.rgba = 0xFFFFFFFF
CENTER_TEXT_CONFIG.shadowRGBA = 0x000000FF
CENTER_TEXT_CONFIG.isShadowed = true

---Draws the progress of loading the slider tables.
---@param progress number Fraction between 0 and 1
function ActivePuzzle:drawLoadProgress(progress)
  local canvas = self.progress_canvas
  canvas:Clear()

  drawCenteredText(canvas, canvas.width // 2, canvas.height // 2 - 15, "Loading Data", CENTER_TEXT_CONFIG)

  drawProgressBar(canvas, canvas.width // 2, canvas.height // 2 + 25, 100, progress, 2, 1, 0x00FFFFFF, 0xFFFFFFFF)
end

---Draws the "Solving" text and a progress bar while the solver is searching.
---@param tick integer Ticks spent solving so far
---@param max_ticks integer
function ActivePuzzle:drawSolvingProgress(tick, max_ticks)
  local canvas = self.progress_canvas

  drawCenteredText(canvas, canvas.width // 2, canvas.height // 2 - 15, "Solving", CENTER_TEXT_CONFIG)

  drawProgressBar(canvas, canvas.width // 2, canvas.height // 2 + 25, 100, tick / max_ticks, 2, 1, 0x00FF00FF, 0xFF0000FF)
end

---Draws the progress bar, timers and speed statistics. Works in the "solving" and "executing" states.
---Does not clear the canvas, callers are responsible for that.
function ActivePuzzle:drawProgress()
  local s = self.state
  local canvas = self.progress_canvas

  local solving = s.state == "solving"
  local executing = s.state == "executing"
  if not solving and not executing then return end

  local solution_length = 250
  if executing then
    solution_length = #s.solution
  elseif s.solver.best_solution then
    solution_length = #s.solver.best_solution
  end

  local cx, cy = canvas.width // 2, 9
  local sx, sy = canvas.width // 2, canvas.height - 9

  -- Always Draw progress bar
  -- While lost, mainline_index is -1. Keep showing the progress of the last known mainline entry then
  local progress_index = executing and
      (s.mainline_index > 0 and s.mainline_index or s.recovery_solution.recovering_to_mainline_index) or 1
  local completed = executing and (progress_index - 1) or 0
  local progress = executing and (completed / solution_length) or 0
  local length = math.min(2 * solution_length, 250)
  drawProgressBar(canvas, cx, cy, length, progress, 2, 1)
  drawCenteredText(canvas, cx + length / 2 + 20, cy, tostring(solution_length), SMALL_TEXT_CONFIG)

  -- Always draw elapsed time
  drawCenteredText(canvas, cx - (length / 2 + 25), cy,
    string.format("%.1fs", (s.finished_tick or self.ticks) * TICK_SECONDS),
    SMALL_TEXT_CONFIG)

  -- Draw solution length if available
  if solution_length then
    drawCenteredText(canvas, cx + length / 2 + 20, cy, tostring(solution_length), SMALL_TEXT_CONFIG)
  end

  if s.finished_tick == nil then
    -- Draw current speed in moves/s
    local solving_time = (self.ticks - s.start_tick) * TICK_SECONDS
    local moves_per_second = solving_time > 0 and completed / solving_time or 0

    drawCenteredText(canvas, sx, sy, string.format("%.1f moves/s", moves_per_second), SMALL_TEXT_CONFIG)
  else
    -- Slider is done, draw total solving time and speed
    local total_time = s.finished_tick * TICK_SECONDS
    local solving_time = (s.finished_tick - s.start_tick) * TICK_SECONDS
    local moves_per_second = #s.solution / solving_time

    drawCenteredText(canvas, sx, sy, string.format("Done! %.1fs, %.1f moves/s", total_time, moves_per_second),
      SMALL_TEXT_CONFIG)

    if slider_solver.settings.estimate_slider_speed:get() then
      -- Estimate slider speed is a legacy option that calculates the corresponding slider speed setting in Alt1 Clue Solver
      -- that the user's speed would have achieved.

      local small_steps = 0
      for _, entry in ipairs(s.solution) do
        small_steps = small_steps + #Move.split(entry.move)
      end

      local partial_steps = small_steps - #s.solution
      local full_steps = small_steps - partial_steps
      local counted = partial_steps * 0.5 + full_steps

      local estimated_slider_speed = (solving_time - 0.5) / counted

      drawCenteredText(canvas, sx, sy - 20, string.format("Slider Speed %.3f", estimated_slider_speed), SMALL_TEXT_CONFIG)
    end
  end
end

---Stub: draws the overlay shown when no solution could be produced.
function ActivePuzzle:drawFailed()
  local canvas = self.progress_canvas
  canvas:Clear()

  local x = canvas.width // 2
  local y = canvas.height // 2

  drawCenteredText(canvas, x, y - 25, "Error", CENTER_TEXT_CONFIG)
  drawCenteredText(canvas, x, y + 5, self.state.reason, SMALL_TEXT_CONFIG)
end

---@return ct.sliders.ActiveSliderPuzzle
function ActivePuzzle.new()
  ---@class ct.sliders.ActiveSliderPuzzle
  local self = setmetatable({}, ActivePuzzle)

  self.lifetime = zyklib.disposable.DisposableGroup.new()

  -- Create the canvas for the solution overlay
  local puzzle_container = ui.Interfaces:GetComponent(id.Component.SLIDE_PUZZLE__PUZZLE_WRAPPER) --[[@as ui.ComponentCollection]]

  self.progress_canvas = ui.Canvas.new(puzzle_container)
  self.progress_canvas:SetSize(puzzle_container.width, puzzle_container.height)
  self.solution_canvas = ui.Canvas.new(puzzle_container)
  self.solution_canvas:SetSize(puzzle_container.width, puzzle_container.height)

  self.ticks = 0
  self.state = { state = "waitingforpdb", progress = pdb(), last_drawn_progress = nil }

  self.lifetime:add(slider_solver.settings.mode:observable():subscribe(function()
    if self.state.state == "waitingforpdb" then return end

    if self.solver then
      self.solver:dispose()
      self.solver = nil
    end
    self.solution_canvas:Clear()
    self.progress_canvas:Clear()
    self.state = { state = "waitingforpdb", progress = pdb(), last_drawn_progress = nil }
  end))

  self.lifetime:add(zyklib.game_events.native.Logic:subscribe(function() self:logictick() end))

  self:logictick()

  return self
end

---Reacts to a state that is not on the mainline. Either the player follows the current recovery sequence, or a move
---back to the mainline (or to the last known recovery state) is computed. If neither is possible, the player is lost.
---@private
---@param current ct.sliders.SliderState
function ActivePuzzle:recover(current)
  local s = self.state
  local recovery = s.recovery_solution
  local sequence = recovery.sequence

  local _, recovery_index = zyklib.array.find(sequence, function(entry)
    return zyklib.array.exists(entry.pre_states, function(pre) return SliderState.isEqual(pre, current) end)
  end)

  if recovery_index > 0 then
    -- Following the recovery. Prune it to the remaining steps
    recovery.sequence = { table.unpack(sequence, recovery_index) }
    recovery.last_known_state = current
    s.mainline_index = recovery.recovering_to_mainline_index
    return
  end

  -- The state is not part of the recovery sequence. Find a single move that gets back to a known state.
  local targets
  if recovery.last_known_state ~= nil then
    targets = { recovery.last_known_state }
  else
    local entry = s.solution[recovery.recovering_to_mainline_index]
    local last = s.solution[#s.solution]
    targets = entry and entry.pre_states or (last and { last.post } or {})
  end

  local recovery_move
  for _, target in ipairs(targets) do
    recovery_move = SliderState.findMove(current, target)
    if recovery_move ~= nil then break end
  end

  if recovery_move == nil then
    -- Lost track
    s.mainline_index = -1
    return
  end

  -- After the recovery move, the player is in the target state and continues the previous sequence from there.
  -- Entries are stored as clicked tiles since their first move may start from a partially completed state.
  local moves = { recovery_move }
  local blank = current[SliderState.BLANK_TILE_INDEX] + recovery_move

  for _, entry in ipairs(sequence) do
    local tile = entry.post[SliderState.BLANK_TILE_INDEX]
    moves[#moves + 1] = tile - blank
    blank = tile
  end

  if slider_solver.settings.mode:get() == "keyboard" then
    moves = Move.expand(moves)
  else
    moves = Move.compress(moves)
  end

  recovery.sequence = SliderState.augmentMoves(current, moves, slider_solver.settings.mode:get() ~= "keyboard")
  recovery.last_known_state = current
  s.mainline_index = recovery.recovering_to_mainline_index
end

function ActivePuzzle:logictick()
  self.ticks = self.ticks + 1

  local s = self.state

  if s.state == "waitingforpdb" then
    local loading = s.progress

    if loading.data:isSettled() then
      if loading.data:isRejected() then
        self.state = { state = "failed", reason = loading.data:getRejectionReason() }
        self:drawFailed()
        return
      end

      local graph = loading.data:get()

      local solver = PdbSolverTicked.new(SliderState.getSliderState(), graph,
        slider_solver.settings.mode:get() ~= "keyboard")
      solver:start()
      self.solver = solver
      self.state = { state = "solving", start_tick = self.ticks, solver = solver }
      self.progress_canvas:Clear()
    elseif s.last_drawn_progress ~= loading.progress then
      s.last_drawn_progress = loading.progress
      self:drawLoadProgress(loading.progress)
    end
  end

  -- We may have switched to the "solving" state, which we handle immediately
  if s.state == "solving" then
    local SOLVER_TICK_BUDGET = 512 -- How many states to process per tick

    local done = s.solver:tick(SOLVER_TICK_BUDGET)

    local max_ticks = slider_solver.settings.solve_time:get() / 20

    if done or self.ticks - s.start_tick >= max_ticks then
      -- Solving time is over, lock in the best solution found so far
      local current = SliderState.getSliderState()
      local best = s.solver.best_solution

      if best == nil then
        self.state = { state = "failed", reason = "No solution found" }
        self:drawFailed()
        return
      end

      s.solver:cancel()

      self.solution = SliderState.augmentMoves(current, best, slider_solver.settings.mode:get() ~= "keyboard")
      self.state = {
        state = "executing",
        start_tick = self.ticks,
        solution = self.solution,
        mainline_index = 1,
        last_mainline_state = current,
        recovery_solution = { sequence = {}, recovering_to_mainline_index = 1 },
      }
    else
      self.progress_canvas:Clear()
      self:drawSolvingProgress(self.ticks - s.start_tick, max_ticks)
      self:drawProgress()
    end
  end

  -- We may have switched to the "executing" state, which we handle immediately
  if s.state == "executing" then
    local current = SliderState.getSliderState()
    local arrows_inverted = var.VarPlayer.SLIDE_PUZZLE_KEYBOARD_INVERT.value ~= 0

    if SliderState.isSolved(current) and s.finished_tick == nil then
      s.finished_tick = self.ticks
    elseif not SliderState.isSolved(current) and s.finished_tick ~= nil then
      -- Left the solved state for some reason. Go back to showing overlay
      s.finished_tick = nil
    end

    local state_changed = s.last_drawn_state == nil or not SliderState.isEqual(s.last_drawn_state, current)

    if state_changed then
      local mainline_index

      if SliderState.isSolved(current) then
        mainline_index = #s.solution + 1
      else
        local _
        _, mainline_index = zyklib.array.findLast(s.solution, function(move)
          return zyklib.array.exists(move.pre_states, function(pre) return SliderState.isEqual(pre, current) end)
        end)
      end

      if mainline_index > 0 then
        s.mainline_index = mainline_index
        s.last_mainline_state = current
        s.recovery_solution = { sequence = {}, recovering_to_mainline_index = mainline_index }
      else
        self:recover(current)
      end


      if SliderState.isSolved(current) then
        if s.finished_tick == nil then s.finished_tick = self.ticks end

        self.solution_canvas:Clear()
      else
        s.finished_tick = nil
        self:drawSolution(current)
      end

      s.last_drawn_state = current
      s.last_drawn_arrows_inverted = arrows_inverted
    elseif s.last_drawn_arrows_inverted ~= arrows_inverted then
      if not SliderState.isSolved(current) then self:drawSolution(current) end
      s.last_drawn_arrows_inverted = arrows_inverted
    end

    -- Reduce number of progress redraws to match the clock accuracy
    if state_changed or self.ticks % 5 == 0 then
      self.progress_canvas:Clear()
      self:drawProgress()
    end
  end
end

function ActivePuzzle:dispose()
  self.lifetime:dispose()
  self.progress_canvas:Destroy()
  self.solution_canvas:Destroy()
  if self.solver then self.solver:dispose() end
  ActivePuzzle.instance = nil
end

---@type ct.sliders.ActiveSliderPuzzle?
ActivePuzzle.instance = nil

local interface_open_handler = zyklib.game_events.native.ServerLogic:map(function()
      local comp = ui.Interfaces:GetComponent(id.Component.SLIDE_PUZZLE__UNIVERSE)

      return comp ~= nil and comp.parent ~= nil
    end)
    :toObservable(false)
    :subscribeSuspended(function(is_open)
      if ActivePuzzle.instance ~= nil then
        ActivePuzzle.instance:dispose()
      end

      if is_open then
        ActivePuzzle.instance = ActivePuzzle.new()
      end
    end)

---Enables or disables the slider solver. Disabling also removes any currently shown overlay.
---@param active boolean
local function setActive(active)
  interface_open_handler:setActive(active)

  if not active and ActivePuzzle.instance ~= nil then
    ActivePuzzle.instance:dispose()
  end
end

local initialized = false

--- Activates the solver whenever it is enabled in the settings and deactivates it otherwise. Only the first call has an effect.
function slider_solver.init()
  if initialized then return end
  initialized = true

  slider_solver.settings.enabled:observable():subscribe(setActive, true)
end

return slider_solver
