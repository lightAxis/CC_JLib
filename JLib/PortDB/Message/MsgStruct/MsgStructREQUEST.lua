local class = require("Class.middleclass")

------------------REQUEST--------------------

---public class MsgStructREQUEST : IMsgStruct
---@class PortDB.MsgStruct.REQUEST
local REQUEST = class("PortDB.MsgStruct.REQUEST",
                      JLib.PortDB.MsgStruct.IMsgStruct)

---namespace JLib
JLib = JLib or {}
---namespace JLib.PortDB
JLib.PortDB = JLib.PortDB or {}
---namespace JLib.PortDB.MsgStruct
JLib.PortDB.MsgStruct = JLib.PortDB.MsgStruct or {}
JLib.PortDB.MsgStruct.REQUEST = REQUEST

---construction
---@param PortToRequest string
function REQUEST:initialize(PortToRequest, IDToSendBack)
    self.PortToRequest = PortToRequest
    self.IDToSendBack = IDToSendBack
end

---properties descroption
---@class PortDB.MsgStruct.REQUEST
---@field PortToRequest string
---@field IDToSendBack number
---@field new fun(self: PortDB.MsgStruct.REQUEST, PortToRequest: string, IDToSendBack: number):PortDB.MsgStruct.REQUEST

---abstract function

function REQUEST:Serialize()
    local temp = {}
    temp["PortToRequest"] = self.PortToRequest
    temp["IDToSendBack"] = self.IDToSendBack
    return textutils.serialize(temp)
end

function REQUEST:Deserialize(str)
    local temp = textutils.unserialize(str)
    local temp2 = REQUEST:new(temp.PortToRequest, temp.IDToSendBack)
    return temp2
end
