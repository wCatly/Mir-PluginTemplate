local pred = loadscript("free-pred")

local targeting = require "targeting"
local menu = require "xerath/menu"

local input = pred.PredInputLine()
input.width = 70
input.cast_time = 0.25
input.speed = 1400
input.add_target_bbox = true
input.target_range = 1000

local result = pred.PredResult()
local eval = pred.PredEval()
local collision_flags = pred.lib.CollisionFlags_EnemyLaneMinions

local check_target_prediction = function(obj)
    pred:Line(input, obj, result)
    if not result.is_in_target_range then
        return false
    end
    return not pred:Collision(input, result, obj, collision_flags)
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
    pred:EvalLine(input, result, obj, eval)
    if eval.is_higher_hitchance then
        print("high e")
        return true
    end
    if eval.distance < 700 then
        if eval.target_just_changed_path then
            return true
        end
    end
    return false
end

local get_action_state = function()
    if player:CanCastSpell(SpellSlot_E) then
        local obj = find_target()
        if obj then
            return eval_target_prediction(obj)
        end
    end
    return false
end

local invoke_action = function()
    return player:CastSpellPos(SpellSlot_E, result.pos)
end

return {
    get_action_state = get_action_state,
    invoke_action = invoke_action,
}