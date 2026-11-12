# Slider solver benchmark

Needs `lua` (5.4+), `git` and `curl`. Solves the puzzles in `data/` with the slider code in the working tree, the way the game does at its default solve time of 200 ms:

```
lua test/slider/bench.lua
```

Every puzzle is solved with 4, 6 and 8 tables, each with no fixes, with each fix on its own and with all fixes. The report compares every combination per puzzle with the game today (8 tables, no fixes) and with the same tables without fixes. It is printed and written to `results/<date>-<commit>[-changed].md`; commit it with the change it measures.

Options: `--puzzles N|all` (default 1000 per data set), `--mode mouse|hybrid|keyboard`, `--sets "A A+B A+B+C"`, `--fixes "none mirror prune dedupe all"`, `--data "sliders_2024.json"`, `--out FILE`.

- The fixes are switched off by replacing their code in memory (see `solverModule` in `bench.lua`); a run errors when that code is no longer found.
- Tables 1-4 are the ones the plugin ships (`pdb/data/`). Tables 5-8 only exist in the data the plugin downloaded before; the first run downloads it (170 MB) into `.cache/`.
- `data/sliders.json`: real puzzles from April-May 2024, before the slider rework. `data/sliders_2024.json`: December 2024, after it (the current game).
