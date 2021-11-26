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
function Border:initialize(parent, screen, BorderThickness, BorderColor)
    JLib.UIElement.initialize(self, parent, screen) -- TODO check superclass constructor
    self.BorderThickness = BorderThickness or 1
    self.BorderColor = BorderColor or JLib.Enums.Colors.gray
end

-- [functions]

-- [overriding functions]

function Border:render(renderOffset)
    local renderOffset_ = renderOffset or JLib.Vector2:new(1, 1)
    local pos_ = JLib.UITools.calcRelativeOffset(self.Pos, renderOffset_)
    print("global render pos:" .. pos_:toString())
    self._screen.write("testttt")
end

function Border:render_Raw(x, y)
    if ((x == nil) or (y == nil)) then
        Border:render()
    else
        Border:render(JLib.Vector2:new(x, y))
    end
end

