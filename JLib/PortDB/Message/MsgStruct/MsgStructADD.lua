local class = require("Class.middleclass")

require("Common.Serializer")
require("PortDB.Message.MsgStruct.IMsgStruct")

---public class MsgStructADD : IMsgStruct
---@class PortDB.MsgStruct.ADD
local ADD = class("PortDB.MsgStruct.ADD", JLib.PortDB.MsgStruct.IMsgStruct)

---namespace JLib
JLib = JLib or {}
---namespace JLib.PortDB
JLib.PortDB = JLib.PortDB or {}
---namespace JLib.PortDB.MsgStruct
JLib.PortDB.MsgStruct = JLib.PortDB.MsgStruct or {}
JLib.PortDB.MsgStruct.ADD = ADD

---constructor
---@param IDToAdd number
---@param PortToAdd string
function ADD:initialize(IDToAdd, PortToAdd)
    self.IDToAdd = IDToAdd
    self.PortToAdd = PortToAdd
end

---properties description
---@class PortDB.MsgStruct.ADD
---@field IDToAdd number
---@field PortToAdd string
---@field new fun(self:PortDB.MsgStruct.ADD , IDToAdd:number, PortToAdd: string):PortDB.MsgStruct.ADD

---abstract function
function ADD:Serialize()
    local temp = {}
    temp["IDToAdd"] = self.IDToAdd
    temp["PortToAdd"] = self.PortToAdd
    return textutils.serialize(temp)
end

function ADD:Deserialize(str)
    local temp = textutils.serialize(str)
    local temp2 = ADD:new(temp.IDToAdd, temp.PortToAdd)
    return temp2
end
