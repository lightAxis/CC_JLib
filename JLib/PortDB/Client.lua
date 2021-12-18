local class = require("Class.middleclass")

require("PortDB.Message")
require("PortDB.Consts")

---@class PortDB.Client
local Client = class("PortDB.Client")

---namespace JLib
JLib = JLib or {}
---namespace JLib.PortDB
JLib.PortDB = JLib.PortDB or {}
JLib.PortDB.Server = Client

---handle msg to client
---@param msgLine PortDB.Message
function Client:HandleMsg(msgLine)

    local msg = JLib.PortDB.Message:Deserialize(msgLine)

    if (msg.Header == JLib.PortDB.Headers.ADD) then
        self:_clientHandleADD(msg.SerializedMsgStruct)
    elseif (msg.Header == JLib.PortDB.Headers.REMOVE) then
        self:_clientHandleREMOVE(msg.SerializedMsgStruct)
    elseif (msg.Header == JLib.PortDB.Headers.REQUEST) then
        self:_clientHandleREQUEST(msg.SerializedMsgStruct)
    elseif (msg.Header == JLib.PortDB.Headers.REFRESH) then
        self:_clientHandleREFRESH(msg.SerializedMsgStruct)
    end
end

---handle ADD in client
---@param struct_ string
function Client:_clientHandleADD(struct_)
    ---none
end

---handle REMOVE in client
---@param struct_ string
function Client:_clientHandleREMOVE(struct_)
    ---none
end

---handle REQUEST in client
---@param struct_ string
function Client:_clientHandleREQUEST(struct_)
    ---none
end

---handle REFRESH in client
---@param struct_ string
function Client:_clientHandleREFRESH(struct_)
    local struct = JLib.PortDB.MsgStruct.REFRESH:Deserialize(struct_)
    local portPath = JLib.PortDB.Consts.ClientPath + "/" + struct.PortToRefresh
    JLib.Common.Serializer.serializeTo(struct.PortTable, portPath,
                                       JLib.PortDB.Table)
end
