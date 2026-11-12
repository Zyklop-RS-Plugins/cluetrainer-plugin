-- PdbRegion.lua
local AllowedMoveTable          = require("cluetrainer/puzzles/sliders/pdb/AllowedMoveTable")
local Indexing                  = require("cluetrainer/puzzles/sliders/pdb/RegionIndexing")

--- The distance of every state of one region to its goal, as built by tools/sliderpdb. Only the distance mod 3 is
--- stored: the solver compares a state with its neighbours, whose distances differ by at most 1, so mod 3 tells closer,
--- equal and further apart.
---@class ct.sliders.pdb.RegionDistanceTable
---@field description ct.sliders.pdb.RegionDescription
---@field indexing ct.sliders.pdb.RegionIndexing
---@field move_table ct.sliders.pdb.AllowedMoveTable
---@field modulus integer the stored distances are the real distances mod this
---@field private parts string[]
---@field private part_size integer
local RegionDistanceTable       = {}
RegionDistanceTable.__index     = RegionDistanceTable

--- One character holds 4 entries: the base-3 digits of (character - 0x21), skipping ']' so the data fits in a Lua long
--- string. DIGITS[byte * 4 + k] is entry k of that character, so a lookup is one table access.
local DIGITS                    = {}
for value = 0, 80 do
  local byte = 0x21 + value
  if byte >= 0x5D then byte = byte + 1 end
  local power = 1
  for k = 0, 3 do
    DIGITS[byte * 4 + k] = value // power % 3
    power = power * 3
  end
end

---@param description ct.sliders.pdb.RegionDescription
---@param parts string[] the table's characters, split into strings of `part_size` (the last may be shorter)
---@param part_size integer
---@return ct.sliders.pdb.RegionDistanceTable
function RegionDistanceTable.new(description, parts, part_size)
  local self = setmetatable({}, RegionDistanceTable)

  self.description = description
  self.indexing = Indexing.new(description.region)
  self.move_table = AllowedMoveTable.new(description)
  self.modulus = 3
  self.parts = parts
  self.part_size = part_size

  return self
end

---Number of characters the table needs, which is what its part files hold together.
---@param indexing ct.sliders.pdb.RegionIndexing
---@return integer
function RegionDistanceTable.characters(indexing)
  return (indexing.size + 3) // 4
end

function RegionDistanceTable:getDistance(state)
  return self:getDistanceByIndex(
    self.indexing:stateIndex(state)
  )
end

---@param index integer 0-based state index
---@return integer distance mod `modulus`
function RegionDistanceTable:getDistanceByIndex(index)
  local character = index // 4
  local part = self.parts[character // self.part_size + 1]
  return DIGITS[part:byte(character % self.part_size + 1) * 4 + index % 4]
end

return RegionDistanceTable
