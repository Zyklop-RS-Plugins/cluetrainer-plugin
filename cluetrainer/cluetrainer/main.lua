-- main.lua

--- Global for zyklib. This is a universally used library, so we save ourself some annoyance by making it a global.
---@type zyklib
zyklib = require("zyklib")

-- If we do not depend dynamically on PrettyUI, use the statically included version to initialize the global
if not prettyui then
  prettyui = require("prettyui")

  zyklib.lifecycle.shutdown_event:subscribe(prettyui.PluginShutdown)
end

---@class ct.global
ctGlobal = {
  persistence = require("cluetrainer/util/storage").new("cluetrainer", "default")
}

local function main()
  zyklib.lifecycle.setupGlobals()

  local settings_dialog = require("cluetrainer/SettingsDialog")
  local MainPanel = require("cluetrainer/MainPanel")
  local PatchNotesDialog = require("cluetrainer/patch_notes/PatchNotesDialog")
  local SolvingOrchestrator = require("cluetrainer/solving/SolvingOrchestrator")
  local Map = require("cluetrainer/map/map")

  PatchNotesDialog.init()

  -- Load and initialize the individual puzzle solver modules
  require("cluetrainer/puzzles/towers/TowerSolver").init()
  require("cluetrainer/puzzles/lockbox/LockboxSolver").init()
  require("cluetrainer/puzzles/knot/KnotSolver").init()
  require("cluetrainer/puzzles/sliders/SliderSolver").init()

  require("cluetrainer/outfit/ChargeLabels").init()

  if Map.settings.visible:get() then
    -- In a callback of its own: built here, it pushed startup over the client's limit of 1000 ms per callback.
    zyklib.game_events.native.Logic:once(function()
      Map.get():setVisible(true)
      SolvingOrchestrator.setActive(SolvingOrchestrator.settings.enabled:get())
    end)
  end

  zyklib.game_events.native.SettingsLayerReady:subscribe(function(payload)
    settings_dialog.mount(payload.component)
  end)

  zyklib.game_events.native.ContentLayerReady:subscribe(function(payload)
    MainPanel.mount(payload.component, {
      solving_enabled = SolvingOrchestrator.settings.enabled:get(),
      map_visible = Map.settings.visible:get(),
      onOpenSettings = function()
        settings_dialog.open()
      end,
      onOpenPatchNotes = function()
        PatchNotesDialog.open()
      end,
      onSolvingChanged = function(enabled)
        SolvingOrchestrator.settings.enabled:set(enabled)
        SolvingOrchestrator.setActive(enabled)
      end,
      onMapChanged = function(visible)
        Map.settings.visible:set(visible)
        Map.get():setVisible(visible)
      end
    })
  end)
end

return {
  main = main
}
