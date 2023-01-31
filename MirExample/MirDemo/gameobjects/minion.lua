
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

local get_selected_target_as_minion = function()
    local obj = game:SelectedTarget()
    return obj and obj:IsMinion() and obj:AsMinion()
end

local botm_draw_menu = function(p_open)
    local obj = get_selected_target_as_minion()

    if ig.Begin("Demo: Minion", p_open) then
        if obj then
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
            format_value("Minion:", obj)
            format_value("\towner()", obj:Owner())
            format_value("\tis_lane_minion()", obj:IsLaneMinion())
            format_value("\tis_melee_minion()", obj:IsMeleeMinion())
            format_value("\tis_ranged_minion()", obj:IsRangedMinion())
            format_value("\tis_siege_minion()", obj:IsSiegeMinion())
            format_value("\tis_super_minion()", obj:IsSuperMinion())
            format_value("\tis_monster()", obj:IsMonster())
            format_value("\tis_camp_monster()", obj:IsCampMonster())
            format_value("\tis_medium_monster()", obj:IsMediumMonster())
            format_value("\tis_large_monster()", obj:IsLargeMonster())
            format_value("\tis_epic_monster()", obj:IsEpicMonster())
            format_value("\tis_wolf()", obj:IsWolf())
            format_value("\tis_gromp()", obj:IsGromp())
            format_value("\tis_raptor()", obj:IsRaptor())
            format_value("\tis_krug()", obj:IsKrug())
            format_value("\tis_buff()", obj:IsBuff())
            format_value("\tis_blue()", obj:IsBlue())
            format_value("\tis_red()", obj:IsRed())
            format_value("\tis_crab()", obj:IsCrab())
            format_value("\tis_dragon()", obj:IsDragon())
            format_value("\tis_special_void_minion()", obj:IsSpecialVoidMinion())
            format_value("\tis_herald()", obj:IsHerald())
            format_value("\tis_baron()", obj:IsBaron())
            format_value("\tis_ward()", obj:IsWard())
            format_value("\tis_special_minion()", obj:IsSpecialMinion())
            format_value("\tis_plant()", obj:IsPlant())
            format_value("\tis_trap()", obj:IsTrap())
            format_value("\tis_summon()", obj:IsSummon())
            format_value("\tis_large_summon()", obj:IsLargeSummon())

            if open_game_object[0] then
                game_object.draw_menu(obj, "Minion", open_game_object)
            end
            if open_attackable_unit[0] then
                attackable_unit.draw_menu(obj, "Minion", open_attackable_unit)
            end
            if open_ai_client[0] then
                ai_client.draw_menu(obj, "Minion", open_ai_client)
            end
            if open_character_record[0] then
                character_record.draw_menu(obj, open_character_record)
            end
            if open_path[0] then
                path.draw_menu(obj, open_path)
            end
            if open_buffs[0] then
                buffs.draw_menu(obj, open_buffs)
            end
            if open_floating_info_bar[0] then
                floating_info_bar.draw_menu(obj, open_floating_info_bar)
            end
            if open_spell_slots[0] then
                spell_slots.draw_menu(obj, open_spell_slots)
            end
            if open_spell_calculations[0] then
                spell_calculations.draw_menu(obj, open_spell_calculations)
            end
            if open_spell_data_resources[0] then
                spell_data_resources.draw_menu(obj, open_spell_data_resources)
            end
        else
            ig.Text("No Minion Selected")
        end
    end
    ig.End()
end

local botm_draw = function()
    local obj = get_selected_target_as_minion()
    if not obj then
        return
    end
    if open_ai_client[0] then
        ai_client.draw(obj)
    end
    if open_path[0] then
        path.draw(obj, open_path)
    end
    if open_floating_info_bar[0] then
        floating_info_bar.draw(obj, open_floating_info_bar)
    end
    if open_spell_slots[0] then
        spell_slots.draw(obj, open_spell_slots)
    end
end

return {
    botm_draw_menu = botm_draw_menu,
    botm_draw = botm_draw,
}