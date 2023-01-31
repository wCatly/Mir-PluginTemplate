local pred = loadscript("free-pred")

local targeting = require "targeting"
local menu = require "xerath/menu"
local q_buff = require "xerath/q_buff"
local q_charge = require "xerath/q_charge"

local input = pred.PredInputLinePrompt()
input.width = 72.5
input.cast_time = 0.6
input.add_target_bbox = true
input.target_range = q_charge.target_range_min

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
    if eval.is_higher_hitchance then
        return true
    end
    if eval.target_just_changed_path then
        return true
    end
    return false
end

local get_action_state = function()
    if q_buff.get() then
        return false
    end
    if player:CanCastSpell(SpellSlot_Q) then
        local obj = find_target()
        if obj then
            return eval_target_prediction(obj)
        end
    end
    return false
end

local invoke_action = function()
    if player:CastSpellPos(SpellSlot_Q, result.pos) then
        return player:ReleaseSpell(SpellSlot_Q, result.pos)
    end
end

return {
    get_action_state = get_action_state,
    invoke_action = invoke_action,
}