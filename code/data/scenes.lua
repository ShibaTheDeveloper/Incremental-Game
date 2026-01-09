-- ~/code/data/scenes.lua

local RenderModule = require("code.engine.render")

local BOX_CONSTANTS = require("code.game.box.constants")

local spawnButtonX = BOX_CONSTANTS.AREA_WIDTH + (_G.WINDOW_WIDTH - BOX_CONSTANTS.AREA_WIDTH) / 2
local spawnButtonY = 500

local defaultButtonPath = "assets/sprites/ui/button220x75.png"
local stanberryFontPath = "assets/fonts/Stanberry.ttf"

local middleX = _G.WINDOW_WIDTH / 2
local middleY = _G.WINDOW_HEIGHT / 2

local newGameButtonY = 300
local backButtonY = 460

return {
    game = {
        spawnButtonHitbox = {
            spritePath = defaultButtonPath,
            type = "sprite",

            x = spawnButtonX,
            y = spawnButtonY,

            color = RenderModule:createColor(255, 200, 0),
            zIndex = 1001
        },

        spawnButtonCostLabel = {
            text = "Cost: (FREE)",
            type = "text",

            x = spawnButtonX,
            y = spawnButtonY + 15,

            color = RenderModule:createColor(255, 255, 255),
            font = love.graphics.newFont(stanberryFontPath, 20),
            zIndex = 1002
        },

        spawnButtonLabel = {
            text = "Spawn Box!",
            type = "text",

            x = spawnButtonX,
            y = spawnButtonY - 8,

            color = RenderModule:createColor(255, 255, 255),
            font = love.graphics.newFont(stanberryFontPath, 28),
            zIndex = 1002
        },

        playAreaBackground = {
            spritePath = "assets/sprites/backgrounds/areabg.png",
            type = "sprite",

            anchorX = 0,
            anchorY = 0,
            zIndex = 1
        },

        sidebarBackground = {
            spritePath = "assets/sprites/backgrounds/sidebar.png",
            type = "sprite",

            anchorX = 0,
            anchorY = 0,

            x = BOX_CONSTANTS.AREA_WIDTH,
            zIndex = 1000
        }
    },
    mainMenu = {
        background = {
            spritePath = "assets/sprites/backgrounds/menubg.png",
            type = "sprite",

            anchorX = 0,
            anchorY = 0,
            zIndex = 1
        },

        playGameButtonHitbox = {
            spritePath = defaultButtonPath,
            type = "sprite",

            x = middleX,
            y = newGameButtonY,

            color = RenderModule:createColor(151, 188, 98),
            zIndex = 1001
        },

        playGameButtonLabel = {
            text = "Play Game",
            type = "text",

            x = middleX,
            y = newGameButtonY,

            color = RenderModule:createColor(255, 255, 255),
            font = love.graphics.newFont(stanberryFontPath, 28),
            zIndex = 1002
        },

        quitButtonHitbox = {
            spritePath = defaultButtonPath,
            type = "sprite",

            x = middleX,
            y = newGameButtonY + 100,

            color = RenderModule:createColor(204, 49, 61),
            zIndex = 1001
        },

        quitButtonLabel = {
            text = "Quit Game",
            type = "text",

            x = middleX,
            y = newGameButtonY + 100,

            color = RenderModule:createColor(255, 255, 255),
            font = love.graphics.newFont(stanberryFontPath, 28),
            zIndex = 1002
        },
    },
    saveFiles = {
        background = {
            spritePath = "assets/sprites/backgrounds/menubg.png",
            type = "sprite",

            anchorX = 0,
            anchorY = 0,
            zIndex = 1
        },

        backToMenuButtonHitbox = {
            spritePath = defaultButtonPath,
            type = "sprite",

            x = middleX,
            y = backButtonY,

            color = RenderModule:createColor(204, 49, 61),
            zIndex = 1001
        },

        backToMenuButtonLabel = {
            text = "Back",
            type = "text",

            x = middleX,
            y = backButtonY,

            color = RenderModule:createColor(255, 255, 255),
            font = love.graphics.newFont(stanberryFontPath, 28),
            zIndex = 1002
        },

        templateSaveFileButtonHitbox = {
            spritePath = defaultButtonPath,
            type = "sprite",

            x = middleX,
            y = middleY - 75,

            rotation = math.rad(90),

            scaleX = 1.5,
            scaleY = 2,

            color = RenderModule:createColor(231, 232, 209, .8),
            zIndex = 1001
        },

        templateSaveFileButtonLabel = {
            text = "Slot ",
            type = "text",

            x = middleX,
            y = middleY - 200,

            color = RenderModule:createColor(255, 255, 255),
            font = love.graphics.newFont(stanberryFontPath, 28),
            zIndex = 1002
        },
    }
}