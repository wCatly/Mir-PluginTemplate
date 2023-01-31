
local ffi = require "ffi"

local demo_h = require "demo_h"
local format_value = demo_h.format_value
local format_opt_value = demo_h.format_opt_value

local show_basic_attacks = ffi.new("bool[1]")
local v_spell_slot = ffi.new("int[1]")
v_spell_slot[0] = 0
local v_basic_attack = ffi.new("int[1]")
v_basic_attack[0] = 0

local draw_menu = function(aiclient, p_open)
    if ig.Begin("Demo: SpellDataResource", p_open) then
        ig.Checkbox("Show Basic Attacks", show_basic_attacks)
        local data
        if show_basic_attacks[0] then
            local basic_attacks = aiclient:BasicAttacks()
            ig.SliderInt("##SpellDataResourceBasicAttacks", v_basic_attack, 0, basic_attacks.n - 1, "basic_attack(%d)", ig.lib.ImGuiSliderFlags_NoInput)
            local basic_attack = basic_attacks.val[v_basic_attack[0]]
            format_value("BasicAttack:", basic_attack)
            data = basic_attack and basic_attack:SpellDataResource()
            
        else
            ig.SliderInt("##SpellDataResourceSpellSlots", v_spell_slot, SpellSlot_Q, SpellSlot_COUNT-1, "spell_slot(%d)", ig.lib.ImGuiSliderFlags_NoInput)
            local spell_slot = aiclient:SpellSlot(v_spell_slot[0])
            format_value("SpellSlot:", spell_slot)
            data = spell_slot and spell_slot:SpellDataResource()
        end
        ig.NewLine()
        format_value("SpellDataResource:", data)
        if data then
            format_value("\tmemory_address()", data:MemoryAddress(), "0x%x")
            format_value("\tflags()", data:Flags())
            format_value("\taffects_type_flags()", data:AffectsTypeFlags(), "0x%x")
            format_value("\taffects_status_flags()", data:AffectsStatusFlags())
            format_value("\tcoefficient()", data:Coefficient())
            format_value("\tcoefficient2()", data:Coefficient2())
            format_value("\tcast_time()", data:CastTime())

            format_value("\tchannel_durations()", data:ChannelDurations())
            local vec = data:ChannelDurations()
            for i = 0, vec.n - 1 do
                format_value("\t\tval["..i.."]", vec.val[i])
            end

            format_value("\tcooldown_times()", data:CooldownTimes())
            local vec = data:CooldownTimes()
            for i = 0, vec.n - 1 do
                format_value("\t\tval["..i.."]", vec.val[i])
            end

            format_value("\tdelay_cast_offset_percent()", data:DelayCastOffsetPercent())
            format_value("\tdelay_total_time_percent()", data:DelayTotalTimePercent())
            format_value("\tpre_cast_lockout_delta_time()", data:PreCastLockoutDeltaTime())
            format_value("\tpost_cast_lockout_delta_time()", data:PostCastLockoutDeltaTime())
            format_value("\tis_delayed_by_cast_locked()", data:IsDelayedByCastLocked())
            format_value("\tstart_cooldown()", data:StartCooldown())

            format_value("\tcast_range_growth_max()", data:CastRangeGrowthMax())
            local vec = data:CastRangeGrowthMax()
            for i = 0, vec.n - 1 do
                format_value("\t\tval["..i.."]", vec.val[i])
            end

            format_value("\tcast_range_growth_start_times()", data:CastRangeGrowthStartTimes())
            local vec = data:CastRangeGrowthStartTimes()
            for i = 0, vec.n - 1 do
                format_value("\t\tval["..i.."]", vec.val[i])
            end

            format_value("\tcharge_update_interval()", data:ChargeUpdateInterval())
            format_value("\tcancel_charge_on_recast_time()", data:CancelChargeOnRecastTime())

            format_value("\tmax_ammo()", data:MaxAmmo())
            local vec = data:MaxAmmo()
            for i = 0, vec.n - 1 do
                format_value("\t\tval["..i.."]", vec.val[i])
            end

            format_value("\tammo_used()", data:AmmoUsed())
            local vec = data:AmmoUsed()
            for i = 0, vec.n - 1 do
                format_value("\t\tval["..i.."]", vec.val[i])
            end

            format_value("\tammo_recharge_times()", data:AmmoRechargeTimes())
            local vec = data:AmmoRechargeTimes()
            for i = 0, vec.n - 1 do
                format_value("\t\tval["..i.."]", vec.val[i])
            end

            format_value("\tammo_not_affected_by_cdr()", data:AmmoNotAffectedByCdr())
            format_value("\tcooldown_not_affected_by_cdr()", data:CooldownNotAffectedByCdr())
            format_value("\tammo_count_hidden_in_ui()", data:AmmoCountHiddenInUi())
            format_value("\tcost_always_shown_in_ui()", data:CostAlwaysShownInUi())
            format_value("\tcannot_be_suppressed()", data:CannotBeSuppressed())
            format_value("\tcan_cast_while_disabled()", data:CanCastWhileDisabled())
            format_value("\tcan_trigger_charge_spell_while_disabled()", data:CanTriggerChargeSpellWhileDisabled())
            format_value("\tcan_cast_or_queue_while_casting()", data:CanCastOrQueueWhileCasting())
            format_value("\tcan_only_cast_while_disabled()", data:CanOnlyCastWhileDisabled())
            format_value("\tcant_cancel_while_winding_up()", data:CantCancelWhileWindingUp())
            format_value("\tcant_cancel_while_channeling()", data:CantCancelWhileChanneling())
            format_value("\tcant_cast_while_rooted()", data:CantCastWhileRooted())
            format_value("\tchannel_is_interrupted_by_disables()", data:ChannelIsInterruptedByDisables())
            format_value("\tchannel_is_interrupted_by_attacking()", data:ChannelIsInterruptedByAttacking())
            format_value("\tapply_attack_damage()", data:ApplyAttackDamage())
            format_value("\tapply_attack_effect()", data:ApplyAttackEffect())
            format_value("\tapply_material_on_hit_sound()", data:ApplyMaterialOnHitSound())
            format_value("\tdoesnt_break_channels()", data:DoesntBreakChannels())
            format_value("\tbelongs_to_avatar()", data:BelongsToAvatar())
            format_value("\tis_disabled_while_dead()", data:IsDisabledWhileDead())
            format_value("\tcan_only_cast_while_dead()", data:CanOnlyCastWhileDead())
            format_value("\tcursor_changes_in_grass()", data:CursorChangesInGrass())
            format_value("\tcursor_changes_in_terrain()", data:CursorChangesInTerrain())
            format_value("\tproject_target_to_cast_range()", data:ProjectTargetToCastRange())
            format_value("\tspell_reveals_champion()", data:SpellRevealsChampion())
            format_value("\tuse_minimap_targeting()", data:UseMinimapTargeting())
            format_value("\tcast_range_use_bounding_boxes()", data:CastRangeUseBoundingBoxes())
            format_value("\tminimap_icon_rotation()", data:MinimapIconRotation())
            format_value("\tuse_charge_channeling()", data:UseChargeChanneling())
            format_value("\tcan_move_while_channeling()", data:CanMoveWhileChanneling())
            format_value("\tdisable_cast_bar()", data:DisableCastBar())
            format_value("\tshow_channel_bar()", data:ShowChannelBar())
            format_value("\talways_snap_facing()", data:AlwaysSnapFacing())
            format_value("\tuse_animator_framerate()", data:UseAnimatorFramerate())
            format_value("\thave_hit_effect()", data:HaveHitEffect())
            format_value("\tis_toggle_spell()", data:IsToggleSpell())
            format_value("\tdo_not_need_to_face_target()", data:DoNotNeedToFaceTarget())
            format_value("\tturn_speed_scalar()", data:TurnSpeedScalar())
            format_value("\tno_winddown_if_cancelled()", data:NoWinddownIfCancelled())
            format_value("\tignore_range_check()", data:IgnoreRangeCheck())
            format_value("\torient_radius_texture_from_player()", data:OrientRadiusTextureFromPlayer())
            format_value("\tignore_anim_continue_until_cast_frame()", data:IgnoreAnimContinueUntilCastFrame())
            format_value("\thide_range_indicator_when_casting()", data:HideRangeIndicatorWhenCasting())
            format_value("\tupdate_rotation_when_casting()", data:UpdateRotationWhenCasting())
            format_value("\tpingable_while_disabled()", data:PingableWhileDisabled())
            format_value("\tconsidered_as_auto_attack()", data:ConsideredAsAutoAttack())
            format_value("\tdoes_not_consume_mana()", data:DoesNotConsumeMana())
            format_value("\tdoes_not_consume_cooldown()", data:DoesNotConsumeCooldown())
            format_value("\tlocked_spell_origination_cast_id()", data:LockedSpellOriginationCastId())
            format_value("\tminimap_icon_display_flag()", data:MinimapIconDisplayFlag())

            format_value("\tcast_ranges()", data:CastRanges())
            local vec = data:CastRanges()
            for i = 0, vec.n - 1 do
                format_value("\t\tval["..i.."]", vec.val[i])
            end

            format_value("\tcast_range_display_overrides()", data:CastRangeDisplayOverrides())
            local vec = data:CastRangeDisplayOverrides()
            for i = 0, vec.n - 1 do
                format_value("\t\tval["..i.."]", vec.val[i])
            end

            format_value("\tcast_radius()", data:CastRadius())
            local vec = data:CastRadius()
            for i = 0, vec.n - 1 do
                format_value("\t\tval["..i.."]", vec.val[i])
            end

            format_value("\tcast_radius_secondary()", data:CastRadiusSecondary())
            local vec = data:CastRadiusSecondary()
            for i = 0, vec.n - 1 do
                format_value("\t\tval["..i.."]", vec.val[i])
            end

            format_value("\tcast_cone_angle()", data:CastConeAngle())
            format_value("\tcast_cone_distance()", data:CastConeDistance())
            format_value("\tcast_target_additional_units_radius()", data:CastTargetAdditionalUnitsRadius())
            format_value("\tlua_on_missile_update_distance_interval()", data:LuaOnMissileUpdateDistanceInterval())
            format_value("\tcast_type()", data:CastType())
            format_value("\tcast_frame()", data:CastFrame())
            format_value("\tmissile_speed()", data:MissileSpeed())
            format_value("\tmissile_effect_key()", data:MissileEffectKey(), "0x%x")
            format_value("\tmissile_effect_player_key()", data:MissileEffectPlayerKey(), "0x%x")
            format_value("\tmissile_effect_enemy_key()", data:MissileEffectEnemyKey(), "0x%x")
            format_value("\tline_width()", data:LineWidth())
            format_value("\tline_drag_length()", data:LineDragLength())
            format_value("\tlook_at_policy()", data:LookAtPolicy())
            format_value("\thit_effect_orient_type()", data:HitEffectOrientType())
            format_value("\thit_effect_key()", data:HitEffectKey(), "0x%x")
            format_value("\thit_effect_player_key()", data:HitEffectPlayerKey(), "0x%x")
            format_value("\tafter_effect_key()", data:AfterEffectKey(), "0x%x")
            format_value("\thave_hit_bone()", data:HaveHitBone())
            format_value("\tparticle_start_offset()", data:ParticleStartOffset())

            format_value("\tfloat_vars_decimals()", data:FloatVarsDecimals())
            local vec = data:FloatVarsDecimals()
            for i = 0, vec.n - 1 do
                format_value("\t\tval["..i.."]", vec.val[i])
            end

            format_value("\tmana()", data:Mana())
            local vec = data:Mana()
            for i = 0, vec.n - 1 do
                format_value("\t\tval["..i.."]", vec.val[i])
            end

            format_value("\tmana_ui_overrides()", data:ManaUiOverrides())
            local vec = data:ManaUiOverrides()
            for i = 0, vec.n - 1 do
                format_value("\t\tval["..i.."]", vec.val[i])
            end

            format_value("\tselection_priority()", data:SelectionPriority())
            format_opt_value("\tspell_cooldown_or_sealed_queue_threshold()", data:SpellCooldownOrSealedQueueThreshold())
            format_opt_value("\trequired_unit_tags()", data:RequiredUnitTags())
            format_opt_value("\texcluded_unit_tags()", data:ExcludedUnitTags())
            format_value("\talternate_name()", data:AlternateName())
            format_value("\tanimation_name()", data:AnimationName())
            format_opt_value("\tanimation_loop_name()", data:AnimationLoopName())
            format_opt_value("\tanimation_winddown_name()", data:AnimationWinddownName())
            format_opt_value("\tanimation_lead_out_name()", data:AnimationLeadOutName())
            format_opt_value("\tminimap_icon_name()", data:MinimapIconName())
            format_opt_value("\tkeyword_when_acquired()", data:KeywordWhenAcquired())
            format_opt_value("\tmissile_effect_name()", data:MissileEffectName())
            format_opt_value("\tmissile_effect_player_name()", data:MissileEffectPlayerName())
            format_opt_value("\tmissile_effect_enemy_name()", data:MissileEffectEnemyName())
            format_opt_value("\thit_effect_name()", data:HitEffectName())
            format_opt_value("\thit_effect_player_name()", data:HitEffectPlayerName())
            format_opt_value("\tafter_effect_name()", data:AfterEffectName())
            format_opt_value("\thit_bone_name()", data:HitBoneName())
            format_opt_value("\tvobotm_category()", data:VoeventCategory())

            local n = data:SpellTagsVectorSize()
            format_value("\tspell_tags_vector_size()", n)
            for i = 0, n - 1 do
                format_value("\t\tspell_tags["..i.."]", data:SpellTagsVector(i))
            end
            
            local n = data:EffectAmountVectorSize()
            format_value("\teffect_amount_vector_size()", n)
            for i = 0, n - 1 do
                local effect_amount = data:EffectAmountVector(i)
                format_value("\t\teffect_amount_vector["..i.."]", effect_amount)
                local m = effect_amount:ValuesArraySize()
                local values = effect_amount:ValuesArray()
                for j = 0, m - 1 do
                    format_value("\t\t\teffect_amount["..j.."]", values[j])
                end
            end
            
            local n = data:DataValuesVectorSize()
            format_value("\tdata_values_vector_size()", n)
            for i = 0, n - 1 do
                local data_values = data:DataValuesVector(i)
                format_value("\t\tdata_values_vector("..i..")", data_values)
                format_value("\t\t\tname()", data_values:Name())
                local n = data_values:ValuesArraySize()
                local values = data_values:ValuesArray()
                format_value("\t\t\tvalues_array_size()", n)
                for j = 0, n - 1 do
                    format_value("\t\t\t\tvalues_array["..j.."]", values[j])
                end
            end

            -- local n = data:SpellCalculationsMapSize()
            -- format_value("\tspell_calculations_map_size()", n)
            -- for i = 0, n - 1 do
            --     local spell_calculation = data:SpellCalculationsMap(i)
            --     format_value("\t\tspell_calculations_map("..i..")", spell_calculation)
            --     format_value("\t\t\thash()", spell_calculation:Hash(), "0x%x")
            --     format_value("\t\t\tresult()", spell_calculation:Result(1))
            -- end
        end
    end
    ig.End()
end

return {
    draw_menu = draw_menu,
}