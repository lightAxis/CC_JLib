local class = require("Class.middleclass")

-- #includes
require("MathLib.Vector2")
require("UI.Enums")
require("UI.UITools")
require("UI.UIEvent")

-- public class UIElement
local UIElement = class("UIElement")

-- namespace JLib
JLib = JLib or {}
JLib.UIElement = UIElement

-- [constructor]
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
    self.BG = bg or JLib.Enums.Colors.black -- background color of element
    self.FG = fg or JLib.Enums.Colors.white -- foregraoud color or element
    self.Children = {}

    self.Name = name or ""

end

-- [functions]

-- @brief set Parent of this element
-- @param parent:UIElement
function UIElement:setParent(parent)
    self.Parent = parent
    if (parent ~= nil) then table.insert(self.Parent.Children, self) end
    return parent
end

-- @brief add Child element to this element
-- @param child:UIElement
function UIElement:addChild(child) table.insert(self.Children, child) end

-- @brief call render callback of children
function UIElement:renderChildren()
    for index, value in ipairs(self.Children) do value:render() end
end

-- @brief check if position is over element.
-- @param checkpos:JLib.Vector2
function UIElement:isPositionOver(checkpos)
    return JLib.UITools.isInsideSquare(self.Pos, self.Len, checkpos)
end

-- @brief check if position is over element. use only lua
-- @param x:num
-- @param y:num
function UIElement:isPositionOver_Raw(x, y)
    return UIElement:isPositionOver(JLib.Vector2:new(x, y))
end

-- @brief update global Position of element based on Parent or nil
-- spread to childs
function UIElement:_updatePos()
    if (self.Parent == nil) then
        self.Pos = self.PosRel:Copy()
    else
        self.Pos = JLib.UITools.calcRelativeOffset(self.Parent.Pos, self.PosRel)
    end
    -- for key, child in pairs(self.Children) do child:_updatePos() end
end

-- @brief update length sync with parent's Len
function UIElement:_updateLengthFromParent()
    self.Len.x = self.Parent.Len.x
    self.Len.x = math.max(1, self.Len.x)
    self.Len.y = self.Parent.Len.y
    self.Len.y = math.max(1, self.Len.y)
end

-- @brief add this UIelement to RenderHistory of JLib.Screen class to use at UIInteraction system
function UIElement:_addThisToRenderHistory()
    table.insert(self._screen._renderHistory, self)
end

-- @brief trigger bubble down click event to element
-- @param button:
function UIElement:triggerClickEvent(button, pos)
    local e = JLib.UIEvent.ClickEventArgs:new(button, pos)
    self:_ClickEventBubbleDown(e)
end

-- @brief click event function for UIElement
-- @param e:JLib.UIEvent.ClickEventArgs
function UIElement:_ClickEventBubbleDown(e)
    self:_ClickEvent(e)
    if (e.Handled == true) then
        return nil
    else
        if (self.Parent ~= nil) then self.Parent:_ClickEventBubbleDown(e) end
    end
end

-- @brief scroll event function for UIElement
-- @param direction:JLib.Enums.ScrollDirection
-- @param pos:JLib.Vector2
function UIElement:triggerScrollEvent(direction, pos)
    local e = JLib.UIEvent.ScrollEventArgs:new(direction, pos)
    self:_ScrollEventBubbleDown(e)
end

-- @brief scroll event function for UIelemnt
-- @param e:JLib.UIEvent.ScrollEventArgs
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

-- @brief keyinput event function for UIElement
-- @param key:JLib.Enums.key -- TODO:JLib.EnumsKey
function UIElement:triggerKeyInputEvent(key)
    local e = JLib.UIEvent.KeyInputEventArgs:new(key)
    self:_KeyInputBubbleDown(e)
end

-- @brief keyinput event function for UIElement
-- @parem e:JLib.UIEvent.KeyInputEventArgs
function UIElement:_KeyInputBubbleDown(e)
    self:_KeyInputEvent(e)
    if (e.Handled == true) then
        return nil
    else
        if (self.Parent ~= nil) then self.Parent:_KeyInputBubbleDown(e) end
    end
end

-- [abstract functions]

-- @brief abstract render function.
-- @param pos:JLib.Vector2
function UIElement:render(pos)
    error("This is abstrct function! UIElement:render(pos)")
end

-- @brief abstract Click Bubble down event function
-- @param e:JLib.UIEvent.ClickEventArgs
function UIElement:_ClickEvent(e)
    error("this is abstrcat function! UIElement:_ClickEvent(e)")
end

-- @brief abstract Scroll Bubble down event function
-- @param e:JLib.UIEvent.ScrollEventArgs
function UIElement:_ScrollEvent(e)
    error("This is abstract function! UIelement:_ScrollEvent(e)")
end

-- @brief abstract KeyInput bubble down event function
-- @param e:JLib.UIEvent.KeyInputEventArgs
function UIElement:_KeyInputEvent(e)
    error("This is abstract function!, UIElement:_KeyInputEvent(e)")
end