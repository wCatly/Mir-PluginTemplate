local ffi = require "ffi"

local demo_h = require "demo_h"
local format_value = demo_h.format_value

local my_script_dir = "my_script"

local botm_draw_menu = function(p_open)
    if ig.Begin("Demo: ScriptTor", p_open) then
        if ig.MenuItem("ScriptTor_issue_reload()", "1") then
            script_tor:IssueReload()
        end
        if ig.MenuItem("ScriptTor_issue_unload()", "2") then
            script_tor:IssueUnload()
        end
        if ig.MenuItem("ScriptTor_issue_toggle()", "3") then
            script_tor:IssueToggle()
        end

        ig.NewLine()

        if ig.MenuItem("ScriptTor_add_script(\""..my_script_dir.."\", \"main.lua\")", "") then
            script_tor:AddScript(my_script_dir, "main.lua")
        end
        if ig.MenuItem("ScriptTor_set_script_display_name(\""..my_script_dir.."\", \"My Script\")", "") then
            script_tor:SetScriptDisplayName(my_script_dir, "My Script")
        end
        if ig.MenuItem("ScriptTor_set_script_enabled(\""..my_script_dir.."\", true)", "") then
            script_tor:SetScriptEnabled(my_script_dir, true)
        end
        if ig.MenuItem("ScriptTor_set_script_author(\""..my_script_dir.."\", \"Name\")", "") then
            script_tor:SetScriptAuthor(my_script_dir, "Name")
        end
        if ig.MenuItem("ScriptTor_set_script_version(\""..my_script_dir.."\", \"1.0.0\")", "") then
            script_tor:SetScriptVersion(my_script_dir, "1.0.0")
        end
        if ig.MenuItem("ScriptTor_remove_script(\""..my_script_dir.."\")", "") then
            script_tor:RemoveScript(my_script_dir)
        end
    end
    ig.End()
end

local botm_key_down = function(vk_code)
    if vk_code == 49 then --[1]
        script_tor:IssueReload()
    elseif vk_code == 50 then --[2]
        script_tor:IssueUnload()
    elseif vk_code == 51 then --[3]
        script_tor:IssueToggle()
    end
end

return {
    botm_draw_menu = botm_draw_menu,
    botm_key_down = botm_key_down,
}