
local ffi = require "ffi"

local demo_h = require "demo_h"
local format_value = demo_h.format_value

local botm_draw_menu = function(p_open)
    if ig.Begin("Demo: Callback Spell Execute", p_open) then
        format_value("void __cdecl botm_spell_execute(Spell *spell);", " ")
        ig.NewLine()
        ig.TextWrapped("Callback function triggered when a spell is executed")
        ig.NewLine()
        ig.Text("Example:")
        ig.NewLine()
        ig.PushStyleColor(ig.lib.ImGuiCol_Text, demo_h.col_text)
        ig.Text("botm.spell_execute = function(spell)")
        ig.Text("\tprint(\"botm.spell_execute\", spell)")
        ig.Text("end")
        ig.PopStyleColor(1)
    end 
    ig.End()
end

local botm_spell_execute = function(spell)
    print("botm.spell_execute", spell)
end

return {
    botm_draw_menu = botm_draw_menu,
    botm_spell_execute = botm_spell_execute,
}