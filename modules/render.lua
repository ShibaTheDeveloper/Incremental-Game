local Module = {}
Module._imageCache = {}
Module._elements = {}

function Module:createColor(r, g, b, alpha)
    return {
        r = r or 255,
        g = g or 255,
        b = b or 255,
        alpha = alpha or 1
    }
end

local Element = {
    type = "sprite",
    tableIndex = 0,
    zIndex = 0,

    offsetX = 0,
    offsetY = 0,
    scaleX = 1,
    scaleY = 1,
    x = 0,
    y = 0,

    color = Module:createColor(255, 255, 255, 1),
    rotation = 0,
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

function Element:draw(windowScaleFactor, baseWindowWidth, baseWindowHeight, currentWindowWidth, currentWindowHeight)
    local windowOffsetX = (currentWindowWidth - baseWindowWidth * windowScaleFactor) / 2
    local windowOffsetY = (currentWindowHeight - baseWindowHeight * windowScaleFactor) / 2

    local x = self.x * windowScaleFactor + windowOffsetX
    local y = self.y * windowScaleFactor + windowOffsetY
    local scaleX = self.scaleX * windowScaleFactor
    local scaleY = self.scaleY * windowScaleFactor
    local offsetX = self.offsetX
    local offsetY = self.offsetY

    local rotation = self.rotation

    local color = self.color or Module:createColor()
    love.graphics.setColor(color.r / 255, color.g / 255, color.b / 255, color.alpha)

    if self.type == "sprite" then love.graphics.draw(self.drawable, x, y, rotation, scaleX, scaleY, offsetX, offsetY)
    else love.graphics.print(self.text, x, y, rotation, scaleX, scaleY, offsetX, offsetY) end
end

function Module:createElement(type, data)
    if (type ~= "text") and (type ~= "sprite") then return end

    local element = setmetatable(data or {}, Element)

    table.insert(self._elements, element)
    element.color = Module:createColor()
    element.tableIndex = #self._elements
    element.type = type

    if type == "sprite" then
        if not (data.spritePath and love.filesystem.getInfo(data.spritePath)) then
            data.spritePath = "assets/sprites/debug_missing.png"
        end

        if not Module._imageCache[data.spritePath] then
            Module._imageCache[data.spritePath] = love.graphics.newImage(data.spritePath)
        end

        element.drawable = Module._imageCache[data.spritePath]
        element.spritePath = data.spritePath
    end

    return element
end

function Module:drawAll()
    table.sort(self._elements, function(a, b)
        if a.zIndex == b.zIndex then
            return a.tableIndex > b.tableIndex
        else
            return a.zIndex < b.zIndex
        end
    end)

    local currentWindowWidth, currentWindowHeight = love.graphics.getDimensions()
    local baseWindowWidth, baseWindowHeight = _G.windowWidth, _G.windowHeight

    local windowScaleFactorX = currentWindowWidth / baseWindowWidth
    local windowScaleFactorY = currentWindowHeight / baseWindowHeight
    local windowScaleFactor = math.min(windowScaleFactorX, windowScaleFactorY)

    for _, element in ipairs(self._elements) do
        element:draw(windowScaleFactor, baseWindowWidth, baseWindowHeight, currentWindowWidth, currentWindowHeight)
    end
end

return Module