local class = require("Class.middleclass")

---public class BankProj.mainScene : UIScene
---@class KioskProj.mainScene : UIScene
local SCENE = class("KioskProj.mainScene", JLib.UIScene)

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
    self.tb1:setText(self.PROJ.Param.kioskName)
    self.tb1.PosRel, self.tb1.Len = grid:getPosLen(2, 2, 1, 1)
    self:tb1_style(self.tb1)

    self.bt1 = JLib.Button:new(self.rootScreenCanvas, self.attachingScreen,
                               "bt1")
    self.bt1:setText("Menu")
    self.bt1.PosRel, self.bt1.Len = grid:getPosLen(2, 4, 1, 1)
    self:butt1_style(self.bt1)
    self.bt1.ClickEvent = function() self:bt1_click() end

    rednet.open(self.PROJ.Param.rednet_side)
end

---properties description
---@class KioskProj.mainScene
---@field PROJ KioskProj
---@field new fun(self:KioskProj.mainScene, attachedScreen:Screen, projNamespace:table):KioskProj.mainScene

---comment
---@param tb1 TextBlock
function SCENE:tb1_style(tb1)
    tb1:setBackgroundColor(JLib.Enums.Color.black)
    tb1:setTextColor(JLib.Enums.Color.cyan)
    tb1:setTextVerticalAlignment(JLib.Enums.VerticalAlignmentMode.center)
    tb1:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.center)
end

---comment
---@param bt1 Button
function SCENE:butt1_style(bt1)
    bt1:setBackgroundColor(JLib.Enums.Color.green)
    bt1:setTextColor(JLib.Enums.Color.lime)
    bt1:setTextVerticalAlignment(JLib.Enums.VerticalAlignmentMode.center)
    bt1:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.center)
end

function SCENE:bt1_click()
    -- self.PROJ.BioScanScene:clean()
    -- self.PROJ.UIRunner:changeScene(self.PROJ.BioScanScene)
    print("aaaa")
end

return SCENE
