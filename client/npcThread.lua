local blockedHashes = {}
for _, model in pairs(EssentialsConfig.NPCs.BlockedModels) do
    table.insert(blockedHashes, GetHashKey(model))
end

local function PedHashIsBlocked(hash)
    for _, _hash in pairs(blockedHashes) do
        if hash == _hash then return true end
    end
    return false
end

CreateThread(function()
    while true do
        Wait(500)
        local playerPed = PlayerPedId()
        for _, ped in EnumeratePeds() do
            if DoesEntityExist(ped) then
                if PedHashIsBlocked(GetHashKey(GetEntityModel(ped))) then
                    DeleteEntity(ped)
                elseif IsPedInCombat(ped, playerPed) then
                    ClearPedTasksImmediately(ped)
                end
            end
        end
    end
end)
