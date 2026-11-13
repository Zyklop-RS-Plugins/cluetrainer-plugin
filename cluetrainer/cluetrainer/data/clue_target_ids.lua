-- The NPC (talk-to) or object (search) that each clue points to, by game config name, keyed by clue id.
-- ids: configs the entity can have (configID). Objects that can be opened also list their opened state.
-- parent_ids: parent configs of multi NPCs at the clue spot (parentConfigID).
-- Names are written by tools/entity_names/name_ids.lua.
-- Generated from the game cache and the RuneScape wiki (Codeberg #35). Entries marked "not confirmed" still need a check in game.
return {
  [0] = { ids = { id.Loc.OMGE_BURTHORPE_HOUSE_DRAWERS_CLOSED, id.Loc.OMGE_BURTHORPE_HOUSE_DRAWERS_OPEN } }, -- Drawers
  [2] = { ids = { id.Loc.AREA_ARDOUGNE_BASIC_DRAWERS, id.Loc.AREA_ARDOUGNE_BASIC_DRAWERS_OPEN } }, -- Drawers
  [14] = { ids = { id.NPC.ZOO_KEEPER, id.NPC.ZOO_KEEPER2, id.NPC.ZOO_KEEPER3 } }, -- Zookeeper (not confirmed)
  [20] = { ids = { id.NPC.CAM_THE_CAMEL } }, -- Cam the Camel
  [24] = { -- Sabbot (not confirmed)
    ids = { id.NPC.DEATH_SABBOT, id.NPC.DEATH_SABBOT_MINING },
    parent_ids = { id.NPC.DEATH_SABBOT_CAVE_MULTI, id.NPC.DEATH_SABBOT_TUNNEL_MULTI },
  },
  [30] = { ids = { id.NPC.GENERAL_BENTNOZE_RED } }, -- General Bentnoze
  [32] = { ids = { id.Loc.HAYSTACK3 } }, -- Haystack
  [39] = { -- Lord Iorwerth
    ids = { id.NPC.LORD_IORWERTH_VIS, id.NPC.ELFCITY_LORD_IORWERTH },
    parent_ids = { id.NPC.LORD_IORWERTH },
  },
  [40] = { ids = { id.Loc.ELEM_CRATE_1 } }, -- Crate
  [44] = { ids = { id.Loc.ACTIVE_CRATE2 } }, -- Crate
  [45] = { ids = { id.Loc.ACTIVE_CRATE2_OLD } }, -- Crate
  [46] = { ids = { id.Loc.ACTIVE_CRATE2 } }, -- Crate
  [47] = { ids = { id.Loc.HUMAN_STORAGE_CRATE_REGULAR_SQUARE_SEARCHABLE } }, -- Crate
  [65] = { ids = { id.Loc.AREA_ARDOUGNE_OUTDOOR_CRATE_STACKED } }, -- Crate
  [66] = { ids = { id.Loc.FAI_FALADOR_DRAWERS, id.Loc.FAI_FALADOR_DRAWERS_OPEN } }, -- Drawers
  [67] = { ids = { id.Loc.FARMING_CRATE_INACTIVE_VAR2 } }, -- Crate
  [68] = { ids = { id.NPC.HANS } }, -- Hans
  [69] = { ids = { id.Loc.FAI_VARROCK_DRAWERS, id.Loc.FAI_VARROCK_DRAWERS_OPEN } }, -- Drawers
  [71] = { ids = { id.Loc.FAI_PORTSARIM_CHEST_CLOSED, id.Loc.FAI_PORTSARIM_CHEST_OPEN } }, -- Chest
  [72] = { ids = { id.Loc.AREA_ARDOUGNE_BASIC_DRAWERS, id.Loc.AREA_ARDOUGNE_BASIC_DRAWERS_OPEN } }, -- Drawers
  [73] = { ids = { id.Loc.OMGE_TAVERLEY_DRAWERS } }, -- Drawers
  [74] = { ids = { id.Loc.CANAFIS_CRATE } }, -- Crate
  [75] = { ids = { id.Loc.KR_CRATE } }, -- Crate
  [76] = { ids = { id.Loc.FALADOR2015_CHEST_CLOSED, id.Loc.FALADOR2015_CHEST_OPEN } }, -- Closed Chest
  [78] = { ids = { id.Loc.ICEMT_MINE_CHEST_CLOSED, id.Loc.ICEMT_MINE_CHEST_OPEN } }, -- Chest
  [79] = { ids = { id.Loc.BUILD_IMP_DRAYNOR_DRAWERS1_CLOSED, id.Loc.BUILD_IMP_DRAYNOR_DRAWERS1_OPEN } }, -- Drawers
  [80] = { ids = { id.Loc.FAI_VARROCK_ACTIVE_RED_CRATE } }, -- Crate
  [81] = { ids = { id.Loc.DESERT2012_PROP_CRATE_ACTIVE } }, -- Boxes
  [82] = { ids = { id.Loc.FAI_VARROCK_ACTIVE_BOXES } }, -- Boxes
  [83] = { ids = { id.Loc.FAI_VARROCK_ACTIVE_LARGE_CRATE } }, -- Crate
  [84] = { ids = { id.Loc.FAI_FALADOR_SMALL_CRATES } }, -- Crate
  [85] = { ids = { id.Loc.FAI_DRAYNOR_ACTIVE_CRATE } }, -- Crate
  [86] = { ids = { id.Loc.AREA_FISHING_GUILD_CRATE_SEARCHABLE } }, -- Crate
  [87] = { ids = { id.Loc.OPN_PROP_CRATE_OFFSET } }, -- Crate
  [88] = { ids = { id.NPC.LOUISA_THE_COOK } }, -- Louisa
  [89] = { ids = { id.Loc.FAI_FALADOR_SMALL_CRATES } }, -- Crate
  [90] = { ids = { id.Loc.RIMM_IMP_DRAYNOR_DRAWERS1_CLOSED, id.Loc.RIMM_IMP_DRAYNOR_DRAWERS1_OPEN } }, -- Drawers
  [91] = { ids = { id.Loc.KR_SEERS_VILLAGE_DRAWERS1, id.Loc.KR_SEERS_VILLAGE_DRAWERS1OPEN } }, -- Drawers
  [92] = { ids = { id.Loc.ACTIVE_CRATE2_OLD } }, -- Crate
  [93] = { ids = { id.Loc.DRAWERS2, id.Loc.DRAWERS2OPEN } }, -- Drawers
  [94] = { ids = { id.NPC.DONOVAN_THE_FAMILY_HANDYMAN } }, -- Donovan the Family Handyman
  [95] = { ids = { id.Loc.DESERT2012_PROP_CRATE_ACTIVE } }, -- Boxes
  [96] = { ids = { id.Loc.ACTIVE_CRATE } }, -- Crate
  [97] = { ids = { id.NPC.GNOME_BRIMSTAIL } }, -- Brimstail (not confirmed)
  [98] = { ids = { id.NPC.WEREWOLFINNKEEPER } }, -- Roavar
  [100] = { ids = { id.Loc.OMGE_SKILL_MINING_BARREL } }, -- Barrel
  [101] = { ids = { id.Loc.AREA_ARDOUGNE_OUTDOOR_CRATE } }, -- Crate
  [102] = { ids = { id.Loc.OMGE_SKILL_MINING_BARREL } }, -- Barrel
  [103] = { ids = { id.NPC.GAIUS } }, -- Gaius
  [105] = { ids = { id.Loc.OMGE_SKILL_MINING_BARREL } }, -- Barrel
  [106] = { ids = { id.NPC.ARHEIN } }, -- Arhein
  [107] = { -- Bartender
    ids = { id.NPC.RUSTYANCHOR_BLAHMAN, id.NPC.RUSTYANCHOR_BARMAN },
    parent_ids = { id.NPC.RUSTYANCHOR_BARTENDER },
  },
  [108] = { ids = { id.Loc.FAI_VARROCK_ACTIVE_LARGE_CRATE } }, -- Crate
  [109] = { ids = { id.NPC.MORT_MYRE_GATE_GUARD } }, -- Ulizius
  [110] = { ids = { id.Loc.FAI_LUMBRIDGE_ACTIVE_BOXES } }, -- Boxes
  [111] = { ids = { id.Loc.FAI_FALADOR_DRAWERS, id.Loc.FAI_FALADOR_DRAWERS_OPEN } }, -- Drawers
  [112] = { ids = { id.Loc.DESERT2012_CHEST, id.Loc.DESERT2012_CHEST_OPEN } }, -- Ornate chest
  [113] = { ids = { id.Loc.AREA_ARDOUGNE_OUTDOOR_CRATE_STACKED } }, -- Crate
  [114] = { ids = { id.NPC.BRIMHAVENCARTDRIVER } }, -- Hajedy
  [115] = { ids = { id.Loc.AREA_ARDOUGNE_OUTDOOR_CRATE } }, -- Crate
  [116] = { ids = { id.NPC.ELLIS_TANNER } }, -- Ellis
  [117] = { ids = { id.Loc.KR_CAMELOT_CHESTCLOSED, id.Loc.KR_CAMELOT_CHESTOPEN } }, -- Closed Chest
  [118] = { ids = { id.Loc.FAI_LUMBRIDGE_CHEST_CLOSED2, id.Loc.FAI_LUMBRIDGE_CHEST_OPEN2 } }, -- Closed Chest
  [119] = { ids = { id.Loc.COMBAT_ACAD_STACKED_CRATES_VAR1 } }, -- Crates
  [120] = { ids = { id.NPC.KANGAI_MAU } }, -- Kangai Mau
  [121] = { ids = { id.NPC.DORIC } }, -- Doric
  [122] = { ids = { id.NPC.GNOMEREFEREE } }, -- Gnome ball referee
  [123] = { ids = { id.Loc.FAI_VARROCK_DRAWERS, id.Loc.FAI_VARROCK_DRAWERS_OPEN } }, -- Drawers
  [124] = { ids = { id.NPC.ZEKE } }, -- Zeke
  [125] = { ids = { id.NPC.BLUEMOON_BARTENDER } }, -- Bartender
  [126] = { ids = { id.Loc.FAI_LUMBRIDGE_ACTIVE_CRATE_STACKED } }, -- Crate
  [127] = { ids = { id.Loc.FAI_VARROCK_DRAWERS, id.Loc.FAI_VARROCK_DRAWERS_OPEN } }, -- Drawers
  [128] = { ids = { id.NPC.GRANDTREE_HAZELMERE } }, -- Hazelmere
  [129] = { ids = { id.Loc.WENDLE_BARREL_POOR_LARGE } }, -- Barrel
  [130] = { ids = { id.Loc.FAI_FALADOR_DRAWERS, id.Loc.FAI_FALADOR_DRAWERS_OPEN } }, -- Drawers
  [131] = { ids = { id.Loc.FAI_FALADOR_DRAWERS, id.Loc.FAI_FALADOR_DRAWERS_OPEN } }, -- Drawers
  [132] = { ids = { id.NPC.SQUIRE } }, -- Squire Asrol
  [133] = { ids = { id.Loc.FAI_FALADOR_SMALL_CRATES } }, -- Crate
  [134] = { ids = { id.Loc.FAI_BARBARIAN_SMALL_CRATES } }, -- Crate
  [135] = { ids = { id.Loc.FAI_PORTSARIM_CRATE2 } }, -- Crate
  [136] = { ids = { id.NPC.SIR_KAY } }, -- Sir Kay
  [137] = { ids = { id.NPC.NED } }, -- Ned
  [138] = { ids = { id.NPC.CHALLENGE_MASTER } }, -- Challenge Mistress Fara
  [139] = { ids = { id.NPC.ABBOT_LANGLEY } }, -- Abbot Langley
  [140] = { ids = { id.NPC.VKQ2_GERRANT_SICK, id.NPC.GERRANT_NPC }, parent_ids = { id.NPC.GERRANT } }, -- Gerrant
  [141] = { ids = { id.NPC.QIP_DIGSITE_EXAMINER_02, id.NPC.QIP_DIGSITE_EXAMINER_03 } }, -- Examiner (not confirmed)
  [142] = { ids = { id.Loc.ACTIVE_BOXES } }, -- Boxes
  [144] = { ids = { id.NPC.DUEL_MONK } }, -- Hamid
  [146] = { ids = { id.NPC.GNOMETRAINER } }, -- Gnome trainer
  [147] = { ids = { id.Loc.DWARFROCK_BOOK_CART } }, -- Mine Cart
  [148] = { ids = { id.Loc.BOOKCASE_OFFSET } }, -- Bookcase
  [149] = { ids = { id.Loc.WIZTOWER2012_LIBRARY_BOOKCASE } }, -- Bookcase
  [150] = { ids = { id.NPC.GNOME_HECKELFUNCH } }, -- Heckel Funch
  [151] = { ids = { id.Loc.ACTIVE_CRATE2 } }, -- Crate
  [153] = { ids = { id.Loc.ACTIVE_CRATE2 } }, -- Crate
  [158] = { ids = { id.Loc.ACTIVE_CRATE2_OLD } }, -- Crate
  [159] = { ids = { id.Loc.UNDERWORLD_SURFACE_NECROMANCERS_TOWER_FURNITURE_DRAWERS } }, -- Drawers
  [160] = { ids = { id.Loc.DWARF_KELDAGRIM_WOODEN_BOXES } }, -- Boxes
  [161] = { ids = { id.Loc.ACTIVE_CRATE2_OLD } }, -- Crate
  [162] = { ids = { id.Loc.ACTIVE_CRATE2 } }, -- Crate
  [163] = { ids = { id.Loc.ELEM_CRATE_1 } }, -- Crate
  [164] = { ids = { id.Loc.AREA_ARDOUGNE_POSH_DRAWERS2, id.Loc.AREA_ARDOUGNE_POSH_DRAWERS2_OPEN } }, -- Drawers
  [167] = { ids = { id.Loc.ACTIVE_CRATE3 } }, -- Crate
  [168] = { ids = { id.NPC.PILOT_WHITE_WOLF } }, -- Captain Bleemadge
  [169] = { ids = { id.NPC.HANS } }, -- Hans
  [170] = { ids = { id.Loc.FAI_LUMBRIDGE_CASTLE_DRAWERS_CLOSED, id.Loc.FAI_LUMBRIDGE_CASTLE_DRAWERS_OPEN } }, -- Drawers
  [171] = { ids = { id.NPC.SIR_PRYSIN }, parent_ids = { id.NPC.SIR_PRYSIN_MULTI } }, -- Sir Prysin
  [173] = { ids = { id.Loc.FAI_LUMBRIDGE_ACTIVE_CRATE_STACKED } }, -- Crate
  [174] = { ids = { id.NPC.WILOUGH } }, -- Wilough
  [175] = { ids = { id.NPC.OZIACH } }, -- Oziach
  [178] = { ids = { id.Loc.ENTRANA_DRAWERS_MEDIUMCLUE, id.Loc.ENTRANA_DRAWERS_MEDIUMCLUE_OPEN } }, -- Drawers
  [179] = { ids = { id.Loc.AREA_ARDOUGNE_OUTDOOR_CRATE } }, -- Crate
  [180] = { ids = { id.NPC.CAPTAIN_TOBIAS } }, -- Captain Tobias
  [181] = { ids = { id.Loc.FAI_VARROCK_CHEST_CLOSED, id.Loc.FAI_VARROCK_CHEST_OPEN } }, -- Closed Chest
  [182] = { ids = { id.NPC.DUEL_CROWDFEMALE3 } }, -- Jeed
  [183] = { ids = { id.Loc.ICEMT_MONASTERY_DRAWERS1, id.Loc.ICEMT_MONASTERY_DRAWERS1OPEN } }, -- Drawers
  [184] = { ids = { id.Loc.WIZTOWER2012_CUPBOARD_VAR2 } }, -- Cupboard
  [185] = { ids = { id.Loc.ACTIVE_CRATE_OLD } }, -- Crate
  [186] = { ids = { id.Loc.ACTIVE_CRATE } }, -- Crate
  [187] = { ids = { id.Loc.AREA_ARDOUGNE_BASIC_DRAWERS, id.Loc.AREA_ARDOUGNE_BASIC_DRAWERS_OPEN } }, -- Drawers
  [188] = { ids = { id.Loc.SLUG2_CRATE_SINGLE } }, -- Crate
  [189] = { ids = { id.Loc.FAIRYKIT_CRATES } }, -- Crate
  [190] = { ids = { id.Loc.MAGICTRAINING_BOOKSHELF_OLD_TALL_DOUBLE2 } }, -- Bookcase (not confirmed)
  [191] = { ids = { id.Loc.CANAFIS_CRATE } }, -- Crate
  [192] = { ids = { id.Loc.HAYSTACK2 } }, -- Hay bales
  [193] = { ids = { id.Loc.DEAL_CRATE2 } }, -- Crate
  [194] = { ids = { id.Loc.OMGE_BURTHORPE_HOUSE_DRAWERS_CLOSED, id.Loc.OMGE_BURTHORPE_HOUSE_DRAWERS_OPEN } }, -- Drawers
  [195] = { ids = { id.Loc.KR_SEERS_VILLAGE_DRAWERS1, id.Loc.KR_SEERS_VILLAGE_DRAWERS1OPEN } }, -- Drawers
  [196] = { ids = { id.Loc.LUC2_BF_CRATE } }, -- Crates
  [198] = { ids = { id.Loc.MENAPHOS_WORKER_CRATE_01_CLUE } }, -- Crate
  [200] = { ids = { id.Loc.DI2_SACKS } }, -- Sacks
  [201] = { ids = { id.Loc.ACTIVE_CRATE_OLD } }, -- Crate
  [203] = { ids = { id.Loc.DRAWERS1, id.Loc.DRAWERS1OPEN } }, -- Drawers
  [205] = { ids = { id.Loc.TOURTRAP_QIP_CRATE_SINGLE } }, -- Crate
  [208] = { ids = { id.Loc.CUPBOARD_GLOFFSET, id.Loc.CUPBOARDOPEN_GLOFFSET } }, -- Cupboard
  [209] = { ids = { id.Loc.CHESTCLOSED, id.Loc.CHESTOPEN } }, -- Closed chest
  [210] = { ids = { id.Loc.ACTIVE_CRATE2_OLD } }, -- Crate
  [211] = { ids = { id.Loc.DRAWERS2, id.Loc.DRAWERS2OPEN } }, -- Drawers
  [212] = { ids = { id.Loc.ACTIVE_CRATE2 } }, -- Crate
  [213] = { ids = { id.Loc.CHESTCLOSED, id.Loc.CHESTOPEN } }, -- Closed chest
  [214] = { ids = { id.Loc.SLUG2_CHEST, id.Loc.SLUG2_CHEST_OPEN } }, -- Chest
  [215] = { ids = { id.Loc.ACTIVE_ALUFT_GNOME_CRATES } }, -- Gnome crates
  [218] = { ids = { id.Loc.WOLF_DRUID_LARGE_CRATE } }, -- Crate
  [220] = { ids = { id.Loc.AREA_ARDOUGNE_BASIC_DRAWERS, id.Loc.AREA_ARDOUGNE_BASIC_DRAWERS_OPEN } }, -- Drawers
  [224] = { ids = { id.Loc.SHELVES_BAMBOO } }, -- Bookcase
  [287] = { ids = { id.NPC.ELID_SHIRATTI } }, -- Shiratti the Custodian
  [288] = { ids = { id.NPC.ALUFT_PILOT_NINTO } }, -- Captain Ninto
  [289] = { ids = { id.NPC.SWAN_COLONIST_3 } }, -- Ramara du Croissant
  [290] = { ids = { id.NPC.GNOME_BALL_COACH } }, -- Gnome Coach
  [291] = { -- Riki the sculptor's model
    ids = {
      id.NPC.DWARF_CITY_SHOP_SCULPTURE_MODEL,
      id.NPC.DWARF_CITY_SHOP_SCULPTURE_MODEL_BOOTS,
      id.NPC.DWARF_CITY_SHOP_SCULPTURE_MODEL_TORSO,
      id.NPC.DWARF_CITY_SHOP_SCULPTURE_MODEL_AXE,
      id.NPC.DWARF_CITY_SHOP_SCULPTURE_MODEL_BOOTS_AND_TORSO,
      id.NPC.DWARF_CITY_SHOP_SCULPTURE_MODEL_BOOTS_AND_AXE,
      id.NPC.DWARF_CITY_SHOP_SCULPTURE_MODEL_TORSO_AND_AXE,
      id.NPC.DWARF_CITY_SHOP_SCULPTURE_MODEL_FINISHED,
    },
    parent_ids = { id.NPC.DWARF_CITY_SHOP_SCULPTURE_MODEL_MULTI },
  },
  [292] = { ids = { id.NPC.ALUFT_GNOME_MAGE } }, -- Professor Onglewip
  [293] = { ids = { id.NPC.AGILITYARENA_CLERK } }, -- Cap'n Izzy No-Beard
  [295] = { ids = { id.NPC.SAILING_TRANSPORT_TRADER_STAN } }, -- Trader Stan
  [296] = { ids = { id.NPC.WIZARD_FRUMSCONE } }, -- Wizard Frumscone
  [297] = { ids = { id.NPC.TREEVILLAGE_SHOPKEEPER1 } }, -- Bolkoy
  [298] = { -- Queen Sigrid
    ids = { id.NPC.MISC_QUEEN_SIGRID_MULTICHILD },
    parent_ids = { id.NPC.MISC_QUEEN_SIGRID, id.NPC.EVQ_QUEEN_SIGRID },
  },
  [299] = { ids = { id.NPC.ZENESHA } }, -- Zenesha
  [300] = { ids = { id.NPC.ZOGRE_UGLUG_NAR } }, -- Uglug Nar
  [301] = { -- Odd Old Man
    ids = { id.NPC.RAG2_ODD_OLD_MAN, id.NPC.RAG2_ODD_OLD_MAN_FURS },
    parent_ids = { id.NPC.RAG2_ODD_OLD_MAN_MULTI },
  },
  [302] = { ids = { id.NPC.FAIRY_NUFF } }, -- Fairy Nuff
  [303] = { ids = { id.NPC.POLYPORE_SKINWEAVER } }, -- Ramokee Skinweaver
  [306] = { -- Brother Tranquility
    ids = { id.NPC.BRAIN_BROTHER_TRANQUILITY_ZOMBIE, id.NPC.BRAIN_BROTHER_TRANQUILITY_HUMAN },
    parent_ids = { id.NPC.BRAIN_TRANQUILITY, id.NPC.BRAIN_ISLAND_TRANQUILITY },
  },
  [307] = { ids = { id.NPC.ELR2_IMPLING_EXPERT } }, -- Sensei Seaworth
  [308] = { ids = { id.NPC.FOTG2_DIGSITE_GUIDE } }, -- Celia Diggory (not confirmed)
  [309] = { -- Malignius Mortifer (not confirmed)
    ids = { id.NPC.ELEMENTAL_WIZARD_BOSS, id.NPC.QUEST_NECROMANCY_TUTORIAL_MALIGNIUS, id.NPC.NECRO_HUB_MALIGNIUS },
  },
  [310] = { ids = { id.NPC.PAWYA_ELF_GARDENER } }, -- Amaethwr
  [311] = { -- Philipe Carnillean (not confirmed)
    ids = {
      id.NPC.CARNI_PHILIPE_HAZEELCULTQUEST,
      id.NPC.CARNI_PHILIPE_FOLLOWER,
      id.NPC.CARNI_PHILIPE_PICKPOCKET,
      id.NPC.CARNI_PHILIPE_FIGHTING,
    },
    parent_ids = {
      id.NPC.PHILIPE_CARNILLEAN,
      id.NPC.CARNI_PHILIPE_POSTQUEST_9,
      id.NPC.CARNI_PHILIPE_POSTQUEST_1,
      id.NPC.CARNI_PHILIPE_POSTQUEST_2,
      id.NPC.CARNI_PHILIPE_POSTQUEST_3,
      id.NPC.CARNI_PHILIPE_POSTQUEST_4,
      id.NPC.CARNI_PHILIPE_POSTQUEST_5,
      id.NPC.CARNI_PHILIPE_POSTQUEST_6,
      id.NPC.CARNI_PHILIPE_POSTQUEST_7,
      id.NPC.CARNI_PHILIPE_POSTQUEST_8,
    },
  },
  [312] = { ids = { id.NPC.WISE_OLD_MAN, id.NPC.WOM_CUTSCENE_4 }, parent_ids = { id.NPC.WOM_MULTI } }, -- Wise Old Man
  [313] = { -- Paul Gower
    ids = { id.NPC.GOWER_PAUL },
    parent_ids = { id.NPC.GOWER_PAUL_MULTI, id.NPC.GOWER_PAUL_ALTAR_MULTI },
  },
  [314] = { ids = { id.NPC.GWD2_SOLO_SOOTHSAYER } }, -- Soothsayer Sybil
  [315] = { ids = { id.NPC.ELFCITY_LADY_TRAHAEARN } }, -- Lady Trahaearn
  [316] = { -- Ali The Wise (not confirmed)
    ids = {
      id.NPC.MAH1_ALI_THE_WISE,
      id.NPC.MAH3_ALI_THE_WISE,
      id.NPC.MAH5_WAVE_ALI_THE_WISE,
      id.NPC.MAH5_ALI_THE_WISE,
      id.NPC.MINIQUEST_EGWD_PRERELEASE_WAHISIETEL_PRESENT,
    },
    parent_ids = {
      id.NPC.MAH1_ALI_THE_WISE_MULTI,
      id.NPC.MAH3_ALI_THE_WISE_MULTI,
      id.NPC.MAH5_ALI_THE_WISE_MULTI,
      id.NPC.MINIQUEST_EGWD_PRERELEASE_WAHISIETEL,
    },
  },
  [317] = { ids = { id.NPC.ADVISOR_GRIM_REAPER }, parent_ids = { id.NPC.DEATH_OFFICE_MULTI } }, -- Death
  [318] = { ids = { id.NPC.EDMOND }, parent_ids = { id.NPC.EDMOND_TOP } }, -- Edmond
  [319] = { ids = { id.NPC.WENDLE_MUSICIAN } }, -- Miriam
  [320] = { ids = { id.NPC.LTEP_NAILS } }, -- Nails Newton
  [321] = { -- Valerio
    ids = { id.NPC.OPN_VALERIO_OUTSIDE_DURINGQUEST_APPEARANCE, id.NPC.OPN_VALERIO_OUTSIDE_POSTQUEST_APPEARANCE },
    parent_ids = { id.NPC.OPN_VALERIO_OUTSIDE },
  },
  [322] = { ids = { id.NPC.FYCIE } }, -- Fycie
  [323] = { ids = { id.NPC.DUEL_JARAAH } }, -- Jaraah
  [326] = { ids = { id.NPC.GNOME_BRIMSTAIL } }, -- Brimstail (not confirmed)
  [327] = { ids = { id.NPC.COOK } }, -- Cook
  [328] = { ids = { id.NPC.ORACLE } }, -- Oracle
  [329] = { -- Caroline
    ids = { id.NPC.CAROLINE },
    parent_ids = { id.NPC.CAROLINE_MULTI, id.NPC.KEN_CAROLINE_INSIDEHOUSE },
  },
  [330] = { ids = { id.NPC.KING_BOLREN } }, -- King Bolren
  [332] = { ids = { id.NPC.VIKING_BRUNDT } }, -- Brundt the Chieftain
  [334] = { ids = { id.NPC.GRANDTREE_FEMI } }, -- Femi
  [335] = { ids = { id.NPC.KEBAB_SELLER } }, -- Karim
  [336] = { -- Gabooty
    ids = { id.NPC.TBWCU_GABOOTY, id.NPC.TBWCU_GABOOTY_NOSTICKS },
    parent_ids = { id.NPC.TBWCU_GABOOTY_MULTINPC },
  },
  [337] = { ids = { id.NPC.LUTHAS } }, -- Luthas
  [338] = { ids = { id.NPC.RECRUITER } }, -- Recruiter
  [339] = { ids = { id.NPC.GODEM_ZAMORAK_EMISSARY } }, -- Moldark, Emissary of Zamorak
  [340] = { ids = { id.NPC.ROMMIK } }, -- Rommik
  [341] = { ids = { id.NPC.LOWE } }, -- Lowe
  [342] = { ids = { id.NPC.PARTYROOM_PETE } }, -- Party Pete
  [343] = { ids = { id.NPC.KING_ROALD } }, -- King Roald
  [471] = { ids = { id.NPC.FATHER_URHNEY } }, -- Father Urhney
}
