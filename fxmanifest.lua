fx_version 'bodacious'
game 'gta5'

author 'FiveM Server Owners Co-Op'
description 'Essentials Core'
version '1.0.0'

client_scripts {
    'config.lua',

    'client/lib/entityiter.lua',
    'client/coreThread.lua',
    'client/drawThread.lua',
    'client/npcThread.lua',
}

server_scripts {
    'config.lua',
    'server/eventHandler.lua',
}

