# Fivem Lua IOC
An opinionated IOC container written in LUA and exported as a FiveM Script.
## Description
This is one implementation of an IOC container written a while ago to be able to handle dependency injection
on large FiveM OOP scripts.
## Getting started
To use the script, clone / download the repository into your resources folder

### Importing the script

````lua
client_scripts {
    ...,
    '@fivem-ioc/src/ContainerBuilder.lua',
    '@fivem-ioc/src/Definition.lua',
    '@fivem-ioc/src/InstanceManager.lua',
    ...,
}

server_scripts {
    ...,
    '@fivem-ioc/src/ContainerBuilder.lua',
    '@fivem-ioc/src/Definition.lua',
    '@fivem-ioc/src/InstanceManager.lua',
    ...,
}
````

### Consuming the script

#### Basic Register
````lua
ClientContainer = ContainerBuilder()
ClientContainer:register('DummyService', DummyService)
````

#### Add arguments by definition reference
````lua
ClientContainer = ContainerBuilder()
ClientContainer:register('DummyService', DummyService)
ClientContainer:register('DummyModule', Dummy):addArgument('Reference', 'DummyService')
````

#### Register a factory

````lua
ClientContainer = ContainerBuilder()
local definition = Definition()
definition:setFactory(DummyFactory, 'foo')

ClientContainer:setDefinition('DummyDefinition', definition)
````
