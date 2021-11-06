RegisterFontFile('font4thai')
fontId = RegisterFontId('font4thai')
function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())

    SetTextScale(0.55, 0.55)
    SetTextFont(fontId)
    SetTextProportional(1)
	SetTextColour(255, 255, 255, 255)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 500
    DrawRect(_x, _y + 0.0300, 0.0110 + factor, 0.05, 0, 0, 0, 100)
end

function reloadskillbar()
    local Result = exports['xzero_skillcheck']:startGameSync({
        textTitle           = Config.xzero_skillcheck.textTitle, -- ข้อความที่แสดง
        speedMin            = Config.xzero_skillcheck.speedMin,         -- ความเร็วสุ่มตั้งแต่เท่าไหร่  (ยิ่งน้อยยิ่งเร็ว)
        speedMax            = Config.xzero_skillcheck.speedMax,         -- ความเร็วสุ่มถึงเท่าไหร่    (ยิ่งน้อยยิ่งเร็ว)
        countSuccessMax     = Config.xzero_skillcheck.countSuccessMax,          -- กำหนดจำนวนครั้งที่สำเร็จ (เมื่อถึงเป้าจะ success)
        countFailedMax      = Config.xzero_skillcheck.countFailedMax,          -- กำหนดจำนวนครั้งที่ล้มเหลว (เมื่อถึงเป้าจะ failed)
    })
    if Result.status then
        policenotify()
        londing()
        
    else
        exports['mythic_notify']:SendAlert('error', _U('fail'), 3*1000)
    end


end

function londing()
	FreezeEntityPosition(playerPed, true)
    TriggerEvent("mythic_progbar:client:progress", {
        name = "unique_action_name",
        duration = Config.mythictime*1000,
        label = _U('mythic_label'),
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },
       animation = {
        animDict = nil,
        anim = nil,
        flags = 0,
        task = 'PROP_HUMAN_BUM_SHOPPING_CART',
    },
        
    }, function(status)
        if not status then
    TriggerServerEvent('Mairu_Cemant:pickedUp')
    FreezeEntityPosition(playerPed, false)
    ClearPedTasks(PlayerPedId())
        end
    end)
end



function policenotify()
    if Config.policenotify.policesound then
        if ESX.GetPlayerData().job.name == 'police' then
            SendNUIMessage({
                type = 'police',
            })
        end
    end
    SendDistressSignal()
    TriggerEvent(Config.policenotify.alertNet.Even, Config.policenotify.alertNet.category)
end

