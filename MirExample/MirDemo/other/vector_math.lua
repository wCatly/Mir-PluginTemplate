
local ffi = require "ffi"

local demo_h = require "demo_h"
local format_value = demo_h.format_value

local botm_draw_menu = function(p_open)
    if ig.Begin("Demo: Vector Math", p_open) then
        ig.Text("Vector types:")
        ig.BulletText("float2/3/4")
        ig.BulletText("int2/3/4")
        ig.BulletText("uint2/3/4")
        ig.NewLine()
        ig.Text("All vector types have the same interface.")
        ig.TextWrapped("Unlike C, Lua supports operator overloading.")
        ig.NewLine()
        ig.Text("Lua Example:")
        ig.NewLine()
        ig.PushStyleColor(ig.lib.ImGuiCol_Text, demo_h.col_text)
        ig.TextWrapped([[
            local a = float3(1, 1, 1)
            local b = float3(5, 1, 1)
            local c = a:dup() --copy
            print("a", a)
            print("b", b)
            print("c", c)
            print("a == a", a == a)
            print("a == b", a == b)
            print("a + b", a + b)
            print("a - b", a - b)
            print("a * 2", a * 2)
            print("a:MulInner(a)", a:MulInner(a))
            print("a:Len()", a:Len())
            print("a:Norm()", a:Norm())
            print("a:Dist(b)", a:Dist(b))
            print("a:DistSqr(b)", a:DistSqr(b))
            print("a:Lerp(b, 0.5)", a:Lerp(b, 0.5))
            print("a:Lerpd(b, 10", a:Lerpd(b, 10))
        ]])
        ig.PopStyleColor(1)
        ig.NewLine()
        ig.Text("Equivalent C code:")
        ig.NewLine()
        ig.PushStyleColor(ig.lib.ImGuiCol_Text, demo_h.col_text)
        ig.TextUnformatted([[
            #define PRINT_FLOAT3(s, a) print("%s %.2f %.2f %.2f\n", s, a.x, a.y, a.z);

            float3 a = {1.0f, 1.0f, 1.0f};
            float3 b = {5.0f, 1.0f, 1.0f};
            float3 c = float3_dup(a);
            PRINT_FLOAT3("a\t", a);
            PRINT_FLOAT3("b\t", b);
            PRINT_FLOAT3("c\t", c);
            print("a == a\t%s\n", float3_eq(a, a) ? "true" : "false");
            print("a == b\t%s\n", float3_eq(a, b) ? "true" : "false");
            PRINT_FLOAT3("a + b\t", float3_add(a, b));
            PRINT_FLOAT3("a - b\t", float3_sub(a, b));
            PRINT_FLOAT3("a * 2\t", float3_scale(a, 2.0f));
            print("float3_mul_inner(a, a) %f\n", float3_mul_inner(a, a));
            print("float3_len(a) %f\n", float3_len(a));
            PRINT_FLOAT3("float3_norm(a)\t", float3_norm(a));
            print("float3_dist(a, b) %f\n", float3_dist(a, b));
            print("float3_dist_sqr(a, b) %f\n", float3_dist_sqr(a, b));
            PRINT_FLOAT3("float3_lerp(a, b, 0.5)\t", float3_lerp(a, b, 0.5f));
            PRINT_FLOAT3("float3_lerpd(a, b, 10)\t", float3_lerpd(a, b, 10.0f));
        ]], nil)
        ig.PopStyleColor(1)
    end
    ig.End()
end

local botm_load = function()
    -- local a = float3(1, 1, 1)
    -- local b = float3(5, 1, 1)
    -- local c = a:dup() --copy
    -- print("a", a)
    -- print("b", b)
    -- print("c", c)
    -- print("a == a", a == a)
    -- print("a == b", a == b)
    -- print("a + b", a + b)
    -- print("a - b", a - b)
    -- print("a * 2", a * 2)
    -- print("a:MulInner(a)", a:MulInner(a))
    -- print("a:Len()", a:Len())
    -- print("a:Norm()", a:Norm())
    -- print("a:Dist(b)", a:Dist(b))
    -- print("a:DistSqr(b)", a:DistSqr(b))
    -- print("a:Lerp(b, 0.5)", a:Lerp(b, 0.5))
    -- print("a:Lerpd(b, 10", a:Lerpd(b, 10))
end

return {
    botm_draw_menu = botm_draw_menu,
    botm_load = botm_load,
}