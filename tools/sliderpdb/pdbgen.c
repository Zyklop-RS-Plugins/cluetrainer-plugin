// pdbgen.c - builds one slider distance table (pattern database) as the Lua part files the plugin loads.
// Usage: pdbgen <multitile 0|1> <25 region digits, e.g. 1111100000...> <output prefix> <characters per part>
//
// A breadth-first search from the region goal gives the exact distance of every state, indexed the way
// RegionIndexing.lua indexes them. The solver only compares neighbours, whose distances differ by at most 1, so the
// distance mod 3 is enough. Four entries are packed into one character: the base-3 number d0 + 3 d1 + 9 d2 + 27 d3
// (0..80), written as the character 0x21 + that number, skipping ']' (0x5D). The text is printable ASCII without ']',
// so each part is a plain Lua long string: <prefix>_01.lua, <prefix>_02.lua, ... each holding `return [[...]]`.
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

enum { FREE = 0, CURRENT = 1, FIXED = 2, BLANK = 24, OTHER = 255 };

static int region[25];
static int multitile;
static int solves_puzzle, current, freedom;
static int comb_cells[25], n_comb; // non-fixed cells (0-based), CURRENT first, then FREE, each by cell index
static int relevant[25];           // tile id -> tracked
static uint64_t choose[26][26], fact[26];
static uint64_t size_;

static void init(void) {
  for (int n = 0; n <= 25; n++)
    for (int k = 0; k <= 25; k++)
      choose[n][k] = k > n ? 0 : (k == 0 || k == n) ? 1 : choose[n - 1][k - 1] + choose[n - 1][k];
  fact[0] = 1;
  for (int n = 1; n <= 25; n++) fact[n] = fact[n - 1] * n;

  solves_puzzle = 1;
  current = 0;
  freedom = 0;
  for (int i = 0; i < 25; i++) {
    if (region[i] == FREE && !(i + 1 == 24 || i + 1 == 20)) solves_puzzle = 0;
    if (region[i] == CURRENT) current++;
    if (region[i] != FIXED) freedom++;
  }
  if (!solves_puzzle) current++;

  // factorial(freedom, max(2, freedom - current)) from RegionIndexing.lua
  int lower = freedom - current > 2 ? freedom - current : 2;
  size_ = 1;
  for (int n = freedom; n > lower; n--) size_ *= n;

  n_comb = 0;
  for (int i = 0; i < 25; i++) if (region[i] == CURRENT) comb_cells[n_comb++] = i;
  for (int i = 0; i < 25; i++) if (region[i] == FREE) comb_cells[n_comb++] = i;
  for (int t = 0; t < 25; t++) relevant[t] = region[t] == CURRENT || t == BLANK;
}

// board[cell] = tile id for tracked tiles, OTHER otherwise. Fixed cells hold their home tile (never tracked here).
static uint64_t rank(const uint8_t *board) {
  int perm[25], counter = 0;
  uint64_t comb = 0;
  for (int i = 0; i < n_comb; i++) {
    int tile = board[comb_cells[i]];
    if (tile != OTHER && relevant[tile]) {
      perm[counter] = tile;
      comb += choose[i][counter + 1];
      counter++;
      if (counter >= current) break;
    }
  }
  uint64_t p = 0;
  for (int i = 1; i < current; i++) {
    int c = 0;
    for (int j = 0; j < i; j++) if (perm[j] > perm[i]) c++;
    p += fact[i] * c;
  }
  return comb * fact[current] + p;
}

static int tracked_tiles[25], n_tracked; // sorted ascending

static void unrank(uint64_t index, uint8_t *board) {
  uint64_t comb = index / fact[current], p = index % fact[current];
  // Permutation: Lehmer-style digits c_i = number of earlier elements greater than element i.
  int digits[25];
  for (int i = current - 1; i >= 1; i--) { digits[i] = (int)(p / fact[i]); p %= fact[i]; }
  digits[0] = 0;
  // Rebuild from the back: element i is the (digits[i])-th largest among the first i+1 remaining... do it forward:
  // perm[i] has exactly digits[i] larger elements before it. Insert elements in order of position into a ranking.
  int order[25]; // order[i] = rank of perm[i] among perm[0..i] (0 = smallest)
  for (int i = 0; i < current; i++) order[i] = i - digits[i];
  // Convert relative ranks to absolute: process from last to first, choosing from remaining sorted tiles.
  int avail[25], n_avail = current, perm[25];
  for (int i = 0; i < current; i++) avail[i] = tracked_tiles[i];
  for (int i = current - 1; i >= 0; i--) {
    // perm[i] is the order[i]-th smallest among perm[0..i] == among remaining avail
    perm[i] = avail[order[i]];
    memmove(&avail[order[i]], &avail[order[i] + 1], (size_t)(n_avail - order[i] - 1) * sizeof(int));
    n_avail--;
  }
  // Combination: positions in comb_cells. comb = sum C(pos_k, k+1) with pos increasing (combinatorial number system).
  int pos[25];
  for (int k = current - 1; k >= 0; k--) {
    int c = k;
    while (choose[c + 1][k + 1] <= comb) c++;
    pos[k] = c;
    comb -= choose[c][k + 1];
  }
  for (int i = 0; i < 25; i++) board[i] = region[i] == FIXED ? (uint8_t)i : OTHER;
  for (int k = 0; k < current; k++) board[comb_cells[pos[k]]] = (uint8_t)perm[k];
}

int main(int argc, char **argv) {
  if (argc != 5 || strlen(argv[2]) != 25 || atoll(argv[4]) <= 0) {
    fprintf(stderr, "usage: pdbgen <multitile> <25 region digits> <output prefix> <characters per part>\n");
    return 2;
  }
  uint64_t part_chars = (uint64_t)atoll(argv[4]);
  multitile = atoi(argv[1]);
  for (int i = 0; i < 25; i++) region[i] = argv[2][i] - '0';
  init();

  n_tracked = 0;
  for (int t = 0; t < 25; t++) if (relevant[t]) tracked_tiles[n_tracked++] = t;
  if (n_tracked != current) { fprintf(stderr, "tracked %d != current %d\n", n_tracked, current); return 1; }

  uint8_t *dist = malloc(size_);
  uint32_t *queue = malloc(size_ * sizeof(uint32_t));
  if (!dist || !queue || size_ > 0xFFFFFFFFull) { fprintf(stderr, "alloc/size\n"); return 1; }
  memset(dist, 255, size_);

  // Seeds: tracked tiles at home; the blank anywhere it is not tracked-at-home (all goal states have distance 0).
  uint64_t head = 0, tail = 0;
  uint8_t board[25], next[25];
  for (int blank_cell = 0; blank_cell < 25; blank_cell++) {
    if (region[blank_cell] == FIXED) continue;
    int ok = 1;
    for (int i = 0; i < 25; i++) {
      board[i] = region[i] == FIXED ? (uint8_t)i : OTHER;
      if (region[i] == CURRENT && i != BLANK) board[i] = (uint8_t)i;
    }
    if (region[blank_cell] == CURRENT && blank_cell != BLANK) ok = 0;
    if (solves_puzzle && blank_cell != BLANK) ok = 0;
    if (!ok) continue;
    if (board[blank_cell] != OTHER && board[blank_cell] != BLANK) continue;
    board[blank_cell] = BLANK;
    uint64_t r = rank(board);
    if (dist[r] == 255) { dist[r] = 0; queue[tail++] = (uint32_t)r; }
  }

  uint64_t layer_counts[256] = {0};
  while (head < tail) {
    uint64_t idx = queue[head++];
    unrank(idx, board);
    int d = dist[idx];
    layer_counts[d]++;
    int b = -1;
    for (int i = 0; i < 25; i++) if (board[i] == BLANK) b = i;
    int bx = b % 5, by = b / 5;
    static const int dirs[4][2] = {{1, 0}, {-1, 0}, {0, 1}, {0, -1}};
    for (int di = 0; di < 4; di++) {
      memcpy(next, board, 25);
      int cur = b;
      for (int n = 1; n <= 4; n++) {
        int nx = bx + dirs[di][0] * n, ny = by + dirs[di][1] * n;
        if (nx < 0 || nx > 4 || ny < 0 || ny > 4) break;
        int cell = ny * 5 + nx;
        if (region[cell] == FIXED) break;
        next[cur] = next[cell];
        next[cell] = BLANK;
        cur = cell;
        uint64_t r = rank(next);
        if (dist[r] == 255) { dist[r] = (uint8_t)(d + 1); queue[tail++] = (uint32_t)r; }
        if (!multitile) break;
      }
    }
  }

  uint64_t unreached = size_ - tail;
  int maxd = 0;
  for (int i = 0; i < 256; i++) if (layer_counts[i]) maxd = i;
  fprintf(stderr, "size %llu reached %llu unreached %llu max depth %d\n",
          (unsigned long long)size_, (unsigned long long)tail, (unsigned long long)unreached, maxd);
  if (unreached != 0) { fprintf(stderr, "every state must be reachable\n"); return 1; }

  uint64_t chars = (size_ + 3) / 4;
  uint8_t *text = malloc(chars);
  if (!text) { fprintf(stderr, "alloc\n"); return 1; }
  for (uint64_t c = 0; c < chars; c++) {
    int v = 0, p = 1;
    for (int k = 0; k < 4; k++) {
      uint64_t i = c * 4 + k;
      v += (i < size_ ? dist[i] % 3 : 0) * p;
      p *= 3;
    }
    int ch = 0x21 + v;
    if (ch >= 0x5D) ch++;
    text[c] = (uint8_t)ch;
  }

  int part = 0;
  for (uint64_t start = 0; start < chars; start += part_chars) {
    uint64_t length = chars - start < part_chars ? chars - start : part_chars;
    char path[4096];
    snprintf(path, sizeof path, "%s_%02d.lua", argv[3], ++part);
    FILE *f = fopen(path, "wb");
    if (!f) { fprintf(stderr, "cannot write %s\n", path); return 1; }
    fputs("return [[", f);
    fwrite(text + start, 1, length, f);
    fputs("]]\n", f);
    fclose(f);
  }
  printf("%d\n", part);
  return 0;
}
