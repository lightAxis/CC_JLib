local class = require("Class.middleclass")

---@class ProjTemplate.SCENENAME1 : UIScene
local SCENE = class("ProjTemplate.SCENENAME1")

---constructor
---@param attachedScreen Screen
---@param ProjTemplatespace ProjTemplate
function SCENE:initialize(attachedScreen, ProjTemplatespace)
    JLib.UIScene.initialize(self, attachedScreen, ProjTemplatespace)

    local grid = JLib.Grid:new(attachedScreen:getSize())
    grid:setHorizontalSetting({ "3", "10", "3", "*", "3" })
    grid:setVerticalSetting({ "1", "10", "*", "5", "*" })
    grid:updatePosLen()

    ---@type Button
    local ButtonNext = JLib.Button:new(self.rootScreenCanvas,
        self.attachingScreen, "button1")
    ButtonNext:setText("Next Scene")
    ButtonNext.ClickEvent = function()
        -- error(self.attachingScreen:getScreenSide())
        self:button_click()
    end
    self:ButtonStyle(ButtonNext)
    ButtonNext.PosRel, ButtonNext.Len = grid:getPosLen(2, 4, 2, 1)

    ---@type ListBox
    local listbox = JLib.ListBox:new(self.rootScreenCanvas, self.attachingScreen, "listbox")
    local fuu = function(k, v) return { ["a"] = k, ["b"] = v } end
    local testTable1 = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14 }
    local testTable2 = { "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "aa", "bb", "ccasdfasdfsfa" }
    local source = {}
    for index, value in ipairs(testTable1) do
        table.insert(source, fuu(testTable1[index], testTable2[index]))
    end
    listbox:setItemSource(source)
    local itemTemplate = function(obj)
        local text = tostring(obj.a) .. "/" .. obj.b
        return text
    end
    listbox:setItemTemplate(itemTemplate)

    listbox.SelectedIndexChanged = function(obj)
        self:itemIndexChanged(obj)
    end
    listbox:Refresh()
    listbox.PosRel, listbox.Len = grid:getPosLen(2, 2)

    ---@type TextBlock
    local textblock = JLib.TextBlock:new(self.rootScreenCanvas, self.attachingScreen, "tb1")
    textblock:setText("this is textblock!")
    textblock:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.center)
    textblock:setTextVerticalAlignment(JLib.Enums.VerticalAlignmentMode.center)
    textblock:setIsTextEditable(true)
    textblock.PosRel, textblock.Len = grid:getPosLen(4, 2)
    self.textblock1 = textblock

end

---properties description
---@class ProjTemplate.SCENENAME1 : UIScene
---@field PROJ ProjTemplate
---@field new fun(self:ProjTemplate.SCENENAME1, attachedScreen:Screen, ProjTemplatespace: ProjTemplate):ProjTemplate.SCENENAME1

function SCENE:changed_to_other_scene() end

---button style
---@param button Button
function SCENE:ButtonStyle(button)
    button.PosRel = JLib.Vector2:new(10, 10)
    button.Len = JLib.Vector2:new(15, 3)
    button:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.center)
    button:setTextVerticalAlignment(JLib.Enums.VerticalAlignmentMode.center)
end

---add freely to do
function SCENE:other_functions() end

function SCENE:button_click()
    -- error(self.attachingScreen:getScreenSide())
    if (self.attachingScreen:getScreenSide() ~= JLib.Enums.Side.NONE) then

        self.PROJ.UIRunner:changeScene(self.PROJ.SCENENAME2_t)
    else
        self.PROJ.UIRunner:changeScene(self.PROJ.SCENENAME2)
    end
end

---comment
---@param obj2 ListBoxItem
function SCENE:itemIndexChanged(obj2)
    local obj = obj2.obj
    local str = self.textblock1:getText()
    str = str .. "\n" .. tostring(obj.a) .. " + " .. obj.b
    self.textblock1:setText(str)
    self.textblock1:setScroll(999)
end

return SCENE
