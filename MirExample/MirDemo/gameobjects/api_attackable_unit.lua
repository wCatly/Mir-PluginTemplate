
local ffi = require "ffi"

local demo_h = require "demo_h"
local format_value = demo_h.format_value

local draw_menu = function(obj, type, p_open)
    if not obj then
        return
    end
    
    if ig.Begin("Demo: AttackableUnit", p_open) then
        format_value("AttackableUnit:", obj)
        format_value("\tbase_collision_radius()", obj:BaseCollisionRadius())
        format_value("\tis_visible()", obj:IsVisible())
        format_value("\tdeath_time)", obj:DeathTime())
        format_value("\tis_dead(()", obj:IsDead())
        format_value("\thealth()", obj:Health())
        format_value("\tmax_health()", obj:MaxHealth())
        format_value("\thealth_max_penalty()", obj:HealthMaxPenalty())
        format_value("\tall_shield()", obj:AllShield())
        format_value("\tphysical_shield()", obj:PhysicalShield())
        format_value("\tmagical_shield()", obj:MagicalShield())
        format_value("\tchamp_specific_health()", obj:ChampSpecificHealth())
        format_value("\tincoming_healing_enemy()", obj:IncomingHealingEnemy())
        format_value("\tincoming_healing_allied()", obj:IncomingHealingAllied())
        format_value("\tstop_shield_fade()", obj:StopShieldFade())
        format_value("\tis_targetable()", obj:IsTargetable())
        format_value("\tmana()", obj:Mana())
        format_value("\tmax_mana()", obj:MaxMana())
        format_value("\tpar()", obj:Par())
        format_value("\tmax_par()", obj:MaxPar())
        format_value("\tpar_state()", obj:ParState())
        format_value("\tsar()", obj:Sar())
        format_value("\tmax_sar()", obj:MaxSar())
        format_value("\tsar_enabled()", obj:SarEnabled())
        format_value("\tsar_state()", obj:SarState())
    end
    ig.End()
end

return {
    draw_menu = draw_menu,
}