local zyklib = require("zyklib")

---@type Step[]
local clues = {
  {
    id = 0,
    type = "simple",
    tier = "easy",
    text = { "Search the drawers of Hild and Penda's house in Burthorpe." },
    solution = {
      type = "search",
      entity = "Drawers",
      entity_configs = {
        { domain = "loc", name = "OMGE_BURTHORPE_HOUSE_DRAWERS_CLOSED" },
        { domain = "loc", name = "OMGE_BURTHORPE_HOUSE_DRAWERS_OPEN" }
      },
      spot = { level = 0, topleft = { x = 2914, y = 3521 }, botright = { x = 2914, y = 3521 } }
    }
  },
  {
    id = 2,
    type = "simple",
    tier = "easy",
    text = { "Search the drawers found upstairs in the Westernmost Inn of East Ardougne." },
    solution = {
      type = "search",
      entity = "Drawers",
      entity_configs = {
        { domain = "loc", name = "AREA_ARDOUGNE_BASIC_DRAWERS" },
        { domain = "loc", name = "AREA_ARDOUGNE_BASIC_DRAWERS_OPEN" }
      },
      spot = { level = 1, topleft = { x = 2575, y = 3326 }, botright = { x = 2575, y = 3326 } }
    }
  },
  {
    id = 65,
    type = "simple",
    tier = "easy",
    text = { "Search the crates outside the bank in the north of east-ardougne" },
    solution = {
      type = "search",
      entity = "Crate",
      entity_configs = { { domain = "loc", name = "AREA_ARDOUGNE_OUTDOOR_CRATE_STACKED" } },
      spot = { level = 0, topleft = { x = 2620, y = 3336 }, botright = { x = 2620, y = 3336 } }
    }
  },
  {
    id = 66,
    type = "simple",
    tier = "easy",
    text = { "Search the drawers in a house in Catherby." },
    solution = {
      type = "search",
      entity = "Drawers",
      entity_configs = {
        { domain = "loc", name = "FAI_FALADOR_DRAWERS" },
        { domain = "loc", name = "FAI_FALADOR_DRAWERS_OPEN" }
      },
      spot = { level = 0, topleft = { x = 2830, y = 3448 }, botright = { x = 2830, y = 3448 } }
    }
  },
  {
    id = 67,
    type = "simple",
    tier = "easy",
    text = { "Search the crates in the chicken coop in the farm north of Port Sarim." },
    solution = {
      type = "search",
      entity = "Crate",
      entity_configs = { { domain = "loc", name = "FARMING_CRATE_INACTIVE_VAR2" } },
      spot = { level = 0, topleft = { x = 3018, y = 3287 }, botright = { x = 3018, y = 3287 } }
    }
  },
  {
    id = 68,
    type = "simple",
    tier = "easy",
    text = { "Speak to Hans to solve the clue." },
    solution = {
      type = "talkto",
      spots = {
        {
          range = { origin = { x = 3202, y = 3205, level = 0 }, size = { x = 21, y = 28 } },
          description = "at Lumbridge Castle"
        }
      },
      npc = "Hans",
      npc_configs = { { domain = "npc", name = "HANS" } }
    }
  },
  {
    id = 69,
    type = "simple",
    tier = "easy",
    text = { "Search the drawers above the shops in Varrock." },
    solution = {
      type = "search",
      entity = "Drawers",
      entity_configs = {
        { domain = "loc", name = "FAI_VARROCK_DRAWERS" },
        { domain = "loc", name = "FAI_VARROCK_DRAWERS_OPEN" }
      },
      spot = { level = 1, topleft = { x = 3206, y = 3419 }, botright = { x = 3206, y = 3419 } }
    }
  },
  {
    id = 71,
    type = "simple",
    tier = "easy",
    text = { "Search chests found in the upstairs of shops in Port Sarim." },
    solution = {
      type = "search",
      entity = "Chest",
      entity_configs = {
        { domain = "loc", name = "FAI_PORTSARIM_CHEST_CLOSED" },
        { domain = "loc", name = "FAI_PORTSARIM_CHEST_OPEN" }
      },
      spot = { level = 1, topleft = { x = 3016, y = 3205 }, botright = { x = 3016, y = 3205 } }
    }
  },
  {
    id = 72,
    type = "simple",
    tier = "easy",
    text = {
      "Search the drawers on the first floor of a building overlooking Ardougne market."
    },
    solution = {
      type = "search",
      entity = "Drawers",
      entity_configs = {
        { domain = "loc", name = "AREA_ARDOUGNE_BASIC_DRAWERS" },
        { domain = "loc", name = "AREA_ARDOUGNE_BASIC_DRAWERS_OPEN" }
      },
      spot = { level = 1, topleft = { x = 2655, y = 3323 }, botright = { x = 2655, y = 3323 } }
    }
  },
  {
    id = 73,
    type = "simple",
    tier = "easy",
    text = { "Search the drawers in Ivy's house in Taverley." },
    solution = {
      type = "search",
      entity = "Drawers",
      entity_configs = { { domain = "loc", name = "OMGE_TAVERLEY_DRAWERS" } },
      spot = { level = 0, topleft = { x = 2914, y = 3448 }, botright = { x = 2914, y = 3448 } }
    }
  },
  {
    id = 74,
    type = "simple",
    tier = "easy",
    text = { "Search the crates in Canifis." },
    solution = {
      type = "search",
      entity = "Crate",
      entity_configs = { { domain = "loc", name = "CANAFIS_CRATE" } },
      spot = { level = 0, topleft = { x = 3509, y = 3497 }, botright = { x = 3509, y = 3497 } }
    }
  },
  {
    id = 75,
    type = "simple",
    tier = "easy",
    text = { "Search for a crate on the ground floor of a house in Seers' Village." },
    solution = {
      type = "search",
      entity = "Crate",
      entity_configs = { { domain = "loc", name = "KR_CRATE" } },
      spot = { level = 0, topleft = { x = 2699, y = 3470 }, botright = { x = 2699, y = 3470 } }
    }
  },
  {
    id = 76,
    type = "simple",
    tier = "easy",
    text = { "Search through chests found in the upstairs of houses in eastern Falador." },
    solution = {
      type = "search",
      entity = "Closed Chest",
      entity_configs = {
        { domain = "loc", name = "FALADOR2015_CHEST_CLOSED" },
        { domain = "loc", name = "FALADOR2015_CHEST_OPEN" }
      },
      spot = { level = 1, topleft = { x = 3041, y = 3364 }, botright = { x = 3041, y = 3364 } }
    }
  },
  {
    id = 78,
    type = "simple",
    tier = "easy",
    text = { "Search the chests in the Dwarven Mine." },
    solution = {
      type = "search",
      entity = "Chest",
      entity_configs = {
        { domain = "loc", name = "ICEMT_MINE_CHEST_CLOSED" },
        { domain = "loc", name = "ICEMT_MINE_CHEST_OPEN" }
      },
      spot = { level = 0, topleft = { x = 3000, y = 9798 }, botright = { x = 3000, y = 9798 } }
    }
  },
  {
    id = 79,
    type = "simple",
    tier = "easy",
    text = { "Search the drawers in a house in Draynor Village." },
    solution = {
      type = "search",
      entity = "Drawers",
      entity_configs = {
        { domain = "loc", name = "BUILD_IMP_DRAYNOR_DRAWERS1_CLOSED" },
        { domain = "loc", name = "BUILD_IMP_DRAYNOR_DRAWERS1_OPEN" }
      },
      spot = { level = 0, topleft = { x = 3097, y = 3277 }, botright = { x = 3097, y = 3277 } }
    }
  },
  {
    id = 80,
    type = "simple",
    tier = "easy",
    text = { "Search for a crate in Varrock Palace." },
    solution = {
      type = "search",
      entity = "Crate",
      entity_configs = { { domain = "loc", name = "FAI_VARROCK_ACTIVE_RED_CRATE" } },
      spot = { level = 0, topleft = { x = 3224, y = 3492 }, botright = { x = 3224, y = 3492 } }
    }
  },
  {
    id = 81,
    type = "simple",
    tier = "easy",
    text = { "Search the boxes in the house in Al Kharid with racks of silk." },
    solution = {
      type = "search",
      entity = "Boxes",
      entity_configs = { { domain = "loc", name = "DESERT2012_PROP_CRATE_ACTIVE" } },
      spot = { level = 0, topleft = { x = 3289, y = 3202 }, botright = { x = 3289, y = 3202 } }
    }
  },
  {
    id = 82,
    type = "simple",
    tier = "easy",
    text = { "Search the boxes in the house near the south entrance of Varrock." },
    solution = {
      type = "search",
      entity = "Boxes",
      entity_configs = { { domain = "loc", name = "FAI_VARROCK_ACTIVE_BOXES" } },
      spot = { level = 0, topleft = { x = 3203, y = 3384 }, botright = { x = 3203, y = 3384 } }
    }
  },
  {
    id = 83,
    type = "simple",
    tier = "easy",
    text = { "Search the crates near a cart in Varrock." },
    solution = {
      type = "search",
      entity = "Crate",
      entity_configs = { { domain = "loc", name = "FAI_VARROCK_ACTIVE_LARGE_CRATE" } },
      spot = { level = 0, topleft = { x = 3226, y = 3452 }, botright = { x = 3226, y = 3452 } }
    }
  },
  {
    id = 84,
    type = "simple",
    tier = "easy",
    text = { "Look in the ground floor crates of houses in Falador." },
    solution = {
      type = "search",
      entity = "Crate",
      entity_configs = { { domain = "loc", name = "FAI_FALADOR_SMALL_CRATES" } },
      spot = { level = 0, topleft = { x = 3029, y = 3355 }, botright = { x = 3029, y = 3355 } }
    }
  },
  {
    id = 85,
    type = "simple",
    tier = "easy",
    text = { "Search the crates in Draynor Manor." },
    solution = {
      type = "search",
      entity = "Crate",
      entity_configs = { { domain = "loc", name = "FAI_DRAYNOR_ACTIVE_CRATE" } },
      spot = { level = 2, topleft = { x = 3106, y = 3369 }, botright = { x = 3106, y = 3369 } }
    }
  },
  {
    id = 86,
    type = "simple",
    tier = "easy",
    text = { "Search for a crate in a building in Hemenster." },
    solution = {
      type = "search",
      entity = "Crate",
      entity_configs = { { domain = "loc", name = "AREA_FISHING_GUILD_CRATE_SEARCHABLE" } },
      spot = { level = 0, topleft = { x = 2636, y = 3453 }, botright = { x = 2636, y = 3453 } }
    }
  },
  {
    id = 87,
    type = "simple",
    tier = "easy",
    text = { "Search the crates in yard of Citharede Abbey." },
    solution = {
      type = "search",
      entity = "Crate",
      entity_configs = { { domain = "loc", name = "OPN_PROP_CRATE_OFFSET" } },
      spot = { level = 0, topleft = { x = 3415, y = 3158 }, botright = { x = 3415, y = 3158 } }
    }
  },
  {
    id = 88,
    type = "simple",
    tier = "easy",
    text = { "Speak to the staff of Sinclair Mansion." },
    solution = {
      type = "talkto",
      spots = {
        {
          range = { origin = { x = 2736, y = 3574, level = 0 }, size = { x = 2, y = 7 } },
          description = "in Sinclair Mansion"
        }
      },
      npc = "Louisa",
      npc_configs = { { domain = "npc", name = "LOUISA_THE_COOK" } }
    }
  },
  {
    id = 89,
    type = "simple",
    tier = "easy",
    text = { "Search in the south-east corner of the Artisan Dwarves' workshop in Falador." },
    solution = {
      type = "search",
      entity = "Crate",
      entity_configs = { { domain = "loc", name = "FAI_FALADOR_SMALL_CRATES" } },
      spot = { level = 0, topleft = { x = 3060, y = 3334 }, botright = { x = 3060, y = 3334 } }
    }
  },
  {
    id = 90,
    type = "simple",
    tier = "easy",
    text = { "Search through some drawers in the upstairs of a house in Rimmington." },
    solution = {
      type = "search",
      entity = "Drawers",
      entity_configs = {
        { domain = "loc", name = "RIMM_IMP_DRAYNOR_DRAWERS1_CLOSED" },
        { domain = "loc", name = "RIMM_IMP_DRAYNOR_DRAWERS1_OPEN" }
      },
      spot = { level = 1, topleft = { x = 2970, y = 3214 }, botright = { x = 2970, y = 3214 } }
    }
  },
  {
    id = 91,
    type = "simple",
    tier = "easy",
    text = { "Search upstairs in the houses of Seers' Village for some drawers." },
    solution = {
      type = "search",
      entity = "Drawers",
      entity_configs = {
        { domain = "loc", name = "KR_SEERS_VILLAGE_DRAWERS1" },
        { domain = "loc", name = "KR_SEERS_VILLAGE_DRAWERS1OPEN" }
      },
      spot = { level = 1, topleft = { x = 2716, y = 3471 }, botright = { x = 2716, y = 3471 } }
    }
  },
  {
    id = 92,
    type = "simple",
    tier = "easy",
    text = { "Search the crates in a house in Yanille that has a piano." },
    solution = {
      type = "search",
      entity = "Crate",
      entity_configs = { { domain = "loc", name = "ACTIVE_CRATE2_OLD" } },
      spot = { level = 0, topleft = { x = 2598, y = 3105 }, botright = { x = 2598, y = 3105 } }
    }
  },
  {
    id = 93,
    type = "simple",
    tier = "easy",
    text = { "Search the drawers in the ground floor of a shop in Yanille." },
    solution = {
      type = "search",
      entity = "Drawers",
      entity_configs = {
        { domain = "loc", name = "DRAWERS2" },
        { domain = "loc", name = "DRAWERS2OPEN" }
      },
      spot = { level = 0, topleft = { x = 2570, y = 3085 }, botright = { x = 2570, y = 3085 } }
    }
  },
  {
    id = 95,
    type = "simple",
    tier = "easy",
    text = { "Search the boxes in one of the tents in Al Kharid." },
    solution = {
      type = "search",
      entity = "Boxes",
      entity_configs = { { domain = "loc", name = "DESERT2012_PROP_CRATE_ACTIVE" } },
      spot = { level = 0, topleft = { x = 3308, y = 3206 }, botright = { x = 3308, y = 3206 } }
    }
  },
  {
    id = 96,
    type = "simple",
    tier = "easy",
    text = { "Search the crate near a cart in Port Khazard." },
    solution = {
      type = "search",
      entity = "Crate",
      entity_configs = { { domain = "loc", name = "ACTIVE_CRATE" } },
      spot = { level = 0, topleft = { x = 2660, y = 3149 }, botright = { x = 2660, y = 3149 } }
    }
  },
  {
    id = 99,
    type = "simple",
    tier = "easy",
    text = { "Dig near some giant mushrooms behind the Grand Tree." },
    solution = {
      type = "dig",
      spot = { x = 2459, y = 3505, level = 0 },
      description = "behind the giant mushrooms"
    }
  },
  {
    id = 100,
    type = "simple",
    tier = "easy",
    text = { "Search a barrel outside the Pick and Lute inn, in Taverley." },
    solution = {
      type = "search",
      entity = "Barrel",
      entity_configs = { { domain = "loc", name = "OMGE_SKILL_MINING_BARREL" } },
      spot = { level = 0, topleft = { x = 2886, y = 3449 }, botright = { x = 2886, y = 3449 } }
    }
  },
  {
    id = 101,
    type = "simple",
    tier = "easy",
    text = { "Search the crates in the house at the north end of the East Ardougne Market." },
    solution = {
      type = "search",
      entity = "Crate",
      entity_configs = { { domain = "loc", name = "AREA_ARDOUGNE_OUTDOOR_CRATE" } },
      spot = { level = 0, topleft = { x = 2658, y = 3323 }, botright = { x = 2658, y = 3323 } }
    }
  },
  {
    id = 102,
    type = "simple",
    tier = "easy",
    text = { "Search a barrel outside the mill, in Taverley." },
    solution = {
      type = "search",
      entity = "Barrel",
      entity_configs = { { domain = "loc", name = "OMGE_SKILL_MINING_BARREL" } },
      spot = { level = 0, topleft = { x = 2894, y = 3418 }, botright = { x = 2894, y = 3418 } }
    }
  },
  {
    id = 103,
    type = "simple",
    tier = "easy",
    text = { "Speak to Gaius in Burthorpe." },
    solution = {
      type = "talkto",
      npc = "Gaius",
      npc_configs = { { domain = "npc", name = "GAIUS" } },
      spots = {
        {
          range = { origin = { x = 2926, y = 3546, level = 0 }, size = { x = 6, y = 7 } },
          description = "in Burthorpe"
        }
      }
    }
  },
  {
    id = 105,
    type = "simple",
    tier = "easy",
    text = { "Search a barrel east of Challenge Mistress Fara, in Burthorpe." },
    solution = {
      type = "search",
      entity = "Barrel",
      entity_configs = { { domain = "loc", name = "OMGE_SKILL_MINING_BARREL" } },
      spot = { level = 0, topleft = { x = 2912, y = 3530 }, botright = { x = 2912, y = 3530 } }
    }
  },
  {
    id = 106,
    type = "simple",
    tier = "easy",
    text = { "Speak to Arhein in Catherby." },
    solution = {
      type = "talkto",
      npc = "Arhein",
      npc_configs = { { domain = "npc", name = "ARHEIN" } },
      spots = {
        {
          range = { origin = { x = 2803, y = 3426, level = 0 } },
          description = "in Catherby"
        }
      }
    }
  },
  {
    id = 107,
    type = "simple",
    tier = "easy",
    text = { "Talk to the bartender of the Rusty Anchor in Port Sarim." },
    solution = {
      type = "talkto",
      npc = "Bartender",
      npc_configs = {
        { domain = "npc", name = "RUSTYANCHOR_BLAHMAN" },
        { domain = "npc", name = "RUSTYANCHOR_BARMAN" },
        { domain = "npc", name = "RUSTYANCHOR_BARTENDER" }
      },
      spots = {
        {
          range = { origin = { x = 3044, y = 3255, level = 0 }, size = { x = 3, y = 4 } },
          description = "in Port Sarim"
        }
      }
    }
  },
  {
    id = 108,
    type = "simple",
    tier = "easy",
    text = { "Search the crates in Horvik's armoury." },
    solution = {
      type = "search",
      entity = "Crate",
      entity_configs = { { domain = "loc", name = "FAI_VARROCK_ACTIVE_LARGE_CRATE" } },
      spot = { level = 0, topleft = { x = 3228, y = 3433 }, botright = { x = 3228, y = 3433 } }
    }
  },
  {
    id = 110,
    type = "simple",
    tier = "easy",
    text = { "Search the boxes in the Goblin house near Lumbridge." },
    solution = {
      type = "search",
      entity = "Boxes",
      entity_configs = { { domain = "loc", name = "FAI_LUMBRIDGE_ACTIVE_BOXES" } },
      spot = { level = 0, topleft = { x = 3247, y = 3244 }, botright = { x = 3247, y = 3244 } }
    }
  },
  {
    id = 111,
    type = "simple",
    tier = "easy",
    text = { "Search the drawers in Falador's chainmail shop." },
    solution = {
      type = "search",
      entity = "Drawers",
      entity_configs = {
        { domain = "loc", name = "FAI_FALADOR_DRAWERS" },
        { domain = "loc", name = "FAI_FALADOR_DRAWERS_OPEN" }
      },
      spot = { level = 0, topleft = { x = 2969, y = 3311 }, botright = { x = 2969, y = 3311 } }
    }
  },
  {
    id = 112,
    type = "simple",
    tier = "easy",
    text = { "Search the chests in Al Kharid palace." },
    solution = {
      type = "search",
      entity = "Ornate chest",
      entity_configs = {
        { domain = "loc", name = "DESERT2012_CHEST" },
        { domain = "loc", name = "DESERT2012_CHEST_OPEN" }
      },
      spot = { level = 0, topleft = { x = 3301, y = 3164 }, botright = { x = 3301, y = 3164 } }
    }
  },
  {
    id = 113,
    type = "simple",
    tier = "easy",
    text = { "Search the crates just outside the armour shop in East Ardougne." },
    solution = {
      type = "search",
      entity = "Crate",
      entity_configs = { { domain = "loc", name = "AREA_ARDOUGNE_OUTDOOR_CRATE_STACKED" } },
      spot = { level = 0, topleft = { x = 2654, y = 3299 }, botright = { x = 2654, y = 3299 } }
    }
  },
  {
    id = 115,
    type = "simple",
    tier = "easy",
    text = { "Search the crates in East Ardougne's general store." },
    solution = {
      type = "search",
      entity = "Crate",
      entity_configs = { { domain = "loc", name = "AREA_ARDOUGNE_OUTDOOR_CRATE" } },
      spot = { level = 0, topleft = { x = 2615, y = 3291 }, botright = { x = 2615, y = 3291 } }
    }
  },
  {
    id = 116,
    type = "simple",
    tier = "easy",
    text = { "Speak to Ellis in Al Kharid." },
    solution = {
      type = "talkto",
      npc = "Ellis",
      npc_configs = { { domain = "npc", name = "ELLIS_TANNER" } },
      spots = {
        {
          range = { origin = { x = 3270, y = 3193, level = 0 }, size = { x = 7, y = 6 } },
          description = "in Al Kharid"
        }
      }
    }
  },
  {
    id = 117,
    type = "simple",
    tier = "easy",
    text = { "Search the chest in the left-hand tower of Camelot Castle." },
    solution = {
      type = "search",
      entity = "Closed Chest",
      entity_configs = {
        { domain = "loc", name = "KR_CAMELOT_CHESTCLOSED" },
        { domain = "loc", name = "KR_CAMELOT_CHESTOPEN" }
      },
      spot = { level = 2, topleft = { x = 2748, y = 3495 }, botright = { x = 2748, y = 3495 } }
    }
  },
  {
    id = 118,
    type = "simple",
    tier = "easy",
    text = { "Search the chest in the Duke of Lumbridge's bedroom." },
    solution = {
      type = "search",
      entity = "Closed Chest",
      entity_configs = {
        { domain = "loc", name = "FAI_LUMBRIDGE_CHEST_CLOSED2" },
        { domain = "loc", name = "FAI_LUMBRIDGE_CHEST_OPEN2" }
      },
      spot = { level = 1, topleft = { x = 3209, y = 3218 }, botright = { x = 3209, y = 3218 } }
    }
  },
  {
    id = 119,
    type = "simple",
    tier = "easy",
    text = { "Search the crates near the Lumbridge Market." },
    solution = {
      type = "search",
      entity = "Crates",
      entity_configs = { { domain = "loc", name = "COMBAT_ACAD_STACKED_CRATES_VAR1" } },
      spot = { level = 0, topleft = { x = 3191, y = 3257 }, botright = { x = 3192, y = 3257 } }
    }
  },
  {
    id = 121,
    type = "simple",
    tier = "easy",
    text = { "Speak to Doric, who lives north of Falador." },
    solution = {
      type = "talkto",
      npc = "Doric",
      npc_configs = { { domain = "npc", name = "DORIC" } },
      spots = {
        {
          range = { origin = { x = 2955, y = 3435, level = 0 }, size = { x = 9, y = 9 } },
          description = "north of Falador"
        }
      }
    }
  },
  {
    id = 123,
    type = "simple",
    tier = "easy",
    text = { "Search the drawers upstairs in the bank to the East of Varrock." },
    solution = {
      type = "search",
      entity = "Drawers",
      entity_configs = {
        { domain = "loc", name = "FAI_VARROCK_DRAWERS" },
        { domain = "loc", name = "FAI_VARROCK_DRAWERS_OPEN" }
      },
      spot = { level = 1, topleft = { x = 3250, y = 3420 }, botright = { x = 3250, y = 3420 } }
    }
  },
  {
    id = 124,
    type = "simple",
    tier = "easy",
    text = { "Talk to Zeke in Al Kharid." },
    solution = {
      type = "talkto",
      npc = "Zeke",
      npc_configs = { { domain = "npc", name = "ZEKE" } },
      spots = {
        {
          range = { origin = { x = 3284, y = 3186, level = 0 }, size = { x = 6, y = 7 } },
          description = "in Al Kharid"
        }
      }
    }
  },
  {
    id = 125,
    type = "simple",
    tier = "easy",
    text = { "Speak to the bartender of the Blue Moon Inn in Varrock." },
    solution = {
      type = "talkto",
      npc = "Bartender",
      npc_configs = { { domain = "npc", name = "BLUEMOON_BARTENDER" } },
      spots = {
        {
          range = { origin = { x = 3223, y = 3396, level = 0 }, size = { x = 4, y = 7 } },
          description = "in the Blue Moon Inn"
        }
      }
    }
  },
  {
    id = 126,
    type = "simple",
    tier = "easy",
    text = { "Search the crate in the southern tower at the entrance to Lumbridge Castle." },
    solution = {
      type = "search",
      entity = "Crate",
      entity_configs = { { domain = "loc", name = "FAI_LUMBRIDGE_ACTIVE_CRATE_STACKED" } },
      spot = { level = 1, topleft = { x = 3228, y = 3212 }, botright = { x = 3228, y = 3212 } }
    }
  },
  {
    id = 127,
    type = "simple",
    tier = "easy",
    text = { "Search the drawers in one of Gertrude's bedrooms." },
    solution = {
      type = "search",
      entity = "Drawers",
      entity_configs = {
        { domain = "loc", name = "FAI_VARROCK_DRAWERS" },
        { domain = "loc", name = "FAI_VARROCK_DRAWERS_OPEN" }
      },
      spot = { level = 0, topleft = { x = 3156, y = 3406 }, botright = { x = 3156, y = 3406 } }
    }
  },
  {
    id = 130,
    type = "simple",
    tier = "easy",
    text = { "Search the drawers in Catherby's Archery Shop." },
    solution = {
      type = "search",
      entity = "Drawers",
      entity_configs = {
        { domain = "loc", name = "FAI_FALADOR_DRAWERS" },
        { domain = "loc", name = "FAI_FALADOR_DRAWERS_OPEN" }
      },
      spot = { level = 0, topleft = { x = 2828, y = 3457 }, botright = { x = 2828, y = 3457 } }
    }
  },
  {
    id = 131,
    type = "simple",
    tier = "easy",
    text = { "Search the drawers upstairs in Falador's shield shop." },
    solution = {
      type = "search",
      entity = "Drawers",
      entity_configs = {
        { domain = "loc", name = "FAI_FALADOR_DRAWERS" },
        { domain = "loc", name = "FAI_FALADOR_DRAWERS_OPEN" }
      },
      spot = { level = 1, topleft = { x = 2971, y = 3386 }, botright = { x = 2971, y = 3386 } }
    }
  },
  {
    id = 132,
    type = "simple",
    tier = "easy",
    text = { "Talk to one of the squires in the White Knights' castle in Falador." },
    solution = {
      type = "talkto",
      npc = "Squire Asrol",
      npc_configs = { { domain = "npc", name = "SQUIRE" } },
      spots = {
        {
          range = { origin = { x = 2970, y = 3339, level = 0 }, size = { x = 8, y = 8 } },
          description = "in the couryard of the White Knight's castle"
        }
      }
    }
  },
  {
    id = 133,
    type = "simple",
    tier = "easy",
    text = { "Search the crates of Falador's general store." },
    solution = {
      type = "search",
      entity = "Crate",
      entity_configs = { { domain = "loc", name = "FAI_FALADOR_SMALL_CRATES" } },
      spot = { level = 0, topleft = { x = 2955, y = 3390 }, botright = { x = 2955, y = 3390 } }
    }
  },
  {
    id = 134,
    type = "simple",
    tier = "easy",
    text = { "Search the crates in the Barbarian Village helmet shop." },
    solution = {
      type = "search",
      entity = "Crate",
      entity_configs = { { domain = "loc", name = "FAI_BARBARIAN_SMALL_CRATES" } },
      spot = { level = 0, topleft = { x = 3073, y = 3430 }, botright = { x = 3073, y = 3430 } }
    }
  },
  {
    id = 135,
    type = "simple",
    tier = "easy",
    text = { "Search the crates in the Port Sarim fishing shop." },
    solution = {
      type = "search",
      entity = "Crate",
      entity_configs = { { domain = "loc", name = "FAI_PORTSARIM_CRATE2" } },
      spot = { level = 0, topleft = { x = 3012, y = 3222 }, botright = { x = 3012, y = 3222 } }
    }
  },
  {
    id = 136,
    type = "simple",
    tier = "easy",
    text = { "Speak to Sir Kay in Camelot Castle." },
    solution = {
      type = "talkto",
      npc = "Sir Kay",
      npc_configs = { { domain = "npc", name = "SIR_KAY" } },
      spots = {
        {
          range = { origin = { x = 2752, y = 3493, level = 0 }, size = { x = 13, y = 11 } },
          description = "in the courtyard of Camelot Castle"
        }
      }
    }
  },
  {
    id = 137,
    type = "simple",
    tier = "easy",
    text = { "Speak to Ned in Draynor Village." },
    solution = {
      type = "talkto",
      npc = "Ned",
      npc_configs = { { domain = "npc", name = "NED" } },
      spots = {
        {
          range = { origin = { x = 3097, y = 3255, level = 0 }, size = { x = 6, y = 6 } },
          description = "in Draynor"
        }
      }
    }
  },
  {
    id = 138,
    type = "simple",
    tier = "easy",
    text = { "Speak to the Challenge Mistress in Burthorpe." },
    solution = {
      type = "talkto",
      npc = "Challenge Mistress Fara",
      npc_configs = { { domain = "npc", name = "CHALLENGE_MASTER" } },
      spots = {
        {
          range = { origin = { x = 2883, y = 3533, level = 0 } },
          description = "in Burthorpe"
        }
      }
    }
  },
  {
    id = 94,
    type = "simple",
    tier = "medium",
    text = { "Speak to Donovan, the family handyman." },
    solution = {
      type = "talkto",
      spots = {
        {
          range = { origin = { x = 2740, y = 3577, level = 1 }, size = { x = 5, y = 6 } },
          description = "at Sinclair Mansion"
        }
      },
      npc = "Donovan the Family Handyman",
      npc_configs = { { domain = "npc", name = "DONOVAN_THE_FAMILY_HANDYMAN" } }
    }
  },
  {
    id = 97,
    type = "simple",
    tier = "medium",
    text = { "Speak to Brimstail." },
    challenge = {
      {
        type = "challengescroll",
        question = "What is 19 to the power of 3?",
        answers = { { answer = 6859 } }
      }
    },
    solution = {
      type = "talkto",
      spots = {
        {
          range = { origin = { x = 2405, y = 9815, level = 0 }, size = { x = 9, y = 8 } },
          description = "in Brimstail's cave"
        }
      },
      npc = "Brimstail",
      npc_configs = { { domain = "npc", name = "GNOME_BRIMSTAIL" } }
    }
  },
  {
    id = 98,
    type = "simple",
    tier = "medium",
    text = { "Speak to Roavar." },
    solution = {
      type = "talkto",
      npc = "Roavar",
      npc_configs = { { domain = "npc", name = "WEREWOLFINNKEEPER" } },
      spots = {
        {
          range = { origin = { x = 3489, y = 3471, level = 0 }, size = { x = 7, y = 5 } },
          description = "in Canifis' bar"
        }
      }
    }
  },
  {
    id = 109,
    type = "simple",
    tier = "medium",
    text = { "Speak to Ulizius." },
    solution = {
      type = "talkto",
      npc = "Ulizius",
      npc_configs = { { domain = "npc", name = "MORT_MYRE_GATE_GUARD" } },
      spots = {
        {
          range = { origin = { x = 3440, y = 3458, level = 0 }, size = { x = 7, y = 7 } },
          description = "near the Swamp Gate"
        }
      }
    }
  },
  {
    id = 114,
    type = "simple",
    tier = "medium",
    text = { "Speak to Hajedy." },
    solution = {
      type = "talkto",
      npc = "Hajedy",
      npc_configs = { { domain = "npc", name = "BRIMHAVENCARTDRIVER" } },
      spots = {
        {
          range = { origin = { x = 2779, y = 3210, level = 0 }, size = { x = 4, y = 4 } },
          description = "in Brimhaven"
        }
      }
    }
  },
  {
    id = 120,
    type = "simple",
    tier = "medium",
    text = { "Speak to Kangai Mau." },
    solution = {
      type = "talkto",
      npc = "Kangai Mau",
      npc_configs = { { domain = "npc", name = "KANGAI_MAU" } },
      spots = {
        {
          range = { origin = { x = 2790, y = 3181, level = 0 }, size = { x = 6, y = 5 } },
          description = "in Brimhaven"
        }
      }
    }
  },
  {
    id = 122,
    type = "simple",
    tier = "medium",
    text = { "Speak to a referee." },
    challenge = {
      {
        type = "challengescroll",
        question = "What is 57 x 89 + 23?",
        answers = { { answer = 5096 } }
      }
    },
    solution = {
      type = "talkto",
      npc = "Gnome ball referee",
      npc_configs = { { domain = "npc", name = "GNOMEREFEREE" } },
      spots = {
        {
          range = { origin = { x = 2385, y = 3488, level = 0 } },
          description = "at the gate of the Gnomeball Field"
        }
      }
    }
  },
  {
    id = 128,
    type = "simple",
    tier = "medium",
    text = { "Speak to Hazelmere." },
    challenge = {
      {
        type = "challengescroll",
        question = "What is 19 to the power of 3?",
        answers = { { answer = 6859 } }
      }
    },
    solution = {
      type = "talkto",
      npc = "Hazelmere",
      npc_configs = { { domain = "npc", name = "GRANDTREE_HAZELMERE" } },
      spots = {
        {
          range = { origin = { x = 2675, y = 3085, level = 1 }, size = { x = 5, y = 5 } },
          description = "east of Yanille"
        }
      }
    }
  },
  {
    id = 129,
    type = "simple",
    tier = "easy",
    text = { "Search a barrel upstairs in one of Wendlewick's farmhouses." },
    solution = {
      type = "search",
      entity = "Barrel",
      entity_configs = { { domain = "loc", name = "WENDLE_BARREL_POOR_LARGE" } },
      spot = { topleft = { x = 3531, y = 1483 }, botright = { x = 3532, y = 1483 }, level = 1 }
    }
  },
  {
    id = 179,
    type = "cryptic",
    tier = "easy",
    text = {
      "A crate found in the tower of a church is your next location.",
      "A crate in the tower of a church is your next location."
    },
    solution = {
      type = "search",
      entity = "Crate",
      entity_configs = { { domain = "loc", name = "AREA_ARDOUGNE_OUTDOOR_CRATE" } },
      spot = { level = 1, topleft = { x = 2612, y = 3306 }, botright = { x = 2612, y = 3306 } }
    }
  },
  {
    id = 180,
    type = "cryptic",
    tier = "easy",
    text = { "One of the sailors in Port Sarim is your next destination." },
    solution = {
      type = "talkto",
      npc = "Captain Tobias",
      npc_configs = { { domain = "npc", name = "CAPTAIN_TOBIAS" } },
      spots = {
        {
          range = { origin = { x = 3027, y = 3216, level = 0 }, size = { x = 2, y = 3 } },
          description = "at Port Sarim"
        }
      }
    }
  },
  {
    id = 182,
    type = "cryptic",
    tier = "easy",
    text = { "Someone watching Het's Oasis is your next destination." },
    solution = {
      type = "talkto",
      spots = {
        {
          range = { origin = { x = 3371, y = 3271, level = 0 }, size = { x = 8, y = 8 } },
          description = "north of Het's Oasis"
        }
      },
      npc = "Jeed",
      npc_configs = { { domain = "npc", name = "DUEL_CROWDFEMALE3" } }
    }
  },
  {
    id = 181,
    type = "cryptic",
    tier = "medium",
    text = {
      "You'll need to look for a city with a central fountain. Look for a locked chest in the city's chapel."
    },
    solution = {
      type = "search",
      spot = { level = 0, topleft = { x = 3256, y = 3487 }, botright = { x = 3256, y = 3487 } },
      entity = "Closed Chest",
      entity_configs = {
        { domain = "loc", name = "FAI_VARROCK_CHEST_CLOSED" },
        { domain = "loc", name = "FAI_VARROCK_CHEST_OPEN" }
      },
      key = {
        instructions = "The chest is locked! An inscription on the chest says: Property of Clock Tower Monastery.",
        answer = "Kill a monk in the Kandarin Monastery.",
        area = { origin = { x = 2591, y = 3204, level = 0 }, size = { x = 31, y = 15 } }
      }
    }
  },
  {
    id = 183,
    type = "cryptic",
    tier = "medium",
    text = {
      "The socks in these drawers are holier than thine, according to the tonsured owners."
    },
    solution = {
      type = "search",
      entity = "Drawers",
      entity_configs = {
        { domain = "loc", name = "ICEMT_MONASTERY_DRAWERS1" },
        { domain = "loc", name = "ICEMT_MONASTERY_DRAWERS1OPEN" }
      },
      spot = { level = 0, topleft = { x = 3056, y = 3497 }, botright = { x = 3056, y = 3497 } },
      key = {
        instructions =
        "The chest has a crude note on top. It reads 'You'll never get these drawers open now! - Zamorak Monk.'",
        answer = "Kill a Monk of Zamorak in the Chaos Temple near the Goblin Village.",
        area = { origin = { x = 2946, y = 3473, level = 0 }, size = { x = 9, y = 6 } }
      }
    }
  },
  {
    id = 184,
    type = "cryptic",
    tier = "medium",
    text = { "Probably filled with wizards' socks." },
    solution = {
      type = "search",
      entity = "Cupboard",
      entity_configs = { { domain = "loc", name = "WIZTOWER2012_CUPBOARD_VAR2" } },
      spot = { level = 2, topleft = { x = 3113, y = 3153 }, botright = { x = 3113, y = 3153 } },
      key = {
        instructions = "This cupboard is locked! One of the Spellwisps might have stolen the key. ",
        answer = "Kill a Spellwisp north west of the tower.",
        area = { origin = { x = 3066, y = 3168, level = 0 }, size = { x = 16, y = 16 } }
      }
    }
  },
  {
    id = 185,
    type = "cryptic",
    tier = "medium",
    text = { "In a village made of bamboo, look for some crates under one of the houses." },
    solution = {
      type = "search",
      entity = "Crate",
      entity_configs = { { domain = "loc", name = "ACTIVE_CRATE_OLD" } },
      spot = { level = 0, topleft = { x = 2800, y = 3074 }, botright = { x = 2800, y = 3074 } }
    }
  },
  {
    id = 186,
    type = "cryptic",
    tier = "medium",
    text = { "The owner of this crate has a hunch that he put more than fish inside." },
    solution = {
      type = "search",
      entity = "Crate",
      entity_configs = { { domain = "loc", name = "ACTIVE_CRATE" } },
      spot = { level = 0, topleft = { x = 2770, y = 3172 }, botright = { x = 2770, y = 3172 } }
    }
  },
  {
    id = 187,
    type = "cryptic",
    tier = "medium",
    text = {
      "In a town where the guards are armed with maces, search the upstairs rooms of the public house."
    },
    solution = {
      type = "search",
      spot = { level = 1, topleft = { x = 2575, y = 3326 }, botright = { x = 2575, y = 3326 } },
      entity = "Drawers",
      entity_configs = {
        { domain = "loc", name = "AREA_ARDOUGNE_BASIC_DRAWERS" },
        { domain = "loc", name = "AREA_ARDOUGNE_BASIC_DRAWERS_OPEN" }
      },
      key = {
        instructions = "The drawers are locked! A note left on the drawers reads: Beware of dog!",
        answer = "Kill a guard dog.",
        area = { origin = { x = 2623, y = 3307, level = 0 }, size = { x = 25, y = 24 } }
      }
    }
  },
  {
    id = 188,
    type = "cryptic",
    tier = "medium",
    text = { "Try not to step on any aquatic nasties while searching this crate." },
    solution = {
      type = "search",
      entity = "Crate",
      entity_configs = { { domain = "loc", name = "SLUG2_CRATE_SINGLE" } },
      spot = { level = 0, topleft = { x = 2764, y = 3273 }, botright = { x = 2764, y = 3273 } }
    }
  },
  {
    id = 189,
    type = "cryptic",
    tier = "medium",
    text = {
      "After a hard day of spraying back the vegetation, you mite want to pop to the nearby forge and search the crates."
    },
    solution = {
      type = "search",
      entity = "Crate",
      entity_configs = { { domain = "loc", name = "FAIRYKIT_CRATES" } },
      spot = { level = 0, topleft = { x = 2399, y = 4471 }, botright = { x = 2399, y = 4471 } }
    }
  },
  {
    id = 190,
    type = "cryptic",
    tier = "medium",
    text = {
      "For any aspiring mage, I'm sure searching this bookcase will be a rewarding experience."
    },
    solution = {
      type = "search",
      entity = "Old Bookshelf",
      entity_configs = { { domain = "loc", name = "MAGICTRAINING_BOOKSHELF_OLD_TALL_DOUBLE2" } },
      spot = { level = 1, topleft = { x = 3366, y = 3319 }, botright = { x = 3366, y = 3319 } }
    }
  },
  {
    id = 191,
    type = "cryptic",
    tier = "medium",
    text = {
      "A town with a different sort of night-life is your destination. Search for some crates in one of the houses."
    },
    solution = {
      type = "search",
      entity = "Crate",
      entity_configs = { { domain = "loc", name = "CANAFIS_CRATE" } },
      spot = { level = 0, topleft = { x = 3498, y = 3507 }, botright = { x = 3498, y = 3507 } }
    }
  },
  {
    id = 192,
    type = "cryptic",
    tier = "medium",
    text = {
      "Hay! Stop for a bit and admire the scenery, just like the tourism promoter says."
    },
    solution = {
      type = "search",
      entity = "Hay bales",
      entity_configs = { { domain = "loc", name = "HAYSTACK2" } },
      spot = { level = 0, topleft = { x = 2524, y = 3438 }, botright = { x = 2524, y = 3438 } }
    }
  },
  {
    id = 193,
    type = "cryptic",
    tier = "medium",
    text = {
      "North of the best monkey restaurant on Karamja, look for the centre of the triangle of boats and search there."
    },
    solution = {
      type = "search",
      entity = "Crate",
      entity_configs = { { domain = "loc", name = "DEAL_CRATE2" } },
      spot = { level = 0, topleft = { x = 2905, y = 3189 }, botright = { x = 2905, y = 3189 } }
    }
  },
  {
    id = 194,
    type = "cryptic",
    tier = "medium",
    text = {
      "Go to the village being attacked by trolls and search the drawers in one of the houses."
    },
    solution = {
      type = "search",
      spot = { level = 0, topleft = { x = 2928, y = 3552 }, botright = { x = 2928, y = 3552 } },
      entity = "Drawers",
      entity_configs = {
        { domain = "loc", name = "OMGE_BURTHORPE_HOUSE_DRAWERS_CLOSED" },
        { domain = "loc", name = "OMGE_BURTHORPE_HOUSE_DRAWERS_OPEN" }
      },
      key = {
        instructions =
        "The drawers are locked! A note on the top of the drawer reads: Wait till I get my hands on Penda; he's nicked the key again!",
        answer = "Pickpocket Penda in the house north of Heroes's Guild.",
        area = { origin = { x = 2912, y = 3521, level = 0 }, size = { x = 5, y = 6 } }
      }
    }
  },
  {
    id = 195,
    type = "cryptic",
    tier = "medium",
    text = {
      "In a town where everyone has perfect vision, seek some locked drawers in a house that sits opposite a workshop."
    },
    solution = {
      type = "search",
      entity = "Drawers",
      entity_configs = {
        { domain = "loc", name = "KR_SEERS_VILLAGE_DRAWERS1" },
        { domain = "loc", name = "KR_SEERS_VILLAGE_DRAWERS1OPEN" }
      },
      spot = { level = 0, topleft = { x = 2709, y = 3478 }, botright = { x = 2709, y = 3478 } },
      key = {
        instructions = "Don't forget to feed the chickens",
        answer = "Kill a chicken.",
        area = { origin = { x = 2729, y = 3555, level = 0 }, size = { x = 11, y = 10 } }
      }
    }
  },
  {
    id = 196,
    type = "cryptic",
    tier = "medium",
    text = {
      "Being this far north has meant that these crates have escaped being battled over."
    },
    solution = {
      type = "search",
      spot = { level = 0, topleft = { x = 2519, y = 3259 }, botright = { x = 2519, y = 3259 } },
      entity = "Crates",
      entity_configs = { { domain = "loc", name = "LUC2_BF_CRATE" } }
    }
  },
  {
    id = 197,
    type = "cryptic",
    tier = "medium",
    text = {
      "After trawling for bars, go to the nearest place to smith them and dig by the door."
    },
    solution = {
      type = "dig",
      spot = { x = 2656, y = 3161, level = 0 },
      description = "in front of the door"
    }
  },
  {
    id = 198,
    type = "cryptic",
    tier = "medium",
    text = { "Sophind yourself some treasure by searching these boxes." },
    solution = {
      type = "search",
      spot = { level = 0, topleft = { x = 3280, y = 2787 }, botright = { x = 3280, y = 2787 } },
      entity = "Crate",
      entity_configs = { { domain = "loc", name = "MENAPHOS_WORKER_CRATE_01_CLUE" } }
    }
  },
  {
    id = 199,
    type = "cryptic",
    tier = "medium",
    text = {
      "Dig here if you are not feeling too well after travelling through the desert. Ali heartily recommends it."
    },
    solution = {
      type = "dig",
      spot = { x = 3358, y = 2971, level = 0 },
      description = "next to the well"
    }
  },
  {
    id = 200,
    type = "cryptic",
    tier = "medium",
    text = { "You'll need to have Doug Deep into the distant past to get to these sacks" },
    solution = {
      type = "search",
      spot = { level = 0, topleft = { x = 3155, y = 5727 }, botright = { x = 3155, y = 5727 } },
      entity = "Sacks",
      entity_configs = { { domain = "loc", name = "DI2_SACKS" } }
    }
  },
  {
    id = 201,
    type = "cryptic",
    tier = "medium",
    text = { "This crate holds a better reward than a broken arrow." },
    solution = {
      type = "search",
      spot = { level = 0, topleft = { x = 2671, y = 3437 }, botright = { x = 2671, y = 3437 } },
      entity = "Crate",
      entity_configs = { { domain = "loc", name = "ACTIVE_CRATE_OLD" } }
    }
  },
  {
    id = 202,
    type = "cryptic",
    tier = "medium",
    text = {
      "The rock cakes to the south are definitely more edible than the two rocks I buried the treasure between."
    },
    solution = {
      type = "dig",
      spot = { x = 2513, y = 3041, level = 0 },
      description = "between the rocks"
    }
  },
  {
    id = 203,
    type = "cryptic",
    tier = "medium",
    text = {
      "Search the upstairs drawers of a house in a village where pirates are known to have a good time."
    },
    solution = {
      type = "search",
      spot = { level = 1, topleft = { x = 2809, y = 3165 }, botright = { x = 2809, y = 3165 } },
      entity = "Drawers",
      entity_configs = {
        { domain = "loc", name = "DRAWERS1" },
        { domain = "loc", name = "DRAWERS1OPEN" }
      },
      key = {
        instructions = "Shiver me timbers!",
        answer = "Kill a pirate in Brimhaven",
        area = { origin = { x = 2766, y = 3167, level = 0 }, size = { x = 45, y = 35 } }
      }
    }
  },
  {
    id = 204,
    type = "cryptic",
    tier = "medium",
    text = {
      "Don't skip here, it's too muddy. You'll feel like a star if you dig here, though."
    },
    solution = {
      type = "dig",
      spot = { x = 3000, y = 3110, level = 0 },
      description = "on top of the starfish"
    }
  },
  {
    id = 205,
    type = "cryptic",
    tier = "medium",
    text = { "This crate is mine, all mine, even if it is in the middle of the desert." },
    solution = {
      type = "search",
      entity = "Crate",
      entity_configs = { { domain = "loc", name = "TOURTRAP_QIP_CRATE_SINGLE" } },
      spot = { level = 0, topleft = { x = 3289, y = 3022 }, botright = { x = 3289, y = 3022 } }
    }
  },
  {
    id = 206,
    type = "cryptic",
    tier = "medium",
    text = {
      "The treasure is buried in a small building full of bones. Here's a Hint: It's not near a graveyard."
    },
    solution = {
      type = "dig",
      spot = { x = 3356, y = 3507, level = 0 },
      description = "in the western shed"
    }
  },
  {
    id = 207,
    type = "cryptic",
    tier = "medium",
    text = {
      "By the town of the dead, walk south down a rickety bridge, then dig near the spotted fungus."
    },
    solution = {
      type = "dig",
      spot = { x = 3644, y = 3494, level = 0 },
      description = "next to the mushroom"
    }
  },
  {
    id = 208,
    type = "cryptic",
    tier = "medium",
    text = { "This cupboard has treasure, pirate pots and corsair cutlery!" },
    solution = {
      type = "search",
      entity = "Cupboard",
      entity_configs = {
        { domain = "loc", name = "CUPBOARD_GLOFFSET" },
        { domain = "loc", name = "CUPBOARDOPEN_GLOFFSET" }
      },
      spot = { level = 0, topleft = { x = 2811, y = 3160 }, botright = { x = 2811, y = 3160 } }
    }
  },
  {
    id = 209,
    type = "cryptic",
    tier = "medium",
    text = { "The dead, red dragon watches over this chest. He must really dig the view." },
    solution = {
      type = "search",
      spot = { level = 0, topleft = { x = 3354, y = 3349 }, botright = { x = 3354, y = 3349 } },
      entity = "Closed chest",
      entity_configs = {
        { domain = "loc", name = "CHESTCLOSED" },
        { domain = "loc", name = "CHESTOPEN" }
      },
      key = {
        instructions = "The chest is locked!  Crude graffiti on the chest reads: 'Barbarians rule, okay!'",
        answer = "Kill a Barbarian in Barbarian Village.",
        area = { origin = { x = 3073, y = 3412, level = 0 }, size = { x = 22, y = 23 } }
      }
    }
  },
  {
    id = 210,
    type = "cryptic",
    tier = "medium",
    text = { "This crate clearly marks the end of the line for coal." },
    solution = {
      type = "search",
      spot = { level = 0, topleft = { x = 2691, y = 3508 }, botright = { x = 2691, y = 3508 } },
      entity = "Crate",
      entity_configs = { { domain = "loc", name = "ACTIVE_CRATE2_OLD" } }
    }
  },
  {
    id = 211,
    type = "cryptic",
    tier = "medium",
    text = {
      "Go to this building to be illuminated, and check the drawers while you are there."
    },
    solution = {
      type = "search",
      spot = { level = 1, topleft = { x = 2512, y = 3641 }, botright = { x = 2512, y = 3641 } },
      entity = "Drawers",
      entity_configs = {
        { domain = "loc", name = "DRAWERS2" },
        { domain = "loc", name = "DRAWERS2OPEN" }
      },
      key = {
        instructions = "The drawers are locked! A note on the top says 'I'm guarding the key at the market'.",
        answer = "Kill a Fremennik market guard in Relekka.",
        area = { origin = { x = 2635, y = 3669, level = 0 }, size = { x = 18, y = 18 } }
      }
    }
  },
  {
    id = 212,
    type = "cryptic",
    tier = "medium",
    text = { "Find a crate close to the monks that like to paaarty!" },
    solution = {
      type = "search",
      spot = { level = 0, topleft = { x = 2614, y = 3204 }, botright = { x = 2614, y = 3204 } },
      entity = "Crate",
      entity_configs = { { domain = "loc", name = "ACTIVE_CRATE2" } }
    }
  },
  {
    id = 213,
    type = "cryptic",
    tier = "medium",
    text = {
      "In a town where wizards are known to gather, search upstairs in a large house to the north."
    },
    solution = {
      type = "search",
      entity = "Closed chest",
      entity_configs = {
        { domain = "loc", name = "CHESTCLOSED" },
        { domain = "loc", name = "CHESTOPEN" }
      },
      spot = { level = 1, topleft = { x = 2593, y = 3108 }, botright = { x = 2593, y = 3108 } },
      key = {
        instructions = "Stand by your man.",
        answer = "Kill the man downstairs.",
        area = { origin = { x = 2590, y = 3103, level = 0 }, size = { x = 9, y = 6 } }
      }
    }
  },
  {
    id = 214,
    type = "cryptic",
    tier = "medium",
    text = {
      "This temple is rather sluggish. The chest just inside the entrance, however, is filled with goodies."
    },
    solution = {
      type = "search",
      spot = { level = 0, topleft = { x = 2698, y = 9684 }, botright = { x = 2698, y = 9684 } },
      entity = "Chest",
      entity_configs = {
        { domain = "loc", name = "SLUG2_CHEST" },
        { domain = "loc", name = "SLUG2_CHEST_OPEN" }
      }
    }
  },
  {
    id = 215,
    type = "cryptic",
    tier = "medium",
    text = {
      "The gnomes' nearby cart must have collapsed under the weight of all the treasure in these boxes!"
    },
    solution = {
      type = "search",
      spot = { level = 0, topleft = { x = 2397, y = 3355 }, botright = { x = 2397, y = 3355 } },
      entity = "Gnome crates",
      entity_configs = { { domain = "loc", name = "ACTIVE_ALUFT_GNOME_CRATES" } }
    }
  },
  {
    id = 217,
    type = "cryptic",
    tier = "medium",
    text = {
      "Brush off the sand and dig in the quarry. There is a wheely handy barrow to the east. Don't worry, it's coal to dig there - in fact, it's all oclay."
    },
    solution = {
      type = "dig",
      spot = { x = 3175, y = 2915, level = 0 },
      description = "west of the cart"
    }
  },
  {
    id = 218,
    type = "cryptic",
    tier = "medium",
    text = {
      "Observe: In the crate just North of the stairs leading down, you will find the answer."
    },
    solution = {
      type = "search",
      spot = { level = 0, topleft = { x = 2438, y = 3165 }, botright = { x = 2438, y = 3165 } },
      entity = "Crate",
      entity_configs = { { domain = "loc", name = "WOLF_DRUID_LARGE_CRATE" } }
    }
  },
  {
    id = 220,
    type = "cryptic",
    tier = "medium",
    text = {
      "In a town where thieves steal from stalls, search for some drawers in the upstairs of a house near the bank."
    },
    solution = {
      type = "search",
      spot = { level = 1, topleft = { x = 2610, y = 3324 }, botright = { x = 2610, y = 3324 } },
      entity = "Drawers",
      entity_configs = {
        { domain = "loc", name = "AREA_ARDOUGNE_BASIC_DRAWERS" },
        { domain = "loc", name = "AREA_ARDOUGNE_BASIC_DRAWERS_OPEN" }
      },
      key = { instructions = "It's a guard's life", answer = "Kill an ardougne guard." }
    }
  },
  {
    id = 222,
    type = "cryptic",
    tier = "medium",
    text = {
      "While a sea view is nice, it seems this church has not seen visitors in a while. Dig outside the rim of the round window for a reward."
    },
    solution = {
      type = "dig",
      spot = { x = 2993, y = 3178, level = 0 },
      description = "west of the church near Port Sarim"
    }
  },
  {
    id = 28,
    type = "cryptic",
    tier = "hard",
    text = {
      "Covered in shadows, the centre of the circle is where you will find the answer."
    },
    solution = {
      type = "dig",
      spot = { x = 3488, y = 3287, level = 0 },
      description = "at the centre of Mort'ton"
    }
  },
  {
    id = 30,
    type = "cryptic",
    tier = "hard",
    text = { "Generally speaking, his nose was very bent" },
    solution = {
      type = "talkto",
      npc = "General Bentnoze",
      npc_configs = { { domain = "npc", name = "GENERAL_BENTNOZE_RED" } },
      spots = {
        {
          range = { origin = { x = 2954, y = 3512, level = 0 }, size = { x = 7, y = 4 } },
          description = "in Goblin Village"
        }
      }
    },
    challenge = { { type = "slider" } }
  },
  {
    id = 32,
    type = "cryptic",
    tier = "hard",
    text = {
      "If you look closely enough, it seems that the archers have lost more than their needles."
    },
    solution = {
      type = "search",
      entity = "Haystack",
      entity_configs = { { domain = "loc", name = "HAYSTACK3" } },
      spot = { level = 0, topleft = { x = 2671, y = 3416 }, botright = { x = 2671, y = 3416 } }
    }
  },
  {
    id = 39,
    type = "cryptic",
    tier = "hard",
    text = { "There is no 'worthier' lord." },
    challenge = { { type = "slider" } },
    solution = {
      type = "talkto",
      spots = {
        {
          id = "default",
          range = { origin = { x = 2186, y = 3284, level = 1 } },
          note = "After 'Plague's End'",
          description = "in Prifddinas"
        },
        {
          id = "after-plagues-end",
          range = { origin = { x = 2198, y = 3247, level = 0 }, size = { x = 12, y = 12 } },
          note = "Before 'Plague's End'",
          description = "at Iorwerth Camp"
        }
      },
      npc = "Lord Iorwerth",
      npc_configs = {
        { domain = "npc", name = "LORD_IORWERTH_VIS" },
        { domain = "npc", name = "ELFCITY_LORD_IORWERTH" },
        { domain = "npc", name = "LORD_IORWERTH" }
      }
    }
  },
  {
    id = 139,
    type = "cryptic",
    tier = "hard",
    text = {
      "I am head of the abbey with a cold breeze from the west.",
      "'A bag belt only?' he asked his balding brothers"
    },
    solution = {
      type = "talkto",
      spots = {
        {
          range = {
            origin = { x = 3055, y = 3482, level = 0 },
            size = { x = 5, y = 6 },
            data = "73+MMQ=="
          },
          description = "at the Edgeville Monastery"
        }
      },
      npc = "Abbot Langley",
      npc_configs = { { domain = "npc", name = "ABBOT_LANGLEY" } }
    }
  },
  {
    id = 140,
    type = "cryptic",
    tier = "hard",
    text = {
      "My name's a tirade, fishing is my trade, by the docks is where my fortune is made.",
      "If a man carried my burden, he would break his back. I am not rich, but leave silver in my track. Speak to the keeper of my trail."
    },
    solution = {
      type = "talkto",
      spots = {
        {
          range = { origin = { x = 3011, y = 3223, level = 0 }, size = { x = 7, y = 7 } },
          description = "in the fishing shop in Port Sarim"
        }
      },
      npc = "Gerrant",
      npc_configs = {
        { domain = "npc", name = "VKQ2_GERRANT_SICK" },
        { domain = "npc", name = "GERRANT_NPC" },
        { domain = "npc", name = "GERRANT" }
      }
    }
  },
  {
    id = 141,
    type = "cryptic",
    tier = "hard",
    text = {
      "Often sought out by scholars of histories past, find me where words of wisdom speak volumes."
    },
    challenge = { { type = "slider" } },
    solution = {
      type = "talkto",
      npc = "Examiner",
      npc_configs = {
        { domain = "npc", name = "QIP_DIGSITE_EXAMINER_02" },
        { domain = "npc", name = "QIP_DIGSITE_EXAMINER_03" }
      },
      spots = {
        {
          range = { origin = { x = 3351, y = 3342, level = 0 }, size = { x = 9, y = 8 } },
          description = "in the Exam Centre"
        }
      }
    }
  },
  {
    id = 142,
    type = "cryptic",
    tier = "hard",
    text = {
      "A great view: watch the rapidly drying hides get splashed. Check the box you are sitting on."
    },
    solution = {
      type = "search",
      spot = { level = 1, topleft = { x = 2523, y = 3493 }, botright = { x = 2523, y = 3493 } },
      entity = "Boxes",
      entity_configs = { { domain = "loc", name = "ACTIVE_BOXES" } }
    }
  },
  {
    id = 143,
    type = "cryptic",
    tier = "hard",
    text = {
      "You will need to wash the old ash off of your spade when you dig here, but the only water nearby is stagnant."
    },
    solution = {
      type = "dig",
      spot = { x = 2134, y = 5163, level = 0 },
      description = "next to the puddle on top of the mountain on Braindeath Island"
    }
  },
  {
    id = 144,
    type = "cryptic",
    tier = "hard",
    text = { "Identify the back of this over-acting brother. (He's a long way from home.)" },
    challenge = { { type = "slider" } },
    solution = {
      type = "talkto",
      spots = {
        {
          range = { origin = { x = 3131, y = 2800, level = 0 }, size = { x = 5, y = 5 } },
          description = "on the beach in Menaphos Worker District"
        }
      },
      npc = "Hamid",
      npc_configs = { { domain = "npc", name = "DUEL_MONK" } }
    }
  },
  {
    id = 145,
    type = "cryptic",
    tier = "hard",
    text = {
      "As you desert this town, keep an eye out for a set of spines that could ruin nearby rugs: dig carefully around the greenery."
    },
    solution = {
      type = "dig",
      spot = { x = 3396, y = 2918, level = 0 },
      description = "next to the cacti west of Nardaah"
    }
  },
  {
    id = 146,
    type = "cryptic",
    tier = "hard",
    text = { "'Small Shoe.' Often found with rod on mushroom." },
    challenge = { { type = "slider" } },
    solution = {
      type = "talkto",
      spots = {
        {
          range = { origin = { x = 2467, y = 3426, level = 0 }, size = { x = 11, y = 15 } },
          description = "at the Gnome Agility Course"
        }
      },
      npc = "Gnome trainer",
      npc_configs = { { domain = "npc", name = "GNOMETRAINER" } }
    }
  },
  {
    id = 147,
    type = "cryptic",
    tier = "hard",
    text = { "It seems to have reached the end of the line, and it's still empty." },
    solution = {
      type = "search",
      spot = { level = 0, topleft = { x = 3041, y = 9820 }, botright = { x = 3041, y = 9820 } },
      entity = "Mine Cart",
      entity_configs = { { domain = "loc", name = "DWARFROCK_BOOK_CART" } }
    }
  },
  {
    id = 148,
    type = "cryptic",
    tier = "hard",
    text = { "Read 'How to Breed Scorpions' By O.W. Thathurt." },
    solution = {
      type = "search",
      spot = { level = 1, topleft = { x = 2702, y = 3409 }, botright = { x = 2702, y = 3409 } },
      entity = "Bookcase",
      entity_configs = { { domain = "loc", name = "BOOKCASE_OFFSET" } }
    }
  },
  {
    id = 149,
    type = "cryptic",
    tier = "hard",
    text = { "Probably filled with books on magic." },
    solution = {
      type = "search",
      spot = { level = 0, topleft = { x = 3094, y = 3153 }, botright = { x = 3095, y = 3152 } },
      entity = "Bookcase",
      entity_configs = { { domain = "loc", name = "WIZTOWER2012_LIBRARY_BOOKCASE" } }
    }
  },
  {
    id = 150,
    type = "cryptic",
    tier = "hard",
    text = { "Citric cellar." },
    challenge = { { type = "slider" } },
    solution = {
      type = "talkto",
      spots = {
        {
          range = { origin = { x = 2487, y = 3487, level = 1 }, size = { x = 7, y = 3 } },
          description = "in the south-east corner on the first floor of the Grand Tree"
        }
      },
      npc = "Heckel Funch",
      npc_configs = { { domain = "npc", name = "GNOME_HECKELFUNCH" } }
    }
  },
  {
    id = 151,
    type = "cryptic",
    tier = "hard",
    text = {
      "I'm sure they will let ya buy some things here, as long as you are in good 'ealth."
    },
    solution = {
      type = "search",
      spot = { level = 0, topleft = { x = 2340, y = 3187 }, botright = { x = 2340, y = 3187 } },
      entity = "Crate",
      entity_configs = { { domain = "loc", name = "ACTIVE_CRATE2" } }
    }
  },
  {
    id = 152,
    type = "cryptic",
    tier = "hard",
    text = {
      "Mine was the strangest birth under the sun. I left the crimson sack. Yet life had not begun. Entered the world and yet was seen by none."
    },
    solution = {
      type = "dig",
      spot = { x = 2832, y = 9586, level = 0 },
      description = "on top of the Red spider's eggs spawn"
    }
  },
  {
    id = 153,
    type = "cryptic",
    tier = "hard",
    text = { "His head might be hollow, but the crates nearby are filled with surprises." },
    solution = {
      type = "search",
      spot = { level = 0, topleft = { x = 3478, y = 3091 }, botright = { x = 3478, y = 3091 } },
      entity = "Crate",
      entity_configs = { { domain = "loc", name = "ACTIVE_CRATE2" } }
    }
  },
  {
    id = 154,
    type = "cryptic",
    tier = "hard",
    text = {
      "My giant guardians below the market streets would be fans of rock and roll, if only they could grab hold of it. Dig near my purple smoke!"
    },
    solution = {
      type = "dig",
      spot = { x = 3161, y = 9904, level = 0 },
      description = "next to the cauldron"
    }
  },
  {
    id = 155,
    type = "cryptic",
    tier = "hard",
    text = {
      "You can cook food on me, but don't cook any foodles - That would just be wrong."
    },
    solution = {
      type = "dig",
      spot = { x = 2969, y = 2975, level = 0 },
      description = "by the fire next to Captain Klemfoodle"
    }
  },
  {
    id = 156,
    type = "cryptic",
    tier = "hard",
    text = {
      "The beasts to my east snap claws and tails. The rest to my west can slide and eat fish. The force to my north will jump and they'll wail, Come dig by my fire and make a wish."
    },
    solution = {
      type = "dig",
      spot = { x = 2598, y = 3267, level = 0 },
      description = "next to the torch in Ardougne Zoo"
    }
  },
  {
    id = 157,
    type = "cryptic",
    tier = "hard",
    text = {
      "You don't need to go hopping mad - or take steps - to get to this treasure: just be totally shellfish."
    },
    solution = {
      type = "dig",
      spot = { x = 2519, y = 3594, level = 0 },
      description = "on top of the shell"
    }
  },
  {
    id = 158,
    type = "cryptic",
    tier = "hard",
    text = {
      "When you get tired of fighting, go deep, deep down until you need an antidote."
    },
    solution = {
      type = "search",
      spot = { level = 0, topleft = { x = 2576, y = 9583 }, botright = { x = 2576, y = 9583 } },
      entity = "Crate",
      entity_configs = { { domain = "loc", name = "ACTIVE_CRATE2_OLD" } }
    }
  },
  {
    id = 159,
    type = "cryptic",
    tier = "hard",
    text = {
      "'Throat mage seeks companionship. Seek answers inside my furniture if interested.'"
    },
    solution = {
      type = "search",
      entity = "Drawers",
      entity_configs = {
        {
          domain = "loc",
          name = "UNDERWORLD_SURFACE_NECROMANCERS_TOWER_FURNITURE_DRAWERS"
        }
      },
      spot = { level = 1, topleft = { x = 2666, y = 3238 }, botright = { x = 2666, y = 3238 } }
    }
  },
  {
    id = 160,
    type = "cryptic",
    tier = "hard",
    text = { "Must be full of railings" },
    solution = {
      type = "search",
      entity = "Boxes",
      entity_configs = { { domain = "loc", name = "DWARF_KELDAGRIM_WOODEN_BOXES" } },
      spot = { level = 0, topleft = { x = 2576, y = 3464 }, botright = { x = 2576, y = 3464 } }
    }
  },
  {
    id = 161,
    type = "cryptic",
    tier = "hard",
    text = { "You will need to under-cook to solve this one." },
    solution = {
      type = "search",
      entity = "Crate",
      entity_configs = { { domain = "loc", name = "ACTIVE_CRATE2_OLD" } },
      spot = { level = 0, topleft = { x = 3219, y = 9617 }, botright = { x = 3219, y = 9617 } }
    }
  },
  {
    id = 162,
    type = "cryptic",
    tier = "hard",
    text = { "The cheapest water for miles around, but they react badly to religious icons." },
    solution = {
      type = "search",
      entity = "Crate",
      entity_configs = { { domain = "loc", name = "ACTIVE_CRATE2" } },
      spot = { level = 0, topleft = { x = 3178, y = 2987 }, botright = { x = 3178, y = 2987 } }
    }
  },
  {
    id = 163,
    type = "cryptic",
    tier = "hard",
    text = {
      "You have all of the elements available to solve this clue. Fortunately you do not have to go as far as to stand in a draft."
    },
    solution = {
      type = "search",
      entity = "Crate",
      entity_configs = { { domain = "loc", name = "ELEM_CRATE_1" } },
      spot = { level = 0, topleft = { x = 2723, y = 9891 }, botright = { x = 2723, y = 9891 } }
    }
  },
  {
    id = 164,
    type = "cryptic",
    tier = "hard",
    text = { "Try not to let yourself be dazzled when you search these drawers." },
    solution = {
      type = "search",
      entity = "Drawers",
      entity_configs = {
        { domain = "loc", name = "AREA_ARDOUGNE_POSH_DRAWERS2" },
        { domain = "loc", name = "AREA_ARDOUGNE_POSH_DRAWERS2_OPEN" }
      },
      spot = { level = 0, topleft = { x = 2561, y = 3323 }, botright = { x = 2561, y = 3323 } }
    }
  },
  {
    id = 165,
    type = "cryptic",
    tier = "hard",
    text = {
      "Aggie I see, Lonely and southern I feel, I am neither inside nor outside the house, yet no house would be complete without me. The treasure lies beneath me!"
    },
    solution = {
      type = "dig",
      spot = { x = 3083, y = 3257, level = 0 },
      description = "in front of the window"
    }
  },
  {
    id = 166,
    type = "cryptic",
    tier = "hard",
    text = {
      "I am a token of the greatest love. I have no beginning or end. My eye is red, I can fit like a glove. Go to the place where it's money they lend, And dig by the gate to be my friend."
    },
    solution = {
      type = "dig",
      spot = { x = 3191, y = 9825, level = 0 },
      description = "in front of the gate"
    }
  },
  {
    id = 167,
    type = "cryptic",
    tier = "hard",
    text = { "Navigating to this crate will be a trial." },
    solution = {
      type = "search",
      entity = "Crate",
      entity_configs = { { domain = "loc", name = "ACTIVE_CRATE3" } },
      spot = { level = 0, topleft = { x = 2648, y = 3662 }, botright = { x = 2648, y = 3662 } }
    }
  },
  {
    id = 168,
    type = "cryptic",
    tier = "hard",
    text = { "This aviator is at the peak of his profession." },
    challenge = { { type = "slider" } },
    solution = {
      type = "talkto",
      spots = {
        {
          range = { origin = { x = 2850, y = 3493, level = 1 } },
          description = "at the top of White Wolf Mountain"
        }
      },
      npc = "Captain Bleemadge",
      npc_configs = { { domain = "npc", name = "PILOT_WHITE_WOLF" } }
    }
  },
  {
    id = 169,
    type = "cryptic",
    tier = "hard",
    text = { "Snah? I feel all confused, like one of those cakes." },
    solution = {
      type = "talkto",
      spots = {
        {
          range = { origin = { x = 3202, y = 3205, level = 0 }, size = { x = 21, y = 28 } },
          description = "at Lumbridge Castle"
        }
      },
      npc = "Hans",
      npc_configs = { { domain = "npc", name = "HANS" } }
    }
  },
  {
    id = 170,
    type = "cryptic",
    tier = "hard",
    text = {
      "My home is grey, and made of stone, A castle with a search for a meal. Hidden in some drawers I am, across from a wooden wheel."
    },
    solution = {
      type = "search",
      entity = "Drawers",
      entity_configs = {
        { domain = "loc", name = "FAI_LUMBRIDGE_CASTLE_DRAWERS_CLOSED" },
        { domain = "loc", name = "FAI_LUMBRIDGE_CASTLE_DRAWERS_OPEN" }
      },
      spot = { level = 1, topleft = { x = 3213, y = 3216 }, botright = { x = 3213, y = 3216 } }
    }
  },
  {
    id = 171,
    type = "cryptic",
    tier = "hard",
    text = { "Surprising? I bet he is...", "I bet he is..." },
    solution = {
      type = "talkto",
      spots = {
        {
          range = { origin = { x = 3202, y = 3470, level = 0 }, size = { x = 5, y = 5 } },
          description = "in Varrock Castle"
        }
      },
      npc = "Sir Prysin",
      npc_configs = {
        { domain = "npc", name = "SIR_PRYSIN" },
        { domain = "npc", name = "SIR_PRYSIN_MULTI" }
      }
    }
  },
  {
    id = 173,
    type = "cryptic",
    tier = "hard",
    text = {
      "Four blades I have, yet draw no blood, Still I turn my prey to powder. If you are brave, come search my roof, It is there my blades are louder."
    },
    solution = {
      type = "search",
      entity = "Crate",
      entity_configs = { { domain = "loc", name = "FAI_LUMBRIDGE_ACTIVE_CRATE_STACKED" } },
      spot = { level = 2, topleft = { x = 3166, y = 3309 }, botright = { x = 3166, y = 3309 } }
    }
  },
  {
    id = 174,
    type = "cryptic",
    tier = "hard",
    text = {
      "My name is like a tree, yet it is spelt with a 'g'. Come see the fur which is right near me."
    },
    challenge = { { type = "slider" } },
    solution = {
      type = "talkto",
      spots = {
        {
          range = { origin = { x = 3219, y = 3434, level = 0 }, size = { x = 6, y = 5 } },
          description = "near Varrock's fountain"
        }
      },
      npc = "Wilough",
      npc_configs = { { domain = "npc", name = "WILOUGH" } }
    }
  },
  {
    id = 175,
    type = "cryptic",
    tier = "hard",
    text = {
      "A strange little man who sells armour only to those who've proven themselves to be unafraid of dragons."
    },
    challenge = { { type = "slider" } },
    solution = {
      type = "talkto",
      spots = {
        {
          range = { origin = { x = 3066, y = 3514, level = 0 }, size = { x = 5, y = 5 } },
          description = "in Edgeville"
        }
      },
      npc = "Oziach",
      npc_configs = { { domain = "npc", name = "OZIACH" } }
    }
  },
  {
    id = 176,
    type = "cryptic",
    tier = "hard",
    text = {
      "Come to the evil ledge, Yew know yew want to. Try not to get stung.",
      "Come to the Try not to get stung."
    },
    solution = {
      type = "dig",
      spot = { x = 3089, y = 3468, level = 0 },
      description = "next to the yew tree"
    }
  },
  {
    id = 178,
    type = "cryptic",
    tier = "hard",
    text = {
      "When no weapons are at hand, then is the time to reflect. In Saradomin's name, redemption draws closer."
    },
    solution = {
      type = "search",
      entity = "Drawers",
      entity_configs = {
        { domain = "loc", name = "ENTRANA_DRAWERS_MEDIUMCLUE" },
        { domain = "loc", name = "ENTRANA_DRAWERS_MEDIUMCLUE_OPEN" }
      },
      spot = { level = 0, topleft = { x = 2818, y = 3351 }, botright = { x = 2818, y = 3351 } }
    }
  },
  {
    id = 216,
    type = "cryptic",
    tier = "hard",
    text = {
      "46 is my number. My body is the colour of burnt orange and crawls among those with eight. Three mouths I have, yet I cannot eat. My blinking blue eye hides my grave."
    },
    solution = {
      type = "dig",
      spot = { x = 3170, y = 3885, level = 0 },
      description = "on top of the sapphire spawn"
    }
  },
  {
    id = 219,
    type = "cryptic",
    tier = "hard",
    text = {
      "If you didn't want to be here and in danger, you should lever things well enough alone."
    },
    solution = {
      type = "dig",
      spot = { x = 3154, y = 3923, level = 0 },
      description = "in front of the lever in deep wilderness"
    }
  },
  {
    id = 221,
    type = "cryptic",
    tier = "hard",
    text = {
      "I lie lonely and forgotten in mid wilderness, Where the dead rise from their beds. Feel free to quarrel and wind me up, and dig while you shoot their heads."
    },
    solution = {
      type = "dig",
      spot = { x = 3235, y = 3673, level = 0 },
      description = "on top of the crossbow in the Graveyard of Shadows"
    }
  },
  {
    id = 223,
    type = "cryptic",
    tier = "hard",
    text = {
      "And so on, and so on, and so on. Walking from the land of many unimportant things leads to a choice of paths."
    },
    solution = {
      type = "dig",
      spot = { x = 2592, y = 3879, level = 0 },
      description = "at the crossoads on Etceteria"
    }
  },
  {
    id = 224,
    type = "cryptic",
    tier = "hard",
    text = {
      "This village has a problem with cartloads of the undead. Try checking the bookcase to find the answer."
    },
    solution = {
      type = "search",
      entity = "Bookcase",
      entity_configs = { { domain = "loc", name = "SHELVES_BAMBOO" } },
      spot = { level = 0, topleft = { x = 2833, y = 2992 }, botright = { x = 2833, y = 2992 } }
    }
  },
  {
    id = 49,
    type = "map",
    tier = "easy",
    image_url = "/assets/Map_clue_Wizards_Tower.png",
    text = { "X marks the spot south of the wizard's tower." },
    solution = {
      type = "dig",
      description = "east of the rock",
      spot = { x = 3103, y = 3133, level = 0 }
    }
  },
  {
    id = 50,
    type = "map",
    tier = "easy",
    image_url = "/assets/Map_clue_Brother_Galahads_house.png",
    text = {
      "X marks the spot in front of a small house surrounded by trees and near a bridge."
    },
    solution = {
      type = "dig",
      description = "in front of the door",
      spot = { x = 2612, y = 3481, level = 0 }
    }
  },
  {
    id = 54,
    type = "map",
    tier = "easy",
    image_url = "/assets/Map_clue_Falador_stones.png",
    text = { "X marks the spot near some rocks and a tree." },
    solution = {
      type = "dig",
      description = "west of the tree",
      spot = { x = 3043, y = 3399, level = 0 }
    }
  },
  {
    id = 55,
    type = "map",
    tier = "easy",
    image_url = "/assets/Map_clue_Falador_statue_crossroads.png",
    text = { "X marks the spot near a statue." },
    solution = {
      type = "dig",
      description = "two tiles south-east of the bench",
      spot = { x = 2970, y = 3414, level = 0 }
    }
  },
  {
    id = 56,
    type = "map",
    tier = "easy",
    image_url = "/assets/Map_clue_Varrock_east_mine.webp",
    text = { "X marks the spot at the end of a path north of a mine." },
    solution = {
      type = "dig",
      description = "two tiles south-east of the dead tree",
      spot = { x = 3290, y = 3373, level = 0 }
    }
  },
  {
    id = 63,
    type = "map",
    tier = "easy",
    image_url = "/assets/Map_clue_Varrock_west_mine.png",
    text = { "X marks the spot east of a tree near a small island on a river." },
    solution = {
      type = "dig",
      description = "three tiles east of the tree",
      spot = { x = 3164, y = 3359, level = 0 }
    }
  },
  {
    id = 44,
    type = "map",
    tier = "medium",
    image_url = "/assets/Map_clue_Clock_Tower.png",
    text = { "A crate near a bridge over a river." },
    solution = {
      type = "search",
      spot = { level = 0, topleft = { x = 2565, y = 3248 }, botright = { x = 2565, y = 3248 } },
      entity = "Crate",
      entity_configs = { { domain = "loc", name = "ACTIVE_CRATE2" } }
    }
  },
  {
    id = 45,
    type = "map",
    tier = "medium",
    image_url = "/assets/Map_clue_McGrubors_Wood.png",
    text = { "A crate in the woods directly next to a building." },
    solution = {
      type = "search",
      spot = { level = 0, topleft = { x = 2658, y = 3488 }, botright = { x = 2658, y = 3488 } },
      entity = "Crate",
      entity_configs = { { domain = "loc", name = "ACTIVE_CRATE2_OLD" } }
    }
  },
  {
    id = 48,
    type = "map",
    tier = "medium",
    image_url = "/assets/Map_clue_Ourania_chaos_altar.png",
    text = { "X marks the spot between lava lakes." },
    solution = {
      type = "dig",
      description = "behind the chaos altar at Ourania",
      spot = { x = 2454, y = 3230, level = 0 }
    }
  },
  {
    id = 51,
    type = "map",
    tier = "medium",
    image_url = "/assets/Map_clue_Chemist's_house.png",
    text = { "X marks the spot next to a building at the coast." },
    solution = {
      type = "dig",
      description = "west of the Chemist's House",
      spot = { x = 2924, y = 3208, level = 0 }
    }
  },
  {
    id = 52,
    type = "map",
    tier = "medium",
    image_url = "/assets/Map_clue_Miscellania.png",
    text = { "X marks the spot between some trees at the end of a path." },
    solution = {
      type = "dig",
      description = "between the signpost and the evergreen",
      spot = { x = 2536, y = 3865, level = 0 }
    }
  },
  {
    id = 53,
    type = "map",
    tier = "medium",
    image_url = "/assets/Map_clue_Tower_of_Life.png",
    text = { "X marks the spot on a surprisingly detailled map next to a statue on a road." },
    solution = {
      type = "dig",
      description = "south of the giant head",
      spot = { x = 2650, y = 3231, level = 0 }
    }
  },
  {
    id = 57,
    type = "map",
    tier = "medium",
    image_url = "/assets/Map_clue_Seers_to_Rellekka_road.png",
    text = { "X marks the spot on a narrow landstrip near a road and a lot of trees." },
    solution = {
      type = "dig",
      description = "next to the bush",
      spot = { x = 2667, y = 3562, level = 0 }
    }
  },
  {
    id = 58,
    type = "map",
    tier = "medium",
    image_url = "/assets/Map_clue_Hobgoblin_peninsula.png",
    text = { "X marks the spot near a rock on a peninsula." },
    solution = {
      type = "dig",
      spot = { x = 2906, y = 3292, level = 0 },
      description = "at the tip of the hobgoblin peninsula."
    }
  },
  {
    id = 60,
    type = "map",
    tier = "medium",
    image_url = "/assets/Map_clue_Lighthouse_peninsula.png",
    text = { "X marks the spot on a small landmass surrounded by water." },
    solution = {
      type = "dig",
      spot = { x = 2578, y = 3597, level = 0 },
      description = "at the end of the branching path next to the crystal tree"
    }
  },
  {
    id = 61,
    type = "map",
    image_url = "/assets/Map_clue_Haunted_Mine.png",
    tier = "medium",
    text = { "X marks the spot near some weird looking grass" },
    solution = {
      type = "dig",
      spot = { x = 3434, y = 3265, level = 0 },
      description = "four tiles west of the mushroom"
    }
  },
  {
    id = 62,
    type = "map",
    tier = "medium",
    image_url = "/assets/Map_clue_Draynor.png",
    text = {
      "X marks the spot at the end of a path starting from a rock and near a fishing spot."
    },
    solution = {
      type = "dig",
      spot = { x = 3092, y = 3225, level = 0 },
      description = "between the southern most willow tree and the small obelisk"
    }
  },
  {
    id = 40,
    type = "map",
    tier = "hard",
    text = { "A crate at a group of three buildings." },
    image_url = "/assets/Map_clue_Observatory.png",
    solution = {
      type = "search",
      entity = "Crate",
      entity_configs = { { domain = "loc", name = "ELEM_CRATE_1" } },
      spot = { level = 0, topleft = { x = 2457, y = 3182 }, botright = { x = 2457, y = 3182 } }
    }
  },
  {
    id = 41,
    type = "map",
    tier = "hard",
    text = { "X marks the spot next to a tree behind a building in the corner of a city." },
    image_url = "/assets/Map_clue_Yanille_anvil.png",
    solution = {
      type = "dig",
      spot = { x = 2616, y = 3077, level = 0 },
      description = "inside, next to the south-eastern wall of the anvil building, or outside next to the tree"
    }
  },
  {
    id = 42,
    type = "map",
    tier = "hard",
    text = { "X marks the spot between two tables." },
    image_url = "/assets/Map_clue_Legends_Guild.png",
    solution = {
      type = "dig",
      spot = { x = 2722, y = 3338, level = 0 },
      description = "two tiles south of the northern bench"
    }
  },
  {
    id = 43,
    type = "map",
    tier = "hard",
    image_url = "/assets/Map_clue_West_Ardougne.png",
    text = { "X marks the spot in one of multiple column-like buildings." },
    solution = {
      type = "dig",
      description = "in the north-western corner of the building",
      spot = { x = 2488, y = 3308, level = 0 }
    }
  },
  {
    id = 46,
    type = "map",
    tier = "hard",
    image_url = "/assets/Map_clue_Dark_Warriors_Fortress.png",
    text = { "A crate in the courtyard of a castle." },
    solution = {
      type = "search",
      entity = "Crate",
      entity_configs = { { domain = "loc", name = "ACTIVE_CRATE2" } },
      spot = { level = 0, topleft = { x = 3026, y = 3629 }, botright = { x = 3026, y = 3629 } }
    }
  },
  {
    id = 47,
    type = "map",
    tier = "hard",
    image_url = "/assets/Map_clue_Fort_Forinthry.png",
    text = { "A crate outside of some fort's walls." },
    solution = {
      type = "search",
      entity = "Crate",
      entity_configs = { { domain = "loc", name = "HUMAN_STORAGE_CRATE_REGULAR_SQUARE_SEARCHABLE" } },
      spot = { level = 0, topleft = { x = 3312, y = 3528 }, botright = { x = 3312, y = 3528 } }
    }
  },
  {
    id = 59,
    type = "map",
    tier = "hard",
    image_url = "/assets/Map_clue_small_volcanoes.png",
    text = { "X marks the spot between three small volcanoes." },
    solution = {
      type = "dig",
      spot = { x = 3021, y = 3912, level = 0 },
      description = "two tiles west of the large geyser"
    }
  },
  {
    id = 8,
    type = "emote",
    tier = "easy",
    text = {
      "Dance in the shack in Lumbridge Swamp. Equip a bronze dagger, iron full helm and a gold ring."
    },
    area = { origin = { x = 3202, y = 3167, level = 0 }, size = { x = 4, y = 4 } },
    items = {
      { slot = zyklib.game.equipment.SLOTS.MAINHAND, options = { config.Obj.BRONZE_DAGGER } },
      { slot = zyklib.game.equipment.SLOTS.HEAD,     options = { config.Obj.IRON_FULL_HELM } },
      { slot = zyklib.game.equipment.SLOTS.RING,     options = { config.Obj.GOLD_RING } } },
    emotes = { "Dance" },
    double_agent = false,
    hidey_hole = {
      config = "TRAIL17_STASH_26_LUMBRIDGE_SWAMP",
      name = "Barrel (hidey-hole)",
      location = { topleft = { x = 3204, y = 3169 }, botright = { x = 3204, y = 3169 }, level = 0 }
    }
  },
  {
    id = 259,
    type = "emote",
    tier = "easy",
    text = {
      "Think in the middle of the wheat field by the Lumbridge mill. Equip a sapphire necklace, polar camo legs and an oak shortbow."
    },
    area = { origin = { x = 3155, y = 3295, level = 0 }, size = { x = 6, y = 9 } },
    items = {
      { slot = zyklib.game.equipment.SLOTS.NECK,     options = { config.Obj.SAPPHIRE_NECKLACE } },
      { slot = zyklib.game.equipment.SLOTS.LEGS,     options = { config.Obj.HUNTING_TROUSERS_POLAR } },
      { slot = zyklib.game.equipment.SLOTS.MAINHAND, options = { config.Obj.OAK_SHORTBOW } } },
    emotes = { "Think" },
    double_agent = false,
    hidey_hole = {
      config = "TRAIL17_STASH_44_LUMBRIDGE_MILL",
      name = "Sack of items (hidey-hole)",
      location = { topleft = { x = 3165, y = 3302 }, botright = { x = 3165, y = 3302 }, level = 0 }
    }
  },
  {
    id = 260,
    type = "emote",
    tier = "easy",
    text = {
      "Laugh at the crossroads south of Sinclair Mansion. Equip a leather cowl, amulet of strength and iron scimitar."
    },
    area = { origin = { x = 2737, y = 3534, level = 0 }, size = { x = 8, y = 8 } },
    items = {
      { slot = zyklib.game.equipment.SLOTS.HEAD,     options = { config.Obj.LEATHER_COWL } },
      { slot = zyklib.game.equipment.SLOTS.NECK,     options = { config.Obj.AMULET_OF_STRENGTH } },
      { slot = zyklib.game.equipment.SLOTS.MAINHAND, options = { config.Obj.IRON_SCIMITAR } } },
    emotes = { "Laugh" },
    double_agent = false,
    hidey_hole = {
      config = "TRAIL17_STASH_31_SINCLAIR_MANSION",
      name = "Rock (hidey-hole)",
      location = { topleft = { x = 2731, y = 3534 }, botright = { x = 2731, y = 3534 }, level = 0 }
    }
  },
  {
    id = 261,
    type = "emote",
    tier = "easy",
    text = {
      "Panic in the limestone mine. Equip bronze platelegs, a steel pickaxe and a steel helmet."
    },
    area = { origin = { x = 3367, y = 3497, level = 0 }, size = { x = 10, y = 6 } },
    items = {
      { slot = zyklib.game.equipment.SLOTS.LEGS,     options = { config.Obj.BRONZE_PLATELEGS } },
      { slot = zyklib.game.equipment.SLOTS.MAINHAND, options = { config.Obj.STEEL_PICKAXE } },
      { slot = zyklib.game.equipment.SLOTS.HEAD,     options = { config.Obj.STEEL_MED_HELM } } },
    emotes = { "Panic" },
    double_agent = false,
    hidey_hole = {
      config = "TRAIL17_STASH_35_LIMESTONE_MINE",
      name = "Crate (hidey-hole)",
      location = { topleft = { x = 3376, y = 3500 }, botright = { x = 3376, y = 3500 }, level = 0 }
    }
  },
  {
    id = 262,
    type = "emote",
    tier = "easy",
    text = {
      "Panic on the pier where you catch the Fishing Trawler. Have nothing equipped at all when you do."
    },
    area = { origin = { x = 2676, y = 3163, level = 0 }, size = { x = 1, y = 12 } },
    items = {
      { slot = zyklib.game.equipment.SLOTS.HEAD,     options = { nil } },
      { slot = zyklib.game.equipment.SLOTS.CAPE,     options = { nil } },
      { slot = zyklib.game.equipment.SLOTS.NECK,     options = { nil } },
      { slot = zyklib.game.equipment.SLOTS.MAINHAND, options = { nil } },
      { slot = zyklib.game.equipment.SLOTS.BODY,     options = { nil } },
      { slot = zyklib.game.equipment.SLOTS.LEGS,     options = { nil } },
      { slot = zyklib.game.equipment.SLOTS.HANDS,    options = { nil } },
      { slot = zyklib.game.equipment.SLOTS.FEET,     options = { nil } },
      { slot = zyklib.game.equipment.SLOTS.RING,     options = { nil } },
      { slot = zyklib.game.equipment.SLOTS.AMMO,     options = { nil } },
      { slot = zyklib.game.equipment.SLOTS.POCKET,   options = { nil } },
    },
    emotes = { "Panic" },
    double_agent = false,
    hidey_hole = nil
  },
  {
    id = 263,
    type = "emote",
    tier = "easy",
    text = {
      "Blow a raspberry at the monkey cage in Ardougne Zoo. Equip a studded leather body, bronze platelegs and a mud pie."
    },
    area = { origin = { x = 2597, y = 3273, level = 0 }, size = { x = 11, y = 11 } },
    items = {
      { slot = zyklib.game.equipment.SLOTS.BODY,     options = { config.Obj.STUDDED_BODY } },
      { slot = zyklib.game.equipment.SLOTS.LEGS,     options = { config.Obj.BRONZE_PLATELEGS } },
      { slot = zyklib.game.equipment.SLOTS.MAINHAND, options = { config.Obj.MUD_PIE } } },
    emotes = { "Raspberry" },
    double_agent = false,
    hidey_hole = {
      config = "TRAIL17_STASH_04_ARDOUGNE_ZOO",
      name = "Rock (hidey-hole)",
      location = { topleft = { x = 2599, y = 3280 }, botright = { x = 2599, y = 3280 }, level = 0 }
    }
  },
  {
    id = 264,
    type = "emote",
    tier = "easy",
    text = {
      "Clap on the causeway to the Wizards' Tower. Equip an iron helmet, emerald ring and leather gloves."
    },
    area = { origin = { x = 3101, y = 3187, level = 0 }, size = { x = 4, y = 23 } },
    items = {
      { slot = zyklib.game.equipment.SLOTS.HEAD,  options = { config.Obj.IRON_MED_HELM } },
      { slot = zyklib.game.equipment.SLOTS.RING,  options = { config.Obj.EMERALD_RING } },
      { slot = zyklib.game.equipment.SLOTS.HANDS, options = { config.Obj.LEATHER_GLOVES } } },
    emotes = { "Clap" },
    double_agent = false,
    hidey_hole = {
      config = "TRAIL17_STASH_17_WIZARDS_TOWER",
      name = "Rock (hidey-hole)",
      location = { topleft = { x = 3099, y = 3189 }, botright = { x = 3099, y = 3188 }, level = 0 }
    }
  },
  {
    id = 265,
    type = "emote",
    tier = "easy",
    text = {
      "Twirl at the crossroads north of Rimmington. Equip a Sapphire ring, yellow flowers and leather chaps."
    },
    area = { origin = { x = 2953, y = 3239, level = 0 }, size = { x = 3, y = 5 } },
    items = {
      { slot = zyklib.game.equipment.SLOTS.RING,     options = { config.Obj.SAPPHIRE_RING } },
      { slot = zyklib.game.equipment.SLOTS.MAINHAND, options = { config.Obj.FLOWERS_WATERFALL_QUEST_YELLOW } },
      { slot = zyklib.game.equipment.SLOTS.LEGS,     options = { config.Obj.LEATHER_CHAPS } } },
    emotes = { "Twirl" },
    double_agent = false,
    hidey_hole = {
      config = "TRAIL17_STASH_40_CROSSROADS",
      name = "Rock (hidey-hole)",
      location = { topleft = { x = 2959, y = 3241 }, botright = { x = 2960, y = 3240 }, level = 0 }
    }
  },
  {
    id = 266,
    type = "emote",
    tier = "easy",
    text = {
      "Blow raspberries outside the entrance to Keep Le Faye. Equip a studded leather coif, iron platebody and leather gloves."
    },
    area = { origin = { x = 2757, y = 3398, level = 0 }, size = { x = 7, y = 8 } },
    items = {
      { slot = zyklib.game.equipment.SLOTS.HEAD,  options = { config.Obj.COIF } },
      { slot = zyklib.game.equipment.SLOTS.BODY,  options = { config.Obj.IRON_PLATEBODY } },
      { slot = zyklib.game.equipment.SLOTS.HANDS, options = { config.Obj.LEATHER_GLOVES } } },
    emotes = { "Raspberry" },
    double_agent = false,
    hidey_hole = {
      config = "TRAIL17_STASH_06_KEEP_LE_FAYE",
      name = "Rock (hidey-hole)",
      location = { topleft = { x = 2756, y = 3404 }, botright = { x = 2756, y = 3404 }, level = 0 }
    }
  },
  {
    id = 267,
    type = "emote",
    tier = "easy",
    text = {
      "Cheer for the monks at Port Sarim. Equip a studded leather coif, steel plateskirt and a sapphire necklace."
    },
    area = { origin = { x = 3044, y = 3234, level = 0 }, size = { x = 6, y = 4 } },
    items = {
      { slot = zyklib.game.equipment.SLOTS.HEAD, options = { config.Obj.COIF } },
      { slot = zyklib.game.equipment.SLOTS.LEGS, options = { config.Obj.STEEL_PLATESKIRT } },
      { slot = zyklib.game.equipment.SLOTS.NECK, options = { config.Obj.SAPPHIRE_NECKLACE } } },
    emotes = { "Cheer" },
    double_agent = false,
    hidey_hole = {
      config = "TRAIL17_STASH_13_PORT_SARIM",
      name = "Crate (hidey-hole)",
      location = { topleft = { x = 3042, y = 3234 }, botright = { x = 3042, y = 3234 }, level = 0 }
    }
  },
  {
    id = 268,
    type = "emote",
    tier = "easy",
    text = { "Wave on Mudskipper Point. Equip a gold ring, leather chaps and a steel mace." },
    area = { origin = { x = 2981, y = 3106, level = 0 }, size = { x = 25, y = 25 } },
    items = {
      { slot = zyklib.game.equipment.SLOTS.RING,     options = { config.Obj.GOLD_RING } },
      { slot = zyklib.game.equipment.SLOTS.LEGS,     options = { config.Obj.LEATHER_CHAPS } },
      { slot = zyklib.game.equipment.SLOTS.MAINHAND, options = { config.Obj.STEEL_MACE } } },
    emotes = { "Wave" },
    double_agent = false,
    hidey_hole = {
      config = "TRAIL17_STASH_47_MUDSKIPPER_POINT",
      name = "Rock (hidey-hole)",
      location = { topleft = { x = 3004, y = 3123 }, botright = { x = 3004, y = 3123 }, level = 0 }
    }
  },
  {
    id = 269,
    type = "emote",
    tier = "easy",
    text = {
      "Shrug in the mine near Rimmington. Equip a gold necklace, gold ring and a bronze spear."
    },
    area = { origin = { x = 2970, y = 3230, level = 0 }, size = { x = 20, y = 22 } },
    items = {
      { slot = zyklib.game.equipment.SLOTS.NECK,     options = { config.Obj.GOLD_NECKLACE } },
      { slot = zyklib.game.equipment.SLOTS.RING,     options = { config.Obj.GOLD_RING } },
      { slot = zyklib.game.equipment.SLOTS.MAINHAND, options = { config.Obj.BRONZE_SPEAR } } },
    emotes = { "Shrug" },
    double_agent = false,
    hidey_hole = {
      config = "TRAIL17_STASH_38_RIMMINGTON_MINE",
      name = "Cart (hidey-hole)",
      location = { topleft = { x = 2972, y = 3237 }, botright = { x = 2973, y = 3235 }, level = 0 }
    }
  },
  {
    id = 270,
    type = "emote",
    tier = "easy",
    text = {
      "Clap in the main exam room of the Exam Centre. Equip a ruby amulet, blue flowers and leather gloves."
    },
    area = { origin = { x = 3351, y = 3342, level = 0 }, size = { x = 9, y = 8 } },
    items = {
      { slot = zyklib.game.equipment.SLOTS.NECK,     options = { config.Obj.STRUNG_RUBY_AMULET } },
      { slot = zyklib.game.equipment.SLOTS.MAINHAND, options = { config.Obj.FLOWERS_WATERFALL_QUEST_BLUE } },
      { slot = zyklib.game.equipment.SLOTS.HANDS,    options = { config.Obj.LEATHER_GLOVES } } },
    emotes = { "Clap" },
    double_agent = false,
    hidey_hole = {
      config = "TRAIL17_STASH_15_EXAM_CENTRE",
      name = "Crate (hidey-hole)",
      location = { topleft = { x = 3351, y = 3348 }, botright = { x = 3351, y = 3348 }, level = 0 }
    }
  },
  {
    id = 271,
    type = "emote",
    tier = "easy",
    text = {
      "Yawn in Varrock Palace library. Equip a holy symbol, leather vambraces and an iron warhammer."
    },
    area = { origin = { x = 3207, y = 3490, level = 0 }, size = { x = 8, y = 8 } },
    items = {
      { slot = zyklib.game.equipment.SLOTS.NECK,     options = { config.Obj.BLESSEDSTAR } },
      { slot = zyklib.game.equipment.SLOTS.HANDS,    options = { config.Obj.LEATHER_VAMBRACES } },
      { slot = zyklib.game.equipment.SLOTS.MAINHAND, options = { config.Obj.IRON_WARHAMMER } } },
    emotes = { "Yawn" },
    double_agent = false,
    hidey_hole = {
      config = "TRAIL17_STASH_48_VARROCK_LIBRARY",
      name = "Crate (hidey-hole)",
      location = { topleft = { x = 3217, y = 3494 }, botright = { x = 3217, y = 3494 }, level = 0 }
    }
  },
  {
    id = 272,
    type = "emote",
    tier = "easy",
    text = {
      "Dance in the Party Room. Equip a steel full helmet, steel platebody and an iron plateskirt."
    },
    area = { origin = { x = 3036, y = 3371, level = 0 }, size = { x = 20, y = 15 } },
    items = {
      { slot = zyklib.game.equipment.SLOTS.HEAD, options = { config.Obj.STEEL_FULL_HELM } },
      { slot = zyklib.game.equipment.SLOTS.BODY, options = { config.Obj.STEEL_PLATEBODY } },
      { slot = zyklib.game.equipment.SLOTS.LEGS, options = { config.Obj.IRON_PLATESKIRT } } },
    emotes = { "Dance" },
    double_agent = false,
    hidey_hole = {
      config = "TRAIL17_STASH_25_PARTY_ROOM",
      name = "Potted plant (hidey-hole)",
      location = { topleft = { x = 3041, y = 3372 }, botright = { x = 3041, y = 3372 }, level = 0 }
    }
  },
  {
    id = 273,
    type = "emote",
    tier = "easy",
    text = {
      "Twirl in Draynor Manor by the fountain. Equip an iron platebody, studded chaps and a bronze full helm."
    },
    area = { origin = { x = 3085, y = 3332, level = 0 }, size = { x = 6, y = 6 } },
    items = {
      { slot = zyklib.game.equipment.SLOTS.BODY, options = { config.Obj.IRON_PLATEBODY } },
      { slot = zyklib.game.equipment.SLOTS.LEGS, options = { config.Obj.STUDDED_CHAPS } },
      { slot = zyklib.game.equipment.SLOTS.HEAD, options = { config.Obj.BRONZE_FULL_HELM } } },
    emotes = { "Twirl" },
    double_agent = false,
    hidey_hole = {
      config = "TRAIL17_STASH_41_DRAYNOR_MANOR",
      name = "Dead tree (hidey-hole)",
      location = { topleft = { x = 3090, y = 3341 }, botright = { x = 3092, y = 3340 }, level = 0 }
    }
  },
  {
    id = 274,
    type = "emote",
    tier = "easy",
    text = {
      "Jump for joy at the beehives. Equip iron boots, an unholy symbol and a steel hatchet."
    },
    area = { origin = { x = 2752, y = 3437, level = 0 }, size = { x = 15, y = 14 } },
    items = {
      { slot = zyklib.game.equipment.SLOTS.FEET,     options = { config.Obj.IRON_ARMOURED_BOOTS } },
      { slot = zyklib.game.equipment.SLOTS.NECK,     options = { config.Obj.BLESSEDSNAKE } },
      { slot = zyklib.game.equipment.SLOTS.MAINHAND, options = { config.Obj.STEEL_AXE } } },
    emotes = { "Jump for Joy" },
    double_agent = false,
    hidey_hole = {
      config = "TRAIL17_STASH_28_BEEHIVE",
      name = "Beehive (hidey-hole)",
      location = { topleft = { x = 2762, y = 3447 }, botright = { x = 2762, y = 3447 }, level = 0 }
    }
  },
  {
    id = 275,
    type = "emote",
    tier = "easy",
    text = {
      "Headbang in the mine north of Al-kharid. Equip a Polar Camo Top, Leather Gloves and Leather Boots."
    },
    area = { origin = { x = 3296, y = 3291, level = 0 }, size = { x = 8, y = 26 } },
    items = {
      { slot = zyklib.game.equipment.SLOTS.BODY,  options = { config.Obj.HUNTING_CAMOFLAUGE_ROBE_POLAR } },
      { slot = zyklib.game.equipment.SLOTS.HANDS, options = { config.Obj.LEATHER_GLOVES } },
      { slot = zyklib.game.equipment.SLOTS.FEET,  options = { config.Obj.LEATHER_BOOTS } } },
    emotes = { "Headbang" },
    double_agent = false,
    hidey_hole = {
      config = "TRAIL17_STASH_27_DESERT_MINE",
      name = "Rocks (hidey-hole)",
      location = { topleft = { x = 3295, y = 3282 }, botright = { x = 3295, y = 3282 }, level = 0 }
    }
  },
  {
    id = 276,
    type = "emote",
    tier = "easy",
    text = {
      "Bow or curtsy outside the entrance to the Legends' Guild. Equip iron platelegs, an emerald amulet and an oak shieldbow."
    },
    area = { origin = { x = 2726, y = 3346, level = 0 }, size = { x = 6, y = 4 } },
    items = {
      { slot = zyklib.game.equipment.SLOTS.LEGS,     options = { config.Obj.IRON_PLATELEGS } },
      { slot = zyklib.game.equipment.SLOTS.NECK,     options = { config.Obj.STRUNG_EMERALD_AMULET } },
      { slot = zyklib.game.equipment.SLOTS.MAINHAND, options = { config.Obj.OAK_LONGBOW } } },
    emotes = { "Bow or Curtsy" },
    double_agent = false,
    hidey_hole = {
      config = "TRAIL17_STASH_09_LEGENDS_GUILD",
      name = "Rock (hidey-hole)",
      location = { topleft = { x = 2732, y = 3352 }, botright = { x = 2732, y = 3352 }, level = 0 }
    }
  },
  {
    id = 277,
    type = "emote",
    tier = "easy",
    text = {
      "Cheer in the centre of the Burthorpe Games Room. Have nothing equipped at all when you do."
    },
    area = { origin = { x = 2194, y = 4946, level = 0 }, size = { x = 28, y = 28 } },
    items = {
      { slot = zyklib.game.equipment.SLOTS.HEAD,     options = { nil } },
      { slot = zyklib.game.equipment.SLOTS.CAPE,     options = { nil } },
      { slot = zyklib.game.equipment.SLOTS.NECK,     options = { nil } },
      { slot = zyklib.game.equipment.SLOTS.MAINHAND, options = { nil } },
      { slot = zyklib.game.equipment.SLOTS.BODY,     options = { nil } },
      { slot = zyklib.game.equipment.SLOTS.LEGS,     options = { nil } },
      { slot = zyklib.game.equipment.SLOTS.HANDS,    options = { nil } },
      { slot = zyklib.game.equipment.SLOTS.FEET,     options = { nil } },
      { slot = zyklib.game.equipment.SLOTS.RING,     options = { nil } },
      { slot = zyklib.game.equipment.SLOTS.AMMO,     options = { nil } },
      { slot = zyklib.game.equipment.SLOTS.POCKET,   options = { nil } },
    },
    emotes = { "Cheer" },
    double_agent = false,
    hidey_hole = nil
  },
  {
    id = 278,
    type = "emote",
    tier = "easy",
    text = {
      "Dance at the crossroads north of Draynor. Equip an iron chainbody, sapphire ring and a shieldbow."
    },
    area = { origin = { x = 3108, y = 3293, level = 0 }, size = { x = 4, y = 4 } },
    items = {
      { slot = zyklib.game.equipment.SLOTS.BODY,     options = { config.Obj.IRON_CHAINBODY } },
      { slot = zyklib.game.equipment.SLOTS.RING,     options = { config.Obj.SAPPHIRE_RING } },
      { slot = zyklib.game.equipment.SLOTS.MAINHAND, options = { config.Obj.LONGBOW } } },
    emotes = { "Dance" },
    double_agent = false,
    hidey_hole = {
      config = "TRAIL17_STASH_23_DRAYNOR_CROSSROADS",
      location = { topleft = { x = 3112, y = 3292 }, botright = { x = 3112, y = 3292 }, level = 0 },
      name = "Rock (hidey-hole)"
    }
  },
  {
    id = 279,
    type = "emote",
    tier = "easy",
    text = {
      "Dance a jig by the entrance to the Fishing Guild. Equip an emerald ring, sapphire amulet, and a bronze chainbody."
    },
    area = { origin = { x = 2611, y = 3384, level = 0 }, size = { x = 5, y = 3 } },
    items = {
      { slot = zyklib.game.equipment.SLOTS.RING, options = { config.Obj.EMERALD_RING } },
      { slot = zyklib.game.equipment.SLOTS.NECK, options = { config.Obj.STRUNG_SAPPHIRE_AMULET } },
      { slot = zyklib.game.equipment.SLOTS.BODY, options = { config.Obj.BRONZE_CHAINBODY } } },
    emotes = { "Jig" },
    double_agent = false,
    hidey_hole = {
      config = "TRAIL17_STASH_20_FISHING_GUILD",
      location = { topleft = { x = 2619, y = 3388 }, botright = { x = 2619, y = 3388 }, level = 0 },
      name = "Rock (hidey-hole)"
    }
  },
  {
    id = 280,
    type = "emote",
    tier = "easy",
    text = {
      "Bow or curtsy at the entrance to Het's Oasis. Equip an iron chainbody, leather chaps and a studded leather coif."
    },
    area = { origin = { x = 3318, y = 3225, level = 0 }, size = { x = 9, y = 17 } },
    items = {
      { slot = zyklib.game.equipment.SLOTS.BODY, options = { config.Obj.IRON_CHAINBODY } },
      { slot = zyklib.game.equipment.SLOTS.LEGS, options = { config.Obj.LEATHER_CHAPS } },
      { slot = zyklib.game.equipment.SLOTS.HEAD, options = { config.Obj.COIF } } },
    emotes = { "Bow or Curtsy" },
    double_agent = false,
    hidey_hole = {
      config = "TRAIL17_STASH_08_DUEL_ARENA",
      name = "Sack (hidey-hole)",
      location = { topleft = { x = 3323, y = 3236 }, botright = { x = 3323, y = 3236 }, level = 0 }
    }
  },
  {
    id = 281,
    type = "emote",
    tier = "easy",
    text = {
      "Cry outside the south gates of Fort Forinthry. Equip a hard leather body, leather chaps and a bronze hatchet."
    },
    area = { origin = { x = 3296, y = 3520, level = 0 }, size = { x = 16, y = 9 } },
    items = {
      { slot = zyklib.game.equipment.SLOTS.BODY,     options = { config.Obj.HARDLEATHER_BODY } },
      { slot = zyklib.game.equipment.SLOTS.LEGS,     options = { config.Obj.LEATHER_CHAPS } },
      { slot = zyklib.game.equipment.SLOTS.MAINHAND, options = { config.Obj.BRONZE_AXE } } },
    emotes = { "Cry" },
    double_agent = false,
    hidey_hole = {
      config = "TRAIL17_STASH_46_LUMBER_YARD",
      location = { topleft = { x = 3299, y = 3521 }, botright = { x = 3299, y = 3521 }, level = 0 },
      name = "Tree stump (hidey-hole)"
    }
  },
  {
    id = 282,
    type = "emote",
    tier = "easy",
    text = {
      "Clap on the top level of the mill north of East Ardougne. Equip an emerald ring, wood camo top and an unenchanted tiara."
    },
    area = { origin = { x = 2630, y = 3381, level = 2 }, size = { x = 6, y = 6 } },
    items = {
      { slot = zyklib.game.equipment.SLOTS.RING, options = { config.Obj.EMERALD_RING } },
      { slot = zyklib.game.equipment.SLOTS.BODY, options = { config.Obj.HUNTING_CAMOFLAUGE_ROBE_WOOD } },
      { slot = zyklib.game.equipment.SLOTS.HEAD, options = { config.Obj.TIARA } } },
    emotes = { "Clap" },
    double_agent = false,
    hidey_hole = {
      config = "TRAIL17_STASH_16_WINDMILL",
      location = { topleft = { x = 2635, y = 3383 }, botright = { x = 2635, y = 3383 }, level = 2 },
      name = "Crate (hidey-hole)"
    }
  },
  {
    id = 283,
    type = "emote",
    tier = "easy",
    text = {
      "Yawn in Draynor Marketplace. Equip an iron kiteshield, steel longsword and studded leather chaps."
    },
    area = { origin = { x = 3074, y = 3246, level = 0 }, size = { x = 13, y = 10 } },
    items = {
      { slot = zyklib.game.equipment.SLOTS.OFFHAND,  options = { config.Obj.IRON_KITESHIELD } },
      { slot = zyklib.game.equipment.SLOTS.MAINHAND, options = { config.Obj.STEEL_LONGSWORD } },
      { slot = zyklib.game.equipment.SLOTS.LEGS,     options = { config.Obj.STUDDED_CHAPS } } },
    emotes = { "Yawn" },
    double_agent = false,
    hidey_hole = {
      config = "TRAIL17_STASH_51_DRAYNOR_VILLAGE",
      name = "Barrel (hidey-hole)",
      location = { topleft = { x = 3078, y = 3246 }, botright = { x = 3078, y = 3246 }, level = 0 }
    }
  },
  {
    id = 284,
    type = "emote",
    tier = "easy",
    text = {
      "Cheer at the Druids' Circle. Equip an air tiara, bronze two-handed sword and a gold amulet."
    },
    area = { origin = { x = 2917, y = 3476, level = 0 }, size = { x = 10, y = 11 } },
    items = {
      { slot = zyklib.game.equipment.SLOTS.HEAD,     options = { config.Obj.TIARA_AIR } },
      { slot = zyklib.game.equipment.SLOTS.MAINHAND, options = { config.Obj.BRONZE_2H_SWORD } },
      { slot = zyklib.game.equipment.SLOTS.NECK,     options = { config.Obj.STRUNG_GOLD_AMULET } } },
    emotes = { "Cheer" },
    double_agent = false,
    hidey_hole = {
      config = "TRAIL17_STASH_11_DRUID_CIRCLE",
      name = "Rock (hidey-hole)",
      location = { topleft = { x = 2922, y = 3476 }, botright = { x = 2922, y = 3476 }, level = 0 }
    }
  },
  {
    id = 7,
    type = "emote",
    tier = "medium",
    text = {
      "Beckon at the Digsite, near the eastern winch. Bow or curtsy before you talk to me. Equip a pointed red and black snelm, snakeskin boots, and an iron pickaxe."
    },
    area = { origin = { x = 3375, y = 3440, level = 0 }, size = { x = 7, y = 7 } },
    items = {
      { slot = zyklib.game.equipment.SLOTS.HEAD,     options = { config.Obj.SNELM_POINT_REDPLUSBLACK } },
      { slot = zyklib.game.equipment.SLOTS.FEET,     options = { config.Obj.SNAKESKIN_BOOTS } },
      { slot = zyklib.game.equipment.SLOTS.MAINHAND, options = { config.Obj.IRON_PICKAXE } } },
    emotes = { "Beckon", "Bow or Curtsy" },
    double_agent = false,
    hidey_hole = {
      config = "TRAIL17_STASH_02_DIGSITE",
      name = "Barrel (hidey-hole)",
      location = { topleft = { x = 3379, y = 3445 }, botright = { x = 3379, y = 3445 }, level = 0 }
    }
  },
  {
    id = 247,
    type = "emote",
    tier = "medium",
    text = {
      "Panic by the mausoleum in Morytania. Wave before you speak to me. Equip a mithril plateskirt, a maple shieldbow and no boots."
    },
    area = { origin = { x = 3490, y = 3565, level = 0 }, size = { x = 25, y = 17 } },
    items = {
      { slot = zyklib.game.equipment.SLOTS.LEGS,     options = { config.Obj.MITHRIL_PLATESKIRT } },
      { slot = zyklib.game.equipment.SLOTS.MAINHAND, options = { config.Obj.MAPLE_LONGBOW } },
      { slot = zyklib.game.equipment.SLOTS.FEET,     options = { nil } }
    },
    emotes = { "Panic", "Wave" },
    double_agent = false,
    hidey_hole = {
      config = "TRAIL17_STASH_32_MAUSOLEUM",
      name = "Crate (hidey-hole)",
      location = { topleft = { x = 3506, y = 3574 }, botright = { x = 3506, y = 3574 }, level = 0 }
    }
  },
  {
    id = 248,
    type = "emote",
    tier = "medium",
    text = {
      "Dance a jig under Shantay's Awning. Bow or curtsy before you talk to me. Equip a pointed blue snail helmet and an air staff."
    },
    area = { origin = { x = 3303, y = 3121, level = 0 }, size = { x = 4, y = 4 } },
    items = {
      { slot = zyklib.game.equipment.SLOTS.HEAD,     options = { config.Obj.SNELM_POINT_BLUE } },
      { slot = zyklib.game.equipment.SLOTS.MAINHAND, options = { config.Obj.DOM_AIR_STAFF } } },
    emotes = { "Jig", "Bow or Curtsy" },
    double_agent = false,
    hidey_hole = {
      config = "TRAIL17_STASH_21_SHANTAY_PASS",
      name = "Crate (hidey-hole)",
      location = { topleft = { x = 3302, y = 3130 }, botright = { x = 3302, y = 3130 }, level = 0 }
    }
  },
  {
    id = 249,
    type = "emote",
    tier = "medium",
    text = {
      "Think under the lens in the Observatory. Twirl before you talk to me. Equip a mithril chainbody, green dragonhide chaps and a ruby amulet."
    },
    area = { origin = { x = 2439, y = 3164, level = 1 }, size = { x = 3, y = 3 } },
    items = {
      { slot = zyklib.game.equipment.SLOTS.BODY, options = { config.Obj.MITHRIL_CHAINBODY } },
      { slot = zyklib.game.equipment.SLOTS.LEGS, options = { config.Obj.DRAGONHIDE_CHAPS } },
      { slot = zyklib.game.equipment.SLOTS.NECK, options = { config.Obj.STRUNG_RUBY_AMULET } } },
    emotes = { "Think", "Twirl" },
    double_agent = false,
    hidey_hole = {
      config = "TRAIL17_STASH_43_OBSERVATORY",
      location = { topleft = { x = 2445, y = 3161 }, botright = { x = 2445, y = 3161 }, level = 1 },
      name = "Crate (hidey-hole)"
    }
  },
  {
    id = 250,
    type = "emote",
    tier = "medium",
    text = {
      "Twirl on the bridge by Barbarian Village. Salute before you talk to me. Equip an iron hatchet, steel kiteshield and a mithril full helmet."
    },
    area = { origin = { x = 3102, y = 3420, level = 0 }, size = { x = 7, y = 2 } },
    items = {
      { slot = zyklib.game.equipment.SLOTS.MAINHAND, options = { config.Obj.IRON_AXE } },
      { slot = zyklib.game.equipment.SLOTS.OFFHAND,  options = { config.Obj.STEEL_KITESHIELD } },
      { slot = zyklib.game.equipment.SLOTS.HEAD,     options = { config.Obj.MITHRIL_FULL_HELM } } },
    emotes = { "Twirl", "Salute" },
    double_agent = false,
    hidey_hole = {
      config = "TRAIL17_STASH_42_GUNNARSGRUNN",
      name = "Rock (hidey-hole)",
      location = { topleft = { x = 3114, y = 3418 }, botright = { x = 3115, y = 3417 }, level = 0 }
    }
  },
  {
    id = 251,
    type = "emote",
    tier = "medium",
    text = {
      "Jump for joy in Yanille bank. Dance a jig before you talk to me. Equip an iron crossbow, adamant helmet and snakeskin chaps."
    },
    area = { origin = { x = 2609, y = 3088, level = 0 }, size = { x = 5, y = 10 } },
    items = {
      { slot = zyklib.game.equipment.SLOTS.MAINHAND, options = { config.Obj.XBOWS_CROSSBOW_IRON } },
      { slot = zyklib.game.equipment.SLOTS.HEAD,     options = { config.Obj.ADAMANT_MED_HELM } },
      { slot = zyklib.game.equipment.SLOTS.LEGS,     options = { config.Obj.SNAKESKIN_CHAPS } } },
    emotes = { "Jump for Joy", "Jig" },
    double_agent = false,
    hidey_hole = {
      config = "TRAIL17_STASH_29_YANILLE",
      name = "Crate (hidey-hole)",
      location = { topleft = { x = 2613, y = 3088 }, botright = { x = 2613, y = 3088 }, level = 0 }
    }
  },
  {
    id = 252,
    type = "emote",
    tier = "medium",
    text = {
      "Dance in the centre of Canifis. Bow or curtsy before you talk to me. Equip a spiny helmet, mithril platelegs and an iron two-handed sword."
    },
    area = { origin = { x = 3485, y = 3480, level = 0 }, size = { x = 19, y = 17 } },
    items = {
      { slot = zyklib.game.equipment.SLOTS.HEAD,     options = { config.Obj.WALLBEAST_SPIKE_HELMET } },
      { slot = zyklib.game.equipment.SLOTS.LEGS,     options = { config.Obj.MITHRIL_PLATELEGS } },
      { slot = zyklib.game.equipment.SLOTS.MAINHAND, options = { config.Obj.IRON_2H_SWORD } } },
    emotes = { "Dance", "Bow or Curtsy" },
    double_agent = false,
    hidey_hole = {
      config = "TRAIL17_STASH_24_CANIFIS",
      name = "Barrel (hidey-hole)",
      location = { topleft = { x = 3491, y = 3480 }, botright = { x = 3491, y = 3480 }, level = 0 }
    }
  },
  {
    id = 253,
    type = "emote",
    tier = "medium",
    text = {
      "Cheer in the Barbarian Agility Arena. Headbang before you talk to me. Equip a steel platebody, maple shortbow and bronze boots."
    },
    area = { origin = { x = 2528, y = 3542, level = 0 }, size = { x = 28, y = 18 } },
    items = {
      { slot = zyklib.game.equipment.SLOTS.BODY,     options = { config.Obj.STEEL_PLATEBODY } },
      { slot = zyklib.game.equipment.SLOTS.MAINHAND, options = { config.Obj.MAPLE_SHORTBOW } },
      { slot = zyklib.game.equipment.SLOTS.FEET,     options = { config.Obj.BRONZE_ARMOURED_BOOTS } } },
    emotes = { "Cheer", "Headbang" },
    double_agent = false,
    hidey_hole = {
      config = "TRAIL17_STASH_12_BARBARIAN_AGILITY",
      name = "Barrel (hidey-hole)",
      location = { topleft = { x = 2545, y = 3556 }, botright = { x = 2545, y = 3556 }, level = 0 }
    }
  },
  {
    id = 254,
    type = "emote",
    tier = "medium",
    text = {
      "Cry on the platform of the south-west tree in the Gnome Agility Arena. Indicate 'no' before you talk to me. Equip a steel kiteshield, ring of forging and green dragonhide chaps."
    },
    area = { origin = { x = 2472, y = 3418, level = 2 }, size = { x = 6, y = 4 } },
    items = {
      { slot = zyklib.game.equipment.SLOTS.LEGS,    options = { config.Obj.DRAGONHIDE_CHAPS } },
      { slot = zyklib.game.equipment.SLOTS.OFFHAND, options = { config.Obj.STEEL_KITESHIELD } },
      { slot = zyklib.game.equipment.SLOTS.RING,    options = { config.Obj.RING_OF_FORGING } } },
    emotes = { "Cry", "No" },
    double_agent = false,
    hidey_hole = {
      config = "TRAIL17_STASH_19_GNOME_AGILITY",
      name = "Tree stump (hidey-hole)",
      location = { topleft = { x = 2473, y = 3418 }, botright = { x = 2473, y = 3418 }, level = 2 }
    }
  },
  {
    id = 255,
    type = "emote",
    tier = "medium",
    text = {
      "Beckon in Tai Bwo Wannai. Clap before you talk to me. Equip green dragonhide chaps, a ring of duelling and a mithril helmet."
    },
    items = {
      { slot = zyklib.game.equipment.SLOTS.LEGS, options = { config.Obj.DRAGONHIDE_CHAPS } },
      { slot = zyklib.game.equipment.SLOTS.RING, options = { config.Obj.RING_OF_DUELING_CHARGED } },
      { slot = zyklib.game.equipment.SLOTS.HEAD, options = { config.Obj.MITHRIL_MED_HELM } } },
    emotes = { "Beckon", "Clap" },
    double_agent = false,
    area = { origin = { x = 2778, y = 3057, level = 0 }, size = { x = 33, y = 17 } },
    hidey_hole = {
      config = "TRAIL17_STASH_01_TAI_BWO_WANNAI",
      name = "Crate (hidey-hole)",
      location = { topleft = { x = 2793, y = 3073 }, botright = { x = 2793, y = 3073 }, level = 0 }
    }
  },
  {
    id = 256,
    type = "emote",
    tier = "medium",
    text = {
      "Cheer in the Ogre Pen in the Training Camp. Show you are angry before you talk to me. Equip a green dragonhide body and chaps, and a steel squareshield."
    },
    items = {
      { slot = zyklib.game.equipment.SLOTS.BODY,    options = { config.Obj.DRAGONHIDE_BODY } },
      { slot = zyklib.game.equipment.SLOTS.LEGS,    options = { config.Obj.DRAGONHIDE_CHAPS } },
      { slot = zyklib.game.equipment.SLOTS.OFFHAND, options = { config.Obj.STEEL_SQ_SHIELD } } },
    emotes = { "Cheer", "Angry" },
    double_agent = false,
    area = { origin = { x = 2523, y = 3373, level = 0 }, size = { x = 11, y = 5 } },
    hidey_hole = {
      config = "TRAIL17_STASH_14_COMBAT_TRAINING_CAMP",
      name = "Crate (hidey-hole)",
      location = { topleft = { x = 2521, y = 3377 }, botright = { x = 2521, y = 3377 }, level = 0 }
    }
  },
  {
    id = 257,
    type = "emote",
    tier = "medium",
    text = {
      "Cry in the Catherby archery shop. Bow or curtsy before you talk to me. Equip a round red and black snelm, a hard leather body and an unblessed silver sickle."
    },
    items = {
      { slot = zyklib.game.equipment.SLOTS.HEAD,     options = { config.Obj.SNELM_ROUND_REDPLUSBLACK } },
      { slot = zyklib.game.equipment.SLOTS.BODY,     options = { config.Obj.HARDLEATHER_BODY } },
      { slot = zyklib.game.equipment.SLOTS.MAINHAND, options = { config.Obj.SILVER_SICKLE } } },
    emotes = { "Cry", "Bow or Curtsy" },
    double_agent = false,
    area = { origin = { x = 2824, y = 3454, level = 0 }, size = { x = 6, y = 4 } },
    hidey_hole = {
      config = "TRAIL17_STASH_18_CATHERBY",
      name = "Crates (hidey-hole)",
      location = { topleft = { x = 2829, y = 3455 }, botright = { x = 2829, y = 3455 }, level = 0 }
    }
  },
  {
    id = 258,
    type = "emote",
    tier = "medium",
    text = {
      "Yawn in the Castle Wars lobby. Shrug before you talk to me. Equip a ruby amulet, mithril scimitar and an iron square shield."
    },
    items = {
      { slot = zyklib.game.equipment.SLOTS.NECK,     options = { config.Obj.STRUNG_RUBY_AMULET } },
      { slot = zyklib.game.equipment.SLOTS.MAINHAND, options = { config.Obj.MITHRIL_SCIMITAR } },
      { slot = zyklib.game.equipment.SLOTS.OFFHAND,  options = { config.Obj.IRON_SQ_SHIELD } } },
    emotes = { "Yawn", "Shrug" },
    double_agent = false,
    area = { origin = { x = 2436, y = 3080, level = 0 }, size = { x = 13, y = 20 } },
    hidey_hole = {
      config = "TRAIL17_STASH_49_CASTLE_WARS",
      name = "Stone blocks (hidey-hole)",
      location = { topleft = { x = 2448, y = 3088 }, botright = { x = 2448, y = 3087 }, level = 0 }
    }
  },
  {
    id = 225,
    type = "emote",
    tier = "hard",
    text = {
      "Panic in the heart of the Haunted Woods. Beware of double agents! Have no items equipped when you do."
    },
    emotes = { "Panic" },
    items = {
      { slot = zyklib.game.equipment.SLOTS.HEAD,     options = { nil } },
      { slot = zyklib.game.equipment.SLOTS.CAPE,     options = { nil } },
      { slot = zyklib.game.equipment.SLOTS.NECK,     options = { nil } },
      { slot = zyklib.game.equipment.SLOTS.MAINHAND, options = { nil } },
      { slot = zyklib.game.equipment.SLOTS.BODY,     options = { nil } },
      { slot = zyklib.game.equipment.SLOTS.LEGS,     options = { nil } },
      { slot = zyklib.game.equipment.SLOTS.HANDS,    options = { nil } },
      { slot = zyklib.game.equipment.SLOTS.FEET,     options = { nil } },
      { slot = zyklib.game.equipment.SLOTS.RING,     options = { nil } },
      { slot = zyklib.game.equipment.SLOTS.AMMO,     options = { nil } },
      { slot = zyklib.game.equipment.SLOTS.POCKET,   options = { nil } },
    },
    double_agent = true,
    area = { origin = { x = 3611, y = 3483, level = 0 }, size = { x = 11, y = 11 } },
    hidey_hole = nil
  },
  {
    id = 226,
    type = "emote",
    tier = "hard",
    text = {
      "Laugh in the Jokul's tent in the Mountain Camp. Beware of double agents! Equip a rune full helmet, blue dragonhide chaps and a fire battlestaff."
    },
    items = {
      { slot = zyklib.game.equipment.SLOTS.HEAD,     options = { config.Obj.RUNE_FULL_HELM } },
      { slot = zyklib.game.equipment.SLOTS.LEGS,     options = { config.Obj.BLUE_DRAGONHIDE_CHAPS } },
      { slot = zyklib.game.equipment.SLOTS.MAINHAND, options = { config.Obj.FIRE_BATTLESTAFF } } },
    emotes = { "Laugh" },
    double_agent = true,
    area = { origin = { x = 2790, y = 3667, level = 0 }, size = { x = 8, y = 9 } },
    hidey_hole = {
      config = "TRAIL17_STASH_30_MOUNTAIN_CAMP",
      name = "Rock (hidey-hole)",
      location = { topleft = { x = 2790, y = 3667 }, botright = { x = 2790, y = 3667 }, level = 0 }
    }
  },
  {
    id = 227,
    type = "emote",
    tier = "hard",
    text = {
      "Panic by the pilot on White Wolf Mountain. Beware of double agents! Equip mithril platelegs, a ring of life, and a rune hatchet."
    },
    items = {
      { slot = zyklib.game.equipment.SLOTS.LEGS,     options = { config.Obj.MITHRIL_PLATELEGS } },
      { slot = zyklib.game.equipment.SLOTS.RING,     options = { config.Obj.RING_OF_LIFE } },
      { slot = zyklib.game.equipment.SLOTS.MAINHAND, options = { config.Obj.RUNE_AXE } } },
    emotes = { "Panic" },
    double_agent = true,
    area = { origin = { x = 2843, y = 3489, level = 1 }, size = { x = 11, y = 10 } },
    hidey_hole = {
      config = "TRAIL17_STASH_33_WHITE_WOLF_MOUNTAIN",
      name = "Rock (hidey-hole)",
      location = { topleft = { x = 2845, y = 3496 }, botright = { x = 2845, y = 3496 }, level = 1 }
    }
  },
  {
    id = 228,
    type = "emote",
    tier = "hard",
    text = {
      "Salute in the banana plantation. Beware of double agents! Equip a diamond ring, amulet of power and nothing on your chest and legs."
    },
    items = {
      { slot = zyklib.game.equipment.SLOTS.RING, options = { config.Obj.DIAMOND_RING } },
      { slot = zyklib.game.equipment.SLOTS.NECK, options = { config.Obj.AMULET_OF_POWER } },
      { slot = zyklib.game.equipment.SLOTS.BODY, options = { nil } },
      { slot = zyklib.game.equipment.SLOTS.LEGS, options = { nil } },
    },
    emotes = { "Salute" },
    double_agent = true,
    area = { origin = { x = 2908, y = 3155, level = 0 }, size = { x = 27, y = 20 } },
    hidey_hole = {
      config = "TRAIL17_STASH_37_MUSA_POINT",
      name = "Log (hidey-hole)",
      location = { topleft = { x = 2914, y = 3154 }, botright = { x = 2914, y = 3154 }, level = 0 }
    }
  },
  {
    id = 229,
    type = "emote",
    tier = "hard",
    text = {
      "Dance at the cat-doored pyramid in Sophanem. Beware of double agents! Equip a ring of life, an amulet of glory and an adamant two-handed sword."
    },
    items = {
      { slot = zyklib.game.equipment.SLOTS.RING,     options = { config.Obj.RING_OF_LIFE } },
      { slot = zyklib.game.equipment.SLOTS.NECK,     options = { config.Obj.AMULET_OF_GLORY } },
      { slot = zyklib.game.equipment.SLOTS.MAINHAND, options = { config.Obj.ADAMANT_2H_SWORD } } },
    emotes = { "Dance" },
    double_agent = true,
    area = { origin = { x = 3292, y = 2781, level = 0 }, size = { x = 6, y = 4 } },
    hidey_hole = {
      config = "TRAIL17_STASH_22_SOPHANEM",
      name = "Crate (hidey-hole)",
      location = { topleft = { x = 3310, y = 2784 }, botright = { x = 3310, y = 2783 }, level = 0 }
    }
  },
  {
    id = 230,
    type = "emote",
    tier = "hard",
    text = {
      "Blow a raspberry in the Fishing Guild bank. Beware of double agents! Equip an elemental shield, blue dragonhide chaps and a rune warhammer."
    },
    area = { origin = { x = 2585, y = 3420, level = 0 }, size = { x = 3, y = 4 } },
    items = {
      { slot = zyklib.game.equipment.SLOTS.OFFHAND,  options = { config.Obj.ELEMENTAL_SHIELD } },
      { slot = zyklib.game.equipment.SLOTS.LEGS,     options = { config.Obj.BLUE_DRAGONHIDE_CHAPS } },
      { slot = zyklib.game.equipment.SLOTS.MAINHAND, options = { config.Obj.RUNE_WARHAMMER } } },
    emotes = { "Raspberry" },
    double_agent = true,
    hidey_hole = {
      config = "TRAIL17_STASH_05_FISHING_GUILD",
      location = { topleft = { x = 2585, y = 3424 }, botright = { x = 2585, y = 3424 }, level = 0 },
      name = "Crate (hidey-hole)"
    }
  },
  {
    id = 231,
    type = "emote",
    tier = "hard",
    text = {
      "Blow a kiss between the tables in Shilo Village bank. Beware of double agents! Equip a splitbark helm, mud pie and rune platebody."
    },
    items = {
      { slot = zyklib.game.equipment.SLOTS.HEAD,     options = { config.Obj.SPLITBARK_HELM } },
      { slot = zyklib.game.equipment.SLOTS.MAINHAND, options = { config.Obj.MUD_PIE } },
      { slot = zyklib.game.equipment.SLOTS.BODY,     options = { config.Obj.RUNE_PLATEBODY } } },
    emotes = { "Blow kiss" },
    double_agent = true,
    area = { origin = { x = 2851, y = 2952, level = 0 }, size = { x = 3, y = 4 } },
    hidey_hole = {
      config = "TRAIL17_STASH_03_SHILO_VILLAGE",
      name = "Potted plant (hidey-hole)",
      location = { topleft = { x = 2856, y = 2954 }, botright = { x = 2857, y = 2953 }, level = 0 }
    }
  },
  {
    id = 232,
    type = "emote",
    tier = "hard",
    text = {
      "Bow or curtsy at the top of the lighthouse. Beware of double agents! Equip a blue dragonhide body, blue dragonhide vambraces and no jewellery."
    },
    area = { origin = { x = 2504, y = 3636, level = 2 }, size = { x = 10, y = 10 } },
    items = {
      { slot = zyklib.game.equipment.SLOTS.BODY,  options = { config.Obj.BLUE_DRAGONHIDE_BODY } },
      { slot = zyklib.game.equipment.SLOTS.HANDS, options = { config.Obj.BLUE_DRAGON_VAMBRACES } },
      { slot = zyklib.game.equipment.SLOTS.RING,  options = { nil } },
      { slot = zyklib.game.equipment.SLOTS.NECK,  options = { nil } },
    },
    emotes = { "Bow or Curtsy" },
    double_agent = true,
    hidey_hole = {
      config = "TRAIL17_STASH_07_LIGHTHOUSE",
      location = { topleft = { x = 2512, y = 3639 }, botright = { x = 2512, y = 3639 }, level = 2 },
      name = "Crate (hidey-hole)"
    }
  },
  {
    id = 235,
    type = "emote",
    tier = "hard",
    text = {
      "Yawn near the Wilderness Bandit camp obelisk. Beware of double agents! Equip an iron square shield, blue dragon vambraces and an iron pickaxe."
    },
    items = {
      { slot = zyklib.game.equipment.SLOTS.OFFHAND,  options = { config.Obj.IRON_SQ_SHIELD } },
      { slot = zyklib.game.equipment.SLOTS.HANDS,    options = { config.Obj.BLUE_DRAGON_VAMBRACES } },
      { slot = zyklib.game.equipment.SLOTS.MAINHAND, options = { config.Obj.IRON_PICKAXE } } },
    emotes = { "Yawn" },
    area = { origin = { x = 3031, y = 3728, level = 0 }, size = { x = 9, y = 9 } },
    hidey_hole = {
      config = "TRAIL17_STASH_50_BANDIT_CAMP",
      name = "Dead tree (hidey-hole)",
      location = { topleft = { x = 3031, y = 3723 }, botright = { x = 3032, y = 3722 }, level = 0 }
    },
    double_agent = true
  },
  {
    id = 243,
    type = "emote",
    tier = "hard",
    text = {
      "Shrug in the Zamorak temple, found in the eastern Wilderness. Beware of double agents! Equip bronze platelegs, an iron platebody and blue dragonhide vambraces."
    },
    items = {
      { slot = zyklib.game.equipment.SLOTS.LEGS,  options = { config.Obj.BRONZE_PLATELEGS } },
      { slot = zyklib.game.equipment.SLOTS.BODY,  options = { config.Obj.IRON_PLATEBODY } },
      { slot = zyklib.game.equipment.SLOTS.HANDS, options = { config.Obj.BLUE_DRAGON_VAMBRACES } } },
    emotes = { "Shrug" },
    area = { origin = { x = 3234, y = 3603, level = 0 }, size = { x = 12, y = 12 } },
    double_agent = true,
    hidey_hole = {
      config = "TRAIL17_STASH_39_CHAOS_TEMPLE",
      name = "Rock (hidey-hole)",
      location = { topleft = { x = 3245, y = 3610 }, botright = { x = 3245, y = 3610 }, level = 0 }
    }
  },
  {
    id = 233,
    type = "emote",
    tier = "master",
    text = {
      "Cheer by the sulphur pit in the TzHaar City. Beware of double agents! Equip a fire cape, a Toktz-ket-xil and a spork."
    },
    area = { origin = { x = 4630, y = 5104, level = 0 }, size = { x = 14, y = 14 } },
    items = {
      { slot = zyklib.game.equipment.SLOTS.CAPE,     options = { config.Obj.TZHAAR_CAPE_FIRE } },
      { slot = zyklib.game.equipment.SLOTS.OFFHAND,  options = { config.Obj.TZHAAR_SPIKESHIELD } },
      { slot = zyklib.game.equipment.SLOTS.MAINHAND, options = { config.Obj.HUNDRED_SPORK } } },
    emotes = { "Cheer" },
    double_agent = true,
    hidey_hole = {
      config = "TRAIL17_STASH_52_TZHAAR_CITY",
      name = "Table (hidey-hole)",
      location = { topleft = { x = 4638, y = 5106 }, botright = { x = 4638, y = 5106 }, level = 0 }
    }
  },
  {
    id = 234,
    type = "emote",
    tier = "master",
    text = {
      "Headbang inside the Slayer Tower. Beware of double agents! Equip an imp-hide hood, a Prifddinian musician's robe top and an amulet of magic."
    },
    emotes = { "Headbang" },
    area = { origin = { x = 3400, y = 3541, level = 0 }, size = { x = 47, y = 34 } },
    items = {
      { slot = zyklib.game.equipment.SLOTS.HEAD, options = { config.Obj.IMPHIDE_HOOD } },
      { slot = zyklib.game.equipment.SLOTS.BODY, options = { config.Obj.ELFCITY_MUSICIAN_BODY } },
      { slot = zyklib.game.equipment.SLOTS.NECK, options = { config.Obj.AMULET_OF_MAGIC } } },
    double_agent = true,
    hidey_hole = {
      config = "TRAIL17_STASH_55_SLAYER_TOWER",
      name = "Crates (hidey-hole)",
      location = { topleft = { x = 3427, y = 3541 }, botright = { x = 3427, y = 3541 }, level = 0 }
    }
  },
  {
    id = 236,
    type = "emote",
    tier = "master",
    text = {
      "Dare to laugh in the Green Ghost inn at Port Phasmatys. Beware of double agents! Equip an Iban's staff, a ghostly cloak and a cavalier."
    },
    emotes = { "Laugh" },
    items = {
      { slot = zyklib.game.equipment.SLOTS.MAINHAND, options = { config.Obj.IBANSTAFF } },
      { slot = zyklib.game.equipment.SLOTS.CAPE,     options = { config.Obj.SECRET_GHOST_CLOAK } },
      {
        slot = zyklib.game.equipment.SLOTS.HEAD,
        options = {
          config.Obj.CAVALIER_BROWN,
          config.Obj.CAVALIER_DARK,
          config.Obj.CAVALIER_BLACK,
          config.Obj.TRAIL17_CAVALIER_GILDED,
          config.Obj.PIRATE_HAT_CAVALIER_HIGHWAY_MASK,
          config.Obj.TRAIL17_CAVALIER_GILDED_HIGHWAY_MASK,
        }
      }
    },
    double_agent = true,
    area = { origin = { x = 3671, y = 3489, level = 0 }, size = { x = 11, y = 11 } },
    hidey_hole = {
      config = "TRAIL17_STASH_56_PORT_PHASMATYS",
      name = "Barrel (hidey-hole)",
      location = { topleft = { x = 3676, y = 3494 }, botright = { x = 3676, y = 3494 }, level = 0 }
    }
  },
  {
    id = 237,
    type = "emote",
    tier = "master",
    text = {
      "Blow a Raspberry at the celestial dragons on Dragontooth Isle. Beware of double agents! Equip a dragon mask, a Dragon Rider amulet and a dragon defender."
    },
    double_agent = true,
    area = { origin = { x = 2242, y = 5956, level = 0 }, size = { x = 60, y = 57 } },
    items = {
      {
        slot = zyklib.game.equipment.SLOTS.HEAD,
        options = {
          config.Obj.TRAIL_GREENDRAGON_HEAD,
          config.Obj.TRAIL_BLUEDRAGON_HEAD,
          config.Obj.TRAIL_REDDRAGON_HEAD,
          config.Obj.TRAIL_BLACKDRAGON_HEAD,
          config.Obj.TRAIL_FROSTDRAGON_HEAD,
          config.Obj.TRAIL_BRONZEDRAGON_HEAD,
          config.Obj.TRAIL_IRONDRAGON_HEAD,
          config.Obj.TRAIL_STEELDRAGON_HEAD,
          config.Obj.TRAIL_MITHRILDRAGON_HEAD,
          config.Obj.TRAIL17_ADAMANT_DRAGON_HEAD,
          config.Obj.TRAIL17_DRAGONSTONE_DRAGON_HEAD,
          config.Obj.TRAIL17_ONYX_DRAGON_HEAD,
          config.Obj.TRAIL17_RUNE_DRAGON_HEAD,
          config.Obj.TRAIL17_HYDRIX_DRAGON_HEAD,
        }
      },
      { slot = zyklib.game.equipment.SLOTS.NECK,    options = { config.Obj.OOAK_DRAGONRIDER_AMULET } },
      { slot = zyklib.game.equipment.SLOTS.OFFHAND, options = { config.Obj.DRAGON_PARRYINGDAGGER } } },
    emotes = { "Raspberry" },
    hidey_hole = {
      config = "TRAIL17_STASH_60_CELESTIAL_DRAGONS",
      name = "Rock (hidey-hole)",
      location = { topleft = { x = 2277, y = 5966 }, botright = { x = 2277, y = 5965 }, level = 0 }
    }
  },
  {
    id = 238,
    type = "emote",
    tier = "master",
    text = {
      "Wave in front of the entrance to the Grand Library of Menaphos. Beware of double agents! Equip an asylum surgeon's ring and the Scabaras mask."
    },
    area = { origin = { x = 3173, y = 2708, level = 0 }, size = { x = 3, y = 4 } },
    items = {
      { slot = zyklib.game.equipment.SLOTS.RING, options = { config.Obj.HOUSE_RING_HIGH } },
      { slot = zyklib.game.equipment.SLOTS.HEAD, options = { config.Obj.OZAN2_TOMB_MASK_SCABARAS } } },
    emotes = { "Wave" },
    double_agent = true,
    hidey_hole = {
      config = "TRAIL17_STASH_57_MENAPHOS_LIBRARY",
      name = "Plant (hidey-hole)",
      location = { topleft = { x = 3172, y = 2711 }, botright = { x = 3172, y = 2711 }, level = 0 }
    }
  },
  {
    id = 239,
    type = "emote",
    tier = "master",
    text = {
      "Jig in the Edgeville Monastery garden. Beware of double agents! Equip a holy cithara, Saradomin's murmur and a ring of devotion."
    },
    emotes = { "Jig" },
    items = {
      { slot = zyklib.game.equipment.SLOTS.OFFHAND, options = { config.Obj.OPN_CITHARA } },
      { slot = zyklib.game.equipment.SLOTS.NECK,    options = { config.Obj.GODWARS_AMULET_RANGE } },
      { slot = zyklib.game.equipment.SLOTS.RING,    options = { config.Obj.RING_OF_PRAYER } } },
    double_agent = true,
    area = { origin = { x = 3046, y = 3501, level = 0 }, size = { x = 12, y = 8 } },
    hidey_hole = {
      config = "TRAIL17_STASH_63_EDGEVILLE_MONASTERY",
      name = "Barrel (hidey-hole)",
      location = { topleft = { x = 3056, y = 3499 }, botright = { x = 3056, y = 3499 }, level = 0 }
    }
  },
  {
    id = 240,
    type = "emote",
    tier = "master",
    text = {
      "Bow or curtsy at the charm sprite hunter area. Beware of double agents! Equip an enhanced yaktwee stick, a Dagon-hai hat and an amulet of ranging."
    },
    items = {
      { slot = zyklib.game.equipment.SLOTS.MAINHAND, options = { config.Obj.HUNTCHARM_STAVE_ENHANCED } },
      { slot = zyklib.game.equipment.SLOTS.HEAD,     options = { config.Obj.LUC2_DAGONHAI_HAT } },
      { slot = zyklib.game.equipment.SLOTS.NECK,     options = { config.Obj.AMULET_OF_RANGING } } },
    area = { origin = { x = 2391, y = 3362, level = 0 }, size = { x = 26, y = 22 } },
    emotes = { "Bow or Curtsy" },
    double_agent = true,
    hidey_hole = {
      config = "TRAIL17_STASH_53_CHARM_SPRITE",
      name = "Rock (hidey-hole)",
      location = { topleft = { x = 2398, y = 3369 }, botright = { x = 2398, y = 3368 }, level = 0 }
    }
  },
  {
    id = 241,
    type = "emote",
    tier = "master",
    text = {
      "Think in the Hefin district of Prifddinas. Beware of double agents! Equip an ancient staff, Prifddinian worker's trousers and a berserker ring."
    },
    emotes = { "Think" },
    items = {
      { slot = zyklib.game.equipment.SLOTS.MAINHAND, options = { config.Obj.STAFF_OF_ZAROS } },
      { slot = zyklib.game.equipment.SLOTS.LEGS,     options = { config.Obj.ELFCITY_SKILLER_LEGS } },
      { slot = zyklib.game.equipment.SLOTS.RING,     options = { config.Obj.BERZERKER_RING } } },
    area = { origin = { x = 2174, y = 3393, level = 1 }, size = { x = 30, y = 22 } },
    double_agent = true,
    hidey_hole = {
      config = "TRAIL17_STASH_62_HEFIN_DISTRICT",
      name = "Potted plant (hidey-hole)",
      location = { topleft = { x = 2181, y = 3402 }, botright = { x = 2181, y = 3402 }, level = 1 }
    }
  },
  {
    id = 242,
    type = "emote",
    tier = "master",
    text = {
      "Shrug in the Lumbridge Fishing Supplies shop. Beware of double agents! Equip demon slayer gloves, a boater and the cape of legends."
    },
    area = { origin = { x = 3194, y = 3251, level = 0 }, size = { x = 5, y = 8 } },
    items = {
      { slot = zyklib.game.equipment.SLOTS.HANDS, options = { config.Obj.DND_SUMMON_ARMOUR_GLOVES } },
      {
        slot = zyklib.game.equipment.SLOTS.HEAD,
        options = {
          config.Obj.STRAWBOATER_RED,
          config.Obj.STRAWBOATER_ORANGE,
          config.Obj.STRAWBOATER_GREEN,
          config.Obj.STRAWBOATER_BLUE,
          config.Obj.STRAWBOATER_BLACK,
          config.Obj.TRAIL17_STRAWBOATER_GILDED,
        }
      },
      { slot = zyklib.game.equipment.SLOTS.CAPE,  options = { config.Obj.CAPE_OF_LEGENDS } } },
    emotes = { "Shrug" },
    double_agent = true,
    hidey_hole = {
      config = "TRAIL17_STASH_61_LUMBRIDGE_FISHING",
      name = "Barrel (hidey-hole)",
      location = { topleft = { x = 3198, y = 3258 }, botright = { x = 3198, y = 3258 }, level = 0 }
    }
  },
  {
    id = 244,
    type = "emote",
    tier = "master",
    text = {
      "Have an idea inside the Invention Guild. Beware of double agents! Equip a lab coat top, lab coat legs and a staff of light."
    },
    items = {
      { slot = zyklib.game.equipment.SLOTS.BODY,     options = { config.Obj.INVENT_LABCOAT_TORSO } },
      { slot = zyklib.game.equipment.SLOTS.LEGS,     options = { config.Obj.INVENT_LABCOAT_LEGS } },
      { slot = zyklib.game.equipment.SLOTS.MAINHAND, options = { config.Obj.STAFF_OF_LIGHT } } },
    emotes = { "Idea" },
    area = { origin = { x = 6160, y = 1039, level = 0 }, size = { x = 18, y = 36 } },
    double_agent = true,
    hidey_hole = {
      config = "TRAIL17_STASH_58_INVENTION_GUILD",
      name = "Barrel (hidey-hole)",
      location = { topleft = { x = 6176, y = 1050 }, botright = { x = 6176, y = 1050 }, level = 0 }
    }
  },
  {
    id = 245,
    type = "emote",
    tier = "master",
    text = {
      "Dance on an Uncharted Isle. Beware of double agents! Equip a dark bow, some infinity boots and culinaromancer gloves 10."
    },
    area = { origin = { x = 1185, y = 7372, level = 0 }, size = { x = 21, y = 22 } },
    items = {
      { slot = zyklib.game.equipment.SLOTS.MAINHAND, options = { config.Obj.DARKBOW } },
      { slot = zyklib.game.equipment.SLOTS.FEET,     options = { config.Obj.MAGICTRAINING_INFINITYBOOTS } },
      { slot = zyklib.game.equipment.SLOTS.HANDS,    options = { config.Obj.HUNDRED_GAUNTLETS_LEVEL_10 } } },
    emotes = { "Dance" },
    double_agent = true,
    hidey_hole = {
      config = "TRAIL17_STASH_54_UNCHARTED_ISLE",
      location = {
        topleft = { x = 1818, y = 11653 },
        botright = { x = 1818, y = 11653 },
        level = 0
      },
      name = "Water barrel (hidey-hole)"
    }
  },
  {
    id = 246,
    type = "emote",
    tier = "master",
    text = {
      "Salute in the Max Guild Garden. Beware of double agents! Have no items equipped when you do."
    },
    area = { origin = { x = 2268, y = 3318, level = 1 }, size = { x = 17, y = 18 } },
    items = {
      { slot = zyklib.game.equipment.SLOTS.HEAD,     options = { nil } },
      { slot = zyklib.game.equipment.SLOTS.CAPE,     options = { nil } },
      { slot = zyklib.game.equipment.SLOTS.NECK,     options = { nil } },
      { slot = zyklib.game.equipment.SLOTS.MAINHAND, options = { nil } },
      { slot = zyklib.game.equipment.SLOTS.BODY,     options = { nil } },
      { slot = zyklib.game.equipment.SLOTS.LEGS,     options = { nil } },
      { slot = zyklib.game.equipment.SLOTS.HANDS,    options = { nil } },
      { slot = zyklib.game.equipment.SLOTS.FEET,     options = { nil } },
      { slot = zyklib.game.equipment.SLOTS.RING,     options = { nil } },
      { slot = zyklib.game.equipment.SLOTS.AMMO,     options = { nil } },
      { slot = zyklib.game.equipment.SLOTS.POCKET,   options = { nil } },
    },
    emotes = { "Salute" },
    hidey_hole = nil,
    double_agent = true
  },
  {
    id = 14,
    type = "anagram",
    tier = "medium",
    text = { "This anagram reveals who to speak to next: Eek Zero Op" },
    challenge = {
      {
        type = "challengescroll",
        question = "How many camels live in the zoo?",
        answers = { { answer = 3 } }
      }
    },
    solution = {
      type = "talkto",
      npc = "Zookeeper",
      npc_configs = {
        { domain = "npc", name = "ZOO_KEEPER" },
        { domain = "npc", name = "ZOO_KEEPER2" },
        { domain = "npc", name = "ZOO_KEEPER3" }
      },
      spots = {
        {
          range = { origin = { x = 2607, y = 3268, level = 0 }, size = { x = 14, y = 14 } },
          description = "in Ardougne Zoo"
        }
      }
    },
    anagram = { "Eek Zero Op" }
  },
  {
    id = 24,
    type = "anagram",
    tier = "medium",
    text = {
      "This anagram reveals who to speak to next: Stab Ob",
      "This anagram reveals who to speak to next: Boast B"
    },
    solution = {
      type = "talkto",
      spots = {
        {
          id = "before-death-plateu",
          description = "in his cave near Burthorpe",
          range = { origin = { x = 2267, y = 4752, level = 0 }, size = { x = 5, y = 9 } },
          note = "Before 'Death Plateu'"
        },
        {
          id = "after-death-plateau",
          description = "in the tunnel to Death Plateau",
          range = { origin = { x = 3401, y = 4282, level = 2 }, size = { x = 5, y = 5 } },
          note = "After 'Death Plateau'"
        }
      },
      npc = "Sabbot",
      npc_configs = {
        { domain = "npc", name = "DEATH_SABBOT" },
        { domain = "npc", name = "DEATH_SABBOT_MINING" },
        { domain = "npc", name = "DEATH_SABBOT_CAVE_MULTI" },
        { domain = "npc", name = "DEATH_SABBOT_TUNNEL_MULTI" }
      }
    },
    anagram = { "Stab Ob", "Boast B" }
  },
  {
    id = 318,
    type = "anagram",
    tier = "medium",
    text = { "This anagram reveals who to speak to next: Nod med" },
    challenge = {
      {
        type = "challengescroll",
        question = "How many pigeon cages are there around the back of Jerico's house?",
        answers = { { answer = 3 } }
      }
    },
    solution = {
      type = "talkto",
      npc = "Edmond",
      npc_configs = { { domain = "npc", name = "EDMOND" }, { domain = "npc", name = "EDMOND_TOP" } },
      spots = {
        {
          range = { origin = { x = 2564, y = 3330, level = 0 }, size = { x = 7, y = 7 } },
          description = "north of Ardougne castle"
        }
      }
    },
    anagram = { "Nod med" }
  },
  {
    id = 320,
    type = "anagram",
    tier = "medium",
    text = { "This anagram reveals who to speak to next: Winston Lane" },
    challenge = {
      {
        type = "challengescroll",
        question = "How many tables are there in the Pick and Lute Inn?",
        answers = { { answer = 10 } }
      }
    },
    solution = {
      type = "talkto",
      npc = "Nails Newton",
      npc_configs = { { domain = "npc", name = "LTEP_NAILS" } },
      spots = {
        {
          range = { origin = { x = 2881, y = 3444, level = 0 } },
          description = "near Taverley Lodestone"
        }
      }
    },
    anagram = { "Winston Lane" }
  },
  {
    id = 321,
    type = "anagram",
    tier = "medium",
    text = { "This anagram reveals who to speak to next: Or A Vile" },
    challenge = {
      {
        type = "challengescroll",
        question = "How many windows look out into the Citharede Abbey courtyard?",
        answers = { { answer = 17 } }
      }
    },
    solution = {
      type = "talkto",
      npc = "Valerio",
      npc_configs = {
        { domain = "npc", name = "OPN_VALERIO_OUTSIDE_DURINGQUEST_APPEARANCE" },
        { domain = "npc", name = "OPN_VALERIO_OUTSIDE_POSTQUEST_APPEARANCE" },
        { domain = "npc", name = "OPN_VALERIO_OUTSIDE" }
      },
      spots = {
        {
          range = { origin = { x = 3400, y = 3149, level = 0 } },
          description = "outside of the abbey"
        }
      }
    },
    anagram = { "Or A Vile" }
  },
  {
    id = 322,
    type = "anagram",
    tier = "medium",
    text = { "This anagram reveals who to speak to next: Icy Fe" },
    solution = {
      type = "talkto",
      npc = "Fycie",
      npc_configs = { { domain = "npc", name = "FYCIE" } },
      spots = {
        {
          range = { origin = { x = 2646, y = 9390, level = 0 }, size = { x = 8, y = 9 } },
          description = "in Rantz's cave"
        }
      }
    },
    anagram = { "Icy Fe" }
  },
  {
    id = 323,
    type = "anagram",
    tier = "medium",
    text = { "This anagram reveals who to speak to next: Aha Jar" },
    solution = {
      type = "talkto",
      npc = "Jaraah",
      npc_configs = { { domain = "npc", name = "DUEL_JARAAH" } },
      spots = {
        {
          range = { origin = { x = 3290, y = 3215, level = 0 }, size = { x = 8, y = 5 } },
          description = "at the northern end of Al Kharid"
        }
      }
    },
    anagram = { "Aha Jar" }
  },
  {
    id = 326,
    type = "anagram",
    tier = "medium",
    text = { "This anagram reveals who to speak to next: Bail Trims" },
    solution = {
      type = "talkto",
      spots = {
        {
          range = { origin = { x = 2405, y = 9815, level = 0 }, size = { x = 9, y = 8 } },
          description = "in his cave at Tree Gnome Stronghold"
        }
      },
      npc = "Brimstail",
      npc_configs = { { domain = "npc", name = "GNOME_BRIMSTAIL" } }
    },
    anagram = { "Bail Trims" }
  },
  {
    id = 327,
    type = "anagram",
    tier = "medium",
    text = { "This anagram reveals who to speak to next: Ok Co" },
    challenge = {
      {
        type = "challengescroll",
        question = "How many cannons does Lumbridge Castle have?",
        answers = { { answer = 7 } }
      }
    },
    solution = {
      type = "talkto",
      npc = "Cook",
      npc_configs = { { domain = "npc", name = "COOK" } },
      spots = {
        {
          range = { origin = { x = 3208, y = 3215, level = 0 }, size = { x = 3, y = 1 } },
          description = "in Lumbridge Castle's kitchen"
        }
      }
    },
    anagram = { "Ok Co" }
  },
  {
    id = 328,
    type = "anagram",
    tier = "medium",
    text = { "This anagram reveals who to speak to next: Are Col" },
    challenge = {
      {
        type = "challengescroll",
        question = "If x is 15 and y is 3, what is 3x + y? ",
        answers = { { answer = 48 } }
      }
    },
    solution = {
      type = "talkto",
      npc = "Oracle",
      npc_configs = { { domain = "npc", name = "ORACLE" } },
      spots = {
        {
          range = { origin = { x = 3008, y = 3498, level = 0 }, size = { x = 12, y = 6 } },
          description = "on the peak of Ice Mountain"
        }
      }
    },
    anagram = { "Are Col" }
  },
  {
    id = 329,
    type = "anagram",
    tier = "medium",
    text = { "This anagram reveals who to speak to next: Arc O Line" },
    challenge = {
      {
        type = "challengescroll",
        question = "How many fishermen are there on the Fishing Platform?",
        answers = {
          { answer = 11, note = "Before 'Kennith's Concerns'" },
          { answer = 0,  note = "After 'Kennith's Concerns'" }
        }
      }
    },
    solution = {
      type = "talkto",
      npc = "Caroline",
      npc_configs = {
        { domain = "npc", name = "CAROLINE" },
        { domain = "npc", name = "CAROLINE_MULTI" },
        { domain = "npc", name = "KEN_CAROLINE_INSIDEHOUSE" }
      },
      spots = {
        {
          id = "default",
          description = "in Witchhaven",
          range = { origin = { x = 2713, y = 3290, level = 0 }, size = { x = 6, y = 16 } },
          note = "Before 'Sea Slug'"
        },
        {
          range = { origin = { x = 2708, y = 3280, level = 1 }, size = { x = 5, y = 6 } },
          description = "in her house in Witchhaven",
          note = "After 'Sea Slug'."
        }
      }
    },
    anagram = { "Arc O Line" }
  },
  {
    id = 330,
    type = "anagram",
    tier = "medium",
    text = { "This anagram reveals who to speak to next: Goblin Kern" },
    solution = {
      type = "talkto",
      spots = {
        {
          range = { origin = { x = 2540, y = 3167, level = 0 }, size = { x = 3, y = 5 } },
          description = "in Tree Gnome Village"
        }
      },
      npc = "King Bolren",
      npc_configs = { { domain = "npc", name = "KING_BOLREN" } }
    },
    anagram = { "Goblin Kern" }
  },
  {
    id = 471,
    type = "anagram",
    tier = "medium",
    text = { "This anagram reveals who to speak to next: HE ANY FURTHER" },
    challenge = {
      {
        type = "challengescroll",
        question = "How many ore rocks are there in the nearby copper and tin mine?",
        answers = { { answer = 8 } }
      }
    },
    solution = {
      type = "talkto",
      npc = "Father Urhney",
      npc_configs = { { domain = "npc", name = "FATHER_URHNEY" } },
      spots = {
        {
          range = { origin = { x = 3203, y = 3147, level = 0 }, size = { x = 8, y = 5 } },
          description = "in the Lumbridge swamp"
        }
      }
    },
    anagram = { "HE ANY FURTHER" }
  },
  {
    id = 332,
    type = "anagram",
    tier = "medium",
    text = { "This anagram reveals who to speak to next: Dt Run B" },
    challenge = {
      {
        type = "challengescroll",
        question = "How many people are waiting for the next bard to perform?",
        answers = { { answer = 4 } }
      }
    },
    solution = {
      type = "talkto",
      npc = "Brundt the Chieftain",
      npc_configs = { { domain = "npc", name = "VIKING_BRUNDT" } },
      spots = {
        {
          range = { origin = { x = 2657, y = 3666, level = 0 }, size = { x = 4, y = 5 } },
          description = "in Relekka Longhall"
        }
      }
    },
    anagram = { "Dt Run B" }
  },
  {
    id = 334,
    type = "anagram",
    tier = "medium",
    text = { "This anagram reveals who to speak to next: Me if" },
    solution = {
      type = "talkto",
      spots = {
        {
          range = { origin = { x = 2457, y = 3380, level = 0 }, size = { x = 5, y = 3 } },
          description = "at gates of Tree Gnome Stronghold"
        }
      },
      npc = "Femi",
      npc_configs = { { domain = "npc", name = "GRANDTREE_FEMI" } }
    },
    anagram = { "Me if" }
  },
  {
    id = 335,
    type = "anagram",
    tier = "medium",
    text = { "This anagram reveals who to speak to next: R Ak Mi" },
    challenge = {
      {
        type = "challengescroll",
        question =
        "I have 16 kebabs, I eat one myself and share the rest equally between 3 friends. How many do they have each?",
        answers = { { answer = 5 } }
      }
    },
    solution = {
      type = "talkto",
      npc = "Karim",
      npc_configs = { { domain = "npc", name = "KEBAB_SELLER" } },
      spots = {
        {
          range = {
            origin = { x = 3269, y = 3181, level = 0 },
            size = { x = 3, y = 4 },
            data = "/g8="
          },
          description = "in Al Kharid"
        }
      }
    },
    anagram = { "R Ak Mi" }
  },
  {
    id = 336,
    type = "anagram",
    tier = "medium",
    text = { "This anagram reveals who to speak to next: Got A Boy" },
    challenge = {
      {
        type = "challengescroll",
        question = "How many buildings are in the village?",
        answers = { { answer = 11 } }
      }
    },
    solution = {
      type = "talkto",
      npc = "Gabooty",
      npc_configs = {
        { domain = "npc", name = "TBWCU_GABOOTY" },
        { domain = "npc", name = "TBWCU_GABOOTY_NOSTICKS" },
        { domain = "npc", name = "TBWCU_GABOOTY_MULTINPC" }
      },
      spots = {
        {
          range = { origin = { x = 2786, y = 3063, level = 0 }, size = { x = 16, y = 8 } },
          description = "in Tai Bwo Wannai Village"
        }
      }
    },
    anagram = { "Got A Boy" }
  },
  {
    id = 337,
    type = "anagram",
    tier = "medium",
    text = { "This anagram reveals who to speak to next: Halt Us" },
    solution = {
      type = "talkto",
      spots = {
        {
          range = { origin = { x = 2935, y = 3152, level = 0 }, size = { x = 7, y = 5 } },
          description = "at Musa Point"
        }
      },
      npc = "Luthas",
      npc_configs = { { domain = "npc", name = "LUTHAS" } }
    },
    anagram = { "Halt Us" }
  },
  {
    id = 338,
    type = "anagram",
    tier = "medium",
    text = { "This anagram reveals who to speak to next: Err Cure It" },
    challenge = {
      {
        type = "challengescroll",
        question = "How many houses have a cross on the door?",
        answers = { { answer = 20 } }
      }
    },
    solution = {
      type = "talkto",
      npc = "Recruiter",
      npc_configs = { { domain = "npc", name = "RECRUITER" } },
      spots = {
        {
          range = { origin = { x = 2539, y = 3302, level = 0 }, size = { x = 6, y = 7 } },
          description = "in West Ardougne"
        }
      }
    },
    anagram = { "Err Cure It" }
  },
  {
    id = 339,
    type = "anagram",
    tier = "medium",
    text = { "This anagram reveals who to speak to next: Iz A Ammo Load For Mrs Yakkers" },
    challenge = {
      {
        type = "challengescroll",
        question = "How many bottles are there on the stall to the east of Mr Ex?",
        answers = {
          { answer = 5, note = "Edgeville intact" },
          { answer = 3, note = "Edgeville destroyed" }
        }
      }
    },
    solution = {
      type = "talkto",
      npc = "Moldark, Emissary of Zamorak",
      npc_configs = { { domain = "npc", name = "GODEM_ZAMORAK_EMISSARY" } },
      spots = {
        {
          range = { origin = { x = 3104, y = 3508, level = 0 }, size = { x = 2, y = 3 } },
          description = "in Edgeville"
        }
      }
    },
    anagram = { "Iz A Ammo Load For Mrs Yakkers" }
  },
  {
    id = 340,
    type = "anagram",
    tier = "medium",
    text = { "This anagram reveals who to speak to next: Im Krom" },
    challenge = {
      {
        type = "challengescroll",
        question = "How many rocks in the Rimmington mine cannot be used to make bronze?",
        answers = { { answer = 7 } }
      }
    },
    solution = {
      type = "talkto",
      npc = "Rommik",
      npc_configs = { { domain = "npc", name = "ROMMIK" } },
      spots = {
        {
          range = { origin = { x = 2945, y = 3193, level = 0 }, size = { x = 6, y = 7 } },
          description = "in Rimmington"
        }
      }
    },
    anagram = { "Im Krom" }
  },
  {
    id = 341,
    type = "anagram",
    tier = "medium",
    text = { "This anagram reveals who to speak to next: El Ow" },
    solution = {
      type = "talkto",
      spots = {
        {
          range = { origin = { x = 3230, y = 3420, level = 0 }, size = { x = 7, y = 3 } },
          description = "in Varrock's Archery Store"
        }
      },
      npc = "Lowe",
      npc_configs = { { domain = "npc", name = "LOWE" } }
    },
    anagram = { "El Ow" }
  },
  {
    id = 342,
    type = "anagram",
    tier = "medium",
    text = { "This anagram reveals who to speak to next: Peaty Pert" },
    solution = {
      type = "talkto",
      spots = {
        {
          range = { origin = { x = 3048, y = 3372, level = 0 }, size = { x = 7, y = 7 } },
          description = "in the Party Room"
        }
      },
      npc = "Party Pete",
      npc_configs = { { domain = "npc", name = "PARTYROOM_PETE" } }
    },
    anagram = { "Peaty Pert" }
  },
  {
    id = 343,
    type = "anagram",
    tier = "medium",
    text = { "This anagram reveals who to speak to next: Lark In Dog" },
    challenge = {
      {
        type = "challengescroll",
        question = "How many bookcases are there in the Varrock Palace library?",
        answers = { { answer = 24 } }
      }
    },
    solution = {
      type = "talkto",
      npc = "King Roald",
      npc_configs = { { domain = "npc", name = "KING_ROALD" } },
      spots = {
        {
          range = { origin = { x = 3217, y = 3471, level = 0 }, size = { x = 8, y = 8 } },
          description = "in Varrock Castle"
        }
      }
    },
    anagram = { "Lark In Dog" }
  },
  {
    id = 20,
    type = "anagram",
    tier = "hard",
    text = {
      "This anagram reveals who to speak to next: Me Am The Calc",
      "This anagram reveals who to speak to next: Ace Match Elm",
      "This anagram reveals who to speak to next: The Cal Came"
    },
    challenge = { { type = "slider" } },
    solution = {
      type = "talkto",
      spots = {
        {
          range = { origin = { x = 3284, y = 3234, level = 0 }, size = { x = 11, y = 8 } },
          description = "north of Al Kharid"
        }
      },
      npc = "Cam the Camel",
      npc_configs = { { domain = "npc", name = "CAM_THE_CAMEL" } }
    },
    anagram = { "Me Am The Calc", "Ace Match Elm", "The Cal Came" }
  },
  {
    id = 287,
    type = "anagram",
    tier = "hard",
    text = { "This anagram reveals who to speak to next: I Eat Its Chart Hints Do U" },
    challenge = { { type = "slider" } },
    solution = {
      type = "talkto",
      spots = {
        {
          range = {
            origin = { x = 3420, y = 2925, level = 0 },
            size = { x = 11, y = 7 },
            data = "8Jvf//3v///PDA=="
          },
          description = "in Nardah"
        }
      },
      npc = "Shiratti the Custodian",
      npc_configs = { { domain = "npc", name = "ELID_SHIRATTI" } }
    },
    anagram = { "I Eat Its Chart Hints Do U" }
  },
  {
    id = 288,
    type = "anagram",
    tier = "hard",
    text = { "This anagram reveals who to speak to next: An Paint Tonic" },
    challenge = { { type = "slider" } },
    solution = {
      type = "talkto",
      spots = {
        {
          range = { origin = { x = 2869, y = 9877, level = 0 } },
          description = "in the Dwarven Tunnel under the White Wolf Mountain"
        }
      },
      npc = "Captain Ninto",
      npc_configs = { { domain = "npc", name = "ALUFT_PILOT_NINTO" } }
    },
    anagram = { "An Paint Tonic" }
  },
  {
    id = 289,
    type = "anagram",
    tier = "hard",
    text = { "This anagram reveals who to speak to next: Arr! So I am a crust, and?" },
    challenge = { { type = "slider" } },
    solution = {
      type = "talkto",
      spots = {
        {
          range = { origin = { x = 2338, y = 3673, level = 0 }, size = { x = 9, y = 6 } },
          description = "at the Piscatoris Fishing Colony"
        }
      },
      npc = "Ramara du Croissant",
      npc_configs = { { domain = "npc", name = "SWAN_COLONIST_3" } }
    },
    anagram = { "Arr! So I am a crust, and?" }
  },
  {
    id = 290,
    type = "anagram",
    tier = "hard",
    text = { "This anagram reveals who to speak to next: C On Game Hoc" },
    challenge = {
      {
        type = "challengescroll",
        question = "How many gnomes on the gnome ball field have red patches on their uniforms?",
        answers = { { answer = 6 } }
      }
    },
    solution = {
      type = "talkto",
      npc = "Gnome Coach",
      npc_configs = { { domain = "npc", name = "GNOME_BALL_COACH" } },
      spots = {
        {
          range = { origin = { x = 2406, y = 3498, level = 0 } },
          description = "north-east of the gnomeball field"
        }
      }
    },
    anagram = { "C On Game Hoc" }
  },
  {
    id = 291,
    type = "anagram",
    tier = "hard",
    text = { "This anagram reveals who to speak to next: He Do Pose. It Is Cultrrl, Mk?" },
    challenge = { { type = "slider" } },
    solution = {
      type = "talkto",
      spots = {
        {
          range = { origin = { x = 2904, y = 10207, level = 0 } },
          description = "in eastern Keldagrim"
        }
      },
      npc = "Riki the sculptor's model",
      npc_configs = {
        { domain = "npc", name = "DWARF_CITY_SHOP_SCULPTURE_MODEL" },
        { domain = "npc", name = "DWARF_CITY_SHOP_SCULPTURE_MODEL_BOOTS" },
        { domain = "npc", name = "DWARF_CITY_SHOP_SCULPTURE_MODEL_TORSO" },
        { domain = "npc", name = "DWARF_CITY_SHOP_SCULPTURE_MODEL_AXE" },
        { domain = "npc", name = "DWARF_CITY_SHOP_SCULPTURE_MODEL_BOOTS_AND_TORSO" },
        { domain = "npc", name = "DWARF_CITY_SHOP_SCULPTURE_MODEL_BOOTS_AND_AXE" },
        { domain = "npc", name = "DWARF_CITY_SHOP_SCULPTURE_MODEL_TORSO_AND_AXE" },
        { domain = "npc", name = "DWARF_CITY_SHOP_SCULPTURE_MODEL_FINISHED" },
        { domain = "npc", name = "DWARF_CITY_SHOP_SCULPTURE_MODEL_MULTI" }
      }
    },
    anagram = { "He Do Pose. It Is Cultrrl, Mk?" }
  },
  {
    id = 292,
    type = "anagram",
    tier = "hard",
    text = { "This anagram reveals who to speak to next: Profs Lose Wrong Pie" },
    challenge = { { type = "slider" } },
    solution = {
      type = "talkto",
      spots = {
        {
          range = {
            origin = { x = 3101, y = 3148, level = 0 },
            size = { x = 14, y = 20 },
            data = "/8f/8//9////////////////////////9//8B//Bf/AP/AE="
          },
          description = "on the ground floor of Wizard's Tower"
        }
      },
      npc = "Professor Onglewip",
      npc_configs = { { domain = "npc", name = "ALUFT_GNOME_MAGE" } }
    },
    anagram = { "Profs Lose Wrong Pie" }
  },
  {
    id = 293,
    type = "anagram",
    tier = "hard",
    text = { "This anagram reveals who to speak to next: O Birdz A Zany En Pc" },
    challenge = {
      {
        type = "challengescroll",
        question = "How many banana trees are there in the plantation?",
        answers = { { answer = 33 } }
      }
    },
    solution = {
      type = "talkto",
      npc = "Cap'n Izzy No-Beard",
      npc_configs = { { domain = "npc", name = "AGILITYARENA_CLERK" } },
      spots = {
        {
          range = { origin = { x = 2807, y = 3190, level = 0 }, size = { x = 1, y = 2 } },
          description = "at the Agility Arena"
        }
      }
    },
    anagram = { "O Birdz A Zany En Pc" }
  },
  {
    id = 295,
    type = "anagram",
    tier = "hard",
    text = { "This anagram reveals who to speak to next: Red Art Tans" },
    challenge = { { type = "slider" } },
    solution = {
      type = "talkto",
      spots = {
        {
          range = { origin = { x = 3033, y = 3190, level = 0 } },
          description = "in Port Sarim"
        }
      },
      npc = "Trader Stan",
      npc_configs = { { domain = "npc", name = "SAILING_TRANSPORT_TRADER_STAN" } }
    },
    anagram = { "Red Art Tans" }
  },
  {
    id = 296,
    type = "anagram",
    tier = "hard",
    text = { "This anagram reveals who to speak to next: Or Zinc Fumes Ward" },
    challenge = { { type = "slider" } },
    solution = {
      type = "talkto",
      spots = {
        {
          range = { origin = { x = 2588, y = 9489, level = 0 } },
          description = "in the basement of Wizard's Guild"
        }
      },
      npc = "Wizard Frumscone",
      npc_configs = { { domain = "npc", name = "WIZARD_FRUMSCONE" } }
    },
    anagram = { "Or Zinc Fumes Ward" }
  },
  {
    id = 297,
    type = "anagram",
    tier = "hard",
    text = { "This anagram reveals who to speak to next: By Look" },
    challenge = {
      {
        type = "challengescroll",
        question = "How many flowers are there in the clearing below this platform?",
        answers = { { answer = 13 } }
      }
    },
    solution = {
      type = "talkto",
      npc = "Bolkoy",
      npc_configs = { { domain = "npc", name = "TREEVILLAGE_SHOPKEEPER1" } },
      spots = {
        {
          range = {
            origin = { x = 2525, y = 3158, level = 1 },
            size = { x = 8, y = 7 },
            data = "wMD//x8fHw=="
          },
          description = "in Tree Gnome Village"
        }
      }
    },
    anagram = { "By Look" }
  },
  {
    id = 298,
    type = "anagram",
    tier = "hard",
    text = { "This anagram reveals who to speak to next: Sequin Dirge" },
    challenge = { { type = "slider" } },
    solution = {
      type = "talkto",
      spots = {
        {
          range = { origin = { x = 2499, y = 3861, level = 1 }, size = { x = 4, y = 4 } },
          note = "After 'Blood Runs Deep'",
          description = "in Miscellania's Throneroom"
        },
        {
          range = { origin = { x = 2612, y = 3871, level = 1 }, size = { x = 6, y = 9 } },
          note = "Before 'Blood Runs Deep'",
          description = "in Etceteria Castle"
        }
      },
      npc = "Queen Sigrid",
      npc_configs = {
        { domain = "npc", name = "MISC_QUEEN_SIGRID_MULTICHILD" },
        { domain = "npc", name = "MISC_QUEEN_SIGRID" },
        { domain = "npc", name = "EVQ_QUEEN_SIGRID" }
      }
    },
    anagram = { "Sequin Dirge" }
  },
  {
    id = 299,
    type = "anagram",
    tier = "hard",
    text = { "This anagram reveals who to speak to next: A Zen She" },
    challenge = { { type = "slider" } },
    solution = {
      type = "talkto",
      spots = {
        {
          range = {
            origin = { x = 2654, y = 3291, level = 0 },
            size = { x = 8, y = 4 },
            data = "wPz/Bg=="
          },
          description = "in her house south of Ardougne Market"
        }
      },
      npc = "Zenesha",
      npc_configs = { { domain = "npc", name = "ZENESHA" } }
    },
    anagram = { "A Zen She" }
  },
  {
    id = 300,
    type = "anagram",
    tier = "hard",
    text = { "This anagram reveals who to speak to next: Gulag Run" },
    challenge = { { type = "slider" } },
    solution = {
      type = "talkto",
      spots = {
        {
          range = { origin = { x = 2437, y = 3044, level = 0 }, size = { x = 11, y = 12 } },
          description = "south of Castle Wars"
        }
      },
      npc = "Uglug Nar",
      npc_configs = { { domain = "npc", name = "ZOGRE_UGLUG_NAR" } }
    },
    anagram = { "Gulag Run" }
  },
  {
    id = 301,
    type = "anagram",
    tier = "hard",
    text = { "This anagram reveals who to speak to next: Land Doomd" },
    challenge = { { type = "slider" } },
    solution = {
      type = "talkto",
      spots = {
        {
          range = {
            origin = { x = 3358, y = 3500, level = 0 },
            size = { x = 10, y = 10 },
            data = "4OP//////ffff//9Bw=="
          },
          description = "at the limestone mine"
        }
      },
      npc = "Odd Old Man",
      npc_configs = {
        { domain = "npc", name = "RAG2_ODD_OLD_MAN" },
        { domain = "npc", name = "RAG2_ODD_OLD_MAN_FURS" },
        { domain = "npc", name = "RAG2_ODD_OLD_MAN_MULTI" }
      }
    },
    anagram = { "Land Doomd" }
  },
  {
    id = 302,
    type = "anagram",
    tier = "hard",
    text = { "This anagram reveals who to speak to next: I Faffy Run" },
    challenge = { { type = "slider" } },
    solution = {
      type = "talkto",
      spots = {
        {
          range = { origin = { x = 2384, y = 4466, level = 0 }, size = { x = 7, y = 6 } },
          description = "north of the bank in Zanaris"
        }
      },
      npc = "Fairy Nuff",
      npc_configs = {
        { domain = "npc", name = "FAIRY_NUFF2" },
        { domain = "npc", name = "FAIRY_NUFF" },
        { domain = "npc", name = "FAIRY_NUFF_MULTI" }
      }
    },
    anagram = { "I Faffy Run" }
  },
  {
    id = 303,
    type = "anagram",
    tier = "master",
    text = {
      "This anagram reveals who to speak to next: An exile that isn't wholly free WE IRK OVER NAMESAKE."
    },
    solution = {
      type = "talkto",
      spots = {
        {
          range = { origin = { x = 4646, y = 5384, level = 0 } },
          description = "at the bottom of Polypore Dungeon"
        }
      },
      npc = "Ramokee Skinweaver",
      npc_configs = { { domain = "npc", name = "POLYPORE_SKINWEAVER" } }
    },
    anagram = { "WE IRK OVER NAMESAKE" }
  },
  {
    id = 306,
    type = "anagram",
    tier = "master",
    text = {
      "This anagram reveals who to speak to next: QUIT THY BRINE RAT ROLL"
    },
    solution = {
      type = "talkto",
      spots = {
        {
          range = { origin = { x = 3679, y = 2960, level = 0 }, size = { x = 5, y = 5 } },
          description = "by the docks on Mos Le'Harmless",
          note = "Mos Le'Harmless"
        },
        {
          range = { origin = { x = 3786, y = 2823, level = 0 }, size = { x = 3, y = 2 } },
          description = "on Harmony Island",
          note = "Harmony"
        }
      },
      npc = "Brother Tranquillity",
      npc_configs = {
        { domain = "npc", name = "BRAIN_BROTHER_TRANQUILITY_ZOMBIE" },
        { domain = "npc", name = "BRAIN_BROTHER_TRANQUILITY_HUMAN" },
        { domain = "npc", name = "BRAIN_TRANQUILITY" },
        { domain = "npc", name = "BRAIN_ISLAND_TRANQUILITY" }
      }
    },
    anagram = { "QUIT THY BRINE RAT ROLL" }
  },
  {
    id = 307,
    type = "anagram",
    tier = "master",
    text = { "This anagram reveals who to speak to next: They seek spirits O EASTERN WISHES" },
    challenge = { { type = "towers" } },
    solution = {
      type = "talkto",
      spots = {
        {
          range = { origin = { x = 1785, y = 11953, level = 0 } },
          description = "on Tuaei Leit"
        }
      },
      npc = "Sensei Seaworth",
      npc_configs = { { domain = "npc", name = "ELR2_IMPLING_EXPERT" } }
    },
    anagram = { "O EASTERN WISHES" }
  },
  {
    id = 308,
    type = "anagram",
    tier = "master",
    text = {
      "This anagram reveals who to speak to next: This lady wants me to find ancient scrolls ERGO I DIG CLAY"
    },
    challenge = { { type = "towers" } },
    solution = {
      type = "talkto",
      spots = {
        {
          id = "outside",
          description = "outside of the entrance to the empty throne room",
          range = { origin = { x = 3377, y = 3404, level = 0 } },
          note = "Outside the empty throne room"
        },
        {
          id = "inside",
          description = "inside the empty throne room",
          range = { origin = { x = 2826, y = 12631, level = 2 } },
          note = "Inside the empty throne room"
        }
      },
      npc = "Celia Diggory",
      npc_configs = { { domain = "npc", name = "FOTG2_DIGSITE_GUIDE" } }
    },
    anagram = { "ERGO I DIG CLAY" }
  },
  {
    id = 309,
    type = "anagram",
    tier = "master",
    text = {
      "This anagram reveals who to speak to next: Master of the elements, he may REIGN US IF IMMORTAL"
    },
    challenge = { { type = "lockbox" } },
    solution = {
      type = "talkto",
      spots = {
        {
          id = "armadyl-tower",
          range = { origin = { x = 2997, y = 3263, level = 0 }, size = { x = 8, y = 11 } },
          description = "south of Falador"
        },
        {
          id = "city-of-um",
          range = { origin = { x = 1035, y = 1763, level = 1 } },
          description = "at the Ritual Site"
        }
      },
      npc = "Malignius Mortifer",
      npc_configs = {
        { domain = "npc", name = "ELEMENTAL_WIZARD_BOSS" },
        { domain = "npc", name = "QUEST_NECROMANCY_TUTORIAL_MALIGNIUS" },
        { domain = "npc", name = "NECRO_HUB_MALIGNIUS" }
      }
    },
    anagram = { "REIGN US IF IMMORTAL" }
  },
  {
    id = 310,
    type = "anagram",
    tier = "master",
    text = {
      "This anagram reveals who to speak to next: If distracted from their work AH; WET ARM"
    },
    challenge = { { type = "lockbox" } },
    solution = {
      type = "talkto",
      spots = {
        {
          range = { origin = { x = 2347, y = 3164, level = 0 } },
          description = "in Lletya"
        }
      },
      npc = "Amaethwr",
      npc_configs = { { domain = "npc", name = "PAWYA_ELF_GARDENER" } }
    },
    anagram = { "AH; WET ARM" }
  },
  {
    id = 311,
    type = "anagram",
    tier = "master",
    text = {
      "This anagram reveals who to speak to next: Young but stylish PIN HEIR ALL IN PLACE"
    },
    solution = {
      type = "talkto",
      npc = "Philipe Carnillean",
      npc_configs = {
        { domain = "npc", name = "CARNI_PHILIPE_HAZEELCULTQUEST" },
        { domain = "npc", name = "CARNI_PHILIPE_FOLLOWER" },
        { domain = "npc", name = "CARNI_PHILIPE_PICKPOCKET" },
        { domain = "npc", name = "CARNI_PHILIPE_FIGHTING" },
        { domain = "npc", name = "PHILIPE_CARNILLEAN" },
        { domain = "npc", name = "CARNI_PHILIPE_POSTQUEST_9" },
        { domain = "npc", name = "CARNI_PHILIPE_POSTQUEST_1" },
        { domain = "npc", name = "CARNI_PHILIPE_POSTQUEST_2" },
        { domain = "npc", name = "CARNI_PHILIPE_POSTQUEST_3" },
        { domain = "npc", name = "CARNI_PHILIPE_POSTQUEST_4" },
        { domain = "npc", name = "CARNI_PHILIPE_POSTQUEST_5" },
        { domain = "npc", name = "CARNI_PHILIPE_POSTQUEST_6" },
        { domain = "npc", name = "CARNI_PHILIPE_POSTQUEST_7" },
        { domain = "npc", name = "CARNI_PHILIPE_POSTQUEST_8" }
      },
      spots = {
        {
          id = "before",
          description = "at Carnillean Mansion",
          range = { origin = { x = 2564, y = 3267, level = 0 }, size = { x = 12, y = 8 } },
          note = "Before Carnillean Rising"
        },
        {
          id = "50qp",
          description = "at the entrance of Ardougne Combat Training Camp",
          range = { origin = { x = 2514, y = 3354, level = 0 }, size = { x = 8, y = 4 } },
          note = "50 qp."
        },
        {
          id = "100qp",
          description = "at the entrance to Mountain Camp",
          range = { origin = { x = 2752, y = 3649, level = 0 }, size = { x = 8, y = 8 } },
          note = "100 qp."
        },
        {
          id = "150qp",
          description = "in Shilo Village",
          range = { origin = { x = 2857, y = 2993, level = 1 }, size = { x = 9, y = 9 } },
          note = "150 qp."
        },
        {
          id = "200qp",
          description = "in the Green Ghost Inn",
          range = { origin = { x = 3671, y = 3489, level = 0 }, size = { x = 11, y = 11 } },
          note = "200 qp."
        },
        {
          id = "250qp",
          description = "at the bottom of Polypore Dungeon",
          range = { origin = { x = 4643, y = 5384, level = 0 }, size = { x = 8, y = 8 } },
          note = "250 qp."
        },
        {
          id = "300qp",
          description = "outside of Oldak's house",
          range = { origin = { x = 2709, y = 5357, level = 0 }, size = { x = 6, y = 6 } },
          note = "300 qp."
        },
        {
          id = "350qp",
          description = "at Piscatoris Fishing Colony",
          range = { origin = { x = 2338, y = 3673, level = 0 }, size = { x = 9, y = 6 } },
          note = "350 qp."
        },
        {
          id = "400qp",
          description = "at the TzHaar fight Caves",
          range = { origin = { x = 4610, y = 5123, level = 0 }, size = { x = 8, y = 8 } },
          note = "400 qp."
        },
        {
          id = "450qp",
          description = "in the City of Um",
          range = { origin = { x = 1127, y = 1719, level = 1 }, size = { x = 5, y = 5 } },
          note = "450 qp."
        }
      }
    },
    anagram = { "PIN HEIR ALL IN PLACE" }
  },
  {
    id = 312,
    type = "anagram",
    tier = "master",
    text = {
      "This anagram reveals who to speak to next: In his youth, this adventurer was a WINSOME LAD"
    },
    solution = {
      type = "talkto",
      spots = {
        {
          range = { origin = { x = 3088, y = 3255, level = 0 } },
          description = "in Draynor"
        }
      },
      npc = "Wise Old Man",
      npc_configs = {
        { domain = "npc", name = "WISE_OLD_MAN" },
        { domain = "npc", name = "WOM_CUTSCENE_4" },
        { domain = "npc", name = "WOM_MULTI" }
      }
    },
    anagram = { "WINSOME LAD" }
  },
  {
    id = 313,
    type = "anagram",
    tier = "master",
    text = {
      "This anagram reveals who to speak to next: The cabbage diet must work because he has A PURE GLOW"
    },
    solution = {
      type = "talkto",
      spots = {
        {
          id = "life-altar",
          note = "After Gower Quest",
          range = { origin = { x = 1056, y = 5550, level = 1 } },
          description = "at the Life Altar"
        },
        {
          id = "farm",
          note = "Before Gower Quest",
          range = { origin = { x = 3256, y = 3355, level = 0 } },
          description = "at the farm south of Varrock"
        }
      },
      npc = "Paul Gower",
      npc_configs = {
        { domain = "npc", name = "GOWER_PAUL" },
        { domain = "npc", name = "GOWER_PAUL_MULTI" },
        { domain = "npc", name = "GOWER_PAUL_ALTAR_MULTI" }
      }
    },
    anagram = { "A PURE GLOW" }
  },
  {
    id = 314,
    type = "anagram",
    tier = "master",
    text = {
      "This anagram reveals who to speak to next: Age allows a new perspective in this vital place TABOO RISES SHYLY"
    },
    solution = {
      type = "talkto",
      spots = {
        {
          range = { origin = { x = 3198, y = 6961, level = 1 } },
          description = "at the entrance to Telos"
        }
      },
      npc = "Soothsayer Sybil",
      npc_configs = { { domain = "npc", name = "GWD2_SOLO_SOOTHSAYER" } }
    },
    anagram = { "TABOO RISES SHYLY" }
  },
  {
    id = 315,
    type = "anagram",
    tier = "master",
    text = {
      "This anagram reveals who to speak to next: With her age, it's no surprise to HEAR A LADY RANT"
    },
    solution = {
      type = "talkto",
      spots = {
        {
          range = { origin = { x = 2221, y = 3298, level = 1 } },
          description = "at the seren stones"
        }
      },
      npc = "Lady Trahaearn",
      npc_configs = { { domain = "npc", name = "ELFCITY_LADY_TRAHAEARN" } }
    },
    anagram = { "HEAR A LADY RANT" }
  },
  {
    id = 316,
    type = "anagram",
    tier = "master",
    text = {
      "This anagram reveals who to speak to next: He claimed to be a human scholar but I SAW THE LIE"
    },
    solution = {
      type = "talkto",
      spots = {
        {
          range = {
            origin = { x = 3416, y = 2935, level = 0 },
            size = { x = 9, y = 6 },
            data = "P/7////jBw=="
          },
          description = "in Nardaah"
        }
      },
      npc = "Ali The Wise",
      npc_configs = {
        { domain = "npc", name = "MAH1_ALI_THE_WISE" },
        { domain = "npc", name = "MAH3_ALI_THE_WISE" },
        { domain = "npc", name = "MAH5_WAVE_ALI_THE_WISE" },
        { domain = "npc", name = "MAH5_ALI_THE_WISE" },
        { domain = "npc", name = "MINIQUEST_EGWD_PRERELEASE_WAHISIETEL_PRESENT" },
        { domain = "npc", name = "MAH1_ALI_THE_WISE_MULTI" },
        { domain = "npc", name = "MAH3_ALI_THE_WISE_MULTI" },
        { domain = "npc", name = "MAH5_ALI_THE_WISE_MULTI" },
        { domain = "npc", name = "MINIQUEST_EGWD_PRERELEASE_WAHISIETEL" }
      }
    },
    anagram = { "I SAW THE LIE" }
  },
  {
    id = 317,
    type = "anagram",
    tier = "master",
    text = { "This anagram reveals who to speak to next: His job leaves him kind of HATED" },
    solution = {
      type = "talkto",
      spots = {
        {
          id = "office",
          range = { origin = { x = 414, y = 680, level = 0 } },
          description = "in Death's Office",
          note = "Death's Office"
        }
      },
      npc = "Death",
      npc_configs = {
        { domain = "npc", name = "ADVISOR_GRIM_REAPER" },
        { domain = "npc", name = "DEATH_OFFICE_MULTI" }
      }
    },
    anagram = { "HATED" }
  },
  {
    id = 319,
    type = "anagram",
    tier = "medium",
    text = { "This anagram reveals who to speak to next: MR MIAI" },
    solution = {
      type = "talkto",
      spots = {
        {
          range = { origin = { x = 3491, y = 1506, level = 0 }, size = { x = 2, y = 3 } },
          description = "in Wendlewick"
        }
      },
      npc = "Miriam",
      npc_configs = { { domain = "npc", name = "WENDLE_MUSICIAN" } }
    },
    anagram = { "MR MIAI" }
  },
  {
    id = 36,
    type = "scan",
    tier = "elite",
    text = {
      "This scroll will work in the deepest levels of the Wilderness. Orb scan range: 25 paces."
    },
    spots = {
      { x = 2958, y = 3917, level = 0 },
      { x = 2979, y = 3962, level = 0 },
      { x = 2998, y = 3914, level = 0 },
      { x = 2956, y = 3908, level = 0 },
      { x = 2944, y = 3909, level = 0 },
      { x = 2990, y = 3924, level = 0 },
      { x = 3055, y = 3914, level = 0 },
      { x = 3060, y = 3941, level = 0 },
      { x = 3029, y = 3949, level = 0 },
      { x = 3012, y = 3959, level = 0 },
      { x = 3057, y = 3948, level = 0 },
      { x = 3048, y = 3926, level = 0 },
      { x = 3037, y = 3925, level = 0 },
      { x = 3031, y = 3926, level = 0 },
      { x = 3021, y = 3926, level = 0 },
      { x = 3110, y = 3954, level = 0 },
      { x = 3125, y = 3909, level = 0 },
      { x = 3080, y = 3911, level = 0 },
      { x = 3160, y = 3943, level = 0 },
      { x = 3182, y = 3926, level = 0 },
      { x = 3193, y = 3950, level = 0 },
      { x = 3179, y = 3943, level = 0 },
      { x = 3175, y = 3962, level = 0 },
      { x = 3242, y = 3956, level = 0 },
      { x = 3241, y = 3944, level = 0 },
      { x = 3210, y = 3910, level = 0 },
      { x = 3216, y = 3944, level = 0 },
      { x = 3266, y = 3936, level = 0 },
      { x = 3307, y = 3916, level = 0 },
      { x = 3306, y = 3947, level = 0 },
      { x = 3281, y = 3942, level = 0 },
      { x = 3315, y = 3914, level = 0 },
      { x = 3269, y = 3914, level = 0 },
      { x = 3380, y = 3960, level = 0 },
      { x = 3342, y = 3894, level = 0 },
      { x = 3334, y = 3906, level = 0 },
      { x = 3363, y = 3960, level = 0 },
      { x = 3346, y = 3976, level = 0 },
      { x = 3408, y = 3937, level = 0 }
    },
    range = 25,
    scantext = "the deepest levels of the Wilderness"
  },
  {
    id = 349,
    type = "scan",
    tier = "elite",
    text = {
      "This scroll will work in the desert, east of the Elid and north of Nardah. Orb scan range: 27 paces."
    },
    spots = {
      { x = 3421, y = 2949, level = 0 },
      { x = 3444, y = 2952, level = 0 },
      { x = 3447, y = 2967, level = 0 },
      { x = 3438, y = 2960, level = 0 },
      { x = 3417, y = 2959, level = 0 },
      { x = 3427, y = 2970, level = 0 },
      { x = 3442, y = 2974, level = 0 },
      { x = 3408, y = 2986, level = 0 },
      { x = 3426, y = 2984, level = 0 },
      { x = 3436, y = 2989, level = 0 },
      { x = 3406, y = 3003, level = 0 },
      { x = 3393, y = 2997, level = 0 },
      { x = 3419, y = 3017, level = 0 },
      { x = 3382, y = 3015, level = 0 },
      { x = 3385, y = 3024, level = 0 },
      { x = 3383, y = 3018, level = 0 },
      { x = 3423, y = 3020, level = 0 },
      { x = 3448, y = 3019, level = 0 },
      { x = 3411, y = 3048, level = 0 },
      { x = 3422, y = 3051, level = 0 },
      { x = 3448, y = 3063, level = 0 },
      { x = 3401, y = 3064, level = 0 },
      { x = 3460, y = 3022, level = 0 },
      { x = 3476, y = 3018, level = 0 },
      { x = 3462, y = 3047, level = 0 },
      { x = 3465, y = 3034, level = 0 },
      { x = 3502, y = 3050, level = 0 },
      { x = 3510, y = 3041, level = 0 },
      { x = 3476, y = 3057, level = 0 },
      { x = 3480, y = 3090, level = 0 },
      { x = 3473, y = 3082, level = 0 },
      { x = 3482, y = 3108, level = 0 },
      { x = 3499, y = 3104, level = 0 },
      { x = 3505, y = 3093, level = 0 },
      { x = 3401, y = 3099, level = 0 },
      { x = 3396, y = 3110, level = 0 },
      { x = 3406, y = 3126, level = 0 },
      { x = 3433, y = 3122, level = 0 },
      { x = 3444, y = 3085, level = 0 },
      { x = 3446, y = 3128, level = 0 },
      { x = 3360, y = 3095, level = 0 },
      { x = 3387, y = 3123, level = 0 },
      { x = 3373, y = 3126, level = 0 },
      { x = 3384, y = 3081, level = 0 },
      { x = 3405, y = 3136, level = 0 },
      { x = 3409, y = 3119, level = 0 },
      { x = 3432, y = 3105, level = 0 },
      { x = 3427, y = 3141, level = 0 },
      { x = 3444, y = 3141, level = 0 },
      { x = 3435, y = 3129, level = 0 },
      { x = 3456, y = 3140, level = 0 }
    },
    range = 27,
    scantext = "the desert, east of the Elid and north of Nardah"
  },
  {
    id = 350,
    type = "scan",
    tier = "elite",
    text = { "This scroll will work in Isafdar and Lletya. Orb scan range: 22 paces." },
    spots = {
      { x = 2173, y = 3125, level = 0 },
      { x = 2283, y = 3265, level = 0 },
      { x = 2217, y = 3130, level = 0 },
      { x = 2253, y = 3118, level = 0 },
      { x = 2247, y = 3143, level = 0 },
      { x = 2271, y = 3165, level = 0 },
      { x = 2287, y = 3141, level = 0 },
      { x = 2310, y = 3187, level = 0 },
      { x = 2331, y = 3171, level = 0 },
      { x = 2322, y = 3190, level = 0 },
      { x = 2348, y = 3183, level = 0 },
      { x = 2225, y = 3145, level = 0 },
      { x = 2186, y = 3146, level = 0 },
      { x = 2205, y = 3155, level = 0 },
      { x = 2216, y = 3159, level = 0 },
      { x = 2182, y = 3192, level = 0 },
      { x = 2226, y = 3158, level = 0 },
      { x = 2176, y = 3201, level = 0 },
      { x = 2225, y = 3212, level = 0 },
      { x = 2219, y = 3221, level = 0 },
      { x = 2194, y = 3220, level = 0 },
      { x = 2194, y = 3237, level = 0 },
      { x = 2229, y = 3248, level = 0 },
      { x = 2203, y = 3254, level = 0 },
      { x = 2258, y = 3212, level = 0 },
      { x = 2289, y = 3220, level = 0 },
      { x = 2302, y = 3230, level = 0 },
      { x = 2282, y = 3262, level = 0 },
      { x = 2232, y = 3223, level = 0 }
    },
    range = 22,
    scantext = "Isafdar and Lletya"
  },
  {
    id = 351,
    type = "scan",
    tier = "elite",
    text = {
      "This scroll will work within the walls of Varrock and the Grand Exchange Orb scan range: 16 paces"
    },
    spots = {
      { x = 3197, y = 3383, level = 0 },
      { x = 3211, y = 3385, level = 0 },
      { x = 3228, y = 3383, level = 0 },
      { x = 3240, y = 3383, level = 0 },
      { x = 3175, y = 3404, level = 0 },
      { x = 3175, y = 3415, level = 0 },
      { x = 3196, y = 3415, level = 0 },
      { x = 3197, y = 3423, level = 0 },
      { x = 3253, y = 3393, level = 0 },
      { x = 3228, y = 3409, level = 0 },
      { x = 3231, y = 3439, level = 0 },
      { x = 3220, y = 3407, level = 0 },
      { x = 3204, y = 3409, level = 0 },
      { x = 3273, y = 3398, level = 0 },
      { x = 3284, y = 3378, level = 0 },
      { x = 3185, y = 3472, level = 0 },
      { x = 3188, y = 3488, level = 0 },
      { x = 3180, y = 3510, level = 0 },
      { x = 3141, y = 3488, level = 0 },
      { x = 3213, y = 3484, level = 0 },
      { x = 3230, y = 3494, level = 0 },
      { x = 3241, y = 3480, level = 0 },
      { x = 3213, y = 3462, level = 0 },
      { x = 3248, y = 3454, level = 0 }
    },
    range = 16,
    scantext = "Varrock and the Grand Exchange"
  },
  {
    id = 352,
    type = "scan",
    tier = "elite",
    text = {
      "This scroll will work within the walls of East or West Ardougne. Orb scan range: 22 paces."
    },
    spots = {
      { x = 2442, y = 3310, level = 0 },
      { x = 2440, y = 3319, level = 0 },
      { x = 2462, y = 3282, level = 0 },
      { x = 2483, y = 3313, level = 0 },
      { x = 2467, y = 3319, level = 0 },
      { x = 2496, y = 3282, level = 0 },
      { x = 2517, y = 3281, level = 0 },
      { x = 2512, y = 3267, level = 0 },
      { x = 2529, y = 3270, level = 0 },
      { x = 2537, y = 3306, level = 0 },
      { x = 2520, y = 3318, level = 0 },
      { x = 2500, y = 3290, level = 0 },
      { x = 2540, y = 3331, level = 0 },
      { x = 2509, y = 3330, level = 0 },
      { x = 2475, y = 3331, level = 0 },
      { x = 2583, y = 3265, level = 0 },
      { x = 2589, y = 3319, level = 0 },
      { x = 2582, y = 3314, level = 0 },
      { x = 2623, y = 3311, level = 0 },
      { x = 2570, y = 3321, level = 0 },
      { x = 2662, y = 3304, level = 0 },
      { x = 2625, y = 3292, level = 0 },
      { x = 2635, y = 3313, level = 0 },
      { x = 2662, y = 3338, level = 0 },
      { x = 2633, y = 3339, level = 0 },
      { x = 2613, y = 3337, level = 0 },
      { x = 2589, y = 3330, level = 0 },
      { x = 2569, y = 3340, level = 0 }
    },
    range = 22,
    scantext = "East or West Ardougne"
  },
  {
    id = 353,
    type = "scan",
    tier = "elite",
    text = {
      "This scroll will work within the dwarven city of Keldagrim. Orb scan range: 11 paces."
    },
    spots = {
      { x = 2841, y = 10189, level = 0 },
      { x = 2856, y = 10192, level = 0 },
      { x = 2822, y = 10193, level = 0 },
      { x = 2873, y = 10194, level = 0 },
      { x = 2872, y = 10181, level = 0 },
      { x = 2846, y = 10233, level = 0 },
      { x = 2860, y = 10215, level = 0 },
      { x = 2837, y = 10209, level = 0 },
      { x = 2905, y = 10162, level = 0 },
      { x = 2924, y = 10162, level = 0 },
      { x = 2938, y = 10162, level = 0 },
      { x = 2936, y = 10206, level = 0 },
      { x = 2906, y = 10202, level = 0 },
      { x = 2937, y = 10191, level = 0 },
      { x = 2904, y = 10193, level = 0 },
      { x = 2924, y = 10191, level = 0 },
      { x = 2922, y = 10179, level = 0 },
      { x = 2938, y = 10179, level = 0 }
    },
    range = 11,
    scantext = "Keldagrim"
  },
  {
    id = 354,
    type = "scan",
    tier = "elite",
    text = { "This scroll will work in Menaphos. Orb scan range: 30 paces" },
    spots = {
      { x = 3099, y = 2677, level = 0 },
      { x = 3127, y = 2643, level = 0 },
      { x = 3095, y = 2730, level = 0 },
      { x = 3096, y = 2692, level = 0 },
      { x = 3108, y = 2742, level = 0 },
      { x = 3131, y = 2791, level = 0 },
      { x = 3135, y = 2775, level = 0 },
      { x = 3146, y = 2659, level = 0 },
      { x = 3155, y = 2641, level = 0 },
      { x = 3180, y = 2669, level = 0 },
      { x = 3180, y = 2700, level = 0 },
      { x = 3199, y = 2750, level = 0 },
      { x = 3145, y = 2759, level = 0 },
      { x = 3153, y = 2799, level = 0 },
      { x = 3165, y = 2814, level = 0 },
      { x = 3193, y = 2797, level = 0 },
      { x = 3237, y = 2664, level = 0 },
      { x = 3200, y = 2709, level = 0 },
      { x = 3210, y = 2770, level = 0 },
      { x = 3231, y = 2770, level = 0 },
      { x = 3238, y = 2792, level = 0 }
    },
    range = 30,
    scantext = "Menaphos"
  },
  {
    id = 355,
    type = "scan",
    tier = "elite",
    text = {
      "This scroll will work in the Piscatoris Hunter Area. Orb scan range: 14 paces."
    },
    spots = {
      { x = 2310, y = 3518, level = 0 },
      { x = 2336, y = 3540, level = 0 },
      { x = 2364, y = 3547, level = 0 },
      { x = 2353, y = 3543, level = 0 },
      { x = 2324, y = 3553, level = 0 },
      { x = 2361, y = 3567, level = 0 },
      { x = 2308, y = 3560, level = 0 },
      { x = 2313, y = 3576, level = 0 },
      { x = 2331, y = 3574, level = 0 },
      { x = 2342, y = 3575, level = 0 },
      { x = 2358, y = 3557, level = 0 },
      { x = 2363, y = 3527, level = 0 },
      { x = 2358, y = 3580, level = 0 },
      { x = 2388, y = 3586, level = 0 },
      { x = 2398, y = 3582, level = 0 },
      { x = 2392, y = 3591, level = 0 },
      { x = 2373, y = 3612, level = 0 },
      { x = 2372, y = 3626, level = 0 },
      { x = 2318, y = 3601, level = 0 },
      { x = 2339, y = 3589, level = 0 },
      { x = 2362, y = 3612, level = 0 },
      { x = 2347, y = 3609, level = 0 },
      { x = 2332, y = 3632, level = 0 },
      { x = 2320, y = 3625, level = 0 },
      { x = 2344, y = 3645, level = 0 },
      { x = 2310, y = 3587, level = 0 }
    },
    range = 14,
    scantext = "Piscatoris Hunter Area"
  },
  {
    id = 356,
    type = "scan",
    tier = "elite",
    text = { "This scroll will work in Brimhaven Dungeon. Orb scan range: 14 paces." },
    spots = {
      { x = 2703, y = 9439, level = 0 },
      { x = 2738, y = 9456, level = 0 },
      { x = 2737, y = 9433, level = 0 },
      { x = 2722, y = 9444, level = 0 },
      { x = 2729, y = 9427, level = 0 },
      { x = 2695, y = 9457, level = 0 },
      { x = 2739, y = 9506, level = 0 },
      { x = 2745, y = 9488, level = 0 },
      { x = 2707, y = 9486, level = 0 },
      { x = 2699, y = 9481, level = 0 },
      { x = 2730, y = 9513, level = 0 },
      { x = 2717, y = 9517, level = 0 },
      { x = 2712, y = 9524, level = 0 },
      { x = 2701, y = 9516, level = 0 },
      { x = 2713, y = 9503, level = 0 },
      { x = 2679, y = 9479, level = 0 },
      { x = 2650, y = 9488, level = 0 },
      { x = 2649, y = 9499, level = 0 },
      { x = 2665, y = 9504, level = 0 },
      { x = 2681, y = 9505, level = 0 },
      { x = 2647, y = 9511, level = 0 },
      { x = 2664, y = 9522, level = 0 },
      { x = 2672, y = 9514, level = 0 },
      { x = 2652, y = 9528, level = 0 },
      { x = 2640, y = 9533, level = 0 },
      { x = 2641, y = 9541, level = 0 },
      { x = 2680, y = 9542, level = 0 },
      { x = 2669, y = 9573, level = 0 },
      { x = 2675, y = 9582, level = 0 },
      { x = 2660, y = 9589, level = 0 },
      { x = 2642, y = 9575, level = 0 },
      { x = 2638, y = 9594, level = 2 },
      { x = 2630, y = 9581, level = 2 },
      { x = 2638, y = 9566, level = 2 },
      { x = 2634, y = 9551, level = 2 },
      { x = 2627, y = 9530, level = 2 },
      { x = 2631, y = 9516, level = 2 },
      { x = 2639, y = 9504, level = 2 },
      { x = 2628, y = 9489, level = 2 },
      { x = 2655, y = 9475, level = 2 },
      { x = 2703, y = 9564, level = 0 },
      { x = 2697, y = 9563, level = 0 }
    },
    range = 14,
    scantext = "Brimhaven Dungeon"
  },
  {
    id = 357,
    type = "scan",
    tier = "elite",
    text = { "This scroll will work in Taverley Dungeon. Orb scan range: 22 paces." },
    spots = {
      { x = 2858, y = 9788, level = 0 },
      { x = 2870, y = 9791, level = 0 },
      { x = 2875, y = 9805, level = 0 },
      { x = 2832, y = 9813, level = 0 },
      { x = 2835, y = 9819, level = 0 },
      { x = 2822, y = 9826, level = 0 },
      { x = 2892, y = 9783, level = 0 },
      { x = 2895, y = 9769, level = 0 },
      { x = 2914, y = 9757, level = 0 },
      { x = 2936, y = 9764, level = 0 },
      { x = 2905, y = 9734, level = 0 },
      { x = 2907, y = 9718, level = 0 },
      { x = 2907, y = 9705, level = 0 },
      { x = 2926, y = 9692, level = 0 },
      { x = 2968, y = 9786, level = 0 },
      { x = 2952, y = 9786, level = 0 },
      { x = 2949, y = 9773, level = 0 },
      { x = 2938, y = 9812, level = 0 },
      { x = 2904, y = 9809, level = 0 },
      { x = 2884, y = 9799, level = 0 },
      { x = 2895, y = 9831, level = 0 },
      { x = 2933, y = 9848, level = 0 },
      { x = 2907, y = 9842, level = 0 },
      { x = 2888, y = 9846, level = 0 },
      { x = 2945, y = 9796, level = 0 }
    },
    range = 22,
    scantext = "Taverley Dungeon"
  },
  {
    id = 358,
    type = "scan",
    tier = "elite",
    text = {
      "This scroll will work on the faraway island of Mos Le'Harmless. Orb scan range: 27 paces."
    },
    spots = {
      { x = 3702, y = 2972, level = 0 },
      { x = 3657, y = 2955, level = 0 },
      { x = 3699, y = 2996, level = 0 },
      { x = 3651, y = 2991, level = 0 },
      { x = 3692, y = 2976, level = 0 },
      { x = 3676, y = 2981, level = 0 },
      { x = 3773, y = 2960, level = 0 },
      { x = 3728, y = 2973, level = 0 },
      { x = 3730, y = 2996, level = 0 },
      { x = 3765, y = 2995, level = 0 },
      { x = 3717, y = 2969, level = 0 },
      { x = 3758, y = 2956, level = 0 },
      { x = 3752, y = 3006, level = 0 },
      { x = 3669, y = 3055, level = 0 },
      { x = 3695, y = 3063, level = 0 },
      { x = 3697, y = 3052, level = 0 },
      { x = 3687, y = 3046, level = 0 },
      { x = 3679, y = 3018, level = 0 },
      { x = 3702, y = 3027, level = 0 },
      { x = 3757, y = 3063, level = 0 },
      { x = 3742, y = 3063, level = 0 },
      { x = 3736, y = 3041, level = 0 },
      { x = 3726, y = 3038, level = 0 },
      { x = 3765, y = 3030, level = 0 },
      { x = 3769, y = 3015, level = 0 },
      { x = 3740, y = 3018, level = 0 },
      { x = 3802, y = 3035, level = 0 },
      { x = 3791, y = 3023, level = 0 },
      { x = 3818, y = 3027, level = 0 },
      { x = 3831, y = 3031, level = 0 },
      { x = 3843, y = 2987, level = 0 },
      { x = 3850, y = 3010, level = 0 }
    },
    range = 27,
    scantext = "Mos Le'Harmless"
  },
  {
    id = 359,
    type = "scan",
    tier = "elite",
    text = { "This scroll will work within the Haunted Woods. Orb scan range: 11 paces." },
    spots = {
      { x = 3534, y = 3470, level = 0 },
      { x = 3523, y = 3460, level = 0 },
      { x = 3551, y = 3514, level = 0 },
      { x = 3575, y = 3511, level = 0 },
      { x = 3562, y = 3509, level = 0 },
      { x = 3583, y = 3484, level = 0 },
      { x = 3583, y = 3466, level = 0 },
      { x = 3552, y = 3483, level = 0 },
      { x = 3573, y = 3484, level = 0 },
      { x = 3529, y = 3501, level = 0 },
      { x = 3544, y = 3465, level = 0 },
      { x = 3567, y = 3475, level = 0 },
      { x = 3609, y = 3499, level = 0 },
      { x = 3596, y = 3501, level = 0 },
      { x = 3637, y = 3486, level = 0 },
      { x = 3623, y = 3476, level = 0 },
      { x = 3604, y = 3507, level = 0 },
      { x = 3624, y = 3508, level = 0 },
      { x = 3616, y = 3512, level = 0 },
      { x = 3606, y = 3465, level = 0 },
      { x = 3590, y = 3475, level = 0 }
    },
    range = 11,
    scantext = "Haunted Woods"
  },
  {
    id = 360,
    type = "scan",
    tier = "elite",
    text = { "This scroll will work in the Kharazi Jungle. Orb scan range: 14 paces." },
    spots = {
      { x = 2775, y = 2891, level = 0 },
      { x = 2786, y = 2914, level = 0 },
      { x = 2804, y = 2924, level = 0 },
      { x = 2762, y = 2918, level = 0 },
      { x = 2775, y = 2936, level = 0 },
      { x = 2766, y = 2932, level = 0 },
      { x = 2815, y = 2887, level = 0 },
      { x = 2859, y = 2891, level = 0 },
      { x = 2848, y = 2907, level = 0 },
      { x = 2827, y = 2934, level = 0 },
      { x = 2832, y = 2935, level = 0 },
      { x = 2852, y = 2934, level = 0 },
      { x = 2857, y = 2919, level = 0 },
      { x = 2841, y = 2915, level = 0 },
      { x = 2872, y = 2901, level = 0 },
      { x = 2920, y = 2888, level = 0 },
      { x = 2892, y = 2907, level = 0 },
      { x = 2931, y = 2920, level = 0 },
      { x = 2921, y = 2937, level = 0 },
      { x = 2892, y = 2937, level = 0 },
      { x = 2929, y = 2894, level = 0 },
      { x = 2927, y = 2925, level = 0 },
      { x = 2936, y = 2917, level = 0 },
      { x = 2944, y = 2902, level = 0 },
      { x = 2932, y = 2935, level = 0 },
      { x = 2942, y = 2934, level = 0 }
    },
    range = 14,
    scantext = "Kharazi Jungle"
  },
  {
    id = 361,
    type = "scan",
    tier = "elite",
    text = { "This scroll will work in the city of Zanaris. Orb scan range: 16 paces." },
    spots = {
      { x = 2414, y = 4378, level = 0 },
      { x = 2423, y = 4372, level = 0 },
      { x = 2420, y = 4381, level = 0 },
      { x = 2389, y = 4405, level = 0 },
      { x = 2377, y = 4410, level = 0 },
      { x = 2404, y = 4406, level = 0 },
      { x = 2372, y = 4467, level = 0 },
      { x = 2402, y = 4466, level = 0 },
      { x = 2396, y = 4457, level = 0 },
      { x = 2410, y = 4460, level = 0 },
      { x = 2400, y = 4441, level = 0 },
      { x = 2380, y = 4421, level = 0 },
      { x = 2406, y = 4428, level = 0 },
      { x = 2429, y = 4431, level = 0 },
      { x = 2417, y = 4444, level = 0 },
      { x = 2417, y = 4470, level = 0 },
      { x = 2385, y = 4447, level = 0 },
      { x = 2439, y = 4460, level = 0 },
      { x = 2441, y = 4428, level = 0 },
      { x = 2468, y = 4439, level = 0 },
      { x = 2457, y = 4443, level = 0 },
      { x = 2453, y = 4471, level = 0 }
    },
    range = 16,
    scantext = "Zanaris"
  },
  {
    id = 362,
    type = "scan",
    tier = "elite",
    text = {
      "This scroll will work in the dark and damp caves below Lumbridge Swamp. Orb scan range: 11 paces."
    },
    spots = {
      { x = 3172, y = 9570, level = 0 },
      { x = 3167, y = 9546, level = 0 },
      { x = 3179, y = 9559, level = 0 },
      { x = 3191, y = 9555, level = 0 },
      { x = 3170, y = 9557, level = 0 },
      { x = 3210, y = 9557, level = 0 },
      { x = 3233, y = 9547, level = 0 },
      { x = 3246, y = 9566, level = 0 },
      { x = 3252, y = 9577, level = 0 },
      { x = 3227, y = 9575, level = 0 },
      { x = 3209, y = 9587, level = 0 },
      { x = 3210, y = 9571, level = 0 }
    },
    range = 11,
    scantext = "The caves beneath Lumbridge Swamp"
  },
  {
    id = 363,
    type = "scan",
    tier = "elite",
    text = {
      "This scroll will work on the Fremennik Isles of Jatizso and Neitiznot. Orb scan range: 16 paces."
    },
    spots = {
      { x = 2354, y = 3790, level = 0 },
      { x = 2360, y = 3799, level = 0 },
      { x = 2324, y = 3808, level = 0 },
      { x = 2322, y = 3787, level = 0 },
      { x = 2311, y = 3801, level = 0 },
      { x = 2340, y = 3803, level = 0 },
      { x = 2342, y = 3809, level = 0 },
      { x = 2330, y = 3829, level = 0 },
      { x = 2311, y = 3835, level = 0 },
      { x = 2376, y = 3800, level = 0 },
      { x = 2381, y = 3789, level = 0 },
      { x = 2402, y = 3789, level = 0 },
      { x = 2421, y = 3792, level = 0 },
      { x = 2397, y = 3801, level = 0 },
      { x = 2419, y = 3833, level = 0 },
      { x = 2395, y = 3812, level = 0 },
      { x = 2373, y = 3834, level = 0 },
      { x = 2314, y = 3851, level = 0 },
      { x = 2326, y = 3866, level = 0 },
      { x = 2326, y = 3850, level = 0 },
      { x = 2354, y = 3853, level = 0 },
      { x = 2349, y = 3880, level = 0 },
      { x = 2312, y = 3894, level = 0 },
      { x = 2352, y = 3892, level = 0 },
      { x = 2414, y = 3848, level = 0 },
      { x = 2418, y = 3870, level = 0 },
      { x = 2377, y = 3850, level = 0 },
      { x = 2400, y = 3870, level = 0 },
      { x = 2368, y = 3870, level = 0 },
      { x = 2417, y = 3893, level = 0 },
      { x = 2399, y = 3888, level = 0 },
      { x = 2389, y = 3899, level = 0 }
    },
    range = 16,
    scantext = "Fremennik Isles of Jatizso and Neitiznot"
  },
  {
    id = 364,
    type = "scan",
    tier = "elite",
    text = { "This scroll will work within the walls of Falador. Orb scan range: 22 paces." },
    spots = {
      { x = 2938, y = 3322, level = 0 },
      { x = 2976, y = 3316, level = 0 },
      { x = 2947, y = 3316, level = 0 },
      { x = 3005, y = 3326, level = 0 },
      { x = 2958, y = 3379, level = 0 },
      { x = 2972, y = 3342, level = 0 },
      { x = 2945, y = 3339, level = 0 },
      { x = 2948, y = 3390, level = 0 },
      { x = 2942, y = 3388, level = 0 },
      { x = 2939, y = 3355, level = 0 },
      { x = 3039, y = 3331, level = 0 },
      { x = 3050, y = 3348, level = 0 },
      { x = 3015, y = 3339, level = 0 },
      { x = 3027, y = 3365, level = 0 },
      { x = 3025, y = 3379, level = 0 },
      { x = 3059, y = 3384, level = 0 },
      { x = 3031, y = 3379, level = 0 },
      { x = 3011, y = 3382, level = 0 }
    },
    range = 22,
    scantext = "Falador"
  },
  {
    id = 365,
    type = "scan",
    tier = "elite",
    text = {
      "This scroll will work in the cave goblin city of Dorgesh-Kaan. Orb scan range: 16 paces."
    },
    spots = {
      { x = 2747, y = 5263, level = 0 },
      { x = 2731, y = 5266, level = 0 },
      { x = 2740, y = 5273, level = 0 },
      { x = 2723, y = 5279, level = 0 },
      { x = 2711, y = 5271, level = 0 },
      { x = 2729, y = 5295, level = 0 },
      { x = 2711, y = 5284, level = 0 },
      { x = 2730, y = 5315, level = 0 },
      { x = 2717, y = 5311, level = 0 },
      { x = 2739, y = 5253, level = 1 },
      { x = 2738, y = 5301, level = 1 },
      { x = 2700, y = 5284, level = 1 },
      { x = 2704, y = 5321, level = 0 },
      { x = 2732, y = 5327, level = 0 },
      { x = 2704, y = 5349, level = 0 },
      { x = 2701, y = 5343, level = 1 },
      { x = 2704, y = 5357, level = 1 },
      { x = 2734, y = 5370, level = 1 },
      { x = 2747, y = 5327, level = 1 },
      { x = 2698, y = 5316, level = 1 }
    },
    range = 16,
    scantext = "Dorgesh-Kaan"
  },
  {
    id = 366,
    type = "scan",
    tier = "elite",
    text = {
      "This scroll will work in the Fremennik Slayer Dungeons. Orb scan range: 16 paces."
    },
    spots = {
      { x = 2720, y = 9969,  level = 0 },
      { x = 2741, y = 9977,  level = 0 },
      { x = 2701, y = 9978,  level = 0 },
      { x = 2724, y = 9977,  level = 0 },
      { x = 2714, y = 9990,  level = 0 },
      { x = 2731, y = 9998,  level = 0 },
      { x = 2718, y = 10000, level = 0 },
      { x = 2722, y = 10025, level = 0 },
      { x = 2705, y = 10027, level = 0 },
      { x = 2745, y = 10024, level = 0 },
      { x = 2743, y = 9986,  level = 0 },
      { x = 2751, y = 9995,  level = 0 },
      { x = 2754, y = 10009, level = 0 },
      { x = 2804, y = 10004, level = 0 },
      { x = 2808, y = 10018, level = 0 },
      { x = 2789, y = 10042, level = 0 },
      { x = 2772, y = 10030, level = 0 },
      { x = 2757, y = 10029, level = 0 },
      { x = 2767, y = 10002, level = 0 }
    },
    range = 16,
    scantext = "Fremennik Slayer Dungeons"
  },
  {
    id = 367,
    type = "scan",
    tier = "elite",
    text = {
      "This scroll will work in the crater of the Wilderness volcano. Orb scan range: 11 paces."
    },
    spots = {
      { x = 3112, y = 3678, level = 0 },
      { x = 3124, y = 3698, level = 0 },
      { x = 3130, y = 3672, level = 0 },
      { x = 3120, y = 3665, level = 0 },
      { x = 3104, y = 3704, level = 0 },
      { x = 3087, y = 3712, level = 0 },
      { x = 3133, y = 3717, level = 0 },
      { x = 3118, y = 3724, level = 0 },
      { x = 3110, y = 3735, level = 0 },
      { x = 3096, y = 3738, level = 0 },
      { x = 3134, y = 3741, level = 0 },
      { x = 3169, y = 3745, level = 0 },
      { x = 3180, y = 3713, level = 0 },
      { x = 3163, y = 3724, level = 0 },
      { x = 3146, y = 3738, level = 0 },
      { x = 3174, y = 3705, level = 0 },
      { x = 3152, y = 3698, level = 0 },
      { x = 3145, y = 3681, level = 0 },
      { x = 3146, y = 3698, level = 0 }
    },
    range = 11,
    scantext = "The crater in the Wilderness"
  },
  {
    id = 368,
    type = "scan",
    tier = "master",
    text = {
      "This scroll will work in the elven city of Prifddinas. Orb scan range: 30 paces."
    },
    spots = {
      { x = 2175, y = 3291, level = 1 },
      { x = 2133, y = 3379, level = 1 },
      { x = 2145, y = 3381, level = 1 },
      { x = 2148, y = 3351, level = 1 },
      { x = 2174, y = 3398, level = 1 },
      { x = 2180, y = 3322, level = 1 },
      { x = 2199, y = 3268, level = 1 },
      { x = 2212, y = 3272, level = 1 },
      { x = 2227, y = 3295, level = 1 },
      { x = 2224, y = 3328, level = 1 },
      { x = 2197, y = 3433, level = 1 },
      { x = 2222, y = 3429, level = 1 },
      { x = 2228, y = 3424, level = 1 },
      { x = 2247, y = 3267, level = 1 },
      { x = 2234, y = 3265, level = 1 },
      { x = 2275, y = 3382, level = 1 },
      { x = 2292, y = 3361, level = 1 },
      { x = 2268, y = 3397, level = 1 }
    },
    range = 30,
    scantext = "Prifddinas"
  },
  {
    id = 369,
    type = "scan",
    tier = "master",
    text = {
      "This scroll will work in the vampyre city of Darkmeyer. Orb scan range: 16 paces."
    },
    spots = {
      { x = 3599, y = 3328, level = 0 },
      { x = 3590, y = 3344, level = 0 },
      { x = 3588, y = 3361, level = 0 },
      { x = 3596, y = 3375, level = 0 },
      { x = 3631, y = 3358, level = 0 },
      { x = 3611, y = 3328, level = 0 },
      { x = 3606, y = 3391, level = 0 },
      { x = 3639, y = 3390, level = 0 },
      { x = 3651, y = 3405, level = 0 },
      { x = 3670, y = 3373, level = 0 },
      { x = 3632, y = 3344, level = 0 },
      { x = 3654, y = 3335, level = 0 },
      { x = 3666, y = 3344, level = 0 },
      { x = 3654, y = 3357, level = 0 },
      { x = 3671, y = 3366, level = 0 },
      { x = 3661, y = 3374, level = 0 },
      { x = 3676, y = 3392, level = 0 }
    },
    range = 16,
    scantext = "Darkmeyer"
  },
  {
    id = 370,
    type = "scan",
    tier = "master",
    text = {
      "This scroll will work on The Islands That Once Were Turtles. Orb scan range: 27 paces."
    },
    spots = {
      { x = 2103, y = 11425, level = 0 },
      { x = 2092, y = 11427, level = 0 },
      { x = 2100, y = 11432, level = 0 },
      { x = 2101, y = 11440, level = 0 },
      { x = 2099, y = 11448, level = 0 },
      { x = 2286, y = 11452, level = 0 },
      { x = 2285, y = 11440, level = 0 },
      { x = 2266, y = 11455, level = 0 },
      { x = 2221, y = 11497, level = 0 },
      { x = 2198, y = 11481, level = 0 },
      { x = 2183, y = 11500, level = 0 },
      { x = 2194, y = 11500, level = 0 },
      { x = 2200, y = 11501, level = 0 },
      { x = 2251, y = 11428, level = 0 },
      { x = 2267, y = 11441, level = 0 },
      { x = 2275, y = 11453, level = 0 },
      { x = 2283, y = 11499, level = 0 },
      { x = 2272, y = 11428, level = 0 },
      { x = 2286, y = 11473, level = 0 }
    },
    range = 27,
    scantext = "The Islands That Once Were Turtles"
  },
  {
    id = 371,
    type = "scan",
    tier = "master",
    text = { "This scroll will work in the Heart of Gielinor. Orb scan range: 49 paces." },
    spots = {
      { x = 3119, y = 6905, level = 1 },
      { x = 3124, y = 6905, level = 1 },
      { x = 3148, y = 6913, level = 1 },
      { x = 3131, y = 6921, level = 1 },
      { x = 3131, y = 6932, level = 1 },
      { x = 3156, y = 6925, level = 1 },
      { x = 3166, y = 6910, level = 1 },
      { x = 3165, y = 6932, level = 1 },
      { x = 3236, y = 6924, level = 1 },
      { x = 3257, y = 6927, level = 1 },
      { x = 3258, y = 6913, level = 1 },
      { x = 3248, y = 6903, level = 1 },
      { x = 3227, y = 6982, level = 1 },
      { x = 3217, y = 7004, level = 1 },
      { x = 3219, y = 7023, level = 1 },
      { x = 3180, y = 6985, level = 1 },
      { x = 3129, y = 6998, level = 1 },
      { x = 3141, y = 7018, level = 1 },
      { x = 3183, y = 7015, level = 1 },
      { x = 3194, y = 7029, level = 1 },
      { x = 3210, y = 7028, level = 1 },
      { x = 3229, y = 6980, level = 1 },
      { x = 3241, y = 7039, level = 1 },
      { x = 3147, y = 7046, level = 1 },
      { x = 3156, y = 7040, level = 1 },
      { x = 3274, y = 7045, level = 1 }
    },
    range = 49,
    scantext = "The Heart of Gielinor"
  },
  {
    id = 485,
    type = "scan",
    tier = "master",
    text = { "This scroll will work in the Lost Grove. Orb scan range: 14 paces." },
    spots = {
      { x = 1374, y = 5550, level = 0 },
      { x = 1390, y = 5616, level = 0 },
      { x = 1431, y = 5596, level = 0 },
      { x = 1421, y = 5627, level = 0 },
      { x = 1426, y = 5718, level = 0 },
      { x = 1417, y = 5684, level = 0 },
      { x = 1405, y = 5651, level = 0 },
      { x = 1392, y = 5730, level = 0 },
      { x = 1349, y = 5716, level = 0 },
      { x = 1361, y = 5733, level = 0 },
      { x = 1307, y = 5622, level = 0 },
      { x = 1375, y = 5687, level = 0 },
      { x = 1332, y = 5651, level = 0 },
      { x = 1373, y = 5634, level = 0 },
      { x = 1351, y = 5659, level = 0 },
      { x = 1368, y = 5609, level = 0 },
      { x = 1370, y = 5670, level = 0 }
    },
    range = 14,
    scantext = "The Lost Grove"
  },
  {
    id = 487,
    type = "scan",
    tier = "elite",
    text = { "This scroll will work in Wendlewick. Orb scan range: 12 paces." },
    spots = {
      { x = 3485, y = 1538, level = 0 },
      { x = 3471, y = 1555, level = 0 },
      { x = 3514, y = 1588, level = 0 },
      { x = 3477, y = 1578, level = 0 },
      { x = 3506, y = 1549, level = 0 },
      { x = 3494, y = 1517, level = 0 },
      { x = 3487, y = 1504, level = 0 },
      { x = 3466, y = 1523, level = 0 },
      { x = 3442, y = 1550, level = 0 },
      { x = 3421, y = 1525, level = 0 },
      { x = 3402, y = 1510, level = 0 },
      { x = 3437, y = 1494, level = 0 },
      { x = 3423, y = 1509, level = 0 },
      { x = 3471, y = 1498, level = 0 },
      { x = 3483, y = 1475, level = 0 },
      { x = 3529, y = 1500, level = 0 },
      { x = 3570, y = 1478, level = 0 },
      { x = 3554, y = 1470, level = 0 },
      { x = 3559, y = 1504, level = 0 },
      { x = 3564, y = 1532, level = 0 }
    },
    range = 12,
    scantext = "Wendlewick"
  },
  {
    id = 399,
    type = "compass",
    tier = "elite",
    text = { "The compass shows where you need to go." },
    challenge = { { type = "wizard" }, { type = "slider" }, { type = "celticknot" } },
    spots = {
      { x = 2413, y = 2818, level = 0 },
      { x = 2398, y = 2862, level = 0 },
      { x = 2476, y = 2845, level = 0 },
      { x = 2493, y = 2875, level = 0 },
      { x = 2546, y = 2872, level = 0 },
      { x = 2547, y = 2826, level = 0 },
      { x = 2617, y = 2876, level = 0 },
      { x = 2598, y = 2838, level = 0 },
      { x = 2445, y = 2917, level = 0 },
      { x = 2458, y = 2893, level = 0 },
      { x = 2541, y = 2926, level = 0 },
      { x = 2511, y = 2936, level = 0 },
      { x = 2578, y = 2930, level = 0 },
      { x = 2589, y = 2898, level = 0 },
      { x = 2482, y = 2977, level = 0 },
      { x = 2490, y = 2949, level = 0 },
      { x = 2511, y = 2980, level = 0 },
      { x = 2535, y = 2958, level = 0 },
      { x = 2590, y = 2994, level = 0 },
      { x = 2592, y = 2956, level = 0 },
      { x = 2640, y = 2987, level = 0 },
      { x = 2638, y = 2948, level = 0 },
      { x = 2330, y = 3057, level = 0 },
      { x = 2355, y = 3038, level = 0 },
      { x = 2393, y = 3046, level = 0 },
      { x = 2418, y = 3040, level = 0 },
      { x = 2481, y = 3011, level = 0 },
      { x = 2439, y = 3057, level = 0 },
      { x = 2564, y = 3041, level = 0 },
      { x = 2590, y = 3063, level = 0 },
      { x = 2629, y = 3123, level = 0 },
      { x = 2671, y = 3109, level = 0 },
      { x = 2579, y = 3130, level = 0 },
      { x = 2610, y = 3076, level = 0 },
      { x = 2519, y = 3115, level = 0 },
      { x = 2559, y = 3102, level = 0 },
      { x = 2449, y = 3110, level = 0 },
      { x = 2486, y = 3134, level = 0 },
      { x = 2433, y = 3144, level = 0 },
      { x = 2468, y = 3177, level = 0 },
      { x = 2498, y = 3175, level = 0 },
      { x = 2557, y = 3164, level = 0 },
      { x = 2619, y = 3153, level = 0 },
      { x = 2595, y = 3192, level = 0 },
      { x = 2651, y = 3148, level = 0 },
      { x = 2627, y = 3172, level = 0 },
      { x = 2457, y = 3221, level = 0 },
      { x = 2478, y = 3254, level = 0 },
      { x = 2543, y = 3211, level = 0 },
      { x = 2502, y = 3249, level = 0 },
      { x = 2583, y = 3223, level = 0 },
      { x = 2592, y = 3251, level = 0 },
      { x = 2634, y = 3208, level = 0 },
      { x = 2646, y = 3251, level = 0 },
      { x = 2492, y = 3270, level = 0 },
      { x = 2451, y = 3283, level = 0 },
      { x = 2506, y = 3276, level = 0 },
      { x = 2582, y = 3266, level = 0 },
      { x = 2582, y = 3314, level = 0 },
      { x = 2665, y = 3266, level = 0 },
      { x = 2650, y = 3302, level = 0 },
      { x = 2723, y = 3277, level = 0 },
      { x = 2700, y = 3311, level = 0 },
      { x = 2381, y = 3388, level = 0 },
      { x = 2410, y = 3388, level = 0 },
      { x = 2457, y = 3331, level = 0 },
      { x = 2485, y = 3377, level = 0 },
      { x = 2541, y = 3389, level = 0 },
      { x = 2513, y = 3351, level = 0 },
      { x = 2581, y = 3340, level = 0 },
      { x = 2576, y = 3370, level = 0 },
      { x = 2651, y = 3351, level = 0 },
      { x = 2662, y = 3338, level = 0 },
      { x = 2724, y = 3360, level = 0 },
      { x = 2739, y = 3388, level = 0 },
      { x = 2359, y = 3448, level = 0 },
      { x = 2392, y = 3398, level = 0 },
      { x = 2410, y = 3419, level = 0 },
      { x = 2438, y = 3398, level = 0 },
      { x = 2470, y = 3404, level = 0 },
      { x = 2522, y = 3429, level = 0 },
      { x = 2531, y = 3405, level = 0 },
      { x = 2583, y = 3449, level = 0 },
      { x = 2565, y = 3395, level = 0 },
      { x = 2677, y = 3400, level = 0 },
      { x = 2657, y = 3451, level = 0 },
      { x = 2726, y = 3399, level = 0 },
      { x = 2705, y = 3418, level = 0 },
      { x = 2765, y = 3445, level = 0 },
      { x = 2797, y = 3428, level = 0 },
      { x = 2835, y = 3423, level = 0 },
      { x = 2834, y = 3451, level = 0 },
      { x = 2926, y = 3402, level = 0 },
      { x = 2908, y = 3431, level = 0 },
      { x = 2950, y = 3406, level = 0 },
      { x = 2995, y = 3429, level = 0 },
      { x = 3055, y = 3396, level = 0 },
      { x = 3027, y = 3454, level = 0 },
      { x = 3089, y = 3409, level = 0 },
      { x = 3134, y = 3423, level = 0 },
      { x = 3158, y = 3439, level = 0 },
      { x = 3176, y = 3400, level = 0 },
      { x = 3228, y = 3409, level = 0 },
      { x = 3233, y = 3446, level = 0 },
      { x = 3276, y = 3444, level = 0 },
      { x = 3318, y = 3426, level = 0 },
      { x = 3390, y = 3421, level = 0 },
      { x = 3362, y = 3403, level = 0 },
      { x = 3411, y = 3410, level = 0 },
      { x = 3439, y = 3454, level = 0 },
      { x = 3473, y = 3401, level = 0 },
      { x = 3461, y = 3432, level = 0 },
      { x = 3538, y = 3449, level = 0 },
      { x = 3563, y = 3408, level = 0 },
      { x = 2356, y = 3498, level = 0 },
      { x = 2325, y = 3510, level = 0 },
      { x = 2394, y = 3513, level = 0 },
      { x = 2401, y = 3458, level = 0 },
      { x = 2489, y = 3487, level = 0 },
      { x = 2457, y = 3511, level = 0 },
      { x = 2504, y = 3484, level = 0 },
      { x = 2550, y = 3475, level = 0 },
      { x = 2588, y = 3506, level = 0 },
      { x = 2609, y = 3470, level = 0 },
      { x = 2649, y = 3473, level = 0 },
      { x = 2683, y = 3491, level = 0 },
      { x = 2707, y = 3475, level = 0 },
      { x = 2733, y = 3502, level = 0 },
      { x = 2777, y = 3501, level = 0 },
      { x = 2808, y = 3474, level = 0 },
      { x = 2832, y = 3473, level = 0 },
      { x = 2859, y = 3508, level = 0 },
      { x = 2937, y = 3511, level = 0 },
      { x = 2900, y = 3501, level = 0 },
      { x = 2956, y = 3505, level = 0 },
      { x = 2983, y = 3473, level = 0 },
      { x = 3035, y = 3490, level = 0 },
      { x = 3021, y = 3470, level = 0 },
      { x = 3103, y = 3488, level = 0 },
      { x = 3127, y = 3469, level = 0 },
      { x = 3145, y = 3510, level = 0 },
      { x = 3190, y = 3464, level = 0 },
      { x = 3254, y = 3505, level = 0 },
      { x = 3260, y = 3460, level = 0 },
      { x = 3317, y = 3507, level = 0 },
      { x = 3288, y = 3460, level = 0 },
      { x = 3329, y = 3518, level = 0 },
      { x = 3373, y = 3483, level = 0 },
      { x = 3420, y = 3479, level = 0 },
      { x = 3452, y = 3476, level = 0 },
      { x = 3487, y = 3492, level = 0 },
      { x = 3516, y = 3473, level = 0 },
      { x = 3529, y = 3501, level = 0 },
      { x = 3576, y = 3481, level = 0 },
      { x = 3598, y = 3509, level = 0 },
      { x = 3619, y = 3485, level = 0 },
      { x = 3649, y = 3475, level = 0 },
      { x = 3678, y = 3518, level = 0 },
      { x = 2336, y = 3540, level = 0 },
      { x = 2351, y = 3572, level = 0 },
      { x = 2418, y = 3525, level = 0 },
      { x = 2394, y = 3574, level = 0 },
      { x = 2491, y = 3529, level = 0 },
      { x = 2542, y = 3562, level = 0 },
      { x = 2677, y = 3539, level = 0 },
      { x = 2653, y = 3578, level = 0 },
      { x = 2699, y = 3537, level = 0 },
      { x = 2721, y = 3577, level = 0 },
      { x = 2757, y = 3548, level = 0 },
      { x = 2757, y = 3581, level = 0 },
      { x = 2878, y = 3529, level = 0 },
      { x = 2860, y = 3575, level = 0 },
      { x = 2928, y = 3573, level = 0 },
      { x = 2919, y = 3535, level = 0 },
      { x = 2979, y = 3546, level = 0 },
      { x = 2986, y = 3583, level = 0 },
      { x = 3052, y = 3548, level = 0 },
      { x = 3030, y = 3520, level = 0 },
      { x = 3096, y = 3534, level = 0 },
      { x = 3125, y = 3578, level = 0 },
      { x = 3153, y = 3545, level = 0 },
      { x = 3184, y = 3559, level = 0 },
      { x = 3229, y = 3541, level = 0 },
      { x = 3255, y = 3576, level = 0 },
      { x = 3289, y = 3528, level = 0 },
      { x = 3292, y = 3574, level = 0 },
      { x = 3376, y = 3567, level = 0 },
      { x = 3339, y = 3572, level = 0 },
      { x = 3418, y = 3544, level = 0 },
      { x = 3432, y = 3544, level = 0 },
      { x = 3460, y = 3553, level = 0 },
      { x = 3510, y = 3530, level = 0 },
      { x = 3571, y = 3534, level = 0 },
      { x = 3547, y = 3524, level = 0 },
      { x = 3624, y = 3524, level = 0 },
      { x = 3596, y = 3541, level = 0 },
      { x = 3655, y = 3537, level = 0 },
      { x = 2262, y = 3605, level = 0 },
      { x = 2295, y = 3639, level = 0 },
      { x = 2332, y = 3610, level = 0 },
      { x = 2347, y = 3594, level = 0 },
      { x = 2392, y = 3599, level = 0 },
      { x = 2374, y = 3630, level = 0 },
      { x = 2509, y = 3634, level = 0 },
      { x = 2559, y = 3619, level = 0 },
      { x = 2606, y = 3635, level = 0 },
      { x = 2586, y = 3605, level = 0 },
      { x = 2684, y = 3612, level = 0 },
      { x = 2669, y = 3637, level = 0 },
      { x = 2708, y = 3589, level = 0 },
      { x = 2737, y = 3626, level = 0 },
      { x = 2779, y = 3594, level = 0 },
      { x = 2780, y = 3635, level = 0 },
      { x = 2999, y = 3606, level = 0 },
      { x = 2965, y = 3632, level = 0 },
      { x = 3059, y = 3620, level = 0 },
      { x = 3028, y = 3632, level = 0 },
      { x = 3092, y = 3605, level = 0 },
      { x = 3127, y = 3597, level = 0 },
      { x = 3179, y = 3612, level = 0 },
      { x = 3146, y = 3642, level = 0 },
      { x = 3254, y = 3624, level = 0 },
      { x = 3247, y = 3597, level = 0 },
      { x = 3304, y = 3605, level = 0 },
      { x = 3278, y = 3615, level = 0 },
      { x = 3338, y = 3638, level = 0 },
      { x = 3342, y = 3591, level = 0 },
      { x = 3433, y = 3639, level = 0 },
      { x = 3403, y = 3640, level = 0 },
      { x = 2309, y = 3669, level = 0 },
      { x = 2332, y = 3659, level = 0 },
      { x = 2612, y = 3658, level = 0 },
      { x = 2643, y = 3679, level = 0 },
      { x = 2680, y = 3676, level = 0 },
      { x = 2712, y = 3653, level = 0 },
      { x = 2696, y = 3695, level = 0 },
      { x = 2756, y = 3651, level = 0 },
      { x = 2972, y = 3682, level = 0 },
      { x = 2999, y = 3671, level = 0 },
      { x = 2956, y = 3705, level = 0 },
      { x = 2965, y = 3740, level = 0 },
      { x = 3088, y = 3678, level = 0 },
      { x = 3107, y = 3653, level = 0 },
      { x = 3187, y = 3661, level = 0 },
      { x = 3142, y = 3656, level = 0 },
      { x = 3220, y = 3667, level = 0 },
      { x = 3210, y = 3695, level = 0 },
      { x = 3280, y = 3664, level = 0 },
      { x = 3315, y = 3704, level = 0 },
      { x = 3353, y = 3664, level = 0 },
      { x = 3378, y = 3699, level = 0 },
      { x = 3437, y = 3682, level = 0 },
      { x = 3423, y = 3706, level = 0 },
      { x = 3511, y = 3670, level = 0 },
      { x = 3470, y = 3710, level = 0 },
      { x = 2666, y = 3717, level = 0 },
      { x = 2686, y = 3727, level = 0 },
      { x = 2725, y = 3751, level = 0 },
      { x = 2744, y = 3735, level = 0 },
      { x = 2975, y = 3762, level = 0 },
      { x = 2985, y = 3715, level = 0 },
      { x = 3060, y = 3767, level = 0 },
      { x = 3046, y = 3752, level = 0 },
      { x = 3104, y = 3745, level = 0 },
      { x = 3116, y = 3769, level = 0 },
      { x = 3153, y = 3744, level = 0 },
      { x = 3193, y = 3739, level = 0 },
      { x = 3213, y = 3756, level = 0 },
      { x = 3255, y = 3740, level = 0 },
      { x = 3342, y = 3732, level = 0 },
      { x = 3367, y = 3766, level = 0 },
      { x = 3432, y = 3754, level = 0 },
      { x = 3430, y = 3717, level = 0 },
      { x = 3506, y = 3734, level = 0 },
      { x = 2737, y = 3796, level = 0 },
      { x = 2185, y = 3637, level = 0 },
      { x = 2960, y = 3824, level = 0 },
      { x = 2999, y = 3791, level = 0 },
      { x = 3059, y = 3833, level = 0 },
      { x = 3051, y = 3804, level = 0 },
      { x = 3101, y = 3783, level = 0 },
      { x = 3128, y = 3822, level = 0 },
      { x = 3151, y = 3795, level = 0 },
      { x = 3193, y = 3783, level = 0 },
      { x = 3250, y = 3821, level = 0 },
      { x = 3208, y = 3792, level = 0 },
      { x = 3363, y = 3807, level = 0 },
      { x = 3349, y = 3823, level = 0 },
      { x = 2958, y = 3858, level = 0 },
      { x = 2990, y = 3883, level = 0 },
      { x = 3037, y = 3870, level = 0 },
      { x = 3055, y = 3895, level = 0 },
      { x = 3088, y = 3891, level = 0 },
      { x = 3127, y = 3891, level = 0 },
      { x = 3157, y = 3865, level = 0 },
      { x = 3195, y = 3877, level = 0 },
      { x = 3250, y = 3843, level = 0 },
      { x = 3252, y = 3887, level = 0 },
      { x = 3294, y = 3865, level = 0 },
      { x = 3317, y = 3896, level = 0 },
      { x = 3383, y = 3893, level = 0 },
      { x = 3336, y = 3898, level = 0 },
      { x = 2971, y = 3929, level = 0 },
      { x = 2990, y = 3948, level = 0 },
      { x = 3055, y = 3915, level = 0 },
      { x = 3060, y = 3941, level = 0 },
      { x = 3128, y = 3913, level = 0 },
      { x = 3110, y = 3954, level = 0 },
      { x = 3155, y = 3924, level = 0 },
      { x = 3181, y = 3944, level = 0 },
      { x = 3244, y = 3907, level = 0 },
      { x = 3242, y = 3956, level = 0 },
      { x = 3306, y = 3947, level = 0 },
      { x = 3275, y = 3915, level = 0 },
      { x = 3388, y = 3930, level = 0 },
      { x = 3429, y = 3924, level = 0 },
      { x = 2901, y = 3356, level = 0 },
      { x = 2915, y = 3335, level = 0 },
      { x = 2972, y = 3342, level = 0 },
      { x = 2976, y = 3386, level = 0 },
      { x = 3027, y = 3365, level = 0 },
      { x = 3050, y = 3348, level = 0 },
      { x = 3125, y = 3371, level = 0 },
      { x = 3081, y = 3363, level = 0 },
      { x = 3158, y = 3376, level = 0 },
      { x = 3140, y = 3343, level = 0 },
      { x = 3243, y = 3378, level = 0 },
      { x = 3240, y = 3351, level = 0 },
      { x = 3312, y = 3376, level = 0 },
      { x = 3304, y = 3335, level = 0 },
      { x = 3352, y = 3381, level = 0 },
      { x = 3358, y = 3353, level = 0 },
      { x = 3438, y = 3349, level = 0 },
      { x = 3408, y = 3390, level = 0 },
      { x = 3474, y = 3385, level = 0 },
      { x = 3485, y = 3362, level = 0 },
      { x = 2915, y = 3302, level = 0 },
      { x = 2917, y = 3271, level = 0 },
      { x = 2976, y = 3274, level = 0 },
      { x = 2976, y = 3316, level = 0 },
      { x = 3033, y = 3286, level = 0 },
      { x = 3066, y = 3322, level = 0 },
      { x = 3128, y = 3310, level = 0 },
      { x = 3129, y = 3268, level = 0 },
      { x = 3188, y = 3317, level = 0 },
      { x = 3146, y = 3312, level = 0 },
      { x = 3210, y = 3305, level = 0 },
      { x = 3242, y = 3268, level = 0 },
      { x = 3265, y = 3300, level = 0 },
      { x = 3309, y = 3298, level = 0 },
      { x = 3347, y = 3273, level = 0 },
      { x = 3349, y = 3312, level = 0 },
      { x = 3450, y = 3276, level = 0 },
      { x = 3422, y = 3302, level = 0 },
      { x = 3488, y = 3270, level = 0 },
      { x = 3478, y = 3292, level = 0 },
      { x = 3538, y = 3311, level = 0 },
      { x = 3582, y = 3312, level = 0 },
      { x = 2920, y = 3249, level = 0 },
      { x = 2932, y = 3216, level = 0 },
      { x = 2982, y = 3203, level = 0 },
      { x = 2997, y = 3241, level = 0 },
      { x = 3042, y = 3251, level = 0 },
      { x = 3019, y = 3242, level = 0 },
      { x = 3091, y = 3258, level = 0 },
      { x = 3122, y = 3227, level = 0 },
      { x = 3137, y = 3212, level = 0 },
      { x = 3135, y = 3257, level = 0 },
      { x = 3210, y = 3205, level = 0 },
      { x = 3263, y = 3253, level = 0 },
      { x = 3271, y = 3204, level = 0 },
      { x = 3323, y = 3225, level = 0 },
      { x = 3486, y = 3245, level = 0 },
      { x = 3519, y = 3246, level = 0 },
      { x = 2986, y = 3191, level = 0 },
      { x = 2997, y = 3149, level = 0 },
      { x = 3028, y = 3171, level = 0 },
      { x = 3011, y = 3195, level = 0 },
      { x = 3119, y = 3167, level = 0 },
      { x = 3083, y = 3155, level = 0 },
      { x = 3146, y = 3170, level = 0 },
      { x = 3195, y = 3163, level = 0 },
      { x = 3240, y = 3161, level = 0 },
      { x = 3235, y = 3191, level = 0 },
      { x = 3272, y = 3156, level = 0 },
      { x = 3293, y = 3183, level = 0 },
      { x = 3391, y = 3180, level = 0 },
      { x = 3350, y = 3162, level = 0 },
      { x = 3418, y = 3164, level = 0 },
      { x = 3394, y = 3149, level = 0 },
      { x = 3465, y = 3140, level = 0 },
      { x = 3210, y = 3092, level = 0 },
      { x = 3257, y = 3117, level = 0 },
      { x = 3304, y = 3126, level = 0 },
      { x = 3303, y = 3077, level = 0 },
      { x = 3378, y = 3078, level = 0 },
      { x = 3344, y = 3112, level = 0 },
      { x = 3429, y = 3106, level = 0 },
      { x = 3410, y = 3079, level = 0 },
      { x = 3483, y = 3108, level = 0 },
      { x = 3509, y = 3088, level = 0 },
      { x = 3171, y = 3028, level = 0 },
      { x = 3189, y = 3047, level = 0 },
      { x = 3235, y = 3048, level = 0 },
      { x = 3215, y = 3020, level = 0 },
      { x = 3303, y = 3050, level = 0 },
      { x = 3320, y = 3013, level = 0 },
      { x = 3355, y = 3044, level = 0 },
      { x = 3383, y = 3019, level = 0 },
      { x = 3419, y = 3017, level = 0 },
      { x = 3422, y = 3046, level = 0 },
      { x = 3468, y = 3044, level = 0 },
      { x = 3509, y = 3025, level = 0 },
      { x = 3170, y = 2982, level = 0 },
      { x = 3142, y = 3003, level = 0 },
      { x = 3225, y = 2986, level = 0 },
      { x = 3256, y = 2953, level = 0 },
      { x = 3289, y = 2957, level = 0 },
      { x = 3319, y = 2990, level = 0 },
      { x = 3376, y = 2988, level = 0 },
      { x = 3346, y = 2958, level = 0 },
      { x = 3404, y = 2992, level = 0 },
      { x = 3442, y = 2955, level = 0 },
      { x = 3170, y = 2914, level = 0 },
      { x = 3177, y = 2888, level = 0 },
      { x = 3245, y = 2935, level = 0 },
      { x = 3205, y = 2895, level = 0 },
      { x = 3296, y = 2891, level = 0 },
      { x = 3316, y = 2930, level = 0 },
      { x = 3361, y = 2921, level = 0 },
      { x = 3373, y = 2898, level = 0 },
      { x = 3423, y = 2916, level = 0 },
      { x = 3434, y = 2888, level = 0 },
      { x = 3218, y = 2843, level = 0 },
      { x = 3247, y = 2866, level = 0 },
      { x = 3290, y = 2840, level = 0 },
      { x = 3321, y = 2848, level = 0 },
      { x = 3390, y = 2841, level = 0 },
      { x = 3341, y = 2836, level = 0 },
      { x = 3376, y = 2790, level = 0 },
      { x = 3351, y = 2781, level = 0 },
      { x = 3401, y = 2758, level = 0 },
      { x = 3359, y = 2753, level = 0 },
      { x = 2703, y = 3204, level = 0 },
      { x = 2746, y = 3232, level = 0 },
      { x = 2772, y = 3217, level = 0 },
      { x = 2805, y = 3204, level = 0 },
      { x = 2743, y = 3174, level = 0 },
      { x = 2734, y = 3144, level = 0 },
      { x = 2802, y = 3156, level = 0 },
      { x = 2762, y = 3172, level = 0 },
      { x = 2843, y = 3153, level = 0 },
      { x = 2874, y = 3173, level = 0 },
      { x = 2912, y = 3168, level = 0 },
      { x = 2906, y = 3141, level = 0 },
      { x = 2763, y = 3125, level = 0 },
      { x = 2786, y = 3075, level = 0 },
      { x = 2846, y = 3078, level = 0 },
      { x = 2831, y = 3119, level = 0 },
      { x = 2912, y = 3116, level = 0 },
      { x = 2881, y = 3073, level = 0 },
      { x = 2761, y = 3057, level = 0 },
      { x = 2779, y = 3023, level = 0 },
      { x = 2869, y = 3026, level = 0 },
      { x = 2835, y = 3025, level = 0 },
      { x = 2930, y = 3029, level = 0 },
      { x = 2901, y = 3031, level = 0 },
      { x = 2791, y = 2969, level = 0 },
      { x = 2757, y = 2949, level = 0 },
      { x = 2916, y = 2992, level = 0 },
      { x = 2881, y = 2968, level = 0 },
      { x = 2970, y = 2979, level = 0 },
      { x = 2958, y = 2996, level = 0 },
      { x = 2804, y = 2924, level = 0 },
      { x = 2793, y = 2893, level = 0 },
      { x = 2858, y = 2890, level = 0 },
      { x = 2841, y = 2934, level = 0 },
      { x = 2920, y = 2888, level = 0 },
      { x = 2932, y = 2933, level = 0 },
      { x = 2960, y = 2928, level = 0 },
      { x = 2856, y = 3455, level = 0 },
      { x = 3082, y = 3475, level = 0 },
      { x = 2778, y = 3583, level = 0 },
      { x = 3265, y = 3270, level = 0 },
      { x = 3508, y = 3673, level = 0 },
      { x = 2864, y = 3589, level = 0 }
    },
    valid_area = { topleft = { x = 1922, y = 4092 }, botright = { x = 3902, y = 2500 }, level = 0 }
  },
  {
    id = 400,
    type = "compass",
    tier = "master",
    text = { "The compass shows where you need to go on the arc." },
    challenge = { { type = "wizard" }, { type = "lockbox" }, { type = "towers" } },
    spots = {
      { x = 1868, y = 11649, level = 0 },
      { x = 1904, y = 11604, level = 0 },
      { x = 1879, y = 11559, level = 0 },
      { x = 1812, y = 11620, level = 0 },
      { x = 2349, y = 11182, level = 0 },
      { x = 2283, y = 11163, level = 0 },
      { x = 2265, y = 11223, level = 0 },
      { x = 2323, y = 11222, level = 0 },
      { x = 2106, y = 11279, level = 0 },
      { x = 2069, y = 11338, level = 0 },
      { x = 2093, y = 11354, level = 0 },
      { x = 2117, y = 11313, level = 0 },
      { x = 2091, y = 11296, level = 0 },
      { x = 2449, y = 11564, level = 0 },
      { x = 2506, y = 11593, level = 0 },
      { x = 2508, y = 11605, level = 0 },
      { x = 2494, y = 11553, level = 0 },
      { x = 1779, y = 11993, level = 0 },
      { x = 1759, y = 11986, level = 0 },
      { x = 1759, y = 11966, level = 0 },
      { x = 1771, y = 11919, level = 0 },
      { x = 2040, y = 11800, level = 0 },
      { x = 2073, y = 11813, level = 0 },
      { x = 2035, y = 11823, level = 0 },
      { x = 2004, y = 11801, level = 0 },
      { x = 1966, y = 11814, level = 0 },
      { x = 1939, y = 11801, level = 0 },
      { x = 2278, y = 11503, level = 0 },
      { x = 2282, y = 11464, level = 0 },
      { x = 2193, y = 11480, level = 0 },
      { x = 2089, y = 11432, level = 0 }
    },
    valid_area = {
      topleft = { x = 1600, y = 12159 },
      botright = { x = 2751, y = 11008 },
      level = 0
    }
  },
  {
    id = 470,
    type = "compass",
    tier = "tetracompass",
    single_tile_target = true,
    text = { "The compass shows where you need to dig up the casket." },
    valid_area = { topleft = { x = 1922, y = 4092 }, botright = { x = 3902, y = 2500 }, level = 0 },
    spots = {
      { x = 2935, y = 3489, level = 0 },
      { x = 2946, y = 3462, level = 0 },
      { x = 2945, y = 3274, level = 0 },
      { x = 2896, y = 3550, level = 0 },
      { x = 2595, y = 2932, level = 0 },
      { x = 2623, y = 3001, level = 0 },
      { x = 2462, y = 2897, level = 0 },
      { x = 2573, y = 2922, level = 0 },
      { x = 2606, y = 2956, level = 0 },
      { x = 2600, y = 2934, level = 0 },
      { x = 2553, y = 2985, level = 0 },
      { x = 2614, y = 3624, level = 0 },
      { x = 2713, y = 3628, level = 0 },
      { x = 2674, y = 3710, level = 0 },
      { x = 2729, y = 3606, level = 0 },
      { x = 2590, y = 3263, level = 0 },
      { x = 2680, y = 3370, level = 0 },
      { x = 2468, y = 3278, level = 0 },
      { x = 2557, y = 3370, level = 0 },
      { x = 2752, y = 3394, level = 0 },
      { x = 2482, y = 3357, level = 0 },
      { x = 2609, y = 3383, level = 0 },
      { x = 2554, y = 3467, level = 0 },
      { x = 2546, y = 3522, level = 0 },
      { x = 2534, y = 3429, level = 0 },
      { x = 2425, y = 3187, level = 0 },
      { x = 2460, y = 3198, level = 0 },
      { x = 2305, y = 3544, level = 0 },
      { x = 2322, y = 3548, level = 0 },
      { x = 2269, y = 3537, level = 0 },
      { x = 2363, y = 3574, level = 0 },
      { x = 2357, y = 3551, level = 0 },
      { x = 2365, y = 3545, level = 0 },
      { x = 2315, y = 3548, level = 0 },
      { x = 2720, y = 3468, level = 0 },
      { x = 2704, y = 3453, level = 0 },
      { x = 2708, y = 3449, level = 0 },
      { x = 2722, y = 3577, level = 0 },
      { x = 2632, y = 3489, level = 0 },
      { x = 2764, y = 3478, level = 0 },
      { x = 2450, y = 3516, level = 0 },
      { x = 2453, y = 3554, level = 0 },
      { x = 2358, y = 3483, level = 0 },
      { x = 2419, y = 3397, level = 0 },
      { x = 2516, y = 3187, level = 0 },
      { x = 2504, y = 3205, level = 0 },
      { x = 2578, y = 3118, level = 0 },
      { x = 2578, y = 3139, level = 0 },
      { x = 2587, y = 3076, level = 0 },
      { x = 2857, y = 2970, level = 0 },
      { x = 2779, y = 3100, level = 0 },
      { x = 2910, y = 3075, level = 0 },
      { x = 2705, y = 3157, level = 0 },
      { x = 2726, y = 3223, level = 0 },
      { x = 2835, y = 2927, level = 0 },
      { x = 3256, y = 3195, level = 0 },
      { x = 3142, y = 3251, level = 0 },
      { x = 3356, y = 3396, level = 0 },
      { x = 3200, y = 3200, level = 0 },
      { x = 3731, y = 3164, level = 0 },
      { x = 2196, y = 3101, level = 0 },
      { x = 2254, y = 3119, level = 0 },
      { x = 2207, y = 3156, level = 0 },
      { x = 2168, y = 3083, level = 0 },
      { x = 2281, y = 3190, level = 0 },
      { x = 2893, y = 3656, level = 0 },
      { x = 2860, y = 3662, level = 0 },
      { x = 3162, y = 3542, level = 0 },
      { x = 3430, y = 3649, level = 0 },
      { x = 2961, y = 3821, level = 0 },
      { x = 3237, y = 3664, level = 0 },
      { x = 2992, y = 3686, level = 0 },
      { x = 2965, y = 3746, level = 0 }
    }
  },
  {
    type = "skilling",
    text = {
      "Crossing the desert I met a crocodile. She gave me a dazzling smile but she had something in her teeth."
    },
    tier = "master",
    id = 372,
    areas = { { origin = { x = 3274, y = 2677, level = 0 }, size = { x = 8, y = 9 } } },
    answer = "Catch a plover bird in the southern part of Sophanem.",
    cursor = "hunt"
  },
  {
    type = "skilling",
    text = {
      "I once met a man returning from market. He showed me the spoils of his day. It's precious to see what people pay for."
    },
    tier = "master",
    id = 373,
    areas = { { origin = { x = 2666, y = 3301, level = 0 }, size = { x = 4, y = 5 } } },
    answer = "Steal from the Ardougne Gem Stall.",
    cursor = "thieve",
    target = "Gem stall",
    relevant_configs = { { domain = "loc", name = "AREA_ARDOUGNE_GEMTHIEFSTALL" } }
  },
  {
    type = "skilling",
    text = { "A view of the city from high above. I can hear their prayers below." },
    tier = "master",
    id = 374,
    areas = { { origin = { x = 2189, y = 3441, level = 2 }, size = { x = 3, y = 3 } } },
    cursor = "agility",
    answer = "Go to the top of the Hefin Agility Course."
  },
  {
    type = "skilling",
    text = { "Round and round we go, burning, burning all aglow." },
    tier = "master",
    id = 375,
    areas = { { origin = { x = 3017, y = 9242, level = 0 }, size = { x = 4, y = 4 } } },
    cursor = "burn",
    ingredients = {
      { name = "Curly root", configs = { { domain = "obj", name = "JARO_ROOT_CURLY" } } }
    },
    target = "Dry patch",
    relevant_configs = { { domain = "loc", name = "JARO_FIREPIT" } },
    answer = "Start a firepit with a Curly Root in the Jadinko Lair."
  },
  {
    type = "skilling",
    text = {
      "When I encountered this individual, she had more rings than any I had seen before."
    },
    tier = "master",
    id = 376,
    areas = { { origin = { x = 2269, y = 3386, level = 1 }, size = { x = 5, y = 5 } } },
    answer = "Cut some elder logs from an elder tree.",
    cursor = "chop",
    target = "Elder tree",
    relevant_configs = { { domain = "loc", name = "FARMING_ELDER_TREE_PATCH_1" } }
  },
  {
    type = "skilling",
    text = { "Rowdy Unruly Boisterous I am pie." },
    tier = "master",
    id = 377,
    answer = "Cook a wild pie. The 'Bake Pie' spell works.",
    cursor = "cook",
    ingredients = {
      {
        name = "Raw wild pie",
        configs = { { domain = "obj", name = "UNCOOKED_WILD_PIE" } }
      }
    },
    target = "Range",
    relevant_configs = { { domain = "loc", name = "RANGE" } },
    areas = { { origin = { x = 2633, y = 3164, level = 0 }, size = { x = 2, y = 2 } } }
  },
  {
    type = "skilling",
    text = {
      "In a station of power someone requires assistance. Do a good deed to spread some happiness."
    },
    tier = "master",
    id = 378,
    areas = { { origin = { x = 2698, y = 5186, level = 2 }, size = { x = 50, y = 61 } } },
    cursor = "agility",
    target = "Turgall",
    relevant_configs = { { domain = "npc", name = "DORGESH_MALE_ENGINEER" } },
    answer = "Help Turgall at the Dorgesh-Kaan Agility Course."
  },
  {
    type = "skilling",
    text = {
      "Those things I once held dear continue to fade. I look upon her face and barely know who she is. But her eyes... They are still so radiant."
    },
    tier = "master",
    id = 379,
    areas = { { origin = { x = 3800, y = 3547, level = 0 }, size = { x = 10, y = 10 } } },
    cursor = "divine",
    answer = "Harvest a radiant memory."
  },
  {
    type = "skilling",
    text = {
      "There are those who prove themselves and become a beacon of light in the darkness. Come to the crystal city and become that figure."
    },
    tier = "master",
    cursor = "pray",
    id = 380,
    areas = { { origin = { x = 2199, y = 3352, level = 1 }, size = { x = 19, y = 19 } } },
    answer = "Active the Light Form Prayer in Prifddinas"
  },
  {
    type = "skilling",
    text = {
      "Stare into the flames for long enough and you may see something you didn't realise was there."
    },
    tier = "master",
    id = 381,
    answer = "Light some magic logs.",
    cursor = "burn",
    ingredients = {
      {
        name = "Magic logs or corrupted magic logs",
        configs = {
          { domain = "obj", name = "MAGIC_LOGS" },
          { domain = "obj", name = "MENAPHOS_CORRUPTED_LOGS" }
        }
      }
    },
    target = "Fire",
    relevant_configs = {},
    areas = {
      {
        origin = { x = 4310, y = 823, level = 0 },
        size = { x = 3, y = 2 },
        data = "Og=="
      }
    }
  },
  {
    type = "skilling",
    text = {
      "The crystals tempt most however, there are other riches to gain for the quick-fingered."
    },
    tier = "master",
    id = 382,
    answer = "Pickpocket any elf",
    cursor = "thieve",
    areas = { { origin = { x = 2141, y = 3333, level = 1 }, size = { x = 7, y = 13 } } }
  },
  {
    type = "skilling",
    text = {
      "Magical energy floats unleashed. The fluid of life that flows through us all. Span the gap to capture this energy."
    },
    tier = "master",
    id = 383,
    areas = { { origin = { x = 4348, y = 6059, level = 0 }, size = { x = 11, y = 12 } } },
    answer = "Siphon some blood runes in the Runespan.",
    cursor = "runecraft"
  },
  {
    type = "skilling",
    text = {
      "The spell struck me in the chest. Perhaps if I had worn armour today. Black looks better than red."
    },
    tier = "master",
    id = 384,
    answer = "Craft a black dragonhide body.",
    cursor = "craft",
    ingredients = {
      {
        name = "Black dragon leather",
        configs = { { domain = "obj", name = "DRAGON_LEATHER_BLACK" } },
        amount = 3
      },
      { name = "Thread", configs = { { domain = "obj", name = "THREAD" } } }
    },
    areas = { { origin = { x = 2274, y = 3311, level = 1 }, size = { x = 5, y = 3 } } }
  },
  {
    type = "skilling",
    text = {
      "Ernie once mentioned to me a secret to improve my cooking. His idea was strong but I went the extra mile."
    },
    tier = "master",
    id = 385,
    answer = "Add a fire rune to a decorated cooking urn (nr).",
    cursor = "craft",
    ingredients = {
      {
        name = "Decorated cooking urn (no rune)",
        configs = { { domain = "obj", name = "URNS_COOKING5_NORUNE" } }
      },
      { name = "Fire rune", configs = { { domain = "obj", name = "FIRERUNE" } } }
    },
    areas = { { origin = { x = 2274, y = 3311, level = 1 }, size = { x = 5, y = 3 } } }
  },
  {
    type = "skilling",
    text = {
      "I have all the ingredients for soup but sometimes a simple meal tastes the best."
    },
    tier = "master",
    id = 386,
    answer = "Cook a raw shark, raw rocktail or raw sailfish.",
    cursor = "cook",
    ingredients = {
      {
        name = "Raw shark, raw rocktail or raw sailfish",
        configs = {
          { domain = "obj", name = "RAW_SHARK" },
          { domain = "obj", name = "LRC_ROCKTAIL_RAW" },
          { domain = "obj", name = "DSF_RAW_SAILFISH" }
        }
      }
    },
    target = "Fire",
    relevant_configs = {
      { domain = "loc", name = "RAID1_PERM_BONFIRE_BURN" },
      { domain = "loc", name = "RAID1_PERM_BONFIRE_COOK" },
      { domain = "loc", name = "RAID1_PERM_BONFIRE" }
    },
    areas = { { origin = { x = 4310, y = 823, level = 0 }, size = { x = 3, y = 3 } } }
  },
  {
    type = "skilling",
    text = { "Take the journey to a distant mining site. Become a blight to your foes." },
    tier = "master",
    id = 387,
    answer = "Smelt a Bane bar at a furnace.",
    cursor = "smith",
    ingredients = {
      {
        name = "Banite ore",
        configs = { { domain = "obj", name = "MAH5_BANE_ORE" } },
        amount = 2
      }
    },
    target = "Furnace",
    relevant_configs = { { domain = "loc", name = "SMITHING_HUMAN_FURNACE" } },
    areas = { { origin = { x = 3225, y = 3255, level = 0 }, size = { x = 5, y = 3 } } }
  },
  {
    type = "skilling",
    text = {
      "Where there is Light there is also Death. Should you contain this you may progress."
    },
    tier = "master",
    id = 388,
    areas = { { origin = { x = 2203, y = 4834, level = 0 }, size = { x = 5, y = 5 } } },
    answer = "Craft a death rune.",
    cursor = "runecraft",
    ingredients = {
      {
        name = "Pure essence",
        configs = { { domain = "obj", name = "BLANKRUNE_HIGH" } }
      }
    },
    target = "Death altar",
    relevant_configs = { { domain = "loc", name = "DEATH_ALTAR" } }
  },
  {
    type = "skilling",
    text = { "There is a temple where there are rivers of red. Bind the magic to get ahead." },
    tier = "master",
    id = 389,
    areas = { { origin = { x = 2460, y = 4893, level = 1 }, size = { x = 6, y = 6 } } },
    answer = "Craft a blood rune.",
    cursor = "runecraft",
    ingredients = {
      {
        name = "Pure or exalted essence",
        configs = {
          { domain = "obj", name = "BLANKRUNE_HIGH" },
          { domain = "obj", name = "EXALTED_ESSENCE" }
        }
      }
    },
    target = "Blood altar",
    relevant_configs = { { domain = "loc", name = "BLOOD_ALTAR" } }
  },
  {
    type = "skilling",
    text = {
      "Corruption seeps from this stone but there are those who work to cleanse it. Lend your voice."
    },
    tier = "master",
    id = 390,
    areas = { { origin = { x = 2188, y = 3446, level = 1 }, size = { x = 5, y = 5 } } },
    answer = "Completely use up a cleansing crystal on the Corrupted Seren Stone.",
    cursor = "pray",
    ingredients = {
      {
        name = "Cleansing crystal",
        configs = { { domain = "obj", name = "ELFCITY_HEFIN_CLEANSING_CRYSTAL" } }
      }
    },
    target = "Corrupted Seren Stone",
    relevant_configs = { { domain = "loc", name = "ELFCITY_HEFIN_SEREN_STONE" } }
  },
  {
    type = "skilling",
    text = { "Charm me and I shall unlock. But be brave in the darkness." },
    tier = "master",
    id = 391,
    areas = { { origin = { x = 3365, y = 3730, level = 0 }, size = { x = 21, y = 21 } } },
    answer = "Catch a charming moth in the Wilderness.",
    cursor = "hunt",
    target = "Charming moth",
    relevant_configs = { { domain = "npc", name = "WILDERNESS_BUTTERFLY" } }
  },
  {
    type = "skilling",
    text = {
      "I once met an ancient warrior who told me tales of his adventures. His eyes lit up as he spoke."
    },
    tier = "master",
    id = 392,
    answer = "Burn some elder logs.",
    cursor = "herblore",
    ingredients = { { name = "Elder logs", configs = { { domain = "obj", name = "ELDER_LOGS" } } } },
    target = "Fire",
    relevant_configs = {},
    areas = {
      {
        origin = { x = 4310, y = 823, level = 0 },
        size = { x = 3, y = 2 },
        data = "Og=="
      }
    }
  },
  {
    type = "skilling",
    text = { "Keeping all your gold together. That's a good idea. It shall be mine." },
    tier = "master",
    id = 393,
    answer = "Mine a concentrated gold deposit in the Living Rock Caverns.",
    cursor = "mine",
    target = "Concentrated gold deposit",
    relevant_configs = { { domain = "loc", name = "MINING_CONCENTRATED_GOLD" } },
    areas = { { origin = { x = 3646, y = 5141, level = 0 }, size = { x = 3, y = 5 } } }
  },
  {
    type = "skilling",
    text = { "Rumours of a great shark continue to spread. Catch me one and I will be fed." },
    tier = "master",
    id = 394,
    answer = "Catch a raw great white shark.",
    cursor = "fish",
    areas = {
      {
        origin = { x = 2845, y = 3424, level = 0 },
        size = { x = 19, y = 7 },
        data = "wA8A/wD8z+H/j/9//v///x8="
      }
    }
  },
  {
    type = "skilling",
    text = {
      "The God of Order requires a sacrifice of strength but in return restores me. If only we could keep that feeling in his absence."
    },
    tier = "master",
    id = 395,
    answer = "Create a Saradomin brew.",
    cursor = "herblore",
    ingredients = {
      {
        name = "Toadflax potion (unfinished)",
        configs = { { domain = "obj", name = "TOADFLAXVIAL" } }
      },
      {
        name = "Crushed nest",
        configs = { { domain = "obj", name = "CRUSHED_BIRD_NEST" } }
      }
    },
    areas = { { origin = { x = 2274, y = 3311, level = 1 }, size = { x = 5, y = 3 } } }
  },
  {
    type = "skilling",
    text = {
      "Head protection is never a bad thing. Make it from rune for the best chance of survival."
    },
    tier = "master",
    id = 396,
    answer = "Smith a rune med helm or rune full helm.",
    cursor = "smith",
    ingredients = {
      {
        name = "Rune bar",
        configs = { { domain = "obj", name = "RUNITE_BAR" } },
        amount = 2
      }
    },
    target = "Anvil",
    relevant_configs = { { domain = "loc", name = "SMITHING_HUMAN_ANVIL" } },
    areas = { { origin = { x = 3228, y = 3253, level = 0 }, size = { x = 2, y = 3 } } }
  },
  {
    type = "skilling",
    text = {
      "Being open to Chaos can raise your defences. It may also bring you closer to death. Take a moment to bottle this feeling."
    },
    tier = "master",
    id = 397,
    answer = "Create a Zamorak brew.",
    cursor = "herblore",
    ingredients = {
      {
        name = "Torstol potion (unfinished)",
        configs = { { domain = "obj", name = "TORSTOLVIAL" } }
      },
      {
        name = "Jangerberries",
        configs = { { domain = "obj", name = "JANGERBERRIES" } }
      }
    },
    areas = { { origin = { x = 2274, y = 3311, level = 1 }, size = { x = 5, y = 3 } } }
  },
  {
    type = "skilling",
    text = { "Catching only one shark. That don't impress me much." },
    tier = "master",
    id = 398,
    answer = "Catch two sharks at once.",
    cursor = "fish",
    areas = {
      {
        origin = { x = 2845, y = 3424, level = 0 },
        size = { x = 19, y = 7 },
        data = "wA8A/wD8z+H/j/9//v///x8="
      }
    }
  },
  {
    id = 402,
    type = "coordinates",
    tier = "medium",
    text = { "00 degrees 05 minutes south,01 degrees 13 minutes east" },
    coordinates = {
      latitude = { degrees = 0, minutes = 5, direction = "south" },
      longitude = { degrees = 1, minutes = 13, direction = "east" }
    }
  },
  {
    id = 403,
    type = "coordinates",
    tier = "medium",
    text = { "00 degrees 13 minutes south,14 degrees 00 minutes east" },
    coordinates = {
      latitude = { degrees = 0, minutes = 13, direction = "south" },
      longitude = { degrees = 14, minutes = 0, direction = "east" }
    }
  },
  {
    id = 404,
    type = "coordinates",
    tier = "medium",
    text = { "00 degrees 18 minutes south,09 degrees 28 minutes east" },
    coordinates = {
      latitude = { degrees = 0, minutes = 18, direction = "south" },
      longitude = { degrees = 9, minutes = 28, direction = "east" }
    }
  },
  {
    id = 405,
    type = "coordinates",
    tier = "medium",
    text = { "00 degrees 20 minutes south,23 degrees 15 minutes east" },
    coordinates = {
      latitude = { degrees = 0, minutes = 20, direction = "south" },
      longitude = { degrees = 23, minutes = 15, direction = "east" }
    }
  },
  {
    id = 406,
    type = "coordinates",
    tier = "medium",
    text = { "00 degrees 31 minutes south,17 degrees 43 minutes east" },
    coordinates = {
      latitude = { degrees = 0, minutes = 31, direction = "south" },
      longitude = { degrees = 17, minutes = 43, direction = "east" }
    }
  },
  {
    id = 407,
    type = "coordinates",
    tier = "medium",
    text = { "00 degrees 50 minutes north,24 degrees 16 minutes east" },
    coordinates = {
      latitude = { degrees = 0, minutes = 50, direction = "north" },
      longitude = { degrees = 24, minutes = 16, direction = "east" }
    }
  },
  {
    id = 408,
    type = "coordinates",
    tier = "medium",
    text = { "01 degrees 18 minutes south,14 degrees 15 minutes east" },
    coordinates = {
      latitude = { degrees = 1, minutes = 18, direction = "south" },
      longitude = { degrees = 14, minutes = 15, direction = "east" }
    }
  },
  {
    id = 410,
    type = "coordinates",
    tier = "medium",
    text = { "01 degrees 26 minutes north,08 degrees 01 minutes east" },
    coordinates = {
      latitude = { degrees = 1, minutes = 26, direction = "north" },
      longitude = { degrees = 8, minutes = 1, direction = "east" }
    }
  },
  {
    id = 411,
    type = "coordinates",
    tier = "medium",
    text = { "01 degrees 35 minutes south,07 degrees 28 minutes east" },
    coordinates = {
      latitude = { degrees = 1, minutes = 35, direction = "south" },
      longitude = { degrees = 7, minutes = 28, direction = "east" }
    }
  },
  {
    id = 413,
    type = "coordinates",
    tier = "medium",
    text = { "02 degrees 50 minutes north,06 degrees 20 minutes east" },
    coordinates = {
      latitude = { degrees = 2, minutes = 50, direction = "north" },
      longitude = { degrees = 6, minutes = 20, direction = "east" }
    }
  },
  {
    id = 414,
    type = "coordinates",
    tier = "medium",
    text = { "02 degrees 50 minutes north,21 degrees 46 minutes east" },
    coordinates = {
      latitude = { degrees = 2, minutes = 50, direction = "north" },
      longitude = { degrees = 21, minutes = 46, direction = "east" }
    }
  },
  {
    id = 416,
    type = "coordinates",
    tier = "medium",
    text = { "03 degrees 35 minutes south,13 degrees 35 minutes east" },
    coordinates = {
      latitude = { degrees = 3, minutes = 35, direction = "south" },
      longitude = { degrees = 13, minutes = 35, direction = "east" }
    }
  },
  {
    id = 419,
    type = "coordinates",
    tier = "medium",
    text = { "04 degrees 00 minutes south,12 degrees 46 minutes east" },
    coordinates = {
      latitude = { degrees = 4, minutes = 0, direction = "south" },
      longitude = { degrees = 12, minutes = 46, direction = "east" }
    }
  },
  {
    id = 422,
    type = "coordinates",
    tier = "medium",
    text = { "04 degrees 13 minutes north,12 degrees 45 minutes east" },
    coordinates = {
      latitude = { degrees = 4, minutes = 13, direction = "north" },
      longitude = { degrees = 12, minutes = 45, direction = "east" }
    }
  },
  {
    id = 425,
    type = "coordinates",
    tier = "medium",
    text = { "05 degrees 20 minutes south,04 degrees 28 minutes east" },
    coordinates = {
      latitude = { degrees = 5, minutes = 20, direction = "south" },
      longitude = { degrees = 4, minutes = 28, direction = "east" }
    }
  },
  {
    id = 427,
    type = "coordinates",
    tier = "medium",
    text = { "05 degrees 43 minutes north,23 degrees 05 minutes east" },
    coordinates = {
      latitude = { degrees = 5, minutes = 43, direction = "north" },
      longitude = { degrees = 23, minutes = 5, direction = "east" }
    }
  },
  {
    id = 431,
    type = "coordinates",
    tier = "medium",
    text = { "06 degrees 31 minutes north,01 degrees 46 minutes west" },
    coordinates = {
      latitude = { degrees = 6, minutes = 31, direction = "north" },
      longitude = { degrees = 1, minutes = 46, direction = "west" }
    }
  },
  {
    id = 432,
    type = "coordinates",
    tier = "medium",
    text = { "07 degrees 05 minutes north,30 degrees 56 minutes east" },
    coordinates = {
      latitude = { degrees = 7, minutes = 5, direction = "north" },
      longitude = { degrees = 30, minutes = 56, direction = "east" }
    }
  },
  {
    id = 434,
    type = "coordinates",
    tier = "medium",
    text = { "07 degrees 33 minutes north,15 degrees 00 minutes east" },
    coordinates = {
      latitude = { degrees = 7, minutes = 33, direction = "north" },
      longitude = { degrees = 15, minutes = 0, direction = "east" }
    }
  },
  {
    id = 440,
    type = "coordinates",
    tier = "medium",
    text = { "08 degrees 33 minutes north,01 degrees 39 minutes west" },
    coordinates = {
      latitude = { degrees = 8, minutes = 33, direction = "north" },
      longitude = { degrees = 1, minutes = 39, direction = "west" }
    }
  },
  {
    id = 442,
    type = "coordinates",
    tier = "medium",
    text = { "09 degrees 33 minutes north,02 degrees 15 minutes east" },
    coordinates = {
      latitude = { degrees = 9, minutes = 33, direction = "north" },
      longitude = { degrees = 2, minutes = 15, direction = "east" }
    }
  },
  {
    id = 443,
    type = "coordinates",
    tier = "medium",
    text = { "09 degrees 48 minutes north,17 degrees 39 minutes east" },
    coordinates = {
      latitude = { degrees = 9, minutes = 48, direction = "north" },
      longitude = { degrees = 17, minutes = 39, direction = "east" }
    }
  },
  {
    id = 444,
    type = "coordinates",
    tier = "medium",
    text = { "11 degrees 03 minutes north,31 degrees 20 minutes east" },
    coordinates = {
      latitude = { degrees = 11, minutes = 3, direction = "north" },
      longitude = { degrees = 31, minutes = 20, direction = "east" }
    }
  },
  {
    id = 445,
    type = "coordinates",
    tier = "medium",
    text = { "11 degrees 05 minutes north,00 degrees 45 minutes west" },
    coordinates = {
      latitude = { degrees = 11, minutes = 5, direction = "north" },
      longitude = { degrees = 0, minutes = 45, direction = "west" }
    }
  },
  {
    id = 446,
    type = "coordinates",
    tier = "medium",
    text = { "11 degrees 41 minutes north,14 degrees 58 minutes east" },
    coordinates = {
      latitude = { degrees = 11, minutes = 41, direction = "north" },
      longitude = { degrees = 14, minutes = 58, direction = "east" }
    }
  },
  {
    id = 449,
    type = "coordinates",
    tier = "medium",
    text = { "14 degrees 54 minutes north,09 degrees 13 minutes east" },
    coordinates = {
      latitude = { degrees = 14, minutes = 54, direction = "north" },
      longitude = { degrees = 9, minutes = 13, direction = "east" }
    }
  },
  {
    id = 462,
    type = "coordinates",
    tier = "medium",
    text = { "22 degrees 30 minutes north,03 degrees 01 minutes east" },
    coordinates = {
      latitude = { degrees = 22, minutes = 30, direction = "north" },
      longitude = { degrees = 3, minutes = 1, direction = "east" }
    }
  },
  {
    id = 401,
    type = "coordinates",
    tier = "hard",
    text = { "00 degrees 00 minutes north,07 degrees 13 minutes west" },
    challenge = { { type = "wizard" } },
    coordinates = {
      latitude = { degrees = 0, minutes = 0, direction = "north" },
      longitude = { degrees = 7, minutes = 13, direction = "west" }
    }
  },
  {
    id = 409,
    type = "coordinates",
    tier = "hard",
    text = { "01 degrees 24 minutes north,08 degrees 05 minutes west" },
    challenge = { { type = "wizard" } },
    coordinates = {
      latitude = { degrees = 1, minutes = 24, direction = "north" },
      longitude = { degrees = 8, minutes = 5, direction = "west" }
    }
  },
  {
    id = 412,
    type = "coordinates",
    tier = "hard",
    text = { "02 degrees 33 minutes north,28 degrees 45 minutes east" },
    challenge = { { type = "wizard" } },
    coordinates = {
      latitude = { degrees = 2, minutes = 33, direction = "north" },
      longitude = { degrees = 28, minutes = 45, direction = "east" }
    }
  },
  {
    id = 415,
    type = "coordinates",
    tier = "hard",
    text = { "03 degrees 03 minutes south,05 degrees 03 minutes east" },
    challenge = { { type = "wizard" } },
    coordinates = {
      latitude = { degrees = 3, minutes = 3, direction = "south" },
      longitude = { degrees = 5, minutes = 3, direction = "east" }
    }
  },
  {
    id = 417,
    type = "coordinates",
    tier = "hard",
    text = { "03 degrees 39 minutes south,13 degrees 58 minutes east" },
    challenge = { { type = "wizard" } },
    coordinates = {
      latitude = { degrees = 3, minutes = 39, direction = "south" },
      longitude = { degrees = 13, minutes = 58, direction = "east" }
    }
  },
  {
    id = 418,
    type = "coordinates",
    tier = "hard",
    text = { "03 degrees 45 minutes south,22 degrees 45 minutes east" },
    challenge = { { type = "wizard" } },
    coordinates = {
      latitude = { degrees = 3, minutes = 45, direction = "south" },
      longitude = { degrees = 22, minutes = 45, direction = "east" }
    }
  },
  {
    id = 420,
    type = "coordinates",
    tier = "hard",
    text = { "04 degrees 03 minutes south,03 degrees 11 minutes east" },
    challenge = { { type = "wizard" } },
    coordinates = {
      latitude = { degrees = 4, minutes = 3, direction = "south" },
      longitude = { degrees = 3, minutes = 11, direction = "east" }
    }
  },
  {
    id = 421,
    type = "coordinates",
    tier = "hard",
    text = { "04 degrees 05 minutes south,04 degrees 24 minutes east" },
    challenge = { { type = "wizard" } },
    coordinates = {
      latitude = { degrees = 4, minutes = 5, direction = "south" },
      longitude = { degrees = 4, minutes = 24, direction = "east" }
    }
  },
  {
    id = 423,
    type = "coordinates",
    tier = "hard",
    text = { "04 degrees 16 minutes south,16 degrees 16 minutes east" },
    challenge = { { type = "wizard" } },
    coordinates = {
      latitude = { degrees = 4, minutes = 16, direction = "south" },
      longitude = { degrees = 16, minutes = 16, direction = "east" }
    }
  },
  {
    id = 424,
    type = "coordinates",
    tier = "hard",
    text = { "04 degrees 41 minutes north,03 degrees 09 minutes west" },
    challenge = { { type = "wizard" } },
    coordinates = {
      latitude = { degrees = 4, minutes = 41, direction = "north" },
      longitude = { degrees = 3, minutes = 9, direction = "west" }
    }
  },
  {
    id = 426,
    type = "coordinates",
    tier = "hard",
    text = { "05 degrees 37 minutes north,31 degrees 15 minutes east" },
    challenge = { { type = "wizard" } },
    coordinates = {
      latitude = { degrees = 5, minutes = 37, direction = "north" },
      longitude = { degrees = 31, minutes = 15, direction = "east" }
    }
  },
  {
    id = 428,
    type = "coordinates",
    tier = "hard",
    text = { "05 degrees 50 minutes south,10 degrees 05 minutes east" },
    challenge = { { type = "wizard" } },
    coordinates = {
      latitude = { degrees = 5, minutes = 50, direction = "south" },
      longitude = { degrees = 10, minutes = 5, direction = "east" }
    }
  },
  {
    id = 429,
    type = "coordinates",
    tier = "hard",
    text = { "06 degrees 00 minutes south,21 degrees 48 minutes east" },
    challenge = { { type = "wizard" } },
    coordinates = {
      latitude = { degrees = 6, minutes = 0, direction = "south" },
      longitude = { degrees = 21, minutes = 48, direction = "east" }
    }
  },
  {
    id = 430,
    type = "coordinates",
    tier = "hard",
    text = { "06 degrees 11 minutes south,15 degrees 07 minutes east" },
    challenge = { { type = "wizard" } },
    coordinates = {
      latitude = { degrees = 6, minutes = 11, direction = "south" },
      longitude = { degrees = 15, minutes = 7, direction = "east" }
    }
  },
  {
    id = 433,
    type = "coordinates",
    tier = "hard",
    text = { "07 degrees 22 minutes north,14 degrees 15 minutes east" },
    challenge = { { type = "wizard" } },
    coordinates = {
      latitude = { degrees = 7, minutes = 22, direction = "north" },
      longitude = { degrees = 14, minutes = 15, direction = "east" }
    }
  },
  {
    id = 435,
    type = "coordinates",
    tier = "hard",
    text = { "07 degrees 41 minutes north,06 degrees 00 minutes east" },
    challenge = { { type = "wizard" } },
    coordinates = {
      latitude = { degrees = 7, minutes = 41, direction = "north" },
      longitude = { degrees = 6, minutes = 0, direction = "east" }
    }
  },
  {
    id = 436,
    type = "coordinates",
    tier = "hard",
    text = { "07 degrees 43 minutes south,12 degrees 26 minutes east" },
    challenge = { { type = "wizard" } },
    coordinates = {
      latitude = { degrees = 7, minutes = 43, direction = "south" },
      longitude = { degrees = 12, minutes = 26, direction = "east" }
    }
  },
  {
    id = 437,
    type = "coordinates",
    tier = "hard",
    text = { "08 degrees 03 minutes north,31 degrees 16 minutes east" },
    challenge = { { type = "wizard" } },
    coordinates = {
      latitude = { degrees = 8, minutes = 3, direction = "north" },
      longitude = { degrees = 31, minutes = 16, direction = "east" }
    }
  },
  {
    id = 438,
    type = "coordinates",
    tier = "hard",
    text = { "08 degrees 05 minutes south,15 degrees 56 minutes east" },
    challenge = { { type = "wizard" } },
    coordinates = {
      latitude = { degrees = 8, minutes = 5, direction = "south" },
      longitude = { degrees = 15, minutes = 56, direction = "east" }
    }
  },
  {
    id = 439,
    type = "coordinates",
    tier = "hard",
    text = { "08 degrees 26 minutes south,10 degrees 28 minutes east" },
    challenge = { { type = "wizard" } },
    coordinates = {
      latitude = { degrees = 8, minutes = 26, direction = "south" },
      longitude = { degrees = 10, minutes = 28, direction = "east" }
    }
  },
  {
    id = 441,
    type = "coordinates",
    tier = "hard",
    text = { "09 degrees 22 minutes north,02 degrees 24 minutes west" },
    challenge = { { type = "wizard" } },
    coordinates = {
      latitude = { degrees = 9, minutes = 22, direction = "north" },
      longitude = { degrees = 2, minutes = 24, direction = "west" }
    }
  },
  {
    id = 447,
    type = "coordinates",
    tier = "hard",
    text = { "12 degrees 48 minutes north,20 degrees 20 minutes east" },
    challenge = { { type = "wizard" } },
    coordinates = {
      latitude = { degrees = 12, minutes = 48, direction = "north" },
      longitude = { degrees = 20, minutes = 20, direction = "east" }
    }
  },
  {
    id = 448,
    type = "coordinates",
    tier = "hard",
    text = { "13 degrees 46 minutes north,21 degrees 01 minutes east" },
    challenge = { { type = "wizard" } },
    coordinates = {
      latitude = { degrees = 13, minutes = 46, direction = "north" },
      longitude = { degrees = 21, minutes = 1, direction = "east" }
    }
  },
  {
    id = 450,
    type = "coordinates",
    tier = "hard",
    text = { "15 degrees 48 minutes north,13 degrees 52 minutes east" },
    challenge = { { type = "wizard" } },
    coordinates = {
      latitude = { degrees = 15, minutes = 48, direction = "north" },
      longitude = { degrees = 13, minutes = 52, direction = "east" }
    }
  },
  {
    id = 451,
    type = "coordinates",
    tier = "hard",
    text = { "16 degrees 20 minutes north,12 degrees 45 minutes east" },
    challenge = { { type = "wizard" } },
    coordinates = {
      latitude = { degrees = 16, minutes = 20, direction = "north" },
      longitude = { degrees = 12, minutes = 45, direction = "east" }
    }
  },
  {
    id = 452,
    type = "coordinates",
    tier = "hard",
    text = { "16 degrees 30 minutes north,16 degrees 28 minutes east" },
    challenge = { { type = "wizard" } },
    coordinates = {
      latitude = { degrees = 16, minutes = 30, direction = "north" },
      longitude = { degrees = 16, minutes = 28, direction = "east" }
    }
  },
  {
    id = 453,
    type = "coordinates",
    tier = "hard",
    text = { "16 degrees 35 minutes north,27 degrees 01 minutes east" },
    challenge = { { type = "wizard" } },
    coordinates = {
      latitude = { degrees = 16, minutes = 35, direction = "north" },
      longitude = { degrees = 27, minutes = 1, direction = "east" }
    }
  },
  {
    id = 454,
    type = "coordinates",
    tier = "hard",
    text = { "17 degrees 50 minutes north,08 degrees 30 minutes east" },
    challenge = { { type = "wizard" } },
    coordinates = {
      latitude = { degrees = 17, minutes = 50, direction = "north" },
      longitude = { degrees = 8, minutes = 30, direction = "east" }
    }
  },
  {
    id = 455,
    type = "coordinates",
    tier = "hard",
    text = { "18 degrees 03 minutes north,25 degrees 16 minutes east" },
    challenge = { { type = "wizard" } },
    coordinates = {
      latitude = { degrees = 18, minutes = 3, direction = "north" },
      longitude = { degrees = 25, minutes = 16, direction = "east" }
    }
  },
  {
    id = 456,
    type = "coordinates",
    tier = "hard",
    text = { "18 degrees 22 minutes north,16 degrees 33 minutes east" },
    challenge = { { type = "wizard" } },
    coordinates = {
      latitude = { degrees = 18, minutes = 22, direction = "north" },
      longitude = { degrees = 16, minutes = 33, direction = "east" }
    }
  },
  {
    id = 457,
    type = "coordinates",
    tier = "hard",
    text = { "19 degrees 43 minutes north,25 degrees 07 minutes east" },
    challenge = { { type = "wizard" } },
    coordinates = {
      latitude = { degrees = 19, minutes = 43, direction = "north" },
      longitude = { degrees = 25, minutes = 7, direction = "east" }
    }
  },
  {
    id = 458,
    type = "coordinates",
    tier = "hard",
    text = { "20 degrees 05 minutes north,21 degrees 52 minutes east" },
    challenge = { { type = "wizard" } },
    coordinates = {
      latitude = { degrees = 20, minutes = 5, direction = "north" },
      longitude = { degrees = 21, minutes = 52, direction = "east" }
    }
  },
  {
    id = 459,
    type = "coordinates",
    tier = "hard",
    text = { "20 degrees 07 minutes north,18 degrees 33 minutes east" },
    challenge = { { type = "wizard" } },
    coordinates = {
      latitude = { degrees = 20, minutes = 7, direction = "north" },
      longitude = { degrees = 18, minutes = 33, direction = "east" }
    }
  },
  {
    id = 460,
    type = "coordinates",
    tier = "hard",
    text = { "20 degrees 33 minutes north,15 degrees 48 minutes east" },
    challenge = { { type = "wizard" } },
    coordinates = {
      latitude = { degrees = 20, minutes = 33, direction = "north" },
      longitude = { degrees = 15, minutes = 48, direction = "east" }
    }
  },
  {
    id = 461,
    type = "coordinates",
    tier = "hard",
    text = { "21 degrees 24 minutes north,17 degrees 54 minutes east" },
    challenge = { { type = "wizard" } },
    coordinates = {
      latitude = { degrees = 21, minutes = 24, direction = "north" },
      longitude = { degrees = 17, minutes = 54, direction = "east" }
    }
  },
  {
    id = 463,
    type = "coordinates",
    tier = "hard",
    text = { "22 degrees 35 minutes north,19 degrees 18 minutes east" },
    challenge = { { type = "wizard" } },
    coordinates = {
      latitude = { degrees = 22, minutes = 35, direction = "north" },
      longitude = { degrees = 19, minutes = 18, direction = "east" }
    }
  },
  {
    id = 464,
    type = "coordinates",
    tier = "hard",
    text = { "22 degrees 45 minutes north,26 degrees 33 minutes east" },
    challenge = { { type = "wizard" } },
    coordinates = {
      latitude = { degrees = 22, minutes = 45, direction = "north" },
      longitude = { degrees = 26, minutes = 33, direction = "east" }
    }
  },
  {
    id = 465,
    type = "coordinates",
    tier = "hard",
    text = { "24 degrees 26 minutes north,26 degrees 24 minutes east" },
    challenge = { { type = "wizard" } },
    coordinates = {
      latitude = { degrees = 24, minutes = 26, direction = "north" },
      longitude = { degrees = 26, minutes = 24, direction = "east" }
    }
  },
  {
    id = 466,
    type = "coordinates",
    tier = "hard",
    text = { "24 degrees 56 minutes north,22 degrees 28 minutes east" },
    challenge = { { type = "wizard" } },
    coordinates = {
      latitude = { degrees = 24, minutes = 56, direction = "north" },
      longitude = { degrees = 22, minutes = 28, direction = "east" }
    }
  },
  {
    id = 467,
    type = "coordinates",
    tier = "hard",
    text = { "24 degrees 58 minutes north,18 degrees 43 minutes east" },
    challenge = { { type = "wizard" } },
    coordinates = {
      latitude = { degrees = 24, minutes = 58, direction = "north" },
      longitude = { degrees = 18, minutes = 43, direction = "east" }
    }
  },
  {
    id = 468,
    type = "coordinates",
    tier = "hard",
    text = { "25 degrees 03 minutes north,17 degrees 05 minutes east" },
    challenge = { { type = "wizard" } },
    coordinates = {
      latitude = { degrees = 25, minutes = 3, direction = "north" },
      longitude = { degrees = 17, minutes = 5, direction = "east" }
    }
  },
  {
    id = 469,
    type = "coordinates",
    tier = "hard",
    text = { "25 degrees 03 minutes north,23 degrees 24 minutes east" },
    challenge = { { type = "wizard" } },
    coordinates = {
      latitude = { degrees = 25, minutes = 3, direction = "north" },
      longitude = { degrees = 23, minutes = 24, direction = "east" }
    }
  }
}
return clues
