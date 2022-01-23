local class = require("Class.middleclass")

---@class BankDB.Table
local Table = class("BankDB.Table")

require("BankDB.TableStruct.daytime_t")
require("BankDB.TableStruct.history_t")

---namespace JLib
JLib = JLib or {}
---namespace JLib.BankDB
JLib.BankDB = JLib.BankDB or {}
JLib.BankDB.Table = Table

---constructor
function Table:initialize()
    self.Owner = ""
    self.Balance = 1000;
    self.Histories = {}
end

---properties description
---@class BankDB.Table
---@field Owner string
---@field Balance number
---@field Histories table<number, BankDB.Table.History>
---@field new fun(self:BankDB.Table):BankDB.Table

---serialize this
---@return string
function Table:Serialize()
    local temp = {}
    temp.Owner = self.Owner
    temp.Balance = self.Balance
    return textutils.serialize(temp)
end

---deserialize string, without Histories filled
---@param str string
---@return BankDB.Table
function Table:Deserialize(str)
    local temp = textutils.unserialize(str)
    local temp2 = JLib.BankDB.Table:new()
    temp2.Owner = temp.Owner
    temp2.Balance = temp.Balance
    return temp2
end