-- ~/code/game/musicHandler.lua

local SoundModule = require("code.engine.sound")
local extra = require("code.engine.extra")

local TrackData = require("code.data.tracks")

local Module = {}
Module.playingTrack = nil
Module.loadedTracks = {}

function Module.init()
    for index, track in pairs(TrackData) do
        local data = extra.cloneTable(track)

        local soundObject = SoundModule:createSound({
            soundPath = data.trackPath,
            volume = data.volume,

            type = "track",
            loop = true
        })

        data.soundObject = soundObject
        Module.loadedTracks[index] = data
    end
end

function Module:playTrack(name)
    if name == self.playingTrack then return end

    local track = self.loadedTracks[name]
    if not track then return end

    if self.playingTrack then
        self:stopTrack(self.playingTrack)
    end

    track.soundObject:play()

    self.playingTrack = name
end

function Module:pauseTrack(name)
    local track = self.loadedTracks[name]
    if not track then return end

    track.soundObject:pause()
end

function Module:stopTrack(name)
    local track = self.loadedTracks[name]
    if not track then return end

    track.soundObject:stop()
    self.playingTrack = nil
end

function Module:getLoadedTracks()
    return self.loadedTracks
end

return Module