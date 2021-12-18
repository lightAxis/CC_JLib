local class = require("Class.middleclass")

------------------REQUEST--------------------

---@class PortDB.MsgStruct.REQUEST
local REQUEST = class("PortDB.MsgStruct.REQUEST")

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
---@field new fun(PortToRequest: string, IDToSendBack: number):PortDB.MsgStruct.REQUEST
