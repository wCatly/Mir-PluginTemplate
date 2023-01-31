
local ffi = require "ffi"

local demo_h = require "demo_h"
local format_value = demo_h.format_value

local draw_menu = function(obj, type)
    if not obj then
        return
    end
    
    if ig.Begin("Demo: GameObject", p_open) then
        if ig.TreeNode("Enum GameObjectType") then
            format_value("\tGameObjectType_Hero", GameObjectType_Hero)
            format_value("\tGameObjectType_Minion", GameObjectType_Minion)
            format_value("\tGameObjectType_Turret", GameObjectType_Turret)
            format_value("\tGameObjectType_Inhib", GameObjectType_Inhib)
            format_value("\tGameObjectType_Nexus", GameObjectType_Nexus)
            format_value("\tGameObjectType_Missile", GameObjectType_Missile)
            format_value("\tGameObjectType_Particle", GameObjectType_Particle)
            ig.TreePop()
        end
        if ig.TreeNode("Enum GameObjectTeam") then
            format_value("\tGameObjectTeam_Ally", GameObjectTeam_Ally)
            format_value("\tGameObjectTeam_Enemy", GameObjectTeam_Enemy)
            format_value("\tGameObjectTeam_Neutral", GameObjectTeam_Neutral)
            ig.TreePop()
        end
        ig.NewLine()
        format_value("GameObject:", obj)
        format_value("\tmemory_address()", obj:MemoryAddress(), "0x%x")
        format_value("\tid()", obj:Id(), "0x%x")
        format_value("\tindex()", obj:Index(), "0x%x")
        format_value("\ttype()", obj:Type())
        format_value("\tteam()", obj:Team())
        format_value("\tname()", obj:Name())
        format_value("\tis_on_screen()", obj:IsOnScreen())
        format_value("\tnetwork_id()", obj:NetworkId(), "0x%x")
        format_value("\tpos()", obj:Pos())
        format_value("\tis_zombie()", obj:IsZombie())
        format_value("\tis_ally()", obj:IsAlly())
        format_value("\tis_enemy()", obj:IsEnemy())
        format_value("\tis_neutral()", obj:IsNeutral())
        format_value("\tis_player()", obj:IsPlayer())
        format_value("\tis_hero()", obj:IsHero())
        format_value("\tis_minion()", obj:IsMinion())
        format_value("\tis_turret()", obj:IsTurret())
        format_value("\tis_inhib()", obj:IsInhib())
        format_value("\tis_nexus()", obj:IsNexus())
        format_value("\tis_missile()", obj:IsMissile())
        format_value("\tis_particle()", obj:IsParticle())
        format_value("\tis_neutral_camp()", obj:IsNeutralCamp())
        format_value("\tis_attackable_unit()", obj:IsAttackableUnit())
        format_value("\tis_ai_client()", obj:IsAiClient())
    end
    ig.End()
end

return {
    draw_menu = draw_menu,
}