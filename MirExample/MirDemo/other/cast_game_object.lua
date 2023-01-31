
local ffi = require "ffi"

local demo_h = require "demo_h"
local format_value = demo_h.format_value

local col_good = ig.ColorConvertU32ToFloat4(0xff009900)

local botm_draw_menu = function(p_open)    
    if ig.Begin("Demo: Cast GameObject*", p_open) then
        ig.TextWrapped("GameObject is the base class for the following objects:")
        ig.BulletText("Particle")
        ig.BulletText("Missile")
        ig.BulletText("NeutralCamp")
        ig.BulletText("Inhib")
        ig.BulletText("Nexus")
        ig.BulletText("Turret")
        ig.BulletText("Minion")
        ig.BulletText("Hero")
        ig.BulletText("Player")
        ig.TextWrapped("\nSome of the BotM API functions return a pointer to a GameObject. Because the GameObject interface is very limited you often want to have access to the functions of the derived class. You can do so by using obj:AsType()\n\n")
        ig.PushStyleColor(ig.lib.ImGuiCol_Text, demo_h.col_text)
        ig.Text("local obj = game:SelectedTarget()")
        ig.Text("if obj and obj:IsMinion() then")
        ig.TextColored(col_good, "\tobj = obj:AsMinion()")
        ig.Text("\tlocal is_dragon = obj:IsDragon()")
        ig.Text("end")
        ig.PopStyleColor(1)
        ig.TextWrapped("\nThe equivalent C code uses a classic C cast\n\n")
        ig.PushStyleColor(ig.lib.ImGuiCol_Text, demo_h.col_text)
        ig.Text("GameObject *obj = Game_selected_target(game);")
        ig.Text("if (obj && GameObject_is_minion(obj)) {")
        ig.TextColored(col_good, "\tMinion *m = (Minion*)obj;")
        ig.Text("\tbool is_dragon = Minion_is_dragon(m);")
        ig.Text("}")
        ig.PopStyleColor(1)
    end 
    ig.End()
end

return {
    botm_draw_menu = botm_draw_menu,
}