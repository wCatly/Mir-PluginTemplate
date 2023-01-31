
local ffi = require "ffi"

local demo_h = require "demo_h"
local format_value = demo_h.format_value

local botm_draw_menu = function(p_open)
    if ig.Begin("Demo: C/C++ Development", p_open, 0) then
        ig.TextWrapped("When developing a C project, you need to link against botm.dll and include the botm_api header. A gcc (MSYS2 MINGW32) example is included in the folder.")
        ig.NewLine()
        ig.Text("libbotm_lapi_xxx.a (optional):")
        ig.Indent()
        ig.BulletText("Can be linked against your C/C++ project statically")
        ig.BulletText("Is an archive of the most used api functions")
        ig.BulletText("Ultrahigh performance - inlines api functions if link time optimization (lto) is enabled")
        ig.BulletText("Other advantages:")
        ig.SameLine()
        ig.TextWrapped("By embedding api functions in your dll, it renders your dll useless on league patches and makes it exponentially harder for cracks to crack old versions of your project. It also lets you discontinue support of your project by simply not updating it anymore")
        ig.BulletText("Disadvantage:")
        ig.SameLine()
        ig.TextWrapped("Your project needs to be manually updated with each league patch")
        ig.BulletText("If a project links against libbotm_lapi it should be specified in the manifest.\n\"script_entry\" is then obsolete and replaced by the specific supported version. Your needs to be fully placed (excluding the manifest) in a subfolder with the supported version being the folder name")
        ig.Indent()
        ig.PushStyleColor(ig.lib.ImGuiCol_Text, demo_h.col_text)
        ig.Text([[
            {
                "display_name" : "My Script",
                ...
                "is_libbotm_lapi" : true,
                "12_23_483_5208_riot" : "my_script.dll",
                "13_1_487_9641_riot" : "my_script.dll"
            }
        ]])
                ig.PopStyleColor(1)
    end
    ig.End()
end

return {
    botm_draw_menu = botm_draw_menu,
}