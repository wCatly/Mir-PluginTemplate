
local ffi = require "ffi"

local demo_h = require "demo_h"
local format_value = demo_h.format_value

local draw_menu = function(hero, p_open)
    if ig.Begin("Demo: ItemSlots", p_open) then
        if ig.TreeNode("Enum ItemSlot") then
            format_value("\tItemSlot_0", ItemSlot_0)
            format_value("\tItemSlot_1", ItemSlot_1)
            format_value("\tItemSlot_2", ItemSlot_2)
            format_value("\tItemSlot_3", ItemSlot_3)
            format_value("\tItemSlot_4", ItemSlot_4)
            format_value("\tItemSlot_5", ItemSlot_5)
            format_value("\tItemSlot_COUNT", ItemSlot_COUNT)
            ig.TreePop()
        end
        
        ig.NewLine()

        for i = ItemSlot_0, ItemSlot_COUNT - 1 do
            local item_slot = hero:ItemSlot(i)
            format_value("ItemSlot_"..i..":", item_slot)
            if item_slot then
                format_value("\tmemory_address()", item_slot:MemoryAddress(), "0x%x")
                format_value("\tstacks()", item_slot:Stacks())
                format_value("\tmax_stacks()", item_slot:MaxStacks())
                format_value("\tspell_stacks()", item_slot:SpellStacks())
                format_value("\tpurchase_time()", item_slot:PurchaseTime())
                format_value("\tid()", item_slot:Id())
                format_value("\tcost()", item_slot:Cost())
                format_value("\tname()", item_slot:Name())
                local icon = item_slot:Icon()
                format_value("\ticon()", icon)
                if icon then
                    ig.Text("\t\t") ig.SameLine()
                    local uv = icon:Uv()
                    ig.Image(icon:TexId(), icon:Size(), uv.p_min, uv.p_max)
                end
                ig.NewLine()
            end
        end
    end
    ig.End()
end

local draw = function(hero, p_open)
    local pos = game:CursorPos()
    for i = ItemSlot_0, ItemSlot_COUNT - 1 do
        local item_slot = hero:ItemSlot(i)
        if item_slot then
            local icon = item_slot:Icon()
            if icon then
                graphics:DrawImage2d(icon, pos)
                pos = pos + float2(icon:Width(), 0)
            end
        end
    end
end

return {
    draw_menu = draw_menu,
    draw = draw,
}