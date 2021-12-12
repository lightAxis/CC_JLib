local class = require("Class.middleclass")

require("UI.Enums")
require("UI.Screen")
require("DB.Protocols")
require("DB.MsgStruct.Includes")
require("DB.Tools")
require("DB.Struct")

-- public class DBClient
---@class DB.Client
local Client = class("Client")

---namespace JLib
JLib = JLib or {}
---namespace JLib.DB
JLib.DB = JLib.DB or {}
JLib.DB.Client = Client

---constructor
---@param rednetSide Enums.Side
---@param tableSavePath string
---@param screen Screen
---@param serverID number
function Client:initialize(rednetSide, tableSavePath, screen, serverID, clientID)
    self._rednetSide = rednetSide
    self._tableSavePath = tableSavePath
    self._screen = screen
    self._serverID = serverID
    self._clientID = clientID

    self._protocols = {}

    rednet.open(self._rednetSide)
end

--- properties description
---@class DB.Client
---@field _rednetSide Enums.Side
---@field _tableSavePath string
---@field _screen Screen
---@field _serverID number
---@field _clientID number
---@field _protocols table<number, DB.Struct>
---@field new fun(self:DB.Client, rednetSide: Enums.Side, tableSavePath: string, screen: Screen):DB.Client

---add to db with current protocol
---@param protocol string   
function Client:AddToDB(protocol)
    local MsgStruct = JLib.DB.MsgStructAdd:new(self._clientID, protocol)
    local msg = JLib.DB.Message:new(JLib.DB.Protocols.add, MsgStruct)

    rednet.send(self._serverID, textutils.serialize(msg),
                JLib.DB.Protocols.master)
end

---remove to db with current protocol
---@param protocol string
function Client:RemoveFromDB(protocol)
    local MsgStruct = JLib.DB.MsgStructRemove:new(self._clientID, protocol)
    local msg = JLib.DB.Message:new(JLib.DB.Protocols.remove, MsgStruct)

    rednet.send(self._serverID, textutils.serialize(msg),
                JLib.DB.Protocols.remove)
end

---request new data from db with protocol
---@param protocol string
function Client:RequestFromDB(protocol)
    local MsgStruct = JLib.DB.MsgStructRequest:new(self._clientID, protocol)
end

---refresh data from DB
---@param msg DB.Message
function Client:HandleRefreshFromDB(msg)
    ---@type DB.MsgStructRefresh
    local msgStruct = msg.msgStruct
    local data = msgStruct.DBData

    local path = self._tableSavePath .. "/" .. msgStruct.ProtocolToRefresh
    JLib.DB.Tools.saveData(path, data)

    self._protocols[msgStruct.ProtocolToRefresh] = data
end

---get IDs of protocol
---@param protocol string
---@return DB.Struct
function Client:getIDs(protocol)
    local path = self._tableSavePath .. "/" .. protocol
    if (self._protocols[protocol] == nil) then
        local data = JLib.DB.Tools.getData(path)
        if (data == nil) then return nil end

        self._protocols[protocol] = data
        return data.IDs
    else
        return self._protocols[protocol]
    end
end
