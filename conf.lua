_G.WINDOW_WIDTH = 800
_G.WINDOW_HEIGHT = 600

_G.MIN_WINDOW_WIDTH = 400
_G.MIN_WINDOW_HEIGHT = 300

function love.conf(config)
    config.window.width = _G.WINDOW_WIDTH
    config.window.height = _G.WINDOW_HEIGHT

    config.window.minwidth = _G.MIN_WINDOW_WIDTH
    config.window.minheight = _G.MIN_WINDOW_HEIGHT

    config.window.icon = "assets/sprites/gerald.png"
    config.window.title = "Incremental Game"

    config.window.fullscreentype = "desktop"

    config.window.resizable = true
    config.console = true

    config.window.vsync = 0
end