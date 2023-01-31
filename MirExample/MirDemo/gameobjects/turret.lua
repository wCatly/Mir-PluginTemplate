
local ffi = require "ffi"

local demo_h = require "demo_h"
local format_value = demo_h.format_value

local game_object = require "gameobjects/api_game_object"
local attackable_unit = require "gameobjects/api_attackable_unit"
local ai_client = require "gameobjects/api_ai_client"
local character_record = require "gameobjects/character_record"
local path = require "gameobjects/path"
local buffs = require "gameobjects/buffs"
local floating_info_bar = require "gameobjects/floating_info_bar"
local spell_slots = require "gameobjects/spell_slots"
local spell_calculations = require "gameobjects/spell_calculations"
local spell_data_resources = require "gameobjects/spell_data_resources"

local open_game_object = ffi.new("bool[1]")
local open_attackable_unit = ffi.new("bool[1]")
local open_ai_client = ffi.new("bool[1]")
local open_character_record = ffi.new("bool[1]")
local open_path = ffi.new("bool[1]")
local open_buffs = ffi.new("bool[1]")
local open_floating_info_bar = ffi.new("bool[1]")
local open_spell_slots = ffi.new("bool[1]")
local open_spell_calculations = ffi.new("bool[1]")
local open_spell_data_resources = ffi.new("bool[1]")

local turret_index = ffi.new("int[1]")
turret_index[0] = 0

local turret

local get_selected_target_as_turret = function()
    local obj = game:SelectedTarget()
    return obj and obj:IsTurret() and obj:AsTurret()
end

local botm_draw_menu = function(p_open)
    if ig.Begin("Demo: Turret", p_open) then

        turret = get_selected_target_as_turret()
        
        if not turret then
            local turrets = object_manager:Turrets()
            ig.SliderInt("##SliderTurret", turret_index, 0, turrets.n - 1, "turret[%d]", 0)
            turret = turrets.n > 0 and turrets.val[turret_index[0]]
            ig.NewLine()
        end

        if turret then
            ig.Checkbox("GameObject interface", open_game_object)
            ig.Checkbox("AttackableUnit interface", open_attackable_unit)
            ig.Checkbox("AIClient interface", open_ai_client)
            ig.NewLine()
            ig.Checkbox("CharacterRecord", open_character_record)
            ig.Checkbox("Path", open_path)
            ig.Checkbox("Buffs", open_buffs)
            ig.Checkbox("FloatingInfoBar", open_floating_info_bar)
            ig.Checkbox("SpellSlots", open_spell_slots)
            ig.Checkbox("SpellCalculations", open_spell_calculations)
            ig.Checkbox("SpellDataResources", open_spell_data_resources)
            ig.NewLine()
            format_value("Turret:", turret)
            format_value("\tis_outer_turret()", turret:IsOuterTurret())
            format_value("\tis_inner_turret()", turret:IsInnerTurret())
            format_value("\tis_inhib_turret()", turret:IsInhibTurret())
            format_value("\tis_nexus_turret()", turret:IsNexusTurret())
            format_value("\tis_shrine()", turret:IsShrine())
        end
    end
    ig.End()

    if open_game_object[0] then
        game_object.draw_menu(turret, "Turret", open_game_object)
    end
    if open_attackable_unit[0] then
        attackable_unit.draw_menu(turret, "Turret", open_attackable_unit)
    end
    if open_ai_client[0] then
        ai_client.draw_menu(turret, "Turret", open_ai_client)
    end
    if open_character_record[0] then
        character_record.draw_menu(turret, open_character_record)
    end
    if open_path[0] then
        path.draw_menu(turret, open_path)
    end
    if open_buffs[0] then
        buffs.draw_menu(turret, open_buffs)
    end
    if open_floating_info_bar[0] then
        floating_info_bar.draw_menu(turret, open_floating_info_bar)
    end
    if open_spell_slots[0] then
        spell_slots.draw_menu(turret, open_spell_slots)
    end
    if open_spell_calculations[0] then
        spell_calculations.draw_menu(turret, open_spell_calculations)
    end
    if open_spell_data_resources[0] then
        spell_data_resources.draw_menu(turret, open_spell_data_resources)
    end
end

local botm_draw = function()
    if not turret then
        return
    end
    if open_ai_client[0] then
        ai_client.draw(turret)
    end
    if open_path[0] then
        path.draw(turret, open_path)
    end
    if open_floating_info_bar[0] then
        floating_info_bar.draw(turret, open_floating_info_bar)
    end
    if open_spell_slots[0] then
        spell_slots.draw(turret, open_spell_slots)
    end
end

return {
    botm_draw_menu = botm_draw_menu,
    botm_draw = botm_draw,
}