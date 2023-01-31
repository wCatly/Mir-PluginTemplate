local ffi = require "ffi"

local demo_h = require "demo_h"
local format_value = demo_h.format_value

local botm_draw_menu = function(p_open)
    if ig.Begin("Demo: BotM", p_open) then
        if ig.TreeNode("Enum BotMLanguage") then
            format_value("\tBotMLanguage_En", BotMLanguage_En)
            format_value("\tBotMLanguage_Cn", BotMLanguage_Cn)
            ig.TreePop()
        end
        ig.NewLine()
        format_value("BotM:", bot)
        format_value("\tversion()", bot:Version())
        format_value("\tlanguage()", bot:Language())
        format_value("\tget_directory()", bot:GetDirectory())
        format_value("\tget_script_directory()", bot:GetScriptDirectory())
        format_value("\tis_menu_open()", bot:IsMenuOpen())
        format_value("\tis_draw_enabled()", bot:IsDrawEnabled())
        ig.NewLine()

        if ig.MenuItem("Toggle Menu", "1") then
            bot:IssueToggleMenu()
        end
        if ig.MenuItem("Toggle Drawings", "2") then
            bot:IssueToggleDrawings()
        end
    end
    ig.End()
end

local botm_draw = function()
    local str = "Waiting for [2] Toggle Drawings"
    local pos = game:CursorPos()
    graphics:DrawText2d(pos, 0xffffffff, str)
end

local botm_key_down = function(vk_code)
    if vk_code == 49 then --[1]
        bot:IssueToggleMenu()
    elseif vk_code == 50 then --[2]
        bot:IssueToggleDrawings()
    end
end

return {
    botm_draw_menu = botm_draw_menu,
    botm_draw = botm_draw,
    botm_key_down = botm_key_down,
}