local class = require("Class.middleclass")

---public class BankProj.mainScene : UIScene
---@class BankProj.mainScene : UIScene
local SCENE = class("BankProj.mainScene", JLib.UIScene)

---constructor
---@param attachedScreen Screen
---@param projNamespace table
function SCENE:initialize(attachedScreen, projNamespace)
    JLib.UIScene.initialize(self, attachedScreen, projNamespace)
    local grid = JLib.Grid:new(self.rootScreenCanvas.Len)
    grid:setHorizontalSetting({"*", "2*", "*"})
    grid:setVerticalSetting({"*", "2*", "*", "2*", "*"})
    grid:updatePosLen()

    self.tb1 = JLib.TextBlock:new(self.rootScreenCanvas, self.attachingScreen,
                                  "tb1")
    self.tb1:setText("KRW Bank!")
    self.tb1.PosRel, self.tb1.Len = grid:getPosLen(2, 2, 1, 1)
    self:tb1_style(self.tb1)

    self.bt1 = JLib.Button:new(self.rootScreenCanvas, self.attachingScreen,
                               "bt1")
    self.bt1:setText("Login!")
    self.bt1.PosRel, self.bt1.Len = grid:getPosLen(2, 4, 1, 1)
    self:butt1_style(self.bt1)
    self.bt1.ClickEvent = function() self:bt1_click() end

end

---properties description
---@class BankProj.mainScene
---@field PROJ BankProj
---@field new fun(self:BankProj.mainScene, attachedScreen:Screen, projNamespace:table):BankProj.mainScene

---comment
---@param tb1 TextBlock
function SCENE:tb1_style(tb1)
    tb1:setTextVerticalAlignment(JLib.Enums.VerticalAlignmentMode.center)
    tb1:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.center)
end

---comment
---@param bt1 Button
function SCENE:butt1_style(bt1)
    bt1:setTextVerticalAlignment(JLib.Enums.VerticalAlignmentMode.center)
    bt1:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.center)
end

function SCENE:bt1_click() 
    self.PROJ.LoginScene:resetList()
    self.PROJ.UIRunner:changeScene(self.PROJ.LoginScene) 
end

return SCENE