local class = require("Class.middleclass")

---public class Grid
---@class Grid
local Grid = class("Grid")

---namespace JLib
JLib.Grid = Grid

---constructo
---@param Len Vector2   
---@param Pos? Vector2 or (1,1)
function Grid:initialize(Len, Pos)
    self.targetLen = Len:Copy()
    self.Offset = Pos or JLib.Vector2:new(1, 1)
    self.horizontalSettings = {}
    self.verticalSettings = {}
    self._LensX = {}
    self._LensY = {}
end

---properties description
---@class Grid
---@field targetLen Vector2
---@field new fun(self:Grid, Len:Vector2, Pos:Vector2):Grid

---set horizontal setting, table<number, string>, "num", "num*"
---@param setting table<number, string>
function Grid:setHorizontalSetting(setting) self.horizontalSettings = setting end

---set vertical setting, table<number, string>, "num", "num*"
---@param setting table<number, string>
function Grid:setVerticalSetting(setting) self.verticalSettings = setting end

---update internal position length
function Grid:updatePosLen()
    local horizontalLength = #(self.horizontalSettings)
    local verticalLength = #(self.verticalSettings)

    local horisetting = {}
    local horistarSum = 0
    local horiLenSum = 0
    local horistar = 0
    for index, value in ipairs(self.horizontalSettings) do
        horisetting[index] = {}
        if string.match(value, "*") then
            local starti, endi = string.find(value, "*")
            local starNum = string.sub(value, 1, starti - 1)
            if (starNum == "") then starNum = "1" end
            horisetting[index].isFix = false
            horisetting[index].num = tonumber(starNum)
            horistarSum = horistarSum + horisetting[index].num
        else
            horisetting[index].isFix = true
            horisetting[index].num = tonumber(value)
            horiLenSum = horiLenSum + horisetting[index].num
        end
    end
    horistar = (self.targetLen.x - horiLenSum) / horistarSum

    for i, v in ipairs(self.horizontalSettings) do
        if (horisetting[i].isFix) then
            self._LensX[i] = horisetting[i].num
        else
            self._LensX[i] = math.floor((horisetting[i].num * horistar) + 0.5)
        end
    end

    local versetting = {}
    local verstarSum = 0
    local verLenSum = 0
    local verstar = 0
    for index, value in ipairs(self.verticalSettings) do
        versetting[index] = {}
        if string.match(value, "*") then
            local starti, endi = string.find(value, "*")
            local starNum = string.sub(value, 1, starti - 1)
            if (starNum == "") then starNum = "1" end
            versetting[index].isFix = false
            versetting[index].num = tonumber(starNum)
            verstarSum = verstarSum + versetting[index].num
        else
            versetting[index].isFix = true
            versetting[index].num = tonumber(value)
            verLenSum = verLenSum + versetting[index].num
        end
    end
    verstar = (self.targetLen.y - verLenSum) / verstarSum

    for i, v in ipairs(self.verticalSettings) do
        if (versetting[i].isFix) then
            self._LensY[i] = versetting[i].num
        else
            self._LensY[i] = math.floor((versetting[i].num * verstar) + 0.5)
        end
    end

    for i = 2, horizontalLength, 1 do
        self._LensX[i] = self._LensX[i - 1] + self._LensX[i]
    end
    for i = 2, verticalLength, 1 do
        self._LensY[i] = self._LensY[i - 1] + self._LensY[i]
    end

end

---get Position and length
---@param col number column number > 1
---@param row number row number > 1
---@param colSpan? number column span number > 1
---@param rowSpan? number row span number > 1
---@return Vector2 Pos
---@return Vector2 Len
function Grid:getPosLen(col, row, colSpan, rowSpan)

    return self:getPosLenWithMargin(col, row, colSpan, rowSpan, 0, 0, 0, 0)

end

---get Position and length with margin applied
---@param col number column number > 1
---@param row number row number > 1
---@param colSpan? number column span number > 1
---@param rowSpan? number row span number > 1
---@param marginLeft? number margin > 0
---@param marginRight? number margin >0
---@param marginTop? number margin >0
---@param marginBottom? number margin >0
---@return Vector2 Pos
---@return Vector2 Len
function Grid:getPosLenWithMargin(col, row, colSpan, rowSpan, marginLeft,
                                  marginRight, marginTop, marginBottom)
    local colspan = colSpan or 1
    local rowspan = rowSpan or 1

    local Pos = JLib.Vector2:new(0, 0)
    local Len = JLib.Vector2:new(0, 0)

    if (col == 1) then
        Pos.x = 1
        Len.x = self._LensX[colSpan]
    else
        Pos.x = self._LensX[col - 1] + 1
        Len.x = self._LensX[col + colspan - 1] - self._LensX[col - 1]
    end

    if (row == 1) then
        Pos.y = 1
        Len.y = self._LensY[rowSpan]
    else
        Pos.y = self._LensY[row - 1] + 1
        Len.y = self._LensY[row + rowspan - 1] - self._LensY[row - 1]
    end

    local marginLeft = marginLeft or 0
    local marginRight = marginRight or 0
    local marginTop = marginTop or 0
    local marginBottom = marginBottom or 0

    Pos.x = Pos.x + marginLeft
    Len.x = Len.x - marginLeft

    Len.x = Len.x - marginRight

    Pos.y = Pos.y + marginTop
    Len.y = Len.y - marginTop

    Len.y = Len.y - marginBottom

    Len.x = math.min(Len.x, self.targetLen.x)
    Len.y = math.min(Len.y, self.targetLen.y)

    Pos = JLib.UITools.calcRelativeOffset(Pos, self.Offset)

    return Pos, Len
end
