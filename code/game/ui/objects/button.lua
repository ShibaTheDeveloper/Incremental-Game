-- ~/code/game/ui/objects/button.lua

local ScreenTransitionModule = require("code.game.vfx.screenTransition")

local IdManagerModule = require("code.engine.idManager")
local SoundModule = require("code.engine.sound")

local manager = IdManagerModule:createManager()

local Button = {
    id = 0,

    elements = {},

    cooldown = 0,
    lastUsed = 0,

    hitboxElement = nil,

    mouseButton = 1,
    onClick = nil,

    _clickScale = .1,
    _scaleSpeed = .5
}
Button.__index = Button

local Module = {}
Module._buttons = {}

function Button:remove()
    Module._buttons[self.id] = nil
    manager:release(self.id)
end

function Button:click(x, y, mouseButton)
    if ScreenTransitionModule.transitioning then return end

    if (os.clock() - self.lastUsed) < self.cooldown then return end
    if not self.hitboxElement:isPointInside(x, y) then return end
    if mouseButton ~= self.mouseButton then return end

    self.lastUsed = os.clock()

    for _, element in pairs(self.elements) do
        element._baseScaleX = element._baseScaleX or (element.scaleX or 1)
        element._baseScaleY = element._baseScaleY or (element.scaleY or 1)

        element.scaleX = element.scaleX - self._clickScale
        element.scaleY = element.scaleY - self._clickScale
    end

    if self.playClickSound then
        local sound = SoundModule:createSound({soundPath = "assets/sounds/ui/click.wav"})

        if sound then
            sound:play(true, -100, 100, 1000)
            sound:remove()
        end
    end

    if self.onClick then
        self:onClick()
    end
end

function Button:update(deltaTime)
    if not self.hitboxElement then self:remove() return end

    for _, element in pairs(self.elements) do
        element._baseScaleX = element._baseScaleX or (element.scaleX or 1)
        element._baseScaleY = element._baseScaleY or (element.scaleY or 1)

        if element.scaleX < element._baseScaleX then
            element.scaleX = math.min(element.scaleX + self._scaleSpeed * deltaTime, element._baseScaleX)
        end
        if element.scaleY < element._baseScaleY then
            element.scaleY = math.min(element.scaleY + self._scaleSpeed * deltaTime, element._baseScaleY)
        end
    end
end

function Module:createButton(data)
    if not data then return end
    if not data.hitboxElement then return end
    if #data.elements == 0 then return end

    local button = setmetatable({
        id = manager:get(),

        elements = data.elements or {},

        cooldown = data.cooldown or .25,
        lastUsed = -math.huge,

        playClickSound = data.playClickSound or true,

        hitboxElement = data.hitboxElement,

        mouseButton = data.mouseButton or 1,
        onClick = data.onClick or nil,

        _clickScale = data.clickScale or .1,
        _scaleSpeed = data.scaleSpeed or .5
    }, Button)

    Module._buttons[button.id] = button
    return button
end

function Module:mousePressed(x, y, mouseButton)
    for _, button in pairs(self._buttons) do
        button:click(x, y, mouseButton)
    end
end

function Module:updateAll(deltaTime)
    for _, button in pairs(self._buttons) do
        button:update(deltaTime)
    end
end

return Module