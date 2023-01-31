
local ffi = require "ffi"

local demo_h = require "demo_h"
local format_value = demo_h.format_value

local botm_draw_menu = function(p_open)
    if ig.Begin("Demo: Lua Development", p_open, 0) then
        ig.TextWrapped("LuaJIT 2.1.0-beta3 (http://luajit.org/)")
        ig.NewLine()
        ig.Text("Create your project:")
        ig.BulletText("Copy folder mir\\scripts\\example_lua")
        ig.BulletText("Modify manifest.json (inside the folder)")
        ig.BulletText("Reload the launcher")
        ig.NewLine()
        ig.TextWrapped("Mir is fully upwards-compatible with LuaJIT. It supports all standard Lua library functions")
        ig.NewLine()
        
        -- ig.PushStyleColor(ig.lib.ImGuiCol_Text, demo_h.col_text)
        -- ig.Text([[
        --     {
        --         "display_name" : "My Script",
        --         ...
        --         "is_libbotm_lapi" : true,
        --         "12_23_483_5208_riot" : "12_23_483_5208_riot\\my_script.dll",
        --         "13_1_487_9641_riot" : "13_1_487_9641_riot\\my_script.dll"
        --     }
        -- ]])
        -- ig.PopStyleColor(1)
    end
    ig.End()
end

return {
    botm_draw_menu = botm_draw_menu,
}