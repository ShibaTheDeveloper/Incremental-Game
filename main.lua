-- ~/main.lua

local BoxHandlerModule = require("code.game.box.handler")
local VFXHandlerModule = require("code.game.vfx.handler")
local UIHandlerModule = require("code.game.ui.handler")

local SaveFilesModule = require("code.engine.saveFiles")
local RenderModule = require("code.engine.render")

VFXHandlerModule.init()
UIHandlerModule.init()

SaveFilesModule.init()

function love.update(deltaTime)
    BoxHandlerModule:update(deltaTime)
    VFXHandlerModule:update(deltaTime)
    UIHandlerModule:update(deltaTime)
end

function love.draw()
    RenderModule:drawAll()
end

function love.mousepressed(_, _, button)
    local mouseX, mouseY = RenderModule:getMousePos()
    UIHandlerModule:mousePressed(mouseX, mouseY, button)
end

function love.quit()
    love.window.setFullscreen(false)
    SaveFilesModule.quit()
end