local zyklib = require("zyklib/init")

local buffs = {}

buffs.backpack = nil
buffs.jacket = nil

local function getMaxProgress()
  return var.VarPlayer.TRAIL_OUTFIT_FULL_OWNED.value == 31 and 4 or 3
end

local function updateBuff(buff, name, chargesVar, progressVar)
  local maxProgress = getMaxProgress()
  local label = tostring(chargesVar.value)
  local tooltip = name .. " " .. tostring(progressVar.value) .. "/" .. tostring(maxProgress)

  buff:SetLabel(label)
  buff:SetTooltip(tooltip)
end

local function refreshBuffs(self)
  updateBuff(self.backpack, "Globetrotter backpack", var.VarPlayer.TRAIL_OUTFIT_CAPE_CHARGES,
    var.VarPlayer.TRAIL_OUTFIT_CAPE_CHARGE_PROGRESS)
  updateBuff(self.jacket, "Globetrotter jacket", var.VarPlayer.TRAIL_OUTFIT_TORSO_CHARGES,
    var.VarPlayer.TRAIL_OUTFIT_TORSO_CHARGE_PROGRESS)
end

function buffs:init()
  self.backpack = prettyui.BuffBar.addBuff({
    objId = 42119, -- backpack sprite
    font = id.Font.NOTOSANS_BOLD_16,
    backgroundRgba = 0x2B2100CC,
  })

  self.jacket = prettyui.BuffBar.addBuff({
    objId = 42113, -- jacket sprite
    font = id.Font.NOTOSANS_BOLD_16,
    backgroundRgba = 0x2B2100CC,
  })

  refreshBuffs(self)

  zyklib.ewent.Native.VarTransmit:subscribe(function(e)
    if not e or not e.var or not e.var.configName then
      return
    end

    -- it seems this config name is changed when the charges for jacket/backpack
    if e.var.configName ~= "TT17_VARIABLE_2" then
      return
    end

    if not self.backpack or not self.jacket then
      return
    end

    refreshBuffs(self)
  end)
end

-- to be called for cleanup when clue trainer is unloaded
function buffs:destroy()
  prettyui.BuffBar.removeBuff(self.backpack)
  prettyui.BuffBar.removeBuff(self.jacket)
end

return buffs
