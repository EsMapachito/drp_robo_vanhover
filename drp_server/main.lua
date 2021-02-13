VORP = exports.vorp_inventory:vorp_inventoryApi()

data = {}
TriggerEvent("vorp_inventory:getData",function(call)
    data = call
end)

RegisterNetEvent("drp_def_puerto:startToRob")
AddEventHandler("drp_def_puerto:startToRob", function()
    local _source = source
    TriggerEvent('vorp:getCharacter', _source, function(user)
        local count = VORP.getItemCount(_source, "lockpick")

        if count >= 1 then
         
            VORP.subItem(_source,"lockpick", 1)
            TriggerClientEvent('drp_def_puerto:startTimer', _source)
			TriggerClientEvent('drp_def_puerto:startAnimation', _source)
        else
            TriggerClientEvent("vorp:TipBottom", _source, "Necesitas una ganzúa", 6000)
        end     
    end)
end)

RegisterNetEvent("drp_def_puerto:payout")
AddEventHandler("drp_def_puerto:payout", function()
    TriggerEvent('vorp:getCharacter', source, function(user)
        local _source = source
        local _user = user
           TriggerEvent("vorp:addMoney",source, 0, 150, _user)
    end)
    TriggerClientEvent("vorp:Tip",source, 'Has conseguido 150$', 5000)

end)
