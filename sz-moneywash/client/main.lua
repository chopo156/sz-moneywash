ESX = nil

local PlayerData = {}
local isNear = false
local ped = PlayerPedId()

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)

Citizen.CreateThread(function()
    local location = Config.Wash
    while true do
        Citizen.Wait(4)
        if isNear then
            Draw3DText(location.x, location.y, location.z, "~g~[E]~w~ para lavar dinheiro", 0.4)
            if Vdist(GetEntityCoords(ped), Config.Wash) < 1 and IsControlJustPressed(1, 38) then
                TriggerServerEvent("szwash:wash")
                print('Comando executado')
            end
        end 
    end
end)


Citizen.CreateThread(function()
    while true do
        local coords = GetEntityCoords(ped)
        Citizen.Wait(500)
        if Vdist(coords, Config.Wash) < Config.Distance then
            isNear = true
        else
            isNear = false
        end
    end
end)

function Draw3DText(x, y, z, text, scale)
	local onScreen, _x, _y = World3dToScreen2d(x, y, z)
	local pX, pY, pZ = table.unpack(GetGameplayCamCoords())
	SetTextScale(scale, scale)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextEntry("STRING")
	SetTextCentre(true)
	SetTextColour(255, 255, 255, 215)
	AddTextComponentString(text)
	DrawText(_x, _y)
	local factor = (string.len(text)) / 700
	DrawRect(_x, _y + 0.0150, 0.06 + factor, 0.03, 41, 11, 41, 100)
end
