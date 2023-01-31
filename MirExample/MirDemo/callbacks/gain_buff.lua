
local ffi = require "ffi"

local demo_h = require "demo_h"
local format_value = demo_h.format_value

local botm_draw_menu = function(p_open)
    if ig.Begin("Demo: Callback Gain/Lose/Update Buff", p_open) then
        format_value("void __cdecl botm_gain_buff(Buff *buff);", " ")
        format_value("void __cdecl botm_lose_buff(Buff *buff);", " ")
        format_value("void __cdecl botm_update_buff(Buff *buff);", " ")
        ig.NewLine()
        ig.TextWrapped("Callback functions triggered when a Buff is gained, lost or updated")
        ig.PushStyleColor(ig.lib.ImGuiCol_Text, 0xff00ffff)
        ig.PopStyleColor(1)
        ig.NewLine()
        ig.Text("Example:")
        ig.NewLine()
        ig.PushStyleColor(ig.lib.ImGuiCol_Text, demo_h.col_text)
        ig.TextWrapped([[
botm.gain_buff = function(buff)
    print("Gain Buff", buff)
end

botm.lose_buff = function(buff)
    print("Lose Buff", buff)
end

botm.update_buff = function(buff)
    print("Update Buff", buff)
end
        ]])
        ig.PopStyleColor(1)
    end 
    ig.End()
end

local botm_gain_buff = function(buff)
    print("Gain Buff", buff)
end

local botm_lose_buff = function(buff)
    print("Lose Buff", buff)
end

local botm_update_buff = function(buff)
    print("Update Buff", buff)
end

return {
    botm_draw_menu = botm_draw_menu,
    botm_gain_buff = botm_gain_buff,
    botm_lose_buff = botm_lose_buff,
    botm_update_buff = botm_update_buff,
}