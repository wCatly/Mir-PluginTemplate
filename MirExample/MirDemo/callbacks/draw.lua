
local ffi = require "ffi"

local demo_h = require "demo_h"
local format_value = demo_h.format_value

local botm_draw_menu = function(p_open)
    if ig.Begin("Demo: Callback Draw", p_open) then
        format_value("void __cdecl botm_draw_world();", " ")
        format_value("void __cdecl botm_draw();", " ")
        format_value("void __cdecl botm_draw_menu();", " ")
        ig.NewLine()
        ig.TextWrapped("Callback functions triggered on every frame. Use for rendering")
        ig.NewLine()
        ig.Text("Remarks:")
        ig.BulletText("botm_draw_world renders under game objects")
        ig.BulletText("botm_draw stops being triggered if drawings are disabled")
        ig.BulletText("botm_draw_menu stops being triggered if the menu is closed")
        ig.NewLine()
        ig.Text("Example:")
        ig.NewLine()
        ig.PushStyleColor(ig.lib.ImGuiCol_Text, demo_h.col_text)
        ig.Text("botm.draw_world = function()")
        ig.Text("\tlocal pos = player:Pos()")
        ig.Text("\tlocal color = 0xffffffff")
        ig.Text("\tgraphics:DrawCircle3d(pos, 500, color, 64, 3)")
        ig.Text("end")
        ig.NewLine()
        ig.Text("botm.draw = function()")
        ig.Text("\tlocal pos = game:CursorPos()")
        ig.Text("\tlocal color = 0xffffffff")
        ig.Text("\tgraphics:DrawText2d(pos, color, \"Hello from botm.draw\")")
        ig.Text("end")
        ig.NewLine()
        ig.Text("botm.draw_menu = function()")
        ig.Text("\tif ig.Begin(\"Demo: Callback Draw Menu\", nil, 0) then")
        ig.Text("\t\tig.Text(\"Hello from botm.draw_menu\")")
        ig.Text("\tend")
        ig.Text("\tig.End()")
        ig.Text("end")
        ig.PopStyleColor(1)
    end 
    ig.End()

    if ig.Begin("Demo: Callback Draw Menu", nil, 0) then
        ig.Text("Hello from botm.draw_menu")
    end
    ig.End()
end

local botm_draw_world = function()
    local pos = player:Pos()
    local color = 0xffffffff
    graphics:DrawCircle3d(pos, 500, color, 64, 3)
end

local botm_draw = function()
    local pos = game:CursorPos()
    local color = 0xffffffff
    graphics:DrawText2d(pos, color, "Hello from botm.draw")
end

return {
    botm_draw_menu = botm_draw_menu,
    botm_draw_world = botm_draw_world,
    botm_draw = botm_draw,
}