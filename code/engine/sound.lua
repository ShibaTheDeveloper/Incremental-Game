-- ~/code/engine/sound.lua

local IdManagerModule = require("code.engine.idManager")
local manager = IdManagerModule:createManager()

local Sound = {
    id = 0,

    soundPath = "",
    source = nil,

    volume = 1,
    pitch = 1
}
Sound.__index = Sound

local Module = {}
Module._sounds = {}

function Sound:pause()
    self.source:pause()
end

function Sound:play(randomisePitch, min, max, divisor)
    local defaultPitch = self.pitch

    if randomisePitch then
        divisor = divisor or 1000
        min = min or -100
        max = max or 100

        self.pitch = defaultPitch + math.random(min, max) / divisor
    end

    self.source:stop()

    self.source:setVolume(self.volume)
    self.source:setPitch(self.pitch)

    self.source:play()
    self.pitch = defaultPitch
end

function Sound:stop()
    self.source:stop()
end

function Sound:remove()
    local id = self.id
    self.source = nil

    Module._sounds[id] = nil
    manager:release(id)
end

function Module:createSound(data)
    if not data.soundPath then return end

    local source = love.audio.newSource(data.soundPath, "static")

    local sound = setmetatable({
        id = manager:get(),

        soundPath = data.soundPath,
        source = source,

        volume = data.volume or 1,
        pitch = data.pitch or 1
    }, Sound)
    self._sounds[sound.id] = sound

    source:setVolume(sound.volume)

    return sound
end

return Module