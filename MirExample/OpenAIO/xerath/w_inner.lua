local pred = loadscript("free-pred")

local targeting = require "targeting"
local menu = require "xerath/menu"

local input = pred.PredInputCirclePrompt()
input.effect_radius = 125
input.cast_time = 0.75
input.add_target_bbox = false
input.target_range = 990

local result = pred.PredResult()
local eval = pred.PredEval()

local check_target_prediction = function(obj)
    pred:CirclePrompt(input, obj, result)
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
    pred:EvalCirclePrompt(input, result, obj, eval)
    if eval.is_higher_hitchance then
        print("high w2")
        return true
    end
    if eval.target_just_changed_path then
        return true
    end
    if eval.distance < 250 then
        return true
    end
    return false
end

local get_action_state = function()
    if player:CanCastSpell(SpellSlot_W) then
        local obj = find_target()
        if obj then
            return eval_target_prediction(obj)
        end
    end
    return false
end

local invoke_action = function()
    return player:CastSpellPos(SpellSlot_W, result.pos)
end

return {
    get_action_state = get_action_state,
    invoke_action = invoke_action,
}