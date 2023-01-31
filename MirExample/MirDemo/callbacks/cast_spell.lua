
local ffi = require "ffi"

local demo_h = require "demo_h"
local format_value = demo_h.format_value

local botm_draw_menu = function(p_open)
    if ig.Begin("Demo: Callback Cast Spell", p_open) then
        format_value("void __cdecl botm_cast_spell(CastSpellInfo *info);", " ")
        ig.NewLine()
        ig.TextWrapped("Callback function triggered when a script calls one of the cast_spell functions.")
        ig.TextWrapped("Refer to the botm_game_event callback to intercept input by the user.")
        ig.NewLine()
        ig.Text("Example:")
        ig.NewLine()
        ig.PushStyleColor(ig.lib.ImGuiCol_Text, demo_h.col_text)
        ig.Text("botm.cast_spell = function(info)")
        ig.Text("\t--pos, pos2, target fields may be altered to change the spell cast")
        ig.Text("\t--block field may be set to true to block the spell cast")
        ig.Text("\tprint(\"botm.cast_spell\", info.slot, info.pos, info.pos2, info.target)")
        ig.Text("end")
        ig.PopStyleColor(1)  
    end
    ig.End()
end

local botm_cast_spell = function(info)
    print("botm_cast_spell", info.slot, info.pos, info.pos2, info.target)
    --info.block = true
    --info.pos.z = info.pos.z + 300
end

return {
    botm_draw_menu = botm_draw_menu,
    botm_cast_spell = botm_cast_spell,
}