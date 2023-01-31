
local ffi = require "ffi"

local demo_h = require "demo_h"
local format_value = demo_h.format_value

local draw_menu = function(obj, type, p_open)
    if not obj then
        return
    end
    
    if ig.Begin("Demo: Hero", p_open) then
        format_value("Hero:", obj)
        format_value("\tis_teleporting()", obj:IsTeleporting())
        format_value("\tteleport_type()", obj:TeleportType())
        format_value("\tteleport_name()", obj:TeleportName())
        format_value("\tlevel()", obj:Level())
        format_value("\texp()", obj:Exp())
        format_value("\trunes()", obj:Runes())
        local vec = obj:Runes()
        for i = 0, vec.n - 1 do
            format_value("\t\tval["..i.."]", vec.val[i])
        end
        format_value("\titem_slot(ItemSlot_0)", obj:ItemSlot(ItemSlot_0))
    end
    ig.End()
end

return {
    draw_menu = draw_menu,
}