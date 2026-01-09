-- ~/code/game/ui/sceneHandler.lua

local Module = {}
Module._activeTransition = nil
Module.currentScene = nil

local function sceneExists(name)
    local fsPath = "code/game/ui/scenes/" .. name .. ".lua"
    return love.filesystem.getInfo(fsPath, "file") ~= nil
end

function Module:update(deltaTime)
    if not self.currentScene then return end

    if self.currentScene.update then
        self.currentScene:update(deltaTime)
    end
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