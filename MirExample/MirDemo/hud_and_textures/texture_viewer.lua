local size = float2(96, 96)
local uv0, uv1 = float2(0, 0), float2(1, 1)
local tint_col, border_col = float4(1, 1, 1, 1), float4(0, 0, 0, 0)

local offset = 0

local botm_draw_menu = function(p_open)
    if ig.Begin("Texture Viewer", p_open) then
        local n = 5

        local textures = game:Textures()

        ig.Text(textures.n.." Game Textures")

        if ig.SmallButton("Prev "..n*n) then
            if offset ~= 0 then
                offset = offset - n*n
            end
        end
        ig.SameLine()
        if ig.SmallButton("Next "..n*n) then
            offset = offset + n*n
        end
        ig.SameLine()
        ig.Text(offset.."-"..offset+n*n-1)

        ig.NewLine()

        local hovered
        if ig.BeginChild("MiniView", size*(n+1)) then
            for i = 0, n - 1 do
                for j = 0, n - 1 do
                    local index = offset + i*n+j
                    if index >= textures.n then
                        break
                    end
                    local tex = textures.val[index]
                    if tex then
                        ig.Image(tex:TexId(), size, uv0, uv1, tint_col, border_col)
                        if ig.IsItemHovered(ig.lib.ImGuiHoveredFlags_None) then
                            hovered = tex
                        end
                    end
                    ig.SameLine()
                end
                ig.NewLine()
            end
        end
        ig.EndChild()

        ig.SameLine()
        
        if ig.BeginChild("View", size*(n+1)) then
            if hovered then
                ig.Image(hovered:TexId(), size*(n-1), uv0, uv1, tint_col, border_col)
                ig.TextWrapped("%s", hovered:Name())
                ig.TextWrapped("Size: %s", tostring(hovered:Size()))
            end
        end
        ig.EndChild()
    end
    ig.End()

end

return {
    botm_draw_menu = botm_draw_menu,
}