
local ffi = require "ffi"

local demo_h = require "demo_h"
local format_value = demo_h.format_value

local only_player = ffi.new("bool[1]")

local botm_draw_menu = function(p_open)
    if ig.Begin("Demo: Callback Process Spell", p_open) then
        format_value("void __cdecl botm_process_spell(Spell *spell);", " ")
        ig.NewLine()
        ig.TextWrapped("Callback function triggered when a spell is casted")
        ig.NewLine()
        ig.Checkbox("Print only spells emitted by player", only_player)
        ig.NewLine()
        ig.Text("Example:")
        ig.NewLine()
        ig.PushStyleColor(ig.lib.ImGuiCol_Text, demo_h.col_text)
        ig.TextUnformatted([[
    botm.process_spell = function(spell)
        print("Spell:", spell)
        print("\tmemory_address()", string.format("0x%x", spell:MemoryAddress()))
        print("\tspell_data_resource()", spell:SpellDataResource())
        print("\tstart_pos()", spell:StartPos())
        print("\tend_pos()" , spell:EndPos())
        print("\tend_pos_line()", spell:EndPosLine())
        print("\thas_target()", spell:HasTarget())
        print("\twind_up_time()", spell:WindUpTime())
        print("\tanimation_time()", spell:AnimationTime())
        print("\tslot()", spell:Slot())
        print("\tis_basic_attack()", spell:IsBasicAttack())
        print("\tname()", spell:Name())
        print("\thash()", string.format("0x%x",spell:Hash())
        print("\tsource()", spell:Source())
        print("\ttarget()", spell:Target())
    end
        ]], nil)
        ig.PopStyleColor(1)
    end 
    ig.End()
end

local botm_process_spell = function(spell)
    if only_player[0] then
        local source = spell:Source()
        if source and not source:IsPlayer() then
            return
        end
    end
    print("Spell:", spell)
    print("\tmemory_address()", string.format("0x%x", spell:MemoryAddress()))
    print("\tspell_data_resource()", spell:SpellDataResource())
    print("\tstart_pos()", spell:StartPos())
    print("\tend_pos()" , spell:EndPos())
    print("\tend_pos_line()", spell:EndPosLine())
    print("\thas_target()", spell:HasTarget())
    print("\twind_up_time()", spell:WindUpTime())
    print("\tanimation_time()", spell:AnimationTime())
    print("\tslot()", spell:Slot())
    print("\tis_basic_attack()", spell:IsBasicAttack())
    print("\tname()", spell:Name())
    print("\thash()", string.format("0x%x",spell:Hash()))
    print("\tsource()", spell:Source())
    print("\ttarget()", spell:Target())
    print("")
end

return {
    botm_draw_menu = botm_draw_menu,
    botm_process_spell = botm_process_spell,
}