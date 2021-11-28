local class = require("Class.middleclass")

-- #includes
require("UI.UIElement")
require("UI.Enums")
require("UI.UITools")

require("LibGlobal.StaticMethods")

-- public class TextBlock : UIElement
local TextBlock = class("TextBlock", JLib.UIElement)

-- namespace JLib
JLib = JLib or {}
JLib.TextBlock = TextBlock

-- [constructor]
function TextBlock:initialize(parent, screen, name, text)
    JLib.UIElement.initialize(self, parent, screen, name)

    self._HorizontalAlignmentMode = JLib.Enums.HorizontalAlignmentMode.left
    self._VerticalAlignmentMode = JLib.Enums.VerticalAlignmentMode.top

    self._TextSplited = {}

    self._Text = text or ""
    self._isTextChanged = false

    self:setText(self._Text)

    self._scroll = 1
end
-- [functions]

function TextBlock:setText(text)
    if (text == nil) then
        error("TextBlock:setText(text) : text must be string")
    end
    self._Text = text
    -- self:_getTextSplited()

    self._isTextChanged = true
end

-- @brief set vertical alignment mode of textblock
-- @param align:JLib.Enums.VerticalAlignmentMode
function TextBlock:setVerticalAlignment(align)
    self._VerticalAlignmentMode = align
    self._isTextChanged = true
end

-- @brief set horizontal alignment mode of textblock
-- @param align:JLib.Enums.HorizontalAlignmentMode
function TextBlock:setHorizontalAlignment(align)
    self._HorizontalAlignmentMode = align
    self._isTextChanged = true
end

function TextBlock:getText() return self._Text end

function TextBlock:render()
    if (self._isTextChanged == false) then return end

    self:_getTextSplited()

    local maxScrol = self._scroll + self.Len.y - 1
    local tempTextSplited = {}

    local parent_ = nil

    if (self.Parent ~= nil) then
        parent_ = self.Parent.Pos
    else
        parent_ = JLib.Vector2:new(1, 1)
    end

    self._screen:setBackgroundColor(self.BG)
    self._screen:setTextColor(self.FG)

    local renderPos = JLib.UITools.calcRelativeOffset(parent_, self.PosRel)

    local i = 1
    for index, value in ipairs(self._TextSplited) do
        for index2, value2 in ipairs(value.wrapped_text) do
            -- table.insert(tempTextSplited,
            --              {['text'] = value2.text, ['align'] = value2.align})
            self._screen:setCursorPos(JLib.UITools.calcRelativeOffset_X(
                                          renderPos, value2.align))
            self._screen:write(value2.text)

            renderPos.y = renderPos.y + 1
            i = i + 1
            if (i > maxScrol) then goto end_ end
        end
    end
    ::end_::

    self._isTextChanged = false
end
-- 렌더

-- 텍스트 인풋

-- 텍스트 잘라서 표시
function TextBlock:_getTextSplited()
    local text_ = self._Text

    -- split text with '\n'
    local textSplitted_ = self._Text:split("\n")

    -- split by text with \n
    local lengthSum = 1
    self._TextSplited = {}
    for index, value in ipairs(textSplitted_) do
        local TextSplitted_node = {
            ['index'] = lengthSum,
            ['text'] = value,
            ['wrapped_text'] = {}
        }
        table.insert(self._TextSplited, TextSplitted_node)
        lengthSum = lengthSum + #value + 1
    end

    -- split text by length of element
    for i, v in ipairs(self._TextSplited) do
        local textline = v.text
        local textline_spliited = ""
        local textline_anchor = 1
        if (textline == "") then
            local temp = {['index'] = 1, ['text'] = "", ['align'] = 1}
            table.insert(v.wrapped_text, temp)
            goto continue
        end

        while (#textline >= self.Len.x) do
            textline_spliited = string.sub(textline, 1, self.Len.x)

            local temp = {
                ['index'] = textline_anchor,
                ['text'] = textline_spliited,
                ['align'] = 1
            }
            table.insert(v.wrapped_text, temp)

            textline_anchor = textline_anchor + self.Len.x
            textline = string.sub(textline, self.Len.x + 1, #textline)
        end

        if (textline ~= "") then
            textline_spliited = textline
            local temp = {
                ['index'] = textline_anchor,
                ['text'] = textline,
                ['align'] = JLib.UITools.calcHorizontalAlignPos(1, self.Len.x,
                                                                #textline_spliited,
                                                                self._HorizontalAlignmentMode)
            }
            table.insert(v.wrapped_text, temp)
        end
        ::continue::
    end
end

-- 텍스트 정렬모드 설정

