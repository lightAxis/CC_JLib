local class = require("Class.middleclass")

---@class BankProj.profileScene : UIScene
local SCENE = class("BankProj.profileScene")

---constructor
---@param attachedScreen Screen
---@param ProjTemplatespace BankProj
function SCENE:initialize(attachedScreen, ProjTemplatespace)
    JLib.UIScene.initialize(self, attachedScreen, ProjTemplatespace)
    local grid = JLib.Grid:new(self.rootScreenCanvas.Len)
    grid:setHorizontalSetting({"9", "*"})
    grid:setVerticalSetting({"1", "1", "*", "*", "*", "*", "1", "1"})
    grid:updatePosLen()

    local grid_bottom_pos, grid_bottom_len = grid:getPosLen(1, 8, 2, 1)
    local grid_buttom = JLib.Grid:new(grid_bottom_len, grid_bottom_pos)
    grid_buttom:setHorizontalSetting({"*", "*"})
    grid_buttom:setVerticalSetting({"*"})
    grid_buttom:updatePosLen()

    --- title menu
    local title_tb = JLib.TextBlock:new(self.rootScreenCanvas,
                                        self.attachingScreen, "title_tb")
    title_tb:setText("Profile")
    title_tb.PosRel, title_tb.Len = grid:getPosLenWithMargin(1, 1, 2, 1, 0, 0,
                                                             0, 0)
    self:title_tb_style(title_tb)
    self.title_tb = title_tb

    --- msg_textblock
    local msg_tb = JLib.TextBlock:new(self.rootScreenCanvas,
                                      self.attachingScreen, "msg_tb")
    msg_tb:setText("Press Refresh Button")
    msg_tb.PosRel, msg_tb.Len = grid:getPosLenWithMargin(1, 2, 2, 1, 0, 0, 0, 0)
    self:msg_tb_style(msg_tb)
    self.msg_tb = msg_tb

    --- account owner fixed TextBlock
    local ownerf_tb = JLib.TextBlock:new(self.rootScreenCanvas,
                                         self.attachingScreen, "ownerf_tb")
    ownerf_tb:setText("Owner")
    ownerf_tb.PosRel, ownerf_tb.Len = grid:getPosLenWithMargin(1, 3, 1, 1, 1, 1,
                                                               1, 0)
    self:ownerf_tb_style(ownerf_tb)
    self.ownerf_tb = ownerf_tb

    --- account owner TextBlock
    local owner_tb = JLib.TextBlock:new(self.rootScreenCanvas,
                                        self.attachingScreen, "owner_tb")
    owner_tb.PosRel, owner_tb.Len = grid:getPosLenWithMargin(2, 3, 1, 1, 1, 1,
                                                             1, 0)
    owner_tb:setText(self.PROJ.BioScanScene.current_Player)
    self:owner_tb_style(owner_tb)
    self.owner_tb = owner_tb

    --- account balance fixed TextBlock
    local balancef_tb = JLib.TextBlock:new(self.rootScreenCanvas,
                                           self.attachingScreen, "balancef_tb")
    balancef_tb:setText("Balance")
    balancef_tb.PosRel, balancef_tb.Len =
        grid:getPosLenWithMargin(1, 4, 1, 1, 1, 1, 1, 0)
    self:balancef_tb_style(balancef_tb)
    self.balancef_tb = balancef_tb

    --- account balance TextBlock
    local balance_tb = JLib.TextBlock:new(self.rootScreenCanvas,
                                          self.attachingScreen, "balance_tb")
    balance_tb:setText("")
    balance_tb.PosRel, balance_tb.Len = grid:getPosLenWithMargin(2, 4, 1, 1, 1,
                                                                 1, 1, 0)
    self:balance_tb_style(balance_tb)
    self.balance_tb = balance_tb

    --- account salary fixed TextBlock
    local salaryf_tb = JLib.TextBlock:new(self.rootScreenCanvas,
                                          self.attachingScreen, "salaryf_tb")
    salaryf_tb:setText("Salary")
    salaryf_tb.PosRel, salaryf_tb.Len = grid:getPosLenWithMargin(1, 5, 1, 1, 1,
                                                                 1, 1, 0)
    self:salaryf_tb_style(salaryf_tb)
    self.salaryf_tb = salaryf_tb

    --- account salary TextBlock
    local salary_tb = JLib.TextBlock:new(self.rootScreenCanvas,
                                         self.attachingScreen, "salaty_tb")
    salary_tb.PosRel, salary_tb.Len = grid:getPosLenWithMargin(2, 5, 1, 1, 1, 1,
                                                               1, 0)
    salary_tb:setText("")
    self:salary_tb_style(salary_tb)
    self.salary_tb = salary_tb

    --- account working hour fixed TextBlock
    local whf_tb = JLib.TextBlock:new(self.rootScreenCanvas,
                                      self.attachingScreen, "whf_tb")
    whf_tb.PosRel, whf_tb.Len = grid:getPosLenWithMargin(1, 6, 1, 1, 1, 1, 1, 0)
    whf_tb:setText("WorkedH")
    self:whf_tb_style(whf_tb)
    self.whf_tb = whf_tb

    --- account working hour TextBlock
    local wh_tb = JLib.TextBlock:new(self.rootScreenCanvas,
                                     self.attachingScreen, "wh_tb")
    wh_tb.PosRel, wh_tb.Len = grid:getPosLenWithMargin(2, 6, 1, 1, 1, 1, 1, 0)
    wh_tb:setText("")
    self:wh_tb_style(wh_tb)
    self.wh_tb = wh_tb

    --- refresh button
    local refresh_bt = JLib.Button:new(self.rootScreenCanvas,
                                       self.attachingScreen, "refresh_bt")
    refresh_bt:setText("Refresh")
    refresh_bt.PosRel, refresh_bt.Len = grid_buttom:getPosLenWithMargin(2, 1, 1,
                                                                        1, 0, 0,
                                                                        0, 0)
    self:refresh_bt_style(refresh_bt)
    self.refresh_bt = refresh_bt

    --- back Button
    local back_bt = JLib.Button:new(self.rootScreenCanvas, self.attachingScreen,
                                    "back_bt")
    back_bt:setText("Back")
    back_bt.PosRel, back_bt.Len = grid_buttom:getPosLenWithMargin(1, 1, 1, 1, 0,
                                                                  1, 0, 0)
    self:back_bt_style(back_bt)
    self.back_bt = back_bt

end

--- properties description
---@class BankProj.profileScene : UIScene
---@field PROJ BankProj
---@field new fun(self:BankProj.profileScene, attachedScreen:Screen, ProjTemplatespace: BankProj):BankProj.profileScene

---@param tb TextBlock
function SCENE:title_tb_style(tb)
    tb:setBackgroundColor(JLib.Enums.Color.lightBlue)
    tb:setTextColor(JLib.Enums.Color.white)
    tb:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.center)
    tb:setTextVerticalAlignment(JLib.Enums.VerticalAlignmentMode.center)
    tb:setIsTextEditable(false)
end

---@param tb TextBlock
function SCENE:msg_tb_style(tb)
    tb:setBackgroundColor(JLib.Enums.Color.lime)
    tb:setTextColor(JLib.Enums.Color.white)
    tb:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.center)
    tb:setTextVerticalAlignment(JLib.Enums.VerticalAlignmentMode.center)
    tb:setIsTextEditable(false)
end

---@param tb TextBlock
function SCENE:ownerf_tb_style(tb)
    tb:setBackgroundColor(JLib.Enums.Color.purple)
    tb:setTextColor(JLib.Enums.Color.white)
    tb:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.center)
    tb:setTextVerticalAlignment(JLib.Enums.VerticalAlignmentMode.center)
    tb:setIsTextEditable(false)
end

---@param tb TextBlock
function SCENE:owner_tb_style(tb)
    tb:setBackgroundColor(JLib.Enums.Color.purple)
    tb:setTextColor(JLib.Enums.Color.white)
    tb:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.center)
    tb:setTextVerticalAlignment(JLib.Enums.VerticalAlignmentMode.center)
    tb:setIsTextEditable(false)
end

---@param tb TextBlock
function SCENE:balancef_tb_style(tb)
    tb:setBackgroundColor(JLib.Enums.Color.purple)
    tb:setTextColor(JLib.Enums.Color.white)
    tb:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.center)
    tb:setTextVerticalAlignment(JLib.Enums.VerticalAlignmentMode.center)
    tb:setIsTextEditable(false)
end

---@param tb TextBlock
function SCENE:balance_tb_style(tb)
    tb:setBackgroundColor(JLib.Enums.Color.purple)
    tb:setTextColor(JLib.Enums.Color.white)
    tb:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.center)
    tb:setTextVerticalAlignment(JLib.Enums.VerticalAlignmentMode.center)
    tb:setIsTextEditable(false)
end

---@param tb TextBlock
function SCENE:salaryf_tb_style(tb)
    tb:setBackgroundColor(JLib.Enums.Color.purple)
    tb:setTextColor(JLib.Enums.Color.white)
    tb:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.center)
    tb:setTextVerticalAlignment(JLib.Enums.VerticalAlignmentMode.center)
    tb:setIsTextEditable(false)
end

---@param tb TextBlock
function SCENE:salary_tb_style(tb)
    tb:setBackgroundColor(JLib.Enums.Color.purple)
    tb:setTextColor(JLib.Enums.Color.white)
    tb:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.center)
    tb:setTextVerticalAlignment(JLib.Enums.VerticalAlignmentMode.center)
    tb:setIsTextEditable(false)
end

---@param tb TextBlock
function SCENE:whf_tb_style(tb)
    tb:setBackgroundColor(JLib.Enums.Color.purple)
    tb:setTextColor(JLib.Enums.Color.white)
    tb:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.center)
    tb:setTextVerticalAlignment(JLib.Enums.VerticalAlignmentMode.center)
    tb:setIsTextEditable(false)
end

---@param tb TextBlock
function SCENE:wh_tb_style(tb)
    tb:setBackgroundColor(JLib.Enums.Color.purple)
    tb:setTextColor(JLib.Enums.Color.white)
    tb:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.center)
    tb:setTextVerticalAlignment(JLib.Enums.VerticalAlignmentMode.center)
    tb:setIsTextEditable(false)
end

---@param bt Button
function SCENE:refresh_bt_style(bt)
    bt:setTextVerticalAlignment(JLib.Enums.VerticalAlignmentMode.center)
    bt:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.center)
    bt.ClickEvent = function() self:refresh_bt_clickEvent() end
end

function SCENE:refresh_bt_clickEvent()
    -- print("aaaa2")
    local msgstruct = JLib.BankDB.MsgStruct.GETACCOUNT:new()
    msgstruct.Username = self.PROJ.BioScanScene.current_Player
    msgstruct.IDToSendBack = self.PROJ.Param.myID
    local msg = JLib.BankDB.Message:new(JLib.BankDB.Headers.GETACCOUNT,
                                        msgstruct:Serialize())

    rednet.send(self.PROJ.Param.BankServerID, msg:Serialize(),
                JLib.BankDB.Consts.masterPort)

end

---@param bt Button
function SCENE:back_bt_style(bt)
    bt:setTextVerticalAlignment(JLib.Enums.VerticalAlignmentMode.center)
    bt:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.center)
    bt.ClickEvent = function() self:back_bt_clickEvent() end
end

function SCENE:back_bt_clickEvent()
    self:unlink_rednet_event()
    self.PROJ.UIRunner:changeScene(self.PROJ.BankingMenuScene)
end

---@param str string
function SCENE:setOwnerName(str) self.owner_tb:setText(str) end

function SCENE:link_rednet_event()
    self.PROJ.EventRouter:attachRednetCallback(JLib.BankDB.Consts.masterPort,
                                               function(a, b, c, d)
        self:bank_callback(a, b, c, d)
    end)
end

function SCENE:unlink_rednet_event()
    self.PROJ.EventRouter:removeRednetEventCallBack(JLib.BankDB.Consts
                                                        .masterPort)
end

function SCENE:clearTextBlocks()
    self.msg_tb:setText("Press Refresh Button")
    self.salary_tb:setText("")
    self.balance_tb:setText("")
    self.wh_tb:setText("")
end

function SCENE:bank_callback(a, b, c, d)
    -- print(a, b, c, d)
    if (b == self.PROJ.Param.BankServerID) then
        local msg = JLib.BankDB.Message:Deserialize(c)
        if (msg.Header == JLib.BankDB.Headers.ACK_GETACCOUNT) then
            local msgstruct = JLib.BankDB.MsgStruct.ACK_GETACCOUNT:Deserialize(
                                  msg.SerializedMsgStruct)

            if (msgstruct.Success == true) then
                self.balance_tb:setText(tostring(msgstruct.Account.Balance))
                self.salary_tb:setText(tostring(msgstruct.Account.Salary))
                self.wh_tb:setText(tostring(msgstruct.Account.WorkingHour))
            end

            self.msg_tb:setText(JLib.BankDB.MsgStruct.ACK_GETACCOUNT
                                    .eStateReverse[msgstruct.State])

            self.PROJ.UIRunner:RenderScreen()
        end
    end
end

return SCENE
