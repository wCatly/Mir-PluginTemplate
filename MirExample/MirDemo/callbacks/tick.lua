
local ffi = require "ffi"

local demo_h = require "demo_h"
local format_value = demo_h.format_value

local botm_draw_menu = function(p_open)
    if ig.Begin("Demo: Callback Tick", p_open) then
        format_value("void __cdecl botm_uncapped_tick();", "uncapped")
        format_value("void __cdecl botm_before_tick();", "60 ticks per second")
        format_value("void __cdecl botm_tick();", "60 ticks per second")
        format_value("void __cdecl botm_after_tick();", "60 ticks per second")
        format_value("void __cdecl botm_lazy_tick();", "1 tick every 5 seconds")
        ig.NewLine()
        ig.TextWrapped("Callback functions to update the state of your script")
        ig.NewLine()
        ig.TextWrapped("botm_before_tick and botm_after_tick are intended to be used by libraries and are always synched with botm_tick")
        ig.NewLine()
        ig.TextWrapped("For performance reasons, uncapped_tick shall only be used in cases where it is absolutely crucial to update something on every frame. Your script will not run worse if the code is in a normal tick")
        ig.NewLine()
        ig.Text("Example:")
        ig.NewLine()
        ig.PushStyleColor(ig.lib.ImGuiCol_Text, demo_h.col_text)
        ig.Text("botm.tick = function()")
        ig.Text("\tprint(\"botm_tick\", game:Time())")
        ig.Text("end")
        ig.PopStyleColor(1)
    end 
    ig.End()
end

local botm_tick = function()
    print("botm_tick", game:Time())
end

return {
    botm_draw_menu = botm_draw_menu,
    botm_tick = botm_tick,
}