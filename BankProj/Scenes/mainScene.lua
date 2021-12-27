local class = require("Class.middleclass")

---public class BankProj.mainScene : UIScene
---@class BankProj.mainScene : UIScene
local SCENE = class("BankProj.mainScene", JLib.UIScene)

---constructor
---@param attachedScreen Screen
---@param projNamespace table
function SCENE:initialize(attachedScreen, projNamespace)
    JLib.UIScene.initialize(self, attachedScreen, projNamespace)
    self.UserListBox = JLib.ListBox:new(self.rootScreenCanvas, self.attachingScreen, "UserListBox")
    self.UserListBox:selected
end

---properties description
---@class BankProj.mainScene : UIScene
---@field PROJ BankProj
---@field new fun(attachedScreen:Screen, projNamespace:table)

function SCENE:initElements() end
