local class = require("Class.middleclass")

---public class UIScene
---@class UIScene
local UIScene = class("UIScene")

---namespace JLib
JLib = JLib or {}
JLib.UIScene = UIScene

---constructor
---@param attachedScreen Screen
---@param projNamespace any
function UIScene:initialize(attachedScreen, projNamespace)
    self.attachingScreen = attachedScreen
    self.PROJ = projNamespace
    ---@type ScreenCanvas
    self.rootScreenCanvas = JLib.ScreenCanvas:new(nil, attachedScreen,
        "rootScreenCanvas")

end

---properties description
---@class UIScene
---@field attachingScreen Screen
---@field PROJ table
---@field rootScreenCanvas ScreenCanvas
---@field new fun(self:UIScene, attachedScreen:Screen, projNamespace:table):UIScene
