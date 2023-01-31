
local ffi = require "ffi"

local demo_h = require "demo_h"
local format_value = demo_h.format_value

local botm_draw_menu = function(p_open)
    if ig.Begin("Demo: Callback Waypoints Change", p_open) then
        format_value("void __cdecl botm_waypoints_change(Hero *obj);", " ")
        ig.NewLine()
        ig.TextWrapped("Callback function triggered when a heros waypoints change")
        ig.NewLine()
        ig.Text("Example:")
        ig.NewLine()
        ig.PushStyleColor(ig.lib.ImGuiCol_Text, demo_h.col_text)
        ig.Text("botm.waypoints_change = function(obj)")
        ig.Text("\tprint(\"botm.waypoints_change\", obj:Name(), obj:Path():EndPos())")
        ig.Text("end")
        ig.PopStyleColor(1)
    end 
    ig.End()
end

local botm_waypoints_change = function(obj)
    print("botm.waypoints_change", obj:Name(), obj:Path():EndPos())
end

return {
    botm_draw_menu = botm_draw_menu,
    botm_waypoints_change = botm_waypoints_change,
}