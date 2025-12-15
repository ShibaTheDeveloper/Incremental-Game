local Module = {}
Module.fullscreen = false
Module._imageCache = {}
Module._elements = {}

function Module:createColor(r, g, b, alpha)
    return {
        r = (r or 255) / 255,
        g = (g or 255) / 255,
        b = (b or 255)  / 255,
        alpha = alpha or 1
    }
end

local Element = {
    type = "sprite",
    zIndex = 0,

    anchorX = .5,
    anchorY = .5,

    offsetX = 0,
    offsetY = 0,

    scaleX = 1,
    scaleY = 1,

    x = 0,
    y = 0,

    color = Module:createColor(255, 255, 255),
    rotation = 0,

    flip = false
}
Element.__index = Element

function Element:remove()
    for index, value in ipairs(Module._elements) do
        if value == self then
            table.remove(Module._elements, index)
            break
        end
    end
end

function Element:draw(windowScaleFactor, windowOffsetX, windowOffsetY)
    local x = self.x * windowScaleFactor + windowOffsetX + (self.offsetX or 0)
    local y = self.y * windowScaleFactor + windowOffsetY + (self.offsetY or 0)

    local scaleX = self.scaleX * (self.flip and -1 or 1) * windowScaleFactor
    local scaleY = self.scaleY * windowScaleFactor

    local rotation = math.rad(self.rotation * (self.flip and -1 or 1))

    local offsetX, offsetY = 0, 0

    if self.type == "sprite" and self.drawable then
        offsetX = self.drawable:getWidth() * self.anchorX
        offsetY = self.drawable:getHeight() * self.anchorY
    elseif self.type == "text" and self.text then
        local font = love.graphics.getFont()
        offsetX = font:getWidth(self.text) * self.anchorX
        offsetY = font:getHeight() * self.anchorY
    end

    local color = self.color or Module:createColor()
    love.graphics.setColor(color.r, color.g, color.b, color.alpha)

    if self.type == "sprite" then love.graphics.draw(self.drawable, x, y, rotation, scaleX, scaleY, offsetX, offsetY)
    else love.graphics.print(self.text, x, y, rotation, scaleX, scaleY, offsetX, offsetY) end
end

function Module:createElement(type, data)
    if (type ~= "text") and (type ~= "sprite") then return end

    local element = setmetatable(data or {}, Element)
    table.insert(self._elements, element)

    element.color = data.color or Module:createColor()
    element.type = type

    if type == "sprite" then
        if not (data.spritePath and love.filesystem.getInfo(data.spritePath)) then
            data.spritePath = "assets/sprites/missing.png"
        end

        if not Module._imageCache[data.spritePath] then
            Module._imageCache[data.spritePath] = love.graphics.newImage(data.spritePath)
        end

        element.drawable = Module._imageCache[data.spritePath]
        element.spritePath = data.spritePath
    end

    return element
end

function Module:getScaledDimensions(x, y)
    local currentWindowWidth, currentWindowHeight = love.graphics.getDimensions()
    local baseWindowWidth, baseWindowHeight = _G.windowWidth, _G.windowHeight

    local windowScaleX = currentWindowWidth / baseWindowWidth
    local windowScaleY = currentWindowHeight / baseWindowHeight
    local windowScale = math.min(windowScaleX, windowScaleY)

    local offsetX = (currentWindowWidth - baseWindowWidth * windowScale) / 2
    local offsetY = (currentWindowHeight - baseWindowHeight * windowScale) / 2

    local virtualX = (x - offsetX) / windowScale
    local virtualY = (y - offsetY) / windowScale

    virtualX = math.max(0, math.min(baseWindowWidth, virtualX))
    virtualY = math.max(0, math.min(baseWindowHeight, virtualY))

    return virtualX, virtualY
end

function Module:drawAll()
    table.sort(self._elements, function(a, b)
        return a.zIndex < b.zIndex
    end)

    local currentWindowWidth, currentWindowHeight = love.graphics.getDimensions()
    local baseWindowWidth, baseWindowHeight = _G.windowWidth, _G.windowHeight

    local windowScaleFactorX = currentWindowWidth / baseWindowWidth
    local windowScaleFactorY = currentWindowHeight / baseWindowHeight
    local windowScaleFactor = math.min(windowScaleFactorX, windowScaleFactorY)

    local windowOffsetX = (currentWindowWidth - baseWindowWidth * windowScaleFactor) / 2
    local windowOffsetY = (currentWindowHeight - baseWindowHeight * windowScaleFactor) / 2

    love.graphics.setScissor(windowOffsetX, windowOffsetY, baseWindowWidth * windowScaleFactor, baseWindowHeight * windowScaleFactor)

    for _, element in pairs(self._elements) do
        element:draw(windowScaleFactor, windowOffsetX, windowOffsetY)
    end
end

return Module