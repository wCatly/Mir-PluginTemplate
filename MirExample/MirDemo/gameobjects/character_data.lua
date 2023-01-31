local ffi = require "ffi"

local demo_h = require "demo_h"
local format_value = demo_h.format_value

local show_base_character_data = ffi.new("bool[1]")

local draw_menu = function(aiclient, p_open)

    if ig.Begin("Demo: CharacterData", p_open) then
        ig.Checkbox("Show Base CharacterData", show_base_character_data)
        ig.NewLine()

        local data = aiclient:CharacterData()
        if show_base_character_data[0] then
            data = aiclient:BaseCharacterData()
        end
    
        format_value("CharacterData:", data)
        format_value("\tmemory_address()", data:MemoryAddress(), "0x%x")
        format_value("\tmodel()", data:Model())
        format_value("\tskin_id()", data:SkinId())
        format_value("\tskin_name()", data:SkinName())
        format_value("\trecord()", data:Record())

    end
    ig.End()
end

return {
    draw_menu = draw_menu,
}