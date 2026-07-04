local medical = {}

local resourceName = 'ak47_qb_ambulancejob'

--- Source: https://docs.menanak47.com/qbcore/ak47_qb_ambulancejob/exports

---@param serverId number
---@return boolean
function medical.isPlayerDead(serverId)
    local target = tonumber(serverId)
    if not target then return false end

    return exports[resourceName]:IsPlayerDead(target) or exports[resourceName]:IsPlayerDown(target) or false
end

---@param value number
function medical.overrideMaxHealth(value)
    -- Integrations with other resources
end

if bridge.name == bridge.currentResource then
    local cachedDeadState

    ---@param value boolean
    local function syncDeathState(value)
        if cachedDeadState == value then return end
        cachedDeadState = value

        if not value then
            TriggerServerEvent("prp-bridge:server:revived")
            TriggerEvent("prp-bridge:client:revived")
            return
        end

        TriggerServerEvent("prp-bridge:server:died")
        TriggerEvent("prp-bridge:client:died")
    end

    RegisterNetEvent(resourceName .. ':onPlayerDown', function()
        syncDeathState(true)
    end)

    RegisterNetEvent(resourceName .. ':onPlayerDeath', function()
        syncDeathState(true)
    end)

    RegisterNetEvent(resourceName .. ':onPlayerRevive', function()
        syncDeathState(false)
    end)

    RegisterNetEvent(resourceName .. ':onForceRespawn', function()
        syncDeathState(false)
    end)
end

return medical
