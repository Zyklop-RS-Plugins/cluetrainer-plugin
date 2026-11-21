---@class ct.PatchNotes.ListItem
---@field text string
---@field children ct.PatchNotes.ListItem[]?

---@class ct.PatchNotes.Paragraph
---@field type "paragraph"
---@field text string

---@class ct.PatchNotes.Header
---@field type "header"
---@field text string

---@class ct.PatchNotes.List
---@field type "list"
---@field items ct.PatchNotes.ListItem[]

---@class ct.PatchNotes.Patch
---@field version string
---@field date string Release date in YYYY-MM-DD format.
---@field name string
---@field content (ct.PatchNotes.Paragraph|ct.PatchNotes.Header|ct.PatchNotes.List)[]

---@param text string
---@return ct.PatchNotes.Header
local function header(text)
  return { type = "header", text = text }
end

---@param text string
---@return ct.PatchNotes.Paragraph
local function paragraph(text)
  return { type = "paragraph", text = text }
end

---@param items ct.PatchNotes.ListItem[]
---@return ct.PatchNotes.List
local function list(items)
  return { type = "list", items = items }
end

---@param text string
---@param children ct.PatchNotes.ListItem[]?
---@return ct.PatchNotes.ListItem
local function item(text, children)
  return { text = text, children = children }
end

-- List releases from oldest to newest.
-- Version strings are compared exactly; on a version change, entries after the
-- last opened release are shown. If it is absent or later, all entries through
-- the current release are shown.
-- Use header "Section", paragraph "Text", and list { item "Change" } in content.
---@type ct.PatchNotes.Patch[]
local patches = { {
  version = "83",
  date = "2026-11-19",
  name = "Clue Trainer (Plugin API)",
  content = {
    header "About this version",
    paragraph "This is the initial release of Clue Trainer for the official RuneScape Client plugin API. You may wonder why this version is labelled as version 83. Clue Trainer has a long history as a plugin for the Alt 1 toolkit, and this version is a direct continuation of that lineage, equipped with all the learnings from more than three years of development.",
    paragraph "You will notice that this version is still rough around the edges. The will be visual issues, glitches, suboptimal UX, and missing features. Just like with the previous 82 versions for the Alt 1 toolkit, we will continue to iterate on Clue Trainer to make it better than ever. Please feel free to report any feedback you have in the Clue Chasers discord, the Mod.io page, or directly on the plugin's issue tracker at Codeberg.",
    header "Patch Notes",
    list {
      item "Ported Clue Trainer to the official RuneScape Client plugin API.",
      item "Added in-game highlighting of dig spots, npcs, containers, and emote areas.",
      item "Added in-game rendering of paths as threedimensional shapes.",
      item "Automated detection of fairy ring favourites.",
      item "Eliminated issues with misreads of interface puzzles and compass angles.",
      item "Clue Trainer now supports any interface scaling.",
      item "Compass clues now automatically detect your position and the compass angle, no manual input required."
    },
  },
}, {
  version = "84",
  date = "2026-11-20",
  name = "Bugfixes",
  content = {
    list {
      item "Fixed a bug that caused clue detection to stop working after a search clue.",
      item "Added improved error resiliency for several types of internal failures.",
      item "Optimized map performance in several ways to reduce issues with the plugin not enabling properly.",
      item "Worked around an API bug that caused colour settings to not be properly persisted and fall back to black.",
      item "Fixed detection of a master anagram clue.",
      item "Fixed an incorrectly placed scan decision point for the Lumbridge caves scan.",
      item "Fixed that Clue Trainer interfaces could hide behind native UI components.",
      item "Fixed starting position of the clue info panel so that it no longer hides in the top-left corner.",
    },
  },
}, {
  version = "85",
  date = "2026-11-20",
  name = "PrettyUI Update",
  content = {
    list {
      item "Updated to PrettyUI 1.3.2. This allows moving the interface even in classic mode. Hold Alt to drag the interfaces.",
    },
    header "Why does Clue Trainer not depend on PrettyUI?",
    paragraph "Clue Trainer uses PrettyUI, but ships its own copy to work around intolerable performance issues that arose when dynamically depending on PrettyUI. In a future update, these issues may be resolved, allowing for the standard dependency approach."
  },
}, {
  version = "86",
  date = "TBD",
  name = "TBD",
  content = {
    list {
      item "Updated to PrettyUI 1.3.3. This fixes the crashes that could occur when trying to move an interface.",
    },
  },
}
}

---@class ct.patch_notes.patch_notes
local patch_notes = {
  -- Keep this in sync with the plugin manifest versions.
  messages = {
    first_start =
    "Thanks for installing and Welcome to Clue Trainer! Clue Trainer is continuously iterated on, and this window will show whenever the plugin has received an update to keep you informed about the latest changes and improvements.",
    update =
    "Clue Trainer has been updated. Join the Clue Chasers discord to leave praise and criticism, report issues, request features, get support or just come by and say hi in the #clue-trainer channel. If you enjoy Clue Trainer, consider supporting continuous development at Ko-fi.com/zyklopmarco.",
    manual =
    "Join the Clue Chasers discord to leave praise and criticism, report issues, request features, get support or just come by and say hi in the #clue-trainer channel. If you enjoy Clue Trainer, consider supporting continuous development at Ko-fi.com/zyklopmarco.",
  },
  patches = patches,
  latest_patch = patches[1]
}

return patch_notes
