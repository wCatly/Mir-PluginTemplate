local ffi = require "ffi"

local demo_h = require "demo_h"
local format_value = demo_h.format_value

local height = ffi.new("int[1]")
local pitch = ffi.new("int[1]")
local yaw = ffi.new("int[1]")
local lock = ffi.new("bool[1]")

local botm_draw_menu = function(p_open)
    if ig.Begin("Demo: Camera", p_open) then
        format_value("Camera:", camera)
        format_value("\tpos()", camera:Pos())
        format_value("\theight()", camera:Height())
        format_value("\tpitch()", camera:Pitch())
        format_value("\tyaw()", camera:Yaw())
        format_value("\tis_locked()", camera:IsLocked())

        ig.NewLine()

        ig.PushStyleColor(ig.lib.ImGuiCol_Text, demo_h.col_text)

        if height[0] == 0 then height[0] = camera:Height() end
        ig.SliderInt("##slider1", height, 0, 10000, "\tset_height(%d)", 0)
        camera:SetHeight(height[0])

        if pitch[0] == 0 then pitch[0] = camera:Pitch() end
        ig.SliderInt("##slider2", pitch, 0, 360, "\tset_pitch(%d)", 0)
        camera:SetPitch(pitch[0])

        if yaw[0] == 0 then yaw[0] = camera:Yaw() end
        ig.SliderInt("##slider3", yaw, 0, 360, "\tset_yaw(%d)", 0)
        camera:SetYaw(yaw[0])

        if not lock[0] then lock[0] = camera:IsLocked() end
        local fmt = string.format("\tset_lock(%s)", tostring(lock[0]))
        ig.Checkbox(fmt, lock)
        camera:SetLock(lock[0])

        ig.PopStyleColor(1)
    end
    ig.End()
end

return {
    botm_draw_menu = botm_draw_menu,
}