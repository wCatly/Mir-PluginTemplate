local orb = loadscript("free-orbwalker")

local action_lock = require "action_lock"
local targeting = require "targeting"

local menu = require "ezreal/menu"
local q_cast = require "ezreal/q_cast"
local w_cast = require "ezreal/w_cast"

local combo = function()
    if not orb:CanMove() then
        return
    end

    if orb:GetEffectiveTarget() == nil then
        if q_cast.get_action_state() then
            if q_cast.invoke_action() then
                action_lock.set_lock_await_response()
                return true
            end
        end
        if not menu.w_only_after_aa[0] then
            if w_cast.get_action_state() then
                if w_cast.invoke_action() then
                    action_lock.set_lock_await_response()
                    return true
                end
            end
        end
    end

    if orb:IsTickAfterWindUpTime() then
        if q_cast.get_action_state() then
            if q_cast.invoke_action() then
                action_lock.set_lock_await_response()
                return true
            end
        end
        if w_cast.get_action_state() then
            if w_cast.invoke_action() then
                action_lock.set_lock_await_response()
                return true
            end
        end
    end

    return false
end

local load = function()
    menu.load()
end

local tick = function()
    if action_lock.is_locked() then
        orb:SetNextAllowMove(false)
        orb:SetNextAllowAttack(false)
        return
    end

    if menu.combat_key:IsPressed() then
        if combo() then
            return
        end
    end
end

local draw = function()
    if menu.debug_q[0] then
        q_cast.debug()
    end
end

local draw_menu = function()
    menu.draw_menu()
end

local request_save_settings = function()
    menu.save_ini()
end

local process_spell = function(spell)

end

return {
    load = load,
    tick = tick,
    draw = draw,
    draw_menu = draw_menu,
    request_save_settings = request_save_settings,
    process_spell = process_spell,
}


