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
---@field new fun(self:Grid, Len:Vector2, Pos?:Vector2):Grid

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

    self._LensX = self:__getLens(self.targetLen.x, self.horizontalSettings)
    self._LensY = self:__getLens(self.targetLen.y, self.verticalSettings)

    for i = 2, horizontalLength, 1 do
        self._LensX[i] = self._LensX[i - 1] + self._LensX[i]
    end
    for i = 2, verticalLength, 1 do
        self._LensY[i] = self._LensY[i - 1] + self._LensY[i]
    end

    for i, v in ipairs(self._LensX) do
        self._LensX[i] = math.floor(v + 0.5)
    end

    for i, v in ipairs(self._LensY) do
        self._LensY[i] = math.floor(v + 0.5)
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

---get length segments array
---@param len number
---@param segStr table<number, string>
function Grid:__getLens(len, segStr)
    local temp_ts = {}
    local starSum = 0
    local LenSum = 0
    local starUnitLen = 0
    for index, value in ipairs(segStr) do
        temp_ts[index] = {}
        if string.match(value, "*") then
            local starti, endi = string.find(value, "*")
            local starNum = string.sub(value, 1, starti - 1)
            if (starNum == "") then starNum = "1" end
            temp_ts[index].isFix = false
            temp_ts[index].num = tonumber(starNum)
            if (temp_ts[index].num == nil) then error("segStr parse failed!") end
            starSum = starSum + temp_ts[index].num
        else
            temp_ts[index].isFix = true
            temp_ts[index].num = tonumber(value)
            if (temp_ts[index].num == nil) then error("segStr parse failed!") end
            LenSum = LenSum + temp_ts[index].num
        end
    end
    if (len < LenSum) then error("segStr total static len is larger than targetLen!") end
    starUnitLen = (len - LenSum) / starSum

    local resultLens = {}
    for i, v in ipairs(temp_ts) do
        if (v.isFix) then
            resultLens[i] = v.num
        else
            -- self._LensX[i] = math.floor((horisetting[i].num * horistar) + 0.5)
            resultLens[i] = v.num * starUnitLen
        end
    end

    return resultLens
end
