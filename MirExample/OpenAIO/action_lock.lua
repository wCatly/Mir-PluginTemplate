--this modules purpose is to prevent spell buffering which mess up pred

local lock_end_time = 0

local spell_lock_time = {
    ["EzrealQ"] = function(spell)
        return game:Time() + spell:WindUpTime() - game:Latency() + 0.033
    end,
    ["EzrealW"] = function(spell)
        return game:Time() + spell:WindUpTime() - game:Latency() + 0.033
    end,
    ["EzrealE"] = function(spell)
        return game:Time() + spell:WindUpTime() - game:Latency() + 0.033
    end,
    ["EzrealR"] = function(spell)
        return game:Time() + spell:WindUpTime() - game:Latency() + 0.033
    end,


    ["XerathArcanopulse2"] = function(spell)
        return game:Time() + 0.60 - game:Latency() + 0.033
    end,
    ["XerathArcaneBarrage2"] = function(spell)
        return game:Time() + 0.25 - game:Latency() + 0.033
    end,
    ["XerathMageSpear"] = function(spell)
        return game:Time() + 0.25 - game:Latency() + 0.033
    end,
}

local is_locked = function()
    return game:Time() < lock_end_time
end

local set_lock_await_response = function()
    lock_end_time = game:Time() + game:Latency() + 0.033*4
end

local process_spell = function(spell)
    local source = spell:Source()
    if not source or not source:IsPlayer() then
        return
    end
    local name = spell:Name()
    if spell_lock_time[name] then
        lock_end_time = spell_lock_time[name](spell)
    end
end

return {
    is_locked = is_locked,
    set_lock_await_response = set_lock_await_response,

    process_spell = process_spell,
}