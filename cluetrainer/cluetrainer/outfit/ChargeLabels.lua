-- ChargeLabels.lua
local schema = require "cluetrainer/util/schema"
local OutfitCharges = require "cluetrainer/outfit/OutfitCharges"

--- Shows the stored charges in the bottom right corner of the Globetrotter pieces in the worn equipment interface.
---@class ct.outfit.ChargeLabels
local ChargeLabels = {}

ChargeLabels.settings = {
  enabled = ctGlobal.persistence:profileVariable("outfit_charges/enabled", schema.bool({ default = true })),
  -- Off by default: the boots' charges are of little use as long as their ability stays as it is.
  boots = ctGlobal.persistence:profileVariable("outfit_charges/boots", schema.bool({ default = false })),
}

---@class ct.outfit.ChargeLabels.Entry
---@field piece ct.outfit.OutfitPiece
---@field optional boolean Whether the piece's charges are only shown when asked for

--- The pieces that get a label.
---@type ct.outfit.ChargeLabels.Entry[]
local ENTRIES = {
  { piece = OutfitCharges.pieces.jacket,   optional = false },
  { piece = OutfitCharges.pieces.backpack, optional = false },
  { piece = OutfitCharges.pieces.boots,    optional = true },
}

---@param entry ct.outfit.ChargeLabels.Entry
---@return boolean
local function isShown(entry)
  if not ChargeLabels.settings.enabled:get() then return false end
  return not entry.optional or ChargeLabels.settings.boots:get()
end

local FONT = id.Font.MUSEO_SANS_13PT_REGULAR
local COLOUR = 0xFFFFFFFF
local EMPTY_COLOUR = 0xFF5959FF

---@type table<ct.outfit.ChargeLabels.Entry, ui.Text>
local labels = {}

---@param label ui.Text?
---@return boolean # Whether the label still exists in the interface
local function exists(label)
  if label == nil then return false end
  local ok, parent = pcall(function() return label.parent end)
  return ok and parent ~= nil
end

---@param layer ui.ComponentCollection
---@return ui.Text
local function createLabel(layer)
  local label = ui.Text.new(layer)
  label.font = FONT
  label.alignHorizontal = ui.AlignMode.BOTTOMRIGHT
  label.alignVertical = ui.AlignMode.BOTTOMRIGHT
  label.isShadowed = true
  return label
end

--- Finds the worn piece sprites and puts a label on each, sized to the sprite so it follows any layout.
local function sync()
  local layer = ui.Interfaces:GetComponent(id.Component.TOPLEVEL_V2_WORN__ITEM_LAYER) --[[@as ui.ComponentCollection?]]

  ---@type table<ct.outfit.ChargeLabels.Entry, ui.Component>
  local sprites = {}
  if layer ~= nil then
    layer:IterateDynamicComponents(function(component)
      for _, entry in ipairs(ENTRIES) do
        if entry.piece.obj_ids[component.associatedObjectID] then sprites[entry] = component end
      end
      return false
    end)
  end

  for _, entry in ipairs(ENTRIES) do
    local sprite = isShown(entry) and sprites[entry] or nil
    local label = labels[entry]

    if sprite == nil then
      if exists(label) then label.hidden = true end
    else
      if not exists(label) then
        label = createLabel(layer --[[@as ui.ComponentCollection]])
        labels[entry] = label
      end

      local charges = entry.piece.charges:get()
      label:SetPos(sprite.x, sprite.y)
      label:SetSize(sprite.width, sprite.height)
      label.content = tostring(charges)
      label.rgba = charges == 0 and EMPTY_COLOUR or COLOUR
      label.hidden = false
    end
  end
end

local function hideAll()
  for _, label in pairs(labels) do
    if exists(label) then label.hidden = true end
  end
end

local initialized = false

--- Starts showing the labels. Only the first call has an effect. While the labels are disabled, nothing runs.
function ChargeLabels.init()
  if initialized then return end
  initialized = true

  local sync_handler = zyklib.game_events.native.ServerLogic:subscribeSuspended(sync)

  -- Observing a piece's charges keeps them up to date: OutfitCharges only listens to the server while they are observed.
  ---@type table<ct.outfit.ChargeLabels.Entry, zyklib.reactive.EventHandler>
  local charge_handlers = {}
  for _, entry in ipairs(ENTRIES) do
    charge_handlers[entry] = entry.piece.charges:subscribeSuspended(function() end)
  end

  local function update()
    local enabled = ChargeLabels.settings.enabled:get()

    for entry, handler in pairs(charge_handlers) do
      handler:setActive(isShown(entry))
    end
    sync_handler:setActive(enabled)

    if not enabled then hideAll() end
  end

  ChargeLabels.settings.enabled:observable():subscribe(update)
  ChargeLabels.settings.boots:observable():subscribe(update)
  update()
end

return ChargeLabels
