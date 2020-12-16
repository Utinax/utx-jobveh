ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('utx-jobveh:takemoney')
AddEventHandler('utx-jobveh:takemoney', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    xPlayer.removeAccountMoney('bank', 2500)
    TriggerClientEvent('esx:showNotification', src, 'Depozito olarak banka hesabınızdan 2500$ kesildi!')
end)

ESX.RegisterServerCallback("utx-jobveh:givemoney", function(source, cb, verilecekpara)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    xPlayer.addAccountMoney('bank', verilecekpara)
    cb(true)
end)
