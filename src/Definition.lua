--Copyright 2022 Sergio Palacio Ródenas
--
--Licensed under the Apache License, Version 2.0 (the "License");
--you may not use this file except in compliance with the License.
--You may obtain a copy of the License at
--
--http://www.apache.org/licenses/LICENSE-2.0
--
--Unless required by applicable law or agreed to in writing, software
--distributed under the License is distributed on an "AS IS" BASIS,
--WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
--See the License for the specific language governing permissions and
--limitations under the License.
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
