-- ~/code/game/ui/scenes/game.lua

local UIButtonObjectModule = require("code.game.ui.objects.button")
local BoxFactoryModule = require("code.game.box.factory")

local RenderModule = require("code.engine.render")

local ScenesData = require("code.data.scenes")
local SceneData = ScenesData.game

local Module = {}
Module._elements = {}
Module._buttons = {}

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

local function setupBackgrounds(self)
    local playAreaBackground = RenderModule:createElement(SceneData.playAreaBackground)
    local sidebarBackground = RenderModule:createElement(SceneData.sidebarBackground)

    table.insert(self._elements, playAreaBackground)
    table.insert(self._elements, sidebarBackground)
end

local function setupSpawnButton(self)
    local spawnButtonHitbox = RenderModule:createElement(SceneData.spawnButtonHitbox)
    local spawnButtonCostLabel = RenderModule:createElement(SceneData.spawnButtonCostLabel)
    local spawnButtonLabel = RenderModule:createElement(SceneData.spawnButtonLabel)

    table.insert(self._elements, spawnButtonHitbox)
    table.insert(self._elements, spawnButtonCostLabel)
    table.insert(self._elements, spawnButtonLabel)

    local spawnButton = UIButtonObjectModule:createButton({
        elements = {
            spawnButtonHitbox,
            spawnButtonCostLabel,
            spawnButtonLabel
        },

        hitboxElement = spawnButtonHitbox,

        mouseButton = 1,
        onClick = function()
            BoxFactoryModule:spawn()
        end
    })

    table.insert(self._buttons, spawnButton)
end

function Module:init()
    setupBackgrounds(self)
    setupSpawnButton(self)
end

return Module