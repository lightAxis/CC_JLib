local class = require("Class.middleclass")

require("DBs.PortDB.Message")
require("DBs.PortDB.Consts")
require("DBs.PortDB.Table")

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

---properties description
---@class PortDB.Server
---@field new fun(self:PortDB.Server):PortDB.Server

---handler msg to server
---@param msgLine string
function Server:ServerHandle(msgLine)

    local msg = JLib.PortDB.Message:Deserialize(msgLine)

    if (msg.Header == JLib.PortDB.Headers.ADD) then
        print("ADD "..msg.SerializedMsgStruct)
        self:_serverHandleADD(msg.SerializedMsgStruct)
    elseif (msg.Header == JLib.PortDB.Headers.REMOVE) then
        print("REMOVE "..msg.SerializedMsgStruct)
        self:_serverHandleREMOVE(msg.SerializedMsgStruct)
    elseif (msg.Header == JLib.PortDB.Headers.REQUEST) then
        print("REQUEST "..msg.SerializedMsgStruct)
        self:_serverHandleREQUEST(msg.SerializedMsgStruct)
    elseif (msg.Header == JLib.PortDB.Headers.REFRESH) then
        print("REFRESH "..msg.SerializedMsgStruct)
        self:_serverHandleREFRESH(msg.SerializedMsgStruct)
    end
end

---handle add in server
---@param struct_ string
function Server:_serverHandleADD(struct_)
    local struct = JLib.PortDB.MsgStruct.ADD:Deserialize(struct_)
    
    local portPath = JLib.PortDB.Consts.ServerPath .. "/" .. struct.PortToAdd

    ---@type PortDB.Table
    local table = JLib.Common.Serializer.DeserializeFrom(portPath,
                                                         JLib.PortDB.Table)

    if (table == nil) then 
        table = JLib.PortDB.Table:new(struct.PortToAdd) 
    end

    table.IDs[struct.IDToAdd] = true

    JLib.Common.Serializer.SerializeTo(table, portPath, true)
end

---handle remove in server
---@param struct_ string
function Server:_serverHandleREMOVE(struct_)
    local struct = JLib.PortDB.MsgStruct.REMOVE:Deserialize(struct_)

    local portPath = JLib.PortDB.Consts.ServerPath .. "/" .. struct.PortToRemove

    ---@type PortDB.Table
    local table = JLib.Common.Serializer.DeserializeFrom(portPath,
                                                         JLib.PortDB.Table)

    if (table == nil) then
         table = JLib.PortDB.Table:new(struct.PortToRemove) 
    end

    table.IDs[struct.IDToRemove] = nil

    JLib.Common.Serializer.SerializeTo(table, portPath, true)
end

---handle request in server
---@param struct_ string
function Server:_serverHandleREQUEST(struct_)
    local struct = JLib.PortDB.MsgStruct.REQUEST:Deserialize(struct_)

    local portPath = JLib.PortDB.Consts.ServerPath .. "/" .. struct.PortToRequest

    ---@type PortDB.Table
    local table = JLib.Common.Serializer.DeserializeFrom(portPath,
                                                         JLib.PortDB.Table)

    if (table == nil) then
        table = JLib.PortDB.Table:new(struct.PortToRequest)
    end

    local msgStruct = JLib.PortDB.MsgStruct.REFRESH:new(table.Port, table:Serialize())
    local msg = JLib.PortDB.Message:new(JLib.PortDB.Headers.REFRESH,
                                        msgStruct:Serialize())    
    rednet.send(struct.IDToSendBack, msg:Serialize(),
                JLib.PortDB.Consts.masterPort)
end

---handle refresh in server
---@param struct_ string
function Server:_serverHandleREFRESH(struct_)
    ---kjhkh
end
