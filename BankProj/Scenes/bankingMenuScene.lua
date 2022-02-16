local class = require("Class.middleclass")

---@class BankProj.bankingMenuScene : UIScene
local SCENE = class("BankProj.bankingMenuScene")

require("DBs.BankDB.Include")

---constructor
---@param attachedScreen Screen
---@param ProjTemplatespace BankProj
function SCENE:initialize(attachedScreen, ProjTemplatespace)
    JLib.UIScene.initialize(self, attachedScreen, ProjTemplatespace)
    local grid = JLib.Grid:new(self.rootScreenCanvas.Len)
    grid:setHorizontalSetting({"*", "*"})
    grid:setVerticalSetting({"1", "*", "*", "1"})
    grid:updatePosLen()

    --- title
    local title_tb = JLib.TextBlock:new(self.rootScreenCanvas,
                                        self.attachingScreen, "title_tb")
    title_tb:setText("Menu")
    title_tb.PosRel, title_tb.Len = grid:getPosLenWithMargin(1, 1, 2, 1, 0, 0,
                                                             0, 0)
    self:title_tb_style(title_tb)
    self.title_tb = title_tb

    --- profile button
    local profile_bt = JLib.Button:new(self.rootScreenCanvas,
                                       self.attachingScreen, "profile_bt")
    profile_bt:setText("Profile")
    profile_bt.PosRel, profile_bt.Len = grid:getPosLenWithMargin(1, 2, 1, 1, 1,
                                                                 1, 1, 1)
    self:profile_bt_style(profile_bt)
    self.profile_bt = profile_bt

    --- histories button
    local histories_bt = JLib.Button:new(self.rootScreenCanvas,
                                         self.attachingScreen, "histories_bt")
    histories_bt:setText("Histories")
    histories_bt.PosRel, histories_bt.Len =
        grid:getPosLenWithMargin(2, 2, 1, 1, 0, 2, 1, 1)
    self:histories_bt_style(histories_bt)
    self.histories_bt = histories_bt

    --- send button
    local send_bt = JLib.Button:new(self.rootScreenCanvas, self.attachingScreen,
                                    "send_bt")
    send_bt:setText("Send Money")
    send_bt.PosRel, send_bt.Len = grid:getPosLenWithMargin(1, 3, 1, 1, 1, 1, 0,
                                                           2)
    self:send_bt_style(send_bt)
    self.send_bt = send_bt

    --- register button
    local register_bt = JLib.Button:new(self.rootScreenCanvas,
                                        self.attachingScreen, "register_bt")
    register_bt:setText("Register")
    register_bt.PosRel, register_bt.Len =
        grid:getPosLenWithMargin(2, 3, 1, 1, 0, 2, 0, 2)
    self:register_bt_style(register_bt)
    self.register_bt = register_bt

    --- back button
    local back_bt = JLib.Button:new(self.rootScreenCanvas, self.attachingScreen,
                                    "back_bt")
    back_bt:setText("Back")
    back_bt.PosRel, back_bt.Len = grid:getPosLenWithMargin(1, 4, 1, 1, 0, 1, 0,
                                                           0)
    self:back_bt_style(back_bt)
    self.back_bt = back_bt

end

---properties description
---@class BankProj.bankingMenuScene : UIScene
---@field PROJ BankProj
---@field new fun(self:BankProj.bankingMenuScene, attachedScreen:Screen, ProjTemplatespace: BankProj):BankProj.bankingMenuScene

---@param tb TextBlock
function SCENE:title_tb_style(tb)
    tb:setBackgroundColor(JLib.Enums.Color.lightBlue)
    tb:setTextColor(JLib.Enums.Color.white)
    tb:setTextVerticalAlignment(JLib.Enums.VerticalAlignmentMode.center)
    tb:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.center)
end

---@param bt Button
function SCENE:profile_bt_style(bt)
    bt:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.center)
    bt:setTextVerticalAlignment(JLib.Enums.VerticalAlignmentMode.center)
    bt.ClickEvent = function() self:profile_bt_clickEvent() end
end

function SCENE:profile_bt_clickEvent()
    self.PROJ.ProfileScene:setOwnerName(self.PROJ.BioScanScene.current_Player)
    self.PROJ.ProfileScene:link_rednet_event()
    self.PROJ.ProfileScene:clearTextBlocks()
    self.PROJ.UIRunner:changeScene(self.PROJ.ProfileScene)
end

---@param bt Button
function SCENE:histories_bt_style(bt)
    bt:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.center)
    bt:setTextVerticalAlignment(JLib.Enums.VerticalAlignmentMode.center)
    bt.ClickEvent = function() self:histories_bt_clickEvent() end
end

function SCENE:histories_bt_clickEvent()
    self.PROJ.HistoriesScene:link_rednet_event()
    self.PROJ.HistoriesScene:clear()
    self.PROJ.UIRunner:changeScene(self.PROJ.HistoriesScene)
end

---@param bt Button
function SCENE:send_bt_style(bt)
    bt:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.center)
    bt:setTextVerticalAlignment(JLib.Enums.VerticalAlignmentMode.center)
    bt.ClickEvent = function() self:send_bt_clickEvent() end
end

function SCENE:send_bt_clickEvent()
    print("aa3")
    self.PROJ.SendingScene:link_rednet_event()
    self.PROJ.SendingScene:clear()
    self.PROJ.UIRunner:changeScene(self.PROJ.SendingScene)
end

---@param bt Button
function SCENE:register_bt_style(bt)
    bt:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.center)
    bt:setTextVerticalAlignment(JLib.Enums.VerticalAlignmentMode.center)
    bt.ClickEvent = function() self:register_bt_clickEvent() end
end

function SCENE:register_bt_clickEvent() print("aa4") end

---@param bt Button
function SCENE:back_bt_style(bt)
    bt:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.center)
    bt:setTextVerticalAlignment(JLib.Enums.VerticalAlignmentMode.center)
    bt.ClickEvent = function() self:back_bt_clickEvent() end
end

function SCENE:back_bt_clickEvent()
    self.PROJ.BioScanScene:clean()
    self.PROJ.UIRunner:changeScene(self.PROJ.BioScanScene)
end

return SCENE
