local class = require("Class.middleclass")

-- #includes
require("UI.UIElement")
require("UI.UITools")
require("UI.Border")
require("UI.Margin")
require("UI.TextArea")

-- public class TextBlock : UIElement   
---  
---**require** :  
--- - Class.middleclass
--- - UI.UIElement
--- - UI.UITools
--- - UI.Border
--- - UI.Margin
--- - UI.TextArea
---@class TextBlock : UIElement
local TextBlock = class("TextBlock", JLib.UIElement)

-- namespace JLib
JLib = JLib or {}
JLib.TextBlock = TextBlock

-- constructor
---@param parent UIElement
---@param screen Screen
---@param name string
---@param text? string or ""
---@param PosRel? Vector2 or (1,1)
---@param Len? Vector2 or (1,1)
---@param bg? Enums.Color or Enums.Color.gray
---@param fg? Enums.Color or Enums.Color.white
function TextBlock:initialize(parent, screen, name, text, PosRel, Len, bg, fg)

    local PosRel_ = PosRel or JLib.Vector2:new(1, 1)
    local Len_ = Len or JLib.Vector2:new(1, 1)
    local bg_ = bg or JLib.Enums.Color.gray
    local fg_ = fg or JLib.Enums.Color.white

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

-- priperties description
---@class TextBlock : UIElement
---@field _Border Border
---@field _Margin Margin
---@field _TextArea TextArea
---@field new fun(parent: UIElement, screen: Screen, name: string, text?: string, PosRel?: Vector2, Len?: Vector3, bg?: Enums.Color, fg?: Enums.Color): TextBlock

-- functions

---@param thickness number
function TextBlock:setBorderThickness(thickness)
    self._Border.BorderThickness = thickness
end

---@param color Enums.Color
function TextBlock:setBorderColor(color) self._Border.BorderColor = color end

---@param margin number
function TextBlock:setMarginAll(margin) self._Margin:setMarginAll(margin) end

---@param marginLeft number
function TextBlock:setMarginLeft(marginLeft) self._Margin.MarginLeft =
    marginLeft end

---@param marginRight number
function TextBlock:setMarginRight(marginRight)
    self._Margin.MarginRight = marginRight
end

---@param marginTop number
function TextBlock:setMarginTop(marginTop) self._Margin.MarginTop = marginTop end

---@param marginBottom number
function TextBlock:setMarginBottom(marginBottom)
    self._Margin.MarginBottom = marginBottom
end

---get all four margins
---@return number left
---@return number right
---@return number top
---@return number bottom
function TextBlock:getMargin()
    return self._Margin.MarginLeft, self._Margin.MarginRight,
           self._Margin.MarginTop, self._Margin.MarginBottom
end

---@param align Enums.HorizontalAlignmentMode
function TextBlock:setTextHorizontalAlignment(align)
    self._TextArea:setHorizontalAlignment(align)
end

---@param align Enums.VerticalAlignmentMode
function TextBlock:setTextVerticalAlignment(align)
    self._TextArea:setVerticalAlignment(align)
end

---@param text string
function TextBlock:setText(text) self._TextArea:setText(text) end

---@param color Enums.Color
function TextBlock:setTextColor(color) self._TextArea.FG = color end

---@param scroll number
function TextBlock:setScroll(scroll) self._TextArea:setScroll(scroll) end

---@return number scrollIndex
function TextBlock:getScroll() return self._TextArea:getScroll() end

--- fill textarea with current BG
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

---overrided function from UIElement:render()
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

---overrided function from UIElement:_ClickEvent
---@param e ClickEventArgs
function TextBlock:_ClickEvent(e) end

---overrided function from UIElement:_ScrollEvent
---@param e ScrollEventArgs
function TextBlock:_ScrollEvent(e) end

---overrided function from UIElement:_KeyInputEvent
---@param e KeyInputEventArgs
function TextBlock:_KeyInputEvent(e) end

---overrided function from UIElement:_CharEvent
---@param e CharEventArgs
function TextBlock:_CharEvent(e) end

---overrided function from UIElement:PostRendering()
function TextBlock:PostRendering() end