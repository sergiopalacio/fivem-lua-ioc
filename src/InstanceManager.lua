_G.InstanceManager = {}

InstanceManagerMethods = {}

-- constructor
InstanceManagerMethods.__call = function(self, containerBuilder, definitions, alias)
    local o = setmetatable({}, {
        __index = self
    })

    o._containerBuilder = containerBuilder
    o._definitions = definitions
    o._alias = alias
    return o
end

-- methods
InstanceManagerMethods.__index = {
    getInstance = function(self, id)
        id = self._alias[id] ~= nil and self._alias[id] or id

        if self._definitions[id] then
            return self:_getInstanceFromId(id)
        end
    end,
    _getInstanceFromId = function(self, id)
        local definition = self._definitions[id]
        if definition.Object ~= nil or definition.factory then
            return self:_getExistingInstanceFromId(id)
        else
            print('No definition object/factory found')
        end
    end,
    _getExistingInstanceFromId = function(self, id)
        local definition = self._definitions[id]
        print(json.encode(definition.args))
        if definition.shared == false then
            return self:getInstanceFromDefinition(definition)
        end

        if self._containerBuilder.services[id] then
            return self._containerBuilder.services[id]
        end

        local instance = self:getInstanceFromDefinition(definition)
        self._containerBuilder.services[id] = instance
        return instance
    end,
    getInstanceFromDefinition = function(self, definition)
        if definition.factory then
            return self:_getInstanceFromFactory(definition)
        end

        return self:_getNotSyntheticInstanceFromDefinition(definition)
    end,
    _getInstanceFromFactory = function(self, definition)
        local args = self:_resolveArguments(definition.args)

        if definition.factory.Object ~= nil then
            return definition.factory.Object[definition.factory.method](table.unpack(args))
        end
    end,
    _getNotSyntheticInstanceFromDefinition = function(self, definition)
        local args = self:_resolveArguments(definition.args)
        return definition.Object(table.unpack(args))
    end,
    _resolveArguments = function(self, args)
        if not args then
            args = {}
        end

        local resolvedArgument = {}

        for _, arg in pairs(args) do
            local services = self:_resolveServices('Reference', arg)
            print('services', json.encode(services))
            if services ~= nil then
                table.insert(resolvedArgument, services)
            end
        end

        return resolvedArgument
    end,
    _resolveServices = function(self, type, argumentValue)
        if type == 'Reference' then
            if self._containerBuilder:hasDefinition(argumentValue) then
                return self:getInstance(argumentValue)
            end
        else
            return argumentValue
        end
    end
}

setmetatable(InstanceManager, InstanceManagerMethods)
