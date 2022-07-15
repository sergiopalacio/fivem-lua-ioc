_G.ContainerBuilder = {}

ContainerBuilderMethods = {}

ContainerBuilderMethods.__call = function(self)
    local o = setmetatable({}, {
        __index = self
    })
    o._definitions = {}
    o._alias = {}
    o.services = {}
    o._instanceManager = nil
    return o
end

ContainerBuilderMethods.__index = {
    hasDefinition = function(self, id)
        return self._definitions[id] ~= nil
    end,
    instanceManager = function(self)
        if not self._instanceManager then
            self._instanceManager = InstanceManager(self, self._definitions, self._alias)
        end
        return self._instanceManager
    end,
    get = function(self, id)
        return self:instanceManager():getInstance(id)
    end,
    register = function(self, id, module, args)
        local moduleDefinition = Definition(module, args)
        return self:__setDefinition(id, moduleDefinition)
    end,
    setDefinition = function(self,id, definition)
        self._definitions[id] = definition
    end,
    __setDefinition = function(self, id, definition)
        self._definitions[id] = definition
        return definition
    end
}

setmetatable(ContainerBuilder, ContainerBuilderMethods)
