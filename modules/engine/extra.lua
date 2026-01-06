local Module = {}

function Module.clamp(x, min, max)
    x = (x > max and max or x)
    x = (x < min and min or x)

    return x
end

function Module.cloneTable(table)
    local newTable = {}

   for index, value in pairs(table) do
        newTable[index] = value
    end

    return newTable
end

function Module.getScaledMousePos()
    local screenWidth, screenHeight = love.graphics.getDimensions()

    local scaleX = screenWidth / _G.WINDOW_WIDTH
    local scaleY = screenHeight / _G.WINDOW_HEIGHT
    local scale = math.min(scaleX, scaleY)

    local offsetX = (screenWidth - _G.WINDOW_WIDTH * scale) / 2
    local offsetY = (screenHeight - _G.WINDOW_HEIGHT * scale) / 2

    local mouseX, mouseY = love.mouse.getPosition()
    local x = (mouseX - offsetX) / scale
    local y = (mouseY - offsetY) / scale

    x, y = Module.clamp(x, 0, _G.WINDOW_WIDTH), Module.clamp(y, 0, _G.WINDOW_HEIGHT)

    return x, y
end

return Module