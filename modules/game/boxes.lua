local IdManagerModule = require("modules.engine.id_manager")
local manager = IdManagerModule:createManager()

local Box = {}

local Module = {}

function Module:createBox(tier)
    local box = setmetatable({
        id = manager:get(),
        tier = tier or 1
    }, Box)
end

return Module