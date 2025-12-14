local RenderModule = require("modules.render")
RenderModule:createElement("sprite", {x = 10, y = 70, scaleX = 1, scaleY = 1})
RenderModule:createElement("sprite", {x = 80, y = 14, scaleX = 1, scaleY = 1})
RenderModule:createElement("sprite", {x = 98, y = 5, scaleX = 1, scaleY = 1})
RenderModule:createElement("sprite", {x = 52, y = 98, scaleX = 1, scaleY = 1})

function love.draw()
    RenderModule:drawAll()
end

function love.quit()
    love.window.setFullscreen(false)
end