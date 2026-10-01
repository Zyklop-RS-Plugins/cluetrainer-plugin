local function main()
  local orchestrator   = require("cluetrainer/solving/orchestrator")
  local towers_solver  = require("cluetrainer/puzzles/towers/TowerSolver")
  local lockbox_solver = require("cluetrainer/puzzles/lockbox/LockboxSolver")
  local knot_solver    = require("cluetrainer/puzzles/knots/KnotSolver")
  local buffs          = require("cluetrainer/buffs/Buffs")
  local NpcHighlight   = require("zyklib/highlights/NpcHighlight")
  local MutableMesh    = require("zyklib/MutableMesh")
  local api_util       = require("zyklib/api_util")
  local LocHighlight   = require("zyklib/highlights/LocHighlight")
  local zyklib         = require("zyklib/init")
  local ClueProgress   = require("cluetrainer/ClueProgress")
  local lua_util       = require("zyklib/lua_util")

  -- towers_solver:init()
  -- lockbox_solver:init()
  -- knot_solver:init()
  -- orchestrator.init()

  buffs:init()

  local shape = MutableMesh.cube():shapeData()


  zyklib.ewent.Native.VarTransmit:subscribe(function(e)
    log(e.var.configName .. " changed from " .. tostring(e.oldValue) .. " to " .. tostring(e.newValue))
  end)

  -- map:ZoomToMapSquare(CoordGrid.new(0, 49, 54, 29, 31))



  -- zyklib.ewent.Native.MiniMenuEntrySelected:subscribe(function(event)
  --   log(zyklib.api_util.to_plain_table(event))

  --   if event.entry.componentData ~= nil then
  --     if event.entry.componentData.component.spriteID ~= nil then
  --       log(zyklib.api_util.to_plain_table(id.Sprite.FromID(event.entry.componentData.component.spriteID)))
  --     end
  --   end
  -- end)

  -- zyklib.ewent.Native.EntityDraw:subscribe(function(event)
  --   return not (event.entityType == EntityType.NPC)
  -- end)

  -- NpcHighlight.new(function(npc)
  --         return true
  --     end,
  --     function(npc)
  --         return {
  --             shapeData = shape,
  --             translation = npc.aabb:GetCorner(BoxCornerType.LEFT_BOTTOM_NEAR),
  --             scale = npc.aabb.dimensions,
  --             colour = 0xFF00FF80
  --         }
  --     end):activate()

  -- zyklib.ewent.Native.LocAdded:subscribe(function(event)
  --     log(event.config.configName)
  -- end)

  -- LocHighlight.new({
  --         name = "*ree*"
  --     },
  --     function(loc)
  --         return {
  --             shapeData = shape,
  --             translation = loc.position,
  --             scale = Vector3.new(512, 512, 512),
  --             colour = 0xFF00FF80
  --         }
  --     end):activate()

  log("clue trainer loaded")
end

return {
  main = main
}
