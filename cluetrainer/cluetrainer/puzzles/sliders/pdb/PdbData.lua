-- PdbData.lua
local RegionDistanceTable = require("cluetrainer/puzzles/sliders/pdb/PdbRegion")

local DATA = "cluetrainer/puzzles/sliders/pdb/data/"
local manifest = require(DATA .. "manifest")

--- Loads the slider tables that ship with the plugin (data/manifest.lua) from their part files. `step` loads one file,
--- so the caller can spread the loading over ticks and keep each tick far below the client's time limit.
---@class ct.sliders.pdb.PdbData
---@field tables ct.sliders.pdb.RegionDistanceTable[] usable once `step` returned true
---@field private files {name: string, length: integer, parts: string[]}[]
---@field private loaded integer
local PdbData = {}
PdbData.__index = PdbData

---@return ct.sliders.pdb.PdbData
function PdbData.new()
  local self = setmetatable({ tables = {}, files = {}, loaded = 0 }, PdbData)

  for t, entry in ipairs(manifest.tables) do
    local region = {}
    for i = 1, 25 do region[i] = tonumber(entry.region:sub(i, i)) end

    -- The table reads from `parts`, which `step` fills file by file
    local parts = {}
    local tbl = RegionDistanceTable.new({ multitile = manifest.multitile, region = region }, parts, manifest.part_size)
    self.tables[t] = tbl

    local characters = RegionDistanceTable.characters(tbl.indexing)
    for k = 1, (characters + manifest.part_size - 1) // manifest.part_size do
      self.files[#self.files + 1] = {
        name = string.format("%st%d_%02d", DATA, t, k),
        length = math.min(manifest.part_size, characters - (k - 1) * manifest.part_size),
        parts = parts,
      }
    end
  end

  return self
end

---Loads the next part file. Errors when a file is missing or has the wrong length.
---@return boolean done whether all files are loaded
function PdbData:step()
  local file = self.files[self.loaded + 1]
  if file == nil then return true end

  local result = require(file.name)
  local text = type(result) == "table" and result[1] or result
  if type(text) ~= "string" or #text ~= file.length then
    -- Level 0 leaves out the source position, so the reason stays short enough to show on the puzzle
    local got = type(text) == "string" and (#text .. " characters") or tostring(text)
    error(string.format("%s: %s, expected %d", file.name:match("[^/]+$"), got, file.length), 0)
  end

  file.parts[#file.parts + 1] = text
  self.loaded = self.loaded + 1
  return self.loaded == #self.files
end

---@return number fraction of the files loaded
function PdbData:progress()
  return self.loaded / #self.files
end

return PdbData
