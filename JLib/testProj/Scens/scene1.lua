local class = require("Class.middleclass")

require("UI.UIScene")

---@class testProj.scene1 : UIScene
local scene1 = class("testProj.scene1", JLib.UIScene)

---constructor
---@param attachedScreen Screen
---@param PROJ table
function scene1:initialize(attachedScreen, PROJ)
    JLib.UIScene.initialize(self, attachedScreen, PROJ)
    -- screen:clearScreen()
    local sc1 = self.rootScreenCanvas
    local screen = self.attachingScreen
    local listbox = JLib.ListBox:new(sc1, screen, "listbox")
    local fuu = function(k, v) return {["a"] = k, ["b"] = v} end
    local testTable1 = {1, 2, 3, 4, 5, 6, 7, 8, 9, 0}
    local testTable2 = {"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k"}
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
    listbox:Refresh()
    listbox.PosRel = JLib.Vector2:new(2, 3)
    listbox.Len = JLib.Vector2:new(5, 5)
    listbox:setScroll(2)

    local tb1 = JLib.TextBlock:new(sc1, screen, "tb1", "")
    tb1.PosRel = JLib.Vector2:new(10, 1)
    tb1.Len = JLib.Vector2:new(10, 3)
    tb1:setTextVerticalAlignment(JLib.Enums.VerticalAlignmentMode.center)
    tb1:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.center)
    tb1:setIsTextEditable(true)

    local tb2 = JLib.TextBlock:new(sc1, screen, "tb2", "")
    tb2.PosRel = JLib.Vector2:new(10, 5)
    tb2.Len = JLib.Vector2:new(10, 3)
    tb2:setTextVerticalAlignment(JLib.Enums.VerticalAlignmentMode.center)
    tb2:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.center)

    ---@param obj ListBoxItem
    local fuu2 = function(obj)
        local obj2 = obj.obj
        tb1:setText("id : " .. tostring(obj2.a))
        tb2:setText("pass : " .. obj2.b)
    end

    listbox.SelectedIndexChanged = fuu2

end

---properties description
---@class testProj.scene1 : UIScene
---@field new fun(self:testProj.scene1, attachedScreen:Screen , PROJ:table):testProj.scene1

return scene1
