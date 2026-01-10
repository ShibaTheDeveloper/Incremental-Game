-- ~/code/engine/sound.lua

local IdManagerModule = require("code.engine.idManager")
local SaveFilesModule = require("code.engine.saveFiles")

local manager = IdManagerModule:createManager()

local Sound = {
    id = 0,

    type = "",
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

function Sound:play(randomizePitch, min, max, divisor)
    local defaultPitch = self.pitch

    if randomizePitch then
        divisor = divisor or 1000
        min = min or -100
        max = max or 100

        self.pitch = defaultPitch + math.random(min, max) / divisor
    end

    self.source:stop()
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

    local sourceType = ((data.type or "sound") == "sound" and "static" or "stream")
    local source = love.audio.newSource(data.soundPath, sourceType)

    local sound = setmetatable({
        id = manager:get(),

        type = data.type or "sound",
        soundPath = data.soundPath,

        source = source,

        loop = data.loop or false,

        volume = data.volume or 1,
        pitch = data.pitch or 1
    }, Sound)
    self._sounds[sound.id] = sound

    source:setVolume(sound.volume)

    return sound
end

function Module:update()
    for _, sound in pairs(self._sounds) do
        if not sound.source:isPlaying() then goto continue end

        local baseVolumeMulti = (sound.type == "sound" and SaveFilesModule.settingsFile.soundVolume or SaveFilesModule.settingsFile.trackVolume)
        sound.source:setVolume(sound.volume * (baseVolumeMulti * SaveFilesModule.settingsFile.masterVolume))

        sound.source:setLooping(sound.loop)
        sound.source:setPitch(sound.pitch)

        :: continue ::
    end
end

return Module