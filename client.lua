ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

local sleep = 2000
local isInMarker = false
local isInMarker2 = false
local aracalindi = false

function DrawText3D(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(sleep)
		perform = false
		isInMarker = false

		local player = PlayerPedId()
		local playerCoords = GetEntityCoords(player)
		local distance = GetDistanceBetweenCoords(playerCoords, -339.335, -1024.46, 30.380, true)
		local distance2 = GetDistanceBetweenCoords(playerCoords, -310.487, -1028.75, 30.385, true)

		if (distance < 16) then
			perform = true
			DrawMarker(2, -339.335, -1024.46, 30.380, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.4, 0.4, 0.2, 255, 255, 255, 255, 0, 0, 0, 1, 0, 0, 0)
			if distance < 3 then
				isInMarker = true
				DrawText3D(-339.335, -1024.46, 30.380 + 0.4, '~g~E~s~ - Meslek Aracı Çıkart')
			end
		end

		if (distance2 < 16) then
			perform = true
			DrawMarker(2, -310.487, -1028.75, 30.385, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.4, 0.4, 0.2, 255, 255, 255, 255, 0, 0, 0, 1, 0, 0, 0)
			if distance2 < 3 then
				isInMarker2 = true
				DrawText3D(-310.487, -1028.75, 30.385 + 0.4, '~g~E~s~ - Meslek Aracını Geri Ver')
			end
		end

		if IsControlJustReleased(0, 38) and isInMarker then
			AracCikart()
		elseif IsControlJustReleased(0, 38) and isInMarker2 then
			AracSil()
		end

		if perform then
			sleep = 7
		elseif not perform then
			sleep = 2000
		end

	end
end)

function AracCikart()
	local player = PlayerPedId()
	local aractami = IsPedInAnyVehicle(player, false)
	if not aractami then
		if not aracalindi then
			ESX.Game.SpawnVehicle('utillitruck3', vector3(-337.037, -1018.13, 30.384), 250.0, function(vehicle)
				local plate = 'WORK' .. math.random(100, 900)
				SetVehicleNumberPlateText(vehicle, plate)
				local plate2 = GetVehicleNumberPlateText(vehicle)
				exports['hsn-hotwire']:AddKeys(plate2)
				aracalindi = true
				TaskWarpPedIntoVehicle(player, vehicle, -1)
			end)
			TriggerServerEvent('utx-jobveh:takemoney')
		else
			ESX.ShowNotification('Zaten araç almışsınız!')
		end
	else
		ESX.ShowNotification('Bir araçtayken bunu yapamazsınız!')
	end
end

function AracSil()
    local player = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(player, false)
    local driver = GetPedInVehicleSeat(vehicle, -1)
	local model = GetEntityModel(vehicle)
	local aractami = IsPedInAnyVehicle(player, false)
	if aractami then
		if aracalindi then
			if player == driver then
				if model == 2132890591 then
            		DeleteVehicle(vehicle)
            		aracalindi = false
					ESX.TriggerServerCallback("utx-jobveh:givemoney", function(CB)
						if CB then
						  ESX.ShowNotification('Depozito olarak alınan 2500$ banka hesabınıza iade edildi!')
						end
					end, 2500)
				else
					ESX.ShowNotification('Bu araç meslek aracı değil!')
				end
			else
				ESX.ShowNotification('Aracın sürücüsü siz değilsiniz!')
			end
    	else
        	ESX.ShowNotification('Meslek aracı almamışsınız!')
		end
	else
		ESX.ShowNotification('Bir araçta değilsiniz!')
	end
end

Citizen.CreateThread(function()
	local coords = vector3(-339.335, -1024.46, 30.380)
	local blip = AddBlipForCoord(coords)

	SetBlipSprite(blip, 67)
	SetBlipScale(blip, 0.7)
	SetBlipColour(blip, 5)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName('Meslek Aracı Çıkar')
	EndTextCommandSetBlipName(blip)
end)
