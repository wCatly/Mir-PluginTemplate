
local ffi = require "ffi"

local demo_h = require "demo_h"
local format_value = demo_h.format_value

local draw_menu = function(aiclient, p_open)
    if ig.Begin("Demo: Path", p_open) then
        local path = aiclient:Path()
        format_value("Path:", path)
        format_value("\tmemory_address()", path:MemoryAddress(), "0x%x")
        format_value("\tend_pos()", path:EndPos())
        format_value("\tpos()", path:Pos())
        format_value("\tvelocity()", path:Velocity())
        format_value("\tis_active()", path:IsActive())
        format_value("\tis_dashing()", path:IsDashing())
        format_value("\tdash_speed()", path:DashSpeed())
        format_value("\tmove_speed()", path:MoveSpeed())
        format_value("\tspeed()", path:Speed())
        format_value("\tindex()", path:Index())
        format_value("\twaypoints()", path:Waypoints())
        local vec = path:Waypoints()
        for i = 0, vec.n - 1 do
            format_value("\t\tval["..i.."]", vec.val[i])
        end
        format_value("\tsource()", path:Source())
    end
    ig.End()
end

local draw = function(aiclient)
    local path = aiclient:Path()
    if not path:IsActive() then
        return
    end
    local vec = path:Waypoints()
    for i = 0, vec.n - 2 do
        local p1 = vec.val[i]
        local p2 = vec.val[i+1]
        graphics:DrawLine3d(p1, p2, 0xffffffff, 3)
    end
end

return {
    draw_menu = draw_menu,
    draw = draw,
}