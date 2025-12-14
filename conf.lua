_G.windowWidth = 800
_G.windowHeight = 600

_G.minWindowWidth = 400
_G.minWindowHeight = 300

function love.conf(config)
    config.window.width = _G.windowWidth
    config.window.height = _G.windowHeight

    config.window.minwidth = _G.minWindowWidth
    config.window.minheight = _G.minWindowHeight

    config.window.icon = "assets/sprites/wooden_pickaxe.png"
    config.window.title = "Incremental Game"

    config.window.fullscreentype = "desktop"

    config.window.resizable = true
    config.console = true

    config.window.vsync = 0
end