# Slider solver benchmark

Needs `lua` (5.4+), `git` and `curl`. Solves the puzzles in `data/` with the slider code in the working tree, the way the game does:

```
lua test/slider/bench.lua
```

Every puzzle is solved with 4, 6 and 8 tables, each with no fixes, with each fix on its own and with all fixes. The report compares every combination per puzzle with the game today (8 tables, no fixes) and with the same tables without fixes. It is printed and written to `results/<date>-<commit>[-changed].md`; commit it with the change it measures.

Options: `--puzzles N|all` (default 1000 per data set), `--times "200 1000"`, `--mode mouse|hybrid|keyboard`, `--sets "A A+B A+B+C"`, `--fixes "none mirror prune dedupe all"`, `--data "sliders_2024.json"`, `--out FILE`.

- The fixes are switched off by replacing their code in memory (see `solverModule` in `bench.lua`); a run errors when that code is no longer found.
- The first run downloads the published tables the plugin uses (170 MB) into `.cache/`.
- `data/sliders.json`: real puzzles from April-May 2024, before the slider rework. `data/sliders_2024.json`: December 2024, after it (the current game).
