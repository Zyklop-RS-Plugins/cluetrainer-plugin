local tilecoordinates       = require("cluetrainer/math/math").tilecoordinates
local path_shapes           = require "cluetrainer/solving/common/path_shapes"
local TileArea              = require("cluetrainer/math/math").tilearea
local map                   = require "cluetrainer/map/map"
local TalkSolutionNpcEntity = require "cluetrainer/map/elements/TalkSolutionNpcEntity"
local SearchSolutionEntity  = require "cluetrainer/map/elements/SearchSolutionEntity"
local DigSolutionEntity     = require "cluetrainer/map/elements/DigSolutionEntity"
local InteractionMarker     = require "cluetrainer/map/elements/InteractionMarker"
local Bounds                = require "cluetrainer/util/Bounds"
local Path                  = require "cluetrainer/model/path"
local AbstractClueSolver    = require "cluetrainer/solving/AbstractClueSolver"
local Navigator             = require "cluetrainer/solving/common/Navigator"
local MapSectionControl     = require "cluetrainer/solving/common/MapSectionControl"
local luaflet               = require "prettymap/luaflet"
local PathStepEntity        = require "cluetrainer/map/elements/PathStepElement"
local RichText              = require "cluetrainer/util/RichText"
local zyklib                = require "zyklib"
local MutableMesh           = require "zyklib/MutableMesh"
local ClueStateAction       = require "cluetrainer/solving/cluestateinterface/ClueStateAction"
local TeleportAction        = require "cluetrainer/solving/cluestateinterface/TeleportAction"
local clues                 = require "cluetrainer/model/clues"

---@param step Step
local function create_step_highlights(step)
  local cube = MutableMesh.new()
      :add(MutableMesh.cube():faces_only():recolor(0xFFFFFF80))
      :add(MutableMesh.cube():lines_only():recolor(0xFFFFFFFF))
      :shapeData()

  ---@param config ct.ConfigId.Npc | ct.ConfigId.Loc
  ---@param coordinates TileCoordinates?
  local function highlight_config(config, coordinates)
    if config.domain == "npc" then
      local npc_id = id.NPC[config.name]
      return zyklib.highlights.NpcHighlight.new(function(npc) return npc.configID == npc_id end,
        function(npc)
          return {
            shapeData = cube,
            translation = npc.aabb:GetCorner(BoxCornerType.LEFT_BOTTOM_NEAR) - Vector3.new(0.1) * npc.aabb
                .dimensions,
            scale = Vector3.new(1.2) * npc.aabb.dimensions,
            colour = 0xFFFF00A0
          }
        end
      )
    else
      return path_shapes.locHighlight({
        coordGrid = coordinates and
            tilecoordinates.toCoordGrid({ x = coordinates.x, y = coordinates.y, level = coordinates.level }),
        range = 2,
        configID = id.Loc[config.name]
      })
    end
  end

  ---@type zyklib.TerrainHighlight[]
  local highlights = {}

  local solution = clues.getSolution(step)

  if solution ~= nil then
    if solution.type == "dig" then
      --[[@as TileCoordinates]] -- LuaCats does not narrow the type of step.solution to DigSolution, so we need to cast this
      local spot = solution.spot

      table.insert(highlights, path_shapes.digHighlight(spot))
    elseif solution.type == "talkto" then
      for _, npc_config in pairs(solution.npc_configs) do
        table.insert(highlights, highlight_config(npc_config))
      end
    elseif solution.type == "search" then
      -- LuaCats does not narrow the type of step.solution to SearchSolution, so we need to cast the following
      local spot = solution.spot --[[@as TileRectangle]]

      for _, value in pairs(solution.entity_configs or {}) do
        table.insert(highlights, highlight_config(value, { x = spot.topleft.x, y = spot.botright.y, level = spot.level }))
      end
    end
  end

  if step.type == "skilling" then
    for _, config in pairs(step.relevant_configs or {}) do
      table.insert(highlights, highlight_config(config))
    end
  end

  return zyklib.highlights.HighlightGroup.new(highlights)
end

---Construct the map elements that are relevant for the given step
---@param step Step
---@return prettymap.luaflet.Twig
local function create_step_map_layer(step)
  local layer = luaflet.twigs.Twig.new()

  local solution = clues.getSolution(step)

  if solution ~= nil then
    if solution.type == "talkto" then
      TalkSolutionNpcEntity.new(solution.npc, solution.spots[1]):AddTo(layer)
    elseif solution.type == "search" then
      SearchSolutionEntity.new(solution --[[@as Solution.Search]]):AddTo(layer)
    elseif solution.type == "dig" then
      DigSolutionEntity.new(solution --[[@as Solution.Dig]]):AddTo(layer)
    end
  end

  if step.type == "skilling" then
    InteractionMarker.new({
      coordinate = require("cluetrainer/map/elements/geometry").coord(TileArea.ensure_mutable(step.areas[1])
        :center()),
      cursor = step.cursor
    })
  end

  return layer

  -- Implementation for creating a map layer for the given step
end

---@param step Step
---@return ct.Bounds
local function clue_map_bounds(step)
  local bounds = Bounds.new()

  -- Skilling clues have no solution, only an area, so `sol` can be nil.
  local sol = clues.getSolution(step)

  if sol == nil then
    -- Only the skilling area below.
  elseif sol.type == "talkto" then
    local spot = sol.spots[1]

    bounds:addArea(spot.range)
  elseif sol.type == "dig" then
    bounds:addTile(sol.spot)
  elseif sol.type == "search" then
    bounds:addRectangle(sol.spot)
  end

  if step.type == "skilling" then
    bounds:addRectangle(TileArea.toRect(step.areas[1]))
  end

  return bounds
end

--- The skilling answer with the ingredients it uses up, such as "Craft a black dragonhide body. (3× Black dragon
--- leather + Thread)", so the player knows what to bring.
---@param clue Skilling
---@return string
local function skilling_text(clue)
  if not clue.ingredients or #clue.ingredients == 0 then return clue.answer end
  local parts = {}
  for i, ingredient in ipairs(clue.ingredients) do
    local amount = ingredient.amount or 1
    parts[i] = (amount > 1 and (amount .. "× ") or "") .. ingredient.name
  end
  return clue.answer .. " (" .. table.concat(parts, " + ") .. ")"
end

---@param method Method.GenericPath
---@return Path.Step[]
local function stitch_path(method)
  local all = zyklib.array.filter({ method.pre_path, method.main_path }, function(step) return step ~= nil end)
  return zyklib.array.flatten(all)
end

---@class ct.SimpleClueActions
---@field teleport ct.solving.TeleportAction
---@field talk? ct.interfaces.cluestate.ClueStateAction
---@field dig? ct.interfaces.cluestate.ClueStateAction
---@field obtain_key? ct.interfaces.cluestate.ClueStateAction
---@field search? ct.interfaces.cluestate.ClueStateAction
---@field skill? ct.interfaces.cluestate.ClueStateAction
---@field defeat_wizard? ct.interfaces.cluestate.ClueStateAction
---@field enter_challenge_scroll_answer? ct.interfaces.cluestate.ClueStateAction
---@field solve_slider? ct.interfaces.cluestate.ClueStateAction
---@field solve_celtic_knot? ct.interfaces.cluestate.ClueStateAction
---@field solve_lockbox? ct.interfaces.cluestate.ClueStateAction
---@field solve_towers? ct.interfaces.cluestate.ClueStateAction

--- An ActiveSimpleClue manages a single simple clue currently in progress.
---@class ct.ActiveSimpleClue : ct.AbstractClueSolver
---@field private navigator Navigator?
---@field private map_navigator ct.MapSectionControl?
---@field private path_twig prettymap.luaflet.Twig?
---@field private clue_state ct.ClueStateInterface
---@field private method Method.GenericPath?
---@field actions ct.SimpleClueActions
local SimpleClueSolver = setmetatable({}, { __index = AbstractClueSolver })
SimpleClueSolver.__index = SimpleClueSolver

---@param clue Step
---@param clue_state ct.ClueStateInterface
---@return ct.ActiveSimpleClue
function SimpleClueSolver.new(clue, clue_state)
  return AbstractClueSolver.create(SimpleClueSolver, clue, clue_state)
end

---Builds the solver; see `AbstractClueSolver.create`, which disposes it should this fail.
---@private
---@param clue Step
---@param clue_state ct.ClueStateInterface
function SimpleClueSolver:init(clue, clue_state)
  ---@cast self ct.ActiveSimpleClue
  self.clue_state = clue_state

  self.disposable_group:add(create_step_highlights(clue):activate())
  self.disposable_group:add(create_step_map_layer(clue):AddTo(map.get().map.twigs))

  self.actions = { teleport = TeleportAction.new(nil) }

  self.disposable_group:add(clue_state.method_selected:subscribe(function(selected)
    self:setMethod(selected and selected.method --[[@as Method.GenericPath?]])
  end))
  clue_state:setClueSpot({ clue = clue })

  if not self.method then
    local bounds = clue_map_bounds(clue)
    --- Only fit to the basic clue target bounds if there is no method available initially
    map.get():fitBounds(bounds)
  end
end

function SimpleClueSolver:buildActions()
  local clue = self.clue
  local state_panel = self.clue_state
  state_panel:clearActions()
  if self.method then state_panel:addAction(self.actions.teleport) end
  local sol = clues.getSolution(clue)

  if sol then
    if sol.type == "talkto" then
      self.actions.talk = state_panel:addAction(ClueStateAction.Text.new("Talk to " .. RichText.npc(sol.npc)))
    elseif sol.type == "dig" then
      self.actions.dig = state_panel:addAction(ClueStateAction.Text.new("Dig " .. (sol.description or "at target")))
    elseif sol.type == "search" then
      if sol.key and var.VarPlayer.TRAIL17_MEDIUM_KEY_SKIP_OWNED.value == 0 then
        self.actions.obtain_key = state_panel:addAction(ClueStateAction.Text.new("Obtain key"))
      end

      self.actions.search = state_panel:addAction(ClueStateAction.Text.new("Search " .. RichText.loc(sol.entity)))
    end
  end

  if clue.type == "skilling" then
    ---@cast clue Skilling
    self.actions.skill = state_panel:addAction(ClueStateAction.Text.new(skilling_text(clue)))
  end

  local challenges = clue.challenge

  if challenges ~= nil and #challenges > 0 then
    for _, challenge in ipairs(challenges) do
      if challenge.type == "wizard" then
        self.actions.defeat_wizard = state_panel:addAction(ClueStateAction.Text.new("Defeat wizard "))

        self.actions.defeat_wizard:setState("complete")
      elseif challenge.type == "slider" then
        self.actions.solve_slider = state_panel:addAction(ClueStateAction.Text.new("Complete slider challenge"))
      elseif challenge.type == "celticknot" then
        self.actions.solve_celtic_knot = state_panel:addAction(ClueStateAction.Text.new("Solve Celtic knot challenge"))
      elseif challenge.type == "lockbox" then
        self.actions.solve_lockbox = state_panel:addAction(ClueStateAction.Text.new("Solve lockbox challenge"))
      elseif challenge.type == "towers" then
        self.actions.solve_towers = state_panel:addAction(ClueStateAction.Text.new("Solve towers challenge"))
      elseif challenge.type == "challengescroll" then
        self.actions.enter_challenge_scroll_answer = state_panel:addAction(ClueStateAction.Text.new("Enter answer " ..
          challenge.answers[1]
          .answer)) -- TODO: Automatically determine correct answer
      end
    end
  end
end

---@param method Method.GenericPath?
function SimpleClueSolver:setMethod(method)
  self.method = method
  if method then
    self:setPath(stitch_path(method))
  else
    self:setPath(nil)
  end
  self:buildActions()
end

---@param path Path.Raw?
function SimpleClueSolver:setPath(path)
  if self.navigator ~= nil then
    self.navigator:dispose()
    self.navigator = nil
  end

  if self.map_navigator ~= nil then
    self.map_navigator:dispose()
    self.map_navigator = nil
  end

  if self.path_twig ~= nil then
    self.path_twig:Detach()
    self.path_twig = nil
  end

  if path ~= nil then
    self.navigator = Navigator.new(function(teleport)
      self.actions.teleport:setTeleport(teleport)
    end)
    self.navigator:set(path)

    local sectioned_path = Path.split_into_sections(path)
    local steps = zyklib.array.flatMap(sectioned_path, function(section) return section.steps end)
    self.path_twig = PathStepEntity.route(steps):AddTo(map.get().map.twigs)

    self.map_navigator = MapSectionControl.new(map.get(),
      zyklib.array.map(sectioned_path, function(sec) return { name = sec.name, bounds = Path.bounds(sec.steps) } end))
  end
end

function SimpleClueSolver:dispose()
  self:setPath(nil)
  AbstractClueSolver.dispose(self)
end

return SimpleClueSolver
