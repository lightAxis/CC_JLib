local class = require("Class.middleclass")

---@class ProjTemplate.SCENENAME2 : UIScene
local SCENE = class("ProjTemplate.SCENENAME2")

---constructor
---@param attachedScreen Screen
---@param ProjTemplatespace ProjTemplate
function SCENE:initialize(attachedScreen, ProjTemplatespace)
    JLib.UIScene.initialize(self, attachedScreen, ProjTemplatespace)

    local button2 = JLib.Button:new(self.rootScreenCanvas, self.attachingScreen,
                                    "button2")
    button2:setText("prev scene")
    button2.ClickEvent = function() self:buttonClickEvent() end
    self:setButton(button2)

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

return SCENE
