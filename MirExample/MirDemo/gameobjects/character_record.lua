
local ffi = require "ffi"

local demo_h = require "demo_h"
local format_value = demo_h.format_value
local format_opt_value = demo_h.format_opt_value
local format_opt_float3 = demo_h.format_opt_float3

local format_attack_slot_data = function(data, tab)
    format_opt_value(tab.."attack_total_time", data:AttackTotalTime())
    format_opt_value(tab.."attack_cast_time", data:AttackCastTime())
    format_opt_value(tab.."attack_delay_cast_offset_percent", data:AttackDelayCastOffsetPercent())
    format_opt_value(tab.."attack_delay_cast_offset_percent_attack_speed_ratio", data:AttackDelayCastOffsetPercentAttackSpeedRatio())
    format_opt_value(tab.."attack_probability", data:AttackProbability())
    format_opt_value(tab.."attack_name", data:AttackName())
end

local draw_menu = function(aiclient, p_open)

    if ig.Begin("Demo: CharacterRecord", p_open) then
        local record = aiclient:CharacterRecord()

        format_value("CharacterRecord:", record)
        format_value("\tmemory_address()", record:MemoryAddress(), "0x%x")
        format_value("\tcharacter_name()", record:CharacterName())
        format_opt_value("\tfallback_character_name()", record:FallbackCharacterName())
        format_value("\tbase_hp()", record:BaseHp())
        format_value("\thp_per_level()", record:HpPerLevel())
        format_value("\tbase_static_hp_regen()", record:BaseStaticHpRegen())
        format_value("\tbase_factor_hp_regen()", record:BaseFactorHpRegen())
        format_value("\thealth_bar_height()", record:HealthBarHeight())
        format_value("\thealth_bar_full_parallax()", record:HealthBarFullParallax())
        format_opt_value("\tself_champ_specific_health_suffix()", record:SelfChampSpecificHealthSuffix())
        format_opt_value("\tself_cb_champ_specific_health_suffix()", record:SelfCbChampSpecificHealthSuffix())
        format_opt_value("\tally_champ_specific_health_suffix()", record:AllyChampSpecificHealthSuffix())
        format_opt_value("\tenemy_champ_specific_health_suffix()", record:EnemyChampSpecificHealthSuffix())
        format_value("\thighlight_healthbar_icons()", record:HighlightHealthbarIcons())
        format_value("\tbase_damage()", record:BaseDamage())
        format_value("\tdamage_per_level()", record:DamagePerLevel())
        format_value("\tbase_armor()", record:BaseArmor())
        format_value("\tarmor_per_level()", record:ArmorPerLevel())
        format_value("\tbase_spell_block()", record:BaseSpellBlock())
        format_value("\tbase_dodge()", record:BaseDodge())
        format_value("\tdodge_per_level()", record:DodgePerLevel())
        format_value("\tbase_miss_chance()", record:BaseMissChance())
        format_value("\tbase_crit_chance()", record:BaseCritChance())
        format_value("\tcrit_damage_multiplier()", record:CritDamageMultiplier())
        format_value("\tcrit_per_level()", record:CritPerLevel())
        format_value("\tbase_move_speed()", record:BaseMoveSpeed())
        format_value("\tattack_range()", record:AttackRange())
        format_value("\tattack_speed()", record:AttackSpeed())
        format_value("\tattack_speed_ratio()", record:AttackSpeedRatio())
        format_value("\tattack_speed_per_level()", record:AttackSpeedPerLevel())
        format_value("\tability_power_inc_per_level()", record:AbilityPowerIncPerLevel())
        format_value("\tadaptive_force_to_ability_power_weight()", record:AdaptiveForceToAbilityPowerWeight())
        format_value("\tbasic_attack()", record:BasicAttack())
        format_attack_slot_data(record:BasicAttack(), "\t\t")
        
        format_value("\textra_attacks()", record:ExtraAttacks())
        local vec = record:ExtraAttacks()
        for i = 0, vec.n - 1 do
            format_value("\t\tval["..i.."]", vec.val[i])
            format_attack_slot_data(vec.val[i], "\t\t\t")
        end

        format_value("\tcrit_attacks()", record:CritAttacks())
        local vec = record:CritAttacks()
        for i = 0, vec.n - 1 do
            format_value("\t\tval["..i.."]", vec.val[i])
            format_attack_slot_data(vec.val[i], "\t\t\t")
        end

        format_value("\tattack_auto_interrupt_percent()", record:AttackAutoInterruptPercent())
        format_value("\tacquisition_range()", record:AcquisitionRange())
        format_opt_value("\twake_up_range()", record:WakeUpRange())
        format_opt_value("\tfirst_acquisition_range()", record:FirstAcquisitionRange())
        format_value("\ttower_targeting_priority_boost()", record:TowerTargetingPriorityBoost())
        format_value("\texp_given_on_death()", record:ExpGivenOnDeath())
        format_value("\tgold_given_on_death()", record:GoldGivenOnDeath())
        format_value("\tgold_radius()", record:GoldRadius())
        format_value("\texperience_radius()", record:ExperienceRadius())
        format_value("\tdeath_botm_listening_radius()", record:DeathEventListeningRadius())
        format_value("\tlocal_gold_given_on_death()", record:LocalGoldGivenOnDeath())
        format_value("\tlocal_exp_given_on_death()", record:LocalExpGivenOnDeath())
        format_value("\tlocal_gold_split_with_last_hitter()", record:LocalGoldSplitWithLastHitter())
        format_value("\tglobal_gold_given_on_death()", record:GlobalGoldGivenOnDeath())
        format_value("\tglobal_exp_given_on_death()", record:GlobalExpGivenOnDeath())
        format_opt_value("\tperception_bubble_radius()", record:PerceptionBubbleRadius())
        format_opt_float3("\tperception_bounding_box_size()", record:PerceptionBoundingBoxSize())
        format_value("\tsignificance()", record:Significance())
        format_value("\tuntargetable_spawn_time()", record:UntargetableSpawnTime())
        format_value("\tability_power()", record:AbilityPower())
        format_value("\ton_kill_event()", record:OnKillEvent(), "0x%x")
        format_value("\ton_kill_botm_steal()", record:OnKillEventSteal(), "0x%x")
        format_value("\ton_kill_botm_for_spectator()", record:OnKillEventForSpectator(), "0x%x")
        format_value("\tcritical_attack()", record:CriticalAttack())
        format_value("\tpassive_name()", record:PassiveName())
        format_opt_value("\tpassive_lua_name()", record:PassiveLuaName())
        format_value("\tpassive_tool_tip()", record:PassiveToolTip())
        format_opt_value("\tpassive_spell()", record:PassiveSpell())
        format_value("\tpassive_range()", record:PassiveRange())
        format_opt_value("\ticon_name()", record:IconName())
        format_value("\tfriendly_tooltip()", record:FriendlyTooltip())
        format_value("\tname()", record:Name())
        format_opt_value("\tpar_name()", record:ParName())
        format_opt_value("\thover_indicator_texture_name()", record:HoverIndicatorTextureName())
        format_value("\thover_indicator_radius()", record:HoverIndicatorRadius())
        format_opt_value("\thover_line_indicator_base_texture_name()", record:HoverLineIndicatorBaseTextureName())
        format_opt_value("\thover_line_indicator_target_texture_name()", record:HoverLineIndicatorTargetTextureName())
        format_value("\thover_indicator_width()", record:HoverIndicatorWidth())
        format_value("\thover_indicator_rotate_to_player()", record:HoverIndicatorRotateToPlayer())
        format_opt_value("\thover_indicator_minimap_override()", record:HoverIndicatorMinimapOverride())
        format_opt_value("\tminimap_icon_override()", record:MinimapIconOverride())
        format_value("\thover_indicator_radius_minimap()", record:HoverIndicatorRadiusMinimap())
        format_value("\thover_line_indicator_width_minimap()", record:HoverLineIndicatorWidthMinimap())
        format_value("\tarea_indicator_radius()", record:AreaIndicatorRadius())
        format_value("\tarea_indicator_min_radius()", record:AreaIndicatorMinRadius())
        format_value("\tarea_indicator_max_distsance()", record:AreaIndicatorMaxDistsance())
        format_value("\tarea_indicator_target_distsance()", record:AreaIndicatorTargetDistsance())
        format_value("\tarea_indicator_min_distsance()", record:AreaIndicatorMinDistsance())
        format_opt_value("\tarea_indicator_texture_name()", record:AreaIndicatorTextureName())
        format_value("\tarea_indicator_texture_size()", record:AreaIndicatorTextureSize())
        format_opt_value("\tchar_audio_name_override()", record:CharAudioNameOverride())
        format_value("\tuse_cc_animations()", record:UseCcAnimations())
        format_opt_value("\tjoint_for_anim_adjusted_selection()", record:JointForAnimAdjustedSelection())
        format_value("\toutline_bbox_expansion()", record:OutlineBboxExpansion())
        format_value("\tsilhouette_attachment_anim()", record:SilhouetteAttachmentAnim())
        format_value("\thit_fx_scale()", record:HitFxScale())
        format_value("\tselection_radius()", record:SelectionRadius())
        format_value("\tselection_height()", record:SelectionHeight())
        format_value("\tpathfinding_collision_radius()", record:PathfindingCollisionRadius())
        format_opt_value("\toverride_gameplay_collision_radius()", record:OverrideGameplayCollisionRadius())
        format_value("\tunit_tags_string()", record:UnitTagsString())
        format_value("\tfriendly_ux_override_team()", record:FriendlyUxOverrideTeam(), "0x%x")
        format_opt_value("\tfriendly_ux_override_include_tags_string()", record:FriendlyUxOverrideIncludeTagsString())
        format_opt_value("\tfriendly_ux_override_exclude_tags_string()", record:FriendlyUxOverrideExcludeTagsString())
        format_value("\tplatform_enabled()", record:PlatformEnabled())
        format_value("\trecord_as_ward()", record:RecordAsWard())
        format_value("\tminion_score_value()", record:MinionScoreValue())
        format_value("\tuse_riot_relationships()", record:UseRiotRelationships())
        format_value("\tflags()", record:Flags(), "0x%x")
        format_value("\tminion_flags()", record:MinionFlags(), "0x%x")
        format_value("\tdeath_time()", record:DeathTime())
        format_value("\toccluded_unit_selectable_distance()", record:OccludedUnitSelectableDistance())
        format_value("\tmoving_toward_enemy_activation_angle()", record:MovingTowardEnemyActivationAngle())

        format_value("\tspell_names()", record:SpellNames())
        local vec = record:SpellNames()
        for i = 0, vec.n - 1 do
            format_value("\t\tval["..i.."]", ffi.string(vec.val[i]))
        end

        format_value("\textra_spells()", record:ExtraSpells())
        local vec = record:ExtraSpells()
        for i = 0, vec.n - 1 do
            format_value("\t\tval["..i.."]", ffi.string(vec.val[i]))
        end

    end
    ig.End()
end

return {
    draw_menu = draw_menu,
}