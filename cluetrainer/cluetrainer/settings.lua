local SliderSolver = require("cluetrainer/puzzles/sliders/SliderSolver")
local KnotSolver = require("cluetrainer/puzzles/knot/KnotSolver")
local LockboxSolver = require("cluetrainer/puzzles/lockbox/LockboxSolver")
local TowerSolver = require("cluetrainer/puzzles/towers/TowerSolver")
local ScanClueSolver = require("cluetrainer/solving/ScanClueSolver")
local CompassSolver = require("cluetrainer/solving/CompassSolver")
local ChargeLabels = require("cluetrainer/outfit/ChargeLabels")

--- Collects the settings that each puzzle module owns and persists.
local settings = {
  sliders = SliderSolver.settings,
  knots = KnotSolver.settings,
  lockboxes = LockboxSolver.settings,
  towers = TowerSolver.settings,
  scans = ScanClueSolver.settings,
  compasses = CompassSolver.settings,
  outfit_charges = ChargeLabels.settings,
}

return settings
