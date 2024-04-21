util.require_natives('3095a')

local settings_list = menu.list(menu.my_root(), "Settings", {}, "", function() end)

local delay = 1000
settings_list:slider("Change Delay", {"invischeckdelay"}, "Change the delay between the checks for invisible vehicles", 0, 100000, delay, 1000, function(kys)
    delay = kys
end)

local deletemessage = true
menu.toggle(settings_list, "Enable Delete Message", {"delmessage"}, "Enables message on deleting vehicles.", function(on)
    deletemessage = on
end, deletemessage)

function RemoveInvisVehicles()
    local vehicle = entities.get_user_vehicle_as_handle(true)
    if vehicle ~= -1 and not ENTITY.IS_ENTITY_VISIBLE(vehicle) then
        if deletemessage then
            util.toast("Deleting invisible vehicle: "..VEHICLE.GET_DISPLAY_NAME_FROM_VEHICLE_MODEL(ENTITY.GET_ENTITY_MODEL(vehicle)))
        end
        entities.delete(vehicle)
    end
    util.yield(delay)
end

menu.toggle_loop(menu.my_root(), "Remove Invisible vehicles", {"fuckinvisveh"}, "Removes invisible vehicles.", function(on)
    RemoveInvisVehicles()
end)


util.keep_running()