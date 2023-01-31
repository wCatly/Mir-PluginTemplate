
local ffi = require "ffi"

local demo_h = require "demo_h"
local format_value = demo_h.format_value

local game_object = require "gameobjects/api_game_object"

local open_game_object = ffi.new("bool[1]")

local print_missiles = ffi.new("bool[1]")
local filter_player = ffi.new("bool[1]")
local filter_radius = ffi.new("bool[1]")
local filter_radius_value = ffi.new("float[1]")
filter_radius_value[0] = 500

local missile 

local botm_draw_menu = function(p_open)
    if ig.Begin("Demo: Missile", p_open) then
        ig.Checkbox("Print emitted missiles", print_missiles)
        ig.Checkbox("Only missiles emitted by Player", filter_player)
        ig.Checkbox("Only missiles in radius", filter_radius)
        if filter_radius[0] then
            ig.SliderFloat("Filter radius", filter_radius_value, 0, 3000, "%.2f", ig.lib.ImGuiSliderFlags_NoInput)
        end
        ig.NewLine()
        if missile then
            ig.Checkbox("GameObject interface", open_game_object)
            ig.NewLine()
            format_value("Missile:", missile)
            format_value("\tstart_pos()", missile:StartPos())
            format_value("\tend_pos()", missile:EndPos())
            format_value("\tspeed()", missile:Speed())
            format_value("\twidth()", missile:Width())
            format_value("\tsource()", missile:Source())
            format_value("\ttarget()", missile:Target())
            format_value("\tspell()", missile:Spell())
        else
            ig.Text("No missile to display")
        end
    end
    ig.End()

    if open_game_object[0] then
        game_object.draw_menu(missile, "Missile", open_game_object)
    end
end

local botm_draw = function()
    local missiles = object_manager:Missiles()
    for i = 0, missiles.n - 1 do
        local obj = missiles.val[i]
        if obj:IsOnScreen() then
            graphics:DrawLine3d(obj:StartPos(), obj:EndPos(), 0x33ffffff, 3)
            graphics:DrawText3d(obj:Pos(), 0x33ffffff, tostring(obj))
        end
    end
end

local print_missile = function(missile)
    print("Missile:", missile)
    print("\tstart_pos()", missile:StartPos())
    print("\tend_pos()", missile:EndPos())
    print("\tspeed()", missile:Speed())
    print("\twidth()", missile:Width())
    print("\tsource()", missile:Source())
    print("\ttarget()", missile:Target())
    print("\tspell()", missile:Spell())
    print("")
end

local is_emitted_by_player = function(obj)
    local source = obj:Source()
    return source and source:IsPlayer()
end

local botm_create_object = function(obj)
    if obj:IsMissile() then
        local obj = obj:AsMissile()

        local should_print = print_missiles[0]

        if filter_player[0] then
            if not is_emitted_by_player(obj) then
                should_print = false
                obj = nil
            end
        end

        if obj and filter_radius[0] then
            local pos = player:Pos()
            if pos:Dist(obj:StartPos()) > filter_radius_value[0] then
                should_print = false
                obj = nil
            end
        end

        if obj and should_print then
            print_missile(obj)
        end

        if obj then
            missile = obj
        end
    end
end

local botm_delete_object = function(type, id)
    if missile and missile:Id() == id then
        missile = nil
    end
end

return {
    botm_draw_menu = botm_draw_menu,
    botm_draw = botm_draw,
    botm_create_object = botm_create_object,
    botm_delete_object = botm_delete_object,
}