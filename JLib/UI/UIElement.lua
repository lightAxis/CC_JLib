local class = require("Class.middleclass")

-- #includes
require("MathLib.Vector2")
require("UI.Enums")
require("UI.UITools")
require("UI.UIEvent")

-- public class UIElement
---
---**require** :
--- - Class.middleclass
--- - MathLib.Vector2
--- - UI.Enums
--- - UI.UITools
--- - UI.UIEvent
---@class UIElement
local UIElement = class("UIElement")

-- namespace JLib
JLib = JLib or {}
JLib.UIElement = UIElement

-- [constructor]

---constructor
---@param parent UIElement
---@param screen Screen
---@param name string
---@param x? number or 1
---@param y? number or 1
---@param xlen? number or 1
---@param ylen? number or 1
---@param bg? Enums.Color or Enums.Color.black
---@param fg? Enums.Color or Enums.Color.white
function UIElement:initialize(parent, screen, name, x, y, xlen, ylen, bg, fg)
    if (screen == nil) then
        error("UIElement cannot be initialized without owner:screen")
    end
    -- private:
    self._screen = screen -- owner screen handle
    -- public:
    self.Parent = self:setParent(parent or nil)
    self.PosRel = JLib.Vector2:new(x or 1, y or 1) -- coordinate of Position Relavent to parent obj

    if (self.Parent == nil) then -- coordinate of Global position in screen
        self.Pos = self.PosRel
    else
        self.Pos = JLib.UITools.calcRelativeOffset(self.Parent.Pos, self.PosRel)
    end

    self.Len = JLib.Vector2:new(xlen or 1, ylen or 1) -- length of w,h
    self.BG = bg or JLib.Enums.Color.gray -- background color of element
    self.FG = fg or JLib.Enums.Color.white -- foregraoud color or element

    ---@type table<number,UIElement>
    self.Children = {}

    self.Name = name or ""

    self.Visible = true

end

-- [properties description]
--- TODO change to protected, Pos, Children, Name, Visible
--- TODO consider capsule Parent, Posrel, Len?
---@class UIElement
---@field _screen Screen
---@field Parent UIElement
---@field PosRel Vector2
---@field Pos Vector2
---@field Len Vector2
---@field BG Enums.Color
---@field FG Enums.Color
---@field Children table<number,UIElement>
---@field Name string
---@field Visible boolean
---@field new fun(self:UIElement ,parent: UIElement|nil, screen: Screen, name: string, x?: number, y?: number, xlen?: number, ylen?:number, bg?: Enums.Color, fg?:Enums.Color)

-- [functions]

---set Parent of this element
---@param parent UIElement
function UIElement:setParent(parent)
    self.Parent = parent
    if (parent ~= nil) then table.insert(self.Parent.Children, self) end
    return parent
end

-- add Child element to this element
---@param child UIElement
function UIElement:addChild(child) table.insert(self.Children, child) end

-- call render callback of children
function UIElement:renderChildren()
    for index, value in ipairs(self.Children) do
        if (value.Visible == true) then value:render() end
    end
end

-- check if position is over element.
---@param checkpos Vector2
function UIElement:isPositionOver(checkpos)
    return JLib.UITools.isInsideSquare(self.Pos, self.Len, checkpos)
end

-- check if position is over element. use only lua
---@param x number
---@param y number
function UIElement:isPositionOver_Raw(x, y)
    return UIElement:isPositionOver(JLib.Vector2:new(x, y))
end

-- update global Position of element based on Parent or nil
-- spread to childs
function UIElement:_updatePos()
    if (self.Parent == nil) then
        self.Pos = self.PosRel:Copy()
    else
        self.Pos = JLib.UITools.calcRelativeOffset(self.Parent.Pos, self.PosRel)
    end
    -- for key, child in pairs(self.Children) do child:_updatePos() end
end

-- update length sync with parent's Len
function UIElement:_updateLengthFromParent()
    self.Len.x = self.Parent.Len.x
    self.Len.x = math.max(1, self.Len.x)
    self.Len.y = self.Parent.Len.y
    self.Len.y = math.max(1, self.Len.y)
end

-- add this UIelement to RenderHistory of JLib.Screen class to use at UIInteraction system
function UIElement:_addThisToRenderHistory()
    table.insert(self._screen._renderHistory, self)
end

-- trigger bubble down click event to element
---@param button Enums.MouseButton
---@param pos Vector2
function UIElement:triggerClickEvent(button, pos)
    local e = JLib.UIEvent.ClickEventArgs:new(button, pos)
    self:_ClickEventBubbleDown(e)
end

-- click event bubble down function for UIElement
---@param e ClickEventArgs
function UIElement:_ClickEventBubbleDown(e)
    self:_ClickEvent(e)
    if (e.Handled == true) then
        return nil
    else
        if (self.Parent ~= nil) then self.Parent:_ClickEventBubbleDown(e) end
    end
end

-- scroll event function for UIElement
---@param direction Enums.ScrollDirection
---@param pos Vector2
function UIElement:triggerScrollEvent(direction, pos)
    local e = JLib.UIEvent.ScrollEventArgs:new(direction, pos)
    self:_ScrollEventBubbleDown(e)
end

-- scroll event bubble down function for UIelemnt
---@param e ScrollEventArgs
function UIElement:_ScrollEventBubbleDown(e)
    self:_ScrollEvent(e)
    if (e.Handled == true) then
        return nil
    else
        if (self.Parent ~= nil) then
            self.Parent:_ScrollEventBubbleDown(e)
        end
    end
end

-- keyinput event function for UIElement
---@param key Enums.Key
function UIElement:triggerKeyInputEvent(key)
    local e = JLib.UIEvent.KeyInputEventArgs:new(key)
    self:_KeyInputBubbleDown(e)
end

-- keyinput bubble down event function for UIElement
---@param e KeyInputEventArgs
function UIElement:_KeyInputBubbleDown(e)
    self:_KeyInputEvent(e)
    if (e.Handled == true) then
        return nil
    else
        if (self.Parent ~= nil) then self.Parent:_KeyInputBubbleDown(e) end
    end
end

---char event function for UIElement
---@param char string
function UIElement:triggerCharEvent(char)
    local e = JLib.UIEvent.CharEventArgs:new(char)
    self:_CharBubbleDown(e)
end

---char event bubble down function for UIElement
---@param e CharEventArgs
function UIElement:_CharBubbleDown(e)
    self:_CharEvent(e)
    if (e.Handled == true) then
        return nil
    else
        if (self.Parent ~= nil) then self.Parent:_CharBubbleDown(e) end
    end
end

-- [abstract functions]

---abstract render function.
function UIElement:render()
    error("This is abstrct function! UIElement:render(pos)")
end

-- abstract Click Bubble down event function
---@param e ClickEventArgs
function UIElement:_ClickEvent(e)
    error("this is abstrcat function! UIElement:_ClickEvent(e)")
end

-- abstract Scroll Bubble down event function
---@param e ScrollEventArgs
function UIElement:_ScrollEvent(e)
    error("This is abstract function! UIelement:_ScrollEvent(e)")
end

-- abstract KeyInput bubble down event function
---@param e KeyInputEventArgs
function UIElement:_KeyInputEvent(e)
    error("This is abstract function!, UIElement:_KeyInputEvent(e)")
end

---abastract Char bubble down event function
---@param e CharEventArgs
function UIElement:_CharEvent(e)
    error("This is abstract function!, UIElement:_CharEvent(e)")
end

---abstract PostRendering function when being focused Element
function UIElement:PostRendering()
    error("this is abstrct function!, UIElement:PostRendering")
end

---abstract function when this element is focused in
function UIElement:FocusIn()
    error("this is abstract function!, UIElement:FocusIn()")
end

---abstract function when this element is focused out
function UIElement:FocusOut()
    error("this is abstract function!, UIElement:FocusOut()")
end
