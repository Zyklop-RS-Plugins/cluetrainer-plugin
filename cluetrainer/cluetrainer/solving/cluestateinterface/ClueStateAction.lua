---@alias ct.interfaces.cluestate.ActionState "incomplete" | "complete"

local STATE_ALPHA = {
  incomplete = 1.0,
  complete = 0.5,
}

local ROW_HEIGHT = 22
local TEXT_VERTICAL_PADDING = 4

---The height of a row for the text wrapped at `width`, including explicit line breaks.
---Rows can't change height after construction, so this is only evaluated for the initial text.
---@param content string
---@param width number
---@param font? FontType Defaults to the body font PrettyUI draws text in
---@return integer
local function rowHeight(content, width, font)
  font = font or config.Font.MUSEO_SANS_15PT_REGULAR

  local SPACING = font.baseline

  local wrap_width = math.max(1, width)
  local pixel_height = font:GetStringHeightAndLineCount(content, wrap_width, SPACING, false, false, false)
  local lines = 0
  local start = 1
  while true do
    local break_start, break_end = content:find("<br>", start, true)
    local part = content:sub(start, break_start and break_start - 1 or #content)
    lines = lines + math.max(1, font:GetStringLineCount(part, wrap_width, false, false, false))
    if not break_start then break end
    start = break_end + 1
  end

  local line_height = font.maxAscent + font.maxDescent + (lines - 1) * SPACING
  return math.max(ROW_HEIGHT, math.max(pixel_height, line_height) + TEXT_VERTICAL_PADDING)
end

---Interface for a single line in the clue state panel.
---State is always stored in the object and only applied to components once they have been constructed.
---Implementations add their components to the PrettyUI view (and thereby its flow rows, which receive the
---alternating backgrounds) and override `setText`, `_construct`, `_apply` and `destroy`.
---@class ct.interfaces.cluestate.ClueStateAction
---@field state ct.interfaces.cluestate.ActionState
---@field constructed boolean
local ClueStateAction = {}
ClueStateAction.__index = ClueStateAction

---@protected
function ClueStateAction:_init()
  self.state = "incomplete"
  self.constructed = false
end

---Creates the components of this action in the given view and applies the stored state to them.
---@param view PrettyUI.View
function ClueStateAction:construct(view)
  assert(not self.constructed, "ClueStateAction already constructed")
  self:_construct(view)
  self.constructed = true
  self:_apply()
end

---Destroys the components of this action.
function ClueStateAction:destroy()
  error("ClueStateAction:destroy not implemented")
end

---@param state ct.interfaces.cluestate.ActionState
function ClueStateAction:setState(state)
  self.state = state
  if self.constructed then self:_apply() end
end

---@protected
---@param view PrettyUI.View
function ClueStateAction:_construct(view)
  error("ClueStateAction:_construct not implemented")
end

---Pushes the stored state to the constructed components.
---@protected
function ClueStateAction:_apply()
  error("ClueStateAction:_apply not implemented")
end

---Action line displaying a simple text.
---@class ct.interfaces.cluestate.TextClueStateAction : ct.interfaces.cluestate.ClueStateAction
---@field content string
---@field heading string?
---@field heading_text ui.Text?
---@field text ui.Text?
local Text = setmetatable({}, { __index = ClueStateAction })
Text.__index = Text

---@param content string
---@param heading? string
---@return ct.interfaces.cluestate.TextClueStateAction
function Text.new(content, heading)
  local self = setmetatable({}, Text)
  self:_init()
  self.content = content
  self.heading = heading
  return self
end

---@param content string
---@return ct.interfaces.cluestate.TextClueStateAction
function Text:setText(content)
  self.content = content
  if self.constructed then self:_apply() end

  return self
end

---@protected
---@param view PrettyUI.SimpleView
function Text:_construct(view)
  if self.heading then
    self.heading_text = view:AddText({
      text = self.heading,
      x = 0,
      font = id.Font.MUSEO_SANS_15PT_BOLD,
      height = rowHeight(self.heading, view.contentWidth, config.Font.MUSEO_SANS_15PT_BOLD),
      marginBottom = 0,
      rowBackgroundGroup = self,
    })
    self.heading_text.clickthrough = true
  end

  self.text = view:AddText({
    text = self.content,
    x = 0,
    height = rowHeight(self.content, view.contentWidth),
    marginBottom = 0,
    rowBackgroundGroup = self.heading and self or nil,
  })
  self.text.clickthrough = true
end

function Text:destroy()
  if self.text then
    self.text:Destroy()
    self.text = nil
  end
  if self.heading_text then
    self.heading_text:Destroy()
    self.heading_text = nil
  end
  self.constructed = false
end

---@protected
function Text:_apply()
  self.text.content = self.content
  self.text.alpha = STATE_ALPHA[self.state]
  if self.heading_text then self.heading_text.alpha = STATE_ALPHA[self.state] end
end

ClueStateAction.Text = Text
ClueStateAction.rowHeight = rowHeight

return ClueStateAction
