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

    ---
    --- Discord Rich Presence
    ---
    SetDiscordAppId(EssentialsConfig.Discord.DiscordAppID)
    if EssentialsConfig.Discord.Enabled then
        SetDiscordRichPresenceAsset(EssentialsConfig.Discord.BigImageName) 
		SetDiscordRichPresenceAssetText(EssentialsConfig.Discord.BigImageHoverText) 
		SetDiscordRichPresenceAssetSmall(EssentialsConfig.Discord.SmallImageName)
		SetDiscordRichPresenceAssetSmallText(EssentialsConfig.Discord.SmallImageHoverText)
		SetRichPresence(EssentialsConfig.Discord.RichPresenceText) 
		SetDiscordRichPresenceAction(0, EssentialsConfig.Discord.FirstButton.text, EssentialsConfig.Discord.FirstButton.url)
		SetDiscordRichPresenceAction(1, EssentialsConfig.Discord.SecondButton.text, EssentialsConfig.Discord.SecondButton.url)
		Wait(5000)
    end

    ---
    --- Remove Map Limits
    ---
    Wait(0)
        ExpandWorldLimits(
            -9000.0,
            -11000.0,
            30.0
        )  
        ExpandWorldLimits(
            10000.0,
            12000.0,
            30.0
        ) 		
    end
end)
