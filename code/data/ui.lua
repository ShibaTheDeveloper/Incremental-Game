-- ~/code/data/scenes.lua

local RenderModule = require("code.engine.render")

local BOX_CONSTANTS = require("code.game.box.constants")
local CONSTANTS = require("code.game.ui.constants")

return {
    game = {
        spawnButtonHitbox = {
            spritePath = CONSTANTS.DEFAULT_BUTTON_PATH,
            type = "sprite",
            x = CONSTANTS.SPAWN_BUTTON_X,
            y = CONSTANTS.SPAWN_BUTTON_Y,
            color = RenderModule:createColor(255, 200, 0),
            zIndex = 1001
        },

        spawnButtonCostLabel = {
            text = "Cost: (FREE)",
            type = "text",
            x = CONSTANTS.SPAWN_BUTTON_X,
            y = CONSTANTS.SPAWN_BUTTON_Y + 15,
            color = RenderModule:createColor(255, 255, 255),
            font = love.graphics.newFont(CONSTANTS.STANBERRY_FONT_PATH, 20),
            zIndex = 1002
        },

        spawnButtonLabel = {
            text = "Spawn Box!",
            type = "text",
            x = CONSTANTS.SPAWN_BUTTON_X,
            y = CONSTANTS.SPAWN_BUTTON_Y - 8,
            color = RenderModule:createColor(255, 255, 255),
            font = love.graphics.newFont(CONSTANTS.STANBERRY_FONT_PATH, 28),
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

            font = love.graphics.newFont(CONSTANTS.STANBERRY_FONT_PATH, 20),

            anchorX = 0,
            anchorY = 0,

            x = 5,
            y = 5,

            zIndex = 1003,
        },

        backToMenuButtonHitbox = {
            spritePath = "assets/sprites/ui/buttonmenu74x74.png",
            type = "sprite",
            x = CONSTANTS.SETTINGS_BUTTON_X - 55,
            y = CONSTANTS.SETTINGS_BUTTON_OFFSET,
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
            x = CONSTANTS.MIDDLE_X,
            y = CONSTANTS.NEW_GAME_BUTTON_Y - 225,

            scaleX = .5,
            scaleY = .5,

            zIndex = 2
        },
        logo2 = {
            spritePath = "assets/sprites/ui/logo2.png",
            type = "sprite",
            x = CONSTANTS.MIDDLE_X,
            y = CONSTANTS.NEW_GAME_BUTTON_Y - 100,

            scaleX = .35,
            scaleY = .35,

            zIndex = 3
        },

        playGameButtonHitbox = {
            spritePath = CONSTANTS.DEFAULT_BUTTON_PATH,
            type = "sprite",
            x = CONSTANTS.MIDDLE_X,
            y = CONSTANTS.NEW_GAME_BUTTON_Y,
            color = RenderModule:createColor(151, 188, 98),
            zIndex = 1001
        },

        playGameButtonLabel = {
            text = "Play Game",
            type = "text",
            x = CONSTANTS.MIDDLE_X,
            y = CONSTANTS.NEW_GAME_BUTTON_Y,
            color = RenderModule:createColor(255, 255, 255),
            font = love.graphics.newFont(CONSTANTS.STANBERRY_FONT_PATH, 28),
            zIndex = 1002
        },

        quitButtonHitbox = {
            spritePath = CONSTANTS.DEFAULT_BUTTON_PATH,
            type = "sprite",
            x = CONSTANTS.MIDDLE_X,
            y = CONSTANTS.NEW_GAME_BUTTON_Y + CONSTANTS.BUTTON_Y_OFFSET,
            color = RenderModule:createColor(204, 49, 61),
            zIndex = 1001
        },

        quitButtonLabel = {
            text = "Quit Game",
            type = "text",
            x = CONSTANTS.MIDDLE_X,
            y = CONSTANTS.NEW_GAME_BUTTON_Y + CONSTANTS.BUTTON_Y_OFFSET,
            color = RenderModule:createColor(255, 255, 255),
            font = love.graphics.newFont(CONSTANTS.STANBERRY_FONT_PATH, 28),
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
            spritePath = CONSTANTS.DEFAULT_BUTTON_PATH,
            type = "sprite",
            x = CONSTANTS.MIDDLE_X,
            y = CONSTANTS.NEW_GAME_BUTTON_Y + CONSTANTS.BUTTON_Y_OFFSET,
            color = RenderModule:createColor(204, 49, 61),
            zIndex = 1001
        },

        backToMenuButtonLabel = {
            text = "Back",
            type = "text",
            x = CONSTANTS.MIDDLE_X,
            y = CONSTANTS.NEW_GAME_BUTTON_Y + CONSTANTS.BUTTON_Y_OFFSET,
            color = RenderModule:createColor(255, 255, 255),
            font = love.graphics.newFont(CONSTANTS.STANBERRY_FONT_PATH, 28),
            zIndex = 1002
        },

        templateSaveFileBackground = {
            spritePath = CONSTANTS.DEFAULT_BUTTON_PATH,
            type = "sprite",
            x = CONSTANTS.MIDDLE_X,
            y = CONSTANTS.NEW_GAME_BUTTON_Y / CONSTANTS.TEMPLATE_SAVE_FILE_Y_DIVIDER,
            rotation = CONSTANTS.TEMPLATE_ROTATION,
            scaleX = CONSTANTS.TEMPLATE_SCALE_X,
            scaleY = CONSTANTS.TEMPLATE_SCALE_Y,
            color = RenderModule:createColor(42, 42, 42, 0.8),
            zIndex = 1001
        },

        templateSaveFileLabel = {
            text = "Slot ",
            type = "text",
            x = CONSTANTS.MIDDLE_X,
            y = CONSTANTS.NEW_GAME_BUTTON_Y - CONSTANTS.TEMPLATE_SAVE_FILE_SLOT_OFFSET,
            color = RenderModule:createColor(255, 255, 255),
            font = love.graphics.newFont(CONSTANTS.STANBERRY_FONT_PATH, 28),
            zIndex = 1002
        },

        templateSaveFileLoadButtonHitbox = {
            spritePath = CONSTANTS.DEFAULT_BUTTON_PATH,
            type = "sprite",
            x = CONSTANTS.MIDDLE_X,
            y = CONSTANTS.NEW_GAME_BUTTON_Y - CONSTANTS.TEMPLATE_LOAD_BUTTON_OFFSET,
            scaleX = CONSTANTS.TEMPLATE_SMALL_SCALE,
            scaleY = CONSTANTS.TEMPLATE_SMALL_SCALE,
            color = RenderModule:createColor(151, 188, 98),
            zIndex = 1002
        },

        templateSaveFileLoadButtonLabel = {
            text = "Load File",
            type = "text",
            x = CONSTANTS.MIDDLE_X,
            y = CONSTANTS.NEW_GAME_BUTTON_Y - CONSTANTS.TEMPLATE_LOAD_BUTTON_OFFSET,
            scaleX = CONSTANTS.TEMPLATE_SMALL_SCALE,
            scaleY = CONSTANTS.TEMPLATE_SMALL_SCALE,
            color = RenderModule:createColor(255, 255, 255),
            font = love.graphics.newFont(CONSTANTS.STANBERRY_FONT_PATH, 28),
            zIndex = 1003
        },

        templateSaveFileResetButtonHitbox = {
            spritePath = CONSTANTS.DEFAULT_BUTTON_PATH,
            type = "sprite",
            x = CONSTANTS.MIDDLE_X,
            y = CONSTANTS.NEW_GAME_BUTTON_Y - CONSTANTS.TEMPLATE_RESET_BUTTON_OFFSET,
            scaleX = CONSTANTS.TEMPLATE_SMALL_SCALE,
            scaleY = CONSTANTS.TEMPLATE_SMALL_SCALE,
            color = RenderModule:createColor(204, 49, 61),
            zIndex = 1002
        },

        templateSaveFileResetButtonLabel = {
            text = "Reset File",
            type = "text",
            x = CONSTANTS.MIDDLE_X,
            y = CONSTANTS.NEW_GAME_BUTTON_Y - CONSTANTS.TEMPLATE_RESET_BUTTON_OFFSET,
            scaleX = CONSTANTS.TEMPLATE_SMALL_SCALE,
            scaleY = CONSTANTS.TEMPLATE_SMALL_SCALE,
            color = RenderModule:createColor(255, 255, 255),
            font = love.graphics.newFont(CONSTANTS.STANBERRY_FONT_PATH, 28),
            zIndex = 1003
        },

        templateSaveFileBoxPreview = {
            x = CONSTANTS.MIDDLE_X,
            y = CONSTANTS.NEW_GAME_BUTTON_Y / CONSTANTS.TEMPLATE_SAVE_FILE_Y_DIVIDER - 25,
            scaleX = 1,
            scaleY = 1,
            zIndex = 1004
        },

        templateSaveFilePlusIcon = {
            spritePath = "assets/sprites/ui/buttonplus100x100.png",
            type = "sprite",

            x = CONSTANTS.MIDDLE_X,
            y = CONSTANTS.NEW_GAME_BUTTON_Y / CONSTANTS.TEMPLATE_SAVE_FILE_Y_DIVIDER - 25,
            scaleX = 1,
            scaleY = 1,
            zIndex = 1004
        },

        templateSaveHighestTier = {
            text = "Highest Tier: 1",
            type = "text",
            x = CONSTANTS.MIDDLE_X,
            y = CONSTANTS.NEW_GAME_BUTTON_Y - CONSTANTS.TEMPLATE_SAVE_FILE_SLOT_OFFSET + 40,
            color = RenderModule:createColor(255, 255, 255),
            font = love.graphics.newFont(CONSTANTS.STANBERRY_FONT_PATH, 20),
            zIndex = 1002
        },

        templateSavePlaytime = {
            text = "0:00:00",
            type = "text",
            x = CONSTANTS.MIDDLE_X,
            y = CONSTANTS.NEW_GAME_BUTTON_Y - CONSTANTS.TEMPLATE_SAVE_FILE_SLOT_OFFSET + 65,
            color = RenderModule:createColor(255, 255, 255),
            font = love.graphics.newFont(CONSTANTS.STANBERRY_FONT_PATH, 22),
            zIndex = 1002
        }
    },
    shared = {
        settingsButtonHitbox = {
            spritePath = "assets/sprites/ui/buttoncog74x74.png",
            type = "sprite",

            x = CONSTANTS.SETTINGS_BUTTON_X,
            y = CONSTANTS.SETTINGS_BUTTON_OFFSET,

            scaleX = .6,
            scaleY = .6,

            color = RenderModule:createColor(117, 124, 136),
            zIndex = 1004
        }
    }
}