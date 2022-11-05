cururl = nil

RegisterNetEvent('r14-uwumenu:server:syncreplace', function(url)
	cururl = url
	TriggerClientEvent('r14-uwumenu:client:setreplace', -1, url)
end)

RegisterNetEvent('r14-uwumenu:server:loadreplace', function()
	TriggerClientEvent('r14-uwumenu:client:setreplace', -1, cururl)
end)

RegisterNetEvent('r14-uwumenu:server:cancelreplace', function()
	TriggerClientEvent('r14-uwumenu:client:cancelreplace', -1)
end)

RegisterNetEvent('r14-uwumenu:server:setpreconmenu', function(data)
	print('here')
	TriggerClientEvent('r14-uwumenu:client:setpreconmenu', -1, data.selection)
end)