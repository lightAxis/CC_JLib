local class = require("Class.middleclass")

---@class PortDB.IMsgStruct
local IMsgStruct = class("PortDB.IMsgStruct")

---namespace JLib
JLib = JLib or {}
---namespace JLib.PortDB
JLib.PortDB = JLib.PortDB or {}
---namespace JLib.PortDB.MsgStruct
JLib.PortDB.MsgStruct = JLib.PortDB.MsgStruct or {}
JLib.PortDB.MsgStruct.IMsgStruct = IMsgStruct

---constuctor
function IMsgStruct:initialize() end

---abstract function
---@return string 
function IMsgStruct:Serialize()
    error("this is abstract function! PortDB.IMsgStruct:Serialize")
    return ""
end

function IMsgStruct:Deserialize(str)
    error("This is abstract function! PortDB.IMsgStrcut:Deserialize")
    return ""
end
