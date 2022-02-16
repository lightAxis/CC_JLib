local class = require("Class.middleclass")

---@class BankProj.loginScene : UIScene
local SCENE = class("BankProj.loginScene")

---constructor
---@param attachedScreen Screen
---@param ProjTemplatespace BankProj
function SCENE:initialize(attachedScreen, ProjTemplatespace)
    JLib.UIScene.initialize(self, attachedScreen, ProjTemplatespace)

    local grid = JLib.Grid:new(self.rootScreenCanvas.Len)
    grid:setHorizontalSetting({"*", "*","1" ,"*", "*"})
    grid:setVerticalSetting({"1", "3","1", "*", "3", "1"})
    grid:updatePosLen()

    self.tb1 = JLib.TextBlock:new(self.rootScreenCanvas, self.attachingScreen,
                                  "tb1")
    self.tb1:setText("Select Your ID")
    self:tb1_style(self.tb1)
    self.tb1.PosRel, self.tb1.Len = grid:getPosLen(2, 2, 3, 1)

    self.lb1 = JLib.ListBox:new(self.rootScreenCanvas, self.attachingScreen,
                                "listbox1")
    self.lb1.PosRel, self.lb1.Len = grid:getPosLen(2, 4, 3, 1)
    self.lb1:setItemTemplate(function(obj) return obj end)

    self.butt1 = JLib.Button:new(self.rootScreenCanvas, self.attachingScreen,
                                 "butt1")
    self.butt1:setText("Get Player")
    self:butt1_style(self.butt1)
    self.butt1.PosRel, self.butt1.Len = grid:getPosLen(2, 5, 1, 1)
    self.butt1.ClickEvent = function() self:butt1_click() end

    self.butt2 = JLib.Button:new(self.rootScreenCanvas, self.attachingScreen,
                                 "butt2")
    self.butt2:setText("Back")
    self:butt1_style(self.butt2)
    self.butt2.PosRel, self.butt2.Len = grid:getPosLen(4, 5, 1, 1)
    self.butt2.ClickEvent = function() self:butt2_click() end

    self.PlayerDetector = peripheral.find(self.PROJ.Param.PlayerDetectorName)

end

---properties description
---@class BankProj.loginScene : UIScene
---@field PROJ BankProj
---@field new fun(self:BankProj.loginScene, attachedScreen:Screen, ProjTemplatespace: BankProj):BankProj.loginScene

---comment
---@param tb1 TextBlock
function SCENE:tb1_style(tb1)
    tb1:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.center)
    tb1:setTextVerticalAlignment(JLib.Enums.VerticalAlignmentMode.center)
end

---comment
---@param butt1 Button
function SCENE:butt1_style(butt1)
    butt1:setTextVerticalAlignment(JLib.Enums.VerticalAlignmentMode.center)
    butt1:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.center)
end

function SCENE:butt1_click()
    local playerList = self.PlayerDetector.getPlayersInRange(self.PROJ.Param
                                                                 .PlayerScanRange)
    self.lb1:setItemSource(playerList)
    self.lb1:Refresh()
end

function SCENE:butt2_click() self.PROJ.UIRunner:changeScene(self.PROJ.MainScene) end

function SCENE:resetList()
    self.lb1:setItemSource({})
    self.lb1:Refresh()
end

return SCENE