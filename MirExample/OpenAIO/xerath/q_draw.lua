local q_buff = require "xerath/q_buff"
local q_release = require "xerath/q_release"

local last_draw = 0
local next_create = 0
local particles = {}

local color = 0xdeffffe7
local color_inner = 0xded0e0d0

local create_particle = function(obj)
    local time = game:Time()
    if time < next_create then
        return
    end

    local r1 = math.random()
    local r2 = math.random()
    local r3 = math.random()
    local speed = math.max(666, r1*1666)
    local angle = r2*(math.pi*2)
    local range = math.max(333, r3*666)

    local pos = obj:Pos()

    table.insert(particles, {
        obj = obj,
        speed = speed,
        pos = float3(pos.x + range*math.cos(angle), 0, pos.z + range*math.sin(angle)),
        expire = time + 2,
        y = pos.y + 333,
    })

    next_create = time + 0.05
end

local remove_particles = function()
    local time = game:Time()

    for i = #particles, 1, -1 do
        local p = particles[i]
        if time > p.expire or p.pos:DistSqr(p.obj:Pos()) < 50 then
            table.remove(particles, i)
        end
    end
end

local draw_particles = function()
    local time = game:Time()
    local dx = time - last_draw

    for i = 1, #particles do
        local p = particles[i]
        local obj = p.obj
        if obj:IsTargetable() then
            p.y = math.max(obj:Pos().y, p.y - dx*777)
            p.pos.y = p.y
            p.pos = p.pos:Lerp(obj:Pos(), dx*p.speed/p.pos:Dist(obj:Pos()))

            graphics:DrawCircle3d(p.pos, 13, color, 3, 3)
            graphics:DrawCircle3d(p.pos, 5, color_inner, 4, 2)
        end
    end

    last_draw = time
end

local on_draw = function()
    local obj = q_release.get_action_target()
    if obj then
        create_particle(obj)
    end
    remove_particles()
    draw_particles()
end

return {
    on_draw = on_draw,
    create_particle = create_particle,
}