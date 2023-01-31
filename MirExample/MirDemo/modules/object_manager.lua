local ffi = require "ffi"

local demo_h = require "demo_h"
local format_value = demo_h.format_value

local botm_draw_menu = function(p_open)
    if ig.Begin("Demo: ObjectManager", p_open) then
        if ig.TreeNode("Sorting Example") then
            local vec = object_manager:EnemyHeroes()
            if vec.n == 0 then
                ig.Text("This example requires enemy heroes")
            else
                format_value("object_manager:SortHeroesHealthAscending(enemy_heroes):", " ")
                object_manager:SortHeroesHealthAbsolute(vec)
                for i = 0, vec.n - 1 do
                    local obj = vec.val[i]
                    ig.Text("\t%s %f", obj:CharName(), obj:Health())
                end
                ig.NewLine()
                format_value("Custom sort health descending:", " ")
                for i = 0, vec.n - 1 do
                    local obj = vec.val[i]
                    obj:SetSortHeuristic(-obj:Health())
                end
                object_manager:SortHeroes(vec)
                for i = 0, vec.n - 1 do
                    local obj = vec.val[i]
                    ig.Text("\t%s %f", obj:CharName(), obj:Health())
                end
            end
            ig.TreePop()
        end
        ig.NewLine()
        format_value("ObjectManager:", object_manager)
        format_value("\tget_object_by_id(player_id)", object_manager:GetObjectById(player:Id()))
        format_value("\tget_object_by_index(player_index)", object_manager:GetObjectByIndex(player:Index()))
        format_value("\tget_object_by_network_id(player_network_id)", object_manager:GetObjectByNetworkId(player:NetworkId()))
        ig.NewLine()
        format_value("\tparticles()", object_manager:Particles())
        format_value("\tneutral_camps()", object_manager:NeutralCamps())
        format_value("\tmissiles()", object_manager:Missiles())
        format_value("\tinhibs()", object_manager:Inhibs())
        format_value("\tnexus()", object_manager:Nexus())
        format_value("\tturrets()", object_manager:Turrets())
        format_value("\tminions()", object_manager:Minions())
        format_value("\theroes()", object_manager:Heroes())
        format_value("\tallied_missiles()", object_manager:AlliedMissiles())
        format_value("\tenemy_missiles()", object_manager:EnemyMissiles())
        format_value("\tneutral_missiles()", object_manager:NeutralMissiles())
        format_value("\tallied_inhibs()", object_manager:AlliedInhibs())
        format_value("\tenemy_inhibs()", object_manager:EnemyInhibs())
        format_value("\tneutral_inhibs()", object_manager:NeutralInhibs())
        format_value("\tallied_nexus()", object_manager:AlliedNexus())
        format_value("\tenemy_nexus()", object_manager:EnemyNexus())
        format_value("\tneutral_nexus()", object_manager:NeutralNexus())
        format_value("\tallied_turrets()", object_manager:AlliedTurrets())
        format_value("\tenemy_turrets()", object_manager:EnemyTurrets())
        format_value("\tneutral_turrets()", object_manager:NeutralTurrets())
        format_value("\tallied_outer_turrets()", object_manager:AlliedOuterTurrets())
        format_value("\tenemy_outer_turrets()", object_manager:EnemyOuterTurrets())
        format_value("\tneutral_outer_turrets()", object_manager:NeutralOuterTurrets())
        format_value("\tallied_inner_turrets()", object_manager:AlliedInnerTurrets())
        format_value("\tenemy_inner_turrets()", object_manager:EnemyInnerTurrets())
        format_value("\tneutral_inner_turrets()", object_manager:NeutralInnerTurrets())
        format_value("\tallied_inhib_turrets()", object_manager:AlliedInhibTurrets())
        format_value("\tenemy_inhib_turrets()", object_manager:EnemyInhibTurrets())
        format_value("\tneutral_inhib_turrets()", object_manager:NeutralInhibTurrets())
        format_value("\tallied_nexus_turrets()", object_manager:AlliedNexusTurrets())
        format_value("\tenemy_nexus_turrets()", object_manager:EnemyNexusTurrets())
        format_value("\tneutral_nexus_turrets()", object_manager:NeutralNexusTurrets())
        format_value("\tallied_shrines()", object_manager:AlliedShrines())
        format_value("\tenemy_shrines()", object_manager:EnemyShrines())
        format_value("\tneutral_shrines()", object_manager:NeutralShrines())
        format_value("\tallied_minions()", object_manager:AlliedMinions())
        format_value("\tenemy_minions()", object_manager:EnemyMinions())
        format_value("\tneutral_minions()", object_manager:NeutralMinions())
        format_value("\tallied_lane_minions()", object_manager:AlliedLaneMinions())
        format_value("\tenemy_lane_minions()", object_manager:EnemyLaneMinions())
        format_value("\tallied_melee_minions()", object_manager:AlliedMeleeMinions())
        format_value("\tenemy_melee_minions()", object_manager:EnemyMeleeMinions())
        format_value("\tallied_ranged_minions()", object_manager:AlliedRangedMinions())
        format_value("\tenemy_ranged_minions()", object_manager:EnemyRangedMinions())
        format_value("\tallied_siege_minions()", object_manager:AlliedSiegeMinions())
        format_value("\tenemy_siege_minions()", object_manager:EnemySiegeMinions())
        format_value("\tallied_super_minions()", object_manager:AlliedSuperMinions())
        format_value("\tenemy_super_minions()", object_manager:EnemySuperMinions())
        format_value("\tjungle_minions()", object_manager:JungleMinions())
        format_value("\tmonsters()", object_manager:Monsters())
        format_value("\tcamp_monsters()", object_manager:CampMonsters())
        format_value("\tmedium_monsters()", object_manager:MediumMonsters())
        format_value("\tlarge_monsters()", object_manager:LargeMonsters())
        format_value("\tepic_monsters()", object_manager:EpicMonsters())
        format_value("\twolves()", object_manager:Wolves())
        format_value("\tgromps()", object_manager:Gromps())
        format_value("\tkrugs()", object_manager:Krugs())
        format_value("\traptors()", object_manager:Raptors())
        format_value("\tbuffs()", object_manager:Buffs())
        format_value("\tblues()", object_manager:Blues())
        format_value("\treds()", object_manager:Reds())
        format_value("\tcrabs()", object_manager:Crabs())
        format_value("\tdragons()", object_manager:Dragons())
        format_value("\tspecial_void_minions()", object_manager:SpecialVoidMinions())
        format_value("\theralds()", object_manager:Heralds())
        format_value("\tbarons()", object_manager:Barons())
        format_value("\tallied_wards()", object_manager:AlliedWards())
        format_value("\tenemy_wards()", object_manager:EnemyWards())
        format_value("\tneutral_wards()", object_manager:NeutralWards())
        format_value("\tallied_special_minions()", object_manager:AlliedSpecialMinions())
        format_value("\tenemy_special_minions()", object_manager:EnemySpecialMinions())
        format_value("\tneutral_special_minions()", object_manager:NeutralSpecialMinions())
        format_value("\tallied_plants()", object_manager:AlliedPlants())
        format_value("\tenemy_plants()", object_manager:EnemyPlants())
        format_value("\tneutral_plants()", object_manager:NeutralPlants())
        format_value("\tallied_traps()", object_manager:AlliedTraps())
        format_value("\tenemy_traps()", object_manager:EnemyTraps())
        format_value("\tneutral_traps()", object_manager:NeutralTraps())
        format_value("\tallied_summons()", object_manager:AlliedSummons())
        format_value("\tenemy_summons()", object_manager:EnemySummons())
        format_value("\tneutral_summons()", object_manager:NeutralSummons())
        format_value("\tallied_large_summons()", object_manager:AlliedLargeSummons())
        format_value("\tenemy_large_summons()", object_manager:EnemyLargeSummons())
        format_value("\tneutral_large_summons()", object_manager:NeutralLargeSummons())
        format_value("\tallied_heroes()", object_manager:AlliedHeroes())
        format_value("\tenemy_heroes()", object_manager:EnemyHeroes())
        format_value("\tneutral_heroes()", object_manager:NeutralHeroes())
        format_value("\tattackable_units()", object_manager:AttackableUnits())
        format_value("\tallied_attackable_units()", object_manager:AlliedAttackableUnits())
        format_value("\tenemy_attackable_units()", object_manager:EnemyAttackableUnits())
        format_value("\tneutral_attackable_units()", object_manager:NeutralAttackableUnits())
        format_value("\tai_clients()", object_manager:AiClients())
        format_value("\tallied_ai_clients()", object_manager:AiClients())
        format_value("\tenemy_ai_clients()", object_manager:EnemyAiClients())
        format_value("\tneutral_ai_clients()", object_manager:NeutralAiClients())
    end
    ig.End()
end

local col_particle = 0x99FFFFFF
local col_neutral_camps = 0xFF0000FF
local col_missile = 0xFFFF00FF
local col_inhib = 0xFFFFFF00
local col_nexus = 0xFF00FF00
local col_turret = 0xFF00FF00
local col_minion = 0xFF00FFFF
local col_hero = 0xFF00FF00

local col_ally = 0xFF009900
local col_enemy = 0xFF000099
local col_neutral = 0xFF999999

local draw_object_name = function(vec, col)
    for i = 0, vec.n - 1 do
        local obj = vec.val[i]
        if obj:IsOnScreen() then
            graphics:DrawText3d(obj:Pos(), col, tostring(obj))
        end
    end
end

local draw_object_circle = function(vec, col)
    for i = 0, vec.n - 1 do
        local obj = vec.val[i]
        if obj:IsOnScreen() then
            graphics:DrawCircle3d(obj:Pos(), 30, col, 3, 2)
        end
    end
end

local botm_draw = function()
    draw_object_name(object_manager:Particles(), col_particle)
    draw_object_name(object_manager:NeutralCamps(), col_neutral_camps)
    draw_object_name(object_manager:Missiles(), col_missile)
    draw_object_name(object_manager:Inhibs(), col_inhib)
    draw_object_name(object_manager:Nexus(), col_nexus)
    draw_object_name(object_manager:Turrets(), col_turret)
    draw_object_name(object_manager:Minions(), col_minion)
    draw_object_name(object_manager:Heroes(), col_hero) 

    draw_object_circle(object_manager:AlliedMissiles(), col_ally)
    draw_object_circle(object_manager:EnemyMissiles(), col_enemy)
    draw_object_circle(object_manager:NeutralMissiles(), col_neutral)

    draw_object_circle(object_manager:AlliedInhibs(), col_ally)
    draw_object_circle(object_manager:EnemyInhibs(), col_enemy)
    draw_object_circle(object_manager:NeutralInhibs(), col_neutral)

    draw_object_circle(object_manager:AlliedNexus(), col_ally)
    draw_object_circle(object_manager:EnemyNexus(), col_enemy)
    draw_object_circle(object_manager:NeutralNexus(), col_neutral)

    draw_object_circle(object_manager:AlliedTurrets(), col_ally)
    draw_object_circle(object_manager:EnemyTurrets(), col_enemy)
    draw_object_circle(object_manager:NeutralTurrets(), col_neutral)

    draw_object_circle(object_manager:AlliedMinions(), col_ally)
    draw_object_circle(object_manager:EnemyMinions(), col_enemy)
    draw_object_circle(object_manager:NeutralMinions(), col_neutral)

    draw_object_circle(object_manager:AlliedHeroes(), col_ally)
    draw_object_circle(object_manager:EnemyHeroes(), col_enemy)
    draw_object_circle(object_manager:NeutralHeroes(), col_neutral)
end

return {
    botm_draw_menu = botm_draw_menu,
    botm_draw = botm_draw,
}