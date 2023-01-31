
local ffi = require "ffi"

local demo_h = require "demo_h"
local format_value = demo_h.format_value

local game_object = require "gameobjects/api_game_object"
local attackable_unit = require "gameobjects/api_attackable_unit"

local open_game_object = ffi.new("bool[1]")
local open_attackable_unit = ffi.new("bool[1]")

local inhib_index = ffi.new("int[1]")
inhib_index[0] = 0

local get_selected_target_as_inhib = function()
    local obj = game:SelectedTarget()
    return obj and obj:IsInhib() and obj:AsInhib()
end


local botm_draw_menu = function(p_open)
    local obj

    if ig.Begin("Demo: Inhib", p_open) then
        obj = get_selected_target_as_inhib()
        
        if not obj then
            local inhibs = object_manager:Inhibs()
            ig.SliderInt("##SliderInhib", inhib_index, 0, inhibs.n - 1, "inhib[%d]", 0)
            obj = inhibs.n > 0 and inhibs.val[inhib_index[0]]
            ig.NewLine()
        end

        if obj then
            ig.Checkbox("GameObject interface", open_game_object)
            ig.Checkbox("AttackableUnit interface", open_attackable_unit)
            ig.NewLine()
            format_value("Inhib:", obj)
            format_value("\trespawn_timer()", obj:RespawnTimer())
        end
    end
    ig.End()

    if open_game_object[0] then
        game_object.draw_menu(obj, "Inhib", open_game_object)
    end
    if open_attackable_unit[0] then
        attackable_unit.draw_menu(obj, "Inhib", open_attackable_unit)
    end
end

return {
    botm_draw_menu = botm_draw_menu,
}