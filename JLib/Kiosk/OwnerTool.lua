local class = require("Class.middleclass")

require("Common.Serializer")

---@class Kiosk.OwnerTool
local ownerTool = class("Kiosk.OwnerTool")

JLib = JLib or {}
--- namespace JLib.Kiosk
JLib.Kiosk = JLib.Kiosk or {}
JLib.Kiosk.OwnerTool = ownerTool

---constructor
---@param KioskPath string
---@param RSBridge AdvancedPeripherals.RsBridge
function ownerTool:initialize(KioskPath, RSBridge)
    self._KioskPath = KioskPath
    self._Settingpath = KioskPath .. "Setting"
    self._MenusPath = KioskPath .. "/Menus"
    self._RSBridge = RSBridge

    self:checkWorkSpace()
end

--- properties description
---@class Kiosk.OwnerTool
---@field _KioskPath string
---@field _RSBridge AdvancedPeripherals.RsBridge
---@field new fun(self:Kiosk.OwnerTool):Kiosk.OwnerTool

function ownerTool:checkWorkSpace()
    local path1 = self._KioskPath
    local path2 = self._MenusPath
    if(fs.exists(path1) == false) then
        fs.makeDir(path1)
    end

    if(fs.exists(path2) == false) then
        fs.makeDir(path2)
    end
end

---get setting from kiosk db
---@return Kiosk.setting_t|nil
function ownerTool:loadSetting()
    local settingPath = self._Settingpath
    ---@type Kiosk.setting_t
    local setting = JLib.Common.Serializer.DeserializeFrom(settingPath, JLib.Kiosk.setting_t)

    if(setting == nil) then return nil end

    return setting
end

---save setting file to kiosk db
---@param setting Kiosk.setting_t
function ownerTool:saveSetting(setting)
    local settingPath = self._Settingpath
    JLib.Common.Serializer.SerializeTo(setting, settingPath, true)
end

---get all items from rsbridge
---@return table<number, AdvancedPeripherals.RsBridge.Item>
function ownerTool:getAllItems()
    local items = self._RSBridge.listItems()
    return items
end

---get all menus from kiosk db
---@return table<number, Kiosk.menu_t>|nil
function ownerTool:loadAllMenus()
    local menuspath  = self._MenusPath
    if(fs.exists(menuspath) == false) then return nil end

    local menusList = fs.list(menuspath)
    local menuPaths = {}
    for index, value in ipairs(menusList) do
        table.insert(menuPaths, menuspath .."/"..value)
    end

    local menus = {}
    for index, value in ipairs(menuPaths) do
        local menu = JLib.Common.Serializer.DeserializeFrom(value, JLib.Kiosk.menu_t)
        table.insert(menus, menu)
    end

    return menus
end

---save menus to kiosk db
---@param menus table<number, Kiosk.menu_t>
function ownerTool:saveAllMenus(menus)
    for index, value in ipairs(menus) do
        local path = self._MenusPath "/".. value.Name
        JLib.Common.Serializer.SerializeTo(value,path,true)
    end
end

---try loading single menu from kiosk db
---@param menuName string
---@return Kiosk.menu_t|nil
function ownerTool:loadMenu(menuName)
    local path = self._MenusPath .."/" + menuName
    ---@type Kiosk.menu_t
    local menu = JLib.Common.Serializer.DeserializeFrom(path, JLib.Kiosk.menu_t)

    if(menu == nil) then return nil end
    return menu
end

---try ssave single menu to kiosk db
---@param menu Kiosk.menu_t
function ownerTool:saveMenu(menu)
   local path = self._MenusPath .. "/" .. menu.Name
   JLib.Common.Serializer.SerializeTo(menu, path, JLib.Kiosk.menu_t)
end

---remove one menu from kiosk db
---@param menuName string
function ownerTool:removeMenu(menuName)
    local path = self._MenusPath .. "/" .. menuName
    fs.delete(path)
end