local class = require("Class.middleclass")

---@class ProjTemplate.SCENENAME2_L : UILayout
local SCENE_L = class("ProjTemplate.SCENENAME2_L")

---constructor
---@param attachedScreen Screen
---@param ProjNamespace ProjTemplate
function SCENE_L:initialize(attachedScreen, ProjNamespace)
    JLib.UILayout.initialize(self, attachedScreen, ProjNamespace)

    ---@type Grid
    local grid = JLib.Grid:new(attachedScreen:getSize())
    grid:setHorizontalSetting({ "*", "10", "*", "10", "*", "10", "*" })
    grid:setVerticalSetting({ "*", "10", "*", "3", "*" })
    grid:updatePosLen()
    self.grid = grid

    ---@type Button
    local button2 = JLib.Button:new(self.rootScreenCanvas, self.attachingScreen,
        "button2")
    button2:setText("prev scene")
    -- button2.ClickEvent = function() self:buttonClickEvent_prev() end
    button2:setTextVerticalAlignment(JLib.Enums.VerticalAlignmentMode.center)
    button2:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.center)
    button2.PosRel, button2.Len = grid:getPosLen(4, 4)
    self.button2 = button2

    ---@type Button
    local button3 = JLib.Button:new(self.rootScreenCanvas, self.attachingScreen, "button3")
    button3:setText("next scene")
    -- button3.ClickEvent = function() self:buttonClickEvent_next() end
    button3:setTextVerticalAlignment(JLib.Enums.VerticalAlignmentMode.center)
    button3:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.center)
    button3.PosRel, button3.Len = grid:getPosLen(6, 4)
    self.button3 = button3

    ---@type Button
    local toggleButton = JLib.Button:new(self.rootScreenCanvas, self.attachingScreen, "togglebutton")
    toggleButton:setText("toggle!")
    -- toggleButton.ClickEvent = function() self:togglebuttonClickEvent() end
    toggleButton.BGPressed = JLib.Enums.Color.lightBlue
    toggleButton.FGPressed = JLib.Enums.Color.black
    toggleButton.IsToggleable = true
    toggleButton:setTextVerticalAlignment(JLib.Enums.VerticalAlignmentMode.center)
    toggleButton:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.center)
    toggleButton.PosRel, toggleButton.Len = grid:getPosLen(2, 4)
    self.toggleButton = toggleButton

    ---@type TextBlock
    local textblock = JLib.TextBlock:new(self.rootScreenCanvas, self.attachingScreen, "textblock")
    textblock:setText("toggle test!\ninit")
    textblock:setBorderColor(JLib.Enums.Color.blue)
    textblock:setBorderThickness(1)
    textblock:setMarginAll(2)
    textblock:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.center)
    textblock:setTextVerticalAlignment(JLib.Enums.VerticalAlignmentMode.center)
    textblock:setBackgroundColor(JLib.Enums.Color.gray)
    textblock:setTextColor(JLib.Enums.Color.white)
    textblock.PosRel, textblock.Len = grid:getPosLen(2, 2, 5, 1)
    self.testTextBlock = textblock

    ---@type TextBlock
    local textblock2 = JLib.TextBlock:new(self.rootScreenCanvas, self.attachingScreen, "textblock2")
    textblock2:setText("This is transparent background!! This is transparent background!! This is transparent background!! ")
    textblock2:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.center)
    textblock2:setTextVerticalAlignment(JLib.Enums.VerticalAlignmentMode.top)
    textblock2:setBackgroundColor(JLib.Enums.Color.None)
    textblock2:setTextColor(JLib.Enums.Color.purple)
    textblock2.PosRel, textblock2.Len = grid:getPosLen(5, 1, 1, 4)
    self.textblock2 = textblock2
end

return SCENE_L