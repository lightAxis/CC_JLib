local class = require("Class.middleclass")

---public class Serializer
---@class Common.Serializer
local Serializer = {}

---namespace JLib
JLib = JLib or {}
---namespace JLib.Common
JLib.Common = JLib.Common or {}
JLib.Common.Serializer = Serializer

---serialize to path
---@param obj any
---@param path string
function Serializer.serializeTo(obj, path)
    local f = fs.open(path, "w")
    local objStr = textutils.serialize(obj)
    f.write(objStr)
    f.close()
end

---deserialize in path
---@param path string
---@return any obj
function Serializer.deserialize(path)
    local f = fs.open(path, "r")
    local objstr = f.readAll()
    local obj = textutils.deserialize(objstr)
    f.close()
    return obj
end
