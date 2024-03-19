CreateThread(function()
    for k, v in pairs(Shared.Positions) do 
        if v.blip.enable then 
            local blip = AddBlipForCoord(vector3(v.coords.x, v.coords.y, v.coords.z))
            SetBlipSprite (blip, v.blip.sprite)
            SetBlipDisplay(blip, 4)
            SetBlipScale  (blip, v.blip.size)
            SetBlipColour (blip, v.blip.color)
            SetBlipAsShortRange(blip, true)

            BeginTextCommandSetBlipName('STRING')
            AddTextComponentSubstringPlayerName(v.blip.text)
            EndTextCommandSetBlipName(blip)
        end
        RequestModel(GetHashKey(v.hash))
        while not HasModelLoaded(GetHashKey(v.hash)) do
        Wait(1)
        end
        RentaPed = CreatePed(4, v.hash, vector3(v.coords.x, v.coords.y, v.coords.z -1), v.coords.w, false, true)
        FreezeEntityPosition(RentaPed, true) 
        SetEntityInvincible(RentaPed, true)
        SetBlockingOfNonTemporaryEvents(RentaPed, true)
        if Shared.Target == "ox_target" then 
            exports.ox_target:addLocalEntity(RentaPed, {
                {
                    name = "rent_"..k,
                    label = L('open_rent'),
                    icon = "fa-solid fa-square-parking",
                    distance = 3,
                    canInteract = function()
                        if v.job == nil then 
                            return true 
                        else
                            if QT.getjob() == v.job then
                                return true 
                            else
                                return false 
                            end
                        end
                    end,
                    onSelect = function(data)
                        local coords = GetEntityCoords(cache.ped, true)
                        if #(coords - vector3(v.coords.x, v.coords.y, v.coords.z)) < 10.5 then 
                            lib.registerContext({
                                id = 'rent_vehicles'..k,
                                title = L('menu_name'),
                                options = v.vehicles,
                            })
                            lib.showContext('rent_vehicles'..k)
                        end
                    end,
                }
            })
        elseif Shared.Target == "qb-target" then 
            exports['qb-target']:AddTargetEntity(RentaPed, {
                options = {
                    {
                        action = function()
                            local coords = GetEntityCoords(cache.ped, true)
                            if #(coords - vector3(v.coords.x, v.coords.y, v.coords.z)) < 10.5 then 
                                lib.registerContext({
                                    id = 'rent_vehicles'..k,
                                    title = L('menu_name'),
                                    options = v.vehicles,
                                })
                                lib.showContext('rent_vehicles'..k)
                            end
                        end,
                        icon = "fa-solid fa-square-parking",
                        label = L('open_rent'),
                        canInteract = function()
                            if v.job == nil then 
                                return true 
                            else
                                if QT.getjob() == v.job then
                                    return true 
                                else
                                    return false 
                                end
                            end
                        end,
                    }
                },
                distance = 3.0
            })
        end
    end
end)

RegisterNetEvent("gg-rent:SpawnVehicle")
 AddEventHandler("gg-rent:SpawnVehicle", function(data)
    local spawn_point = IsAnyVehicleNearPoint(data.coords.x, data.coords.y, data.coords.z, 3.5)
    if not spawn_point then 
        QT.TriggerCallback("gg-rent:HasEnough", function(canAfford)
            if canAfford then 
                QT.CreateVeh({ 
                    model = data.veh_hash,
                    coords = vec4(data.coords.x, data.coords.y, data.coords.z, data.coords.w), 
                }, function(veh)
                    TaskWarpPedIntoVehicle(cache.ped, veh, -1)
                    SetEntityAsMissionEntity(veh)
                    SetVehicleHasBeenOwnedByPlayer(veh, true)
                    SetVehRadioStation(GetVehiclePedIsIn(cache.ped),"OFF")
                end, data.price)
               TriggerEvent("gg-rent:SendAlert", L('main_title'), L('rented_veh'), "success")
           else
             TriggerEvent("gg-rent:SendAlert", L('main_title'), L('insuficient_money'), "error")
           end
       end, data.price)
    else
        TriggerEvent("gg-rent:SendAlert", L('main_title'), L('spawn_blocked'), "error")
    end
end)
