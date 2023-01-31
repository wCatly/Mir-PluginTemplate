
local ffi = require "ffi"

local window_name = "Demo: Sample Menu"
local ini_file = "sample_menu.ini"

local combo_str = "combo item 1\0combo item 2\0combo item 3\0"
local combo_selection = ffi.new("int[1]")

local checkbox = ffi.new("bool[1]")
local slider_float = ffi.new("float[1]")
local slider_int = ffi.new("int[1]")
local color = ffi.new("float[4]")
local hotkey = ig.CreateHotkey()

local color_text = ig.ColorConvertU32ToFloat4(0xffff00ff)

local load_ini = function()
    ini:SetTarget(ini_file)

    checkbox[0] = ini:GetBool("SectionName", "checkbox", 0)
    slider_float[0] = ini:GetFloat("SectionName", "slider_float", 2.5)
    slider_int[0] = ini:GetLong("SectionName", "slider_int", 5)
    combo_selection[0] = ini:GetLong("SectionName", "combo_selection", 2)
    ini:GetHotkey("SectionName", "hotkey", hotkey, string.byte("B"), false, false)
end

local save_ini = function()
    ini:SetTarget(ini_file)

    ini:SetBool("SectionName", "checkbox", checkbox[0])
    ini:SetFloat("SectionName", "slider_float", slider_float[0])
    ini:SetLong("SectionName", "slider_int", slider_int[0])
    ini:SetLong("SectionName", "combo_selection", combo_selection[0])
    ini:SetHotkey("SectionName", "hotkey", hotkey)
end

local icon_0 = player:SpellSlot(0):Icon()

local botm_draw_menu = function(p_open)
    ig.ShowDemoWindow()
    if ig.Begin(window_name, p_open, ig.lib.ImGuiWindowFlags_None) then
        ig.PushStyleColor(ig.lib.ImGuiCol_Text, 0xff00ffff)
        ig.Text("This is just a small example to get quickstarted")
        ig.NewLine()
        ig.Text("ImGui is fully supported for the Lua and C/C++ environment:")
        ig.BulletText("C/C++: \"botm_sdk/include/cimgui.h\" (https://github.com/cimgui/cimgui)")
        ig.BulletText("LuaJIT: \"botm_sdk/misc/cimgui.lua\" (already loaded!) (https://github.com/sonoro1234/LuaJIT-ImGui)")
        ig.PopStyleColor()
        ig.NewLine()

        if icon_0 then
            ig.Image(icon_0:TexId(), float2(64, 64))
            ig.SameLine() ig.Text("Image")
        end
        ig.Text("IconsFontAwesome6 "..icons.Telegram.." "..icons.ScrewdriverWrench)
        ig.TextUnformatted("unformatted text")
        ig.Text("text")
        ig.PushChineseFont()
        ig.Text("你好世界")
        ig.PopChineseFont()
        ig.TextColored(color_text, "colored text")
        ig.TextDisabled("disabled text")
        ig.TextWrapped("this is a wrapped text")
        ig.BulletText("this is a bullet text")
        ig.Text("hover me for tooltip")
        if ig.IsItemHovered(ig.lib.ImGuiHoveredFlags_None) then
            ig.BeginTooltip()
            ig.SetTooltip("this is a tooltip")
            ig.EndTooltip()
        end
        if ig.Checkbox("checkbox", checkbox) then
            print("checkbox toggled. new value: " .. tostring(checkbox[0]))
        end
        if ig.CollapsingHeader("collapsing header", nil, 0) then
            ig.Text("hello")
        end
        if ig.TreeNode("tree node") then
            ig.Text("hello")
            ig.TreePop()
        end
        ig.SliderFloat("float slider", slider_float, 0, 10, "%f", ig.lib.ImGuiSliderFlags_NoInput)
        ig.SliderInt("int slider", slider_int, 0, 10, "%d", ig.lib.ImGuiSliderFlags_NoInput)
        if ig.Combo_Str("combo list", combo_selection, combo_str) then
            print("combo selection", combo_selection[0])
        end
        if ig.Button("button") then
            print("button pressed")
        end
        ig.SameLine()
        if ig.SmallButton("small button") then
            print("small button pressed")
        end
        if ig.ColorEdit4("color edit", color, ig.lib.ImGuiColorEditFlags_AlphaBar) then
            print("color changed:", color[0], color[1], color[2], color[3])
        end
        --print(color[0], color[1], color[2], color[3])
        ig.Hotkey("hotkey", hotkey)
        ig.NewLine()
        ig.Text("hotkey:IsPressed() %s", tostring(hotkey:IsPressed()))
        if ig.Button("hotkey:SetKey(16)") then
            print("change hotkey")
            hotkey:SetKey(16);
        end
        ig.Text("hotkey:GetKey() %s", tostring(hotkey:GetKey()))
        ig.Text("hotkey:GetKeyString() %s", hotkey:GetKeyString())
    end
    ig.End()
end

local botm_load = function()
    load_ini()
end

local botm_request_save_settings = function()
    save_ini()
end

return {
    botm_draw_menu = botm_draw_menu,
    botm_load = botm_load,
    botm_request_save_settings = botm_request_save_settings,

    save_ini = save_ini,

    checkbox = checkbox,
    slider_float = slider_float,
    slider_int = slider_int,
    combo_selection = combo_selection,
    hotkey = hotkey,
}