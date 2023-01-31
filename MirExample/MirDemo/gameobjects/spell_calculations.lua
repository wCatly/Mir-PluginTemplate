
local ffi = require "ffi"

local demo_h = require "demo_h"
local format_value = demo_h.format_value

local v_spell_slot = ffi.new("int[1]")
v_spell_slot[0] = 0

local draw_menu = function(aiclient, p_open)
    if ig.Begin("Demo: SpellCalculation", p_open) then
        ig.SliderInt("##SpellSlot_SpellCalculation", v_spell_slot, SpellSlot_Q, SpellSlot_COUNT-1, "spell_slot(%d)", ig.lib.ImGuiSliderFlags_NoInput)
        ig.NewLine()
        local slot = v_spell_slot[0]
        local spell_slot = aiclient:SpellSlot(slot)
        format_value("SpellSlot("..slot.."):", spell_slot)
        ig.NewLine()
        local vec = aiclient:SpellCalculations(slot)
        format_value("SpellCalculations("..slot.."):", vec)
        for i = 0, vec.n - 1 do
            local calc = vec.val[i]
            format_value("\tval["..i.."]", calc)
            format_value("\t\thash()", calc:Hash(), "0x%x")
            local level = spell_slot:Level()
            format_value("\t\tresult(level "..level..")", calc:Result(level))
            --format_value("\t\t", aiclient:FindSpellCalculationByHash(slot, calc:Hash()))
        end

    end
    ig.End()
end

return {
    draw_menu = draw_menu,
}