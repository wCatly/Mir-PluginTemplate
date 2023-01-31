
local ffi = require "ffi"

local demo_h = require "demo_h"
local format_value = demo_h.format_value

local v_spell_slot = ffi.new("int[1]")
v_spell_slot[0] = 0

local draw_menu = function(aiclient, p_open)
    if ig.Begin("Demo: SpellSlot", p_open) then
        if ig.TreeNode("Enum SpellSlot") then
            format_value("\tSpellSlot_Q", SpellSlot_Q)
            format_value("\tSpellSlot_W", SpellSlot_W)
            format_value("\tSpellSlot_E", SpellSlot_E)
            format_value("\tSpellSlot_R", SpellSlot_R)
            format_value("\tSpellSlot_Summoner1", SpellSlot_Summoner1)
            format_value("\tSpellSlot_Summoner2", SpellSlot_Summoner2)
            format_value("\tSpellSlot_Item1", SpellSlot_Item1)
            format_value("\tSpellSlot_Item2", SpellSlot_Item2)
            format_value("\tSpellSlot_Item3", SpellSlot_Item3)
            format_value("\tSpellSlot_Item4", SpellSlot_Item4)
            format_value("\tSpellSlot_Item5", SpellSlot_Item5)
            format_value("\tSpellSlot_Item6", SpellSlot_Item6)
            format_value("\tSpellSlot_Trinket", SpellSlot_Trinket)
            format_value("\tSpellSlot_Recall", SpellSlot_Recall)
            format_value("\tSpellSlot_14", SpellSlot_14)
            format_value("\tSpellSlot_15", SpellSlot_15)
            format_value("\tSpellSlot_16", SpellSlot_16)
            format_value("\tSpellSlot_17", SpellSlot_17)
            format_value("\tSpellSlot_18", SpellSlot_18)
            format_value("\tSpellSlot_19", SpellSlot_19)
            format_value("\tSpellSlot_20", SpellSlot_20)
            format_value("\tSpellSlot_21", SpellSlot_21)
            format_value("\tSpellSlot_22", SpellSlot_22)
            format_value("\tSpellSlot_23", SpellSlot_23)
            format_value("\tSpellSlot_24", SpellSlot_24)
            format_value("\tSpellSlot_25", SpellSlot_25)
            format_value("\tSpellSlot_26", SpellSlot_26)
            format_value("\tSpellSlot_27", SpellSlot_27)
            format_value("\tSpellSlot_28", SpellSlot_28)
            format_value("\tSpellSlot_29", SpellSlot_29)
            format_value("\tSpellSlot_30", SpellSlot_30)
            format_value("\tSpellSlot_31", SpellSlot_31)
            format_value("\tSpellSlot_32", SpellSlot_32)
            format_value("\tSpellSlot_33", SpellSlot_33)
            format_value("\tSpellSlot_34", SpellSlot_34)
            format_value("\tSpellSlot_35", SpellSlot_35)
            format_value("\tSpellSlot_36", SpellSlot_36)
            format_value("\tSpellSlot_37", SpellSlot_37)
            format_value("\tSpellSlot_38", SpellSlot_38)
            format_value("\tSpellSlot_39", SpellSlot_39)
            format_value("\tSpellSlot_40", SpellSlot_40)
            format_value("\tSpellSlot_41", SpellSlot_41)
            format_value("\tSpellSlot_42", SpellSlot_42)
            format_value("\tSpellSlot_43", SpellSlot_43)
            format_value("\tSpellSlot_44", SpellSlot_44)
            format_value("\tSpellSlot_45", SpellSlot_45)
            format_value("\tSpellSlot_46", SpellSlot_46)
            format_value("\tSpellSlot_47", SpellSlot_47)
            format_value("\tSpellSlot_48", SpellSlot_48)
            format_value("\tSpellSlot_49", SpellSlot_49)
            format_value("\tSpellSlot_50", SpellSlot_50)
            format_value("\tSpellSlot_51", SpellSlot_51)
            format_value("\tSpellSlot_52", SpellSlot_52)
            format_value("\tSpellSlot_53", SpellSlot_53)
            format_value("\tSpellSlot_54", SpellSlot_54)
            format_value("\tSpellSlot_55", SpellSlot_55)
            format_value("\tSpellSlot_56", SpellSlot_56)
            format_value("\tSpellSlot_57", SpellSlot_57)
            format_value("\tSpellSlot_58", SpellSlot_58)
            format_value("\tSpellSlot_59", SpellSlot_59)
            format_value("\tSpellSlot_60", SpellSlot_60)
            format_value("\tSpellSlot_61", SpellSlot_61)
            format_value("\tSpellSlot_62", SpellSlot_62)
            format_value("\tSpellSlot_Passive", SpellSlot_Passive)
            format_value("\tSpellSlot_COUNT", SpellSlot_COUNT)
            
            ig.TreePop()
        end
        if ig.TreeNode("Enum TargetingType") then
            format_value("\tTargetingType_Self", TargetingType_Self)
            format_value("\tTargetingType_Target", TargetingType_Target)
            format_value("\tTargetingType_Area", TargetingType_Area)
            format_value("\tTargetingType_Cone", TargetingType_Cone)
            format_value("\tTargetingType_SelfAoe", TargetingType_SelfAoe)
            format_value("\tTargetingType_TargetOrLocation", TargetingType_TargetOrLocation)
            format_value("\tTargetingType_Location", TargetingType_Location)
            format_value("\tTargetingType_Direction", TargetingType_Direction)
            format_value("\tTargetingType_DragDirection", TargetingType_DragDirection)
            format_value("\tTargetingType_LineTargetToCaster", TargetingType_LineTargetToCaster)
            format_value("\tTargetingType_AreaClamped", TargetingType_AreaClamped)
            format_value("\tTargetingType_LocationClamped", TargetingType_LocationClamped)
            format_value("\tTargetingType_TerrainLocation", TargetingType_TerrainLocation)
            format_value("\tTargetingType_TerrainType", TargetingType_TerrainType)
            format_value("\tTargetingType_LineTerrainToCaster", TargetingType_LineTerrainToCaster)
            ig.TreePop()
        end
        ig.NewLine()
        ig.SliderInt("##Spellslot", v_spell_slot, SpellSlot_Q, SpellSlot_COUNT-1, "spell_slot(%d)", ig.lib.ImGuiSliderFlags_NoInput)
        ig.NewLine()
        local spell_slot = aiclient:SpellSlot(v_spell_slot[0])
        format_value("SpellSlot:", spell_slot)
        if spell_slot then
            format_value("\tmemory_address()", spell_slot:MemoryAddress(), "0x%x")
            format_value("\tname()", spell_slot:Name())
            format_value("\tfnv_hash()", spell_slot:FnvHash(), "0x%x")
            format_value("\thash()", spell_slot:Hash(), "0x%x")
            format_value("\tlevel()", spell_slot:Level())
            format_value("\tcooldown_end()", spell_slot:CooldownEnd())
            format_value("\ttotal_cooldown()", spell_slot:TotalCooldown())
            format_value("\tammo()", spell_slot:Ammo())
            format_value("\tammo_cooldown_end()", spell_slot:AmmoCooldownEnd())
            format_value("\tanimation_end()", spell_slot:AnimationEnd())
            format_value("\tis_in_animation()", spell_slot:IsInAnimation())
            format_value("\ttoggle_state()", spell_slot:ToggleState())
            format_value("\ttargeting_type()", spell_slot:TargetingType())
            local icon = spell_slot:Icon()
            format_value("\ticon()", icon)
            if icon then
                ig.Text("\t\t") ig.SameLine()
                local uv = icon:Uv()
                ig.Image(icon:TexId(), icon:Size(), uv.p_min, uv.p_max)
            end
            if spell_slot:FnvHash() ~= game:FnvHash(spell_slot:Name()) then
                ig.PushStyleColor(ig.lib.ImGuiCol_Text, 0xff00ffff)
                ig.Text("\tFnvHash mismatch ".. string.format("0x%x", game:FnvHash(spell_slot:Name())))
                ig.PopStyleColor()
            end
        end
    end
    ig.End()
end

local draw = function(aiclient)
    local spell_slot = aiclient:SpellSlot(v_spell_slot[0])
    if not spell_slot then
        return
    end

    local icon = spell_slot:Icon()
    if icon then
        graphics:DrawImage2d(icon, game:CursorPos())
    end
end

return {
    draw_menu = draw_menu,
    draw = draw,
}