
local ffi = require "ffi"

local demo_h = require "demo_h"
local format_value = demo_h.format_value

local botm_draw_menu = function(p_open)
    if ig.Begin("Demo: Callback Load", p_open) then
        format_value("bool __cdecl botm_load(ScriptEnv *env);", " ")
        format_value("void __cdecl botm_unload();", " ")
        ig.NewLine()
        ig.TextWrapped("Callback function triggered once upon load/unload of your script.")
        ig.TextWrapped("Use to initialize/clean up. The return value of botm.load indicates whether your script should be loaded or not")
        ig.NewLine()
        ig.Text("Example:")
        ig.NewLine()
        ig.PushStyleColor(ig.lib.ImGuiCol_Text, demo_h.col_text)
        ig.Text("botm.load = function()")
        ig.Text("\tprint(\"Hello from demo\")")
        ig.Text("\treturn true")
        ig.Text("end")
        ig.NewLine()
        ig.Text("botm.unload = function()")
        ig.Text("\tprint(\"Demo says goodbye\")")
        ig.Text("end")
        ig.PopStyleColor(1)
    end 
    ig.End()
end

local botm_load = function()
    print("Hello from demo")
    return true
end

local botm_unload = function()
    print("Demo says goodbye")
end

return {
    botm_draw_menu = botm_draw_menu,
    botm_load = botm_load,
    botm_unload = botm_unload,
}