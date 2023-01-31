local ffi = require "ffi"

local demo_h = require "demo_h"
local format_value = demo_h.format_value

local botm_draw_menu = function(p_open)
    if ig.Begin("Demo: Shop", p_open) then
        format_value("Shop:", shop)
        format_value("\tis_open()", shop:IsOpen())
        format_value("\tcan_shop()", shop:CanShop())

        ig.NewLine()
        ig.TextWrapped("Item IDs can be retreived by the ItemSlot interface. Alternatively you can look them up on the LoL wiki page")
        ig.NewLine()

        if ig.MenuItem("Buy Health Potion", "1") then
            shop:BuyItem(2003)
        end
        if ig.MenuItem("Move ItemSlot_0 to ItemSlot_1", "2") then
            shop:SwitchItem(ItemSlot_0, ItemSlot_1)
        end
        if ig.MenuItem("Sell ItemSlot_1", "3") then
            shop:SellItem(ItemSlot_1)
        end
        if ig.MenuItem("Undo Shop Action", "4") then
            shop:Undo()
        end
    end
    ig.End()
end

local botm_key_down = function(vk_code)
    if vk_code == 49 then --[1]
        bot:IssueToggleDrawings()
    elseif vk_code == 50 then --[2]
        bot:IssueToggleMenu()
    end
end

return {
    botm_draw_menu = botm_draw_menu,
    botm_key_down = botm_key_down,
}