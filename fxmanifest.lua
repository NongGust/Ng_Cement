fx_version 'adamant'

game 'gta5'

description 'Ng_Cement'

version '1.1'

files {
	'html/main.html',
	'html/main.mp3',
	'html/police.mp3',
}

ui_page {
	'html/main.html',
}

server_script {
    '@es_extended/locale.lua',
    'locales/th.lua',
    'config.lua',
    'config_discord.lua',
    'server/main.lua'
}

client_script {
    '@es_extended/locale.lua',
    'locales/th.lua',
    'config.lua',
    'client/function.lua',
    'client/main.lua'
}