fx_version 'bodacious'
game 'gta5'
description 'Fivem dependency inversion'

version '1.0.0'

shared_scripts {
   'src/ContainerBuilder.lua',
   'src/Definition.lua',
   'src/InstanceManager.lua',
}

exports {
    'ContainerBuilder',
    'Definition'
}

server_exports {
    'ContainerBuilder',
    'Definition'
}
