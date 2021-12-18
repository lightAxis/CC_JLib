local class = require("Class.middleclass")

---public class Serializer
---@class Common.Serializer
local Serializer = {}

---namespace JLib
JLib = JLib or {}
---namespace JLib.Common
JLib.Common = JLib.Common or {}
JLib.Common.Serializer = Serializer

---serialize to path.
---@param obj any
---@param path string
---@param serializeModule any must have :Serialize(any) function
function Serializer.SerializeTo(obj, path, serializeModule)
    local f = fs.open(path, "w")
    local objStr = ""

    if (serializeModule == nil) then
        objStr = textutils.serialize(obj)
    else
        objStr = serializeModule:Serialize(obj)
    end

    f.write(objStr)
    f.close()
end

---deserialize in path
---@param path string
---@param deserializeModule any must have :Deserialize(str) function
---@return any obj
function Serializer.DeserializeFrom(path, deserializeModule)
    local f = fs.open(path, "r")
    local objstr = f.readAll()

    local obj
    if (deserializeModule == nil) then
        obj = textutils.deserialize(objstr)
    else
        obj = deserializeModule:Deserialize(objstr)
    end
    f.close()
    return obj
end
