local ffi = require "ffi"

local demo_h = require "demo_h"
local format_value = demo_h.format_value

local botm_draw_menu = function(p_open)
    if ig.Begin("Demo Graphics", p_open) then
        format_value("Graphics:", graphics)
        format_value("\tscreen_width()", graphics:ScreenWidth())
        format_value("\tscreen_height()", graphics:ScreenHeight())
        format_value("\tscreen_size()", graphics:ScreenSize())
        format_value("\tworld_to_screen(mouse_pos)", graphics:WorldToScreen(game:MousePos()))
        format_value("\tis_on_screen_2d(cursor_pos)", graphics:IsOnScreen2d(game:CursorPos()))
        format_value("\tis_on_screen_3d(player_pos)", graphics:IsOnScreen3d(player:Pos()))
        ig.NewLine()
        format_value("\tdraw_line_2d(float2 from, float2 to, uint32_t col, float thickness)", " ")
        format_value("\tdraw_line_3d(float3 from, float3 to, uint32_t col, float thickness)", " ")
        format_value("\tdraw_rectangle_2d(float2 p_min, float2 p_max, uint32_t col, float thickness)", " ")
        format_value("\tdraw_filled_rectangle_2d(float2 p_min, float2 p_max, uint32_t col)", " ")
        format_value("\tdraw_circle_in_rectangle_2d(float2 center, float radius, float2 p_min, float2 p_max, uint32_t col, size_t num_segments, float thickness)", " ")
        format_value("\tdraw_triangle_2d(float2 p1, float2 p2, float2 p3, uint32_t col, float thickness)", " ")
        format_value("\tdraw_filled_triangle_2d(float2 p1, float2 p2, float2 p3, uint32_t col)", " ")
        format_value("\tdraw_triangle_3d(float3 p1, float3 p2, float3 p3, uint32_t col, float thickness)", " ")
        format_value("\tdraw_filled_triangle_3d(float3 p1, float3 p2, float3 p3, uint32_t col)", " ")
        format_value("\tdraw_circle_2d(float2 center, float radius, uint32_t col, size_t num_segments, float thickness)", " ")
        format_value("\tdraw_filled_circle_2d(float2 center, float radius, uint32_t col, size_t num_segments)", " ")
        format_value("\tdraw_circle_3d(float3 center, float radius, uint32_t col, size_t num_segments, float thickness)", " ")
        format_value("\tdraw_filled_circle_3d(float3 center, float radius, uint32_t col, size_t num_segments)", " ")
        format_value("\tdraw_polyline_2d(float2 *points, size_t num_points, uint32_t col, float thickness)", " ")
        format_value("\tdraw_polyline_3d(float3 *points, size_t num_points, uint32_t col, float thickness)", " ")
        format_value("\tdraw_text_2d(float2 pos, uint32_t col, const char *text)", " ")
        format_value("\tdraw_sized_text_2d(float font_size, float2 pos, uint32_t col, const char *text)", " ")
        format_value("\tdraw_text_3d(float3 pos, uint32_t col, const char *text)", " ")
        format_value("\tdraw_sized_text_3d(float font_size, float3 pos, uint32_t col, const char *text)", " ")
        format_value("\tdraw_image_2d(Texture *tex, float2 pos)", " ")
        format_value("\tdraw_image_2d_ex(Texture *tex, float2 pos, float2 size, float2 uv0, float2 uv1, uint32_t col)", " ")
        format_value("\tdraw_image_3d(Texture *tex, float3 pos)", " ")
        format_value("\tdraw_image_3d_ex(Texture *tex, float3 pos, float2 size, float2 uv0, float2 uv1, uint32_t col)", " ")
        ig.NewLine()
        format_value("\tload_image_from_memory(void *data, size_t size)", " ")
        format_value("\tload_image_from_file(const char *path)", " ")
        ig.NewLine()
        format_value("\tis_dx9()", graphics:IsDx9())
        format_value("\tIDirect3DDevice9* dx9_device()", graphics:Dx9Device())
        ig.Text("\tRemarks: LoL uses d3dx9_39 (gcc: -ld3d9 -ld3dx9_39)")
        ig.NewLine()
        format_value("\tis_dx11()", graphics:IsDx11())
        format_value("\tID3D11Device* dx11_device()", graphics:Dx11Device())
        format_value("\tID3D11DeviceContext* dx11_device_context()", graphics:Dx11DeviceContext())
        format_value("\tIDXGISwapChain* dx11_swap_chain()", graphics:Dx11SwapChain())
        ig.NewLine()
        format_value("\tview_projection_matrix()", graphics:ViewProjectionMatrix())
        ig.NewLine()
    end
    ig.End()
end

local col_2d = 0xffffff00
local col_3d = 0xffff00ff

local uv0 = float2(0.25,0.25)
local uv1 = float2(0.75,0.75)
local tex1

local botm_load = function()
    tex1 = graphics:LoadImageFromFile("MirDemo\\resources\\smile.png")
end

local botm_unload = function()

end

local botm_draw = function()
    local cursor2 = game:CursorPos()

    graphics:DrawLine2d(cursor2, cursor2 + float2(300, 0), col_2d, 6)
    graphics:DrawCircle2d(cursor2, 100, col_2d, 8, 6)
    graphics:DrawText2d(cursor2 - float2(0, 15), col_2d, "2D Text")
    graphics:DrawSizedText2d(30, cursor2 - float2(0, 45), col_2d, "2D Sized Text")
    graphics:PushChineseFont()
    graphics:DrawSizedText2d(30, cursor2 - float2(0, 90), col_2d, "你好世界")
    graphics:PopChineseFont()
    
    if tex1 then
        graphics:DrawImage2d(tex1, cursor2)
        graphics:DrawImage2dEx(tex1, cursor2 + float2(tex1:Width(), 0), tex1:Size(), uv0, uv1, 0x7700ffff)
    end

    if not player:IsOnScreen() then
        return
    end
    
    local player3 = player:Pos()
    local mouse3 = game:MousePos()

    graphics:DrawLine3d(mouse3, player3, col_3d, 3)
    graphics:DrawCircle3d(player3, 600, col_3d, 3, 3)
    graphics:DrawText3d(player3, col_3d, "3D Text")
    graphics:DrawSizedText3d(30, player3 + float3(0, 0, 100), col_3d, "3D Sized Text")
end

return {
    botm_draw_menu = botm_draw_menu,
    botm_draw = botm_draw,
    botm_load = botm_load,
    botm_unload = botm_unload,
}