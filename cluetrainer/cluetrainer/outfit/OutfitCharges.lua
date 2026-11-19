-- OutfitCharges.lua
local zyklib = require "zyklib"

---@class ct.outfit.OutfitPiece
---@field name string Item name of the piece
---@field obj_ids table<integer, true> Object ids of all upgrade tiers of the piece
---@field optional boolean Whether the piece's charges are only shown when asked for
---@field charges_var string Name of the variable holding the piece's stored charges
---@field charges zyklib.reactive.Observable<integer> Charges currently stored in the piece

--- Charges of the Globetrotter outfit pieces that can store outfit ability charges.
---@class ct.outfit.OutfitCharges
local OutfitCharges = {}

---@param name string
---@param obj_prefix string Prefix of the piece's object names, followed by TIER0 to TIER3
---@param charges_var string
---@param optional boolean?
---@return ct.outfit.OutfitPiece
local function piece(name, obj_prefix, charges_var, optional)
  ---@type table<integer, true>
  local obj_ids = {}
  for tier = 0, 3 do
    obj_ids[id.Obj[obj_prefix .. tier]] = true
  end

  return {
    name = name,
    obj_ids = obj_ids,
    optional = optional == true,
    charges_var = charges_var,
    charges = zyklib.reactive.Observable.new(var.VarPlayer[charges_var].value),
  }
end

---@type ct.outfit.OutfitPiece[]
OutfitCharges.pieces = {
  piece("Globetrotter jacket", "TRAIL17_TORSO_TIER", "TRAIL_OUTFIT_TORSO_CHARGES"),
  piece("Globetrotter backpack", "TRAIL17_CAPE_TIER", "TRAIL_OUTFIT_CAPE_CHARGES"),
  piece("Globetrotter boots", "TRAIL17_BOOTS_TIER", "TRAIL_OUTFIT_BOOTS_CHARGES", true),
}

--- The base variables of the charge varbits, which the server transmits on every change.
---@type table<integer, true>
local base_variable_ids = {}
for _, p in ipairs(OutfitCharges.pieces) do
  base_variable_ids[var.VarPlayer[p.charges_var].baseVar.id] = true
end

local initialized = false

--- Starts tracking the charges. Only the first call has an effect.
function OutfitCharges.init()
  if initialized then return end
  initialized = true

  zyklib.game_events.native.VarTransmit
      :filter(function(event) return base_variable_ids[event.var.id] ~= nil end)
      :subscribe(function()
        for _, p in ipairs(OutfitCharges.pieces) do
          p.charges:set(var.VarPlayer[p.charges_var].value)
        end
      end)
end

return OutfitCharges
