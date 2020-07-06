-- optimizations
local Wait                                       = Citizen.Wait
local CreateThread                               = Citizen.CreateThread
local EnableDispatchService                      = EnableDispatchService
local SetPedDensityMultiplierThisFrame           = SetPedDensityMultiplierThisFrame
local SetScenarioPedDensityMultiplierThisFrame   = SetScenarioPedDensityMultiplierThisFrame
local SetVehicleDensityMultiplierThisFrame       = SetVehicleDensityMultiplierThisFrame
local SetRandomVehicleDensityMultiplierThisFrame = SetRandomVehicleDensityMultiplierThisFrame
local SetParkedVehicleDensityMultiplierThisFrame = SetParkedVehicleDensityMultiplierThisFrame

CreateThread(function()
    ---
    --- Pause Menu Name
    ---
    if EssentialsConfig.PauseMenu.ShowCustomTitle then
        AddTextEntry('FE_THDR_GTAO', EssentialsConfig.PauseMenu.Title)
    end

    ---
    --- Disable Dispatch
    ---
    if EssentialsConfig.NPCs.DisableDispatch then
        for i = 1, 15 do EnableDispatchService(i, false) end
    end

    ---
    --- NPC Density
    ---
    local localDensity   = EssentialsConfig.NPCs.Density.Locals
    local vehicleDensity = EssentialsConfig.NPCs.Density.Vehicles

    if localDensity ~= 1.0 and vehicleDensity ~= 1.0 then
        while true do
            -- These natives has to be called every frame.
            SetPedDensityMultiplierThisFrame(localDensity)
            SetScenarioPedDensityMultiplierThisFrame(localDensity, localDensity)
            SetVehicleDensityMultiplierThisFrame(vehicleDensity)
            SetRandomVehicleDensityMultiplierThisFrame(vehicleDensity)
            SetParkedVehicleDensityMultiplierThisFrame(vehicleDensity)
            Wait(0)
        end
    end
end)
