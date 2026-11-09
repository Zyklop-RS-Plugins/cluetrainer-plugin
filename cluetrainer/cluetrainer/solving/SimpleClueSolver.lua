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
local clue_targets          = require "cluetrainer/solving/common/clue_targets"
local clues                 = require "cluetrainer/model/clues"

---comment
---@param step Step
local function create_step_highlights(step)
  local cube = MutableMesh.new()
      :add(MutableMesh.cube():faces_only():recolor(0xFFFFFF80))
      :add(MutableMesh.cube():lines_only():recolor(0xFFFFFFFF))
      :shapeData()

  ---@type zyklib.TerrainHighlight[]
  local highlights = {}

  local solution = clues.getSolution(step)

  if solution ~= nil then
    if solution.type == "dig" then
      local spot = solution
          .spot --[[@as TileCoordinates]] -- LuaCats does not narrow the type of step.solution to DigSolution, so we need to cast this

      table.insert(highlights, path_shapes.digHighlight(spot))
    elseif solution.type == "talkto" then
      local target = clue_targets.for_clue(step.id)
      local areas = clue_targets.talkto_areas(solution.spots)

      -- By id only near the spots: some ids are used at more places, such as Hazelmere's in White Knights' Castle.
      if target then
        table.insert(highlights, zyklib.highlights.NpcHighlight.new(function(npc)
            return clue_targets.matches_id(npc, target) and clue_targets.in_areas(npc.coordGrid, areas)
          end,
          function(npc)
            return {
              shapeData = cube,
              translation = npc.aabb:GetCorner(BoxCornerType.LEFT_BOTTOM_NEAR) - Vector3.new(0.1) * npc.aabb.dimensions,
              scale = Vector3.new(1.2) * npc.aabb.dimensions,
              colour = 0xFFFF00A0
            }
          end
        ))
      end
    elseif solution.type == "search" then
      local spot = solution
          .spot --[[@as TileRectangle]] -- LuaCats does not narrow the type of step.solution to SearchSolution, so we need to cast this

      local LOC_SCALE = 2

      local target = clue_targets.for_clue(step.id)
      local areas = clue_targets.search_areas(spot)
      -- 1 extra tile, so objects of 2 by 2 tiles that only partly cover the spot are in the query.
      local around = clue_targets.query_around(areas[1], 1)

      -- By id only on the spot: object ids are shared by every copy of that object, such as all crates of one kind.
      if target then
        table.insert(highlights, zyklib.highlights.LocHighlight.new({
            coordGrid = tilecoordinates.toCoordGrid({ x = around.x, y = around.y, level = spot.level }),
            range = around.range,
            func = function(loc)
              return clue_targets.matches_id(loc, target) and clue_targets.loc_in_areas(loc, areas)
            end
          },
          function(loc)
            -- Width and length at most the object's own tiles (512 units each), so an object placed diagonally,
            -- such as the crates of clues 84, 153 and 158, isn't drawn larger than the same object placed straight.
            local d = loc.aabb.dimensions
            local size = Vector3.new(math.min(d.x, loc.width * 512), d.y, math.min(d.z, loc.length * 512))
            return {
              shapeData = cube,
              translation = loc.aabb.centre - Vector3.new(LOC_SCALE / 2) * size,
              scale = Vector3.new(LOC_SCALE) * size,
              colour = 0x00FFFFA0
            }
          end
        ))
      end
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
  ---@class ct.ActiveSimpleClue
  local self = setmetatable(AbstractClueSolver.new(clue), SimpleClueSolver)
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

  return self
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
