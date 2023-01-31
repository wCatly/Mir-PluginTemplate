
local ffi = require "ffi"

local demo_h = require "demo_h"
local format_value = demo_h.format_value

local game_object = require "gameobjects/api_game_object"
local attackable_unit = require "gameobjects/api_attackable_unit"

local open_game_object = ffi.new("bool[1]")
local open_attackable_unit = ffi.new("bool[1]")

local nexus_index = ffi.new("int[1]")
nexus_index[0] = 0

local get_selected_target_as_nexus = function()
    local obj = game:SelectedTarget()
    return obj and obj:IsNexus() and obj:AsNexus()
end

local botm_draw_menu = function(p_open)
    local obj

    if ig.Begin("Demo: Nexus", p_open) then
        obj = get_selected_target_as_nexus()
        
        if not obj then
            local nexus = object_manager:Nexus()
            ig.SliderInt("##SliderNexus", nexus_index, 0, nexus.n - 1, "nexus[%d]", 0)
            obj = nexus.n > 0 and nexus.val[nexus_index[0]]
            ig.NewLine()
        end

        if obj then
            ig.Checkbox("GameObject interface", open_game_object)
            ig.Checkbox("AttackableUnit interface", open_attackable_unit)
            ig.NewLine()
            format_value("Nexus:", obj)
        end
    end
    ig.End()

    if open_game_object[0] then
        game_object.draw_menu(obj, "Nexus", open_game_object)
    end
    if open_attackable_unit[0] then
        attackable_unit.draw_menu(obj, "Nexus", open_attackable_unit)
    end
end

return {
    botm_draw_menu = botm_draw_menu,
}