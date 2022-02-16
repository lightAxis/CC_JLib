---@module 'Class.middleclass'
local class = require("Class.middleclass")

-- #includes
require("UI.UIElement")
require("UI.TextBlock")

--- public class Button : TextBlock
---  
---**require** :  
--- - Class.middleclass
--- - JLib.UIElement
---@class Button : TextBlock
local Button = class("Button", JLib.TextBlock)

--- namespace JLib
JLib = JLib or {}
JLib.Button = Button

---constructor
function Button:initialize(parent, screen, name, text, PosRel, Len, bg, fg)
    JLib.TextBlock.initialize(self, parent, screen, name, text, PosRel, Len, bg,
                              fg)

    self.IsToggleable = false
    self.IsButtonPressed = false

    self.BGUnpressed = self.BG
    self.FGUnpressed = self.FG
    self.BGPressed = JLib.Enums.Color.lightGray
    self.FGPressed = JLib.Enums.Color.black
    -- self._tempPressed = false

    self.ClickEvent = function(button) end
end

-- priperties description
---@class Button : TextBlock
---@field IsToggleable boolean
---@field IsButtonPressed boolean
---@field BGPressed Enums.Color
---@field FGPressed Enums.Color
-- -@field _tempPressed boolean
---@field ClickEvent fun(Button): nil
---@field new fun(self:Button, parent: UIElement, screen: Screen, name: string, text?: string, PosRel?: Vector2, Len?: Vector3, bg?: Enums.Color, fg?: Enums.Color): Button

-- functions

--- override functions

---overrided from TextBlock
-- ---@param color Enums.Color
-- function Button:setBackgroundColor(color)
--     self.BG = color
--     self._TextArea.BG = color
-- end

---overrided function from UIElement:render()
function Button:render()
    -- update global pos
    self:_updatePos()

    if (self.IsButtonPressed == true) then
        self:setBackgroundColor(self.BGPressed)
        self:setTextColor(self.FGPressed)
    else
        self:setBackgroundColor(self.BGUnpressed)
        self:setTextColor(self.FGUnpressed)
    end

    -- fill inside the button with background color
    self:_fillWithBG()

    -- sync bg,fg of textarea same with button
    self._TextArea.BG = self.BG
    self._TextArea.FG = self.FG

    -- if (self._tempPressed) then
    --     self._tempPressed = false
    --     self.IsButtonPressed = false
    -- end
    -- render history check
    self:_addThisToRenderHistory()

    -- render children components
    self:renderChildren()

end

---overrided function from UIElement:_ClickEvent
---@param e ClickEventArgs
function Button:_ClickEvent(e)
    if (self.IsToggleable) then
        if (not (self.IsButtonPressed)) then
            self.IsButtonPressed = true
            self.BGUnpressed = self.BG
            self.FGUnpressed = self.FG
        else
            self.IsButtonPressed = false
        end
        -- else
        -- if(not(self._tempPressed)) then
        --     self.BGUnpressed = self.BG
        --     self.BG = self.BGPressed
        --     self.IsButtonPressed = true
        --     self._tempPressed = true
        --     print(self.BGPressed.."d")
        -- end
    end

    self.ClickEvent(self)
end

-- ---overrided function from UIElement:_ScrollEvent
-- ---@param e ScrollEventArgs
-- function Button:_ScrollEvent(e)
--     e.Handled = true
--     self:setScroll(self:getScroll() + e.Direction)
-- end

-- ---overrided function from UIElement:_KeyInputEvent
-- ---@param e KeyInputEventArgs
-- function Button:_KeyInputEvent(e) end

-- ---overrided function from UIElement:_CharEvent
-- ---@param e CharEventArgs
-- function Button:_CharEvent(e) end

-- ---overrided function from UIElement:PostRendering()
-- function Button:PostRendering() end

-- ---overrided function from UIElement:FocusIn()
-- function Button:FocusIn() end

---overrided function from UIElement:FocusOut()
-- function Button:FocusOut() 
--     if(not(self.IsToggleable)) then
--         if(self._tempPressed) then
--             self.BG = self.BGUnpressed
--             self._tempPressed = false
--             print(self.BG.."aa")
--         end
--     end
-- end
