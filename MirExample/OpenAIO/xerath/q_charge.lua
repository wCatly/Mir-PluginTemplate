local menu = require "xerath/menu"
local q_buff = require "xerath/q_buff"

local charge_time = 1.5
local charge_time_max = 3.5 - 0.264 --(buffs are updated every 0.264 seconds)
local target_range_min = 750
local target_range_min_sqr = 750*750
local target_range_max = 1500
local target_range_max_sqr = 1500*1500

local target_range = function()
    local buff = q_buff.get()
    if not buff then
        return 0
    end
    local elapsed = game:Time() - buff:StartTime()
    elapsed = elapsed + game:Latency() - 0.033*4
    local t = elapsed / charge_time
    local v = target_range_max - target_range_min
    local range = target_range_min + t*v
    return math.min(target_range_max, range)
end

local remaining_charge_time = function()
    local buff = q_buff.get()
    if not buff then
        return 0
    end
    return charge_time_max - (game:Time() - buff:StartTime())
end

local is_in_target_range_max = function(obj)
    return obj:Pos():DistSqr(player:Pos()) < target_range_max_sqr
end

local find_target = function()
    local pos = player:Pos()
    local vec = object_manager:EnemyHeroes()
    for i, obj in ipairs(vec) do
        if obj:IsTargetable() then
            if is_in_target_range_max(obj) then
                return true
            end
        end
    end
end

local get_action_state = function()
    if q_buff.get() then
        return false
    end
    if player:CanCastSpell(SpellSlot_Q) then
        local obj = find_target()
        if obj then
            return true
        end
    end
    return false
end

local invoke_action = function()
    return player:CastSpellPos(SpellSlot_Q, game:MousePos())
end

return {
    get_action_state = get_action_state,
    invoke_action = invoke_action,

    target_range_min = target_range_min,
    target_range_min_sqr = target_range_min_sqr,
    target_range_max = target_range_max,
    target_range_max_sqr = target_range_max_sqr,

    target_range = target_range,
    remaining_charge_time = remaining_charge_time,
}