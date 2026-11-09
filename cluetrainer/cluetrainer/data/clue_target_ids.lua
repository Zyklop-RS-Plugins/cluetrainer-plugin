-- Game config ids of the NPC (talk-to, master skilling) or object (search, master skilling) that each clue points to,
-- keyed by clue id.
-- ids: configID values. Objects that can be opened also list their opened state.
-- parent_ids: parentConfigID values of multi NPCs and multi objects at the clue spot.
-- Generated from the game cache and the RuneScape wiki (Codeberg #35). Entries marked "not confirmed" still need a check in game.
return {
  [0] = { ids = { 67304, 67305 } }, -- Drawers
  [2] = { ids = { 34482, 34483 } }, -- Drawers
  [14] = { ids = { 28, 7570, 7571 } }, -- Zookeeper (not confirmed)
  [20] = { ids = { 2812 } }, -- Cam the Camel
  [24] = { ids = { 15096, 15098 }, parent_ids = { 15095, 15097 } }, -- Sabbot (not confirmed)
  [30] = { ids = { 4493 } }, -- General Bentnoze
  [32] = { ids = { 300 } }, -- Haystack
  [39] = { ids = { 19647, 19873 }, parent_ids = { 1182 } }, -- Lord Iorwerth
  [40] = { ids = { 18506 } }, -- Crate
  [44] = { ids = { 46331 } }, -- Crate
  [45] = { ids = { 24202 } }, -- Crate
  [46] = { ids = { 46331 } }, -- Crate
  [47] = { ids = { 124881 } }, -- Crate
  [65] = { ids = { 34586 } }, -- Crate
  [66] = { ids = { 25034, 25035 } }, -- Drawers
  [67] = { ids = { 85101 } }, -- Crate
  [68] = { ids = { 0 } }, -- Hans
  [69] = { ids = { 24294, 24295 } }, -- Drawers
  [71] = { ids = { 40093, 40092 } }, -- Chest
  [72] = { ids = { 34482, 34483 } }, -- Drawers
  [73] = { ids = { 66624 } }, -- Drawers
  [74] = { ids = { 24911 } }, -- Crate
  [75] = { ids = { 25775 } }, -- Crate
  [76] = { ids = { 99819, 99820 } }, -- Closed Chest
  [78] = { ids = { 30928, 30927 } }, -- Chest
  [79] = { ids = { 2631, 2651 } }, -- Drawers
  [80] = { ids = { 46266 } }, -- Crate
  [81] = { ids = { 76811 } }, -- Boxes
  [82] = { ids = { 46236 } }, -- Boxes
  [83] = { ids = { 46269 } }, -- Crate
  [84] = { ids = { 11745 } }, -- Crate
  [85] = { ids = { 47560 } }, -- Crate
  [86] = { ids = { 48998 } }, -- Crate
  [87] = { ids = { 63760 } }, -- Crate
  [88] = { ids = { 809 } }, -- Louisa
  [89] = { ids = { 11745 } }, -- Crate
  [90] = { ids = { 71943, 71944 } }, -- Drawers
  [91] = { ids = { 25766, 25767 } }, -- Drawers
  [92] = { ids = { 24202 } }, -- Crate
  [93] = { ids = { 350, 351 } }, -- Drawers
  [94] = { ids = { 806 } }, -- Donovan the Family Handyman
  [95] = { ids = { 76811 } }, -- Boxes
  [96] = { ids = { 46270 } }, -- Crate
  [97] = { ids = { 171 } }, -- Brimstail (not confirmed)
  [98] = { ids = { 1042 } }, -- Roavar
  [100] = { ids = { 66875 } }, -- Barrel
  [101] = { ids = { 34585 } }, -- Crate
  [102] = { ids = { 66875 } }, -- Barrel
  [103] = { ids = { 586 } }, -- Gaius
  [105] = { ids = { 66875 } }, -- Barrel
  [106] = { ids = { 563 } }, -- Arhein
  [107] = { ids = { 11706, 11707 }, parent_ids = { 734 } }, -- Bartender
  [108] = { ids = { 46269 } }, -- Crate
  [109] = { ids = { 1054 } }, -- Ulizius
  [110] = { ids = { 46237 } }, -- Boxes
  [111] = { ids = { 25034, 25035 } }, -- Drawers
  [112] = { ids = { 76216, 76217 } }, -- Ornate chest
  [113] = { ids = { 34586 } }, -- Crate
  [114] = { ids = { 510 } }, -- Hajedy
  [115] = { ids = { 34585 } }, -- Crate
  [116] = { ids = { 2824 } }, -- Ellis
  [117] = { ids = { 25592, 25593 } }, -- Closed Chest
  [118] = { ids = { 135601, 135602 } }, -- Closed Chest
  [119] = { ids = { 79065 } }, -- Crates
  [120] = { ids = { 846 } }, -- Kangai Mau
  [121] = { ids = { 284 } }, -- Doric
  [122] = { ids = { 635 } }, -- Gnome ball referee
  [123] = { ids = { 24294, 24295 } }, -- Drawers
  [124] = { ids = { 541 } }, -- Zeke
  [125] = { ids = { 733 } }, -- Bartender
  [126] = { ids = { 21806 } }, -- Crate
  [127] = { ids = { 24294, 24295 } }, -- Drawers
  [128] = { ids = { 669 } }, -- Hazelmere
  [129] = { ids = { 136481 } }, -- Barrel
  [130] = { ids = { 25034, 25035 } }, -- Drawers
  [131] = { ids = { 25034, 25035 } }, -- Drawers
  [132] = { ids = { 606 } }, -- Squire Asrol
  [133] = { ids = { 11745 } }, -- Crate
  [134] = { ids = { 11600 } }, -- Crate
  [135] = { ids = { 40021 } }, -- Crate
  [136] = { ids = { 241 } }, -- Sir Kay
  [137] = { ids = { 918 } }, -- Ned
  [138] = { ids = { 15780 } }, -- Challenge Mistress Fara
  [139] = { ids = { 801 } }, -- Abbot Langley
  [140] = { ids = { 11699, 12261 }, parent_ids = { 558 } }, -- Gerrant
  [141] = { ids = { 4566, 4567 } }, -- Examiner (not confirmed)
  [142] = { ids = { 46334 } }, -- Boxes
  [144] = { ids = { 1008 } }, -- Hamid
  [146] = { ids = { 162 } }, -- Gnome trainer
  [147] = { ids = { 6045 } }, -- Mine Cart
  [148] = { ids = { 37047 } }, -- Bookcase
  [149] = { ids = { 79424 } }, -- Bookcase
  [150] = { ids = { 603 } }, -- Heckel Funch
  [151] = { ids = { 46331 } }, -- Crate
  [153] = { ids = { 46331 } }, -- Crate
  [158] = { ids = { 24202 } }, -- Crate
  [159] = { ids = { 126971 } }, -- Drawers
  [160] = { ids = { 6176 } }, -- Boxes
  [161] = { ids = { 24202 } }, -- Crate
  [162] = { ids = { 46331 } }, -- Crate
  [163] = { ids = { 18506 } }, -- Crate
  [164] = { ids = { 34530, 34531 } }, -- Drawers
  [167] = { ids = { 46332 } }, -- Crate
  [168] = { ids = { 3810 } }, -- Captain Bleemadge
  [169] = { ids = { 0 } }, -- Hans
  [170] = { ids = { 88873, 88874 } }, -- Drawers
  [171] = { ids = { 883 }, parent_ids = { 9359 } }, -- Sir Prysin
  [173] = { ids = { 21806 } }, -- Crate
  [174] = { ids = { 783 } }, -- Wilough
  [175] = { ids = { 747 } }, -- Oziach
  [178] = { ids = { 127765, 127766 } }, -- Drawers
  [179] = { ids = { 34585 } }, -- Crate
  [180] = { ids = { 376 } }, -- Captain Tobias
  [181] = { ids = { 24203, 24204 } }, -- Closed Chest
  [182] = { ids = { 969 } }, -- Jeed
  [183] = { ids = { 30823, 30824 } }, -- Drawers
  [184] = { ids = { 79400 } }, -- Cupboard
  [185] = { ids = { 46333 } }, -- Crate
  [186] = { ids = { 46270 } }, -- Crate
  [187] = { ids = { 34482, 34483 } }, -- Drawers
  [188] = { ids = { 18502 } }, -- Crate
  [189] = { ids = { 52556 } }, -- Crate
  [190] = { ids = { 10723 } }, -- Bookcase (not confirmed)
  [191] = { ids = { 24911 } }, -- Crate
  [192] = { ids = { 299 } }, -- Hay bales
  [193] = { ids = { 10159 } }, -- Crate
  [194] = { ids = { 67304, 67305 } }, -- Drawers
  [195] = { ids = { 25766, 25767 } }, -- Drawers
  [196] = { ids = { 40495 } }, -- Crates
  [198] = { ids = { 109470 } }, -- Crate
  [200] = { ids = { 32049 } }, -- Sacks
  [201] = { ids = { 46333 } }, -- Crate
  [203] = { ids = { 348, 349 } }, -- Drawers
  [205] = { ids = { 18889 } }, -- Crate
  [208] = { ids = { 37034, 37038 } }, -- Cupboard
  [209] = { ids = { 375, 378 } }, -- Closed chest
  [210] = { ids = { 24202 } }, -- Crate
  [211] = { ids = { 350, 351 } }, -- Drawers
  [212] = { ids = { 46331 } }, -- Crate
  [213] = { ids = { 375, 378 } }, -- Closed chest
  [214] = { ids = { 18304, 18321 } }, -- Chest
  [215] = { ids = { 84019 } }, -- Gnome crates
  [218] = { ids = { 28625 } }, -- Crate
  [220] = { ids = { 34482, 34483 } }, -- Drawers
  [224] = { ids = { 394 } }, -- Bookcase
  [287] = { ids = { 3044 } }, -- Shiratti the Custodian
  [288] = { ids = { 4594 } }, -- Captain Ninto
  [289] = { ids = { 3827 } }, -- Ramara du Croissant
  [290] = { ids = { 2802 } }, -- Gnome Coach
  [291] = { ids = { 2143, 2144, 2145, 2146, 2147, 2148, 2149, 2150 }, parent_ids = { 2142 } }, -- Riki the sculptor's model
  [292] = { ids = { 4585 } }, -- Professor Onglewip
  [293] = { ids = { 437 } }, -- Cap'n Izzy No-Beard
  [295] = { ids = { 4650 } }, -- Trader Stan
  [296] = { ids = { 460 } }, -- Wizard Frumscone
  [297] = { ids = { 471 } }, -- Bolkoy
  [298] = { ids = { 9088 }, parent_ids = { 1359, 9349 } }, -- Queen Sigrid
  [299] = { ids = { 589 } }, -- Zenesha
  [300] = { ids = { 2039 } }, -- Uglug Nar
  [301] = { ids = { 9173, 9174 }, parent_ids = { 9175 } }, -- Odd Old Man
  [302] = { ids = { 3303 } }, -- Fairy Nuff
  [303] = { ids = { 14681 } }, -- Ramokee Skinweaver
  [306] = { ids = { 5616, 5617 }, parent_ids = { 5667, 5668 } }, -- Brother Tranquility
  [307] = { ids = { 23446 } }, -- Sensei Seaworth
  [308] = { ids = { 23572 } }, -- Celia Diggory (not confirmed)
  [309] = { ids = { 2713, 30258, 30289 } }, -- Malignius Mortifer (not confirmed)
  [310] = { ids = { 2860 } }, -- Amaethwr
  [311] = { ids = { 15612, 15613, 15615, 15618 }, parent_ids = { 888, 3334, 15619, 15620, 15621, 15622, 15623, 15624, 15625, 15626 } }, -- Philipe Carnillean (not confirmed)
  [312] = { ids = { 2253, 11569 }, parent_ids = { 3820 } }, -- Wise Old Man
  [313] = { ids = { 22794 }, parent_ids = { 22792, 22793 } }, -- Paul Gower
  [314] = { ids = { 22890 } }, -- Soothsayer Sybil
  [315] = { ids = { 19927 } }, -- Lady Trahaearn
  [316] = { ids = { 7447, 7469, 14251, 14330, 27916 }, parent_ids = { 7406, 7468, 14329, 27915 } }, -- Ali The Wise (not confirmed)
  [317] = { ids = { 8867 }, parent_ids = { 27299 } }, -- Death
  [318] = { ids = { 714 }, parent_ids = { 3213 } }, -- Edmond
  [319] = { ids = { 32548 } }, -- Miriam
  [320] = { ids = { 15085 } }, -- Nails Newton
  [321] = { ids = { 15939, 15940 }, parent_ids = { 14640 } }, -- Valerio
  [322] = { ids = { 1011 } }, -- Fycie
  [323] = { ids = { 962 } }, -- Jaraah
  [326] = { ids = { 171 } }, -- Brimstail (not confirmed)
  [327] = { ids = { 278 } }, -- Cook
  [328] = { ids = { 746 } }, -- Oracle
  [329] = { ids = { 696 }, parent_ids = { 7163, 7181 } }, -- Caroline
  [330] = { ids = { 469 } }, -- King Bolren
  [332] = { ids = { 1294 } }, -- Brundt the Chieftain
  [334] = { ids = { 676 } }, -- Femi
  [335] = { ids = { 543 } }, -- Karim
  [336] = { ids = { 2520, 2521 }, parent_ids = { 2519 } }, -- Gabooty
  [337] = { ids = { 379 } }, -- Luthas
  [338] = { ids = { 720 } }, -- Recruiter
  [339] = { ids = { 17135 } }, -- Moldark, Emissary of Zamorak
  [340] = { ids = { 585 } }, -- Rommik
  [341] = { ids = { 550 } }, -- Lowe
  [342] = { ids = { 659 } }, -- Party Pete
  [343] = { ids = { 648 } }, -- King Roald
  [373] = { ids = { 34385 } }, -- Gem stall
  [375] = { ids = { 12284 } }, -- Dry patch
  [376] = { ids = {}, parent_ids = { 93367 } }, -- Elder tree
  [377] = { ids = { 2728 } }, -- Range
  [378] = { ids = { 5779 } }, -- Turgall
  [381] = { ids = { 110279, 110280 }, parent_ids = { 98296 } }, -- Fire
  [386] = { ids = { 110279, 110280 }, parent_ids = { 98296 } }, -- Fire
  [387] = { ids = { 113261 } }, -- Furnace
  [388] = { ids = { 2488 } }, -- Death altar
  [389] = { ids = { 30624 } }, -- Blood altar
  [390] = { ids = { 94048 } }, -- Corrupted Seren Stone
  [391] = { ids = { 23139 } }, -- Charming moth
  [392] = { ids = { 110279, 110280 }, parent_ids = { 98296 } }, -- Fire
  [393] = { ids = { 113010 } }, -- Concentrated gold deposit
  [396] = { ids = { 113258 } }, -- Anvil
  [471] = { ids = { 458 } }, -- Father Urhney
}
