local class = require("Class.middleclass")

require("Common.Serializer")
require("DBs.BankDB.Message.MsgStruct.IMsgStruct")

---@class BankDB.MsgStruct.ACK_GETHISTORY : BankDB.IMsgStruct
local ACK_GETHISTORY = class("BankDB.MsgStruct.ACK_GETHISTORY",
                             JLib.BankDB.MsgStruct.IMsgStruct)

JLib = JLib or {}
JLib.BankDB = JLib.BankDB or {}
JLib.BankDB.MsgStruct = JLib.BankDB.MsgStruct or {}
JLib.BankDB.MsgStruct.ACK_GETHISTORY = ACK_GETHISTORY

---@class BankDB.MsgStruct.ACK_GETHISTORY.eState
JLib.BankDB.MsgStruct.ACK_GETHISTORY.eState = {
    ["NONE"] = -1,
    ["NO_ACCOUNT"] = -2,
    ["SUCCESS"] = 0
}

---constructor
function ACK_GETHISTORY:initialize()
    self.Histories = {}
    self.Success = false
    self.State = JLib.BankDB.MsgStruct.ACK_GETHISTORY.eState.NONE
end

---properties description
---@class BankDB.MsgStruct.ACK_GETHISTORY : BankDB.IMsgStruct
---@field Histories table<number, BankDB.Table_t.History>
---@field Success boolean
---@field State BankDB.MsgStruct.ACK_GETHISTORY.eState
---@field new fun(self:BankDB.MsgStruct.ACK_GETHISTORY):BankDB.MsgStruct.ACK_GETHISTORY

---serialize this
---@return string
function ACK_GETHISTORY:Serialize()
    local temp = {}
    for index, value in ipairs(self.Histories) do
        table.insert(temp, value:Serialize())
    end
    local temp2 = {}
    temp2.Histories = textutils.serialize(temp)
    temp2.Success = self.Success
    temp2.State = self.State
    return textutils.serialize(temp2)
end

---deserialize string
---@param str string
---@return BankDB.MsgStruct.ACK_GETHISTORY
function ACK_GETHISTORY:Deserialize(str)
    local temp = textutils.unserialize(str)
    local temp2 = {}
    local temp3 = textutils.unserialize(temp.Histories)
    for index, value in ipairs(temp3) do
        table.insert(temp2, JLib.BankDB.Table_t.History:Deserialize(value))
    end
    local new_t = JLib.BankDB.MsgStruct.ACK_GETHISTORY:new()
    new_t.Histories = temp2
    new_t.Success = temp.Success
    new_t.State = temp.State

    return new_t
end
