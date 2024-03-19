fx_version 'cerulean'
game 'gta5'
version '3.0.0'
description "Simple rent-a-car script"
author 'quantum scripts a.k.a gg-scripts'

lua54 'yes'
shared_scripts { 
    '@ox_lib/init.lua',
    'shared.lua',
    'bridge/framework.lua',
    'locales.lua',
	'locales/*.lua',
 }

client_scripts {
    'bridge/client/*.lua',
    'cl_utils.lua'
}

server_scripts {
    'bridge/server/*.lua',
    'sv_utils.lua'
}

dependencies {
    'ox_lib',
}


