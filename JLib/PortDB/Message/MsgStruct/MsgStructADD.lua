local class = require("Class.middleclass")

require("Common.Serializer")
require("PortDb.")

---@class PortDB.MsgStruct.ADD
local ADD = class("PortDB.MsgStruct.ADD")

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
---@field new fun(IDToAdd:number, PortToAdd: string):PortDB.MsgStruct.ADD
