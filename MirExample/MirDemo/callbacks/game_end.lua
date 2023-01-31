
local ffi = require "ffi"

local demo_h = require "demo_h"
local format_value = demo_h.format_value

local botm_draw_menu = function(p_open)
    if ig.Begin("Demo: Callback Game End", p_open, 0) then
        format_value("void __cdecl botm_game_end();", " ")
        ig.NewLine()
        ig.TextWrapped("Callback function triggered once a game ends")
        ig.NewLine()
        ig.Text("Example:")
        ig.NewLine()
        ig.PushStyleColor(ig.lib.ImGuiCol_Text, demo_h.col_text)
        ig.Text("botm.game_end = function()")
        ig.Text("\tprint(\"The game has ended\")")
        ig.Text("end")
        ig.NewLine()
        ig.PopStyleColor(1)
    end 
    ig.End()
end

local game_end = function()
    print("The game has ended")
end

return {
    botm_draw_menu = botm_draw_menu,
    game_end = game_end,

}