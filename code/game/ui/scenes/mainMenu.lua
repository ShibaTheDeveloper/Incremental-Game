-- ~/code/game/ui/scenes/mainMenu.lua

local ScreenTransitionModule = require("code.game.vfx.screenTransition")
local MusicHandlerModule = require("code.game.musicHandler")

local UIButtonObjectModule = require("code.game.ui.objects.button")
local UISceneHandlerModule = require("code.game.ui.sceneHandler")

local RenderModule = require("code.engine.render")

local ScenesData = require("code.data.scenes")

local Module = {}
Module._elements = {}
Module._buttons = {}
Module.name = "mainMenu"

local SceneData = ScenesData[Module.name]
local logo = nil

function Module:clean()
    for _, element in pairs(self._elements) do
        element:remove()
    end

    for _, button in pairs(self._buttons) do
        button:remove()
    end

    self._elements = {}
    self._buttons = {}
end

local function setupLogo(self)
    logo = RenderModule:createElement(SceneData.logo)
    table.insert(self._elements, logo)
end

local function setupBackground(self)
    local background = RenderModule:createElement(SceneData.background)
    table.insert(self._elements, background)
end

local function setupPlayGameButton(self)
    local playGameButtonHitbox = RenderModule:createElement(SceneData.playGameButtonHitbox)
    local playGameButtonLabel = RenderModule:createElement(SceneData.playGameButtonLabel)

    table.insert(self._elements, playGameButtonHitbox)
    table.insert(self._elements, playGameButtonLabel)

    local playGameButton = UIButtonObjectModule:createButton({
        elements = {
            playGameButtonHitbox,
            playGameButtonLabel
        },

        hitboxElement = playGameButtonHitbox,

        mouseButton = 1,
        onClick = function()
            ScreenTransitionModule:transition({
                callback = function()
                    UISceneHandlerModule:switch("saveFiles")
                end
            })
        end
    })

    table.insert(self._buttons, playGameButton)
end

local function setupQuitButton(self)
    local quitButtonHitbox = RenderModule:createElement(SceneData.quitButtonHitbox)
    local quitButtonLabel = RenderModule:createElement(SceneData.quitButtonLabel)

    table.insert(self._elements, quitButtonHitbox)
    table.insert(self._elements, quitButtonLabel)

    local quitButton = UIButtonObjectModule:createButton({
        elements = {
            quitButtonHitbox,
            quitButtonLabel
        },

        hitboxElement = quitButtonHitbox,

        mouseButton = 1,
        onClick = function()
            ScreenTransitionModule:transition({
                callback = function()
                    love.event.quit()
                end
            })
        end
    })

    table.insert(self._buttons, quitButton)
end

function Module:update()
    if logo then
        logo:setRotation(math.sin(os.clock()) * 2)
    end
end

function Module:init()
    MusicHandlerModule:playTrack("mainMenu")

    setupPlayGameButton(self)
    setupQuitButton(self)
    setupBackground(self)
    setupLogo(self)
end

return Module