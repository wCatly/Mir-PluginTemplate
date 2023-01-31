local ffi = require "ffi"

local demo_h = require "demo_h"
local format_value = demo_h.format_value

local draw_example = ffi.new("bool[1]")

local botm_draw_menu = function(p_open)
    if ig.Begin("Demo: Minimap", p_open, 0) then
        format_value("Minimap", minimap)
        format_value("\tpos()", minimap:Pos())
        format_value("\tsize()", minimap:Size())
        format_value("\tworld_bounds()", minimap:WorldBounds())
        local cursor_pos = game:CursorPos()
        format_value("\tis_on_map(cursor_pos)", minimap:IsOnMap(cursor_pos))
        local mouse_pos = game:MousePos()
        format_value("\tworld_to_map(mouse_pos)", minimap:WorldToMap(mouse_pos))
        ig.NewLine()
        ig.Checkbox("Draw circle on minimap example", draw_example)
    end
    ig.End()
end

local draw_circle_on_minimap = function()
    local p_min = minimap:Pos()
    local p_max = p_min + minimap:Size()
    
    local pos = game:CursorPos()
    graphics:DrawCircleInRectangle2d(pos, 40, p_min, p_max, 0xffff00ff, 12, 3)

    local pos = minimap:WorldToMap(game:MousePos())
    graphics:DrawCircleInRectangle2d(pos, 20, p_min, p_max, 0xffffff00, 12, 3)
end

local botm_draw = function()
    if draw_example[0] then
        draw_circle_on_minimap()
    end
end

return {
    botm_draw_menu = botm_draw_menu,
    botm_draw = botm_draw,
}