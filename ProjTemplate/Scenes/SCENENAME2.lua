local class = require("Class.middleclass")

---@class ProjTemplate.SCENENAME2 : UIScene
local SCENE = class("ProjTemplate.SCENENAME2")

---constructor
---@param attachedScreen Screen
---@param ProjTemplatespace ProjTemplate
function SCENE:initialize(attachedScreen, ProjTemplatespace)
    JLib.UIScene.initialize(self, attachedScreen, ProjTemplatespace)

    local grid = JLib.Grid:new(attachedScreen:getSize())
    grid:setHorizontalSetting({ "*", "10", "*", "10", "*", "10", "*" })
    grid:setVerticalSetting({ "*", "10", "*", "3", "*" })
    grid:updatePosLen()

    ---@type Button
    local button2 = JLib.Button:new(self.rootScreenCanvas, self.attachingScreen,
        "button2")
    button2:setText("prev scene")
    button2.ClickEvent = function() self:buttonClickEvent() end
    self:setButton(button2)
    button2.PosRel, button2.Len = grid:getPosLen(4, 4)

    ---@type Button
    local toggleButton = JLib.Button:new(self.rootScreenCanvas, self.attachingScreen, "togglebutton")
    toggleButton:setText("toggle!")
    toggleButton.ClickEvent = function() self:togglebuttonClickEvent() end
    toggleButton.BGPressed = JLib.Enums.Color.lightBlue
    toggleButton.FGPressed = JLib.Enums.Color.black
    toggleButton.IsToggleable = true
    self:setButton(toggleButton)
    toggleButton.PosRel, toggleButton.Len = grid:getPosLen(2, 4)
    self.toggleButton = toggleButton

    ---@type TextBlock
    local textblock = JLib.TextBlock:new(self.rootScreenCanvas, self.attachingScreen, "textblock")
    textblock:setText("toggle test!")
    textblock:setBorderColor(JLib.Enums.Color.blue)
    textblock:setBorderThickness(1)
    textblock:setMarginAll(2)
    textblock:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.center)
    textblock:setTextVerticalAlignment(JLib.Enums.VerticalAlignmentMode.center)
    textblock:setBackgroundColor(JLib.Enums.Color.gray)
    textblock:setTextColor(JLib.Enums.Color.white)
    textblock.PosRel, textblock.Len = grid:getPosLen(2, 2, 5, 1)
    self.testTextBlock = textblock


end

---properties description
---@class ProjTemplate.SCENENAME2 : UIScene
---@field PROJ ProjTemplate
---@field new fun(self:ProjTemplate.SCENENAME2, attachedScreen:Screen, ProjTemplatespace: ProjTemplate):ProjTemplate.SCENENAME2

function SCENE:changed_to_other_scene() end

---add freely to do
function SCENE:other_functions() end

---set button style
---@param button Button
function SCENE:setButton(button)
    button.PosRel = JLib.Vector2:new(20, 1)
    button.Len = JLib.Vector2:new(15, 5)
    button:setTextVerticalAlignment(JLib.Enums.VerticalAlignmentMode.center)
    button:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.center)
end

function SCENE:buttonClickEvent()
    if (self.attachingScreen:getScreenSide() ~= JLib.Enums.Side.NONE) then
        self.PROJ.UIRunner:changeScene(self.PROJ.SCENENAME1_t)
    else
        self.PROJ.UIRunner:changeScene(self.PROJ.SCENENAME1)
    end
end

function SCENE:togglebuttonClickEvent()
    if self.toggleButton.IsButtonPressed then
        self.testTextBlock:setText("toggle test!\npressed!")
        self.testTextBlock:setBorderColor(JLib.Enums.Color.lime)
        self.testTextBlock:setBorderThickness(2)
        self.testTextBlock:setMarginAll(3)
        self.testTextBlock:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.left)
        self.testTextBlock:setTextVerticalAlignment(JLib.Enums.VerticalAlignmentMode.top)
        self.testTextBlock:setBackgroundColor(JLib.Enums.Color.brown)
        self.testTextBlock:setTextColor(JLib.Enums.Color.cyan)
    else
        self.testTextBlock:setText("toggle test!")
        self.testTextBlock:setBorderColor(JLib.Enums.Color.blue)
        self.testTextBlock:setBorderThickness(1)
        self.testTextBlock:setMarginAll(1)
        self.testTextBlock:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.right)
        self.testTextBlock:setTextVerticalAlignment(JLib.Enums.VerticalAlignmentMode.bottom)
        self.testTextBlock:setBackgroundColor(JLib.Enums.Color.gray)
        self.testTextBlock:setTextColor(JLib.Enums.Color.white)
    end
end

return SCENE
