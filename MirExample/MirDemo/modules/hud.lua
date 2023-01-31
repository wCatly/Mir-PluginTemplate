local ffi = require "ffi"

local demo_h = require "demo_h"
local format_value = demo_h.format_value

local v_debug = ffi.new("bool[1]")

local filter = {
    children = ffi.new("bool[1]"),
    inactive_root = ffi.new("bool[1]"),
    inactive_children = ffi.new("bool[1]"),
    inactive_elements = ffi.new("bool[1]"),
}

local is_hud_element_hovered = function(el)
    local pos = game:CursorPos()
    local rect = el:CalcRect()
    local p_min = rect.p_min
    local p_max = rect.p_max
    return pos.x > p_min.x and pos.x < p_max.x and pos.y > p_min.y and pos.y < p_max.y
end

local print_hud_element = function(el)
    print("HudElement:", el)
    print("\tmemory_address()", string.format("%x", el:MemoryAddress()))
    print("\tname()", el:Name())

    local parent = el:Parent()
    print("\tparent()", parent)
    print("\t\tname()", parent:Name())
    print("\t\tis_root()", parent:IsRoot())
    print("\t\troot()", parent:Root())
    print("\t\telements()", parent:Elements())
    print("\t\tchildren()", parent:Children())
    print("\t\tis_active()", parent:IsActive())
    print("\t\tis_dragged()", parent:IsDragged())

    print("\tcalc_rect()", el:CalcRect())

    print("\tis_hud_hit_region()", el:IsHudHitRegion())
    if el:IsHudHitRegion() then
        local el = el:AsHudHitRegion()
        print("\t\tis_active()", el:IsActive())
    end

    print("\tis_hud_text()", el:IsHudText())
    if el:IsHudText() then
        local el = el:AsHudText()
        print("\t\ttext()", el:Text())
    end

    print("\tis_hud_texture()", el:IsHudTexture())
    if el:IsHudTexture() then
        local el = el:AsHudTexture()
        print("\t\ttexture()", el:Texture())
    end

    print("\tis_hud_group()", el:IsHudGroup())
    if el:IsHudGroup() then
        local el = el:AsHudGroup()
        print("\t\tgroup_index()", el:GroupIndex())
    end

    print("\tis_hud_button()", el:IsHudButton())
    if el:IsHudButton() then
        local el = el:AsHudButton()
        print("\t\tcan_trigger()", el:CanTrigger())
        local hit_region = el:HitRegion()
        print("\t\thit_region()", hit_region)
        if hit_region then
            print("\t\t\tis_active()", hit_region:IsActive())
        end
    end
    print("")
end

local is_active_hud_element = function(el)
    if el:IsHudHitRegion() then
        local el = el:AsHudHitRegion()
        return el:IsActive()
    end
    if el:IsHudButton() then
        local el = el:AsHudButton()
        return el:HitRegion():IsActive()
    end
end

local function debug_hud_base(base, filter, print_hovered)
    if not filter.children[0] then
        local children = base:Children()
        for i = 0, children.n - 1 do
            local child = children.val[i]
            if not filter.inactive_children[0] or child:IsActive() then
                debug_hud_base(child, filter, print_hovered)
            end
        end
    end

    local col = 0x33ffffff
    if filter.inactive_elements[0] then
        col = 0x6600ff00
    end
    if base:IsDragged() then
        col = 0x3300ffff
    end

    local elements = base:Elements()
    for i = 0, elements.n - 1 do
        local el = elements.val[i]
        if not filter.inactive_elements[0] or is_active_hud_element(el) then
            local rect = el:CalcRect()
            if print_hovered then
                if is_hud_element_hovered(el) then
                    print_hud_element(el)
                end
            else
                graphics:DrawRectangle2d(rect.p_min, rect.p_max, col, 3)
            end
        end
    end
end

local botm_draw_menu = function(p_open)
    if ig.Begin("Demo: Hud", p_open) then
        ig.Checkbox("Debug", v_debug)
        if v_debug[0] then
            format_value("\tPress M to print hovered elements", " ")
            ig.Text("\t")
            ig.SameLine()
            ig.Checkbox("No inactive roots", filter.inactive_root)
            if filter.inactive_root[0] then
                ig.Text("\t\t")
                ig.SameLine()
                ig.Checkbox("No inactive children", filter.inactive_children)
                if filter.inactive_children[0] then
                    ig.Text("\t\t\t")
                    ig.SameLine()
                    ig.Checkbox("No inactive elements", filter.inactive_elements)
                end
            end
            if not filter.inactive_root[0] then
                filter.inactive_children[0] = false
            end
            if not filter.inactive_children[0] then
                filter.inactive_elements[0] = false
            end
            ig.Text("\t")
            ig.SameLine()
            ig.Checkbox("No children", filter.children)
        end
        ig.NewLine()
        format_value("Hud:", hud)
        format_value("\tbases()", hud:Bases())
    end
    ig.End()
end

local debug = function(print_hovered)
    local vec = hud:Bases()
    for i = 0, vec.n - 1 do
        local base = vec.val[i]
        if base:IsRoot() then
            if not filter.inactive_root[0] or base:IsActive() then
                debug_hud_base(base, filter, print_hovered)
            end
        end
    end
end

local botm_draw = function()
    if v_debug[0] then
        debug(false)
    end
end

local botm_key_down = function(vk)
    if vk == string.byte("M") then
        if v_debug[0] then
            print("--- HOVERED HUD ELEMENTS ---")
            debug(true)
        end
    end
end

return {
    botm_draw_menu = botm_draw_menu,
    botm_draw = botm_draw,
    botm_key_down = botm_key_down,
}