
local ffi = require "ffi"

local demo_h = require "demo_h"
local format_value = demo_h.format_value

local botm_draw_menu = function(p_open)
    if ig.Begin("Demo: Callback Keyboard", p_open) then
        format_value("void __cdecl botm_key_up(uint32_t vk_code);", " ")
        format_value("void __cdecl botm_key_down(uint32_t vk_code);", " ")
        format_value("void __cdecl botm_mouse_up(uint32_t vk_code);", " ")
        format_value("void __cdecl botm_mouse_down(uint32_t vk_code);", " ")
        ig.NewLine()
        ig.TextWrapped("Callback functions triggered when a key is pressed.")
        ig.TextWrapped("The passed argument is a virtual key-code")
        ig.NewLine()
        ig.Text("Example:")
        ig.NewLine()
        ig.PushStyleColor(ig.lib.ImGuiCol_Text, demo_h.col_text)
        ig.Text("botm.key_down = function(vk)")
        ig.Text("\tif vk == string.byte(\"M\") then")
        ig.Text("\t\tprint(\"M key pressed\")")
        ig.Text("\tend")
        ig.Text("end")
        ig.PopStyleColor(1)
    end 
    ig.End()
end

local botm_key_down = function(vk)
    if vk == string.byte("M") then
        print("M key pressed")
    end
end

return {
    botm_draw_menu = botm_draw_menu,
    botm_key_down = botm_key_down,
}