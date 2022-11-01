local class = require("Class.middleclass")

---public class UIScene
---@class UILayout
local UILayout = class("UILayout")

---namespace JLib
JLib = JLib or {}
JLib.UILayout = UILayout

function UILayout:initialize(attachedScreen, projNamespace)
    self.attachingScreen = attachedScreen
    self.PROJ = projNamespace
    self.rootScreenCanvas = JLib.ScreenCanvas:new(nil, attachedScreen, "rootScreenCanvas")
end

---properties description
---@class UILayout
---@field attachingScreen Screen
---@field PROJ table
---@field rootScreenCanvas ScreenCanvas
---@field new fun(self:UIScene, attachedScreen:Screen, projNamespace:table):UILayout
