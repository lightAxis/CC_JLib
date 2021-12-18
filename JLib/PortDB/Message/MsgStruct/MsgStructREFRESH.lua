local class = require("Class.middleclass")

----------------------REFRESH------------------------

---@class PortDB.MsgStruct.REFRESH
local REFRESH = class("PortDB.MsgStruct.REFRESH")

---namespace JLib
JLib = JLib or {}
---namespace JLib.PortDB
JLib.PortDB = JLib.PortDB or {}
---namespace JLib.PortDB.MsgStruct
JLib.PortDB.MsgStruct = JLib.PortDB.MsgStruct or {}
JLib.PortDB.MsgStruct.REFRESH = REFRESH

---constructor
---@param PortToRefresh string
---@param IDList table<number, boolean>
function REFRESH:initialize(PortToRefresh, IDList)
    self.PortToRefresh = PortToRefresh
    self.IdList = IDList
end

---properties description
---@class PortDB.MsgStruct.REFRESH
---@field PortToRefresh string
---@field IdList table<number, boolean>
---@field new fun(PortToRefresh: string, IDList: table<number, boolean>):PortDB.MsgStruct.REFRESH
