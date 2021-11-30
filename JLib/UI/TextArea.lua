local class = require("Class.middleclass")

-- #includes
require("UI.UIElement")
require("UI.Enums")
require("UI.UITools")
require("MathLib.Vector2")

require("LibGlobal.StaticMethods")

-- public class TextBlock : UIElement
local TextArea = class("TextArea", JLib.UIElement)

-- namespace JLib
JLib = JLib or {}
JLib.TextArea = TextArea

-- [constructor]
function TextArea:initialize(parent, screen, name, text)
    if (parent == nil) then error("TextArea must have a parent UIElement!") end
    JLib.UIElement.initialize(self, parent, screen, name)

    self._HorizontalAlignmentMode = JLib.Enums.HorizontalAlignmentMode.left
    self._VerticalAlignmentMode = JLib.Enums.VerticalAlignmentMode.top

    self._TextSplited = {}
    self._TextSplitedViewport = {}
    self._TextSplitedViewportLines = {}

    self._Text = text or ""

    self:setText(self._Text)
    self:setHorizontalAlignment(self._HorizontalAlignmentMode)
    self:setVerticalAlignment(self._VerticalAlignmentMode)

    self._scroll = 1
end
-- [functions]

function TextArea:setText(text)
    if (text == nil) then
        error("TextBlock:setText(text) : text must be string")
    end
    self._Text = text
    -- self:_getTextSplited()
    self:_updateTextSplited()
end

-- @brief set vertical alignment mode of textblock
-- @param align:JLib.Enums.VerticalAlignmentMode
function TextArea:setVerticalAlignment(align) self._VerticalAlignmentMode =
    align end

-- @brief set horizontal alignment mode of textblock
-- @param align:JLib.Enums.HorizontalAlignmentMode
function TextArea:setHorizontalAlignment(align)
    self._HorizontalAlignmentMode = align
    self:_updateTextHorizontalAligned()
end

function TextArea:getText() return self._Text end

function TextArea:setScroll(scroll) self._scroll = math.max(1, scroll) end

function TextArea:getScroll() return self._scroll end

function TextArea:render()
    -- textarea cannot have pos rel
    self.PosRel.x = 1
    self.PosRel.y = 1

    -- update global position
    self:_updatePos()

    -- textarea must follow the length of parent
    self:_updateLengthFromParent()

    -- update wrap of splitted string with \n
    self:_updateTextSplitedViewport()

    -- check if scroll index is avilable
    local minScroll, maxScroll = self:_wrapScroll()

    -- update text splitted lines with black " "
    self:_updateTextSplitedLines(minScroll, maxScroll)

    -- print text splitted lines
    self:_printTextLines()

    -- render children
    self:renderChildren()
end

function TextArea:_updateTextSplited()
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

end

function TextArea:_updateTextSplitedViewport()
    self._TextSplitedViewport = {}

    -- split text by length of element
    for i, v in ipairs(self._TextSplited) do
        local textline = v.text
        local textline_spliited = ""
        local textline_anchor = 1

        local superContinue = false
        if (textline == "") then
            local temp = {
                ['index'] = 1,
                ['text'] = "",
                ['align'] = 1,
                ['parent'] = nil
            }
            table.insert(v.wrapped_text, temp)
            table.insert(self._TextSplitedViewport, temp)
            temp.parent = v
            superContinue = true
        end

        if (superContinue == false) then
            while (#textline >= self.Len.x) do
                textline_spliited = string.sub(textline, 1, self.Len.x)

                local temp = {
                    ['index'] = textline_anchor,
                    ['text'] = textline_spliited,
                    ['align'] = 1,
                    ['parent'] = nil
                }
                table.insert(v.wrapped_text, temp)
                table.insert(self._TextSplitedViewport, temp)
                temp.parent = v

                textline_anchor = textline_anchor + self.Len.x
                textline = string.sub(textline, self.Len.x + 1, #textline)
            end

            if (textline ~= "") then
                textline_spliited = textline
                local temp = {
                    ['index'] = textline_anchor,
                    ['text'] = textline,
                    ['align'] = JLib.UITools.calcHorizontalAlignPos(1,
                                                                    self.Len.x,
                                                                    #textline_spliited,
                                                                    self._HorizontalAlignmentMode),
                    ['parent'] = nil
                }
                table.insert(v.wrapped_text, temp)
                table.insert(self._TextSplitedViewport, temp)
                temp.parent = v
            end
        end
    end
end

function TextArea:_updateTextHorizontalAligned()

    for index, value in ipairs(self._TextSplitedViewport) do
        value.align = JLib.UITools.calcHorizontalAlignPos(1, self.Len.x,
                                                          #(value.text),
                                                          self._HorizontalAlignmentMode)
    end
end

function TextArea:_wrapScroll()
    local minScroll = self._scroll
    minScroll = math.max(minScroll, 1)

    local maxScroll = self._scroll + self.Len.y - 1
    maxScroll = math.min(maxScroll, #(self._TextSplitedViewport))

    minScroll = math.max(maxScroll - self.Len.y + 1, 1)
    self._scroll = minScroll
    return minScroll, maxScroll
end

function TextArea:_updateTextSplitedLines(minScroll, maxScroll)
    local renderPos = self.Pos:Copy()
    self._TextSplitedViewportLines = {}

    for i = minScroll, maxScroll, 1 do
        local forstring = JLib.UITools.getEmptyString(
                              self._TextSplitedViewport[i].align - 1)
        local backstring = JLib.UITools.getEmptyString(
                               self.Len.x - #forstring -
                                   #(self._TextSplitedViewport[i].text))
        table.insert(self._TextSplitedViewportLines, forstring ..
                         self._TextSplitedViewport[i].text .. backstring)
    end
end

function TextArea:_printTextLines()
    self._screen:setBackgroundColor(self.BG)
    self._screen:setTextColor(self.FG)

    local renderPos = self.Pos:Copy()
    for index, value in ipairs(self._TextSplitedViewportLines) do
        self._screen:setCursorPos(renderPos)
        self._screen:write(value)
        renderPos.y = renderPos.y + 1
    end
end
