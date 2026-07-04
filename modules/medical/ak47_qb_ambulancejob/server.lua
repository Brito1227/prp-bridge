local medical = {}

local resourceName = 'ak47_qb_ambulancejob'

--- Source: https://docs.menanak47.com/qbcore/ak47_qb_ambulancejob/triggers

---@param src number | string
---@param amount number
function medical.healPlayer(src, amount)
    local target = tonumber(src)
    if not target then return end

    TriggerClientEvent(resourceName .. ':revive', target)
end

return medical
