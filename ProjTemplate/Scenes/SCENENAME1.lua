local class = require("Class.middleclass")

---@class ProjTemplate.SCENENAME1 : UIScene
local SCENE = class("ProjTemplate.SCENENAME1")

---constructor
---@param attachedScreen Screen
---@param ProjTemplatespace ProjTemplate
function SCENE:initialize(attachedScreen, ProjTemplatespace)
    JLib.UIScene.initialize(self, attachedScreen, ProjTemplatespace)

    local ButtonNext = JLib.Button:new(self.rootScreenCanvas,
                                       self.attachingScreen, "button1")
    ButtonNext:setText("Next Scene")
    ButtonNext.ClickEvent = function()
        -- error(self.attachingScreen:getScreenSide())
        self:button_click()
    end
    self:ButtonStyle(ButtonNext)

end

---properties description
---@class ProjTemplate.SCENENAME1 : UIScene
---@field PROJ ProjTemplate
---@field new fun(self:ProjTemplate.SCENENAME1, attachedScreen:Screen, ProjTemplatespace: ProjTemplate):ProjTemplate.SCENENAME1

function SCENE:changed_to_other_scene() end

---button style
---@param button Button
function SCENE:ButtonStyle(button)
    button.PosRel = JLib.Vector2:new(10, 10)
    button.Len = JLib.Vector2:new(15, 3)
    button:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.center)
    button:setTextVerticalAlignment(JLib.Enums.VerticalAlignmentMode.center)
end

---add freely to do
function SCENE:other_functions() end

function SCENE:button_click()
    -- error(self.attachingScreen:getScreenSide())
    if (self.attachingScreen:getScreenSide() ~= JLib.Enums.Side.NONE) then

        self.PROJ.UIRunner:changeScene(self.PROJ.SCENENAME2_t)
    else
        self.PROJ.UIRunner:changeScene(self.PROJ.SCENENAME2)
    end
end

return SCENE
