
local ffi = require "ffi"

local demo_h = require "demo_h"
local format_value = demo_h.format_value

local game_object = require "gameobjects/api_game_object"
local attackable_unit = require "gameobjects/api_attackable_unit"
local ai_client = require "gameobjects/api_ai_client"
local hero = require "gameobjects/api_hero"
local character_data = require "gameobjects/character_data"
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
local open_character_data = ffi.new("bool[1]")
local open_character_record = ffi.new("bool[1]")
local open_hero = ffi.new("bool[1]")
local open_path = ffi.new("bool[1]")
local open_buffs = ffi.new("bool[1]")
local open_floating_info_bar = ffi.new("bool[1]")
local open_spell_slots = ffi.new("bool[1]")
local open_spell_calculations = ffi.new("bool[1]")
local open_spell_data_resources = ffi.new("bool[1]")
local open_runes = ffi.new("bool[1]")
local open_item_slots = ffi.new("bool[1]")

local move_to_mouse = function()
    if player:CanMove() then
        if player:Move(game:MousePos()) then
            print("Moving to Mouse")
        end
    end
end

local attack_selected_minion = function()
    local target = game:SelectedTarget()
    if target and target:IsMinion() then
        if player:CanAttack() then
            if player:Attack(target:AsAttackableUnit()) then
                print("Attacking selected Minion")
            end
        end
    end
end

local cast_q_to_mouse = function()
    if player:SpellCastIsReady(SpellSlot_Q) then
        if player:CastSpellPos(SpellSlot_Q, game:MousePos()) then
            print("Casting Q to Mouse")
        end
    end
end

local botm_draw_menu = function(p_open)
    local obj = player

    if ig.Begin("Demo: Player", p_open) then
        if ig.TreeNode("Enum SpellCastStatusFlags") then
            format_value("\tSpellCastStatusFlags_Ready", SpellCastStatusFlags_Ready)
            format_value("\tSpellCastStatusFlags_NotAvailable", SpellCastStatusFlags_NotAvailable)
            format_value("\tSpellCastStatusFlags_NotLearned", SpellCastStatusFlags_NotLearned)
            format_value("\tSpellCastStatusFlags_Disabled", SpellCastStatusFlags_Disabled)
            format_value("\tSpellCastStatusFlags_Supressed", SpellCastStatusFlags_Supressed)
            format_value("\tSpellCastStatusFlags_Cooldown", SpellCastStatusFlags_Cooldown)
            format_value("\tSpellCastStatusFlags_OutOfMana", SpellCastStatusFlags_OutOfMana)
            ig.TreePop()
        end
        ig.NewLine()

        if obj then
            ig.NewLine()
            ig.Checkbox("GameObject interface", open_game_object)
            ig.Checkbox("AttackableUnit interface", open_attackable_unit)
            ig.Checkbox("AIClient interface", open_ai_client)
            ig.Checkbox("Hero interface", open_hero)
            ig.NewLine()
            ig.Checkbox("CharacterData", open_character_data)
            ig.Checkbox("CharacterRecord", open_character_record)
            ig.Checkbox("Path", open_path)
            ig.Checkbox("Buffs", open_buffs)
            ig.Checkbox("FloatingInfoBar", open_floating_info_bar)
            ig.Checkbox("SpellSlots", open_spell_slots)
            ig.Checkbox("SpellCalculations", open_spell_calculations)
            ig.Checkbox("SpellDataResources", open_spell_data_resources)
            ig.Checkbox("Runes", open_runes)
            ig.Checkbox("ItemSlots", open_item_slots)
            ig.NewLine()
            format_value("Player:", obj)
            format_value("\tgold()", obj:Gold())
            format_value("\ttotal_gold()", obj:TotalGold())
            format_value("\tis_following_target()", obj:IsFollowingTarget())
            format_value("\tfollow_target()", obj:FollowTarget())
            ig.NewLine()
            if ig.TreeNode("Show CastSpell functions") then
                format_value("\tcast_spell(SpellSlotEnum slot)", "[Ahri W]")
                format_value("\tcast_spell_target(SpellSlotEnum slot, AttackableUnit *target)", "[MasterYi Q]")
                format_value("\tcast_spell_pos(SpellSlotEnum slot, float3 pos)", "[Ezreal Q]")
                format_value("\tcast_spell_line(SpellSlotEnum slot, float3 from, float3 to)", "[Viktor E]")
                format_value("\trelease_spell(SpellSlotEnum slot, float3 pos)", "[Xerath Release Q]")
                ig.NewLine()
                format_value("\tspell_cast_status(SpellSlot_Q)", player:SpellCastStatus(SpellSlot_Q))
                format_value("\tspell_cast_is_ready(SpellSlot_Q)", player:SpellCastIsReady(SpellSlot_Q))
                format_value("\tspell_cast_is_not_available(SpellSlot_Q)", player:SpellCastIsNotAvailable(SpellSlot_Q))
                format_value("\tspell_cast_is_not_learned(SpellSlot_Q)", player:SpellCastIsNotLearned(SpellSlot_Q))
                format_value("\tspell_cast_is_disabled(SpellSlot_Q)", player:SpellCastIsDisabled(SpellSlot_Q))
                format_value("\tspell_cast_is_supressed(SpellSlot_Q)", player:SpellCastIsSupressed(SpellSlot_Q))
                format_value("\tspell_cast_is_on_cooldown(SpellSlot_Q)", player:SpellCastIsOnCooldown(SpellSlot_Q))
                format_value("\tspell_cast_is_out_of_mana(SpellSlot_Q)", player:SpellCastIsOutOfMana(SpellSlot_Q))
                format_value("\tis_cast_spell_limited(SpellSlot_Q)", player:IsCastSpellLimited(SpellSlot_Q))
                format_value("\tis_release_spell_limited(SpellSlot_Q)", player:IsReleaseSpellLimited(SpellSlot_Q))
                format_value("\tcan_cast_spell(SpellSlot_Q)", player:CanCastSpell(SpellSlot_Q))
                ig.TreePop()
            end    
            if ig.TreeNode("Show Move/Attack functions") then
                format_value("\tmove(float3 pos)", " ")
                format_value("\thold_position()", " ")
                format_value("\tstop()", " ")
                format_value("\tattack_move(float3 pos)", " ")
                format_value("\tattack(AttackableUnit *target)", " ")
                format_value("\tpet_move(float3 pos)", " ")
                format_value("\tpet_attack(AttackableUnit *target)", " ")
                ig.NewLine()
                format_value("\tis_move_limited()", player:IsMoveLimited())
                format_value("\tis_attack_limited()", player:IsAttackLimited())
                format_value("\tcan_move()", player:CanMove())
                format_value("\tcan_attack()", player:CanAttack())
                ig.TreePop()
            end

            ig.NewLine()

            if ig.MenuItem("Move to Mouse", "1") then
                move_to_mouse()
            end
            if ig.MenuItem("Attack selected Minion", "2") then
                attack_selected_minion()
            end
            if ig.MenuItem("Cast Q to Mouse", "3") then
                cast_q_to_mouse()
            end

        end
    end
    ig.End()

    if open_game_object[0] then
        game_object.draw_menu(obj, "Player", open_game_object)
    end
    if open_attackable_unit[0] then
        attackable_unit.draw_menu(obj, "Player", open_attackable_unit)
    end
    if open_ai_client[0] then
        ai_client.draw_menu(obj, "Player", open_ai_client)
    end
    if open_hero[0] then
        hero.draw_menu(obj, "Player", open_hero)
    end
    if open_character_data[0] then
        character_data.draw_menu(obj, open_character_data)
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
    if open_ai_client[0] then
        ai_client.draw(player)
    end
    if open_path[0] then
        path.draw(player, open_path)
    end
    if open_floating_info_bar[0] then
        floating_info_bar.draw(player, open_floating_info_bar)
    end
    if open_spell_slots[0] then
        spell_slots.draw(player, open_spell_slots)
    end
    if open_runes[0] then
        runes.draw(player, open_runes)
    end
    if open_item_slots[0] then
        item_slots.draw(player, open_item_slots)
    end
end

local botm_key_down = function(vk_code)
    if vk_code == 49 then --[1]
        move_to_mouse()
    elseif vk_code == 50 then --[2]
        attack_selected_minion()
    elseif vk_code == 51 then --[3]
        cast_q_to_mouse()
    end
end

return {
    botm_draw_menu = botm_draw_menu,
    botm_draw = botm_draw,
    botm_key_down = botm_key_down,
}