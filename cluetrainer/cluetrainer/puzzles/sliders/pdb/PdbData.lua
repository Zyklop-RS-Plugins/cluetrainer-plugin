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

  local text = require(file.name)
  if type(text) ~= "string" or #text ~= file.length then
    error(string.format("%s holds %s characters instead of %d", file.name,
      type(text) == "string" and #text or type(text), file.length))
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
