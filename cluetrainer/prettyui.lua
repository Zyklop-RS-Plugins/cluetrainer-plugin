-- PrettyUI, which includes this file and the entirety of the prettyui folder, is licensed by the PrettyUI contributors under the below license terms.
-- It is redistributed as part of Clue Trainer in accordance with these terms.

-- BSD 3-Clause License

-- Copyright (c) 2026, PrettyRS

-- Redistribution and use in source and binary forms, with or without
-- modification, are permitted provided that the following conditions are met:

-- 1. Redistributions of source code must retain the above copyright notice, this
--    list of conditions and the following disclaimer.

-- 2. Redistributions in binary form must reproduce the above copyright notice,
--    this list of conditions and the following disclaimer in the documentation
--    and/or other materials provided with the distribution.

-- 3. Neither the name of the copyright holder nor the names of its
--    contributors may be used to endorse or promote products derived from
--    this software without specific prior written permission.

-- THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
-- AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
-- IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
-- DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
-- FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
-- DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
-- SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
-- CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
-- OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
-- OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


local TextField = require("prettyui/text_field")
local KeybindField = require("prettyui/keybind_field")
local BuffBar = require("prettyui/buff_bar")
local TimeGraph = require("prettyui/time_graph")
local BarChart = require("prettyui/bar_chart")
local Histogram = require("prettyui/histogram")
local Dialog = require("prettyui/dialog")
local Confirm = require("prettyui/confirm")
local SelectionButtons = require("prettyui/selection_button")
local PrettyMiniMenu = require("prettyui/minimenu")
local OverheadBar = require("prettyui/overhead_bar")
local CategoryGroups = require("prettyui/core/category_groups")
local Components = require("prettyui/core/components")

local resources = Plugin.resources
TextField.SetDefaultSprite(resources and
((resources.prettyui and resources.prettyui.input_default) or resources["prettyui/input_default.png"]))

local PrettyUI = {
    AchievementPopup = require("prettyui/achievement_popup"),
    AnchoredTooltip = require("prettyui/anchored_tooltip"),
    BarChart = BarChart,
    BuildCategoryGroup = CategoryGroups and CategoryGroups.build,
    NewComponent = Components.new,
    RefreshComponentIDs = Components.refresh,
    WithCategoryBatch = CategoryGroups and CategoryGroups.withBatch,
    BigSpinner = require("prettyui/big_spinner"),
    CheckboxButton = SelectionButtons.CheckboxButton,
    ColourPicker = require("prettyui/colour_picker"),
    ComboBox = require("prettyui/combo_box"),
    CollapseButton = require("prettyui/collapse_button"),
    Confirm = Confirm,
    Dialog = Dialog,
    Divider = require("prettyui/divider"),
    FancyButton = require("prettyui/fancy_button"),
    Histogram = Histogram,
    TimeGraph = TimeGraph,
    ItemSlot = require("prettyui/item_slot"),
    ItemGrid = require("prettyui/item_grid"),
    KeybindField = KeybindField,
    List = require("prettyui/list"),
    MiniMenu = PrettyMiniMenu,
    Panel = require("prettyui/panel"),
    OverheadBar = OverheadBar,
    Sprites = require("prettyui/core/sprites"),
    RibbonButton = require("prettyui/ribbon_button"),
    RadioButton = SelectionButtons.RadioButton,
    SimpleButton = require("prettyui/simple_button"),
    Slider = require("prettyui/slider"),
    Sprite = require("prettyui/sprite"),
    SpriteButton = require("prettyui/sprite_button"),
    Spinner = require("prettyui/spinner"),
    Tabs = require("prettyui/tabs"),
    Text = require("prettyui/text"),
    TextField = TextField,
    Tooltip = require("prettyui/tooltip"),
    Window = require("prettyui/window"),
    SimpleView = require("prettyui/simple_view"),
    BuffBar = BuffBar,
}

PrettyUI.version = "1.3.3"

if PrettyMiniMenu then PrettyMiniMenu.Start() end

function PrettyUI.PluginShutdown()
    if KeybindField then KeybindField.Shutdown() end
    if PrettyMiniMenu then PrettyMiniMenu.Shutdown() end
    if Dialog then Dialog.Shutdown() end
    if BuffBar then BuffBar.Shutdown() end
    if TimeGraph then TimeGraph.Shutdown() end
    if BarChart then BarChart.Shutdown() end
    if Histogram then Histogram.Shutdown() end
    if OverheadBar then OverheadBar.Shutdown() end
end

return PrettyUI