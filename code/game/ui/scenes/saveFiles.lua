-- ~/code/game/ui/scenes/saveFiles.lua

local UIButtonObjectModule = require("code.game.ui.objects.button")
local UISceneHandlerModule = require("code.game.ui.sceneHandler")

local SaveFilesModule = require("code.engine.saveFiles")
local RenderModule = require("code.engine.render")

local ScenesData = require("code.data.scenes")

local Module = {}
Module._elements = {}
Module._buttons = {}
Module.name = "saveFiles"

local SceneData = ScenesData[Module.name]

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

local function setupBackground(self)
    local background = RenderModule:createElement(SceneData.background)
    table.insert(self._elements, background)
end

local function setupSaveFileButtons(self)
    local saves = SaveFilesModule.getAllSaveFiles()

    for index, save in pairs(saves) do
        local saveFileButtonHitbox = RenderModule:createElement(SceneData.templateSaveFileButtonHitbox)
        local saveFileButtonLabel = RenderModule:createElement(SceneData.templateSaveFileButtonLabel)

        table.insert(self._elements, saveFileButtonHitbox)
        table.insert(self._elements, saveFileButtonLabel)

        local CalculationX = saveFileButtonHitbox.x * (index / 2)
        saveFileButtonHitbox.x = CalculationX
        saveFileButtonLabel.x = CalculationX

        saveFileButtonLabel.text = "Slot " .. tostring(save.slot)

        local saveFileButton = UIButtonObjectModule:createButton({
            elements = {
                saveFileButtonHitbox,
                saveFileButtonLabel
            },

            hitboxElement = saveFileButtonHitbox,

            mouseButton = 1,
            onClick = function()
                UISceneHandlerModule:switch("game")
                SaveFilesModule.loadFile(save.slot)
            end
        })

        table.insert(self._buttons, saveFileButton)
    end
end

local function setupBackToMenuButton(self)
    local backToMenuButtonHitbox = RenderModule:createElement(SceneData.backToMenuButtonHitbox)
    local backToMenuButtonLabel = RenderModule:createElement(SceneData.backToMenuButtonLabel)

    table.insert(self._elements, backToMenuButtonHitbox)
    table.insert(self._elements, backToMenuButtonLabel)

    local backToMenuButton = UIButtonObjectModule:createButton({
        elements = {
            backToMenuButtonHitbox,
            backToMenuButtonLabel
        },

        hitboxElement = backToMenuButtonHitbox,

        mouseButton = 1,
        onClick = function()
            UISceneHandlerModule:switch("mainMenu")
        end
    })

    table.insert(self._buttons, backToMenuButton)
end

function Module:init()
    setupBackToMenuButton(self)
    setupSaveFileButtons(self)
    setupBackground(self)
end

return Module