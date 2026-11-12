---@diagnostic disable: undefined-global -- desktop Lua (io, os), not the client
-- build.lua - builds the slider tables listed in the plugin's manifest.lua into its Lua part files.
-- Usage (from anywhere): lua tools/sliderpdb/build.lua
-- Needs `lua` and a C compiler (`cc`); takes about 2 minutes and 700 MB of memory. The output is deterministic, so a
-- rebuild that leaves `git status` clean proves the committed files come from this source.

local DIR = arg[0]:match("^(.*)/[^/]*$") or "."
local function sh(cmd)
  local pipe = assert(io.popen(cmd))
  local out = pipe:read("a")
  assert(pipe:close(), "command failed: " .. cmd)
  return (out:gsub("%s+$", ""))
end
local ROOT = sh(string.format("git -C %q rev-parse --show-toplevel", DIR))
local DATA = ROOT .. "/cluetrainer/cluetrainer/puzzles/sliders/pdb/data"
local manifest = dofile(DATA .. "/manifest.lua")

local bin = os.tmpname()
sh(string.format("cc -O2 -o %q %q", bin, ROOT .. "/tools/sliderpdb/pdbgen.c"))
sh(string.format("rm -f %q/t*_*.lua", DATA))
for t, entry in ipairs(manifest.tables) do
  io.stderr:write(string.format("Table %d: %s\n", t, entry.region))
  local parts = sh(string.format("%q %d %s %q %d", bin, manifest.multitile and 1 or 0, entry.region, DATA .. "/t" .. t,
    manifest.part_size))
  io.stderr:write(string.format("  %s part files\n", parts))
end
os.remove(bin)
