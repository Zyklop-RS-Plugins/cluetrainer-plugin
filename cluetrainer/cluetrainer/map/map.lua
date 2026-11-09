local prettymap = require("prettymap")
local zyklib = require("zyklib")
local teleport_layer = require("cluetrainer/map/teleport_layer")
local WindowGeometry = require("cluetrainer/util/WindowGeometry")
local prettyui_workarounds = require("cluetrainer/util/prettyui_workarounds")

local luaflet = require("prettymap/luaflet")
local schema = require("cluetrainer/util/schema")
local storage = require("cluetrainer/util/storage")

-- Mirrors the PrettyUI panel chrome, which is not exposed.
local PANEL_BORDER = 8

-- Mirrors prettymap's internal zoom steps and world size, which are not exposed.
local ZOOM_LEVELS = { 1, 2, 4, 8, 16, 32, 64, 128, 256, 512 }
local MIN_ZOOM_INDEX = 4
local WORLD_WIDTH = 12800
local WORLD_HEIGHT = 12800
-- A panel over the top of the map never takes more than this part of the view when fitting bounds.
local MAX_TOP_INSET = 0.5
-- Room in tiles at every edge when fitting bounds, so a teleport icon at the edge of a small, zoomed-in fit is shown
-- whole and not under the floor control (bottom right). In tiles rather than pixels, so it barely changes large,
-- zoomed-out fits like a scan overview.
local EDGE_MARGIN_TILES = 4

local geometry = WindowGeometry.new("map_window_geometry", { size = true })

---@class ct.GameMap
---@field private shutdown_handler zyklib.reactive.EventHandler
---@field private teleport_layer cluetrainer.TeleportLayer
local GameMap = {}
GameMap.__index = GameMap

GameMap.settings = {
  visible = ctGlobal.persistence:profileVariable("map/visible", schema.bool({ default = false })),
}

---@type ct.GameMap?
local instance = nil

function GameMap.new()
  ---@class ct.GameMap
  local self = setmetatable({}, GameMap)
  self.visible = true

  self.window = prettyui.Panel.new(ui.Interfaces:GetComponent(id.Component.TOPLEVEL_V2__PLUGIN_BUILD_LAYER_BOTTOM), geometry:apply({
    x = -210,
    y = -150,
    xAnchor = 0.5,
    yAnchor = 0.5,
    width = 470,
    height = 400,
    minWidth = 320,
    minHeight = 220,
    resizable = true,
    scrollable = false,
  }))

  self.map = prettymap.Map.new(self.window.content, {
    x = 0,
    y = 0,
    width = self.window.contentWidth,
    height = self.window.content.height,
    showFloorControls = false,
    showZoomControls = false,
    showPlayerMarker = false,
    trackPlayer = false,

  })

  self.map:ZoomToMapSquare(CoordGrid.new(0, 46, 52, 32, 32))

  -- Panel has no resize callback, so hook SetSize, which the resize handle calls on every drag step.
  local panelSetSize = self.window.SetSize

  local game_map_self = self
  self.window.SetSize = function(self, width, height)
    panelSetSize(self, width, height)
    game_map_self.map:SetSize(
      self.root.width - PANEL_BORDER,
      self.root.height - PANEL_BORDER
    )
  end

  luaflet.twigs.GridTwig.new():AddTo(self.map.twigs)

  self.teleport_layer = teleport_layer.new()
  self.map:AddElement(self.teleport_layer)

  luaflet.twigs.prefab.FloorControlTwig.new({ anchor = "bottomright" }):AddTo(self.map.twigs)
  --luaflet.twigs.prefab.ZoomControlTwig.new({ anchor = "bottomright" }):AddTo(self.map.twigs)

  self.shutdown_handler = zyklib.lifecycle.shutdown_event:subscribe(function()
    self:close()
  end)

  return self
end

---Saves the geometry and destroys the map with its panel. The next `get` builds a new one.
function GameMap:close()
  geometry:save(self.window)

  self.shutdown_handler:cancel()
  self.teleport_layer:dispose()
  self.map:Destroy()
  self.window:Destroy()
  if instance == self then instance = nil end
end

---Shows or hides the map panel. The map and everything added to it stay alive while it is hidden.
---@param visible boolean
function GameMap:setVisible(visible)
  if visible == self.visible then return end
  self.visible = visible

  if visible then
    prettyui_workarounds.show(self.window)
  else
    geometry:save(self.window)
    prettyui_workarounds.hide(self.window)
  end
end

---@return boolean
function GameMap:isVisible()
  return self.visible
end

function GameMap:toggle()
  self:setVisible(not self.visible)
end

--- Zooms and centres the map on the bounds.
---@param bounds ct.Bounds
---@param top_inset number? Pixels at the top covered by a panel, kept clear of the bounds. Default 0.
function GameMap:fitBounds(bounds, top_inset)
  if top_inset and top_inset > 0 then
    local viewport_height = self.map.viewportHeight
    top_inset = math.min(top_inset, viewport_height * MAX_TOP_INSET)
    bounds = bounds:copy():extend({ north = top_inset / (viewport_height - top_inset) })
  end

  local rect = bounds:get()
  if rect == nil then return end

  local map = self.map
  local level = rect.level
  -- Bounds uses x/y tile coordinates, the map uses x/z
  local x1, z1 = rect.topleft.x, rect.topleft.y
  local x2, z2 = rect.botright.x, rect.botright.y
  local minX, maxX = math.min(x1, x2) - EDGE_MARGIN_TILES, math.max(x1, x2) + EDGE_MARGIN_TILES
  local minZ, maxZ = math.min(z1, z2) - EDGE_MARGIN_TILES, math.max(z1, z2) + EDGE_MARGIN_TILES

  local cx, cz = (minX + maxX) // 2, (minZ + maxZ) // 2
  local centre = CoordGrid.new(level, cx // 64, cz // 64, cx % 64, cz % 64)

  map:SetPlane(level)

  local targetScale = math.min(
    map.viewportWidth / (maxX - minX + 1),
    map.viewportHeight / (maxZ - minZ + 1)
  )
  local fitScale = math.min(
    map.viewportWidth / WORLD_WIDTH,
    map.viewportHeight / WORLD_HEIGHT
  )
  targetScale = math.max(
    fitScale * ZOOM_LEVELS[MIN_ZOOM_INDEX],
    math.min(fitScale * ZOOM_LEVELS[#ZOOM_LEVELS], targetScale)
  )
  local targetMultiplier = targetScale / fitScale

  local nearestIndex, nearestDistance = MIN_ZOOM_INDEX, math.huge
  for index = MIN_ZOOM_INDEX, #ZOOM_LEVELS do
    local distance = math.abs(ZOOM_LEVELS[index] - targetMultiplier)
    if distance < nearestDistance then
      nearestIndex, nearestDistance = index, distance
    end
  end

  map:_ApplyZoom(nearestIndex, nil, nil, targetScale)
  return map:CentreOn(centre)
end

--- Whether the tile lies in the visible part of the map, at its x/y on whichever plane the map shows.
---@param tile TileCoordinates
---@return boolean
function GameMap:shows(tile)
  local map = self.map
  local x, y = map:CoordToCanvas(tile, true)
  if x == nil then return false end
  local left, top = map.viewport.scrollX or 0, map.viewport.scrollY or 0
  return x >= left and x <= left + map.viewportWidth and y >= top and y <= top + map.viewportHeight
end

--- Ensures the map exists, then returns it.
---@return ct.GameMap
function GameMap.get()
  if not instance then
    instance = GameMap.new()
  end

  return instance
end

--- The map if it exists, without building one.
---@return ct.GameMap?
function GameMap.current()
  return instance
end

return GameMap
