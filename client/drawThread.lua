-- optimizations
local Wait                      = Wait
local PlayerPedId               = PlayerPedId
local GetPlayerWantedLevel      = GetPlayerWantedLevel
local ClearPlayerWantedLevel    = ClearPlayerWantedLevel
local GetSelectedPedWeapon      = GetSelectedPedWeapon
local HideHudComponentThisFrame = HideHudComponentThisFrame

--- Read the config values into locals
local hideCrosshair             = EssentialsConfig.Crosshair.Disabled
local hideCrosshairExcluded     = EssentialsConfig.Crosshair.Excluded
local neverWanted               = EssentialsConfig.NeverWanted
local vehOnlyMinimap = EssentialsConfig.Minimap.OnlyShowInVehicle

CreateThread(function()
    local playerId = PlayerId()
    for i, model in pairs(hideCrosshairExcluded) do
        hideCrosshairExcluded[i] = GetHashKey(model)
    end

    while true do
        local ped = PlayerPedId()

        -- Never wanted
        if neverWanted and GetPlayerWantedLevel(playerId) ~= 0 then
            ClearPlayerWantedLevel(playerId)
        end
        local showRadar = true
        if vehOnlyMinimap and not IsPedInAnyVehicle(ped, false) then
            showRadar = false
        end
        DisplayRadar(showRadar)
        SetBigmapActive(false, showRadar)

        -- Hide crosshair
        if hideCrosshair then
            local hide = true
            if #hideCrosshairExcluded > 0 then
                local currentWeapon = GetSelectedPedWeapon(ped)
                for _, hash in pairs(hideCrosshairExcluded) do
                    if currentWeapon == hash then
                        hide = false
                        break
                    end
                end
            end

            if hide then HideHudComponentThisFrame(14) end
        end
        Wait(0)
    end
end)