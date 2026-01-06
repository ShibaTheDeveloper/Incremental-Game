local BoxUpdateHandler = require("modules.game.box.updateHandler")
local RenderModule = require("modules.engine.render")

function love.update(deltaTime)
    BoxUpdateHandler:update(deltaTime)
end

function love.draw()
    RenderModule:drawAll()
end

function love.quit()
    love.window.setFullscreen(false)
end