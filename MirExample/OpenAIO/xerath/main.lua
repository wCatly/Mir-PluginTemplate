local orb = loadscript("free-orbwalker")

local action_lock = require "action_lock"
local targeting = require "targeting"

local menu = require "xerath/menu"

local q_buff = require "xerath/q_buff"
local q_charge = require "xerath/q_charge"
local q_release = require "xerath/q_release"
local q_short = require "xerath/q_short"
local q_draw = require "xerath/q_draw"

local w_inner = require "xerath/w_inner"
local w_outer = require "xerath/w_outer"

local e_cast = require "xerath/e_cast"

local r_buff = require "xerath/r_buff"
local r_cast = require "xerath/r_cast"
local r_draw = require "xerath/r_draw"

local combo = function()
    if r_cast.get_action_state() then
        if r_cast.invoke_action() then
            action_lock.set_lock_await_response()
            return true
        end
    end

    local orb_can_move = orb:CanMove()

    if orb_can_move or menu.allow_e_cancel_aa[0] then
        if e_cast.get_action_state() then
            if e_cast.invoke_action() then
                action_lock.set_lock_await_response()
                return true
            end
        end
    end
    if orb_can_move then
        if w_inner.get_action_state() then
            if w_inner.invoke_action() then
                action_lock.set_lock_await_response()
                return true
            end
        end
        if w_outer.get_action_state() then
            if w_outer.invoke_action() then
                action_lock.set_lock_await_response()
                return true
            end
        end
        if q_release.get_action_state() then
            if q_release.invoke_action() then
                action_lock.set_lock_await_response()
                return true
            end
        end
        if q_short.get_action_state() then
            if q_short.invoke_action() then
                action_lock.set_lock_await_response()
                return true
            end
        end
        if q_charge.get_action_state() then
            if q_charge.invoke_action() then
                action_lock.set_lock_await_response()
                return true
            end
        end
    end
    return false
end

local harass = function()
    if not orb:CanMove() then
        return
    end

    if menu.harass_use_w[0] then
        if w_inner.get_action_state() then
            if w_inner.invoke_action() then
                action_lock.set_lock_await_response()
                return true
            end
        end
        if w_outer.get_action_state() then
            if w_outer.invoke_action() then
                action_lock.set_lock_await_response()
                return true
            end
        end
    end
    if q_release.get_action_state() then
        if q_release.invoke_action() then
            action_lock.set_lock_await_response()
            return true
        end
    end
    if q_short.get_action_state() then
        if q_short.invoke_action() then
            action_lock.set_lock_await_response()
            return true
        end
    end
    if q_charge.get_action_state() then
        if q_charge.invoke_action() then
            action_lock.set_lock_await_response()
            return true
        end
    end
    return false
end

local load = function(env)
    menu.load()
end

local tick = function()
    if action_lock.is_locked() then
        orb:SetNextAllowMove(false)
        orb:SetNextAllowAttack(false)
        return
    end

    if q_buff.get() then
        orb:SetNextAllowAttack(false)
    end

    if r_buff.get() then
        orb:SetNextAllowMove(false)
        orb:SetNextAllowAttack(false)
    end

    if menu.combat_key:IsPressed() then
        if combo() then
            return
        end
    end

    if menu.harass_key:IsPressed() then
        if harass() then
            return
        end
    end
end

local draw = function()
    q_draw.on_draw()
    r_draw.on_draw()
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