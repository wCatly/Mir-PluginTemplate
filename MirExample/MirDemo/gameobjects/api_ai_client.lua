
local ffi = require "ffi"

local demo_h = require "demo_h"
local format_value = demo_h.format_value

local draw_menu = function(obj, type, p_open)
    if not obj then
        return
    end
    
    if ig.Begin("Demo: AIClient", p_open) then
        if ig.TreeNode("Enum CombatType") then
            format_value("\tCombatType_None", CombatType_None)
            format_value("\tCombatType_Melee", CombatType_Melee)
            format_value("\tCombatType_Ranged", CombatType_Ranged)
            
            ig.TreePop()
        end

        ig.NewLine()
        format_value("AIClient:", obj)
        format_value("\tbase_character_data()", obj:BaseCharacterData())
        format_value("\tcharacter_data()", obj:CharacterData())
        format_value("\tcharacter_record()", obj:CharacterRecord())
        format_value("\tspell_calculations(SpellSlot_R)",  obj:SpellCalculations(SpellSlot_R))
        local spell_calculations = obj:SpellCalculations(SpellSlot_R)
        for i = 0, spell_calculations.n - 1 do
            format_value("\t\tval["..i.."]", spell_calculations.val[i])
        end
        format_value("\tfind_spell_calculation_by_hash(SpellSlot_R, RMainDamage)", obj:FindSpellCalculationByHash(SpellSlot_R, 0x6b5c55b9))
        format_value("\tcalc_attack_cast_delay", obj:CalcAttackCastDelay())
        format_value("\tcalc_attack_delay", obj:CalcAttackDelay())

        local icon = obj:IconSquare()
        format_value("\ticon_square()", icon)
        if icon then
            ig.Text("\t\t") ig.SameLine()
            ig.Image(icon:TexId(), icon:Size())
        end

        local icon = obj:IconCircle()
        format_value("\ticon_circle()", icon)
        if icon then
            ig.Text("\t\t") ig.SameLine()
            ig.Image(icon:TexId(), icon:Size())
        end
        format_value("\thas_bar_pos()", obj:HasBarPos())
        format_value("\tbar_pos()", obj:BarPos())
        format_value("\tfloating_info_bars()", obj:FloatingInfoBars())
        format_value("\tcollision_radius()", obj:CollisionRadius())
        format_value("\tbuffs()", obj:Buffs())
        local vec = obj:Buffs()
        for i = 0, vec.n - 1 do
            format_value("\t\tval["..i.."]", vec.val[i])
        end
        format_value("\tfind_buff(BuffType_Internal)", obj:FindBuff(BuffType_Internal))
        format_value("\tfind_buff_by_name(\"Banners_Manager\")", obj:FindBuffByName("Banners_Manager"))
        format_value("\tfind_buff_by_hash(hash_Banners_Manager))", obj:FindBuffByHash(game:FnvHash("Banners_Manager")))
        format_value("\tactive_spell()", obj:ActiveSpell())
        format_value("\tspell_slot(SpellSlot_Q)", obj:SpellSlot(SpellSlot_Q))
        format_value("\tbasic_attacks", obj:BasicAttacks())
        local vec = obj:BasicAttacks()
        for i = 0, vec.n - 1 do
            format_value("\t\tval["..i.."]", vec.val[i])
        end
        format_value("\tpath()", obj:Path())
        format_value("\tchar_name()", obj:CharName())
        format_value("\tchar_name_fnv_hash()", obj:CharNameFnvHash(), "0x%x")
        format_value("\tdirection()", obj:Direction())
        format_value("\taction_state()", obj:ActionState(), "0x%x")
        format_value("\taction_state2()", obj:ActionState2(), "0x%x")
        format_value("\tcombat_type()", obj:CombatType())
        format_value("\tis_melee()", obj:IsMelee())
        format_value("\tis_ranged()", obj:IsRanged())
        ig.NewLine()
        format_value("\tbase_health()", obj:BaseHealth())
        format_value("\tbase_health_per_level()", obj:BaseHealthPerLevel())
        format_value("\tbase_mana()", obj:BaseMana())
        format_value("\tbase_mana_per_level()", obj:BaseManaPerLevel())
        format_value("\tbase_move_speed()", obj:BaseMoveSpeed())
        ig.NewLine()
        format_value("\tbase_attack_damage()", obj:BaseAttackDamage())
        format_value("\tarmor()", obj:Armor())
        format_value("\tspell_block()", obj:SpellBlock())
        format_value("\tattack_speed_mod()", obj:AttackSpeedMod())
        format_value("\tflat_physical_damage_mod()", obj:FlatPhysicalDamageMod())
        format_value("\tpercent_physical_damage_mod()", obj:PercentPhysicalDamageMod())
        format_value("\tflat_magic_damage_mod()", obj:FlatMagicDamageMod())
        format_value("\tpercent_magic_damage_mod()", obj:PercentMagicDamageMod())
        format_value("\thealth_regen_rate()", obj:HealthRegenRate())
        format_value("\tprimary_ar_regen_rate_rep()", obj:PrimaryArRegenRateRep())
        format_value("\tflat_magic_reduction()", obj:FlatMagicReduction())
        format_value("\tpercent_magic_reduction()", obj:PercentMagicReduction())
        format_value("\tpercent_bonus_armor_penetration()", obj:PercentBonusArmorPenetration())
        format_value("\tpercent_crit_bonus_armor_penetration()", obj:PercentCritBonusArmorPenetration())
        format_value("\tpercent_crit_total_armor_penetration()", obj:PercentCritTotalArmorPenetration())
        format_value("\tpercent_bonus_magic_penetration()", obj:PercentBonusMagicPenetration())
        format_value("\tphysical_lethality()", obj:PhysicalLethality())
        format_value("\tmagic_lethality()", obj:MagicLethality())
        format_value("\tbase_health_regen_rate()", obj:BaseHealthRegenRate())
        format_value("\tprimary_ar_base_regen_rate_rep()", obj:PrimaryArBaseRegenRateRep())
        format_value("\tsecondary_ar_regen_rate_rep()", obj:SecondaryArRegenRateRep())
        format_value("\tsecondary_ar_base_regen_rate_rep()", obj:SecondaryArBaseRegenRateRep())
        format_value("\tpercent_cooldown_cap_mod()", obj:PercentCooldownCapMod())
        format_value("\tpercent_cc_reduction()", obj:PercentCcReduction())
        format_value("\tpercent_exp_bonus()", obj:PercentExpBonus())
        format_value("\tflat_base_attack_damage_mod()", obj:FlatBaseAttackDamageMod())
        format_value("\tpercent_base_attack_damage_mod()", obj:PercentBaseAttackDamageMod())
        format_value("\tbase_attack_damage_sans_percent_scale()", obj:BaseAttackDamageSansPercentScale())
        format_value("\tbonus_armor()", obj:BonusArmor())
        format_value("\tbonus_spell_block()", obj:BonusSpellBlock())
        format_value("\tpercent_bonus_physical_damage_mod()", obj:PercentBonusPhysicalDamageMod())
        format_value("\tpercent_base_physical_damage_as_flat_bonus()", obj:PercentBasePhysicalDamageAsFlatBonus())
        format_value("\tpercent_attack_speed_mod()", obj:PercentAttackSpeedMod())
        format_value("\tpercent_multiplicative_attack_speed_mod()", obj:PercentMultiplicativeAttackSpeedMod())
        format_value("\tcrit_damage_multiplier()", obj:CritDamageMultiplier())
        format_value("\tability_haste_mod()", obj:AbilityHasteMod())
        format_value("\tflat_bubble_radius_mod()", obj:FlatBubbleRadiusMod())
        format_value("\tpercent_bubble_radius_mod()", obj:PercentBubbleRadiusMod())
        format_value("\tmove_speed()", obj:MoveSpeed())
        format_value("\tmove_speed_base_increase()", obj:MoveSpeedBaseIncrease())
        format_value("\tscale_skin_coef()", obj:ScaleSkinCoef())
        format_value("\tpathfinding_radius_mod()", obj:PathfindingRadiusMod())
        format_value("\tbase_ability_damage()", obj:BaseAbilityDamage())
        format_value("\tcrit()", obj:Crit())
        format_value("\tpar_regen_rate()", obj:ParRegenRate())
        format_value("\tattack_range()", obj:AttackRange())
        format_value("\tflat_cast_range_mod()", obj:FlatCastRangeMod())
        format_value("\tpercent_cooldown_mod()", obj:PercentCooldownMod())
        format_value("\tpassive_cooldown_end_time()", obj:PassiveCooldownEndTime())
        format_value("\tpassive_cooldown_total_time()", obj:PassiveCooldownTotalTime())
        format_value("\tflat_armor_penetration()", obj:FlatArmorPenetration())
        format_value("\tpercent_armor_penetration()", obj:PercentArmorPenetration())
        format_value("\tflat_magic_penetration()", obj:FlatMagicPenetration())
        format_value("\tpercent_magic_penetration()", obj:PercentMagicPenetration())
        format_value("\tpercent_life_steal_mod()", obj:PercentLifeStealMod())
        format_value("\tpercent_spell_vamp_mod()", obj:PercentSpellVampMod())
        format_value("\tphysical_damage_percent_modifier()", obj:PhysicalDamagePercentModifier())
        format_value("\tmagical_damage_percent_modifier()", obj:MagicalDamagePercentModifier())
        format_value("\tpercent_damage_to_barracks_minion_mod()", obj:PercentDamageToBarracksMinionMod())
        format_value("\tflat_damage_reduction_from_barracks_minion_mod()", obj:FlatDamageReductionFromBarracksMinionMod())
    end
    ig.End()
end

local draw = function(obj)
    if not obj then
        return
    end

    local pos = game:CursorPos()
    
    local icon_square = obj:IconSquare()
    if icon_square then
        graphics:DrawImage2d(icon_square, pos)
    end

    local icon_circle = obj:IconCircle()
    if icon_circle then
        pos = pos + float2(icon_square:Width(), 0)
        graphics:DrawImage2d(icon_circle, pos)
    end
end

return {
    draw_menu = draw_menu,
    draw = draw,
}