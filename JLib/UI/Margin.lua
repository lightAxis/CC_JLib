local class = require("Class.middleclass")

-- #includes 
require("UI.UIElement")

-- public class Margin
local Margin = class("Margin", JLib.UIElement)

-- namespace JLib
JLib = JLib or {}
JLib.Margin = Margin

-- constructor
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

-- functions

-- @brief sell all 4 margin
-- @param margin:num
function Margin:setMarginAll(margin)
    self.MarginLeft = margin;
    self.MarginRight = margin;
    self.MarginTop = margin;
    self.MarginBottom = margin;
end

-- overridiong functions

function Margin:render()
    -- update self length from parent and margin
    self:_updateLengthFromParent()

    -- update self PosRel from margin
    self:_updatePosRelFromMargin()

    -- update global position
    self:_updatePos()

    -- render children
    self:renderChildren()

end

function Margin:_updateLengthFromParent()
    self.Len.x = self.Parent.Len.x - self.MarginLeft - self.MarginRight
    self.Len.x = math.max(1, self.Len.x)
    self.Len.y = self.Parent.Len.y - self.MarginTop - self.MarginBottom
    self.Len.y = math.max(1, self.Len.y)
end

function Margin:_updatePosRelFromMargin()
    self.PosRel.x = self.MarginLeft + 1
    self.PosRel.y = self.MarginTop + 1
end
