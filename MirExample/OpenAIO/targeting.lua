local ffi = require "ffi"
local orb = loadscript("free-orbwalker")

local HEALTH_PERCENT = 0
local HEALTH_ABSOULTE = 1
local EFFECTIVE_HEALTH_MAGICAL = 2
local EFFECTIVE_HEALTH_PHYSICAL = 3

local targeting_mode_items = ffi.new("const char*[4]")
local targeting_mode = ffi.new("int[1]")
local override_orb_targeting_mode = ffi.new("bool[1]")

local heuristics = {
    [HEALTH_PERCENT] = function(vec)
        object_manager:SortHeroesHealthPercent(vec)
    end,
    [HEALTH_ABSOULTE] = function(vec)
        object_manager:SortHeroesHealthAbsolute(vec)
    end,
    [EFFECTIVE_HEALTH_MAGICAL] = function(vec)
        object_manager:SortHeroesEffectiveHealthMagical(vec)
    end,
    [EFFECTIVE_HEALTH_PHYSICAL] = function(vec)
        object_manager:SortHeroesEffectiveHealthPhysical(vec)
    end,
}

local sort = function(vec, mode)
    local mode = mode and mode or targeting_mode[0]
    local sort_heuristic = heuristics[mode]
    sort_heuristic(vec)
    return true
end

local set_next_orb_targeting_mode = function()
    if override_orb_targeting_mode[0] then
        orb:SetNextTargetingMode(targeting_mode[0])
    end
end

local load_ini = function(default_targeting_mode, default_override_orb_targeting_mode)
    targeting_mode[0] = ini:GetLong("Targeting", "targeting_mode", default_targeting_mode)
    override_orb_targeting_mode[0] = ini:GetBool("Targeting", "override_orb_targeting_mode", default_override_orb_targeting_mode)
end

local save_ini = function()
    ini:SetLong("Targeting", "targeting_mode", targeting_mode[0])
    ini:SetBool("Targeting", "override_orb_targeting_mode", override_orb_targeting_mode[0])
end

local draw_menu = function()
    targeting_mode_items[0] = "Health (%)"
    targeting_mode_items[1] = "Health (Absolute)"
    targeting_mode_items[2] = "Effective Health (Magical)"
    targeting_mode_items[3] = "Effective Health (Physical)"
    ig.Combo_Str_arr("Targeting Mode", targeting_mode, targeting_mode_items, 4)
    ig.Checkbox("Override Orbwalkers Targeting Mode", override_orb_targeting_mode)
end

return {
    HEALTH_PERCENT = HEALTH_PERCENT,
    HEALTH_ABSOULTE = HEALTH_ABSOULTE,
    EFFECTIVE_HEALTH_MAGICAL = EFFECTIVE_HEALTH_MAGICAL,
    EFFECTIVE_HEALTH_PHYSICAL = EFFECTIVE_HEALTH_PHYSICAL,

    targeting_mode = targeting_mode,
    override_orb_targeting_mode = override_orb_targeting_mode,

    sort = sort,
    set_next_orb_targeting_mode = set_next_orb_targeting_mode,

    load_ini = load_ini,
    save_ini = save_ini,

    draw_menu = draw_menu,
}