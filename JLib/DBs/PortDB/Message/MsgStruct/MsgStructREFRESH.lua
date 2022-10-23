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
---@param PortTableSerialized string
function REFRESH:initialize(PortToRefresh, PortTableSerialized)
    self.PortToRefresh = PortToRefresh
    self.PortTableSerialized = PortTableSerialized
end

---properties description
---@class PortDB.MsgStruct.REFRESH
---@field PortToRefresh string
---@field PortTableSerialized string
---@field new fun(self:PortDB.MsgStruct.REFRESH, PortToRefresh: string, IDList: table<number, boolean>):PortDB.MsgStruct.REFRESH

---abstract function
function REFRESH:Serialize()
    local temp = {}
    temp["PortToRefresh"] = self.PortToRefresh
    temp["PortTableSerialized"] = self.PortTableSerialized
    return textutils.serialize(temp)
end

function REFRESH:Deserialize(str)
    local temp = textutils.unserialize(str)
    temp2 = REFRESH:new(temp.PortToRefresh, temp.PortTableSerialized)
    return temp2
end
