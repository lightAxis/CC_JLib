local class = require("Class.middleclass")

--- public class MsgStructRefresh   
--- DB -> Client  
---@class DB.MsgStructRefresh : DB.IMsgStruct
local MsgStructRefresh = class("MsgStructRefresh")

---namespace JLib
JLib = JLib or {}

---namespace JLib.DB
JLib.DB = JLib.DB or {}
JLib.DB.MsgStructRefresh = MsgStructRefresh

---constructor
---@param ProtocolToRefresh string
---@param DBData DB.Struct
function MsgStructRefresh:initialize(ProtocolToRefresh, DBData)
    self.ProtocolToRefresh = ProtocolToRefresh
    self.DBData = DBData
end

--- properties description
---@class DB.MsgStructRefresh : DB.IMsgStruct
---@field ProtocolToRefresh string
---@field DBData DB.Struct
---@field new fun(self: DB.MsgStructRefresh ,ProtocolToRefresh: string, DBData: DB.Struct):DB.MsgStructRefresh
