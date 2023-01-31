
local ffi = require "ffi"
local targeting = require "targeting"

local window_name = "Open AIO - Ezreal"
local initial_pos = float2(500, 300)
local ini_file = "open_aio_ezreal.ini"

local debug_q = ffi.new("bool[1]")
local start_combo_with_aa = ffi.new("bool[1]")
local w_only_after_aa = ffi.new("bool[1]")
local combat_key = ig.CreateHotkey()

local load_ini = function()
    ini:SetTarget(ini_file)

    targeting.load_ini(targeting.EFFECTIVE_HEALTH_PHYSICAL, true)

    debug_q[0] = ini:GetBool("General", "debug_q", true)
    start_combo_with_aa[0] = ini:GetBool("General", "start_combo_with_aa", true)
    w_only_after_aa[0] = ini:GetBool("General", "w_only_after_aa", true)
    ini:GetHotkey("Keys", "combat", combat_key, 32, false, false)
end

local save_ini = function()
    ini:SetTarget(ini_file)

    targeting.save_ini()

    ini:SetBool("General", "debug_q", debug_q[0])
    ini:SetBool("General", "start_combo_with_aa", start_combo_with_aa[0])
    ini:SetBool("General", "w_only_after_aa", w_only_after_aa[0])
    ini:SetHotkey("Keys", "combat", combat_key)
end

local draw_menu = function(p_open)
    ig.SetNextWindowPos(initial_pos, ig.lib.ImGuiCond_FirstUseEver)
    if ig.Begin(window_name, p_open, ig.lib.ImGuiWindowFlags_None) then
        targeting.draw_menu()
        ig.Separator()
        --ig.Checkbox("Start combo with an Auto Attack (if possible)", start_combo_with_aa)
        ig.Checkbox("Debug Q", debug_q)
        ig.Checkbox("Use W only after an Auto Attack", w_only_after_aa)
        --ig.Checkbox("Do not evaluate Q prediction (Fast Q)", fast_q)
        ig.Separator()
        ig.Hotkey("Combat Key", combat_key)
        ig.Separator()
    end
    ig.End()
end

local load = function()
    load_ini()
end

return {
    debug_q = debug_q,
    start_combo_with_aa = start_combo_with_aa,
    w_only_after_aa = w_only_after_aa,
    combat_key = combat_key,

    save_ini = save_ini,

    load = load,
    draw_menu = draw_menu,
}