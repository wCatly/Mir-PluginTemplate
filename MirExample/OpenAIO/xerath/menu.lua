
local ffi = require "ffi"
local targeting = require "targeting"

local window_name = "Open AIO - Xerath"
local initial_pos = float2(500, 300)
local ini_file = "open_aio_xerath.ini"

local allow_e_cancel_aa = ffi.new("bool[1]")
local harass_use_w = ffi.new("bool[1]")
local harass_key = ig.CreateHotkey()
local combat_key = ig.CreateHotkey()

local load_ini = function()
    ini:SetTarget(ini_file)

    targeting.load_ini(targeting.EFFECTIVE_HEALTH_MAGICAL, true)

    allow_e_cancel_aa[0] = ini:GetBool("General", "allow_e_cancel_aa", true)
    harass_use_w[0] = ini:GetBool("General", "harass_use_w", true)

    ini:GetHotkey("Keys", "harass", harass_key, string.byte("V"), false, false)
    ini:GetHotkey("Keys", "combat", combat_key, 32, false, false)
end

local save_ini = function()
    ini:SetTarget(ini_file)

    targeting.save_ini()

    ini:SetBool("General", "allow_e_cancel_aa", allow_e_cancel_aa[0])
    ini:SetBool("General", "harass_use_w", harass_use_w[0])

    ini:SetHotkey("Keys", "harass", harass_key)
    ini:SetHotkey("Keys", "combat", combat_key)
end

local load = function()
    load_ini()
end

local draw_menu = function(p_open)
    ig.SetNextWindowPos(initial_pos, ig.lib.ImGuiCond_FirstUseEver)
    if ig.Begin(window_name, p_open, ig.lib.ImGuiWindowFlags_None) then
        targeting.draw_menu()
        --ig.NewLine()
        ig.Separator()
        --ig.NewLine()
        ig.Checkbox("Allow E to cancel Auto Attacks", allow_e_cancel_aa)
        ig.Checkbox("Use W in Harass", harass_use_w)
        --ig.NewLine()
        ig.Separator()
        --ig.NewLine()
        local harass_label = "Harass Key [Q]"
        if harass_use_w[0] then
            harass_label = "Harass Key [Q + W]"
        end
        ig.Hotkey(harass_label, harass_key)
        ig.Hotkey("Combat Key", combat_key)
        --ig.NewLine()
    end
    ig.End()
end

return {
    allow_e_cancel_aa = allow_e_cancel_aa,
    harass_use_w = harass_use_w,
    harass_key = harass_key,
    combat_key = combat_key,

    save_ini = save_ini,

    load = load,
    draw_menu = draw_menu,
}