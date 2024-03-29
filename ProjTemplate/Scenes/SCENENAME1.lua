local class = require("Class.middleclass")

---@class ProjTemplate.SCENENAME1 : UIScene
local SCENE = class("ProjTemplate.SCENENAME1")

---constructor
---@param ProjTemplatespace ProjTemplate
---@param UILayout ProjTemplate.SCENENAME1_L
function SCENE:initialize(ProjTemplatespace, UILayout)
    JLib.UIScene.initialize(self, ProjTemplatespace, UILayout)


    -- ? to use type checking autocomplete from lua server..
    -- TODO if lua server updates for this issue, than can change
    local layout = self.Layout
    ---@cast layout ProjTemplate.SCENENAME1_L
    self.UILayout = layout

    -- attach button event
    self.UILayout.ButtonNext.ClickEvent = function()
        -- error(self.attachingScreen:getScreenSide())
        self:button_click()
    end

    -- attach itemTemplate
    local itemTemplate = function(obj)
        local text = tostring(obj.a) .. "/" .. obj.b
        return text
    end
    self.UILayout.listbox:setItemTemplate(itemTemplate)
    self.UILayout.listbox.SelectedIndexChanged = function(obj)
        self:itemIndexChanged(obj)
    end
    self.UILayout.listbox:Refresh()
end

---properties description
---@class ProjTemplate.SCENENAME1 : UIScene
---@field PROJ ProjTemplate
---@field new fun(self:ProjTemplate.SCENENAME1, attachedScreen:Screen, ProjTemplatespace: ProjTemplate):ProjTemplate.SCENENAME1

function SCENE:changed_to_other_scene() end

function SCENE:button_click()
    -- error(self.attachingScreen:getScreenSide())
    if (self.Layout.attachingScreen:getScreenSide() ~= JLib.Enums.Side.NONE) then

        self.PROJ.UIRunner:changeScene(self.PROJ.SCENENAME2_t)
    else
        self.PROJ.UIRunner:changeScene(self.PROJ.SCENENAME2)
    end
end

---comment
---@param obj2 ListBoxItem
function SCENE:itemIndexChanged(obj2)
    local obj = obj2.obj
    local str = self.UILayout.textblock1:getText()
    str = str .. "\n" .. tostring(obj.a) .. " + " .. obj.b
    self.UILayout.textblock1:setText(str)
    self.UILayout.textblock1:setScroll(999)
end

return SCENE
