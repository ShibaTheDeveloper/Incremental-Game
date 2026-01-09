-- ~/code/data/scenes.lua

local RenderModule = require("code.engine.render")
local BOX_CONSTANTS = require("code.game.box.constants")

local BUTTON_Y_OFFSET = 100
local SPAWN_BUTTON_Y = 475
local NEW_GAME_BUTTON_Y = 350
local TEMPLATE_SAVE_FILE_SLOT_OFFSET = 310
local TEMPLATE_SAVE_FILE_Y_DIVIDER = 1.6
local TEMPLATE_LOAD_BUTTON_OFFSET = 50
local TEMPLATE_ROTATION = math.rad(90)
local TEMPLATE_SCALE_X = 1.5
local TEMPLATE_SCALE_Y = 2
local TEMPLATE_SMALL_SCALE = 0.55

local DEFAULT_BUTTON_PATH = "assets/sprites/ui/button220x75.png"
local STANBERRY_FONT_PATH = "assets/fonts/Stanberry.ttf"

local MIDDLE_X = _G.WINDOW_WIDTH / 2
local MIDDLE_Y = _G.WINDOW_HEIGHT / 2

local SPAWN_BUTTON_X = BOX_CONSTANTS.AREA_WIDTH + (_G.WINDOW_WIDTH - BOX_CONSTANTS.AREA_WIDTH) / 2

return {
    game = {
        spawnButtonHitbox = {
            spritePath = DEFAULT_BUTTON_PATH,
            type = "sprite",
            x = SPAWN_BUTTON_X,
            y = SPAWN_BUTTON_Y,
            color = RenderModule:createColor(255, 200, 0),
            zIndex = 1001
        },

        spawnButtonCostLabel = {
            text = "Cost: (FREE)",
            type = "text",
            x = SPAWN_BUTTON_X,
            y = SPAWN_BUTTON_Y + 15,
            color = RenderModule:createColor(255, 255, 255),
            font = love.graphics.newFont(STANBERRY_FONT_PATH, 20),
            zIndex = 1002
        },

        spawnButtonLabel = {
            text = "Spawn Box!",
            type = "text",
            x = SPAWN_BUTTON_X,
            y = SPAWN_BUTTON_Y - 8,
            color = RenderModule:createColor(255, 255, 255),
            font = love.graphics.newFont(STANBERRY_FONT_PATH, 28),
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
            spritePath = "assets/sprites/ui/sidebar.png",
            type = "sprite",
            anchorX = 0,
            anchorY = 0,
            x = BOX_CONSTANTS.AREA_WIDTH,
            color = RenderModule:createColor(42, 42, 42),
            zIndex = 1000
        },

        sessionPlaytimeLabel = {
            text = "Session Time: ",
            type = "text",

            font = love.graphics.newFont(STANBERRY_FONT_PATH, 20),

            anchorX = 0,
            anchorY = 0,

            x = 5,
            y = 5,

            zIndex = 1003,
        },

        backToMenuButtonHitbox = {
            spritePath = "assets/sprites/ui/buttonmenu74x74.png",
            type = "sprite",
            x = _G.WINDOW_WIDTH - 35,
            y = 35,
            anchorX = .5,
            anchorY = .5,
            scaleX = .6,
            scaleY = .6,
            color = RenderModule:createColor(117, 124, 136),
            zIndex = 1004
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

        logo = {
            spritePath = "assets/sprites/ui/logo.png",
            type = "sprite",
            x = MIDDLE_X,
            y = NEW_GAME_BUTTON_Y - 200,
            zIndex = 2
        },

        playGameButtonHitbox = {
            spritePath = DEFAULT_BUTTON_PATH,
            type = "sprite",
            x = MIDDLE_X,
            y = NEW_GAME_BUTTON_Y,
            color = RenderModule:createColor(151, 188, 98),
            zIndex = 1001
        },

        playGameButtonLabel = {
            text = "Play Game",
            type = "text",
            x = MIDDLE_X,
            y = NEW_GAME_BUTTON_Y,
            color = RenderModule:createColor(255, 255, 255),
            font = love.graphics.newFont(STANBERRY_FONT_PATH, 28),
            zIndex = 1002
        },

        quitButtonHitbox = {
            spritePath = DEFAULT_BUTTON_PATH,
            type = "sprite",
            x = MIDDLE_X,
            y = NEW_GAME_BUTTON_Y + BUTTON_Y_OFFSET,
            color = RenderModule:createColor(204, 49, 61),
            zIndex = 1001
        },

        quitButtonLabel = {
            text = "Quit Game",
            type = "text",
            x = MIDDLE_X,
            y = NEW_GAME_BUTTON_Y + BUTTON_Y_OFFSET,
            color = RenderModule:createColor(255, 255, 255),
            font = love.graphics.newFont(STANBERRY_FONT_PATH, 28),
            zIndex = 1002
        }
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
            spritePath = DEFAULT_BUTTON_PATH,
            type = "sprite",
            x = MIDDLE_X,
            y = NEW_GAME_BUTTON_Y + BUTTON_Y_OFFSET,
            color = RenderModule:createColor(204, 49, 61),
            zIndex = 1001
        },

        backToMenuButtonLabel = {
            text = "Back",
            type = "text",
            x = MIDDLE_X,
            y = NEW_GAME_BUTTON_Y + BUTTON_Y_OFFSET,
            color = RenderModule:createColor(255, 255, 255),
            font = love.graphics.newFont(STANBERRY_FONT_PATH, 28),
            zIndex = 1002
        },

        templateSaveFileBackground = {
            spritePath = DEFAULT_BUTTON_PATH,
            type = "sprite",
            x = MIDDLE_X,
            y = NEW_GAME_BUTTON_Y / TEMPLATE_SAVE_FILE_Y_DIVIDER,
            rotation = TEMPLATE_ROTATION,
            scaleX = TEMPLATE_SCALE_X,
            scaleY = TEMPLATE_SCALE_Y,
            color = RenderModule:createColor(42, 42, 42, 0.8),
            zIndex = 1001
        },

        templateSaveFileLabel = {
            text = "Slot ",
            type = "text",
            x = MIDDLE_X,
            y = NEW_GAME_BUTTON_Y - TEMPLATE_SAVE_FILE_SLOT_OFFSET,
            color = RenderModule:createColor(255, 255, 255),
            font = love.graphics.newFont(STANBERRY_FONT_PATH, 28),
            zIndex = 1002
        },

        templateSaveFileLoadButtonHitbox = {
            spritePath = DEFAULT_BUTTON_PATH,
            type = "sprite",
            x = MIDDLE_X,
            y = NEW_GAME_BUTTON_Y - TEMPLATE_LOAD_BUTTON_OFFSET,
            scaleX = TEMPLATE_SMALL_SCALE,
            scaleY = TEMPLATE_SMALL_SCALE,
            color = RenderModule:createColor(151, 188, 98),
            zIndex = 1002
        },

        templateSaveFileLoadButtonLabel = {
            text = "Load File",
            type = "text",
            x = MIDDLE_X,
            y = NEW_GAME_BUTTON_Y - TEMPLATE_LOAD_BUTTON_OFFSET,
            scaleX = TEMPLATE_SMALL_SCALE,
            scaleY = TEMPLATE_SMALL_SCALE,
            color = RenderModule:createColor(255, 255, 255),
            font = love.graphics.newFont(STANBERRY_FONT_PATH, 28),
            zIndex = 1003
        },

        templateSaveFileResetButtonHitbox = {
            spritePath = DEFAULT_BUTTON_PATH,
            type = "sprite",
            x = MIDDLE_X,
            y = NEW_GAME_BUTTON_Y,
            scaleX = TEMPLATE_SMALL_SCALE,
            scaleY = TEMPLATE_SMALL_SCALE,
            color = RenderModule:createColor(204, 49, 61),
            zIndex = 1002
        },

        templateSaveFileResetButtonLabel = {
            text = "Reset File",
            type = "text",
            x = MIDDLE_X,
            y = NEW_GAME_BUTTON_Y,
            scaleX = TEMPLATE_SMALL_SCALE,
            scaleY = TEMPLATE_SMALL_SCALE,
            color = RenderModule:createColor(255, 255, 255),
            font = love.graphics.newFont(STANBERRY_FONT_PATH, 28),
            zIndex = 1003
        },

        templateSaveFileBoxPreview = {
            x = MIDDLE_X,
            y = NEW_GAME_BUTTON_Y / TEMPLATE_SAVE_FILE_Y_DIVIDER - 25,
            scaleX = 1,
            scaleY = 1,
            zIndex = 1004
        },

        templateSaveHighestTier = {
            text = "Highest Tier: 1",
            type = "text",
            x = MIDDLE_X,
            y = NEW_GAME_BUTTON_Y - TEMPLATE_SAVE_FILE_SLOT_OFFSET + 40,
            color = RenderModule:createColor(255, 255, 255),
            font = love.graphics.newFont(STANBERRY_FONT_PATH, 20),
            zIndex = 1002
        },

        templateSavePlaytime = {
            text = "0:00:00",
            type = "text",
            x = MIDDLE_X,
            y = NEW_GAME_BUTTON_Y - TEMPLATE_SAVE_FILE_SLOT_OFFSET + 65,
            color = RenderModule:createColor(255, 255, 255),
            font = love.graphics.newFont(STANBERRY_FONT_PATH, 22),
            zIndex = 1002
        }
    }
}