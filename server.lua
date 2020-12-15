ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('utx-jobveh:takemoney')
AddEventHandler('utx-jobveh:takemoney', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    xPlayer.removeAccountMoney('bank', 2500)
    TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = 'Depozito olarak banka hesabınızdan 2500$ kesildi!'} )
end)

RegisterNetEvent('utx-jobveh:givemoney')
AddEventHandler('utx-jobveh:givemoney', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    xPlayer.addAccountMoney('bank', 2500)
    TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = 'Depozito olarak alınan 2500$ banka hesabınıza iade edildi!'} )
end)