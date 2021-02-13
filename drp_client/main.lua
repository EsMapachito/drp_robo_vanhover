local robtime = 300 -- En 5 minutos está
local timerCount = robtime
local isRobbing = false
local timers = false


function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str)
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
	SetTextCentre(centre)
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
	Citizen.InvokeNative(0xADA9255D, 1);
    DisplayText(str, x, y)
end

--Robbery startpoint
Citizen.CreateThread(function()
    while true do
	Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local betweencoords = GetDistanceBetweenCoords(coords, 3022.6, 558.59, 44.78, true)
		if betweencoords < 2.0 then
			DrawTxt(Config.rob, 0.50, 0.90, 0.7, 0.7, true, 255, 255, 255, 255, true)
			if IsControlJustReleased(0, 0xC7B5340A) then		
			TriggerServerEvent("drp_def_puerto:startToRob", function() -- Coges la ganzúa
			isRobbing = true
			end)	
			end
		end
	end
end)

RegisterNetEvent('drp_def_puerto:startAnimation')
AddEventHandler('drp_def_puerto:startAnimation', function()	
    local playerPed = PlayerPedId()
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_CROUCH_INSPECT'), 35000, true, false, false, false)
    exports['progressBars']:startUI(35000, "Abriendo la caja fuerte...")
    Citizen.Wait(35000)
	ClearPedTasksImmediately(PlayerPedId())
	ClearPedSecondaryTask(PlayerPedId())
	Citizen.Wait(1000)
	TriggerEvent("drp_def_puerto:startTheEvent", function()
	end)
end)

--Startingthetimerandrob
RegisterNetEvent("drp_def_puerto:startTimer")
AddEventHandler("drp_def_puerto:startTimer",function()
	timers = true
	TriggerEvent("drp_def_puerto:startTimers")
		while timers do
		Citizen.Wait(0)
		DrawTxt("Las campanas están sonando. Ponte a cubierto. "..timerCount.." segundos", 0.50, 0.52, 0.7, 0.7, true, 255, 255, 255, 255, true)
		local playerPed = PlayerPedId()
		local playerdead = IsPlayerDead(playerped)
		if playerdead then
			timers = false
		end
		local coords = GetEntityCoords(playerPed)
		local betweencoords = GetDistanceBetweenCoords(coords, 3022.6, 558.59, 44.78, true)
		if betweencoords > 70.0 then
			timers = false
		end
		if timerCount == 0 then
			Citizen.Wait(1000)
			TriggerServerEvent("drp_def_puerto:payout", function()
		end)
		end
	end
end)

AddEventHandler("drp_def_puerto:startTimers",function()
Citizen.CreateThread(function()
    while timers do
    
	Citizen.Wait(1000)
    if timerCount >= 0 then
        timerCount = timerCount - 1
	else
		timers = false
    end
	end
end)
end)

function DrawText(text,x,y)
    SetTextScale(0.35,0.35)
    SetTextColor(255,255,255,255)--r,g,b,a
    SetTextCentre(true)
    SetTextDropshadow(1,0,0,0,200)
    SetTextFontForCurrentCommand(0)
    DisplayText(CreateVarString(10, "LITERAL_STRING", text), x, y)s
end

RegisterNetEvent("drp_def_puerto:startTheEvent") -- Viniendo NPC (configuración en el config)
AddEventHandler("drp_def_puerto:startTheEvent",function(num,typey)
    while not HasModelLoaded( GetHashKey("s_m_m_valdeputy_01") ) do
        Wait(500)
        RequestModel( GetHashKey("s_m_m_valdeputy_01") )
    end
	local playerPed = PlayerPedId()
	AddRelationshipGroup('NPC')
	AddRelationshipGroup('PlayerPed')
	for k,v in pairs(Config.npcspawn) do
		pedy = CreatePed(GetHashKey("s_m_m_valdeputy_01"),v.x,v.y,v.z,0, true, false, 0, 0)
		SetPedRelationshipGroupHash(pedy, 'NPC')
        GiveWeaponToPed_2(pedy, 0x64356159, 500, true, 1, false, 0.0)
		Citizen.InvokeNative(0x283978A15512B2FE, pedy, true)
		Citizen.InvokeNative(0xF166E48407BAC484, pedy, PlayerPedId(), 0, 0)
		FreezeEntityPosition(pedy, false)
		TaskCombatPed(pedy,playerped, 0, 16)
	end
end)


