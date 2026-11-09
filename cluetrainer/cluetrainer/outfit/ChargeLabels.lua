-- ChargeLabels.lua
local zyklib = require "zyklib"
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

---@param piece ct.outfit.OutfitPiece
---@return boolean
local function isShown(piece)
  if not ChargeLabels.settings.enabled:get() then return false end
  return not piece.optional or ChargeLabels.settings.boots:get()
end

local FONT = id.Font.MUSEO_SANS_13PT_REGULAR
local COLOUR = 0xFFFFFFFF
local EMPTY_COLOUR = 0xFF5959FF

---@type table<ct.outfit.OutfitPiece, ui.Text>
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

  ---@type table<ct.outfit.OutfitPiece, ui.Component>
  local sprites = {}
  if layer ~= nil then
    layer:IterateDynamicComponents(function(component)
      for _, piece in ipairs(OutfitCharges.pieces) do
        if piece.obj_ids[component.associatedObjectID] then sprites[piece] = component end
      end
      return false
    end)
  end

  for _, piece in ipairs(OutfitCharges.pieces) do
    local sprite = isShown(piece) and sprites[piece] or nil
    local label = labels[piece]

    if sprite == nil then
      if exists(label) then label.hidden = true end
    else
      if not exists(label) then
        label = createLabel(layer --[[@as ui.ComponentCollection]])
        labels[piece] = label
      end

      local charges = piece.charges:get()
      label:SetPos(sprite.x, sprite.y)
      label:SetSize(sprite.width, sprite.height)
      label.content = tostring(charges)
      label.rgba = charges == 0 and EMPTY_COLOUR or COLOUR
      label.hidden = false
    end
  end
end

local initialized = false

--- Starts showing the labels. Only the first call has an effect.
function ChargeLabels.init()
  if initialized then return end
  initialized = true

  OutfitCharges.init()
  zyklib.game_events.native.ServerLogic:subscribe(sync)
end

return ChargeLabels
