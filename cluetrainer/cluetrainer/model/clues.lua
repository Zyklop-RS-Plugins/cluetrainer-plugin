---@class ct.ConfigId.Loc
---@field domain "loc"
---@field name string

---@class ct.ConfigId.Npc
---@field domain "npc"
---@field name string

---@class ct.ConfigId.Obj
---@field domain "obj"
---@field name string

---@alias ct.ConfigId ct.ConfigId.Loc|ct.ConfigId.Npc|ct.ConfigId.Obj

---@alias Challenge
---     | { type: "wizard" }
---     | { type: "slider" }
---     | { type: "celticknot" }
---     | { type: "lockbox" }
---     | { type: "towers" }
---     | { type: "challengescroll", question: string, answers: {answer: number, note: string?}[]}

---@alias ClueTier
---| "easy"
---| "medium"
---| "hard"
---| "elite"
---| "master"
---| "tetracompass"
---| "sandy"

local clues = {}

---@type { values: ClueTier[] }
clues.ClueTier = {
    values = {
        "easy",
        "medium",
        "hard",
        "elite",
        "master",
        "tetracompass",
        "sandy",
    },
}

---@alias ClueType
---| "anagram"
---| "compass"
---| "coordinates"
---| "cryptic"
---| "emote"
---| "map"
---| "scan"
---| "simple"
---| "skilling"

-- Solution

---@alias Solution
---| Solution.TalkTo
---| Solution.Dig
---| Solution.Search


---@class Solution.TalkToSpot
---@field id? string
---@field range TileArea Covers exactly the NPC's roaming range.
---@field note? string Conditions for the NPC to be at this spot.
---@field description string For example, "in City of Um" or "at the Bank".


---@class Solution.TalkTo
---@field type "talkto"
---@field npc string
---@field npc_configs ct.ConfigId.Npc[]?
---@field spots Solution.TalkToSpot[]

---@class Solution.Dig
---@field type "dig"
---@field spot TileCoordinates
---@field description string|nil For example, "on top of the fern".


---@class Solution.SearchKey
---@field instructions string
---@field answer string
---@field area? TileArea


---@class Solution.Search
---@field type "search"
---@field spot TileRectangle
---@field entity string
---@field entity_configs? ct.ConfigId.Loc[]?
---@field key? Solution.SearchKey

---@class StepShared
---@field id number
---@field type ClueType
---@field tier ClueTier
---@field text string[]
---@field challenge? Challenge[]
---@field solution? Solution

---@class Anagram : StepShared
---@field type "anagram"
---@field solution Solution.TalkTo
---@field anagram string[]


---@class Compass : StepShared
---@field type "compass"
---@field spots TileCoordinates[]
---@field valid_area TileRectangle
---@field single_tile_target? boolean


---@class Coordinate : StepShared
---@field type "coordinates"
---@field coordinates GieliCoordinates


---@class Cryptic : StepShared
---@field type "cryptic"
---@field solution Solution


---@class Emote.HideyHole
---@field config string Name of the hidey-hole's master loc, e.g. TRAIL17_STASH_09_LEGENDS_GUILD
---@field location TileRectangle
---@field name string


---@class Emote : StepShared
---@field type "emote"
---@field area TileArea
---@field items {slot : zyklib.game.EquipmentSlotId, options: (ObjType?)[]}[]
---@field emotes string[]
---@field double_agent boolean
---@field hidey_hole Emote.HideyHole|nil

---@class Map : StepShared
---@field type "map"
---@field solution Solution

---@class Scan : StepShared
---@field type "scan"
---@field scantext string
---@field range number
---@field spots TileCoordinates[]


---@class Simple : StepShared
---@field type "simple"
---@field solution Solution


---@class Skilling : StepShared
---@field type "skilling"
---@field areas TileArea[]
---@field answer string
---@field cursor MyCursorType
---@field relevant_configs (ct.ConfigId.Npc | ct.ConfigId.Loc)[]?
---@field ingredients? Skilling.Ingredient[] Items the task uses up; tools are left out.

---@class Skilling.Ingredient
---@field name string
---@field configs ct.ConfigId.Obj[]
---@field amount? integer Default 1.


---@alias Step
---| Anagram
---| Compass
---| Coordinate
---| Cryptic
---| Emote
---| Map
---| Scan
---| Simple
---| Skilling


---@generic T: Step
---@class ClueSpot
---@field clue T
---@field spot? TileCoordinates

---@class ClueSpot.Id
---@field clue number
---@field spot? TileCoordinates

local ctmath = require("cluetrainer/math/math")


---@param step Step
---@return Solution?
function clues.getSolution(step)
    if step.solution ~= nil then return step.solution end

    if step.type == "coordinates" then
        return {
            type = "dig",
            spot = ctmath.gielicoordinates.toTileCoordinates(step.coordinates)
        }
    end

    return nil
end

return clues
