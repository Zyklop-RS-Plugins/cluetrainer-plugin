---@diagnostic disable: undefined-global -- desktop Lua (io, os), not the client
-- bench.lua — solves real slider puzzles with the plugin's slider code in the working tree, the way the game does, for
-- every combination of route set and solver fixes, and writes the report as markdown to test/slider/results/.
-- Each combination is compared per puzzle with today's game (8 tables, no fixes) and with the same tables without fixes.
-- Usage (from anywhere): lua test/slider/bench.lua [options]
--   --puzzles N     first N puzzles of each data set, or all (default 1000)
--   --mode M        mouse (default), hybrid or keyboard
--   --sets "A B"    route sets (default A A+B A+B+C = 4, 6 and 8 tables; also B, C and other combinations)
--   --fixes "a b"   code variants: none, all, or fix names joined by + (default none mirror prune dedupe all)
--   --data "f"      files in data/ (default sliders.json sliders_2024.json)
--   --out FILE      report file (default test/slider/results/<date>-<commit>[-changed].md)
-- Exits with 1 when a variant gives a wrong solution.

local DIR = arg[0]:match("^(.*)/[^/]*$") or "."
local function sh(cmd)
  local pipe = assert(io.popen(cmd))
  local out = pipe:read("a")
  local ok = pipe:close()
  assert(ok, "command failed: " .. cmd)
  return (out:gsub("%s+$", ""))
end
local function read(path)
  local file = assert(io.open(path, "rb"))
  local text = file:read("a")
  file:close()
  return text
end
local ROOT = sh(string.format("git -C %q rev-parse --show-toplevel", DIR))
local CACHE = DIR .. "/.cache"
local SLIDERS = "cluetrainer/cluetrainer/puzzles/sliders"
-- Same location as SliderSolver.getPDB: Plugin.urls.cluetrainer (plugin.production.json) .. BASE_URL
local DATA_URL = "https://cluetrainer.app/data/sliderpdb/mtm_huge/rechunked/"

-- Routes through the tables, by table number. Table 1 is the only start; the solver links each table to the
-- next that fits (Region.isChild), so a set of routes is just the tables they use.
local ROUTES = {
  A = { 1, 2, 3, 4 }, -- row 1, row 2, columns 1-2, final 3x3
  B = { 1, 2, 5, 6 }, -- row 1, row 2, row 3, final 2x5
  C = { 1, 7, 8, 4 }, -- row 1, column 1, rest of row 2 + column 2, final 3x3
}
local TODAY_SET = "A+B+C" -- what the game uses
local REGION_NAMES = { -- 0 free, 1 placed by this table, 2 placed before
  ["1111100000000000000000000"] = "row 1",
  ["2222211111000000000000000"] = "row 2",
  ["2222222222110001100011000"] = "columns 1-2 of rows 3-5",
  ["2222222222221112211022101"] = "final 3x3",
  ["2222222222111110000000000"] = "row 3",
  ["2222222222222221111011101"] = "final 2x5",
  ["2222210000100001000010000"] = "column 1",
  ["2222221111210002100021000"] = "rest of row 2 and column 2",
}

-- Fixes in the working tree, and how a variant without one gets the code from before it. A variant only changes
-- PdbSolverTicked.lua (loaded from the edited text) and the mirrored flag of the graph; everything else is shared.
local FIXES = {
  mirror = "mirrored routes: every route also on the transposed board (SliderSolver.lua flag, with the reflection fixes)",
  prune = "stop a branch once it is as long as the best solution (`>=`)",
  dedupe = "skip a board the same table was already given with no more moves",
}
local FIX_ORDER = { "mirror", "prune", "dedupe" }
local SOLVE_TIME = 200 -- ms, the game's default setting

-- Options -------------------------------------------------------------------------------------------------------------

local options = {
  puzzles = 1000, mode = "mouse", sets = { "A", "A+B", TODAY_SET },
  fixes = { "none", "mirror", "prune", "dedupe", "all" }, data = { "sliders.json", "sliders_2024.json" },
}
for i = 1, #arg, 2 do
  local key, value = arg[i], arg[i + 1]
  local function words()
    local result = {}
    for v in assert(value, key .. " needs a value"):gmatch("[^%s,]+") do result[#result + 1] = v end
    return result
  end
  if key == "--puzzles" then options.puzzles = value == "all" and math.huge or assert(tonumber(value))
  elseif key == "--mode" then options.mode = value
  elseif key == "--sets" then options.sets = words()
  elseif key == "--fixes" then options.fixes = words()
  elseif key == "--data" then options.data = words()
  elseif key == "--out" then options.out = value
  else
    io.stderr:write("usage: lua ", arg[0], " [--puzzles N|all] [--mode mouse|hybrid|keyboard] ",
      "[--sets \"A A+B A+B+C\"] [--fixes \"none mirror all\"] [--data \"sliders_2024.json\"] [--out FILE]\n")
    os.exit(2)
  end
end
assert(options.mode == "mouse" or options.mode == "hybrid" or options.mode == "keyboard", "unknown --mode")

---Sorted, unique table numbers of a set like "A+C".
local function setTables(set)
  local seen, result = {}, {}
  for route in set:gmatch("[^+]+") do
    for _, t in ipairs(assert(ROUTES[route], "unknown route " .. route)) do
      if not seen[t] then
        seen[t] = true
        result[#result + 1] = t
      end
    end
  end
  table.sort(result)
  return result
end
for _, set in ipairs(options.sets) do setTables(set) end

---Which fixes a variant name switches on: "none", "all" or names joined by +.
local function fixesOf(name)
  local on = {}
  if name == "all" then
    for _, fix in ipairs(FIX_ORDER) do on[fix] = true end
  elseif name ~= "none" then
    for fix in name:gmatch("[^+]+") do on[assert(FIXES[fix] and fix, "unknown fix " .. fix)] = true end
  end
  return on
end
for _, name in ipairs(options.fixes) do fixesOf(name) end

-- Statistics ----------------------------------------------------------------------------------------------------------

local function sorted(values)
  local s = { table.unpack(values) }
  table.sort(s)
  return s
end

local function mean(values)
  local sum = 0
  for _, v in ipairs(values) do sum = sum + v end
  return sum / #values
end

---Percentile with linear interpolation between the nearest ranks; `s` must be sorted.
local function pct(s, p)
  local pos = 1 + (#s - 1) * p / 100
  local lo = math.floor(pos)
  local hi = math.min(#s, lo + 1)
  return s[lo] + (s[hi] - s[lo]) * (pos - lo)
end

---Half-width of the 95% confidence interval of the mean (normal approximation, fine for n >= 30).
local function ci95(values)
  local m, squares = mean(values), 0
  for _, v in ipairs(values) do squares = squares + (v - m) ^ 2 end
  return 1.96 * math.sqrt(squares / (#values - 1)) / math.sqrt(#values)
end

---Two-sided exact sign test: the chance of a split at least this uneven if both sides were equally good. Summed in
---log space so large counts don't underflow.
local function signTest(wins, losses)
  local n, k = wins + losses, math.min(wins, losses)
  if n == 0 then return 1 end
  local term = n * math.log(0.5)
  local logs, top = { term }, term
  for i = 1, k do
    term = term + math.log(n - i + 1) - math.log(i)
    logs[#logs + 1] = term
    top = math.max(top, term)
  end
  local sum = 0
  for _, l in ipairs(logs) do sum = sum + math.exp(l - top) end
  return math.min(1, 2 * math.exp(top) * sum)
end

-- Puzzles: the exports in data/ ([{"id":..,"state":[25 numbers],"timestamp":"ms",..}, ..]) ------------------------

---The arrangement's parity equals the parity of the blank's distance to its home cell.
local function solvable(puzzle)
  local inversions, blank = 0, 0
  for i = 1, 25 do
    if puzzle[i] == 24 then blank = i - 1 end
    for j = i + 1, 25 do
      if puzzle[i] > puzzle[j] then inversions = inversions + 1 end
    end
  end
  return inversions % 2 == ((4 - blank % 5) + (4 - blank // 5)) % 2
end

---Puzzles in the order of the export. Left out: states that are not a permutation of 0..24, unsolvable ones, solved
---ones and duplicates, so every puzzle counts once.
local function loadPuzzles(file)
  local text = read(DIR .. "/data/" .. file)
  local set = { file = file, puzzles = {}, valid = 0, left_out = 0 }
  local seen = { ["0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24"] = true }
  for list in text:gmatch('"state"%s*:%s*%[([^%]]*)%]') do
    local puzzle, used = {}, {}
    for n in list:gmatch("%d+") do
      local v = assert(tonumber(n))
      puzzle[#puzzle + 1] = v
      used[v] = true
    end
    local key = table.concat(puzzle, " ")
    local permutation = #puzzle == 25
    for v = 0, 24 do permutation = permutation and used[v] end
    if permutation and not seen[key] and solvable(puzzle) then
      seen[key] = true
      set.valid = set.valid + 1
      if #set.puzzles < options.puzzles then set.puzzles[#set.puzzles + 1] = puzzle end
    else
      set.left_out = set.left_out + 1
    end
  end
  for digits in text:gmatch('"timestamp"%s*:%s*"?(%d+)') do
    local ms = assert(tonumber(digits))
    set.first, set.last = math.min(set.first or ms, ms), math.max(set.last or ms, ms)
  end
  return set
end

-- Tables: 1-4 from the plugin (PdbData), 5-8 from the data the plugin downloaded before, cached in .cache ----------

local function publishedData()
  local path = CACHE .. "/pdb.bin"
  if not io.open(path, "rb") then
    io.stderr:write("Downloading the slider tables (170 MB, once)\n")
    os.execute(string.format("mkdir -p %q", CACHE))
    local count = tonumber(sh(string.format("curl -fsS %q", DATA_URL .. "description.json")):match('"file_count"%s*:%s*(%d+)'))
    local urls = {}
    for k = 0, count - 1 do urls[#urls + 1] = string.format("%q", string.format("%sv0chunk%03d.bin", DATA_URL, k)) end
    sh(string.format("curl -fsS --retry 3 %s > %q && mv %q %q", table.concat(urls, " "), path .. ".part",
      path .. ".part", path))
  end
  return read(path)
end

-- Code: the slider modules of the working tree ----------------------------------------------------------------------

-- `cluetrainer/...` from the plugin, zyklib's pure parts from the submodule. The zyklib root module touches client
-- globals, so `require "zyklib"` gets just the parts the slider code uses.
package.path = ROOT .. "/cluetrainer/?.lua;" .. ROOT .. "/dependencies/zyklib/src/?.lua;" .. package.path
package.preload["zyklib"] = function()
  return { array = require("zyklib/array"), objects = require("zyklib/objects") }
end
local SliderState = require("cluetrainer/puzzles/sliders/SliderState")
local RegionGraph = require("cluetrainer/puzzles/sliders/pdb/RegionGraph")
local PdbData = require("cluetrainer/puzzles/sliders/pdb/PdbData")
local PdbRegion = require("cluetrainer/puzzles/sliders/pdb/PdbRegion")
local Indexing = require("cluetrainer/puzzles/sliders/pdb/RegionIndexing")
local AllowedMoveTable = require("cluetrainer/puzzles/sliders/pdb/AllowedMoveTable")

-- SliderSolver itself needs the client, so the two values it passes to the solver are read from its source text
local solver_settings = read(ROOT .. "/" .. SLIDERS .. "/SliderSolver.lua")
local MIRRORED = assert(solver_settings:match("RegionGraph%.new%(pdb_data%.tables,%s*(%a+)%)"),
  "RegionGraph.new call not found in SliderSolver.lua") == "true"
local BUDGET = assert(tonumber(solver_settings:match("SOLVER_TICK_BUDGET%s*=%s*(%d+)")),
  "SOLVER_TICK_BUDGET not found in SliderSolver.lua")
local SOLVER_TEXT = read(ROOT .. "/" .. SLIDERS .. "/pdb/PdbSolverTicked.lua")

---PdbSolverTicked as the working tree has it, minus the fixes that are off: each is replaced by the code from before.
local function solverModule(on)
  local text = SOLVER_TEXT
  local function find(needle, fix)
    local s, e = text:find(needle, 1, true)
    if not s then error("cannot switch off " .. fix .. ": `" .. needle .. "` not in PdbSolverTicked.lua; update bench.lua") end
    return s, e
  end
  if not on.prune then
    local s, e = find("#move_list >= #self.best_solution", "prune")
    text = text:sub(1, s - 1) .. "#move_list > #self.best_solution" .. text:sub(e + 1)
  end
  if not on.dedupe then
    local s = find("local seen = self.seen[region]", "dedupe")
    local _, e = find("seen[board] = #moves", "dedupe")
    text = text:sub(1, s - 1) .. text:sub(e + 1)
  end
  if on.mirror and not MIRRORED then error("cannot switch on mirror: SliderSolver.lua passes false") end
  return assert(load(text, "=PdbSolverTicked.lua", "t"))()
end

local commit = sh(string.format("git -C %q rev-parse --short HEAD", ROOT))
local branch = sh(string.format("git -C %q rev-parse --abbrev-ref HEAD", ROOT))
local changed = {}
for line in sh(string.format("git -C %q status --porcelain -- %s", ROOT, SLIDERS)):gmatch("[^\n]+") do
  changed[#changed + 1] = "`" .. line:sub(4):gsub("^" .. SLIDERS:gsub("%p", "%%%0") .. "/", "") .. "`"
end

---Number of start-to-end paths through the graph.
local function countRoutes(graph)
  local function paths(node)
    if #node.children == 0 then return 1 end
    local n = 0
    for _, child in ipairs(node.children) do n = n + paths(child) end
    return n
  end
  local n = 0
  for _, entry in ipairs(graph:getEntryPoints()) do n = n + paths(entry) end
  return n
end

-- The solve, as SliderSolver does it: start, then tick(budget) once per game tick until done or solve_time / 20 ticks
-- after the start tick --------------------------------------------------------------------------------------------

local function solve(config, puzzle, solve_time)
  local start = os.clock()
  local solver = config.Solver.new(SliderState.fromPermutation(puzzle), config.graph, options.mode ~= "keyboard")
  solver:start()
  local setup = os.clock() - start -- runs in the same game tick as the first tick call
  local tick, max_tick, done = 0, 0, false
  while true do
    local t0 = os.clock()
    done = solver:tick(BUDGET)
    max_tick = math.max(max_tick, os.clock() - t0 + (tick == 0 and setup or 0))
    if done or tick >= solve_time / 20 then break end
    tick = tick + 1
  end
  local result = { cpu_ms = 1000 * (os.clock() - start), tick_ms = 1000 * max_tick }
  local best = solver.best_solution
  solver:cancel()
  if best then
    local check = SliderState.fromPermutation(puzzle)
    for _, move in ipairs(best) do SliderState.doMove(check, move) end
    result.steps, result.ok = #best, SliderState.isSolved(check)
  end
  return result
end

-- Run -----------------------------------------------------------------------------------------------------------------

local datasets = {}
for k, file in ipairs(options.data) do datasets[k] = loadPuzzles(file) end

---The tables in the published file: per table a 26-byte header (multitile, 25 region cells), then the distance mod 4
---of every state, 2 bits each. Same interface as the plugin's PdbRegion.
local function publishedTables(data)
  local result, offset = {}, 0
  while offset < #data do
    local region = {}
    for i = 1, 25 do region[i] = data:byte(offset + 1 + i) end
    local description = { multitile = data:byte(offset + 1) == 1, region = region }
    local indexing = Indexing.new(region)
    local start = offset + 26
    result[#result + 1] = {
      description = description, indexing = indexing, move_table = AllowedMoveTable.new(description), modulus = 4,
      byte_size = (indexing.size + 3) // 4, source = "downloaded before",
      getDistanceByIndex = function(_, index) return (data:byte(start + index // 4 + 1) >> (2 * (index % 4))) & 3 end,
    }
    offset = start + (indexing.size + 3) // 4
  end
  return result
end

io.stderr:write("Loading the tables\n")
local tables = publishedTables(publishedData())
local shipped = PdbData.new()
while not shipped:step() do end
for t, tbl in ipairs(shipped.tables) do
  assert(table.concat(tbl.description.region) == table.concat(tables[t].description.region),
    "plugin table " .. t .. " has another region than published table " .. t)
  tbl.byte_size, tbl.source = PdbRegion.characters(tbl.indexing), "plugin"
  tables[t] = tbl
end

-- One configuration per route set and code variant; graphs per route set and mirrored flag
local solvers, graphs, sizes, configs = {}, {}, {}, {}
for _, name in ipairs(options.fixes) do solvers[name] = solverModule(fixesOf(name)) end
for _, set in ipairs(options.sets) do
  local chosen = {}
  sizes[set] = 0
  for _, t in ipairs(setTables(set)) do
    chosen[#chosen + 1] = assert(tables[t], "no table " .. t)
    sizes[set] = sizes[set] + tables[t].byte_size
  end
  graphs[set] = { [false] = RegionGraph.new(chosen, false), [true] = RegionGraph.new(chosen, true) }
  for _, name in ipairs(options.fixes) do
    configs[#configs + 1] = { set = set, fixes = name, Solver = solvers[name], graph = graphs[set][fixesOf(name).mirror == true] }
  end
end
local function configIndex(set, fixes)
  for k, c in ipairs(configs) do if c.set == set and c.fixes == fixes then return k end end
end

local results = {} -- results[dataset][config][puzzle]
for d, dataset in ipairs(datasets) do
  local r = {}
  for k = 1, #configs do r[k] = {} end
  for i, puzzle in ipairs(dataset.puzzles) do
    -- Each puzzle through every configuration, starting at a different one each time, so warm-up and CPU throttling
    -- do not favour one
    for n = 1, #configs do
      local k = (i + n) % #configs + 1
      r[k][i] = solve(configs[k], puzzle, SOLVE_TIME)
    end
    if i % 100 == 0 then io.stderr:write(string.format("  %s: %d/%d\n", dataset.file, i, #dataset.puzzles)) end
  end
  results[d] = r
end

-- Report --------------------------------------------------------------------------------------------------------------

local lines = {}
local function out(fmt, ...) lines[#lines + 1] = select("#", ...) > 0 and string.format(fmt, ...) or fmt end
local function row(cells) out("| " .. table.concat(cells, " | ") .. " |") end
---Header row and rule; the first `text_columns` (default 3) are left-aligned, the rest are numbers.
local function header(cells, text_columns)
  row(cells)
  local rule = {}
  for c = 1, #cells do rule[c] = c <= (text_columns or 3) and "---" or "---:" end
  row(rule)
end
local function f(fmt, v) return (v == nil or v ~= v) and "-" or string.format(fmt, v) end
---A difference in whole moves, signed; rounded first so -0.25 shows as +0, not -0.
local function moves(v) return f("%+d", math.floor(v + 0.5)) end
local function mb(bytes) return string.format("%.1f", bytes / 1e6) end
local function date(ms) return ms and os.date("!%Y-%m-%d", ms // 1000) or "?" end
local function setLabel(set) return string.format("%d (%s)", #setTables(set), set) end

---Per-puzzle differences in moves of `b` against `a` (lists of results), puzzles both solved.
local function deltas(a, b)
  local d = {}
  for i = 1, #a do
    if a[i].steps and b[i].steps then d[#d + 1] = b[i].steps - a[i].steps end
  end
  return d
end

---Per-puzzle comparison of `b` with `a` (lists of results): the cells Delta .. Equal.
local function versus(a, b)
  local d, better, worse, equal = deltas(a, b), 0, 0, 0
  for _, v in ipairs(d) do
    if v < 0 then better = better + 1 elseif v > 0 then worse = worse + 1 else equal = equal + 1 end
  end
  local s, m, half = sorted(d), mean(d), ci95(d)
  local p = signTest(better, worse)
  return { f("%+.2f", m), string.format("[%+.2f, %+.2f]", m - half, m + half),
    p >= 0.001 and string.format("%.3f", p) or string.format("%.0e", p), f("%+d", s[1]), moves(pct(s, 5)),
    moves(pct(s, 50)), moves(pct(s, 95)), f("%+d", s[#s]), tostring(better), tostring(worse), tostring(equal) }
end
local SPREAD = { 1, 5, 10, 25, 50, 75, 90, 95, 99 }

---The cells Min, the SPREAD percentiles and Max of the differences of `b` against `a`.
local function spread(a, b)
  local s, result = sorted(deltas(a, b)), {}
  result[1] = f("%+d", s[1])
  for _, p in ipairs(SPREAD) do result[#result + 1] = moves(pct(s, p)) end
  result[#result + 1] = f("%+d", s[#s])
  return result
end

-- Bounds of the size classes of a difference, smallest first; the last class is open-ended
local SIZES = { 1, 3, 5, 10 }
local function sizeLabel(k, sign)
  return SIZES[k + 1] and string.format("%s%d to %s%d", sign, SIZES[k], sign, SIZES[k + 1] - 1)
    or string.format("%s%d or more", sign, SIZES[k])
end

---The cells puzzles per size class (better from large to small, equal, worse from small to large), average gain of
---the better ones, average loss of the worse ones and the moves won and lost over all puzzles.
local function sizeClasses(a, b)
  local better, worse, equal, won, lost = {}, {}, 0, 0, 0
  for k = 1, #SIZES do better[k], worse[k] = 0, 0 end
  local function class(v)
    for k = #SIZES, 1, -1 do if v >= SIZES[k] then return k end end
  end
  for _, v in ipairs(deltas(a, b)) do
    if v < 0 then
      better[class(-v)], won = better[class(-v)] + 1, won - v
    elseif v > 0 then
      worse[class(v)], lost = worse[class(v)] + 1, lost + v
    else
      equal = equal + 1
    end
  end
  local result, n_better, n_worse = {}, 0, 0
  for k = #SIZES, 1, -1 do result[#result + 1], n_better = tostring(better[k]), n_better + better[k] end
  result[#result + 1] = tostring(equal)
  for k = 1, #SIZES do result[#result + 1], n_worse = tostring(worse[k]), n_worse + worse[k] end
  for _, c in ipairs({ f("%.1f", won / n_better), f("%.1f", lost / n_worse), tostring(won), tostring(lost) }) do
    result[#result + 1] = c
  end
  return result
end

local function cpuMean(r)
  local cpu = {}
  for i, x in ipairs(r) do cpu[i] = x.cpu_ms end
  return mean(cpu)
end
local function cells(...)
  local result = {}
  for _, part in ipairs({ ... }) do for _, c in ipairs(part) do result[#result + 1] = c end end
  return result
end

out("# Slider benchmark %s", os.date("%Y-%m-%d"))
out("")
out("- Code: %s, %s. SliderSolver passes mirrored = %s, %d positions per tick.",
  branch == "HEAD" and commit or ("`" .. branch .. "` at " .. commit),
  #changed > 0 and ("with uncommitted changes in " .. table.concat(changed, ", ")) or "no uncommitted slider changes",
  tostring(MIRRORED), BUDGET)
out("- %s mode, solve time %d ms. %s.", (options.mode:gsub("^%l", string.upper)), SOLVE_TIME,
  options.puzzles == math.huge and "All puzzles of each data set" or ("First " .. options.puzzles .. " puzzles of each data set"))
out("- Machine: %s, %s. Times are desktop Lua; compare them with each other, not with the game.",
  sh("uname -sm"), _VERSION)
out("")
out("Fixes (the working tree has them; a variant without one runs the code from before it):")
out("")
for _, fix in ipairs(FIX_ORDER) do out("- `%s`: %s", fix, FIXES[fix]) end
out("- `none`: all three off, the logic of the game today. `all`: all three on.")

out("")
out("## Data")
out("")
header({ "File", "Played", "Puzzles", "Left out", "Used" })
for _, dataset in ipairs(datasets) do
  row({ "data/" .. dataset.file, date(dataset.first) .. " to " .. date(dataset.last), tostring(dataset.valid),
    tostring(dataset.left_out), tostring(#dataset.puzzles) })
end
out("")
header({ "Table", "Region", "Size MB", "From" })
local total = 0
for t, tbl in ipairs(tables) do
  local region = table.concat(tbl.description.region)
  total = total + tbl.byte_size
  row({ tostring(t), REGION_NAMES[region] or ("`" .. region .. "`"), mb(tbl.byte_size), tbl.source })
end
row({ "all", "", mb(total), "" })
out("")
header({ "Tables", "Numbers", "Size MB", "Routes", "Routes with mirror" })
for _, set in ipairs(options.sets) do
  row({ setLabel(set), table.concat(setTables(set), " "), mb(sizes[set]), tostring(countRoutes(graphs[set][false])),
    tostring(countRoutes(graphs[set][true])) })
end

local today = configIndex(TODAY_SET, "none")
local failed = false
for d, dataset in ipairs(datasets) do
  out("")
  out("## %s", dataset.file)
  local problems = {}
  local r = results[d]
  for k, c in ipairs(configs) do
    local none, wrong = 0, 0
    for _, x in ipairs(r[k]) do
      if not x.steps then none = none + 1 elseif not x.ok then wrong = wrong + 1 end
    end
    if none + wrong > 0 then
      problems[#problems + 1] = string.format("%s, %s: %d without solution, %d wrong", setLabel(c.set), c.fixes, none,
        wrong)
    end
    failed = failed or wrong > 0
  end
  out("")
  out(#problems == 0 and "Every solve found a solution and every solution replays to the solved puzzle." or
    ("Problems: " .. table.concat(problems, "; ") .. "."))

  if today then
    out("")
    out("### Against today (8 tables, no fixes)")
    out("")
    header({ "Tables", "Fixes", "Avg moves", "Delta", "95% CI", "p", "Min", "p5", "p50", "p95", "Max",
      "Better", "Worse", "Equal", "CPU ms", "CPU", "Tick p99 ms", "Tick max ms" }, 2)
    for k, c in ipairs(configs) do
      local steps, tick = {}, {}
      for i, x in ipairs(r[k]) do
        if x.steps then steps[#steps + 1] = x.steps end
        tick[i] = x.tick_ms
      end
      tick = sorted(tick)
      row(cells({ setLabel(c.set), c.fixes, f("%.2f", mean(steps)) }, versus(r[today], r[k]),
        { f("%.1f", cpuMean(r[k])), f("%+.0f%%", 100 * (cpuMean(r[k]) / cpuMean(r[today]) - 1)), f("%.2f", pct(tick, 99)),
          f("%.2f", tick[#tick]) }))
    end

    out("")
    out("Spread of the difference per puzzle:")
    out("")
    local spread_header = { "Tables", "Fixes", "Min" }
    for _, p in ipairs(SPREAD) do spread_header[#spread_header + 1] = "p" .. p end
    spread_header[#spread_header + 1] = "Max"
    header(spread_header, 2)
    for k, c in ipairs(configs) do
      if k ~= today then row(cells({ setLabel(c.set), c.fixes }, spread(r[today], r[k]))) end
    end

    out("")
    out("Puzzles per size of the difference, in moves:")
    out("")
    local size_header = { "Tables", "Fixes" }
    for k = #SIZES, 1, -1 do size_header[#size_header + 1] = sizeLabel(k, "-") end
    size_header[#size_header + 1] = "0"
    for k = 1, #SIZES do size_header[#size_header + 1] = sizeLabel(k, "+") end
    for _, h in ipairs({ "Avg gain", "Avg loss", "Moves won", "Moves lost" }) do size_header[#size_header + 1] = h end
    header(size_header, 2)
    for k, c in ipairs(configs) do
      if k ~= today then row(cells({ setLabel(c.set), c.fixes }, sizeClasses(r[today], r[k]))) end
    end
  end

  out("")
  out("### Fixes against the same tables without fixes")
  out("")
  header({ "Tables", "Fixes", "Delta", "95% CI", "p", "Min", "p5", "p50", "p95", "Max", "Better", "Worse",
    "Equal", "CPU" }, 2)
  for k, c in ipairs(configs) do
    local base = configIndex(c.set, "none")
    if base and k ~= base then
      row(cells({ setLabel(c.set), c.fixes }, versus(r[base], r[k]),
        { f("%+.0f%%", 100 * (cpuMean(r[k]) / cpuMean(r[base]) - 1)) }))
    end
  end
end

out("")
out("Delta: mean per-puzzle difference in moves (this row minus the comparison), negative = the player gets a shorter")
out("solution. Min, p5, p50 (median), p95, Max: the spread of those differences; Min is the puzzle that gained most, Max")
out("the one that lost most. Better/Worse/Equal: puzzles with a shorter/longer/same solution. 95% CI: confidence interval")
out("of the mean. p: exact sign test on Better/Worse, the chance of a split this uneven if both were equally good.")
out("pN: N% of the puzzles differ this much or less. Avg gain/loss: average difference of the better/worse puzzles.")
out("Moves won/lost: the sum of those differences over all puzzles; won minus lost, divided by the puzzles, is Delta. CPU:")
out("processor time of the whole solve (the player waits the solve time regardless). Tick: processor time of one game")
out("tick, the cost per frame.")

local report = table.concat(lines, "\n") .. "\n"
io.write("\n", report)
local path = options.out or string.format("%s/results/%s-%s%s.md", DIR, os.date("%Y-%m-%d"), commit,
  #changed > 0 and "-changed" or "")
os.execute(string.format("mkdir -p %q", path:match("^(.*)/") or "."))
local file = assert(io.open(path, "w"))
file:write(report)
file:close()
io.stderr:write("Wrote ", path, "\n")

if failed then
  io.stderr:write("FAIL: a variant gave a wrong solution for a puzzle\n")
  os.exit(1)
end
