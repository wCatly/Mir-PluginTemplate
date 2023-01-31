local pred = loadscript("free-pred")

local targeting = require "targeting"
local menu = require "xerath/menu"
local q_buff = require "xerath/q_buff"
local q_charge = require "xerath/q_charge"

local input = pred.PredInputLinePrompt(1)
input.width = 72.5
input.cast_time = 0.6
input.add_target_bbox = true
input.target_range = q_charge.target_range_max

local result = pred.PredResult()
local eval = pred.PredEval()

local check_target_prediction = function(obj)
    pred:LinePrompt(input, obj, result)
    return result.is_in_target_range
end

local find_target = function()
    local vec = object_manager:EnemyHeroes()
    targeting.sort(vec)
    for i, obj in ipairs(vec) do
        if obj:IsTargetable() then
            if check_target_prediction(obj) then
                return obj
            end
        end
    end
end

local eval_target_prediction = function(obj)
    pred:EvalLinePrompt(input, result, obj, eval)

    local target_range = q_charge.target_range()
    if eval.distance > target_range then
        return false
    end
    if eval.is_higher_hitchance then
        print("high release q")
        return true
    end
    if eval.target_just_changed_path then
        return true
    end
    if q_charge.remaining_charge_time() < 0.1 then
        return true
    end
    return false
end

local get_action_target = function()
    if not q_buff.get() then
        return nil
    end
    if player:CanCastSpell(SpellSlot_Q) then
        return find_target()
    end
    return nil
end

local get_action_state = function()
    local obj = get_action_target()
    if obj then
        return eval_target_prediction(obj)
    end
end

local invoke_action = function()
    return player:ReleaseSpell(SpellSlot_Q, result.pos)
end

return {
    get_action_target = get_action_target,
    get_action_state = get_action_state,
    invoke_action = invoke_action,
}