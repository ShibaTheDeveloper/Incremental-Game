local RenderModule = require("modules.internal.render")
local PlayerModule = require("modules.game.player")
local ItemModule = require("modules.game.item")

function love.load()
    PlayerModule.init()
end

function love.update(deltaTime)
    PlayerModule:step(deltaTime)

    if love.mouse.isDown(1) then
        PlayerModule:mouseClick()
    end
end

function love.draw()
    RenderModule:drawAll()
end

function love.quit()
    love.window.setFullscreen(false)
end