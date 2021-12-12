local class = require("Class.middleclass")

require("UI.Enums")
require("UI.Screen")
require("DB.Protocols")
require("DB.MsgStruct.Includes")
require("DB.Tools")
require("DB.Struct")

--- public DBServer
---@class DB.Server
local Server = class("Server")

--- namespace JLib
JLib = JLib or {}
---namespace JLib.DB
JLib.DB = JLib.DB or {}
JLib.DB.Server = Server

---constructor
---@param rednetSide Enums.Side
---@param tableSavePath string
---@param screen Screen or term
function Server:initialize(rednetSide, tableSavePath, screen)
    self._rednetSide = rednetSide
    self._tableSavePath = tableSavePath
    self._screen = screen or JLib.Screen:new(term)
end

function Server:run()
    rednet.open(self._rednetSide)

    local senderID, serialmsg, port
    while true do
        _, senderID, serialmsg, port = os.pullEvent("rednet_message")

        if port == JLib.DB.Protocols.master then
            ---@type DB.Message
            local msg = textutils.unserialize(serialmsg)
            if (msg.protocol == JLib.DB.Protocols.add) then
                self:handleAdd(msg.msgStruct)
            elseif (msg.protocol == JLib.DB.Protocols.remove) then
                self:handleRemove(msg.msgStruct)
            elseif (msg.protocol == JLib.DB.Protocols.request) then
                self:handleRequest(msg.msgStruct)
            end

        end
    end
end

---handle add command to DB
---@param msg DB.MsgStructAdd
function Server:handleAdd(msg)

    local path = self._tableSavePath .. "/" .. msg.ProtocolToAdd
    local data = JLib.DB.Tools.getData(path)

    if (data == nil) then data = JLib.DB.Struct:new(msg.ProtocolToAdd) end

    local isAlreadyExist = false
    for key, value in pairs(data) do
        if (key == msg.IDToAdd) then
            isAlreadyExist = true
            break
        end
    end

    if (isAlreadyExist == false) then data.IDs[msg.IDToAdd] = true end

    JLib.DB.Tools.saveData(path)

end

---handle Remove command to DB
---@param msg DB.MsgStructRemove
function Server:handleRemove(msg)
    local path = self._tableSavePath .. "/" .. msg.ProtocolToRemove

    local data = JLib.DB.Tools.getData(path)
    if (data == nil) then return end

    local isAlreadyExist = false
    for key, value in pairs(data.IDs) do
        if (key == msg.IDToRemove) then
            data.IDs[msg.IDToRemove] = nil
            break
        end
    end

end

---handle Request command to DB
---@param msg DB.MsgStructRequest
function Server:handleRequest(msg)

    local path = self._tableSavePath .. "/" .. msg.ProtocolToRequest

    local data = JLib.DB.Tools.getData(path)
    if (data == nil) then return end

    local refreshMsg = JLib.DB.MsgStructRefresh:new(msg.ProtocolToRequest, data)
    rednet.send(msg.IDToSendBack, textutils.serialize(refreshMsg),
                JLib.DB.Protocols.master)

end

