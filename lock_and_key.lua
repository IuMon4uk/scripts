script_name('lock_and_key') 
script_author('IuMon4uk') 
script_description('lock and unlock, key and unkey') 

require "lib.moonloader" 
local dlstatus = require('moonloader').download_status
local inicfg = require 'inicfg'
local keys = require "vkeys"
local imgui = require 'imgui'
local encoding = require 'encoding'
encoding.default = 'CP1251'
u8 = encoding.UTF8

update_state = false

local script_vers = 2
local script_vers_text = "1.11"

local update_url = "https://raw.githubusercontent.com/IuMon4uk/scripts/master/update.ini"
local update_path = getWorkingDirectory() .. "/update.ini"

local script_url = "https://github.com/IuMon4uk/scripts/raw/master/lock_and_key.lua"
local script_path = thisScript().path


function main()
    if not isSampLoaded() or not isSampfuncsLoaded() then return end
    while not isSampAvailable() do wait(100) end
         
    sampRegisterChatCommand("update", cmd_update)

	_, id = sampGetPlayerIdByCharHandle(PLAYER_PED)
    nick = sampGetPlayerNickname(id)

    downloadUrlToFile(update_url, update_path, function(id, status)
        if status == dlstatus.STATUS_ENDDOWNLOADDATA then
            updateIni = inicfg.load(nil, update_path)
            if tonumber(updateIni.info.vers) > script_vers then
                sampAddChatMessage("E obnovlenue! Versia: " .. updateIni.info.vers_text,0xDEFF01)
                update_state = true
            end
            os.remove(update_path)
        end
    end)
		 
         while true do
         wait(0)
		 
        if update_state then
            downloadUrlToFile(script_url, script_path, function(id, status)
                if status == dlstatus.STATUS_ENDDOWNLOADDATA then
                    sampAddChatMessage("Script obnovlenuy!", -1)
                    thisScript():reload()
                end
            end)
            break
        end

	end
end

function main()
    if not isSampLoaded() or not isSampfuncsLoaded() then return end
    while not isSampAvailable() do wait(100) end
	
	sampAddChatMessage("[lock and key] Script! by IuMon4uk",0xDEFF01)
	
	while true do
    wait(0)
	if isKeyJustPressed(76) and not sampIsChatInputActive() and not sampIsDialogActive() then 
            sampSendChat("/lock")
		 end
		 if isKeyJustPressed(75) and not sampIsChatInputActive() and not sampIsDialogActive() then 
            sampSendChat("/key")
		end
	end	
end 

function cmd_update(arg)
    sampShowDialog(1000, "Автообновление v2.0", "{FFFFFF}Это урок по обновлению\n{FFF000}Новая версия", "Закрыть", "", 0)
end   


	
	
	
	