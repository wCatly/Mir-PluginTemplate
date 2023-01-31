local menu = require "xerath/menu"
local q_draw = require "xerath/q_draw"
local r_buff = require "xerath/r_buff"
local r_cast = require "xerath/r_cast"

local color = 0xdeffffe7

local on_draw = function()
    if not r_buff.get() then
        return
    end

    local obj = r_cast.get_action_target()
    if obj then
        q_draw.create_particle(obj)
    end

    if not menu.combat_key:IsPressed() then
        local pos = game:CursorPos()
        pos.y = pos.y - 30
        graphics:DrawSizedText2d(20, pos, color, "Press combat key to start ultimating")
    end

    graphics:DrawCircle3d(game:MousePos(), 1000, color, 40, 3)
end

return {
    on_draw = on_draw,
}