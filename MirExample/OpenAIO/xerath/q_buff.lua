local buff_hash = game:FnvHash("XerathArcanopulseChargeUp")

local get = function()
    return player:FindBuffByHash(buff_hash)
end

return {
    get = get,
}