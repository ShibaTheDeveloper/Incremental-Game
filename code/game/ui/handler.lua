-- ~/code/game/ui/handler.lua

local setupUIBackgrounds = require("code.game.ui.backgrounds")
local UIButtonsModule = require("code.game.ui.buttons")

local Module = {}

function Module:mousePressed(x, y, button)
    UIButtonsModule:mousePressed(x, y, button)
end

function Module:update(deltaTime)
    UIButtonsModule:update(deltaTime)
end

function Module.init()
    UIButtonsModule.init()
    setupUIBackgrounds()
end

return Module