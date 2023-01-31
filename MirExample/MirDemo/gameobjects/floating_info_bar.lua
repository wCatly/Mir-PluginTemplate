
local ffi = require "ffi"

local demo_h = require "demo_h"
local format_value = demo_h.format_value

local v_floating_info_bar = ffi.new("int[1]")
v_floating_info_bar[0] = 0

local draw_border_default = ffi.new("bool[1]")
local draw_selected = ffi.new("bool[1]")
local draw_all = ffi.new("bool[1]")
local v_ui_element = ffi.new("int[1]")

local border_defaults = {}

local find_border_default = function(ai_client)
    local vec = ai_client:FloatingInfoBars()
    if vec.n == 0 then 
        return 
    end
    local info = vec.val[0]
    local hud_base = info:HudBase()
    local vec = hud_base:Elements()
    for i = 0, vec.n - 1 do
        local el = vec.val[i]
        if el:Name():find("Border_Default") then
            return el
        end
    end
end

local get_border_default = function(ai_client)
    local id = ai_client:Id()
    local el = border_defaults[id]
    if el then 
        return el 
    end
    el = find_border_default(ai_client)
    border_defaults[id] = el
    return el
end

local draw_menu = function(ai_client, p_open)
    if ig.Begin("Demo: Floating Info Bar", p_open) then
        ig.Checkbox("Draw Border_Default", draw_border_default)
        ig.Checkbox("Draw Selected Element", draw_selected)
        ig.Checkbox("Draw All Elements", draw_all)
        ig.NewLine()
        local vec = ai_client:FloatingInfoBars()
        ig.SliderInt("##Spellslot", v_floating_info_bar, 0, vec.n-1, "floating_info_bars.val[%d]", ig.lib.ImGuiSliderFlags_NoInput)
        if v_floating_info_bar[0] >= vec.n then 
            floating_info_bars[0] = 0
        end
        ig.NewLine()
        if vec.n > 0 then
            local info = vec.val[v_floating_info_bar[0]]
            format_value("FloatingInfoBar:", info)
            
            local hud_base = info:HudBase()
            local vec = hud_base:Elements()

            format_value("\tis_rendered()", info:IsRendered())
            format_value("\thud_base()", hud_base)
            format_value("\t\tname()", hud_base:Name())
            format_value("\t\telements()", vec)

            ig.Text("\t\t\t") ig.SameLine()
            ig.SliderInt("##UIElement", v_ui_element, 0, vec.n - 1, "vec.val[%d]", ig.lib.ImGuiSliderFlags_NoInput)
            if v_ui_element[0] >= vec.n then v_ui_element[0] = 0 end
            local el = vec.val[v_ui_element[0]]
            format_value("\t\t\tvec.val["..v_ui_element[0].."]", el)
            format_value("\t\t\t\tname()", el:Name())
            format_value("\t\t\t\tcalc_rect()", el:CalcRect())
            format_value("\t\t\t\tis_hud_hit_region()", el:IsHudHitRegion())
            format_value("\t\t\t\tis_hud_text()", el:IsHudText())
            format_value("\t\t\t\tis_hud_texture()", el:IsHudTexture())

            if el:IsHudText() then
                local el = el:AsHudText()
                format_value("\t\t\t\ttext()", el:Text())
            end

            if el:IsHudTexture() then
                local el = el:AsHudTexture()
                local tex = el:Texture()
                if tex then
                    ig.Text("\t\t\t\t\t") ig.SameLine()
                    local uv = el:Uv()
                    ig.Image(tex:TexId(), el:Size(), uv.p_min, uv.p_max)
                    graphics:DrawImage2dEx(tex, game:CursorPos() + float2(50,50), el:Size(), uv.p_min, uv.p_max, 0xffffffff)
                end
            end

            if info:IsRendered() then
                if draw_all[0] then
                    for i = 0, vec.n - 1 do
                        local el = vec.val[i]
                        local rect = el:CalcRect()
                        graphics:DrawRectangle2d(rect.p_min, rect.p_max, 0x22ffffff, 3)
                    end
                end
                if draw_border_default[0] then
                    local el = get_border_default(ai_client)
                    if el then
                        local rect = el:CalcRect()
                        graphics:DrawRectangle2d(rect.p_min, rect.p_max, 0xffffffff, 3)
                    end
                end
                if draw_selected[0] then
                    local rect = el:CalcRect()
                    graphics:DrawRectangle2d(rect.p_min, rect.p_max, 0xffffffff, 3)
                end
            end
        end
    end
    ig.End()
end


local draw = function(ai_client, p_open)

end

return {
    draw_menu = draw_menu,
    draw = draw,
}