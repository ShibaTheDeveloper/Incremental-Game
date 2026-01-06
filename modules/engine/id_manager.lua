local Manager = {
    _freeIds = {},
    _nextId = 0
}
Manager.__index = Manager

function Manager:get()
    if #self._freeIds > 0 then
        return table.remove(self._freeIds)
    end

    local id = self._nextId
    self._nextId = self._nextId + 1
    return id
end

function Manager:release(id)
    table.insert(self._freeIds, id)
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