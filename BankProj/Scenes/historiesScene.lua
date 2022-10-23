local class = require("Class.middleclass")

---@class BankProj.historiesScene : UIScene
local SCENE = class("BankProj.bankingMenuScene")

require("DBs.BankDB.Include")

---constructor
---@param attachedScreen Screen
---@param ProjTemplatespace BankProj
function SCENE:initialize(attachedScreen, ProjTemplatespace)
    JLib.UIScene.initialize(self, attachedScreen, ProjTemplatespace)
    local grid = JLib.Grid:new(self.rootScreenCanvas.Len)
    grid:setHorizontalSetting({"14", "*"})
    grid:setVerticalSetting({"1", "1", "1", "*", "1", "1"})
    grid:updatePosLen()

    local grid_bottom_pos, grid_bottom_len = grid:getPosLen(1, 6, 2, 1)
    local grid_buttom = JLib.Grid:new(grid_bottom_len, grid_bottom_pos)
    grid_buttom:setHorizontalSetting({"*", "*"})
    grid_buttom:setVerticalSetting({"*"})
    grid_buttom:updatePosLen()

    local grid_top_pos, grid_top_len = grid:getPosLen(1, 3, 2, 1)
    local grid_top = JLib.Grid:new(grid_top_len, grid_top_pos)
    grid_top:setHorizontalSetting({"*", "3", "2", "3", "2", "3"})
    grid_top:setVerticalSetting({"*"})
    grid_top:updatePosLen()

    local grid_lb_control_pos, grid_lb_control_len =
        grid:getPosLenWithMargin(1, 5, 1, 1, 0, 0, 0, 0)
    local grid_lb_control = JLib.Grid:new(grid_lb_control_len,
                                          grid_lb_control_pos)
    grid_lb_control:setHorizontalSetting({"*", "1", "3", "1", "*"})
    grid_lb_control:setVerticalSetting({"*"})
    grid_lb_control:updatePosLen()

    local grid_hist_pos, grid_hist_len =
        grid:getPosLenWithMargin(2, 4, 1, 2, 0, 0, 0, 0)
    local grid_hist = JLib.Grid:new(grid_hist_len, grid_hist_pos)
    grid_hist:setHorizontalSetting({"*"})
    grid_hist:setVerticalSetting({"1", "1", "1", "1", "1", "1", "1", "1"})
    grid_hist:updatePosLen()

    --- title
    local title_tb = JLib.TextBlock:new(self.rootScreenCanvas,
                                        self.attachingScreen, "title_tb")
    title_tb:setText("Histories")
    title_tb.PosRel, title_tb.Len = grid:getPosLenWithMargin(1, 1, 2, 1, 0, 0,
                                                             0, 0)
    self:title_tb_style(title_tb)
    self.title_tb = title_tb

    --- msg_textblock
    local msg_tb = JLib.TextBlock:new(self.rootScreenCanvas,
                                      self.attachingScreen, "msg_tb")
    msg_tb:setText("Press Query Button")
    msg_tb.PosRel, msg_tb.Len = grid:getPosLenWithMargin(1, 2, 2, 1, 0, 0, 0, 0)
    self:msg_tb_style(msg_tb)
    self.msg_tb = msg_tb

    -- querycountMsg textblock
    local queryCoMsg_tb = JLib.TextBlock:new(self.rootScreenCanvas,
                                             self.attachingScreen,
                                             "queryCoMsg_tb")
    queryCoMsg_tb:setText("Count to query")
    queryCoMsg_tb.PosRel, queryCoMsg_tb.Len = grid_top:getPosLen(1, 1, 1, 1)
    self:quaeryCo_tb_style(queryCoMsg_tb)
    self.queryCoMsg_tb = queryCoMsg_tb

    --- querycountminus10 button
    local qcountminus10_bt = JLib.Button:new(self.rootScreenCanvas,
                                             self.attachingScreen,
                                             "qcountminus10_bt")
    qcountminus10_bt:setText("<<")
    qcountminus10_bt.PosRel, qcountminus10_bt.Len =
        grid_top:getPosLenWithMargin(2, 1, 1, 1, 0, 1, 0, 0)
    self:qcountminus10_bt_style(qcountminus10_bt)
    self.qcountminus10_bt = qcountminus10_bt

    --- querycountminus1 button
    local qcountminus1_bt = JLib.Button:new(self.rootScreenCanvas,
                                            self.attachingScreen,
                                            "qcountminus1_bt")
    qcountminus1_bt:setText("<")
    qcountminus1_bt.PosRel, qcountminus1_bt.Len =
        grid_top:getPosLenWithMargin(3, 1, 1, 1, 0, 1, 0, 0)
    self:qcountminus1_bt_style(qcountminus1_bt)
    self.qcountminus1_bt = qcountminus1_bt

    --- querycountplus1 button
    local qcountplus1_bt = JLib.Button:new(self.rootScreenCanvas,
                                           self.attachingScreen,
                                           "qcountplus1_bt")
    qcountplus1_bt:setText(">")
    qcountplus1_bt.PosRel, qcountplus1_bt.Len =
        grid_top:getPosLenWithMargin(5, 1, 1, 1, 1, 0, 0, 0)
    self:qcountplus1_bt_style(qcountplus1_bt)
    self.qcountplus1_bt = qcountplus1_bt

    --- querycountplus10 button
    local qcountplus10_bt = JLib.Button:new(self.rootScreenCanvas,
                                            self.attachingScreen,
                                            "qcountplus10_bt")
    qcountplus10_bt:setText(">>")
    qcountplus10_bt.PosRel, qcountplus10_bt.Len =
        grid_top:getPosLenWithMargin(6, 1, 1, 1, 1, 0, 0, 0)
    self:qcountplus10_bt_style(qcountplus10_bt)
    self.qcountplus10_bt = qcountplus10_bt

    --- querycount textblock
    local qcount_tb = JLib.TextBlock:new(self.rootScreenCanvas,
                                         self.attachingScreen, "qcount_tb")
    qcount_tb.PosRel, qcount_tb.Len = grid_top:getPosLen(4, 1, 1, 1)
    qcount_tb:setText("1")
    self:qcount_tb_style(qcount_tb)
    self.qcount_tb = qcount_tb

    --- histories listbox
    local hist_lb = JLib.ListBox:new(self.rootScreenCanvas,
                                     self.attachingScreen, "hist_lb")
    self.hist_lb_source = {}
    hist_lb:setItemSource(self.hist_lb_source)
    hist_lb:setItemTemplate(function(obj) return obj.Name end)
    hist_lb.SelectedIndexChanged = function(obj)
        self:hist_lb_selectionChanged(obj)
    end
    hist_lb.PosRel, hist_lb.Len = grid:getPosLenWithMargin(1, 4, 1, 1, 0, 0, 0,
                                                           0)
    self:hist_lb_style(hist_lb)
    self.hist_lb = hist_lb

    --- histories minuspage Button
    local histpageminus1_bt = JLib.Button:new(self.rootScreenCanvas,
                                              self.attachingScreen,
                                              "histpageminus1_bt")
    histpageminus1_bt:setText("<")
    histpageminus1_bt.PosRel, histpageminus1_bt.Len =
        grid_lb_control:getPosLenWithMargin(2, 1, 1, 1, 0, 0, 0, 0)
    self:histpageminus1_bt_style(histpageminus1_bt)
    self.histpageminus1_bt = histpageminus1_bt

    --- histories pluspage Button
    local histpageplus1_bt = JLib.Button:new(self.rootScreenCanvas,
                                             self.attachingScreen,
                                             "histpageplus1_bt")
    histpageplus1_bt:setText(">")
    histpageplus1_bt.PosRel, histpageplus1_bt.Len =
        grid_lb_control:getPosLenWithMargin(4, 1, 1, 1, 0, 0, 0, 0)
    self:histpageplus1_bt_style(histpageplus1_bt)
    self.histpageplus1_bt = histpageplus1_bt

    --- history datatime textblock 1
    local histDateTime_tb1 = JLib.TextBlock:new(self.rootScreenCanvas,
                                                self.attachingScreen,
                                                "histDateTime_tb1")
    histDateTime_tb1.PosRel, histDateTime_tb1.Len =
        grid_hist:getPosLenWithMargin(1, 1, 1, 1, 1, 0, 0, 0)
    histDateTime_tb1:setText("")
    self:histDateTime_tb1_style(histDateTime_tb1)
    self.histDateTime_tb1 = histDateTime_tb1

    --- history datatime textblock 2
    local histDateTime_tb2 = JLib.TextBlock:new(self.rootScreenCanvas,
                                                self.attachingScreen,
                                                "histDateTime_tb2")
    histDateTime_tb2.PosRel, histDateTime_tb2.Len =
        grid_hist:getPosLenWithMargin(1, 2, 1, 1, 1, 0, 0, 0)
    histDateTime_tb2:setText("")
    self:histDateTime_tb2_style(histDateTime_tb2)
    self.histDateTime_tb2 = histDateTime_tb2

    --- history name fixed textblock
    local histnamef_tb = JLib.TextBlock:new(self.rootScreenCanvas,
                                            self.attachingScreen, "histnamef_tb")
    histnamef_tb.PosRel, histnamef_tb.Len =
        grid_hist:getPosLenWithMargin(1, 3, 1, 1, 1, 0, 0, 0)
    histnamef_tb:setText("Name")
    self:histnamef_tb_style(histnamef_tb)
    self.histnamef_tb = histnamef_tb

    --- history name textblock
    local histname_tb = JLib.TextBlock:new(self.rootScreenCanvas,
                                           self.attachingScreen, "histname_tb")
    histname_tb.PosRel, histname_tb.Len =
        grid_hist:getPosLenWithMargin(1, 4, 1, 1, 1, 0, 0, 0)
    histname_tb:setText("")
    self:histname_tb_style(histname_tb)
    self.histname_tb = histname_tb

    --- history inout fixed textblock
    local histinoutf_tb = JLib.TextBlock:new(self.rootScreenCanvas,
                                             self.attachingScreen,
                                             "histinoutf_tb")
    histinoutf_tb.PosRel, histinoutf_tb.Len =
        grid_hist:getPosLenWithMargin(1, 5, 1, 1, 1, 0, 0, 0)
    histinoutf_tb:setText("In&Out")
    self:histinoutf_tb_style(histinoutf_tb)
    self.histinoutf_tb = histinoutf_tb

    --- history inout textblock
    local histinout_tb = JLib.TextBlock:new(self.rootScreenCanvas,
                                            self.attachingScreen, "histinout_tb")
    histinout_tb.PosRel, histinout_tb.Len =
        grid_hist:getPosLenWithMargin(1, 6, 1, 1, 1, 0, 0, 0)
    histinout_tb:setText("")
    self:histinout_tb_style(histinout_tb)
    self.histinout_tb = histinout_tb

    --- history balanceleft fixed textblock
    local histbalanceleftf_tb = JLib.TextBlock:new(self.rootScreenCanvas,
                                                   self.attachingScreen,
                                                   "histbalanceleftf_tb")
    histbalanceleftf_tb.PosRel, histbalanceleftf_tb.Len =
        grid_hist:getPosLenWithMargin(1, 7, 1, 1, 1, 0, 0, 0)
    histbalanceleftf_tb:setText("Balance Left")
    self:histbalanceleftf_tb_style(histbalanceleftf_tb)
    self.histbalanceleftf_tb = histbalanceleftf_tb

    --- history balanceleft textblock
    local histbalanceleft_tb = JLib.TextBlock:new(self.rootScreenCanvas,
                                                  self.attachingScreen,
                                                  "histinout_tb")
    histbalanceleft_tb.PosRel, histbalanceleft_tb.Len =
        grid_hist:getPosLenWithMargin(1, 8, 1, 1, 1, 0, 0, 0)
    histbalanceleft_tb:setText("")
    self:histbalanceleft_tb_style(histbalanceleft_tb)
    self.histbalanceleft_tb = histbalanceleft_tb

    --- query button
    local query_bt = JLib.Button:new(self.rootScreenCanvas,
                                     self.attachingScreen, "query_bt")
    query_bt:setText("Query")
    query_bt.PosRel, query_bt.Len = grid_buttom:getPosLenWithMargin(2, 1, 1, 1,
                                                                    0, 0, 0, 0)
    self:query_bt_style(query_bt)
    self.query_bt = query_bt

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
---@class BankProj.historiesScene : UIScene
---@field PROJ BankProj
---@field new fun(self:BankProj.historiesScene, attachedScreen:Screen, ProjTemplatespace: BankProj):BankProj.historiesScene

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
function SCENE:quaeryCo_tb_style(tb)
    tb:setBackgroundColor(JLib.Enums.Color.purple)
    tb:setTextColor(JLib.Enums.Color.white)
    tb:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.center)
    tb:setTextVerticalAlignment(JLib.Enums.VerticalAlignmentMode.center)
    tb:setIsTextEditable(false)
end

---@param bt Button
function SCENE:qcountminus10_bt_style(bt)
    bt:setTextVerticalAlignment(JLib.Enums.VerticalAlignmentMode.center)
    bt:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.center)
    bt.ClickEvent = function() self:qcountminus10_bt_clickEvent() end
end

function SCENE:qcountminus10_bt_clickEvent()
    self:_modify_query_count(-10)
    self.PROJ.UIRunner:RenderScreen()
end

---@param bt Button
function SCENE:qcountminus1_bt_style(bt)
    bt:setTextVerticalAlignment(JLib.Enums.VerticalAlignmentMode.center)
    bt:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.center)
    bt.ClickEvent = function() self:qcountminus1_bt_clickEvent() end
end

function SCENE:qcountminus1_bt_clickEvent()
    self:_modify_query_count(-1)
    self.PROJ.UIRunner:RenderScreen()
end

---@param bt Button
function SCENE:qcountplus10_bt_style(bt)
    bt:setTextVerticalAlignment(JLib.Enums.VerticalAlignmentMode.center)
    bt:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.center)
    bt.ClickEvent = function() self:qcountplus10_bt_clickEvent() end
end

function SCENE:qcountplus10_bt_clickEvent()
    self:_modify_query_count(10)
    self.PROJ.UIRunner:RenderScreen()
end

---@param bt Button
function SCENE:qcountplus1_bt_style(bt)
    bt:setTextVerticalAlignment(JLib.Enums.VerticalAlignmentMode.center)
    bt:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.center)
    bt.ClickEvent = function() self:qcountplus1_bt_clickEvent() end
end

function SCENE:qcountplus1_bt_clickEvent()
    self:_modify_query_count(1)
    self.PROJ.UIRunner:RenderScreen()
end

---@param tb TextBlock
function SCENE:qcount_tb_style(tb)
    tb:setBackgroundColor(JLib.Enums.Color.purple)
    tb:setTextColor(JLib.Enums.Color.white)
    tb:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.center)
    tb:setTextVerticalAlignment(JLib.Enums.VerticalAlignmentMode.center)
    tb:setIsTextEditable(false)
end

---change query count
---@param diff number
---@return number resultCount
function SCENE:_modify_query_count(diff)
    local number = tonumber(self.qcount_tb:getText())
    number = math.max(1, number + diff)
    number = math.min(number, 999)
    self.qcount_tb:setText(tostring(number))
    return number
end

---get query count
---@return number queryCount
function SCENE:_get_query_count() return tonumber(self.qcount_tb:getText()) end

---@param bt Button
function SCENE:query_bt_style(bt)
    bt:setTextVerticalAlignment(JLib.Enums.VerticalAlignmentMode.center)
    bt:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.center)
    bt.ClickEvent = function() self:query_bt_clickEvent() end
end

function SCENE:query_bt_clickEvent()
    local msgstruct = JLib.BankDB.MsgStruct.GETHISTORY:new()
    msgstruct.Username = self.PROJ.BioScanScene.current_Player
    msgstruct.Count = self:_get_query_count()
    msgstruct.IDToSendBack = self.PROJ.Param.myID

    local msg = JLib.BankDB.Message:new(JLib.BankDB.Headers.GETHISTORY,
                                        msgstruct:Serialize())
    rednet.send(self.PROJ.Param.BankServerID, msg:Serialize(),
                JLib.BankDB.Consts.masterPort)
end

---@param obj ListBoxItem
function SCENE:hist_lb_selectionChanged(obj)

    ---@type BankDB.Table_t.History
    local struct = obj.obj
    print("----")
    print("daytime:" .. struct.DayTime.Realtime)
    print("balaceleft:" .. struct.BalanceLeft)
    print("inout:" .. struct.Inout)
    print("name:" .. struct.Name)
    print("----")

    self:_show_histDetails()
    self:_fillHistoryContent(struct)
end

---@param bt Button
function SCENE:histpageminus1_bt_style(bt)
    bt:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.center)
    bt:setTextVerticalAlignment(JLib.Enums.VerticalAlignmentMode.center)
    bt:setIsTextEditable(false)
    bt.ClickEvent = function() self:histpageminus1_bt_clickEvent() end
end

function SCENE:histpageminus1_bt_clickEvent() self:_modify_hist_page(-1) end

---@param bt Button
function SCENE:histpageplus1_bt_style(bt)
    bt:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.center)
    bt:setTextVerticalAlignment(JLib.Enums.VerticalAlignmentMode.center)
    bt:setIsTextEditable(false)
    bt.ClickEvent = function() self:histpageplus1_bt_clickEvent() end
end

function SCENE:histpageplus1_bt_clickEvent() self:_modify_hist_page(1) end

---@param tb TextBlock
function SCENE:histDateTime_tb1_style(tb)
    tb:setBackgroundColor(JLib.Enums.Color.green)
    tb:setTextColor(JLib.Enums.Color.white)
    tb:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.center)
    tb:setTextVerticalAlignment(JLib.Enums.VerticalAlignmentMode.center)
    tb:setIsTextEditable(false)
    tb.Visible = false
end

---@param tb TextBlock
function SCENE:histDateTime_tb2_style(tb)
    tb:setBackgroundColor(JLib.Enums.Color.green)
    tb:setTextColor(JLib.Enums.Color.white)
    tb:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.center)
    tb:setTextVerticalAlignment(JLib.Enums.VerticalAlignmentMode.center)
    tb:setIsTextEditable(false)
    tb.Visible = false
end

---@param tb TextBlock
function SCENE:histnamef_tb_style(tb)
    tb:setBackgroundColor(JLib.Enums.Color.lime)
    tb:setTextColor(JLib.Enums.Color.white)
    tb:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.left)
    tb:setTextVerticalAlignment(JLib.Enums.VerticalAlignmentMode.center)
    tb:setIsTextEditable(false)
    tb.Visible = false
end
---@param tb TextBlock
function SCENE:histname_tb_style(tb)
    tb:setBackgroundColor(JLib.Enums.Color.lime)
    tb:setTextColor(JLib.Enums.Color.white)
    tb:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.center)
    tb:setTextVerticalAlignment(JLib.Enums.VerticalAlignmentMode.center)
    tb:setIsTextEditable(false)
    tb.Visible = false
end

---@param tb TextBlock
function SCENE:histinoutf_tb_style(tb)
    tb:setBackgroundColor(JLib.Enums.Color.green)
    tb:setTextColor(JLib.Enums.Color.white)
    tb:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.left)
    tb:setTextVerticalAlignment(JLib.Enums.VerticalAlignmentMode.center)
    tb:setIsTextEditable(false)
    tb.Visible = false
end
---@param tb TextBlock
function SCENE:histinout_tb_style(tb)
    tb:setBackgroundColor(JLib.Enums.Color.green)
    tb:setTextColor(JLib.Enums.Color.white)
    tb:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.center)
    tb:setTextVerticalAlignment(JLib.Enums.VerticalAlignmentMode.center)
    tb:setIsTextEditable(false)
    tb.Visible = false
end

---@param tb TextBlock
function SCENE:histbalanceleftf_tb_style(tb)
    tb:setBackgroundColor(JLib.Enums.Color.lime)
    tb:setTextColor(JLib.Enums.Color.white)
    tb:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.left)
    tb:setTextVerticalAlignment(JLib.Enums.VerticalAlignmentMode.center)
    tb:setIsTextEditable(false)
    tb.Visible = false
end
---@param tb TextBlock
function SCENE:histbalanceleft_tb_style(tb)
    tb:setBackgroundColor(JLib.Enums.Color.lime)
    tb:setTextColor(JLib.Enums.Color.white)
    tb:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.center)
    tb:setTextVerticalAlignment(JLib.Enums.VerticalAlignmentMode.center)
    tb:setIsTextEditable(false)
    tb.Visible = false
end

function SCENE:_show_histDetails()
    self.histDateTime_tb1.Visible = true
    self.histDateTime_tb2.Visible = true
    self.histname_tb.Visible = true
    self.histnamef_tb.Visible = true
    self.histinoutf_tb.Visible = true
    self.histinout_tb.Visible = true
    self.histbalanceleftf_tb.Visible = true
    self.histbalanceleft_tb.Visible = true
end

function SCENE:_hide_histDetails()
    self.histDateTime_tb1.Visible = false
    self.histDateTime_tb2.Visible = false
    self.histname_tb.Visible = false
    self.histnamef_tb.Visible = false
    self.histinoutf_tb.Visible = false
    self.histinout_tb.Visible = false
    self.histbalanceleftf_tb.Visible = false
    self.histbalanceleft_tb.Visible = false
end

---fill historiy to content string
---@param history BankDB.Table_t.History
function SCENE:_fillHistoryContent(history)
    local data = history.DayTime.Realtime
    local data1 = data:sub(#data - 12, #data)
    local data2 = data:sub(1, #data - 14)

    self.histDateTime_tb1:setText(data1)
    self.histDateTime_tb2:setText(data2)

    self.histname_tb:setText(history.Name)
    self.histinout_tb:setText(tostring(history.Inout))
    self.histbalanceleft_tb:setText(tostring(history.BalanceLeft))
end

function SCENE:_clearHistoryContent()
    self.histDateTime_tb1:setText("")
    self.histDateTime_tb2:setText("")

    self.histname_tb:setText("")
    self.histinout_tb:setText("")
    self.histbalanceleft_tb:setText("")
end

function SCENE:_modify_hist_page(diff)
    local currScroll = self.hist_lb:getScroll()
    self.hist_lb:setScroll(currScroll + diff)
end

---@param bt Button
function SCENE:back_bt_style(bt)
    bt:setTextVerticalAlignment(JLib.Enums.VerticalAlignmentMode.center)
    bt:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.center)
    bt.ClickEvent = function() self:back_bt_clickEvent() end
end

---@param lb ListBox
function SCENE:hist_lb_style(lb) end

function SCENE:back_bt_clickEvent()
    self:unlink_rednet_event()
    self:clear()
    self.PROJ.UIRunner:changeScene(self.PROJ.BankingMenuScene)
end

function SCENE:link_rednet_event()
    self.PROJ.EventRouter:attachRednetCallback(JLib.BankDB.Consts.masterPort,
                                               function(a, b, c, d)
        self:rednet_callback(a, b, c, d)
    end)
end

function SCENE:unlink_rednet_event()
    self.PROJ.EventRouter:removeRednetEventCallBack(JLib.BankDB.Consts
                                                        .masterPort)
end

function SCENE:rednet_callback(a, b, c, d)
    -- print(a, b, c, d) 

    if (b == self.PROJ.Param.BankServerID) then
        local msg = JLib.BankDB.Message:Deserialize(c)
        if (msg.Header == JLib.BankDB.Headers.ACK_GETHISTORY) then
            local msgstruct = JLib.BankDB.MsgStruct.ACK_GETHISTORY:Deserialize(
                                  msg.SerializedMsgStruct)
            if (msgstruct.Success == true) then

                self.hist_lb_source = msgstruct.Histories
                self.hist_lb:setItemSource(self.hist_lb_source)
                self.hist_lb:Refresh()
            end

            self.msg_tb:setText(JLib.BankDB.MsgStruct.ACK_GETACCOUNT
                                    .eStateReverse[msgstruct.State])

            self:_clearHistoryContent()
            self:_hide_histDetails()
            self.PROJ.UIRunner:ClearScreens()
            self.PROJ.UIRunner:RenderScreen()
        end
    end
end

function SCENE:clear()
    self.qcount_tb:setText("1")
    self.hist_lb_source = {}
    self.hist_lb:setItemSource(self.hist_lb_source)
    self.hist_lb:Refresh()
    self:_clearHistoryContent()
    self:_hide_histDetails()
end

return SCENE
