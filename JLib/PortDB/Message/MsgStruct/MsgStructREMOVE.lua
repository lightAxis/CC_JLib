local class = require("Class.middleclass")

-----------------REMOVE-----------------------

---@class PortDB.MsgStruct.REMOVE
local REMOVE = class("PortDB.MsgStruct.REMOVE")

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
---@field new fun(IDToRemove: number, PortToRemove: string):PortDB.MsgStruct.REMOVE
