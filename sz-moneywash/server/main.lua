ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("szwash:wash")
AddEventHandler('szwash:wash', function()

	local xPlayer = ESX.GetPlayerFromId(source)
	local money = xPlayer.getMoney()
	local black_money_amount = xPlayer.getAccount('black_money').money

    if black_money_amount == 0 then
        TriggerClientEvent('esx:showNotification', source, "Não tens dinheiro sujo!")
        return
    else
	xPlayer.addMoney(black_money_amount) -- Adds the normal money
	xPlayer.removeAccountMoney('black_money', black_money_amount) -- Removes Dirty Money

	TriggerClientEvent('esx:showNotification', source, "Lavaste o ~g~dinheiro~w~ sujo com sucesso!")
    end
end)