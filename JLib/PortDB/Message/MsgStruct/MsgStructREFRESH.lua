local class = require("Class.middleclass")

----------------------REFRESH------------------------

---public class MsgStructREFRESH : IMsgStruct
---@class PortDB.MsgStruct.REFRESH
local REFRESH = class("PortDB.MsgStruct.REFRESH",
                      JLib.PortDB.MsgStruct.IMsgStruct)

---namespace JLib
JLib = JLib or {}
---namespace JLib.PortDB
JLib.PortDB = JLib.PortDB or {}
---namespace JLib.PortDB.MsgStruct
JLib.PortDB.MsgStruct = JLib.PortDB.MsgStruct or {}
JLib.PortDB.MsgStruct.REFRESH = REFRESH

---constructor
---@param PortToRefresh string
---@param PortTable PortDB.Table
function REFRESH:initialize(PortToRefresh, PortTable)
    self.PortToRefresh = PortToRefresh
    self.PortTable = PortTable
end

---properties description
---@class PortDB.MsgStruct.REFRESH
---@field PortToRefresh string
---@field PortTable PortDB.Table
---@field new fun(self:PortDB.MsgStruct.REFRESH, PortToRefresh: string, IDList: table<number, boolean>):PortDB.MsgStruct.REFRESH

---abstract function
function REFRESH:Serialize()
    local temp = {}
    temp["PortToRefresh"] = self.PortToRefresh
    temp["PortTable"] = self.PortTable:Serialize()
    return textutils.serialize(temp)
end

function REFRESH:Deserialize(str)
    local temp = textutils.deserialize(str)
    local PortTable = JLib.PortDB.Table:Deserialize(temp.PortTable)
    temp2 = REFRESH:new(temp.PortToRefresh, PortTable)
    return temp2
end
