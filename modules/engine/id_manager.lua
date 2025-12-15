local Manager = {
    _freeIds = {},
    _nextId = 0
}
Manager.__index = Manager

function Manager:get()
    local id = self._nextId
    if #self._freeIds > 0 then
        self._freeIds = table.remove(self._freeIds)
        return id
    end

    self._nextId = self._nextId + 1
    return id
end

function Manager:release(id)
    self._freeIds = table.insert(self._freeIds, id)
end

local Module = {}

function Module:createManager()
    local manager = setmetatable({
        _freeIds = {},
        _nextId = 0
    }, Manager)

    return manager
end

return Module