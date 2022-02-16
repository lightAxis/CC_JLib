---@module "Class.middleclass"
local class = require("Class.middleclass")

--- #includes
require("UI.TextBlock")
require("UI.UIElement")

--- public class ListBoxItem : UIElement  
---  
---**require** : 
--- - Class.middleclass
--- - UI.TextBlock
--- - UI.UIElement
---@class ListBoxItem : UIElement
local ListBoxItem = class("ListBoxItem", JLib.UIElement)

---namespace JLib
JLib = JLib or {}
JLib.ListBoxItem = ListBoxItem

---constructor
---@param parentListBox ListBox
---@param screen Screen
---@param obj? any
function ListBoxItem:initialize(parentListBox, screen, obj)
    JLib.UIElement.initialize(self, parentListBox, screen, "")
    self.obj = obj or nil
    self._TextArea = JLib.TextArea:new(self, self._screen, "", "")
    self._IsSelected = false
end

--- properties description
---@class ListBoxItem : UIElement
---@field obj any
---@field _TextArea TextArea
---@field _IsSelected boolean
---@field Parent ListBox
---@field new fun(self:ListBoxItem, parent: UIElement, screen: Screen, obj?: any): ListBoxItem

---functions

---make this list box item focused
function ListBoxItem:makeThisItemSelected() self.Parent:SelectItem(self) end

---update this listboxitem visual with itemTemplate  
---
function ListBoxItem:updateItemVisual()
    if (self.obj == nil) then return end

    local text, BG, FG = self.Parent._ItemTemplete(self.obj)

    if (text ~= nil) then self._TextArea:setText(text); end
    if (BG ~= nil) then self:setBG(BG) end
    if (FG ~= nil) then self:setFG(FG) end

end

function ListBoxItem:setBG(bg)
    self.BG = bg
    self._TextArea.BG = bg
end

function ListBoxItem:setFG(fg)
    self.FG = fg
    self._TextArea.FG = fg
end

function ListBoxItem:setText(text) self._TextArea:setText(text) end

---update relative position from parent ListBox
function ListBoxItem:_updatePosRelFromParent()
    self.PosRel.x = 1
    ---this parent must be listbox
    self.PosRel.y = self.Parent._ItemRenderYOffset
    self.Parent._ItemRenderYOffset = self.Parent._ItemRenderYOffset + self.Len.y
end

---update Len.y from parent listbox
function ListBoxItem:_updateLenFromparent()
    self.Len.x = self.Parent.Len.x
    self._TextArea.Len.x = self.Len.x
    self.Len.y = 1
    self._TextArea.Len.y = 1
end

---render internal Textblock
function ListBoxItem:_renderText()
    self._TextArea.PosRel.x = 1
    self._TextArea.PosRel.y = 1
    self._TextArea:render()
end

function ListBoxItem:isSelectIhis(bool) self._IsSelected = bool end

--- overrided functions

---overrided function from UIElement:render()
function ListBoxItem:render() -- renderOffset)

    -- update posrel from parent and item offset y
    self:_updatePosRelFromParent()

    -- update global pos
    self:_updatePos()

    -- update length from parent
    -- custom length update from parent
    -- self:_updateLengthFromParent()
    self:_updateLenFromparent()

    -- render history add
    self:_addThisToRenderHistory()

    -- listboxitem doen not have child.
    -- self:renderChildren()
    -- instead render internal textblock
    self:_renderText()

end

---overrided function from UIElement:_ClickEvent
---@param e ClickEventArgs
function ListBoxItem:_ClickEvent(e) end

---overrided function from UIElement:_ScrollEvent
---@param e ScrollEventArgs
function ListBoxItem:_ScrollEvent(e) end

---overrided function from UIElement:_KeyInputEvent
---@param e KeyInputEventArgs
function ListBoxItem:_KeyInputEvent(e) end

---overrided function from UIElement:_CharEvent
---@param e CharEventArgs
function ListBoxItem:_CharEvent(e) end

---overrided function from UIElement:PostRendering()
function ListBoxItem:PostRendering() end

---overrided function from UIElement:FocusIn()
function ListBoxItem:FocusIn() end

---overrided function from UIElement:FocusOut()
function ListBoxItem:FocusOut() end
