local class = require("Class.middleclass")

-- #includes
require("UI.Enums")
require("MathLib.Vector2")

-- public class Tools
local UITools = class("UITools")

-- namespace JLib
JLib = JLib or {}
JLib.UITools = UITools

-- [constructor]
function UITools:initialize() end

-- [functions]

-- @brief position 2 value to length
-- @param pmin:num
-- @param pmax:num
function UITools.Pos2Len(pmin, pmax) return pmin - pmax + 1 end

-- @brief length to position 2 value, based on start 
-- @param startAt:num
-- @param len:num
function UITools.Len2Pos_FromStart(startAt, len)
    return startAt, len + startAt - 1
end

-- @brief length to position 2 value, based on end
-- @param endAt:num
-- @param len:num
function UITools.Len2Pos_FromEnd(endAt, len) return endAt - len + 1, endAt end

-- @brief calc horizontal Align positions
-- @param min:num
-- @param max:num
-- @param len:num
-- @param mode:JLib.Enums.eHorizontalAlignmentMode
function UITools.calchorizontalAlignPos(min, max, len, mode)
    local x;
    local xlen = UITools.Pos2Len(min, max)

    if (mode == JLib.Enums.HorizontalAlignmentMode.left) then
        x = 1
    elseif (mode == JLib.Enums.HorizontalAlignmentMode.right) then
        x = xlen - len + 1
    elseif (mode == JLib.Enums.HorizontalAlignmentMode.center) then
        x = math.floor((xlen - len) / 2) + 1
    end
end

-- @brief calc vertical Align positions
-- @param min:num
-- @param max:num
-- @param len:num
-- @param mode:JLib.Enums.eVerticalAlignmentMode
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
end

-- @brief calc relative position. as pos(1,1) is origin of offset
-- @param origin:JLib.Vector2
-- @param offset:JLib.Vector2
-- @return JLib.Vector2
function UITools.calcRelativeOffset(origin, offset)
    return origin + offset - JLib.Vector2:new(1, 1)

end

-- @brief calc relative position, move only x axis, as pos(1,1) is origin of offset
-- @param origin:JLib.Vector2
-- @param offset_x:num
-- return JLib.Vector2
function UITools.calcRelativeOffset_X(origin, offset_x)
    return UITools.calcRelativeOffset(origin, JLib.Vector2:new(offset_x, 1))
end

-- @brief calc relative position, move only y axis, as pos(1,1) is origin of offset
-- @param origin:JLib.Vector2
-- @param offset_y:num
-- return JLib.Vector2
function UITools.calcRelativeOffset_Y(origin, offset_y)
    return UITools.calcRelativeOffset(origin, JLib.Vector2:new(1, offset_y))
end

-- @brief calc if point in square area
-- @param pos:JLib.Vector2
-- @param len:JLib.Vector2
-- @param checkpos:JLib.Vector2
function UITools.isInsideSquare(pos, len, checkpos)
    local x1, x2 = UITools.Len2Pos_FromStart(pos.x, len.x)

    if ((x1 <= checkpos.x) and (checkpos.x <= x2)) then
        local y1, y2 = UITools.Len2Pos_FromStart(pos.y, len.y)
        if ((y1 <= checkpos.y) and (checkpos.y <= y2)) then return true end
    end
    return false

end

-- @brief calc if point in square area. use only lua type
-- @param pos:JLib.Vector2
-- @param len:JLib.Vector2
-- @param checkpos:vector2
function UITools.isInsideSquare_Raw(pos_x, pos_y, len_x, len_y, checkpos_x,
                                    checkpos_y)
    local x1, x2 = UITools.Len2Pos_FromStart(pos_x, len_x)

    if ((x1 <= checkpos_x) and (checkpos_x <= x2)) then
        local y1, y2 = UITools.Len2Pos_FromStart(pos_y, len_y)
        if ((y1 <= checkpos_y) and (checkpos_y <= y2)) then return true end
    end
    return false
end

-- @brief get empth string to write 
function UITools.getEmptyString(len)
    local r = ""
    for i = 1, len, 1 do r = r .. " " end
    return r
end

function UITools.drawLine_x(screen, startPos, len, bg)
    local str = UITools.getEmptyString(len)
    screen:setCursorPos(startPos)
    screen:setBackgroundColor(bg)
    screen:write(str)
end

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

function UITools.clearScreen(screen)
    screen:setBackgroundColor(JLib.Enums.Colors.black)
    screen:clear()
end
