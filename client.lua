ESX = nil

local blipsPlayers = {}

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do Citizen.Wait(10) end

    ESX.PlayerData = ESX.GetPlayerData()
    showBlips()
end)

function createBlip(ClientPlayerId)
    local ped = GetPlayerPed(ClientPlayerId)
    local blip = GetBlipFromEntity(ped)

    if DoesBlipExist(blip) then
        RemoveBlip(blip)
    end

     -- Add blip and create head display on player
        blip = AddBlipForEntity(ped)
        SetBlipSprite(blip, 1)
        ShowHeadingIndicatorOnBlip(blip, true) -- Player Blip indicator
        --SetBlipRotation(blip, math.ceil(GetEntityHeading(ped))) -- update rotation
        SetBlipColour(blip, 32)
        SetBlipNameToPlayerName(blip, ClientPlayerId) -- update blip name
        SetBlipScale(blip, 0.5) -- set scale
        SetBlipDisplay(blip, 2) --3 solo mapa grande
        SetBlipAsShortRange(blip, false)
        --table.insert(blipsPlayers, blip) -- add blip to array so we can remove it later
    
end

function showBlips()
    local players = ESX.Game.GetPlayers()

    for k,v in ipairs(players) do
        createBlip(v)
    end
end

--[[Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(1000)
        showBlips()
    end
end)]]

function removeBlip(ClientPlayerId)
    local blip = GetBlipFromEntity(ClientPlayerId)

    if DoesBlipExist(blip) then
        RemoveBlip(blip)
    end
end

RegisterNetEvent('esx_blips:addBlip')
AddEventHandler('esx_blips:addBlip',
    function(ServerPlayerId)
       -- createBlip(GetPlayerFromServerId(ServerPlayerId))
       showBlips()
    end)

RegisterNetEvent('esx_blips:deleteBlip')
AddEventHandler('esx_blips:deleteBlip',
    function(ServerPlayerId)
        removeBlip(GetPlayerFromServerId(ServerPlayerId))
    end)

RegisterNetEvent('playerSpawned')
AddEventHandler('playerSpawned', function()
    TriggerServerEvent('esx_blips:OnPlayerSpawned')
end)