name 'Hades Recoil'
description 'Recoil control script for FiveM'
author 'HadesStudios'
version '1.0.0'

fx_version 'cerulean'
games { 'gta5' }
lua54 'yes'

client_script "@hades-base/components/cl_error.lua"
client_script "@hades-pwnzor/client/check.lua"

client_scripts {
    'client/*.lua'
}

config {
    'shared/config.lua'
}
