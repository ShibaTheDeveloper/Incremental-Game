-- ~/code/game/ui/handler.lua

local UIButtonObjectModule = require("code.game.ui.objects.button")
local UISceneHandlerModule = require("code.game.ui.sceneHandler")

local Module = {}

function Module:mousePressed(x, y, button)
    UIButtonObjectModule:mousePressed(x, y, button)
end

function Module:update(deltaTime)
    UIButtonObjectModule:updateAll(deltaTime)
    UISceneHandlerModule:update(deltaTime)
end

function Module.init()
    UISceneHandlerModule:switch("mainMenu")
end

return Module