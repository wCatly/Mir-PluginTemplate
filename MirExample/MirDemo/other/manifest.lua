
local ffi = require "ffi"

local demo_h = require "demo_h"
local format_value = demo_h.format_value

local botm_draw_menu = function(p_open)
    if ig.Begin("Demo: Manifest", p_open) then
        ig.TextWrapped("Information about your script can be specified in a manifest.")
        ig.TextWrapped("The files format is JSON and goes into the root directory of your script")
        ig.NewLine()
        ig.Text("\t\"script_entry\"")
        ig.Text("\t[optional] \"display_name\"\"")
        ig.Text("\t[optional] \"author\"")
        ig.Text("\t[optional] \"version\"")
        ig.Text("\t[optional] \"icon\"")
        ig.Text("\t[optional] \"enabled_by_default\"")
        ig.Text("\t[optional] \"search_tags\"")
        ig.Text("\t[optional] \"hide_from_user\"")
        ig.Text("\t[optional] \"loadscript_id\"")
        ig.NewLine()
        ig.Text("manifest.json example:")
        ig.NewLine()
        ig.PushStyleColor(ig.lib.ImGuiCol_Text, demo_h.col_text)
ig.Text([[
    {
        "script_entry" : "demo.lua",
        "display_name" : "Mir Demo",
        "author" : "Mir Group",
        "version" : "1.0.0",
        "icon" : "icon.png",
        "enabled_by_default" : true,
        "search_tags" : "help;api;"
    }
]])
        ig.PopStyleColor(1)
        
    end
    ig.End()
end

local botm_load = function()

end

return {
    botm_draw_menu = botm_draw_menu,
    botm_load = botm_load,
}