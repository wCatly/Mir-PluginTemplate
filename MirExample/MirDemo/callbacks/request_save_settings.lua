
local ffi = require "ffi"

local demo_h = require "demo_h"
local format_value = demo_h.format_value

local botm_draw_menu = function(p_open)
    if ig.Begin("Demo: Callback Request Save Settings", p_open) then
        format_value("void __cdecl botm_request_save_settings();", " ")
        ig.NewLine()
        ig.TextWrapped("Callback function occasionally triggered to notify developers to save their script settings")
        ig.NewLine()
        ig.Text("Example:")
        ig.NewLine()
        ig.PushStyleColor(ig.lib.ImGuiCol_Text, demo_h.col_text)
        ig.Text("botm.request_save_settings = function()")
        ig.Text("\tprint(\"save your menu settings here. see sample menu for more information\")")
        ig.Text("end")
        ig.PopStyleColor(1)
    end 
    ig.End()
end

local botm_request_save_settings = function(spell)
    print("save your menu settings here. see sample menu for more information")
end

return {
    botm_draw_menu = botm_draw_menu,
    botm_request_save_settings = botm_request_save_settings,
}