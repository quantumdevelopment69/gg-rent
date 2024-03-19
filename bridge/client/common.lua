QT = {

    TriggerCallback = function(name, cb, ...)
        if ESX ~= nil then
            ESX.TriggerServerCallback(name, cb, ...)
        elseif QBCore ~= nil then
            QBCore.Functions.TriggerCallback(name, cb, ...)
        end
    end,

    getjob = function()
        if ESX ~= nil then
            return ESX.GetPlayerData().job.name
        elseif QBCore ~= nil then
            return QBCore.Functions.GetPlayerData().job.name
        end
    end,

     ZoneCheck = function(v, num)
        local ply = GetEntityCoords(PlayerPedId())
        local dist = #(ply - vector3(v.x, v.y, v.z))
        if dist <= num then 
            return true 
        else
            return false
        end
    end,

    CloseVeh = function(coords)
        if ESX ~= nil then
            return ESX.Game.GetClosestVehicle(coords)
        elseif QBCore ~= nil then
            return QBCore.Functions.GetClosestVehicle(coords)
        end
    end,

    GetPosition = function(entity)
        return vector4(GetEntityCoords(entity), GetEntityHeading(entity))
    end,

    CreateVeh = function(data, cb)
        local playerPed = PlayerPedId()
        local vehiclehash = GetHashKey(data.model)
        RequestModel(vehiclehash)
        CreateThread(function()
            local waiting = 0
            while not HasModelLoaded(vehiclehash) do
                waiting = waiting + 100
                Wait(100)
                if waiting > 5000 then
                    break
                end
            end
            local vehicle = CreateVehicle(vehiclehash, vector3(data.coords.x, data.coords.y, data.coords.z), data.coords.w, 1, 0)
            cb(vehicle)
        end)
    end,


    Cmd = function(name, handler, restricted)
        if ESX ~= nil then
            RegisterCommand(name, handler, restricted)
        elseif QBCore ~= nil then
            QBCore.Commands.Add(name, handler)
        end
    end,

    Notification = function(data)
        if Config.UseFrameworkNotification then 
            if ESX ~= nil then
                ESX.ShowNotification(data.message)
            elseif QBCore ~= nil then
                QBCore.Functions.Notify(data.message)
            end
        else
            SendNotify(src, data)
        end
    end,

    GetVehicleProperties = function(vehicle)
        if ESX ~= nil then
            return ESX.Game.GetVehicleProperties(vehicle)
        elseif QBCore ~= nil then
            return QBCore.Functions.GetVehicleProperties(vehicle)
        end
    end,

    SetVehicleProperties = function(vehicle, props)
        if ESX ~= nil then
            ESX.Game.SetVehicleProperties(vehicle, props)
        elseif QBCore ~= nil then
            QBCore.Functions.SetVehicleProperties(vehicle, props)
        end
    end,

    Sleep = function(data, cb)
        if data.type == "minutes" then 
            local minute = 60 * 1000
            Wait(data.time * minute)
            cb()  -- Call the callback function when done
        elseif data.type == "seconds" then 
            local second = 1000
            Wait(data.time * second)
            cb()  -- Call the callback function when done
        end
    end
    
}
