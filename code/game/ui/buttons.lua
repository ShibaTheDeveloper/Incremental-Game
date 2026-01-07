-- ~/code/game/ui/buttons.lua

local BoxFactoryModule = require("code.game.box.factory")
local RenderModule = require("code.engine.render")

local BOX_CONSTANTS = require("code.game.box.constants")

local Module = {}
Module._spawnButtonLabel = nil
Module._spawnButton = nil

local function spawnButton()
    BoxFactoryModule:spawn()
end

function Module:update(deltaTime)
    if not Module._spawnButtonLabel then return end
    if not Module._spawnButton then return end


end

function Module:mousePressed(x, y, button)
    if button ~= 1 then return end

    if Module._spawnButton:isPointInside(x, y) then
        spawnButton()
    end
end

function Module.init()
    local spawnButtonX = BOX_CONSTANTS.AREA_WIDTH + (_G.WINDOW_WIDTH - BOX_CONSTANTS.AREA_WIDTH) / 2
    local spawnButtonY = 475

    Module._spawnButtonLabel = RenderModule:createElement({
        text = [[Spawn Box!]],
        type = "text",

        font = love.graphics.newFont("assets/Stanberry.ttf", 28),

        x = spawnButtonX,
        y = spawnButtonY,

        zIndex = 1001,

        color = RenderModule:createColor(255, 255, 255, 1)
    })

    Module._spawnButton = RenderModule:createElement({
        spritePath = "assets/sprites/backgrounds/button.png",
        type = "sprite",

        x = spawnButtonX,
        y = spawnButtonY,

        zIndex = 1000,

        color = RenderModule:createColor(244, 181, 22, 1)
    })
end

return Module