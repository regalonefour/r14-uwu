local QBCore = exports['qb-core']:GetCoreObject()

exports['qb-target']:AddBoxZone("uwumenu", vector3(-587.27, -1059.56, 22.34), 0.6, 3.0, { -- The name has to be unique, the coords a vector3 as shown, the 1.5 is the length of the boxzone and the 1.6 is the width of the boxzone, the length and width have to be float values
  name = "uwumenu", -- This is the name of the zone recognized by PolyZone, this has to be unique so it doesn't mess up with other zones
  heading = 270.0, -- The heading of the boxzone, this has to be a float value
  debugPoly = false, -- This is for enabling/disabling the drawing of the box, it accepts only a boolean value (true or false), when true it will draw the polyzone in green
  minZ=23.49, 
  maxZ=24.89
}, {
  options = { -- This is your options table, in this table all the options will be specified for the target to accept
    { -- This is the first table with options, you can make as many options inside the options table as you want
      type = "client", -- This specifies the type of event the target has to trigger on click, this can be "client", "server", "command" or "qbcommand", this is OPTIONAL and will only work if the event is also specified
      icon = 'fa-solid fa-cat', -- This is the icon that will display next to this trigger option
      label = 'Change Menu', -- This is the label of this option which you would be able to click on to trigger everything, this has to be a string
      event = 'r14-uwumenu:client:menumenu',
      job = 'uwu', -- This is the job, this option won't show up if the player doesn't have this job, this can also be done with multiple jobs and grades, if you want multiple jobs you always need a grade with it: job = {["police"] = 0, ["ambulance"] = 2},
    }
  },
  distance = 2.5,
})

RegisterNetEvent('r14-uwumenu:client:menumenu', function(data)
    TriggerEvent('animations:client:EmoteCommandStart', {'tablet2'})

    exports['qb-menu']:openMenu({
        {
            header = "Uwu Menu Options",
            isMenuHeader = true
        },
        {
            header = "Set Custom Image",
            params = {
                event = 'r14-uwumenu:client:getreplace',
            },
        },
        {
            header = "Select Preconfigured Menus",
            params = {
                event = "r14-uwumenu:client:selectmenu",
            },
        },
        {
            header = "Reset Menu",
            params = {
                isServer = true,
                event = 'r14-uwumenu:server:cancelreplace',
            },
        },
        {
            header = "Close (ESC)",
            params = {
                event = exports['qb-menu']:closeMenu(),
            }
        },
    })
end)

RegisterNetEvent('r14-uwumenu:client:selectmenu', function(data)
    exports['qb-menu']:openMenu({
        {
            header = "Preconfigured Menus",
            isMenuHeader = true
        },
        {
            header = "Animated Slide",
            params = {
                isServer = true,
                event = 'r14-uwumenu:server:setpreconmenu',
                args = {
                    selection = '1',
                },
            },
        },
        {
            header = "Close (ESC)",
            params = {
                event = exports['qb-menu']:closeMenu(),
            }
        },
    })
end)

local precon = nil

RegisterNetEvent('r14-uwumenu:client:setpreconmenu', function(selection)
    print("in precon", selection)
    RequestStreamedTextureDict('uwuanim'..selection)
    precon = false
    Wait(1000)
    precon = true
        while true do

            for i = 1, 23, 1 do
                print('here', tostring(i))
                AddReplaceTexture('denis3d_catcafe_txd', 't_m_catcafe_imageatlas01', 'uwuanim'..selection, i)
                Wait(200)
            end
            for i = 23, 1, -1 do
                print('here2', tostring(i))
                AddReplaceTexture('denis3d_catcafe_txd', 't_m_catcafe_imageatlas01', 'uwuanim'..selection, i)
                Wait(200)
            end
            Wait(0)
        end

end)

RegisterNetEvent('r14-uwumenu:client:getreplace', function(data)
    local query = exports["qb-input"]:ShowInput({
        header = "Change Displayed Menu",
        submitText = "Submit",
        inputs = {
            {
                text = "Enter URL",
                name = "url",
                type = "text",
                isRequired = true
            },
        },
    })
    if query then
        TriggerServerEvent('r14-uwumenu:server:syncreplace', query.url)
        TriggerEvent('animations:client:EmoteCommandStart', {'c'})
    else
        QBCore.Functions.Notify("Something went wrong!")
        TriggerEvent('animations:client:EmoteCommandStart', {'c'})
        return
    end
end)

RegisterNetEvent('r14-uwumenu:client:setreplace', function(url)
	local txd = CreateRuntimeTxd('duiTxd')
	local duiObj = CreateDui(url, 2048, 2048)
	Wait(40)
	local dui = GetDuiHandle(duiObj)
	local tx = CreateRuntimeTextureFromDuiHandle(txd, 'duiTex', dui)

    AddReplaceTexture('denis3d_catcafe_txd', 't_m_catcafe_imageatlas01', 'duiTxd', 'duiTex')
end)

RegisterNetEvent('r14-uwumenu:client:cancelreplace', function(url)
    RemoveReplaceTexture('denis3d_catcafe_txd', 't_m_catcafe_imageatlas01')
    precon = false
end)
