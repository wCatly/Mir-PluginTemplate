local pred = loadscript("free-pred")

local targeting = require "targeting"
local menu = require "xerath/menu"
local r_buff = require "xerath/r_buff"

local input = pred.PredInputCirclePrompt()
input.effect_radius = 200
input.cast_time = 0.6
input.add_target_bbox = false
input.target_range = 5000

local result = pred.PredResult()
local eval = pred.PredEval()

local is_near_mouse = function(obj)
    return obj:Pos():DistSqr(game:MousePos()) < 1000 * 1000
end

local check_target_prediction = function(obj)
    pred:CirclePrompt(input, obj, result)
    return result.is_in_target_range
end

local find_target = function()
    local vec = object_manager:EnemyHeroes()
    targeting.sort(vec)
    for i, obj in ipairs(vec) do
        if obj:IsTargetable() and is_near_mouse(obj) then
            if check_target_prediction(obj) then
                return obj
            end
        end
    end
end

local eval_target_prediction = function(obj)
    pred:EvalCirclePrompt(input, result, obj, eval)
    if eval.is_higher_hitchance then
        print("high r")
        return true
    end
    if eval.target_just_changed_path then
        print("high r")
        return true
    end
    return false
end

local get_action_target = function()
    if not r_buff.get() then
        return nil
    end
    if player:CanCastSpell(SpellSlot_R) then
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
    print("cast r", game:Time())
    return player:CastSpellPos(SpellSlot_R, result.pos)
end

return {
    get_action_target = get_action_target,
    get_action_state = get_action_state,
    invoke_action = invoke_action,
}