local class = require("Class.middleclass")

-----------------REMOVE-----------------------

---public class MsgStructREMOVE : IMsgStruct
---@class PortDB.MsgStruct.REMOVE
local REMOVE =
    class("PortDB.MsgStruct.REMOVE", JLib.PortDB.MsgStruct.IMsgStruct)

---namespace JLib
JLib = JLib or {}
---namespace JLib.PortDB
JLib.PortDB = JLib.PortDB or {}
---namespace JLib.PortDB.MsgStruct
JLib.PortDB.MsgStruct = JLib.PortDB.MsgStruct
JLib.PortDB.MsgStruct.REMOVE = REMOVE

---constructor
---@param IDToRemove number
---@param PortToRemove string
function REMOVE:initialize(IDToRemove, PortToRemove)
    self.IDToRemove = IDToRemove
    self.PortToRemove = PortToRemove
end

---properties description
---@class PortDB.MsgStruct.REMOVE
---@field IDToRemove number
---@field PortToRemove string
---@field new fun(self: PortDB.MsgStruct.REMOVE, IDToRemove: number, PortToRemove: string):PortDB.MsgStruct.REMOVE

---abstract function

---serialize this msg struct
---@return string
function REMOVE:Serialize()
    local temp = {}
    temp["IDToRemove"] = self.IDToRemove
    temp["PortToRemove"] = self.PortToRemove
    return textutils.serialize(temp)
end

---deserialize this msg struct
---@param str string
---@return PortDB.MsgStruct.REMOVE
function REMOVE:Deserialize(str)
    local temp = textutils.deserialize(str)
    local temp2 = REMOVE:new(temp.IDToREmove, temp.PortToRemove)
    return temp2
end
