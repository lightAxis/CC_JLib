local class = require("Class.middleclass")

---@class ProjTemplate.SCENENAME3_L : UILayout
local SCENE_L = class("ProjTemplate.SCENENAME2_L")

---constructor
---@param attachedScreen Screen
---@param ProjNamespace ProjTemplate
function SCENE_L:initialize(attachedScreen, ProjNamespace)
    JLib.UILayout.initialize(self, attachedScreen, ProjNamespace)

    ---@type Grid
    local grid = JLib.Grid:new(attachedScreen:getSize())
    grid:setHorizontalSetting({ "*", "10", "*", "10", "*", "10", "*" })
    grid:setVerticalSetting({ "*", "3", "*", "3", "*", "3", "*" })
    grid:updatePosLen()
    self.grid = grid

    --- prev scene button
    ---@type Button
    local button2 = JLib.Button:new(self.rootScreenCanvas, self.attachingScreen,
        "button2")
    button2:setText("prev scene")
    -- button2.ClickEvent = function() self:buttonClickEvent_prev() end
    button2:setTextVerticalAlignment(JLib.Enums.VerticalAlignmentMode.center)
    button2:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.center)
    button2.PosRel, button2.Len = grid:getPosLen(4, 6)
    self.button2 = button2

    --- next scene button
    ---@type Button
    local button3 = JLib.Button:new(self.rootScreenCanvas, self.attachingScreen, "button3")
    button3:setText("next scene")
    -- button3.ClickEvent = function() self:buttonClickEvent_next() end
    button3:setTextVerticalAlignment(JLib.Enums.VerticalAlignmentMode.center)
    button3:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.center)
    button3.PosRel, button3.Len = grid:getPosLen(6, 6)
    self.button3 = button3

    --- progress bar horizontal, with text
    ---@type ProgressBar
    local progressbar1 = JLib.ProgressBar:new(self.rootScreenCanvas, self.attachingScreen, "progressbar1")
    progressbar1:setValue(1.0)
    progressbar1.BarDirection = JLib.Enums.Direction.horizontal
    progressbar1.PosRel, progressbar1.Len = grid:getPosLenWithMargin(2, 2, 5, 1, 0, 0, 0, 0)
    self.progressbar1 = progressbar1

    --- progress bar vertiacl without text
    ---@type ProgressBar
    local progressbar2 = JLib.ProgressBar:new(self.rootScreenCanvas, self.attachingScreen, "progressbar1")
    progressbar2:setValue(1.0)
    progressbar2.BarDirection = JLib.Enums.Direction.vertical
    progressbar2.PosRel, progressbar2.Len = grid:getPosLenWithMargin(5, 1, 1, 5, 0, 0, 1, 1)
    progressbar2.BG = JLib.Enums.Color.None
    progressbar2.BarBG = JLib.Enums.Color.lime
    self.progressbar2 = progressbar2

    --- progress bar horizontal text block
    ---@type TextBlock
    local tx1 = JLib.TextBlock:new(self.rootScreenCanvas, self.attachingScreen, "progressbar1_text")
    tx1:setText("now loading... (" .. tostring(self.progressbar1:getValue() * 100) .. "%)")
    tx1:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.center)
    tx1:setTextVerticalAlignment(JLib.Enums.VerticalAlignmentMode.center)
    tx1.BG = JLib.Enums.Color.None
    tx1.FG = JLib.Enums.Color.lightGray
    tx1.PosRel, tx1.Len = grid:getPosLenWithMargin(2, 2, 5, 1, 0, 0, 0, 0)
    self.tx1 = tx1

    --- button for test value up 0.1
    ---@type Button
    local button_up = JLib.Button:new(self.rootScreenCanvas, self.attachingScreen, "button_up")
    button_up:setText("->")
    -- button_up.ClickEvent = function() self:buttonClickEvent_up() end
    button_up:setTextVerticalAlignment(JLib.Enums.VerticalAlignmentMode.center)
    button_up:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.center)
    button_up.PosRel, button_up.Len = grid:getPosLen(2, 4)
    self.button_up = button_up

    --- button for test value down 0.1
    ---@type Button
    local button_down = JLib.Button:new(self.rootScreenCanvas, self.attachingScreen, "button_down")
    button_down:setText("<-")
    -- button_down.ClickEvent = function() self:buttonClickEvent_down() end
    button_down:setTextVerticalAlignment(JLib.Enums.VerticalAlignmentMode.center)
    button_down:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.center)
    button_down.PosRel, button_down.Len = grid:getPosLen(2, 6)
    self.button_down = button_down
end

return SCENE_L