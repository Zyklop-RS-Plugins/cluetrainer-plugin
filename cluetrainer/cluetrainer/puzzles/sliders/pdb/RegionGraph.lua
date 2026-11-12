-- RegionGraph.lua
local Region              = require("cluetrainer/puzzles/sliders/pdb/Region")


local array = require("zyklib/array")

---@class ct.sliders.pdb.RegionGraph.Node
---@field reflected boolean
---@field effective_region ct.sliders.pdb.Region
---@field table ct.sliders.pdb.RegionDistanceTable
---@field children ct.sliders.pdb.RegionGraph.Node[]

---@class ct.sliders.pdb.RegionGraph
---@field is_multitile boolean
---@field private nodes ct.sliders.pdb.RegionGraph.Node[]
---@field private entry_nodes ct.sliders.pdb.RegionGraph.Node[]
local RegionGraph = {}
RegionGraph.__index = RegionGraph

---@param databases ct.sliders.pdb.RegionDistanceTable[]
---@param include_reflected_nodes boolean
---@return ct.sliders.pdb.RegionGraph
function RegionGraph.new(databases, include_reflected_nodes)
  local self = setmetatable({
    is_multitile = databases[1].description.multitile,
  }, RegionGraph)

  local nodes = {}

  for _, tbl in ipairs(databases) do
    nodes[#nodes + 1] = {
      effective_region = tbl.description.region,
      table = tbl,
      reflected = false,
      children = {},
    }

    if include_reflected_nodes then
      local reflected = Region.reflect(tbl.description.region)

      if not array.exists(nodes, function(node)
            return Region.equals(node.effective_region, reflected)
          end) then
        nodes[#nodes + 1] = {
          effective_region = reflected,
          table = tbl,
          reflected = true,
          children = {},
        }
      end
    end
  end

  self.nodes = nodes

  for _, parent in ipairs(nodes) do
    for _, child in ipairs(nodes) do
      if parent ~= child
          and Region.isChild(parent.effective_region, child.effective_region)
      then
        parent.children[#parent.children + 1] = child
      end
    end
  end

  self.entry_nodes = array.filter(nodes, function(node)
    return Region.isFirst(node.effective_region)
  end)

  return self
end

---@return ct.sliders.pdb.RegionGraph.Node[]
function RegionGraph:getEntryPoints()
  return self.entry_nodes
end

return RegionGraph
