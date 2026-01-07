-- ~/main.lua

local BoxHandlerModule = require("code.game.box.handler")
local VFXHandlerModule = require("code.game.vfx.handler")
local UIHandlerModule = require("code.game.ui.handler")
local extra = require("code.engine.extra")

local RenderModule = require("code.engine.render")

VFXHandlerModule.init()
UIHandlerModule.init()

function love.update(deltaTime)
    BoxHandlerModule:update(deltaTime)
    VFXHandlerModule:update(deltaTime)
    UIHandlerModule:update(deltaTime)
end

function love.draw()
    RenderModule:drawAll()
end

function love.mousepressed(_, _, button)
    local virtualX, virtualY = extra.getScaledMousePos()
    UIHandlerModule:mousePressed(virtualX, virtualY, button)
end

function love.quit()
    love.window.setFullscreen(false)
end