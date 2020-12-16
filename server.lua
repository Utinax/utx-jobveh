ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('utx-jobveh:money')
AddEventHandler('utx-jobveh:money', function(type, miktar)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if type == 'give' then
        xPlayer.addAccountMoney('bank', miktar)
        TriggerClientEvent('esx:showNotification', src, 'Depozito olarak alınan 2500$ banka hesabınıza iade edildi!')
    elseif type == 'take' then
        xPlayer.removeAccountMoney('bank', miktar)
        TriggerClientEvent('esx:showNotification', src, 'Depozito olarak banka hesabınızdan 2500$ kesildi!')
    end
end)
