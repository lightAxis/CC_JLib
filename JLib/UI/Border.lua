local class = require("Class.middleclass")

-- #includes
require("UI.UIElement")
require("UI.UITools")

-- public class Border : UIElement
local Border = class("Border", JLib.UIElement)

-- namespace
JLib = JLib or {}
JLib.Border = Border

-- [constructor]
function Border:initialize(parent, screen, name, BorderThickness, BorderColor)
    if (parent == nil) then error("border must have a parent UIElement!") end
    JLib.UIElement.initialize(self, parent, screen, name)
    self.BorderThickness = BorderThickness or 1
    self.BorderColor = BorderColor or JLib.Enums.Colors.gray
end

-- [functions]

function Border:_drawBorder()
    -- get four anchor pos
    local pos_ = self.Pos:Copy()
    local pos_leftUP1 = pos_:Copy()
    local pos_leftUP2 = pos_:Copy()
    local pos_leftDown = JLib.UITools.calcRelativeOffset_Y(pos_leftUP1,
                                                           self.Len.y)
    local pos_rightUp = JLib.UITools.calcRelativeOffset_X(pos_leftUP1,
                                                          self.Len.x)

    -- draw lines
    for i = 1, self.BorderThickness, 1 do

        JLib.UITools.drawLine_x(self._screen, pos_leftUP1, self.Len.x,
                                self.BorderColor)
        JLib.UITools.drawLine_y(self._screen, pos_leftUP2, self.Len.y,
                                self.BorderColor)
        JLib.UITools.drawLine_x(self._screen, pos_leftDown, self.Len.x,
                                self.BorderColor)
        JLib.UITools.drawLine_y(self._screen, pos_rightUp, self.Len.y,
                                self.BorderColor)

        pos_leftUP1.y = pos_leftUP1.y + 1
        pos_leftUP2.x = pos_leftUP2.x + 1
        pos_leftDown.y = pos_leftDown.y - 1
        pos_rightUp.x = pos_rightUp.x - 1
    end
end

-- [overriding functions]

function Border:render() -- renderOffset)
    -- cannot change border PosRel
    self.PosRel.x = 1
    self.PosRel.y = 1

    -- update global pos
    self:_updatePos()

    -- update length from parent
    self:_updateLengthFromParent()

    -- draw actual lines
    self:_drawBorder()

    -- render history add
    self:_addThisToRenderHistory()

    -- render children
    self:renderChildren()

end

function Border:_ClickEvent(e) end

function Border:_ScrollEvent(e) end

function Border:_KeyInputEvent(e) end
