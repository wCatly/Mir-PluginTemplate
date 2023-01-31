local buff_hash = game:FnvHash("XerathLocusOfPower2")

local get = function()
    return player:FindBuffByHash(buff_hash)
end

return {
    get = get,
}