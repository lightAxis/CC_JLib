local class = require("Class.middleclass")

---@class BankProj.sendingScene : UIScene
local SCENE = class("BankProj.sendingScene")

---constructor
---@param attachedScreen Screen
---@param ProjTemplatespace BankProj
function SCENE:initialize(attachedScreen, ProjTemplatespace)
    JLib.UIScene.initialize(self, attachedScreen, ProjTemplatespace)

    local grid = JLib.Grid:new(self.rootScreenCanvas.Len)
    grid:setHorizontalSetting({"*", "1", "*"})
    grid:setVerticalSetting({"1", "1", "*", "1"})
    grid:updatePosLen()

    local grid_bt_pos, grid_bt_len = grid:getPosLenWithMargin(1, 4, 3, 1, 0, 0,
                                                              0, 0)
    local grid_bt = JLib.Grid:new(grid_bt_len, grid_bt_pos)
    grid_bt:setHorizontalSetting({"*", "*", "*"})
    grid_bt:setVerticalSetting({"*"})
    grid_bt:updatePosLen()

    local grid_aclb_pos, grid_aclb_len =
        grid:getPosLenWithMargin(3, 3, 1, 1, 0, 0, 0, 0)
    local grid_aclb = JLib.Grid:new(grid_aclb_len, grid_aclb_pos)
    grid_aclb:setHorizontalSetting({"*", "1", "3", "1", "*"})
    grid_aclb:setVerticalSetting({"1", "*", "1"})
    grid_aclb:updatePosLen()

    local grid_numpad_pos, grid_numpad_len =
        grid:getPosLenWithMargin(1, 3, 1, 1, 0, 0, 0, 0)
    local grid_numpad = JLib.Grid:new(grid_numpad_len, grid_numpad_pos)
    grid_numpad:setHorizontalSetting({"*", "*", "*", "*", "*"})
    grid_numpad:setVerticalSetting({"1", "1", "1", "1", "1", "1", "1", "1", "*"})
    grid_numpad:updatePosLen()

    --- title textblock
    local title_tb = JLib.TextBlock:new(self.rootScreenCanvas,
                                        self.attachingScreen, "title_tb")
    title_tb.PosRel, title_tb.Len = grid:getPosLenWithMargin(1, 1, 3, 1, 0, 0,
                                                             0, 0)
    title_tb:setText("Sending")
    self:title_tb_style(title_tb)
    self.title_tb = title_tb

    -- system message textblock
    local msg_tb = JLib.TextBlock:new(self.rootScreenCanvas,
                                      self.attachingScreen, "msg_tb")
    msg_tb.PosRel, msg_tb.Len = grid:getPosLenWithMargin(1, 2, 3, 1, 0, 0, 0, 0)
    msg_tb:setText("Press Query Button")
    self:msg_tb_style(msg_tb)
    self.msg_tb = msg_tb

    --- sending textblock
    local sending1_ammount_tb = JLib.TextBlock:new(self.rootScreenCanvas,
                                                   self.attachingScreen,
                                                   "sending1_ammount_tb")
    sending1_ammount_tb.PosRel, sending1_ammount_tb.Len =
        grid_numpad:getPosLenWithMargin(1, 1, 5, 1, 0, 0, 0, 0)
    sending1_ammount_tb:setText("Sending Amount")
    self:sending_amount_tb_style(sending1_ammount_tb)
    self.sending1_ammount_tb = sending1_ammount_tb

    --- sending textblock2
    local sending2_ammount_tb = JLib.TextBlock:new(self.rootScreenCanvas,
                                                   self.attachingScreen,
                                                   "sending2_ammount_tb")
    sending2_ammount_tb.PosRel, sending2_ammount_tb.Len =
        grid_numpad:getPosLenWithMargin(1, 2, 5, 1, 0, 0, 0, 0)
    sending2_ammount_tb:setText("")
    self:sending_amount_tb_style(sending2_ammount_tb)
    self.sending2_ammount_tb = sending2_ammount_tb

    --- numpad buttons
    local numpad_bt_1 = JLib.Button:new(self.rootScreenCanvas,
                                        self.attachingScreen, "numpad_bt_1")
    local numpad_bt_2 = JLib.Button:new(self.rootScreenCanvas,
                                        self.attachingScreen, "numpad_bt_2")
    local numpad_bt_3 = JLib.Button:new(self.rootScreenCanvas,
                                        self.attachingScreen, "numpad_bt_3")
    local numpad_bt_4 = JLib.Button:new(self.rootScreenCanvas,
                                        self.attachingScreen, "numpad_bt_4")
    local numpad_bt_5 = JLib.Button:new(self.rootScreenCanvas,
                                        self.attachingScreen, "numpad_bt_5")
    local numpad_bt_6 = JLib.Button:new(self.rootScreenCanvas,
                                        self.attachingScreen, "numpad_bt_6")
    local numpad_bt_7 = JLib.Button:new(self.rootScreenCanvas,
                                        self.attachingScreen, "numpad_bt_7")
    local numpad_bt_8 = JLib.Button:new(self.rootScreenCanvas,
                                        self.attachingScreen, "numpad_bt_8")
    local numpad_bt_9 = JLib.Button:new(self.rootScreenCanvas,
                                        self.attachingScreen, "numpad_bt_9")
    local numpad_bt_0 = JLib.Button:new(self.rootScreenCanvas,
                                        self.attachingScreen, "numpad_bt_0")
    numpad_bt_1.PosRel, numpad_bt_1.Len =
        grid_numpad:getPosLenWithMargin(1, 4, 1, 1, 0, 1, 0, 0)
    numpad_bt_2.PosRel, numpad_bt_2.Len =
        grid_numpad:getPosLenWithMargin(2, 4, 1, 1, 0, 1, 0, 0)
    numpad_bt_3.PosRel, numpad_bt_3.Len =
        grid_numpad:getPosLenWithMargin(3, 4, 1, 1, 0, 1, 0, 0)
    numpad_bt_4.PosRel, numpad_bt_4.Len =
        grid_numpad:getPosLenWithMargin(4, 4, 1, 1, 0, 1, 0, 0)
    numpad_bt_5.PosRel, numpad_bt_5.Len =
        grid_numpad:getPosLenWithMargin(5, 4, 1, 1, 0, 1, 0, 0)
    numpad_bt_6.PosRel, numpad_bt_6.Len =
        grid_numpad:getPosLenWithMargin(1, 6, 1, 1, 0, 1, 0, 0)
    numpad_bt_7.PosRel, numpad_bt_7.Len =
        grid_numpad:getPosLenWithMargin(2, 6, 1, 1, 0, 1, 0, 0)
    numpad_bt_8.PosRel, numpad_bt_8.Len =
        grid_numpad:getPosLenWithMargin(3, 6, 1, 1, 0, 1, 0, 0)
    numpad_bt_9.PosRel, numpad_bt_9.Len =
        grid_numpad:getPosLenWithMargin(4, 6, 1, 1, 0, 1, 0, 0)
    numpad_bt_0.PosRel, numpad_bt_0.Len =
        grid_numpad:getPosLenWithMargin(5, 6, 1, 1, 0, 1, 0, 0)
    numpad_bt_1:setText("1")
    numpad_bt_2:setText("2")
    numpad_bt_3:setText("3")
    numpad_bt_4:setText("4")
    numpad_bt_5:setText("5")
    numpad_bt_6:setText("6")
    numpad_bt_7:setText("7")
    numpad_bt_8:setText("8")
    numpad_bt_9:setText("9")
    numpad_bt_0:setText("0")
    self:numpad_bt_style(numpad_bt_1, 1)
    self:numpad_bt_style(numpad_bt_2, 2)
    self:numpad_bt_style(numpad_bt_3, 3)
    self:numpad_bt_style(numpad_bt_4, 4)
    self:numpad_bt_style(numpad_bt_5, 5)
    self:numpad_bt_style(numpad_bt_6, 6)
    self:numpad_bt_style(numpad_bt_7, 7)
    self:numpad_bt_style(numpad_bt_8, 8)
    self:numpad_bt_style(numpad_bt_9, 9)
    self:numpad_bt_style(numpad_bt_0, 0)
    self.numpad_bt_1 = numpad_bt_1
    self.numpad_bt_2 = numpad_bt_2
    self.numpad_bt_3 = numpad_bt_3
    self.numpad_bt_4 = numpad_bt_4
    self.numpad_bt_5 = numpad_bt_5
    self.numpad_bt_6 = numpad_bt_6
    self.numpad_bt_7 = numpad_bt_7
    self.numpad_bt_8 = numpad_bt_8
    self.numpad_bt_9 = numpad_bt_9
    self.numpad_bt_0 = numpad_bt_0

    --- sending amount reset button
    local sending_amount_reset_bt = JLib.Button:new(self.rootScreenCanvas,
                                                    self.attachingScreen,
                                                    "sending_amount_reset_bt")
    sending_amount_reset_bt.PosRel, sending_amount_reset_bt.Len =
        grid_numpad:getPosLenWithMargin(2, 8, 3, 1, 0, 0, 0, 0)
    sending_amount_reset_bt:setText("Reset")
    self:sending_amount_reset_bt_style(sending_amount_reset_bt)
    self.sending_amount_reset_bt = sending_amount_reset_bt

    -- account name textblock
    local account_tb = JLib.TextBlock:new(self.rootScreenCanvas,
                                          self.attachingScreen, "account_tb ")
    account_tb.PosRel, account_tb.Len = grid_aclb:getPosLenWithMargin(1, 1, 5,
                                                                      1, 0, 0,
                                                                      0, 0)
    account_tb:setText("Send To")
    self:account_tb_style(account_tb)
    self.account_tb = account_tb

    --- account list listbox
    local accounts_lb = JLib.ListBox:new(self.rootScreenCanvas,
                                         self.attachingScreen, "accounts_lb")
    accounts_lb.PosRel, accounts_lb.Len =
        grid_aclb:getPosLenWithMargin(1, 2, 5, 1, 0, 0, 0, 0)
    accounts_lb:setItemTemplate(function(obj) return obj end)
    -- local temppp = {
    --     "test1", "test2", "test3", "test4", "test5", "test6", "test7", "test8",
    --     "test9", "test10", "test11", "test12"
    -- }
    -- accounts_lb:setItemSource(temppp)
    self:accounts_lb_style(accounts_lb)
    accounts_lb:Refresh()
    self.accounts_lb = accounts_lb

    --- accounts list leftscrol button
    local accounts_lb_left_bt = JLib.Button:new(self.rootScreenCanvas,
                                                self.attachingScreen,
                                                "ccounts_lb_left_bt")
    accounts_lb_left_bt.PosRel, accounts_lb_left_bt.Len =
        grid_aclb:getPosLenWithMargin(2, 3, 1, 1, 0, 0, 0, 0)
    accounts_lb_left_bt:setText("<")
    self:accounts_lb_left_bt_style(accounts_lb_left_bt)
    self.accounts_lb_left_bt = accounts_lb_left_bt

    --- accounts list leftscrol button
    local accounts_lb_right_bt = JLib.Button:new(self.rootScreenCanvas,
                                                 self.attachingScreen,
                                                 "ccounts_lb_right_bt")
    accounts_lb_right_bt.PosRel, accounts_lb_right_bt.Len =
        grid_aclb:getPosLenWithMargin(4, 3, 1, 1, 0, 0, 0, 0)
    accounts_lb_right_bt:setText(">")
    self:accounts_lb_right_bt_style(accounts_lb_right_bt)
    self.accounts_lb_right_bt = accounts_lb_right_bt

    -- back button
    local back_bt = JLib.Button:new(self.rootScreenCanvas, self.attachingScreen,
                                    "back_bt")
    back_bt.PosRel, back_bt.Len = grid_bt:getPosLenWithMargin(1, 1, 1, 1, 0, 1,
                                                              0, 0)
    back_bt:setText("Back")
    self:back_bt_style(back_bt)
    self.back_bt = back_bt

    -- query button
    local query_bt = JLib.Button:new(self.rootScreenCanvas,
                                     self.attachingScreen, "query_bt")
    query_bt.PosRel, query_bt.Len = grid_bt:getPosLenWithMargin(2, 1, 1, 1, 0,
                                                                0, 0, 0)
    query_bt:setText("Query")
    self:query_bt_style(query_bt)
    self.query_bt = query_bt

    -- send button
    local send_bt = JLib.Button:new(self.rootScreenCanvas, self.attachingScreen,
                                    "send_bt")
    send_bt.PosRel, send_bt.Len = grid_bt:getPosLenWithMargin(3, 1, 1, 1, 1, 0,
                                                              0, 0)
    send_bt:setText("Send")
    self:send_bt_style(send_bt)
    self.send_bt = send_bt

end

--- properties description
---@class BankProj.sendingScene : UIScene
---@field PROJ BankProj
---@field new fun(self:BankProj.sendingScene, attachedScreen:Screen, ProjTemplatespace: BankProj):BankProj.sendingScene

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
function SCENE:sending_amount_tb_style(tb)
    tb:setBackgroundColor(JLib.Enums.Color.purple)
    tb:setTextColor(JLib.Enums.Color.white)
    tb:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.right)
    tb:setTextVerticalAlignment(JLib.Enums.VerticalAlignmentMode.center)
    tb:setIsTextEditable(false)
end

---@param bt Button
---@param num number 0~9
function SCENE:numpad_bt_style(bt, num)
    bt:setTextVerticalAlignment(JLib.Enums.VerticalAlignmentMode.center)
    bt:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.center)
    bt.ClickEvent = function(bt) self:numpad_bt_clickEvent(bt) end
end

---@param bt Button
function SCENE:numpad_bt_clickEvent(bt)
    ---@type string
    local number = bt.Name
    number = string.sub(number, #number, #number)
    -- print(number)
    self:_add_number_to_send_amount(number)
end

---@param bt  Button
function SCENE:sending_amount_reset_bt_style(bt)
    bt:setTextVerticalAlignment(JLib.Enums.VerticalAlignmentMode.center)
    bt:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.center)
    bt.ClickEvent = function() self:sending_amount_reset_bt_clickEvent() end
end

function SCENE:sending_amount_reset_bt_clickEvent()
    self.sending2_ammount_tb:setText("")
end

---@param numstr string
function SCENE:_add_number_to_send_amount(numstr)
    local maxlen = self.sending2_ammount_tb.Len.x
    local curstr = self.sending2_ammount_tb:getText()

    if (maxlen > #curstr) then
        curstr = curstr .. numstr
        self.sending2_ammount_tb:setText(curstr)
    end
end

---@param lb ListBox
function SCENE:accounts_lb_style(lb) end

function SCENE:account_tb_style(tb)
    tb:setBackgroundColor(JLib.Enums.Color.purple)
    tb:setTextColor(JLib.Enums.Color.white)
    tb:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.center)
    tb:setTextVerticalAlignment(JLib.Enums.VerticalAlignmentMode.center)
    tb:setIsTextEditable(false)
end

---@param bt Button
function SCENE:accounts_lb_left_bt_style(bt)
    bt:setTextVerticalAlignment(JLib.Enums.VerticalAlignmentMode.center)
    bt:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.center)
    bt.ClickEvent = function() self:accounts_lb_left_bt_clickEvent() end
end

function SCENE:accounts_lb_left_bt_clickEvent() self:_scroll_accounts_lb(-1) end

---@param bt Button
function SCENE:accounts_lb_right_bt_style(bt)
    bt:setTextVerticalAlignment(JLib.Enums.VerticalAlignmentMode.center)
    bt:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.center)
    bt.ClickEvent = function() self:accounts_lb_right_bt_clickEvent() end
end

function SCENE:accounts_lb_right_bt_clickEvent() self:_scroll_accounts_lb(1) end

function SCENE:_scroll_accounts_lb(diff)
    local scroll = self.accounts_lb:getScroll()
    self.accounts_lb:setScroll(scroll + diff)
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

function SCENE:query_bt_style(bt)
    bt:setTextVerticalAlignment(JLib.Enums.VerticalAlignmentMode.center)
    bt:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.center)
    bt.ClickEvent = function() self:query_bt_clickEvent() end
end

function SCENE:query_bt_clickEvent()
    -- print("aaaa3")

    local msgstruct = JLib.BankDB.MsgStruct.GETACCOUNTS:new()
    msgstruct.IDToSendBack = self.PROJ.Param.myID

    local msg = JLib.BankDB.Message:new(JLib.BankDB.Headers.GETACCOUNTS,
                                        msgstruct:Serialize())

    rednet.send(self.PROJ.Param.BankServerID, msg:Serialize(),
                JLib.BankDB.Consts.masterPort)

end

function SCENE:send_bt_style(bt)
    bt:setTextVerticalAlignment(JLib.Enums.VerticalAlignmentMode.center)
    bt:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.center)
    bt.ClickEvent = function() self:send_bt_clickEvent() end
end

function SCENE:send_bt_clickEvent()
    -- print("aaaa4")

    local myName = self.PROJ.BioScanScene.current_Player

    local temp = self.accounts_lb:getSelectedItem()
    -- print(temp)
    if (temp == nil) then
        self.msg_tb:setText("no selected account")
        return
    end
    -- print(temp.obj)
    if (temp.obj == nil) then
        self.msg_tb:setText("no selected account")
        return
    end
    local targetName = temp.obj

    if (myName == targetName) then
        self.msg_tb:setText("sender is reciever")
        return
    end

    local balance = self.sending2_ammount_tb:getText()
    if (balance == "") then
        self.msg_tb:setText("strange sending amount")
        return
    end

    balance = tonumber(balance)

    local msgstruct =
        JLib.BankDB.MsgStruct.SEND:new(myName, targetName, balance)
    msgstruct.FromMsg = targetName
    msgstruct.IDToSendBack = self.PROJ.Param.myID
    msgstruct.ToMsg = myName

    local msg = JLib.BankDB.Message:new(JLib.BankDB.Headers.SEND,
                                        msgstruct:Serialize())

    rednet.send(self.PROJ.Param.BankServerID, msg:Serialize(),
                JLib.BankDB.Consts.masterPort)
end

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

function SCENE:bank_callback(a, b, c, d)
    -- print(a, b, c, d)
    if (b == self.PROJ.Param.BankServerID) then
        local msg = JLib.BankDB.Message:Deserialize(c)
        if (msg.Header == JLib.BankDB.Headers.ACK_GETACCOUNTS) then
            local msgstruct = JLib.BankDB.MsgStruct.ACK_GETACCOUNTS:Deserialize(
                                  msg.SerializedMsgStruct)

            if (msgstruct.Success == true) then
                self.accounts_lb:setItemSource(msgstruct.AccountsList)
                self.accounts_lb:Refresh()
            end

            self.msg_tb:setText(JLib.BankDB.MsgStruct.ACK_GETACCOUNTS
                                    .eStateReverse[msgstruct.State])
            self.PROJ.UIRunner:ClearScreens()
            self.PROJ.UIRunner:RenderScreen()

        elseif (msg.Header == JLib.BankDB.Headers.ACK_SEND) then
            local msgstruct = JLib.BankDB.MsgStruct.ACK_SEND:Deserialize(
                                  msg.SerializedMsgStruct)

            if (msgstruct.Success == true) then end

            self.msg_tb:setText(
                JLib.BankDB.MsgStruct.ACK_SEND.eStateReverse[msgstruct.State])
            self.PROJ.UIRunner:ClearScreens()
            self.PROJ.UIRunner:RenderScreen()

        end
    end

end

function SCENE:clear()
    self.sending2_ammount_tb:setText("")
    self.msg_tb:setText("Press Query Button")
    self.accounts_lb:setItemSource({})
    self.accounts_lb:Refresh()
end

return SCENE
