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
    JLib.UIElement.initialize(self, parent, screen, name) -- TODO check superclass constructor
    self.BorderThickness = BorderThickness or 1
    self.BorderColor = BorderColor or JLib.Enums.Colors.gray
end

-- [functions]

-- [overriding functions]

function Border:render() -- renderOffset)
    -- get render offset
    -- local renderOffset_ = renderOffset or JLib.Vector2:new(1, 1)
    -- local pos_ = JLib.UITools.calcRelativeOffset(self.Pos, renderOffset_)
    local pos_ = self.Pos:Copy()
    -- print("global render pos:" .. pos_:toString())
    -- self._screen.write("testttt")
    local pos_leftUP1 = pos_:Copy()
    local pos_leftUP2 = pos_:Copy()
    local pos_leftDown = JLib.UITools.calcRelativeOffset_Y(pos_leftUP1,
                                                           self.Len.y)
    local pos_rightUp = JLib.UITools
                            .calcRelativeOffset_X(pos_leftUP1, self.Len.x)

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

    self:renderChildren()

end

function Border:render_Raw(x, y)
    if ((x == nil) or (y == nil)) then
        Border:render()
    else
        Border:render(JLib.Vector2:new(x, y))
    end
end