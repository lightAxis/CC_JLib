local class = require("Class.middleclass")

---@class ProjTemplate.SCENENAME2 : UIScene
local SCENE = class("ProjTemplate.SCENENAME2")

---constructor
---@param ProjTemplatespace ProjTemplate
---@param UILayout ProjTemplate.SCENENAME2_L
function SCENE:initialize(ProjTemplatespace, UILayout)
    JLib.UIScene.initialize(self, ProjTemplatespace, UILayout)

    -- ? to use type checking autocomplete from lua server..
    -- TODO if lua server updates for this issue, than can change
    local layout = self.Layout
    ---@cast layout ProjTemplate.SCENENAME2_L
    self.UILayout = layout


    self.UILayout.button2.ClickEvent = function() self:buttonClickEvent_prev() end

    self.UILayout.button3.ClickEvent = function() self:buttonClickEvent_next() end

    self.UILayout.toggleButton.ClickEvent = function() self:togglebuttonClickEvent() end

end

---properties description
---@class ProjTemplate.SCENENAME2 : UIScene
---@field PROJ ProjTemplate
---@field new fun(self:ProjTemplate.SCENENAME2, attachedScreen:Screen, ProjTemplatespace: ProjTemplate):ProjTemplate.SCENENAME2

function SCENE:changed_to_other_scene() end

---add freely to do
function SCENE:other_functions() end

function SCENE:buttonClickEvent_prev()
    if (self.Layout.attachingScreen:getScreenSide() ~= JLib.Enums.Side.NONE) then
        self.PROJ.UIRunner:changeScene(self.PROJ.SCENENAME1_t)
    else
        self.PROJ.UIRunner:changeScene(self.PROJ.SCENENAME1)
    end
end

function SCENE:buttonClickEvent_next()
    if (self.Layout.attachingScreen:getScreenSide() ~= JLib.Enums.Side.NONE) then
        self.PROJ.UIRunner:changeScene(self.PROJ.SCENENAME3_t)
    else
        self.PROJ.UIRunner:changeScene(self.PROJ.SCENENAME3)
    end
end

function SCENE:togglebuttonClickEvent()
    if self.UILayout.toggleButton.IsButtonPressed then
        self.UILayout.testTextBlock:setText("toggle test!\npressed!")
        self.UILayout.testTextBlock:setBorderColor(JLib.Enums.Color.lime)
        self.UILayout.testTextBlock:setBorderThickness(2)
        self.UILayout.testTextBlock:setMarginAll(3)
        self.UILayout.testTextBlock:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.left)
        self.UILayout.testTextBlock:setTextVerticalAlignment(JLib.Enums.VerticalAlignmentMode.top)
        self.UILayout.testTextBlock:setBackgroundColor(JLib.Enums.Color.brown)
        self.UILayout.testTextBlock:setBackgroundColor(JLib.Enums.Color.None)
        self.UILayout.testTextBlock:setTextColor(JLib.Enums.Color.cyan)
    else
        self.UILayout.testTextBlock:setText("toggle test!")
        self.UILayout.testTextBlock:setBorderColor(JLib.Enums.Color.blue)
        self.UILayout.testTextBlock:setBorderThickness(1)
        self.UILayout.testTextBlock:setMarginAll(1)
        self.UILayout.testTextBlock:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.left)
        self.UILayout.testTextBlock:setTextVerticalAlignment(JLib.Enums.VerticalAlignmentMode.bottom)
        self.UILayout.testTextBlock:setBackgroundColor(JLib.Enums.Color.gray)
        self.UILayout.testTextBlock:setTextColor(JLib.Enums.Color.white)
    end
end

return SCENE
