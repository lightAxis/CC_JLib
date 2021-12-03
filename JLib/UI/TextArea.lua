local class = require("Class.middleclass")

-- #includes
require("UI.UIElement")
require("UI.Enums")
require("UI.UITools")
require("MathLib.Vector2")
require("LibGlobal.StaticMethods")

-- public class TextBlock : UIElement  
---  
---**require** :  
--- - Class.middleclass
--- - UI.UIElement
--- - UI.Enums
--- - UI.UITools
--- - MathLib.Vector2
--- - LibGlobal.StaticMethods
---@class TextArea : UIElement
local TextArea = class("TextArea", JLib.UIElement)

-- namespace JLib
JLib = JLib or {}
JLib.TextArea = TextArea

-- [constructor]
---comment
---@param parent UIElement
---@param screen Screen
---@param name string
---@param text string or ""
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

-- properties description
---@class TextArea
---@field _HorizontalAlignmentMode Enums.HorizontalAlignmentMode
---@field _VerticalAlignmentMode Enums.VerticalAlignmentMode
---@field _TextSplited table<number, TextArea.TextSplitedNode>
---@field _TextSplitedViewport table<number, TextArea.WrappedNode>
---@field _TextViewportLines table<number, string>
---@field new fun(parent: UIElement, screen: Screen, name: string, text: string): TextArea

---------[private classes]-----------

--- private class textSplitedNode   
--- **is is private class in TextArea.**
---@class TextArea.TextSplitedNode
local TextSplitedNode = class("textSplitedNode")

---constructor
---@param index number
---@param text string
---@param wrappedNodes? table<number, TextArea.WrappedNode> or {}
function TextSplitedNode:initialize(index, text, wrappedNodes)
    self.index = index
    self.text = text
    self.wrappedNodes = wrappedNodes or {}
end

---properties description
---@class TextArea.TextSplitedNode
---@field index number
---@field text string
---@field wrappedNodes table<number, TextArea.WrappedNode>
---@field new fun(index:number, text:string, wrappedNode: TextArea.WrappedNode): TextArea.TextSplitedNode

---private class WrappedNode
---**this is private class in TextArea**
---@class TextArea.WrappedNode
local WrappedNode = class("WrappedNode")

---constructor
---@param index number
---@param text string
---@param align number
---@param parent TextArea.TextSplitedNode
function WrappedNode:initialize(index, text, align, parent)
    self.index = index
    self.text = text
    self.align = align
    self.parent = parent
end

-- properties description
---@class TextArea.WrappedNode
---@field index number
---@field text string
---@field align number
---@field parent TextArea.TextSplitedNode
---@field new fun(index: number, text:string, align:number, parent: TextArea.TextSplitedNode): TextArea.WrappedNode

-- [functions]

---set text of this textarea
---@param text string
function TextArea:setText(text)
    if (text == nil) then
        error("TextBlock:setText(text) : text must be string")
    end
    self._Text = text
    -- self:_getTextSplited()
    self:_updateTextSplited()
end

---set vertical alignment mode of textblock
---@param align Enums.VerticalAlignmentMode
function TextArea:setVerticalAlignment(align) self._VerticalAlignmentMode =
    align end

---set horizontal alignment mode of textblock
---@param align Enums.HorizontalAlignmentMode
function TextArea:setHorizontalAlignment(align)
    self._HorizontalAlignmentMode = align
    self:_updateTextHorizontalAligned()
end

---get full text of this textarea
---@return string
function TextArea:getText() return self._Text end

---set scroll index of this textarea
---@param scroll number
function TextArea:setScroll(scroll) self._scroll = math.max(1, scroll) end

---get scroll index of this textarea
---@return number
function TextArea:getScroll() return self._scroll end

---make textsplited with rawText
function TextArea:_updateTextSplited()
    local text_ = self._Text

    -- split text with '\n'
    local textSplited_ = self._Text:split("\n")

    -- split by text with \n
    local lengthSum = 1
    self._TextSplited = {}

    for index, value in ipairs(textSplited_) do

        local TextSplited_node = TextSplitedNode:new(lengthSum, value, {})
        table.insert(self._TextSplited, TextSplited_node)
        lengthSum = lengthSum + #value + 1
    end

end

---make wrappedTextNodes with splitted text
function TextArea:_updateTextSplitedViewport()
    self._TextSplitedViewport = {}

    -- split text by length of element
    for i, v in ipairs(self._TextSplited) do
        local textline = v.text
        local textline_spliited = ""
        local textline_anchor = 1

        local superContinue = false
        if (textline == "") then
            local temp = WrappedNode:new(1, "", 1, nil)
            table.insert(v.wrappedNodes, temp)
            table.insert(self._TextSplitedViewport, temp)
            temp.parent = v
            superContinue = true
        end

        if (superContinue == false) then
            while (#textline >= self.Len.x) do
                textline_spliited = string.sub(textline, 1, self.Len.x)
                local temp = WrappedNode:new(textline_anchor, textline_spliited,
                                             1, nil)
                table.insert(v.wrappedNodes, temp)
                table.insert(self._TextSplitedViewport, temp)
                temp.parent = v

                textline_anchor = textline_anchor + self.Len.x
                textline = string.sub(textline, self.Len.x + 1, #textline)
            end

            if (textline ~= "") then
                textline_spliited = textline
                local temp = WrappedNode:new(textline_anchor, textline,
                                             JLib.UITools
                                                 .calcHorizontalAlignPos(1,
                                                                         self.Len
                                                                             .x,
                                                                         #textline_spliited,
                                                                         self._HorizontalAlignmentMode),
                                             nil)

                table.insert(v.wrappedNodes, temp)
                table.insert(self._TextSplitedViewport, temp)
                temp.parent = v
            end
        end
    end
end

---update text horizontal aligned to wrappednode
function TextArea:_updateTextHorizontalAligned()

    for index, value in ipairs(self._TextSplitedViewport) do
        value.align = JLib.UITools.calcHorizontalAlignPos(1, self.Len.x,
                                                          #(value.text),
                                                          self._HorizontalAlignmentMode)
    end
end

---prevent scroll index bound in element length
---@return number minScroll
---@return number maxScroll
function TextArea:_wrapScroll()
    local minScroll = self._scroll
    minScroll = math.max(minScroll, 1)

    local maxScroll = self._scroll + self.Len.y - 1
    maxScroll = math.min(maxScroll, #(self._TextSplitedViewport))

    minScroll = math.max(maxScroll - self.Len.y + 1, 1)
    self._scroll = minScroll
    return minScroll, maxScroll
end

---make textStpliited lines to draw immidiatly
---@param minScroll number
---@param maxScroll number
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

---print TextSplittedLines to screen obj
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

------------------ [overriding functions]---------------

---overrided function from UIElement:render()
function TextArea:render()
    -- textarea cannot have pos rel
    self.PosRel.x = 1
    self.PosRel.y = 1

    -- update global position
    self:_updatePos()

    -- textarea must follow the length of parent
    self:_updateLengthFromParent()

    -- update wrap of splited string with \n
    self:_updateTextSplitedViewport()

    -- check if scroll index is avilable
    local minScroll, maxScroll = self:_wrapScroll()

    -- update text splited lines with black " "
    self:_updateTextSplitedLines(minScroll, maxScroll)

    -- print text splited lines
    self:_printTextLines()

    -- render history add
    self:_addThisToRenderHistory()

    -- render children
    self:renderChildren()
end

---overrided function from UIElement:_ClickEvent
---@param e ClickEventArgs
function TextArea:_ClickEvent(e) end

---overrided function from UIElement:_ScrollEvent
---@param e ScrollEventArgs
function TextArea:_ScrollEvent(e) end

---overrided function from UIElement:_KeyInputEvent
---@param e KeyInputEventArgs
function TextArea:_KeyInputEvent(e) end
