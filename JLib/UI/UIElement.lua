local class = require("Class.middleclass")

-- #includes
require("MathLib.Vector2")
require("UI.Enums")
require("UI.UITools")

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

-- [abstract functions]

-- @brief abstrcat render function.
-- @param pos:JLib.Vector2
function UIElement:render(pos)
    error("This is abstrct function! UIElement:render(pos)")
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

function UIElement:_updateLengthFromParent()
    self.Len.x = self.Parent.Len.x
    self.Len.x = math.max(1, self.Len.x)
    self.Len.y = self.Parent.Len.y
    self.Len.y = math.max(1, self.Len.y)
end

function UIElement:_addThisToRenderHistory()
    table.insert(self._screen._renderHistory, self)
end

function UIElement:_ClickEvent() end
