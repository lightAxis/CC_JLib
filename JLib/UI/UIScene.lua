local class = require("Class.middleclass")

---public class UIScene
---@class UIScene
local UIScene = class("UIScene")

---namespace JLib
JLib = JLib or {}
JLib.UIScene = UIScene

---constructor
---@param projNamespace table
---@param UILayout UILayout
function UIScene:initialize(projNamespace, UILayout)
    self.PROJ = projNamespace
    self.Layout = UILayout

end

---properties description
---@class UIScene
---@field PROJ table
---@field Layout UILayout
--@field Layout UILayout
---@field new fun(self:UIScene, projNamespace:table, UILayout:UILayout):UIScene
