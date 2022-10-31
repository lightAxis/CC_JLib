local class = require("Class.middleclass")

---@class ProjTemplate.SCENENAME3 : UIScene
local SCENE = class("ProjTemplate.SCENENAME3")


---constructor
---@param attachedScreen Screen
---@param ProjTemplatespace ProjTemplate
function SCENE:initialize(attachedScreen, ProjTemplatespace)
    JLib.UIScene.initialize(self, attachedScreen, ProjTemplatespace)

    local grid = JLib.Grid:new(attachedScreen:getSize())
    grid:setHorizontalSetting({ "*", "10", "*", "10", "*", "10", "*" })
    grid:setVerticalSetting({ "*", "3", "*", "3", "*", "3", "*" })
    grid:updatePosLen()

    ---@type Button
    local button2 = JLib.Button:new(self.rootScreenCanvas, self.attachingScreen,
        "button2")
    button2:setText("prev scene")
    button2.ClickEvent = function() self:buttonClickEvent_prev() end
    self:setVHalign(button2)
    button2.PosRel, button2.Len = grid:getPosLen(4, 6)

    ---@type Button
    local button3 = JLib.Button:new(self.rootScreenCanvas, self.attachingScreen, "button3")
    button3:setText("next scene")
    button3.ClickEvent = function() self:buttonClickEvent_next() end
    self:setVHalign(button3)
    button3.PosRel, button3.Len = grid:getPosLen(6, 6)

    ---@type ProgressBar
    local progressbar1 = JLib.ProgressBar:new(self.rootScreenCanvas, self.attachingScreen, "progressbar1")
    progressbar1:setValue(1.0)
    progressbar1.BarDirection = JLib.Enums.Direction.horizontal
    progressbar1.PosRel, progressbar1.Len = grid:getPosLenWithMargin(2, 2, 5, 1, 0, 0, 0, 0)
    self.progressbar1 = progressbar1

    ---@type ProgressBar
    local progressbar2 = JLib.ProgressBar:new(self.rootScreenCanvas, self.attachingScreen, "progressbar1")
    progressbar2:setValue(1.0)
    progressbar2.BarDirection = JLib.Enums.Direction.vertical
    progressbar2.PosRel, progressbar2.Len = grid:getPosLenWithMargin(5, 1, 1, 5, 0, 0, 1, 1)
    progressbar2.BG = JLib.Enums.Color.None
    progressbar2.BarBG = JLib.Enums.Color.lime
    self.progressbar2 = progressbar2

    ---@type TextBlock
    local tx1 = JLib.TextBlock:new(self.rootScreenCanvas, self.attachingScreen, "progressbar1_text")
    tx1:setText("now loading... (" .. tostring(self.progressbar1:getValue() * 100) .. "%)")
    tx1:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.center)
    tx1:setTextVerticalAlignment(JLib.Enums.VerticalAlignmentMode.center)
    tx1.BG = JLib.Enums.Color.None
    tx1.FG = JLib.Enums.Color.lightGray
    tx1.PosRel, tx1.Len = grid:getPosLenWithMargin(2, 2, 5, 1, 0, 0, 0, 0)
    self.tx1 = tx1

    ---@type Button
    local button_up = JLib.Button:new(self.rootScreenCanvas, self.attachingScreen, "button_up")
    button_up:setText("->")
    button_up.ClickEvent = function() self:buttonClickEvent_up() end
    self:setVHalign(button_up)
    button_up.PosRel, button_up.Len = grid:getPosLen(2, 4)

    ---@type Button
    local button_down = JLib.Button:new(self.rootScreenCanvas, self.attachingScreen, "button_down")
    button_down:setText("<-")
    button_down.ClickEvent = function() self:buttonClickEvent_down() end
    self:setVHalign(button_down)
    button_down.PosRel, button_down.Len = grid:getPosLen(2, 6)

end

---set button style
---@param button Button
function SCENE:setVHalign(button)
    button:setTextVerticalAlignment(JLib.Enums.VerticalAlignmentMode.center)
    button:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.center)
end

function SCENE:buttonClickEvent_prev()
    if (self.attachingScreen:getScreenSide() ~= JLib.Enums.Side.NONE) then
        self.PROJ.UIRunner:changeScene(self.PROJ.SCENENAME2_t)
    else
        self.PROJ.UIRunner:changeScene(self.PROJ.SCENENAME2)
    end
end

function SCENE:buttonClickEvent_next()
    if (self.attachingScreen:getScreenSide() ~= JLib.Enums.Side.NONE) then
        self.PROJ.UIRunner:changeScene(self.PROJ.SCENENAME3_t)
    else
        self.PROJ.UIRunner:changeScene(self.PROJ.SCENENAME3)
    end
end

function SCENE:buttonClickEvent_up()
    self.progressbar1:setValue(self.progressbar1:getValue() + 0.1)
    self.progressbar2:setValue(self.progressbar2:getValue() + 0.1)
    self.tx1:setText("now loading... (" .. tostring(self.progressbar1:getValue() * 100) .. "%)")
end

function SCENE:buttonClickEvent_down()
    self.progressbar1:setValue(self.progressbar1:getValue() - 0.1)
    self.progressbar2:setValue(self.progressbar2:getValue() - 0.1)
    self.tx1:setText("now loading... (" .. tostring(self.progressbar1:getValue() * 100) .. "%)")
end

return SCENE
