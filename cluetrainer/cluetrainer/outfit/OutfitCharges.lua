-- OutfitCharges.lua

---@class ct.outfit.OutfitPiece
---@field name string Item name of the piece
---@field obj_ids table<integer, true> Object ids of all upgrade tiers of the piece
---@field charges_var string Name of the variable holding the piece's stored charges
---@field charges zyklib.reactive.Observable<integer> Charges currently stored in the piece, kept up to date while observed

--- Game state of the Globetrotter outfit pieces that can store outfit ability charges. How the charges are shown is up
--- to the modules that use this one, such as ChargeLabels.
---@class ct.outfit.OutfitCharges
local OutfitCharges = {}

--- The base variables of the charge varbits, which the server transmits on every change.
---@type table<integer, true>
local base_variable_ids = {}

---@type table<ct.outfit.OutfitPiece, boolean>
local observed = {}

---@type zyklib.reactive.EventHandler?
local var_handler = nil

local function refresh()
  for _, p in pairs(OutfitCharges.pieces) do
    p.charges:set(var.VarPlayer[p.charges_var].value)
  end
end

--- Listens to the server only while any piece's charges are observed. On resuming, it first catches up on the changes
--- it missed, so that no stale charges are served.
---@param p ct.outfit.OutfitPiece
---@param is_observed boolean
local function setObserved(p, is_observed)
  observed[p] = is_observed

  local any_observed = false
  for _, value in pairs(observed) do
    if value then any_observed = true end
  end

  if var_handler == nil then
    var_handler = zyklib.game_events.native.VarTransmit
        :filter(function(event) return base_variable_ids[event.var.id] ~= nil end)
        :subscribeSuspended(refresh)
  end

  if any_observed and not var_handler:isActive() then refresh() end
  var_handler:setActive(any_observed)
end

---@param name string
---@param obj_prefix string Prefix of the piece's object names, followed by TIER0 to TIER3
---@param charges_var string
---@return ct.outfit.OutfitPiece
local function piece(name, obj_prefix, charges_var)
  ---@type table<integer, true>
  local obj_ids = {}
  for tier = 0, 3 do
    obj_ids[id.Obj[obj_prefix .. tier]] = true
  end

  ---@type ct.outfit.OutfitPiece
  local p
  p = {
    name = name,
    obj_ids = obj_ids,
    charges_var = charges_var,
    charges = zyklib.reactive.Observable.new(var.VarPlayer[charges_var].value, nil, function(is_observed)
      setObserved(p, is_observed)
    end),
  }

  base_variable_ids[var.VarPlayer[charges_var].baseVar.id] = true

  return p
end

OutfitCharges.pieces = {
  jacket = piece("Globetrotter jacket", "TRAIL17_TORSO_TIER", "TRAIL_OUTFIT_TORSO_CHARGES"),
  backpack = piece("Globetrotter backpack", "TRAIL17_CAPE_TIER", "TRAIL_OUTFIT_CAPE_CHARGES"),
  boots = piece("Globetrotter boots", "TRAIL17_BOOTS_TIER", "TRAIL_OUTFIT_BOOTS_CHARGES"),
}

return OutfitCharges
