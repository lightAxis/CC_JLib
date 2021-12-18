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
---@param msg PortDB.Message
function Client:HandleMsg(msg)
    if (msg.Header == JLib.PortDB.Headers.ADD) then
        self:_clientHandleADD(msg)
    elseif (msg.Header == JLib.PortDB.Headers.REMOVE) then
        self:_clientHandleREMOVE(msg)
    elseif (msg.Header == JLib.PortDB.Headers.REQUEST) then
        self:_clientHandleREQUEST(msg)
    elseif (msg.Header == JLib.PortDB.Headers.REFRESH) then
        self:_clientHandleREFRESH(msg)
    end
end

---handle ADD in client
---@param struct PortDB.MsgStruct.ADD
function Client:_clientHandleADD(struct)
    ---none
end

---handle REMOVE in client
---@param struct PortDB.MsgStruct.REMOVE
function Client:_clientHandleREMOVE(struct)
    ---none
end

---handle REQUEST in client
---@param struct PortDB.MsgStruct.REQUEST
function Client:_clientHandleREQUEST(struct)
    ---none
end

---handle REFRESH in client
---@param struct PortDB.MsgStruct.REFRESH
function Client:_clientHandleREFRESH(struct)
    local portPath = JLib.PortDB.Consts.ClientPath + "/" + struct.PortToRefresh
    JLib.Common.Serializer.serializeTo(struct.IdList, portPath)
end
