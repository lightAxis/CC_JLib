local class = require("Class.middleclass")

-- #includes
require("UI.UIElement")
require("UI.UITools")
require("UI.Border")
require("UI.Margin")
require("UI.TextArea")

-- public class TextBlock : UIElement
local TextBlock = class("TextBlock", JLib.UIElement)

-- namespace JLib 
JLib = JLib or {}
JLib.TextBlock = TextBlock

-- constructor
function TextBlock:initialize(parent, screen, name, PosRel, Len, bg, fg, text)

    local PosRel_ = PosRel or JLib.Vector2:new(1, 1)
    local Len_ = Len or JLib.Vector2:new(1, 1)
    local bg_ = bg or JLib.Enums.Colors.gray
    local fg_ = fg or JLib.Enums.Colors.white

    JLib.UIElement.initialize(self, parent, screen, name, PosRel_.x, PosRel_.y,
                              Len_.x, Len_.y, bg_, fg_)

    self._Border = JLib.Border:new(self, screen, name .. "/Border")
    self._Border.BorderThickness = 0

    self._Margin = JLib.Margin:new(self._Border, screen, name .. "/Margin")
    self._Margin:setMarginAll(0)

    self._TextArea = JLib.TextArea:new(self._Margin, screen,
                                       name .. "/TextArea", text or "")
    self._TextArea.BG = self.BG
    self._TextArea.FG = self.FG
end

-- functions
function TextBlock:setBorderThickness(thickness)
    self._Border.BorderThickness = thickness
end

function TextBlock:setBorderColor(color) self._Border.BorderColor = color end

function TextBlock:setMarginAll(margin) self._Margin:setMarginAll(margin) end

function TextBlock:setMarginLeft(marginLeft) self._Margin.MarginLeft =
    marginLeft end

function TextBlock:setMarginRight(marginRight)
    self._Margin.MarginRight = marginRight
end

function TextBlock:setMarginTop(marginTop) self._Margin.MarginTop = marginTop end

function TextBlock:setMarginBottom(marginBottom)
    self._Margin.MarginBottom = marginBottom
end

function TextBlock:getMargin()
    return self._Margin.MarginLeft, self._Margin.MarginRight,
           self._Margin.MarginTop, self._Margin.MarginBottom
end

function TextBlock:setTextHorizontalAlignment(align)
    self._TextArea:setHorizontalAlignment(align)
end

function TextBlock:setTextVerticalAlignment(align)
    self._TextArea:setVerticalAlignment(align)
end

function TextBlock:setText(text) self._TextArea:setText(text) end

function TextBlock:setTextColor(color) self._TextArea.FG = color end

function TextBlock:setScroll(scroll) self._TextArea:setScroll(scroll) end

function TextBlock:getScroll() return self._TextArea:getScroll() end

function TextBlock:_fillWithBG()
    self._screen:setBackgroundColor(self.BG)

    local str = JLib.UITools.getEmptyString(self.Len.x)
    local renderPos = self.Pos:Copy()
    for i = 1, self.Len.y, 1 do
        self._screen:setCursorPos(renderPos)
        self._screen:write(str)
        renderPos.y = renderPos.y + 1
    end
end

-- override functions

function TextBlock:render()
    -- update global pos
    self:_updatePos()

    -- fill inside the textblock with background color
    self:_fillWithBG()

    -- sync bg of textarea same with textblock
    self._TextArea.BG = self.BG

    -- render history check
    self:_addThisToRenderHistory()

    -- render children components
    self:renderChildren()

end
