local class = require("Class.middleclass")

---@class BankDB.IMsgStruct
local IMsgStruct = class("BankDB.IMsgStruct")

---namespace JLib
JLib = JLib or {}
---namespace JLib.BankDB
JLib.BankDB = JLib.BankDB or {}
---namespace JLib.BankDB.MsgStruct
JLib.BankDB.MsgStruct = JLib.BankDB.MsgStruct or {}
JLib.BankDB.MsgStruct.IMsgStruct = IMsgStruct

---constuctor
function IMsgStruct:initialize() end

---abstract function
function IMsgStruct:Serialize()
    error("this is abstract function! BankDB.IMsgStruct:Serialize")
end

function IMsgStruct:Deserialize(str)
    error("This is abstract function! BankDB.IMsgStrcut:Deserialize")
end
