
local ffi = require "ffi"

local demo_h = require "demo_h"
local format_value = demo_h.format_value

local game_object = require "gameobjects/api_game_object"

local open_game_object = ffi.new("bool[1]")

local print_particles = ffi.new("bool[1]")
local filter_player = ffi.new("bool[1]")
local filter_radius = ffi.new("bool[1]")
local filter_radius_value = ffi.new("float[1]")
filter_radius_value[0] = 500

local particle

local get_particle = function()
    if particle then
        return particle
    end
    if not filter_player[0] then
        local vec = object_manager:Particles()
        return vec.n > 0 and vec.val[0]
    end
end

local botm_draw_menu = function(p_open)
    local particle = get_particle()

    if ig.Begin("Demo: Particle", p_open) then
        ig.Checkbox("Print emitted particles", print_particles)
        ig.Checkbox("Only particles emitted by Player", filter_player)
        ig.Checkbox("Only particles in radius", filter_radius)
        if filter_radius[0] then
            ig.SliderFloat("Filter radius", filter_radius_value, 0, 3000, "%.2f", ig.lib.ImGuiSliderFlags_NoInput)
        end
        ig.NewLine()
        if particle then
            ig.Checkbox("GameObject interface", open_game_object)
            ig.NewLine()
            format_value("Particle:", particle)
            format_value("\tvisibility_radius()", particle:VisibilityRadius())
            format_value("\torientation()", particle:Orientation())
            format_value("\tattachment_object()", particle:AttachmentObject())
            format_value("\ttarget_attachment_object()", particle:TargetAttachmentObject())
        else
            ig.Text("No particle to display")
        end
    end
    ig.End()

    if open_game_object[0] then
        game_object.draw_menu(particle, "Particle", open_game_object)
    end
end

local botm_draw = function()
    local particles = object_manager:Particles()
    for i = 0, particles.n - 1 do
        local obj = particles.val[i]
        if obj:IsOnScreen() then
            local radius = obj:VisibilityRadius()
            if radius > 0 then
                graphics:DrawCircle3d(obj:Pos(), radius, 0x33ffffff, 32, 3)
                graphics:DrawText3d(obj:Pos(), 0x33ffffff, tostring(obj))
        
            end
        end
    end
end

local print_particle = function(obj)
    print("Particle:", obj)
    print("\tvisibility_radius()", obj:VisibilityRadius())
    print("\torientation()", obj:Orientation())
    print("\tattachment_object()", tostring(obj:AttachmentObject()))
    print("\ttarget_attachment_object()", tostring(obj:TargetAttachmentObject()))
    print("")
end

local is_emitted_by_player = function(obj)
    local attachment = obj:TargetAttachmentObject()
    return attachment and attachment:IsPlayer()
end

local botm_create_object = function(obj)
    if obj:IsParticle() then
        local obj = obj:AsParticle()

        local should_print = print_particles[0]

        if filter_player[0] then
            if is_emitted_by_player(obj) then
                particle = obj
            else
                should_print = false
            end
        end

        if filter_radius[0] then
            local pos = player:Pos()
            should_print = pos:Dist(obj:Pos()) < filter_radius_value[0]
        end

        if should_print then
            print_particle(obj)
        end
    end
end

local botm_delete_object = function(type, id)
    if particle and particle:Id() == id then
        particle = nil
    end
end

return {
    botm_draw_menu = botm_draw_menu,
    botm_draw = botm_draw,
    botm_create_object = botm_create_object,
    botm_delete_object = botm_delete_object,
}