local class = require("Class.middleclass")

---public class Tools
---@class DB.Tools
local Tools = class("Tools")

---namespace JLib
JLib = JLib or {}
---namespace JLib.DB
JLib.DB = JLib.DB or {}
JLib.DB.Tools = Tools

-- constructor
function Tools:initialize() end

---get unserialized data from path
---@param path string 
---@return DB.Struct
function Tools.getData(path)
    local f
    if (fs.exists(path)) then
        f = fs.open(path, "r")
    else
        return nil
    end
    local temp = f.readAll()
    f.close()
    return textutils.unserialize(temp)
end

---get unserialized data from path
---@param path string
---@param data DB.Struct
function Tools.saveData(path, data)
    local f = fs.open(path, "r")
    f.write(textutils.serialize(data))
    f.close()
end
