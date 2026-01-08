-- ~/code/game/ui/sceneHandler.lua

local Module = {}
Module.currentScene = nil

local function sceneExists(name)
    local fsPath = "code/game/ui/scenes/" .. name .. ".lua"
    return love.filesystem.getInfo(fsPath, "file") ~= nil
end

function Module:switch(name)
    if not sceneExists(name) then return end

    if self.currentScene then
        self.currentScene:clean()
    end

    local scene = require("code.game.ui.scenes." .. name)
    scene:init()

    self.currentScene = scene
end

return Module