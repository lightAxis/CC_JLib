local class = require("Class.middleclass")

-- #includes
require("UI.Enums")
require("MathLib.Vector2")

-- public class UITools   
---  
---**require** : 
--- - Class.middleclass
--- - UI.Enums
--- - MathLib.Vector2
local UITools = class("UITools")

-- namespace JLib
JLib = JLib or {}
JLib.UITools = UITools

-- [constructor]

---constructor
function UITools:initialize() end

-- [functions]

-- position 2 value to length
---@param pmin number
---@param pmax number
---@return number
function UITools.Pos2Len(pmin, pmax) return pmax - pmin + 1 end

-- length to position 2 value, based on start 
---@param startAt number
---@param len number
---@return number
function UITools.Len2Pos_FromStart(startAt, len)
    return startAt, len + startAt - 1
end

-- length to position 2 value, based on end
---@param endAt number
---@param len number
---@return number
function UITools.Len2Pos_FromEnd(endAt, len) return endAt - len + 1, endAt end

-- calc horizontal Align positions
---@param min number
---@param max number
---@param len number
---@param mode Enums.HorizontalAlignmentMode
function UITools.calcHorizontalAlignPos(min, max, len, mode)
    local x;
    local xlen = UITools.Pos2Len(min, max)

    if (mode == JLib.Enums.HorizontalAlignmentMode.left) then
        x = 1
    elseif (mode == JLib.Enums.HorizontalAlignmentMode.right) then
        x = xlen - len + 1
    elseif (mode == JLib.Enums.HorizontalAlignmentMode.center) then
        x = math.floor((xlen - len) / 2) + 1
    end

    return x
end

-- calc vertical Align positions
---@param min number
---@param max number
---@param len number
---@param mode Enums.VerticalAlignmentMode
---@return number y
function UITools.calcVerticalAlignPos(min, max, len, mode)
    local y;
    local ylen = UITools.Pos2Len(min, max)

    if (mode == JLib.Enums.VerticalAlignmentMode.top) then
        y = 1
    elseif (mode == JLib.Enums.VerticalAlignmentMode.bottom) then
        y = ylen - len + 1
    elseif (mode == JLib.Enums.VerticalAlignmentMode.center) then
        y = math.floor((ylen - len) / 2) + 1
    end

    return y
end

-- calc relative position. as pos(1,1) is origin of offset
---@param origin Vector2
---@param offset Vector2
---@return Vector2
function UITools.calcRelativeOffset(origin, offset)
    return origin + offset - JLib.Vector2:new(1, 1)

end

-- calc relative position, move only x axis, as pos(1,1) is origin of offset
---@param origin Vector2
---@param offset_x number
---@return Vector2
function UITools.calcRelativeOffset_X(origin, offset_x)
    return JLib.Vector2:new(origin.x + offset_x - 1, origin.y)
end

---@brief calc relative position, move only y axis, as pos(1,1) is origin of offset
---@param origin Vector2
---@param offset_y number
---@return Vector2
function UITools.calcRelativeOffset_Y(origin, offset_y)
    return JLib.Vector2:new(origin.x, origin.y + offset_y - 1)
end

--- calc relative position offset, in 1D number as 1 is origin of offset
---@param origin number
---@param offset number
---@return number
function UITools.calcRelativeOffset_Raw(origin, offset)
    return origin + offset - 1
end

---transform global position to local position in UIElement
---@param globalPos Vector2
---@param localOrigin Vector2
---@return Vector2
function UITools.transformGlobalPos2LocalPos(globalPos, localOrigin)
    return JLib.Vector2:new(globalPos.x - localOrigin.x + 1,
                            globalPos.y - localOrigin.y + 1)
end

---transform local position to global position in UIElement
---@param localPos Vector2
---@param localOrigin Vector2
---@return Vector2
function UITools.transformLocalPos2GlobalPos(localPos, localOrigin)
    return JLib.Vector2:new(localPos.x + localOrigin.x - 1,
                            localPos.y + localOrigin.y - 1)
end

---transform global index to local index in UIelement
---@param globalIndex number
---@param localOrigin number
---@return number
function UITools.transformGlobalIndex2LocalIndex(globalIndex, localOrigin)
    return globalIndex - localOrigin + 1
end

---transform local index to global index in UIelement
---@param localIndex number
---@param localOrigin number
---@return number
function UITools.transformLocalIndex2GlobalIndex(localIndex, localOrigin)
    return localIndex + localOrigin - 1
end

-- calc if point in square area
---@param pos Vector2
---@param len Vector2
---@param checkpos Vector2
---@return boolean isSquareInside
function UITools.isInsideSquare(pos, len, checkpos)
    local x1, x2 = UITools.Len2Pos_FromStart(pos.x, len.x)

    if ((x1 <= checkpos.x) and (checkpos.x <= x2)) then
        local y1, y2 = UITools.Len2Pos_FromStart(pos.y, len.y)
        if ((y1 <= checkpos.y) and (checkpos.y <= y2)) then return true end
    end
    return false

end

-- calc if point in square area. use only lua type
---@param pos_x number
---@param pos_y number
---@param len_x number
---@param len_y number
---@param checkpos_x number
---@param checkpos_y number
---@return boolean isInsideSquare
function UITools.isInsideSquare_Raw(pos_x, pos_y, len_x, len_y, checkpos_x,
                                    checkpos_y)
    local x1, x2 = UITools.Len2Pos_FromStart(pos_x, len_x)

    if ((x1 <= checkpos_x) and (checkpos_x <= x2)) then
        local y1, y2 = UITools.Len2Pos_FromStart(pos_y, len_y)
        if ((y1 <= checkpos_y) and (checkpos_y <= y2)) then return true end
    end
    return false
end

-- get empth string to write 
---@param len string
---@return string emptystring
function UITools.getEmptyString(len)
    local r = ""
    for i = 1, len, 1 do r = r .. " " end
    return r
end

---draw line in x axis
---@param screen Screen
---@param startPos Vector2
---@param len number
---@param bg Enums.Color
function UITools.drawLine_x(screen, startPos, len, bg)
    local str = UITools.getEmptyString(len)
    screen:setCursorPos(startPos)
    screen:setBackgroundColor(bg)
    screen:write(str)
end

---draw line in y axis
---@param screen Screen
---@param startPos Vector2
---@param len number
---@param bg Enums.Color
function UITools.drawLine_y(screen, startPos, len, bg)
    local startPos_ = startPos:Copy()
    screen:setCursorPos(startPos)
    screen:setBackgroundColor(bg)
    for i = 1, len, 1 do
        screen:write(" ")
        startPos_.y = startPos_.y + 1
        screen:setCursorPos(startPos_)
    end
end

---constrain value in range.
---@param number number
---@param min number  
---@param max number
---@return number
function UITools.constrain(number, min, max)
    if (number < min) then return min end
    if (max < number) then return max end
    return number
end