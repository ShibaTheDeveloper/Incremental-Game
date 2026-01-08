-- ~/code/data/scenes.lua

local RenderModule = require("code.engine.render")

local BOX_CONSTANTS = require("code.game.box.constants")

local spawnButtonX = BOX_CONSTANTS.AREA_WIDTH + (_G.WINDOW_WIDTH - BOX_CONSTANTS.AREA_WIDTH) / 2
local spawnButtonY = 500

local defaultButtonPath = "assets/sprites/ui/button220x75.png"
local stanberryFontPath = "assets/fonts/Stanberry.ttf"

return {
    game = {
        spawnButtonHitbox = {
            spritePath = defaultButtonPath,
            type = "sprite",

            x = spawnButtonX,
            y = spawnButtonY,

            color = RenderModule:createColor(255, 200, 0)
        },

        spawnButtonCostLabel = {
            text = "Cost: (FREE)",
            type = "text",

            x = spawnButtonX,
            y = spawnButtonY + 15,

            color = RenderModule:createColor(255, 255, 255),
            font = love.graphics.newFont(stanberryFontPath, 20)
        },

        spawnButtonLabel = {
            text = "Spawn Box!",
            type = "text",

            x = spawnButtonX,
            y = spawnButtonY - 8,

            color = RenderModule:createColor(255, 255, 255),
            font = love.graphics.newFont(stanberryFontPath, 28)
        },

        playAreaBackground = {
            spritePath = "assets/sprites/backgrounds/areabg.png",
            type = "sprite",

            anchorX = 0,
            anchorY = 0
        },

        sidebarBackground = {
            spritePath = "assets/sprites/backgrounds/sidebar.png",
            type = "sprite",

            anchorX = 0,
            anchorY = 0,

            x = BOX_CONSTANTS.AREA_WIDTH
        }
    }
}