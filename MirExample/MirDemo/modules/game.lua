local ffi = require "ffi"

local demo_h = require "demo_h"
local format_value = demo_h.format_value

local ping_i = 0
local ping_client_i = 0

local ping = function()
    print("ping", ping_i)
    game:Ping(ping_i, game:MousePos(), game:SelectedTarget())
    ping_i = ping_i + 1
end

local ping_client = function()
    print("ping client", ping_client_i)
    game:PingClient(ping_client_i, game:MousePos(), game:SelectedTarget())
    ping_client_i = ping_client_i + 1
end

local botm_draw_menu = function(p_open)
    if ig.Begin("Demo: Game", p_open) then
        if ig.TreeNode("Enum GamePing") then
            format_value("\tGamePing_Alert", GamePing_Alert)
            format_value("\tGamePing_Caution", GamePing_Caution)
            format_value("\tGamePing_OnMyWay", GamePing_OnMyWay)
            format_value("\tGamePing_EnemyMissing", GamePing_EnemyMissing)
            format_value("\tGamePing_Retreat", GamePing_Retreat)
            format_value("\tGamePing_AssistMe", GamePing_AssistMe)
            format_value("\tGamePing_Push", GamePing_Push)
            format_value("\tGamePing_AllIn", GamePing_AllIn)
            format_value("\tGamePing_Hold", GamePing_Hold)
            format_value("\tGamePing_Bait", GamePing_Bait)
            format_value("\tGamePing_EnemyVision", GamePing_EnemyVision)
            format_value("\tGamePing_NeedVision", GamePing_NeedVision)
            format_value("\tGamePing_VisionCleared", GamePing_VisionCleared)
            format_value("\tGamePing_COUNT", GamePing_COUNT)
            ig.TreePop()
        end
        ig.NewLine()
        format_value("Game:", game)
        format_value("\tmouse_pos()", game:MousePos())
        format_value("\tcursor_pos()", game:CursorPos())
        format_value("\ttime()", game:Time())
        format_value("\tlatency()", game:Latency())
        format_value("\tpath_update_timer()", game:PathUpdateTimer())
        format_value("\tfnv_hash(\"test_string\")", game:FnvHash("test_string"), "0x%x")
        format_value("\tcommand_line()", " ")
        ig.Text("\t\t")
        ig.SameLine()
        ig.TextWrapped(game:CommandLine())
        format_value("\tmap_id()", game:MapId())
        format_value("\tmap()", game:Map())
        format_value("\tmutators()", game:Mutators())
        local mutators = game:Mutators()
        for i = 0, mutators.n - 1 do
            format_value("\t\tval["..i.."]", ffi.string(mutators.val[i]))
        end
        format_value("\tmode()", game:Mode())
        format_value("\ttype()", game:Type())
        format_value("\tid()", game:Id())
        format_value("\tplatform_id()", game:PlatformId())
        format_value("\tversion()",  game:Version())
        format_value("\tis_window_focused()", game:IsWindowFocused())
        format_value("\tselected_target()", game:SelectedTarget())
        format_value("\thovered_target()", game:HoveredTarget())
        format_value("\ttextures()", game:Textures())

        ig.NewLine()

        if ig.MenuItem("Game_ping("..ping_i..", mouse_pos, selected_target)", "1") then
            ping()
        end

        if ig.MenuItem("Game_ping_client("..ping_client_i..", mouse_pos, selected_target)", "2") then
            ping_client()
        end
    end
    ig.End()
end

local botm_key_down = function(vk_code)
    if vk_code == 49 then --[1]
        ping()
    elseif vk_code == 50 then --[2]
        ping_client()
    end
end

return {
    botm_draw_menu = botm_draw_menu,
    botm_key_down = botm_key_down,
}