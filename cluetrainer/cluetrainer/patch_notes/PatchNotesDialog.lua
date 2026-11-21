local zyklib = require("zyklib")
local data = require("cluetrainer/patch_notes/patch_notes")

local PatchNotesDialog = {}

local WINDOW_WIDTH = 588
local WINDOW_HEIGHT = 460
local PADDING = 14
local SCROLLBAR_SPACE = 18
local LIST_INDENT = 18
local LIST_MARKER_WIDTH = 14
local LIST_MARGIN_TOP = 8

---@alias ct.PatchNotes.OpenReason "first_start"|"update"|"manual"

local titles = {
  first_start = "Welcome to Clue Trainer",
  update = "Clue Trainer has been updated",
  manual = "Clue Trainer Changelog",
}

---@type PrettyUI.Window?
local window = nil

---@type zyklib.reactive.EventHandler?
local pending = nil

local last_opened = ctGlobal.persistence:globalVariable("patch_notes_last_opened_version", function(value)
  assert(value == nil or type(value) == "string", "Invalid stored patch notes version")
  return value
end)

---@param target PrettyUI.Window
---@param items ct.PatchNotes.ListItem[]
---@param depth integer
---@param content_width integer
local function addList(target, items, depth, content_width)
  local x = math.min(PADDING + (depth + 1) * LIST_INDENT, content_width - PADDING - LIST_MARKER_WIDTH - 1)
  for index, item in ipairs(items) do
    target:AddText({
      text = item.text,
      x = x + LIST_MARKER_WIDTH,
      width = content_width - x - LIST_MARKER_WIDTH - PADDING,
      alignVertical = ui.AlignMode.TOPLEFT,
      marginTop = depth == 0 and index == 1 and LIST_MARGIN_TOP or 0,
      marginBottom = 2,
    })
    target:AddText({
      text = "-",
      x = x,
      width = LIST_MARKER_WIDTH,
      height = 24,
      inline = true,
      alignVertical = ui.AlignMode.TOPLEFT,
      marginBottom = 2,
    })
    if item.children then addList(target, item.children, depth + 1, content_width) end
  end
end

---@param parent ui.Component
---@param previous_version string?
---@param reason ct.PatchNotes.OpenReason
local function open(parent, previous_version, reason)
  local current_index, previous_index
  for index, patch in ipairs(data.patches) do
    if patch.version == data.current_version then current_index = index end
    if patch.version == previous_version then previous_index = index end
  end
  assert(current_index ~= nil, "No patch notes for current version: " .. tostring(data.current_version))
  local first_index = previous_index and previous_index < current_index and previous_index + 1 or 1

  window = prettyui.Window.new(parent, {
    title = titles[reason],
    x = -WINDOW_WIDTH // 2,
    y = -WINDOW_HEIGHT // 2,
    xAnchor = 0.5,
    yAnchor = 0.5,
    width = WINDOW_WIDTH,
    height = WINDOW_HEIGHT,
    scrollable = true,
    destroyOnClose = true,
    onClose = function() window = nil end,
  })

  -- Reserve the scrollbar gutter before it appears so every text block uses the same width.
  local content_width = window.contentWidth - (window.scrollbarVisible and 0 or SCROLLBAR_SPACE)
  local text_width = content_width - 2 * PADDING

  window:AddText({
    text = data.messages[reason],
    width = text_width,
    marginBottom = 0,
  })

  local displayed = false
  for index, patch in ipairs(data.patches) do
    if index >= first_index and index <= current_index then
      window:AddDivider({ marginTop = 0, marginBottom = 0 })
      window:AddText({
        text = patch.date .. " (" .. patch.version .. ") - " .. patch.name,
        font = id.Font.CINZEL_15PT_BOLD,
        colour = 0xf0be79ff,
        alignHorizontal = ui.AlignMode.CENTRE,
        width = text_width,
        marginTop = 0,
      })
      displayed = true
      for block_index, block in ipairs(patch.content) do
        if block.type == "header" then
          window:AddText({
            text = block.text,
            font = id.Font.CINZEL_13PT_BOLD,
            colour = 0xf0be79ff,
            width = text_width,
            marginTop = block_index == 1 and 0 or 6,
          })
        elseif block.type == "paragraph" then
          window:AddText({
            text = block.text,
            width = text_width,
          })
        elseif block.type == "list" then
          addList(window, block.items, 0, content_width)
        else
          error("Invalid patch notes content type: " .. tostring(block.type))
        end
      end
    end
  end
  if not displayed then
    window:AddText("No patch notes are available for this version.")
  end

  if last_opened:get() ~= data.current_version then
    last_opened:set(data.current_version)
  end
end

--- Opens the full patch history, replacing any currently open patch notes.
function PatchNotesDialog.open()
  local parent = ui.Interfaces:GetComponent(id.Component.TOPLEVEL_V2__PLUGIN_BUILD_LAYER_TOP)
  assert(parent ~= nil and parent.visibleGlobal ~= false, "Cannot open patch notes: game interface is unavailable")

  if window ~= nil then
    window:Destroy()
    window = nil
  end
  open(parent, nil, "manual")
  if pending ~= nil then
    pending:cancel()
    pending = nil
  end
end

--- Opens the dialog when the game interface is available, if this version has not been opened.
function PatchNotesDialog.init()
  local previous_version = last_opened:get()

  if previous_version ~= data.latest_patch.version then
    pending = zyklib.game_events.native.Logic:subscribe(function()
      local parent = ui.Interfaces:GetComponent(id.Component.TOPLEVEL_V2__PLUGIN_BUILD_LAYER_TOP)
      if parent == nil or parent.visibleGlobal == false then return end

      open(parent, previous_version, previous_version == nil and "first_start" or "update")
      pending:cancel()
      pending = nil
    end)
  end

  zyklib.lifecycle.shutdown_event:subscribe(function()
    if pending ~= nil then
      pending:cancel()
      pending = nil
    end
    if window ~= nil then
      window:Destroy()
      window = nil
    end
  end)
end

return PatchNotesDialog
