-- ~/code/game/vfx/handler.lua

local ScreenFlashModule = require("code.game.vfx.screenFlash")

local Module = {}

function Module:update(deltaTime)
    ScreenFlashModule:update(deltaTime)
end

function Module.init()
    ScreenFlashModule.init()
end

return Module