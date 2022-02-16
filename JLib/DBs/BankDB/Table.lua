local class = require("Class.middleclass")

---@class BankDB.Table
local Table = class("BankDB.Table")

require("DBs.BankDB.TableStruct.daytime_t")
require("DBs.BankDB.TableStruct.history_t")

---namespace JLib
JLib = JLib or {}
---namespace JLib.BankDB
JLib.BankDB = JLib.BankDB or {}
JLib.BankDB.Table = Table

---constructor
function Table:initialize()
    self.Owner = ""
    self.Balance = 1000
    self.WorkingHour = 0
    self.Salary = 23000000
    self.Histories = {}
end

---properties description
---@class BankDB.Table
---@field Owner string
---@field Balance number
---@field WorkingHour number
---@field Salary number
---@field Histories table<number, BankDB.Table_t.History>
---@field new fun(self:BankDB.Table):BankDB.Table

---serialize this
---@return string
function Table:Serialize()
    local temp = {}
    temp.Owner = self.Owner
    temp.Balance = self.Balance
    temp.WorkingHour = self.WorkingHour
    temp.Salary = self.Salary
    local histories = {}
    for index, value in ipairs(self.Histories) do
        table.insert(histories,value:Serialize())
    end
    temp.Histories = textutils.serialize(histories)
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
    temp2.WorkingHour = temp.WorkingHour
    temp2.Salary = temp.Salary
    local temp3 = textutils.unserialize(temp.Histories)
    local temp4 = {}
    for index, value in ipairs(temp3) do
        table.insert(temp4, JLib.BankDB.Table_t.History:Deserialize(value))
    end
    temp2.Histories = temp4
    return temp2
end