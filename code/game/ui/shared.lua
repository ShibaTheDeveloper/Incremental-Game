-- ~/code/game/ui/shared.lua

local ScreenTransitionModule = require("code.game.vfx.screenTransition")

local UIButtonObjectModule = require("code.game.ui.objects.button")
local UISceneHandlerModule = require("code.game.ui.sceneHandler")

local RenderModule = require("code.engine.render")

local UIData = require("code.data.ui")

local Module = {}

function Module:setupSettingsButton(scene)
    if not scene then return end

    local settingsButtonHitbox = RenderModule:createElement(UIData.shared.settingsButtonHitbox)
    table.insert(scene._elements, settingsButtonHitbox)

    local settingsButton = UIButtonObjectModule:createButton({
        elements = {
            settingsButtonHitbox,
        },

        hitboxElement = settingsButtonHitbox,

        mouseButton = 1,
        onClick = function()
            ScreenTransitionModule:transition({
                callback = function()
                    UISceneHandlerModule:switch("settings")
                end
            })
        end
    })

    table.insert(scene._buttons, settingsButton)
end

return Module