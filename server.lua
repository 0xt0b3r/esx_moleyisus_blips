ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('playerDropped', function()
			TriggerClientEvent('esx_blips:deleteBlip', -1, source)
end)

RegisterNetEvent('esx_blips:OnPlayerSpawned')
AddEventHandler('esx_blips:OnPlayerSpawned', function()
    Citizen.Wait(5000)
    TriggerClientEvent('esx_blips:addBlip', -1, source)
end)