local class = require("Class.middleclass")

-- #includes
require("UI.UIElement")
require("UI.ListBoxItem")

--- public ListBox : UIElement  
---  
---**require** :
--- - Class.middleclass
--- - UI.UIElement
--- - UI.ListBoxItem
---@class ListBox : UIElement
local ListBox = class("Listbox", JLib.UIElement)

--- namespace JLib
JLib = JLib or {}
JLib.ListBox = ListBox

function ListBox:initialize(parent, screen, name)
    JLib.UIElement.initialize(self, parent, screen, name)

    self._ItemSource = {}
    self._Items = {}

    ---@type fun(obj: any): string, Enums.Color, Enums.Color
    self._ItemTemplete = nil

    self._Scroll = 1
    self._ItemRenderYOffset = 1

    self._SelectedItem = nil
    self._SelectedIndex = nil
    ---@type fun(obj: ListBoxItem)
    self.SelectedIndexChanged = nil

    self._viewportItems = {}

    self._OddIndexBG = JLib.Enums.Color.lightGray
    self._OddIndexFG = JLib.Enums.Color.white
    self._EvenIndexBG = JLib.Enums.Color.gray
    self._EvenIndexFG = JLib.Enums.Color.white
    self._SelectedIndexBG = JLib.Enums.Color.lightBlue
    self._SelectedIndexFG = JLib.Enums.Color.white

end

--- properties description
---@class ListBox
---@field _ItemSource table<number, any>
---@field _Items table<number, ListBoxItem>
---@field _ItemTemplate fun(obj:any): string, Enums.Color, Enums.Color
---@field _Scroll number
---@field _ItemRenderYOffset number
---@field _SelectedItem ListBoxItem
---@field _SelectedIndex number
---@field SelectedIndexChanged fun(obj: ListBoxItem)
---@field _viewportItems table<number, ListBoxItem>
---@field _OddIndexBG Enums.Color
---@field _OddIndexFG Enums.Color
---@field _EvenIndexBG Enums.Color
---@field _EvenIndexFG Enums.Color
---@field new fun(self: ListBox, parent: UIElement, screen: Screen, name: string) : ListBox

---@return fun(obj:any): string, Enums.Color, Enums.Color ItemTemplateFunction
function ListBox:getItempTemplate() return self._ItemTemplate end

---@param template fun(obj:any): string, Enums.Color, Enums.Color
function ListBox:setItemTemplate(template) self._ItemTemplete = template end

---@param objs table<number,any>
function ListBox:setItemSource(objs) self._ItemSource = objs; end

---@return table<number, any> objs
function ListBox:getItemSource() return self._ItemSource end

---@return table<number, any> Items
function ListBox:getItems() return self._Items end

---@param scroll number
function ListBox:setScroll(scroll)
    self._Scroll = scroll
    self._ItemRenderYOffset = scroll
end

---@return number Scroll
function ListBox:getScroll() return self._Scroll end

---@param obj ListBoxItem
---@param index? number
function ListBox:Insert(obj, index)
    local index_ = index or #(self._Items) + 1
    table.insert(self._Items, index_, obj)
end

---@param index number
function ListBox:RemoveAt(index) table.remove(self._Items, index) end

---refresh with ItemSource
function ListBox:Refresh()
    if (self._ItemSource ~= nil) then
        self._Items = {}
        for index, value in ipairs(self._ItemSource) do
            local newItem = JLib.ListBoxItem:new(self, self._screen, value)
            table.insert(self._Items, newItem)
        end
    end
end

---@param index number
---@return boolean isSelected
function ListBox:SelectItemAt(index)
    if (index > #(self._Items)) then
        error("index position is over Items in ListBox!")
        return false
    end

    if (self._SelectedItem ~= nil) then
        self._SelectedItem:isSelectIhis(false)
    end

    local newSelectedItem = self._Items[index]
    newSelectedItem:isSelectIhis(true)

    self._SelectedIndex = index
    self._SelectedItem = newSelectedItem

    if (self.SelectedIndexChanged ~= nil) then
        self.SelectedIndexChanged(self._SelectedItem)
    end
    return true
end

---select item if exist
---@param item ListBoxItem
---@return boolean isSelected
function ListBox:SelectItem(item) end

function ListBox:_makeListBoxItemWithTemplate(obj)
    local listBoxItem = JLib.ListBoxItem:new(self, self._screen, obj)
    return listBoxItem
end

function ListBox:_updateViewportItems()

    -- wrap scroll
    local scrollMin = math.max(self._Scroll, 1)
    local scrollMax = JLib.UITools.calcRelativeOffset_Raw(scrollMin, self.Len.y)

    scrollMax = math.min(scrollMax, #(self._Items))
    scrollMin = math.max(scrollMax - self.Len.y + 1, 1)

    -- wrap scroll
    self._Scroll = scrollMin

    -- update viewport items
    self._viewportItems = {}
    for i = scrollMin, scrollMax, 1 do
        table.insert(self._viewportItems, self._Items[i])
    end

    self.Children = {}
    -- update viewport item appearance
    for index, value in ipairs(self._viewportItems) do
        local isEven = ((scrollMin + index - 1) % 2) == 0

        if (value._IsSelected) then
            value:setBG(self._SelectedIndexBG)
            value:setFG(self._SelectedIndexFG)
        else
            if (isEven) then
                value:setBG(self._EvenIndexBG)
                value:setFG(self._EvenIndexFG)
            else
                value:setBG(self._OddIndexBG)
                value:setFG(self._OddIndexFG)
            end
        end

        value:updateItemVisual()
        table.insert(self.Children, value)
    end

end

-- [overriding functions]

---overrided function from UIElement:render()
function ListBox:render() -- renderOffset)

    -- update global pos
    self:_updatePos()

    -- update and change viewport items properties
    self:_updateViewportItems()

    -- -- update length from parent
    -- self:_updateLengthFromParent()

    -- self:_backgroundDraw()

    -- render history add
    self:_addThisToRenderHistory()

    -- initialize item render offset to 1
    self._ItemRenderYOffset = 1

    -- render children
    self:renderChildren()

end

---overrided function from UIElement:_ClickEvent
---@param e ClickEventArgs
function ListBox:_ClickEvent(e)
    local relClickPos = JLib.UITools
                            .transformGlobalPos2LocalPos(e.Pos, self.Pos)

    local clickedIndex = nil
    if ((1 <= relClickPos.y) and (relClickPos.y <= #(self._viewportItems))) then
        clickedIndex = JLib.UITools.transformLocalIndex2GlobalIndex(
                           relClickPos.y, self._Scroll)
    end

    if (clickedIndex == nil) then return nil end

    self:SelectItemAt(clickedIndex)
end

---overrided function from UIElement:_ScrollEvent
---@param e ScrollEventArgs
function ListBox:_ScrollEvent(e)
    self._Scroll = self._Scroll + e.Direction
    e.Handled = true
end

---overrided function from UIElement:_KeyInputEvent
---@param e KeyInputEventArgs
function ListBox:_KeyInputEvent(e) end

---overrided function from UIElement:_CharEvent
---@param e CharEventArgs
function ListBox:_CharEvent(e) end

---overrided function from UIElement:PostRendering()
function ListBox:PostRendering() end

---overrided function from UIElement:FocusIn()
function ListBox:FocusIn() end

---overrided function from UIElement:FocusOut()
function ListBox:FocusOut() end
