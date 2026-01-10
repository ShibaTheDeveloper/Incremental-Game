-- ~/code/game/ui/scenes/saveFiles.lua

local ScreenTransitionModule = require("code.game.vfx.screenTransition")

local BoxesObjectModule = require("code.game.box.object")

local UIButtonObjectModule = require("code.game.ui.objects.button")
local UISceneHandlerModule = require("code.game.ui.sceneHandler")

local SaveFilesModule = require("code.engine.saveFiles")
local RenderModule = require("code.engine.render")
local extra = require("code.engine.extra")

local ScenesData = require("code.data.scenes")

local Module = {}
Module._resetButtons = {}
Module._elements = {}
Module._buttons = {}
Module.name = "saveFiles"

local SceneData = ScenesData[Module.name]

local RESET_BUTTON_WARN_TIME_OUT = .5

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

local function setupSavePlaytime(self, backgroundElement, save)
    local templateSavePlaytime = RenderModule:createElement(SceneData.templateSavePlaytime)
    templateSavePlaytime.text = extra.formatTime(save.playtime)
    templateSavePlaytime.x = backgroundElement.x

    table.insert(self._elements, templateSavePlaytime)
end

local function setupSaveHighestTier(self, backgroundElement, save)
    local templateSaveHighestTier = RenderModule:createElement(SceneData.templateSaveHighestTier)
    templateSaveHighestTier.text = "Highest Tier: " .. save.highestBoxTier
    templateSaveHighestTier.x = backgroundElement.x

    table.insert(self._elements, templateSaveHighestTier)
end

local function setupSaveFileBoxPreview(self, backgroundElement, save)
    local data = BoxesObjectModule:getBoxDataByTier(save.highestBoxTier)
    local templateSaveFileBoxPreview = BoxesObjectModule:createBoxElement(data)

    if templateSaveFileBoxPreview then
        templateSaveFileBoxPreview.x = backgroundElement.x
        templateSaveFileBoxPreview.y = SceneData.templateSaveFileBoxPreview.y

        templateSaveFileBoxPreview.scaleX = SceneData.templateSaveFileBoxPreview.scaleX
        templateSaveFileBoxPreview.scaleY = SceneData.templateSaveFileBoxPreview.scaleY

        templateSaveFileBoxPreview.zIndex = SceneData.templateSaveFileBoxPreview.zIndex
    end

    table.insert(self._elements, templateSaveFileBoxPreview)
end

local function setupSaveFileLoadButton(self, backgroundElement, save)
    local saveFileLoadButtonHitbox = RenderModule:createElement(SceneData.templateSaveFileLoadButtonHitbox)
    local saveFileLoadButtonLabel = RenderModule:createElement(SceneData.templateSaveFileLoadButtonLabel)

    table.insert(self._elements, saveFileLoadButtonHitbox)
    table.insert(self._elements, saveFileLoadButtonLabel)

    saveFileLoadButtonHitbox.x = backgroundElement.x
    saveFileLoadButtonLabel.x = backgroundElement.x

    local saveFileLoadButton = UIButtonObjectModule:createButton({
        elements = {
            saveFileLoadButtonHitbox,
            saveFileLoadButtonLabel
        },

        hitboxElement = saveFileLoadButtonHitbox,

        mouseButton = 1,
        onClick = function()
            ScreenTransitionModule:transition({
                callback = function()
                    SaveFilesModule.loadFile(save.slot)
                    UISceneHandlerModule:switch("game")
                end
            })
        end
    })

    table.insert(self._buttons, saveFileLoadButton)
end

local function setupSaveFileResetButton(self, backgroundElement, save)
    local saveFileResetButtonHitbox = RenderModule:createElement(SceneData.templateSaveFileResetButtonHitbox)
    local saveFileResetButtonLabel = RenderModule:createElement(SceneData.templateSaveFileResetButtonLabel)

    table.insert(self._elements, saveFileResetButtonHitbox)
    table.insert(self._elements, saveFileResetButtonLabel)

    saveFileResetButtonHitbox.x = backgroundElement.x
    saveFileResetButtonLabel.x = backgroundElement.x

    local saveFileResetButton
    saveFileResetButton = UIButtonObjectModule:createButton({
        elements = {
            saveFileResetButtonHitbox,
            saveFileResetButtonLabel
        },

        hitboxElement = saveFileResetButtonHitbox,

        cooldown = 0,

        mouseButton = 1,
        onClick = function()
            ---@diagnostic disable-next-line: need-check-nil
            if saveFileResetButton.deleting then return end

            ---@diagnostic disable-next-line: need-check-nil
            if (os.clock() - saveFileResetButton.lastConfirm) >= RESET_BUTTON_WARN_TIME_OUT then
                saveFileResetButtonLabel.text = "Are you sure?"
                saveFileResetButton.lastConfirm = os.clock()

                return
            else
                saveFileResetButton.deleting = true
                saveFileResetButtonLabel.text = "Bye bye!"

                ScreenTransitionModule:transition({
                    callback = function()
                        SaveFilesModule.deleteFile(save.slot)
                        UISceneHandlerModule:switch("saveFiles")
                    end,

                    duration = 1.2
                })
            end
        end
    })

    saveFileResetButton.lastConfirm = -math.huge
    saveFileResetButton.deleting = false

    table.insert(self._resetButtons, saveFileResetButton)
    table.insert(self._buttons, saveFileResetButton)
end

local function setupSaveFileButtons(self, backgroundElement, save)
    setupSaveFileResetButton(self, backgroundElement, save)
    setupSaveFileLoadButton(self, backgroundElement, save)
end

local function setupSaveFileBackgrounds(self)
    local saves = SaveFilesModule.getAllSaveFiles()

    if #saves == 0 then return end

    local firstHitbox = RenderModule:createElement(SceneData.templateSaveFileBackground)
    local buttonWidth = firstHitbox.drawable:getWidth()
    firstHitbox:remove()

    local totalWidth = (#saves * buttonWidth) + ((#saves - 1))
    local startX = (_G.WINDOW_WIDTH - totalWidth) / 2

    for index, save in ipairs(saves) do
        local templateSaveFileBackground = RenderModule:createElement(SceneData.templateSaveFileBackground)
        local templateSaveFileLabel = RenderModule:createElement(SceneData.templateSaveFileLabel)

        local x = startX + (buttonWidth / 2) + ((index - 1) * (buttonWidth))

        templateSaveFileBackground.x = x
        templateSaveFileLabel.x = x

        templateSaveFileLabel.text = "Slot " .. tostring(save.slot)

        table.insert(self._elements, templateSaveFileBackground)
        table.insert(self._elements, templateSaveFileLabel)

        if save.created then
            setupSaveFileButtons(self, templateSaveFileBackground, save)

            setupSaveFileBoxPreview(self, templateSaveFileBackground, save)
            setupSaveHighestTier(self, templateSaveFileBackground, save)
            setupSavePlaytime(self, templateSaveFileBackground, save)
        else
            local templateSaveFilePlusIcon = RenderModule:createElement(SceneData.templateSaveFilePlusIcon)
            templateSaveFilePlusIcon.x = x

            table.insert(self._elements, templateSaveFilePlusIcon)

            local createSaveFileButton = UIButtonObjectModule:createButton({
                elements = {
                    templateSaveFileBackground,
                    templateSaveFilePlusIcon
                },

                hitboxElement = templateSaveFileBackground,

                mouseButton = 1,
                onClick = function()
                    ScreenTransitionModule:transition({
                        callback = function()
                            SaveFilesModule.createFile(save.slot)
                            UISceneHandlerModule:switch("saveFiles")
                        end,

                        duration = 1.2
                    })
                end
            })

            table.insert(self._buttons, createSaveFileButton)
        end
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
            ScreenTransitionModule:transition({
                callback = function()
                    UISceneHandlerModule:switch("mainMenu")
                end
            })
        end
    })

    table.insert(self._buttons, backToMenuButton)
end

function Module:update()
    for _, button in pairs(self._resetButtons) do
        if (os.clock() - button.lastConfirm) < RESET_BUTTON_WARN_TIME_OUT then goto continue end
        if button.deleting then goto continue end

        button.elements[1].text = SceneData.templateSaveFileResetButtonLabel.text
        button.elements[2].text = SceneData.templateSaveFileResetButtonLabel.text

        :: continue ::
    end
end

function Module:init()
    setupSaveFileBackgrounds(self)
    setupBackToMenuButton(self)
    setupBackground(self)
end

return Module