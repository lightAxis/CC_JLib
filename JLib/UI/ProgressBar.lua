---@module "Class.middleclass"
local class = require("Class.middleclass")

---#includes
require("UI.UIElement")
require("UI.UITools")

-- public class ProgressBar : UIElement
---
---**require**
--- - Class.middleclass
--- - UI.UIElement
--- - UI.UITools
---@class ProgressBar : UIElement
local ProgressBar = class("ProgressBar", JLib.UIElement)

--- namespace JLib
JLib = JLib or {}
JLib.ProgressBar = ProgressBar

-- [constructor]

---comment
---@param parent UIElement
---@param screen Screen
---@param name string
---@param BarBG? Enums.Color default:cyan
---@param dir? Enums.Direction default:horizontal
function ProgressBar:initialize(parent, screen, name, dir, BarBG)
    if (parent == nil) then error("ProgressBar must have a parent UIElement!") end
    JLib.UIElement.initialize(self, parent, screen, name)

    self.BarBG = BarBG or JLib.Enums.Color.cyan
    self.BarDirection = dir or JLib.Enums.Direction.horizontal
    self.IsBGTransparent = false

    ---@type number
    self.__value = 0
end

-- [properties description]

---@class ProgressBar
---@field BarBG Enums.Color
---@field __value number
---@field new fun(self:ProgressBar, parent: UIElement, screen: Screen, name:string, dir?:Enums.Direction, BarBG?: Enums.Color):ProgressBar

---set value of progressbar
---@param value number 0<=value<=1
function ProgressBar:setValue(value)
    value = JLib.UITools.constrain(value, 0.0, 1.0);
    self.__value = value
end

---get value of progressBar
---@return number value
function ProgressBar:getValue()
    return self.__value
end

function ProgressBar:__drawBar()
    local totalLen = 0
    if self.BarDirection == JLib.Enums.Direction.horizontal then
        totalLen = self.Len.x
    elseif self.BarDirection == JLib.Enums.Direction.vertical then
        totalLen = self.Len.y
    else
        totalLen = self.Len.x
    end

    local targetLen = math.floor(totalLen * self.__value + 0.001)
    local restLen = totalLen - targetLen


    if self.BarDirection == JLib.Enums.Direction.horizontal then

        local tempPos = self.Pos:Copy()
        local _, endY = JLib.UITools.Len2Pos_FromStart(self.Pos.y, self.Len.y)

        for y = self.Pos.y, endY, 1 do
            tempPos.y = y
            self._screen:setCursorPos(tempPos)
            self._screen:setBackgroundColor(self.BarBG)
            self._screen:write(JLib.UITools.getEmptyString(targetLen))
            self._screen:setBackgroundColor(self.BG)
            self._screen:write(JLib.UITools.getEmptyString(restLen))
        end

    elseif self.BarDirection == JLib.Enums.Direction.vertical then
        local tempPos = self.Pos:Copy()
        local _, restY = JLib.UITools.Len2Pos_FromStart(self.Pos.y, restLen)
        local _, endY = JLib.UITools.Len2Pos_FromStart(self.Pos.y, self.Len.y)

        if restLen > 0 then
            self._screen:setBackgroundColor(self.BG)
            for y = tempPos.y, restY, 1 do
                tempPos.y = y
                self._screen:setCursorPos(tempPos)
                self._screen:write(JLib.UITools.getEmptyString(self.Len.x))
            end
            tempPos.y = tempPos.y + 1
        end

        self._screen:setBackgroundColor(self.BarBG)
        for y = tempPos.y, endY, 1 do
            tempPos.y = y
            self._screen:setCursorPos(tempPos)
            self._screen:write(JLib.UITools.getEmptyString(self.Len.x))
        end
    end

    return 0

end

-- [overriding functions]

---overrided function from UIElement:render()
function ProgressBar:render() -- renderOffset)

    -- update global pos
    self:_updatePos()

    -- draw actual lines
    self:__drawBar()

    -- render history add
    self:_addThisToRenderHistory()

    -- render children
    self:renderChildren()

end

---overrided function from UIElement:_ClickEvent
---@param e ClickEventArgs
function ProgressBar:_ClickEvent(e) end

---overrided function from UIElement:_ScrollEvent
---@param e ScrollEventArgs
function ProgressBar:_ScrollEvent(e) end

---overrided function from UIElement:_KeyInputEvent
---@param e KeyInputEventArgs
function ProgressBar:_KeyInputEvent(e) end

---overrided function from UIElement:_CharEvent
---@param e CharEventArgs
function ProgressBar:_CharEvent(e) end

---overrided function from UIElement:PostRendering()
function ProgressBar:PostRendering() end

---overrided function from UIElement:FocusIn()
function ProgressBar:FocusIn() end

---overrided function from UIElement:FocusOut()
function ProgressBar:FocusOut() end
