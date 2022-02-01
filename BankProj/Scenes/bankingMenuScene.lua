local class = require("Class.middleclass")

---@class BankProj.bankingMenuScene : UIScene
local SCENE = class("BankProj.bankingMenuScene")

---constructor
---@param attachedScreen Screen
---@param ProjTemplatespace BankProj
function SCENE:initialize(attachedScreen, ProjTemplatespace)
    JLib.UIScene.initialize(self, attachedScreen, ProjTemplatespace)
    local grid = JLib.Grid:new(self.rootScreenCanvas.Len)
    grid:setHorizontalSetting({"10", "*"})
    grid:setVerticalSetting({"1", "*", "1"})
    grid:updatePosLen()

    local grid_pos, grid_len = grid:getPosLen(1, 3, 2, 1)

    --- grid for grid_buttonUnder
    local grid_buttonUnder = JLib.Grid:new(grid_len, grid_pos)
    grid_buttonUnder:setHorizontalSetting({"*", "*"})
    grid_buttonUnder:setVerticalSetting({"*"})
    grid_buttonUnder:updatePosLen()

    --- title
    local title_tb = JLib.TextBlock:new(self.rootScreenCanvas,
                                        self.attachingScreen, "title_tb")
    title_tb:setText("Menu")
    title_tb.PosRel, title_tb.Len = grid:getPosLenWithMargin(1, 1, 2, 1, 0, 0,
                                                             0, 0)
    self:title_tb_style(title_tb)
    self.title_tb = title_tb

    -- --- back button
    local back_bt = JLib.Button:new(self.rootScreenCanvas, self.attachingScreen,
                                    "back_bt")
    back_bt:setText("Back")
    back_bt.PosRel, back_bt.Len = grid_buttonUnder:getPosLenWithMargin(1, 1, 1,
                                                                       1, 0, 1,
                                                                       0, 0)
    self:back_bt_style(back_bt)
    self.back_bt = back_bt

    -- local grid2_profile = JLib.Grid:new(grid1_len)
    -- local grid2_histories = JLib.Grid:new(grid1_len)
    -- local grid2_send = JLib.Grid:new(grid1_len)

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
