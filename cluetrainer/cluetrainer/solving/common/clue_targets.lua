-- Finds the NPC or object a clue points to by its game config id, and the tiles around the clue spot.
-- Pure logic without client calls, so it runs in plain Lua.
local target_ids = require "cluetrainer/data/clue_target_ids"

---@class ct.ClueTarget
---@field ids table<integer, true> configID values
---@field parent_ids table<integer, true> parentConfigID values of multi NPCs

--- An inclusive tile rectangle. It has no level, so spots on bridge tiles (map plane 1 drawn at level 0) still match.
---@class ct.ClueTargetArea
---@field x1 integer
---@field y1 integer
---@field x2 integer
---@field y2 integer

local clue_targets = {}

--- Tiles around a talk-to spot, so NPCs that walk a little past their range still count.
clue_targets.TALKTO_MARGIN = 5

---@type table<integer, ct.ClueTarget|false>
local cache = {}

---@param list integer[]?
---@return table<integer, true>
local function to_set(list)
  local set = {}
  -- pairs, so a name the game does not know drops only that id, not the ids after it.
  for _, id in pairs(list or {}) do set[id] = true end
  return set
end

--- The ids of the NPC or object a clue points to, nil for a clue without known ids.
---@param clue_id integer
---@return ct.ClueTarget?
function clue_targets.for_clue(clue_id)
  if cache[clue_id] == nil then
    local entry = target_ids[clue_id]
    cache[clue_id] = entry ~= nil and { ids = to_set(entry.ids), parent_ids = to_set(entry.parent_ids) } or false
  end
  return cache[clue_id] or nil
end

--- Whether an NPCEntity or LocEntity uses one of the target's configs, directly or as the parent of a multi NPC.
---@param entity { configID: integer, parentConfigID: integer }
---@param target ct.ClueTarget
---@return boolean
function clue_targets.matches_id(entity, target)
  return target.ids[entity.configID] == true or target.parent_ids[entity.parentConfigID] == true
end

---@param x1 integer
---@param y1 integer
---@param x2 integer
---@param y2 integer
---@param margin integer
---@return ct.ClueTargetArea
local function area(x1, y1, x2, y2, margin)
  return {
    x1 = math.min(x1, x2) - margin,
    y1 = math.min(y1, y2) - margin,
    x2 = math.max(x1, x2) + margin,
    y2 = math.max(y1, y2) + margin,
  }
end

--- The search spot itself, without a margin: one tile further already holds a second object with the same id
--- at 10 of the 106 search spots, such as the next crate in a stack.
---@param spot TileRectangle
---@return ct.ClueTargetArea[]
function clue_targets.search_areas(spot)
  return { area(spot.topleft.x, spot.topleft.y, spot.botright.x, spot.botright.y, 0) }
end

---@param spots Solution.TalkToSpot[]
---@return ct.ClueTargetArea[]
function clue_targets.talkto_areas(spots)
  local areas = {}
  for _, spot in ipairs(spots) do
    local origin, size = spot.range.origin, spot.range.size or { x = 1, y = 1 }
    areas[#areas + 1] = area(origin.x, origin.y, origin.x + size.x - 1, origin.y + size.y - 1,
      clue_targets.TALKTO_MARGIN)
  end
  return areas
end

--- Whether a tile lies in any of the areas, on any level.
---@param coord { x: integer, z: integer } A CoordGrid; its z is the tile y.
---@param areas ct.ClueTargetArea[]
---@return boolean
function clue_targets.in_areas(coord, areas)
  local x, y = coord.x, coord.z
  for _, a in ipairs(areas) do
    if x >= a.x1 and x <= a.x2 and y >= a.y1 and y <= a.y2 then return true end
  end
  return false
end

--- Whether an object stands on one of the areas. Its footprint counts, not one tile, and the area grows by the
--- object's size minus one, so it matches whichever footprint tile the client reports as coordGrid.
---@param loc { coordGrid: { x: integer, z: integer }, width: integer, length: integer }
---@param areas ct.ClueTargetArea[]
---@return boolean
function clue_targets.loc_in_areas(loc, areas)
  local x, y = loc.coordGrid.x, loc.coordGrid.z
  local dx, dy = loc.width - 1, loc.length - 1
  for _, a in ipairs(areas) do
    if x >= a.x1 - dx and x <= a.x2 + dx and y >= a.y1 - dy and y <= a.y2 + dy then return true end
  end
  return false
end

--- Centre tile and range of a distance query that contains the whole area plus a margin, to narrow LocList and
--- NPCList filters. The range is the half width plus the half height, so it covers the corners whichever distance
--- the client uses.
---@param a ct.ClueTargetArea
---@param margin integer? Extra tiles around the area, default 0
---@return { x: integer, y: integer, range: integer }
function clue_targets.query_around(a, margin)
  margin = margin or 0
  local half_w, half_h = math.ceil((a.x2 - a.x1) / 2), math.ceil((a.y2 - a.y1) / 2)
  return { x = a.x1 + half_w, y = a.y1 + half_h, range = half_w + half_h + 2 * margin }
end

return clue_targets
