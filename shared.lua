Shared = {}
Shared.Locale = "en"
Shared.Framework = "esx" -- # esx ,qb
Shared.Target = "ox_target" -- # ox_target, qb-target
Shared.MoneyItem = "money" -- # example (cash, money, other item name)

Shared.Positions = { 
  ["loc_1"] = { -- # zone name its importat that each zone have unique name
    hash = "a_m_m_og_boss_01",
    coords = vec4(-662.24, -964.36, 21.24, 355.28), 
	job = nil, -- # if you want job for this location just add job or put to be nil 
    blip = {
      enable = true, 
      sprite = 227, 
      color = 9,
      size = 0.65, 
      text = "Vehicle Rent",
    },
	vehicles = {
			{
				title = 'BLISTA', 
				icon = 'fa-solid fa-cart-shopping',
				description = "Price = 50$", 
				event = "gg-rent:SpawnVehicle", 
				args = { price = 50, veh_hash = "blista", coords = vec4(-663.2, -961.88, 20.64, 274.36) } 
			},
			{
				title = 'SULTAN', 
				icon = 'fa-solid fa-cart-shopping',
				description = "price = 80$", 
				event = "gg-rent:SpawnVehicle", 
				args = { price = 80, veh_hash = "sultan", coords = vec4(-663.2, -961.88, 20.64, 274.36) } 
			},
			{
				title = 'BF490', 
				icon = 'fa-solid fa-cart-shopping',
				description = "Price = 30$", 
				event = "gg-rent:SpawnVehicle", 
				args = { Price = 30, veh_hash = "bf400", coords = vec4(-663.2, -961.88, 20.64, 274.36) } 
			},
	},
  },
}

RegisterNetEvent("gg-rent:SendAlert")
 AddEventHandler("gg-rent:SendAlert", function(title, msg, type)

    if type == "info" then 
        lib.notify({
            title = title,
            description = msg,
            type = "inform",
            position = "left-top",
        })
    elseif type == "error" then 
        lib.notify({
            title = title,
            description = msg,
            type = "error",
            position = "left-top",
        })
    elseif type == "success" then 
        lib.notify({
            title = title,
            description = msg,
            type = "success",
            position = "left-top",
        })
    end

    --ESX.ShowNotification(message, 5000, type)
 
    --SetNotificationTextEntry('STRING')
    --AddTextComponentString(message)
    --DrawNotification(0,1)
 
    --exports['mythic_notify']:DoHudText('inform', message)

end)
