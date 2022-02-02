local class = require("Class.middleclass")

---@class BankProj.bioScanScene : UIScene
local SCENE = class("BankProj.bioScanScene")

---constructor
---@param attachedScreen Screen
---@param ProjTemplatespace BankProj
function SCENE:initialize(attachedScreen, ProjTemplatespace)
    JLib.UIScene.initialize(self, attachedScreen, ProjTemplatespace)

    local grid = JLib.Grid:new(self.rootScreenCanvas.Len)
    grid:setHorizontalSetting({"*", "*"})
    grid:setVerticalSetting({"2", "*", "1"})
    grid:updatePosLen()

    --- title block
    local title_textblock = JLib.TextBlock:new(self.rootScreenCanvas,
                                               self.attachingScreen,
                                               "title_textblock")
    self:title_style(title_textblock)
    title_textblock.PosRel, title_textblock.Len =
        grid:getPosLenWithMargin(1, 1, 2, 1, 0, 1, 0, 0)
    self.title_textblock = title_textblock

    --- player name block
    local player_textblock = JLib.TextBlock:new(self.rootScreenCanvas,
                                                self.attachingScreen,
                                                "player_textblock")
    self:player_style(player_textblock)
    player_textblock.PosRel, player_textblock.Len =
        grid:getPosLenWithMargin(1, 2, 2, 1, 1, 2, 3, 3)
    self.player_textblock = player_textblock

    --- autenticate button
    local auth_bt = JLib.Button:new(self.rootScreenCanvas, self.attachingScreen,
                                    "auth_bt")
    self:auth_bt_style(auth_bt)
    auth_bt.PosRel, auth_bt.Len = grid:getPosLenWithMargin(2, 3, 1, 1, 1, 0, 0,
                                                           0)
    self.auth_bt = auth_bt

    --- back button
    local back_bt = JLib.Button:new(self.rootScreenCanvas, self.attachingScreen,
                                    "back_bt")
    self:back_bt_style(back_bt)
    back_bt.PosRel, back_bt.Len = grid:getPosLenWithMargin(1, 3, 1, 1, 0, 1, 0,
                                                           0)
    self.back_bt = back_bt

    --- attach player detection click event
    self.PROJ.EventRouter:attachEventCallback(
        JLib.EventRouter.Events.playerClick,
        function(a, b, c, d) self:playerClickEvent(a, b, c, d) end)

    self.current_Player = ""

end

--- properties description
---@class BankProj.bioScanScene : UIScene
---@field PROJ BankProj
---@field new fun(self:BankProj.bioScanScene, attachedScreen:Screen, ProjTemplatespace: BankProj):BankProj.bioScanScene

---@param tb TextBlock
function SCENE:title_style(tb)
    tb:setText("Right click player detector\nto authenticate yourself")
    tb:setBackgroundColor(JLib.Enums.Color.lightBlue)
    tb:setTextColor(JLib.Enums.Color.white)
    tb:setTextVerticalAlignment(JLib.Enums.VerticalAlignmentMode.center)
    tb:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.center)
    tb:setIsTextEditable(false)
end

---@param tb TextBlock
function SCENE:player_style(tb)
    tb:setText("")
    tb:setBackgroundColor(JLib.Enums.Color.white)
    tb:setTextColor(JLib.Enums.Color.black)
    tb:setTextVerticalAlignment(JLib.Enums.VerticalAlignmentMode.center)
    tb:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.center)
    tb:setIsTextEditable(false)
    tb.Visible = false
end

---@param bt Button
function SCENE:auth_bt_style(bt)
    bt:setText("Confirm")
    bt:setBackgroundColor(JLib.Enums.Color.lightGray)
    bt:setTextColor(JLib.Enums.Color.white)
    bt:setTextVerticalAlignment(JLib.Enums.VerticalAlignmentMode.center)
    bt:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.center)
    bt:setIsTextEditable(false)
    bt.Visible = false
    bt.ClickEvent = function() self:auth_bt_ClickEvent() end
end

function SCENE:auth_bt_ClickEvent()
    -- self:clean()
    self.PROJ.EventRouter:removeEventCallback(
        JLib.EventRouter.Events.playerClick)
    self.PROJ.UIRunner:changeScene(self.PROJ.BankingMenuScene)
end

---@param bt Button
function SCENE:back_bt_style(bt)
    bt:setText("Back")
    bt:setBackgroundColor(JLib.Enums.Color.lightGray)
    bt:setTextColor(JLib.Enums.Color.black)
    bt:setTextVerticalAlignment(JLib.Enums.VerticalAlignmentMode.center)
    bt:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.center)
    bt:setIsTextEditable(false)
    bt.ClickEvent = function() self:back_bt_clickEvent() end
end

function SCENE:back_bt_clickEvent()
    self:clean()
    self.PROJ.UIRunner:changeScene(self.PROJ.MainScene)
end

function SCENE:playerClickEvent(a, b, c, d)
    self.player_textblock:setText(b)
    self.current_Player = b
    self.player_textblock.Visible = true
    self.auth_bt.Visible = true
    self.PROJ.UIRunner:RenderScreen()
end

function SCENE:clean()
    self.PROJ.EventRouter:attachEventCallback(
        JLib.EventRouter.Events.playerClick,
        function(a, b, c, d) self:playerClickEvent(a, b, c, d) end)
    self.player_textblock:setText("")
    self.current_Player = ""
    self.player_textblock.Visible = false
    self.auth_bt.Visible = false
end

return SCENE
