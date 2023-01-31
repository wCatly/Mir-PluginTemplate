local ffi = require "ffi"

local demo_h = require "demo_h"
local format_value = demo_h.format_value

local flip_minimap = ffi.new("bool[1]")
local show_summoner_names = ffi.new("uint32_t[1]")
local minimap_scale = ffi.new("float[1]")

local botm_draw_menu = function(p_open)
    if ig.Begin("Demo: Options", p_open) then

        flip_minimap[0] = options:FindBool("HUD", "FlipMiniMap")
        format_value("Options_find_bool('HUD', 'FlipMiniMap')", flip_minimap[0])
        local fmt = string.format("Options_change_bool('HUD', 'FlipMiniMap', %s)", tostring(flip_minimap[0]))
        if ig.Checkbox(fmt, flip_minimap) then
            options:ChangeBool("HUD", "FlipMiniMap", flip_minimap[0])
        end
        ig.NewLine()

        show_summoner_names[0] = options:FindInt("HUD", "ShowSummonerNames")
        format_value("Options_find_int('HUD', 'ShowSummonerNames')", show_summoner_names[0])
        ig.SliderInt("##slider1", show_summoner_names, 0, 2, "Options_change_int('HUD', 'ShowSummonerNames', %i)", 0)
        options:ChangeInt("HUD", "ShowSummonerNames", show_summoner_names[0])
        ig.NewLine()

        minimap_scale[0] = options:FindFloat("HUD", "MinimapScale")
        format_value("Options_find_float('HUD', 'MinimapScale')", minimap_scale[0])
        if ig.SliderFloat("##slider", minimap_scale, 0, 3, "Options_change_float('HUD', 'MinimapScale', %f)", 0) then
            options:ChangeFloat("HUD", "MinimapScale", minimap_scale[0])
        end
        ig.NewLine()

        format_value("Options_find_key_pair('GameEvents', 'evtCastSpell1')", options:FindKeyPair("GameEvents", "evtCastSpell1"))

        ig.NewLine()

        if ig.MenuItem("Options_print()", "1") then
            options:Print()
        end
        if ig.MenuItem("Options_change_key_pair('GameEvents', 'evtCastSpell1', '[x]', '')", "2") then
            options:ChangeKeyPair("GameEvents", "evtCastSpell1", "[x]", "")
        end
        if ig.MenuItem("Options_change_key_pair('GameEvents', 'evtCastSpell1', '[q]', '')", "3") then
            options:ChangeKeyPair("GameEvents", "evtCastSpell1", "[q]", "")
        end

    end
    ig.End()
end

local botm_key_down = function(vk_code)
    if vk_code == 49 then --[1]
        options:Print()
    elseif vk_code == 50 then --[2]
        options:ChangeKeyPair("GameEvents", "evtCastSpell1", "[x]", "")
    elseif vk_code == 51 then --[3]
        options:ChangeKeyPair("GameEvents", "evtCastSpell1", "[q]", "")
    end
end

return {
    botm_draw_menu = botm_draw_menu,
    botm_key_down = botm_key_down,
}