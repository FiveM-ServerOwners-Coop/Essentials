local _blockedModelHashes = {}

for _, model in pairs(EssentialsConfig.NPCs.BlockedModels) do
    table.insert(_blockedModelHashes, GetHashKey(model))
end

for _, model in pairs(EssentialsConfig.Vehicles.BlockedModels) do
    table.insert(_blockedModelHashes, GetHashKey(model))
end

for _, model in pairs(EssentialsConfig.Props.BlockedModels) do
    table.insert(_blockedModelHashes, GetHashKey(model))
end

AddEventHandler("entityCreating", function(entity)
    for _, hash in pairs(_blockedModelHashes) do
        if GetEntityModel(entity) == hash then
            print("Blocked entity spawn (" .. hash .. ") - " .. entity)
            print("Source: " .. (source or "nil"))
            CancelEvent()
            break
        end
    end
end)

Citizen.CreateThread(function()
    if #_blockedModelHashes > 0 then
        print("[Essentials] Ready to block " .. #_blockedModelHashes .. " models from spawning")
    end
end)

if EssentialsConfig.PVP then
    AddEventHandler("playerSpawned", function(spawn)
        SetCanAttackFriendly(PlayerPedId(), true, false)
        NetworkSetFriendlyFireOption(true)
    end) 
end
