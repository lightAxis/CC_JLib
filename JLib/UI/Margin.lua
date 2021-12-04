---@module 'Class.middleclass'
local class = require("Class.middleclass")

-- #includes 
require("UI.UIElement")

---public class Margin : JLibElement
---  
---**require** :  
--- - Class.middleclass
--- - UI.UIElement
---@class Margin : UIElement
local Margin = class("Margin", JLib.UIElement)

-- namespace JLib
JLib = JLib or {}
JLib.Margin = Margin

---constructor
---@param parent UIElement
---@param screen Screen
---@param name string
---@param marginLeft? number or 0
---@param marginRight? number or 0
---@param marginTop? number or 0
---@param marginBottom? number or 0
function Margin:initialize(parent, screen, name, marginLeft, marginRight,
                           marginTop, marginBottom)
    if (parent == nil) then
        error("Margin class must have a parent UIElement!")
    end
    JLib.UIElement.initialize(self, parent, screen, name)
    self.MarginLeft = marginLeft or 0
    self.MarginRight = marginRight or 0
    self.MarginTop = marginTop or 0
    self.MarginBottom = marginBottom or 0

end

-- properties
---@class Margin
---@field MarginLeft number
---@field MarginRight number
---@field MarginTop number
---@field MarginBottom number
---@field new fun(parent: UIElement, screen: Screen, name: string, marginLeft?: number, marginRight?: number,  marginTop?: number, marginBottom?: number) : Margin

-- functions

---sell all 4 margin
---@param margin number
function Margin:setMarginAll(margin)
    self.MarginLeft = margin;
    self.MarginRight = margin;
    self.MarginTop = margin;
    self.MarginBottom = margin;
end

-- overriding functions

---overrided function from UIElement:render()
function Margin:render()
    -- update self length from parent and margin
    self:_updateLengthFromParent()

    -- update self PosRel from margin
    self:_updatePosRelFromMargin()

    -- update global position
    self:_updatePos()

    -- render history add
    self:_addThisToRenderHistory()

    -- render children
    self:renderChildren()

end

---overrided function from UIElement:_updateLengthFromParent()
function Margin:_updateLengthFromParent()
    self.Len.x = self.Parent.Len.x - self.MarginLeft - self.MarginRight
    self.Len.x = math.max(1, self.Len.x)
    self.Len.y = self.Parent.Len.y - self.MarginTop - self.MarginBottom
    self.Len.y = math.max(1, self.Len.y)
end

--- update position relevant to parent, using margin properties
function Margin:_updatePosRelFromMargin()
    self.PosRel.x = self.MarginLeft + 1
    self.PosRel.y = self.MarginTop + 1
end

---overrided function from UIElement:_ClickEvent
---@param e ClickEventArgs
function Margin:_ClickEvent(e) end

---overrided function from UIElement:_ScrollEvent
---@param e ScrollEventArgs
function Margin:_ScrollEvent(e) end

---overrided function from UIElement:_KeyInputEvent
---@param e KeyInputEventArgs
function Margin:_KeyInputEvent(e) end

---overrided function from UIElement:_CharEvent
---@param e CharEventArgs
function Margin:_CharEvent(e) end

---overrided function from UIElement:PostRendering()
function Margin:PostRendering() end
