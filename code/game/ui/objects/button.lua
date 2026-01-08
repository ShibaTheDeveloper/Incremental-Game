-- ~/code/game/ui/objects/button.lua

local IdManagerModule = require("code.engine.idManager")
local RenderModule = require("code.engine.render")

local manager = IdManagerModule:createManager()

local Button = {
    id = 0,

    elements = {},

    cooldown = 0,
    lastUsed = 0,

    hitboxElement = nil,

    mouseButton = 1,
    onClick = nil
}
Button.__index = Button

local Module = {}
Module._buttons = {}

function Button:remove()
    local id = self.id

    Module._buttons[id] = nil
    manager:release(id)
end

function Button:click(x, y, mouseButton)
    if (os.clock() - self.lastUsed) < self.cooldown then return end
    if not self.hitboxElement:isPointInside(x, y) then return end
    if mouseButton ~= self.mouseButton then return end

    self.lastUsed = os.clock()

    if self.onClick then
        self:onClick()
    end
end

function Button:update(deltaTime)
    if not self.hitboxElement then self:remove() return end
end

function Module:createButton(data)
    if not data then return end

    if not data.hitboxElement then return end
    if #data.elements == 0 then return end

    local button = setmetatable({
        id = manager:get(),

        elements = data.elements or {},

        cooldown = data.cooldown or .25,
        lastUsed = 0,

        hitboxElement = data.hitboxElement,

        mouseButton = data.mouseButton or 1,
        onClick = data.onClick or nil
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