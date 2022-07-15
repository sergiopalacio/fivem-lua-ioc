_G.Definition = {}

DefinitionMethods = {}

-- init
DefinitionMethods.__call = function(self, object, args)
    local o = setmetatable({}, {
        __index = self
    })

    o.Object = object
    o.args = args or {}
    o.shared = true
    o.factory = nil
    return o
end

-- methods
DefinitionMethods.__index = {
    addArgument = function(self, type, argument)
        table.insert(self.args, argument)
        return self
    end,
    setFactory = function(self, Object, method)
        self.factory = {
            Object = Object,
            method = method
        }
        return self
    end
}

-- class
setmetatable(Definition, DefinitionMethods)
