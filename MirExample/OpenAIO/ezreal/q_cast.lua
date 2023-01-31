local orb = loadscript("free-orbwalker")
local pred = loadscript("free-pred")

local targeting = require "targeting"
local menu = require "ezreal/menu"

local input = pred.PredInputLine()
input.width = 60
input.cast_time = 0.25
input.speed = 2000
input.add_target_bbox = true
input.target_range = 1150

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
    if orb:IsTickAfterWindUpTime() then
        return true
    end

    pred:EvalLine(input, result, obj, eval)
    if eval.is_higher_hitchance then
        return true
    end
    if eval.target_just_changed_path then
        return true
    end
    if eval.distance < 500 then
        return true
    end
    return false
end

local get_action_state = function()
    if player:CanCastSpell(SpellSlot_Q) then
        local obj = find_target()
        if obj then
            return eval_target_prediction(obj)
        end
    end
    return false
end

local invoke_action = function()
    return player:CastSpellPos(SpellSlot_Q, result.pos)
end

local debug = function()
    local target = find_target()
    if not target then
        -- find potential next target if no target is found
        -- target range is increased and collision disabled
        local target_range = input.target_range
        local flags = collision_flags
        input.target_range = 2000
        collision_flags = pred.lib.CollisionFlags_None

        target = find_target()

        input.target_range = target_range
        collision_flags = flags
    end

    if target then
        pred:EnableDebug()

        pred:Line(input, target, result)
        pred:Collision(input, result, target, collision_flags)
        pred:EvalLine(input, result, target, eval)

        pred:DisableDebug()
    end
end

return {
    get_action_state = get_action_state,
    invoke_action = invoke_action,

    debug = debug,
}