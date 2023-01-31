
local ffi = require "ffi"

local demo_h = require "demo_h"
local format_value = demo_h.format_value

local botm_draw_menu = function(p_open)
    if ig.Begin("Demo: Callback Play Animation", p_open, 0) then
        format_value("void __cdecl botm_play_animation(GameObject *obj, const char* name);", " ")
        ig.NewLine()
        ig.TextWrapped("Callback functions triggered when an animation is played")
        ig.PushStyleColor(ig.lib.ImGuiCol_Text, 0xff00ffff)
        ig.PopStyleColor(1)
        ig.NewLine()
        ig.Text("Example:")
        ig.NewLine()
        ig.PushStyleColor(ig.lib.ImGuiCol_Text, demo_h.col_text)
        ig.TextWrapped([[
botm.play_animation = function(obj, name)
    print("Animation", obj, name)
end
        ]])
        ig.PopStyleColor(1)
    end 
    ig.End()
end

local botm_play_animation = function(obj, name)
    print("Animation", obj, name)
end

return {
    botm_draw_menu = botm_draw_menu,
    botm_play_animation = botm_play_animation,
}