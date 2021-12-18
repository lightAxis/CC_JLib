local class = require("Class.middleclass")

require("PortDB.Message")
require("PortDB.Consts")
require("PortDB.Table")

---@class PortDB.Server
local Server = class("PortDB.Server")

---namespace JLib
JLib = JLib or {}
---namespace JLib.PortDB
JLib.PortDB = JLib.PortDB or {}
JLib.PortDB.Server = Server

---construct
function Server:initialize()
    if (fs.exists(JLib.PortDB.Consts.ServerPath) == false) then
        fs.makeDir(JLib.PortDB.Consts.ServerPath)
    end
end

---handler msg to server
---@param msg PortDB.Message
function Server:ServerHandle(msg)
    if (msg.Header == JLib.PortDB.Headers.ADD) then
        self:_serverHandleADD(msg)
    elseif (msg.Header == JLib.PortDB.Headers.REMOVE) then
        self:_serverHandleREMOVE(msg)
    elseif (msg.Header == JLib.PortDB.Headers.REQUEST) then
        self:_serverHandleREQUEST(msg)
    elseif (msg.Header == JLib.PortDB.Headers.REFRESH) then
        self:_serverHandleREFRESH(msg)
    end
end

---handle add in server
---@param struct PortDB.MsgStruct.ADD
function Server:_serverHandleADD(struct)
    local portPath = JLib.PortDB.Consts.ServerPath + "/" + struct.PortToAdd

    ---@type PortDB.Table
    local table = JLib.Common.Serializer.deserialize(portPath)

    if (table == nil) then table = JLib.PortDB.Table:new(struct.PortToAdd) end

    table.IDs[struct.IDToAdd] = true

    JLib.Common.Serializer.serializeTo(table, portPath)
end

---handle remove in server
---@param struct PortDB.MsgStruct.REMOVE
function Server:_serverHandleREMOVE(struct)
    local portPath = JLib.PortDB.Consts.ServerPath + "/" + struct.PortToRemove

    ---@type PortDB.Table
    local table = JLib.Common.Serializer.deserialize(portPath)

    if (table == nil) then table = JLib.PortDB.Table:new(struct.PortToRemove) end

    table.IDs[struct.IDToRemove] = nil

    JLib.Common.Serializer.serializeTo(table, portPath)
end

---handle request in server
---@param struct PortDB.MsgStruct.REQUEST
function Server:_serverHandleREQUEST(struct)
    local portPath = JLib.PortDB.Consts.ServerPath + "/" + struct.PortToRequest

    ---@type PortDB.Table
    local table = JLib.Common.Serializer.deserialize(portPath)

    if (table == nil) then
        table = JLib.PortDB.Table:new(struct.PortToRequest)
    end

    local msg = JLib.PortDB.Message:new(JLib.PortDB.Headers.REFRESH, table)

    rednet.send(struct.IDToSendBack, msg, JLib.PortDB.Consts.masterPort)
end

---handle refresh in server
---@param struct PortDB.MsgStruct.REFRESH
function Server:_serverHandleREFRESH(struct)
    ---none
end
