local knockedOut = false
local wait = 20
local count = 60
local first = true
local time = 10
local timer = 60 * 20

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

AddEventHandler('esx:onPlayerDeath', function(data)
	first = true
end)

RegisterNetEvent('esx_ambulancejob:heal')
AddEventHandler('esx_ambulancejob:heal', function(healType, quiet)
	first = true
end)

Citizen.CreateThread(function()
    while true do
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_UNARMED"), 0.5) 
		Wait(0)
    end
end)

AddEventHandler('knockout:timer', function()
    while (time ~= 0) do
        Wait(1000)
		time = time - 1
	end
	first = true
end)

Citizen.CreateThread(function()
	while true do
		Wait(1)
		local myPed = GetPlayerPed(-1)
		if IsPedInMeleeCombat(myPed) then
			time = timer
			if GetEntityHealth(myPed) < 115 and first then
				SetPlayerInvincible(PlayerId(), true)
				SetPedToRagdoll(myPed, 1000, 1000, 0, 0, 0, 0)
				ESX.ShowNotification("Du bist Bewusstlos")
				wait = 20
				knockedOut = true
				first = false
			end
		elseif not first then
			time = timer
			TriggerEvent('knockout:timer')
		end
		if knockedOut == true then
			SetPlayerInvincible(PlayerId(), true)
			DisablePlayerFiring(PlayerId(), true)
			SetPedToRagdoll(myPed, 1000, 1000, 0, 0, 0, 0)
			ResetPedRagdollTimer(myPed)
			
			if wait >= 0 then
				count = count - 1
				if count == 0 then
					count = 60
					wait = wait - 1
					SetEntityHealth(myPed, GetEntityHealth(myPed) + 1)
				end
			else
				SetPlayerInvincible(PlayerId(), false)
				knockedOut = false
			end
		end
	end
end)