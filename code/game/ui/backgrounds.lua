-- ~/code/game/ui/backgrounds.lua

local RenderModule = require("code.engine.render")
local BOX_CONSTANTS = require("code.game.box.constants")

return function()
    RenderModule:createElement({
        spritePath = "assets/sprites/backgrounds/areabg.png",
        type = "sprite",

        anchorX = 0,
        anchorY = 0
    })

    RenderModule:createElement({
        spritePath = "assets/sprites/backgrounds/sidebar.png",
        type = "sprite",

        anchorX = 0,
        anchorY = 0,

        x = BOX_CONSTANTS.AREA_WIDTH,
        zIndex = 999
    })
end