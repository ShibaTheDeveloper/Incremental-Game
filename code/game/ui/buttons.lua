-- ~/code/game/ui/buttons.lua

local BoxFactoryModule = require("code.game.box.factory")
local RenderModule = require("code.engine.render")

local BOX_CONSTANTS = require("code.game.box.constants")
local CONSTANTS = require("code.game.ui.constants")

local Module = {}
Module._buttons = {
    spawnButton = {
        hitbox = nil,
        elements = {
            background = nil,
            label = nil
        },
        callback = function()
            BoxFactoryModule:spawn()
        end
    }
}

local initiated = false

local function buttonClick(button)
    for _, element in pairs(button.elements) do
        element.scaleX, element.scaleY = element.scaleX - CONSTANTS.BUTTON_CLICK_SCALE_SUBTRACTION, element.scaleY - CONSTANTS.BUTTON_CLICK_SCALE_SUBTRACTION
    end

    if button.callback then
        button.callback()
    end
end

function Module:update(deltaTime)
    if not initiated then return end

    for _, button in pairs(self._buttons) do
        if not button.hitbox then goto continue end

        for _, element in pairs(button.elements) do
            if element.scaleX < 1 then
                local scalePerSecond = 1 / CONSTANTS.BASE_BUTTON_CLICK_SCALE_SPEED
                local scale = element.scaleX + scalePerSecond * deltaTime

                element.scaleX, element.scaleY = scale, scale
            else
                element.scaleX, element.scaleY = 1, 1
            end
        end

        :: continue ::
    end
end

function Module:mousePressed(x, y, button)
    if button ~= 1 then return end

    for _, button in pairs(self._buttons) do
        if button.hitbox:isPointInside(x, y) then
            buttonClick(button)
        end
    end
end

local function setupSpawnButton()
    local spawnButtonX = BOX_CONSTANTS.AREA_WIDTH + (_G.WINDOW_WIDTH - BOX_CONSTANTS.AREA_WIDTH) / 2
    local spawnButtonY = 475

    Module._buttons.spawnButton.elements.label = RenderModule:createElement({
        text = [[Spawn Box!]],
        type = "text",

        font = love.graphics.newFont("assets/fonts/Stanberry.ttf", 28),

        x = spawnButtonX,
        y = spawnButtonY,

        zIndex = 1001,

        color = RenderModule:createColor(255, 255, 255, 1)
    })

    Module._buttons.spawnButton.elements.background = RenderModule:createElement({
        spritePath = "assets/sprites/backgrounds/button.png",
        type = "sprite",

        x = spawnButtonX,
        y = spawnButtonY,

        zIndex = 1000,

        color = RenderModule:createColor(244, 181, 22, 1)
    })

    Module._buttons.spawnButton.hitbox = Module._buttons.spawnButton.elements.background
end

function Module.init()
    setupSpawnButton()

    initiated = true
end

return Module