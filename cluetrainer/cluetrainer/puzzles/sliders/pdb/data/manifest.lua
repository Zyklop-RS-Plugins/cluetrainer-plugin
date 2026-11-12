-- The slider tables that ship with the plugin. `lua tools/sliderpdb/build.lua` builds them into the part files next to
-- this one (t<table>_<part>.lua); PdbData.lua loads them.
-- Region: per cell 2 = placed before this table, 1 = placed by this table, 0 = free.
return {
  multitile = true,         -- tables for mouse moves (a whole row or column part in one move)
  -- Characters per part file. Stays below the largest file the client is known to load (scan_methods.lua, 2.2 MB);
  -- the client's require returned nil for 4 MiB parts.
  part_size = 2 * 1024 * 1024,
  tables = {
    { region = "1111100000000000000000000" }, -- row 1
    { region = "2222211111000000000000000" }, -- row 2
    { region = "2222222222110001100011000" }, -- columns 1-2 of rows 3-5
    { region = "2222222222221112211022101" }, -- final 3x3
  },
}
