local class = require("Class.middleclass")

---@class ProjTemplate.SCENENAME1_L : UILayout
local SCENE_L = class("ProjTemplate.SCENENAME1_L")

---constructor
---@param attachedScreen Screen
---@param ProjNamespace ProjTemplate
function SCENE_L:initialize(attachedScreen, ProjNamespace)
    JLib.UILayout.initialize(self, attachedScreen, ProjNamespace)

    ---@type Grid
    local grid = JLib.Grid:new(attachedScreen:getSize())
    grid:setHorizontalSetting({ "3", "10", "3", "*", "3" })
    grid:setVerticalSetting({ "1", "10", "*", "5", "*" })
    grid:updatePosLen()
    self.grid = grid

    ---@type Button
    local ButtonNext = JLib.Button:new(self.rootScreenCanvas,
        self.attachingScreen, "ButtonNext")
    ButtonNext:setText("Next Scene")
    -- link events at UIScene, not here
    -- ButtonNext.ClickEvent = function() end
    ButtonNext:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.center)
    ButtonNext:setTextVerticalAlignment(JLib.Enums.VerticalAlignmentMode.center)
    ButtonNext.PosRel, ButtonNext.Len = grid:getPosLen(2, 4, 2, 1)
    self.ButtonNext = ButtonNext

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
    -- link events at UIScene, not here
    -- listbox.SelectedIndexChanged = function(obj) end
    listbox:Refresh()
    listbox.PosRel, listbox.Len = grid:getPosLen(2, 2)
    self.listbox = listbox

    ---@type TextBlock
    local textblock = JLib.TextBlock:new(self.rootScreenCanvas, self.attachingScreen, "tb1")
    textblock:setText("this is textblock!")
    textblock:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.center)
    textblock:setTextVerticalAlignment(JLib.Enums.VerticalAlignmentMode.center)
    textblock:setIsTextEditable(true)
    textblock.PosRel, textblock.Len = grid:getPosLen(4, 2)
    self.textblock1 = textblock

end

return SCENE_L