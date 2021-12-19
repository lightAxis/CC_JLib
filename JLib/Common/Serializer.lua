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
---@param isCustomSerialize boolean obj must have :Serialize(any) function
function Serializer.SerializeTo(obj, path, isCustomSerialize)
    local f = fs.open(path, "w")
    local objStr = ""

    if (isCustomSerialize == false) then
        objStr = textutils.serialize(obj)
    else
        objStr = obj:Serialize()
    end

    f.write(objStr)
    f.close()
end

---deserialize in path
---@param path string
---@param deserializeModule any must have :Deserialize(str) function
---@return any|nil obj
function Serializer.DeserializeFrom(path, deserializeModule)
    local f = fs.open(path, "r")

    if(f == nil) then
        return nil
    end
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
