
local ffi = require "ffi"

local demo_h = require "demo_h"
local format_value = demo_h.format_value

local game_object = require "gameobjects/api_game_object"
local attackable_unit = require "gameobjects/api_attackable_unit"
local ai_client = require "gameobjects/api_ai_client"
local hero = require "gameobjects/api_hero"
local character_record = require "gameobjects/character_record"
local path = require "gameobjects/path"
local buffs = require "gameobjects/buffs"
local floating_info_bar = require "gameobjects/floating_info_bar"
local spell_slots = require "gameobjects/spell_slots"
local spell_calculations = require "gameobjects/spell_calculations"
local spell_data_resources = require "gameobjects/spell_data_resources"
local runes = require "gameobjects/runes"
local item_slots = require "gameobjects/item_slots"

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
local open_runes = ffi.new("bool[1]")
local open_item_slots = ffi.new("bool[1]")

local hero_index = ffi.new("int[1]")
hero_index[0] = 0

local obj

local get_selected_target_as_hero = function()
    local obj = game:SelectedTarget()
    return obj and obj:IsHero() and obj:AsHero()
end

local botm_draw_menu = function(p_open)
    obj = get_selected_target_as_hero()

    if ig.Begin("Demo: Hero", p_open) then
        
        if not obj then
            local heroes = object_manager:Heroes()
            ig.SliderInt("##HeroSlider", hero_index, 0, heroes.n - 1, "hero[%d]", 0)
            if hero_index[0] >= heroes.n then
                hero_index[0] = 0
            end
            obj = heroes.n > 0 and heroes.val[hero_index[0]]
        else
            ig.Text("Showing selected Hero")
        end

        if obj then
            ig.NewLine()
            ig.Checkbox("GameObject interface", open_game_object)
            ig.Checkbox("AttackableUnit interface", open_attackable_unit)
            ig.Checkbox("AIClient interface", open_ai_client)
            ig.NewLine()
            ig.Checkbox("CharacterRecord", open_character_record)
            ig.Checkbox("Buffs", open_buffs)
            ig.Checkbox("Path", open_path)
            ig.Checkbox("FloatingInfoBar", open_floating_info_bar)
            ig.Checkbox("SpellSlots", open_spell_slots)
            ig.Checkbox("SpellCalculations", open_spell_calculations)
            ig.Checkbox("SpellDataResources", open_spell_data_resources)
            ig.Checkbox("Runes", open_runes)
            ig.Checkbox("ItemSlots", open_item_slots)
            ig.NewLine()
            hero.draw_menu(obj, "Hero", p_open)
        end
    end
    ig.End()

    if open_game_object[0] then
        game_object.draw_menu(obj, "Hero", open_game_object)
    end
    if open_attackable_unit[0] then
        attackable_unit.draw_menu(obj, "Hero", open_attackable_unit)
    end
    if open_ai_client[0] then
        ai_client.draw_menu(obj, "Hero", open_ai_client)
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
    if open_runes[0] then
        runes.draw_menu(obj, open_runes)
    end
    if open_item_slots[0] then
        item_slots.draw_menu(obj, open_item_slots)
    end
end

local botm_draw = function()
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
    if open_runes[0] then
        runes.draw(obj, open_runes)
    end
    if open_item_slots[0] then
        item_slots.draw(obj, open_item_slots)
    end
end

return {
    botm_draw_menu = botm_draw_menu,
    botm_draw = botm_draw,
}