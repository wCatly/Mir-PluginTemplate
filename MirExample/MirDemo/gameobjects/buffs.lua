
local ffi = require "ffi"

local demo_h = require "demo_h"
local format_value = demo_h.format_value

local draw_menu = function(aiclient, p_open)
    if not aiclient then
        return
    end
    
    if ig.Begin("Demo: Buffs", p_open) then
        if ig.TreeNode("Enum BuffType") then
            format_value("\tBuffType_Internal", BuffType_Internal)
            format_value("\tBuffType_Aura", BuffType_Aura)
            format_value("\tBuffType_CombatEnhancer", BuffType_CombatEnhancer)
            format_value("\tBuffType_CombatDehancer", BuffType_CombatDehancer)
            format_value("\tBuffType_SpellShield", BuffType_SpellShield)
            format_value("\tBuffType_Stun", BuffType_Stun)
            format_value("\tBuffType_Invisibility", BuffType_Invisibility)
            format_value("\tBuffType_Silence", BuffType_Silence)
            format_value("\tBuffType_Taunt", BuffType_Taunt)
            format_value("\tBuffType_Berserk", BuffType_Berserk)
            format_value("\tBuffType_Polymorph", BuffType_Polymorph)
            format_value("\tBuffType_Slow", BuffType_Slow)
            format_value("\tBuffType_Snare", BuffType_Snare)
            format_value("\tBuffType_Damage", BuffType_Damage)
            format_value("\tBuffType_Heal", BuffType_Heal)
            format_value("\tBuffType_Haste", BuffType_Haste)
            format_value("\tBuffType_SpellImmunity", BuffType_SpellImmunity)
            format_value("\tBuffType_PhysicalImmunity", BuffType_PhysicalImmunity)
            format_value("\tBuffType_Invulnerability", BuffType_Invulnerability)
            format_value("\tBuffType_AttackspeedSlow", BuffType_AttackspeedSlow)
            format_value("\tBuffType_Nearsight", BuffType_Nearsight)
            format_value("\tBuffType_Currency", BuffType_Currency)
            format_value("\tBuffType_Fear", BuffType_Fear)
            format_value("\tBuffType_Charm", BuffType_Charm)
            format_value("\tBuffType_Poison", BuffType_Poison)
            format_value("\tBuffType_Suppression", BuffType_Suppression)
            format_value("\tBuffType_Blind", BuffType_Blind)
            format_value("\tBuffType_Counter", BuffType_Counter)
            format_value("\tBuffType_Shred", BuffType_Shred)
            format_value("\tBuffType_Flee", BuffType_Flee)
            format_value("\tBuffType_KnockUp", BuffType_KnockUp)
            format_value("\tBuffType_KnockBack", BuffType_KnockBack)
            format_value("\tBuffType_Disarm", BuffType_Disarm)
            format_value("\tBuffType_Grounded", BuffType_Grounded)
            format_value("\tBuffType_Drowsy", BuffType_Drowsy)
            format_value("\tBuffType_Asleep", BuffType_Asleep)
            format_value("\tBuffType_Obscured", BuffType_Obscured)
            format_value("\tBuffType_ClickproofToEnemies", BuffType_ClickproofToEnemies)
            format_value("\tBuffType_Unkillable", BuffType_Unkillable)
            ig.TreePop()
        end
        ig.NewLine()
        local buffs = aiclient:Buffs()

        if buffs.n == 0 then
            ig.Text("No buffs")
        end

        for i = buffs.n - 1, 0, -1 do
            local buff = buffs.val[i]
            format_value("Buff:", buff)
            format_value("\tBuff_memory_address()", buff:MemoryAddress(), "0x%x")
            format_value("\tBuff_name()", buff:Name())
            format_value("\tBuff_fnv_hash()", buff:FnvHash(), "0x%x")
            format_value("\tBuff_type()", buff:Type())
            format_value("\tBuff_stacks()", buff:Stacks())
            format_value("\tBuff_stacks2()", buff:Stacks2())
            format_value("\tBuff_start_time()", buff:StartTime())
            format_value("\tBuff_end_time()", buff:EndTime())
            format_value("\tBuff_owner()", buff:Owner())
            format_value("\tBuff_source()", buff:Source())
            if buff:FnvHash() ~= game:FnvHash(buff:Name()) then
                ig.PushStyleColor(ig.lib.ImGuiCol_Text, 0xff00ffff)
                ig.Text("\tFnvHash mismatch ".. string.format("0x%x", game:FnvHash(buff:Name())))
                ig.PopStyleColor()
            end
            ig.NewLine()
        end

        ig.NewLine()
    end
    ig.End()
end

return {
    draw_menu = draw_menu,
}