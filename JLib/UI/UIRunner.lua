local class = require("Class.middleclass")

require("UI.UIElement")
require("UI.Enums")
require("UI.Screen")
require("UI.ScreenCanvas")
require("UI.UIEvent")

---public class UIRunner
---@class UIRunner
local UIRunner = class("UIRunner")

---namespace JLib
JLib = JLib or {}
JLib.UIRunner = UIRunner

---constructor
---@param initialFocusedElement? UIElement
function UIRunner:initialize(initialFocusedElement)
    self.FocusedElement = initialFocusedElement
    ---@type table<Enums.Side, UIScene>
    self.Scenes = {}
end

---properties description
---@class UIRunner
---@field FocusedElement UIElement
---@field Scenes table<Enums.Side, UIScene>
---@field new fun(self:UIRunner, initialFocusedElement:UIElement):UIRunner

---attache scene to side
---@param scene UIScene
function UIRunner:attachScene(scene)
    self.Scenes[scene.attachingScreen:getScreenSide()] = scene
end

---remove scene from side
---@param scene UIScene
function UIRunner:detachScene(scene)
    self.Scenes[scene.attachingScreen:getScreenSide()] = nil
end

---change scene of side
---@param scene UIScene
function UIRunner:changeScene(scene)
    self.Scenes[scene.attachingScreen:getScreenSide()] = scene
    self:ClearScreens()
    self:RenderScreen()
end

---set initial scene from side
---@param side Enums.Side
function UIRunner:setIntialScene(side)
    self.FocusedElement = self.Scenes[side].rootScreenCanvas
end

function UIRunner:ClearScreens()
    for key, value in pairs(self.Scenes) do
        value.attachingScreen:clearScreen()
    end
end

function UIRunner:ClearRenderHistories()
    for key, value in pairs(self.Scenes) do
        value.attachingScreen:clearRenderHistory()
    end
end

function UIRunner:RenderScreen()
    for key, value in pairs(self.Scenes) do value.rootScreenCanvas:render() end
end

function UIRunner:Reflect2Screen()
    for key, value in pairs(self.Scenes) do value.rootScreenCanvas:Reflect2Screen() end
end

function UIRunner:PostRendering() self.FocusedElement:PostRendering() end

---Char event callback function for EventRouter
---@param event EventRouter.Events
---@param char string
---@param _ nil
---@param _ nil
function UIRunner:CharEventCallback(event, char, _, _)
    self.FocusedElement:triggerCharEvent(char)

    self:ClearRenderHistories()
    self:RenderScreen()
    self:Reflect2Screen()
    self:PostRendering()
end

---mouse click event function for EventRouter
---@param event EventRouter.Events
---@param button Enums.MouseButton
---@param x number
---@param y number
function UIRunner:MouseClickEventCallback(event, button, x, y)
    if (button == 1) then
        local pos = JLib.Vector2:new(x, y)
        local focusedScreen = self.Scenes[JLib.Enums.Side.NONE].attachingScreen
        -- print(focusedScreen, "aaaa")
        -- print(focusedScreen._side, "aaaa")
        local clickedElement = focusedScreen:getUIAtPos(pos)
        -- print(clickedElement, "aaaa3")
        if (clickedElement ~= self.FocusedElement) then
            self.FocusedElement:FocusOut()
            clickedElement:FocusIn()
        end
        clickedElement:triggerClickEvent(button, pos)
        self.FocusedElement = clickedElement
    end

    self:ClearRenderHistories()
    self:RenderScreen()
    self:Reflect2Screen()
    self:PostRendering()
end

---key input event function for EventRouter
---@param event EventRouter.Events
---@param key Enums.Key
---@param isShiftPressed boolean
---@param _ nil
function UIRunner:KeyInputEventCallback(event, key, isShiftPressed, _)
    self.FocusedElement:triggerKeyInputEvent(key)

    self:ClearRenderHistories()
    self:RenderScreen()
    self:Reflect2Screen()
    self:PostRendering()
end

---scroll event function for EventRouter
---@param event EventRouter.Events
---@param direction Enums.ScrollDirection
---@param x number
---@param y number
function UIRunner:ScrollEventCallback(event, direction, x, y)
    local focusedScreen = self.Scenes[JLib.Enums.Side.NONE].attachingScreen
    local pos = JLib.Vector2:new(x, y)
    -- print(x, y, "aaaa123")
    local scrolledElement = focusedScreen:getUIAtPos(pos)
    scrolledElement:triggerScrollEvent(direction, pos)

    self:ClearRenderHistories()
    self:RenderScreen()
    self:Reflect2Screen()
    self:PostRendering()
end

---monitor touch event function for EventRouter
---@param event EventRouter.Events
---@param side Enums.Side
---@param x number
---@param y number
function UIRunner:MonitorTouchEventCallback(event, side, x, y)
    local focusedScreen = self.Scenes[side].attachingScreen
    local pos = JLib.Vector2:new(x, y)
    local touchedElement = focusedScreen:getUIAtPos(pos)
    if (touchedElement ~= self.FocusedElement) then
        touchedElement:FocusIn()
        self.FocusedElement:FocusOut()
    end
    touchedElement:triggerClickEvent(JLib.Enums.MouseButton.left, pos)

    self:ClearRenderHistories()
    self:RenderScreen()
    self:Reflect2Screen()
    self:PostRendering()
end
