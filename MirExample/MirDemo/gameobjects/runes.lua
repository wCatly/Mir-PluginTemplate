
local ffi = require "ffi"

local demo_h = require "demo_h"
local format_value = demo_h.format_value

local draw_menu = function(hero, p_open)
    if ig.Begin("Demo: Runes", p_open) then
        local vec = hero:Runes()
        if vec.n == 0 then
            format_value("No runes", nil)
        else
            for i = 0, vec.n - 1 do
                local rune = vec.val[i]
                format_value("Rune:", rune)
                format_value("\tmemory_address()", rune:MemoryAddress(), "0x%x")
                format_value("\tid()", rune:Id())
                format_value("\tname()", rune:Name())
                format_value("\tfnv_hash()", rune:FnvHash(), "0x%x")
                local icon = rune:Icon()
                format_value("\ticon()", icon)
                if icon then
                    ig.Text("\t\t") ig.SameLine()
                    local uv = icon:Uv()
                    ig.Image(icon:TexId(), icon:Size(), uv.p_min, uv.p_max)
                end
                if rune:FnvHash() ~= game:FnvHash(rune:Name()) then
                    ig.PushStyleColor(ig.lib.ImGuiCol_Text, 0xff00ffff)
                    ig.Text("\tFnvHash mismatch ".. string.format("0x%x", game:FnvHash(rune:Name())))
                    ig.PopStyleColor()
                end
                ig.NewLine()
            end
        end
    end
    ig.End()
end

local draw = function(hero)
    local pos = game:CursorPos()
    local vec = hero:Runes()
    for i = 0, vec.n - 1 do
        local rune = vec.val[i]
        local icon = rune:Icon()
        if icon then
            graphics:DrawImage2d(icon, pos)
            pos = pos + float2(icon:Width(), 0)
        end
    end
end

return {
    draw_menu = draw_menu,
    draw = draw,
}