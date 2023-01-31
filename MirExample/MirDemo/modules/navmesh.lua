local ffi = require "ffi"

local demo_h = require "demo_h"
local format_value = demo_h.format_value

local botm_draw_menu = function(p_open)
    if ig.Begin("Demo: Navmesh", p_open) then
        if ig.TreeNode("Enum CellTypeFlags") then
            format_value("\tCellTypeFlags_Grass", CellTypeFlags_Grass)
            format_value("\tCellTypeFlags_Wall", CellTypeFlags_Wall)
            format_value("\tCellTypeFlags_Structure", CellTypeFlags_Structure)

            ig.TreePop()
        end
        ig.NewLine()
        local mouse_pos = game:MousePos()
        format_value("Navmesh:", navmesh)
        format_value("\tis_grass(mouse_pos)", navmesh:IsGrass(mouse_pos))
        format_value("\tis_wall(mouse_pos)", navmesh:IsWall(mouse_pos))
        format_value("\tis_structure(mouse_pos)", navmesh:IsStructure(mouse_pos))
        format_value("\tget_terrain_height(mouse_pos)", navmesh:GetTerrainHeight(mouse_pos))

        local index = uint2()
        local from = player:AsAiClient()
        local to = game:MousePos()
        local is_direct_path = navmesh:IsDirectPath(from, to, index)
        format_value("\tis_direct_path(player, mouse_pos)", is_direct_path)

        local vec = navmesh:CalcPath(from, to)
        format_value("\tcalc_path(player, mouse_pos)", vec)
        ig.PushStyleColor(ig.lib.ImGuiCol_Text, 0xff00ffff)
        ig.Text("\t\tWARNING:")
        ig.Text("\t\t") ig.SameLine() ig.BulletText("This function is shredding FPS")
        ig.Text("\t\t") ig.SameLine() ig.BulletText("Successive calls overwrite a previous results memory")
        ig.Text("\t\t") ig.SameLine() ig.BulletText("(Tip) Use only in a small radius")
        ig.Text("\t\t") ig.SameLine() ig.BulletText("(Tip) Use only once per tick")
        ig.PopStyleColor(1)
        for i = 0, vec.n - 1 do
            format_value("\t\tval["..i.."]", vec.val[i])
        end

        ig.NewLine()
        format_value("\tgameplay_area(mouse_pos)", navmesh:GameplayArea(mouse_pos), "0x%x")
        format_value("\tis_in_platform(mouse_pos)", navmesh:IsInPlatform(mouse_pos))
        format_value("\tis_in_base(mouse_pos)", navmesh:IsInBase(mouse_pos))
        format_value("\tis_in_bot_lane(mouse_pos)", navmesh:IsInBotLane(mouse_pos))
        format_value("\tis_in_mid_lane(mouse_pos)", navmesh:IsInMidLane(mouse_pos))
        format_value("\tis_in_top_lane(mouse_pos)", navmesh:IsInTopLane(mouse_pos))
        format_value("\tis_in_bot_river(mouse_pos)", navmesh:IsInBotRiver(mouse_pos))
        format_value("\tis_in_top_river(mouse_pos)", navmesh:IsInTopRiver(mouse_pos))
        format_value("\tis_in_bot_jungle(mouse_pos)", navmesh:IsInBotJungle(mouse_pos))
        format_value("\tis_in_top_jungle(mouse_pos)", navmesh:IsInTopJungle(mouse_pos))
        ig.NewLine()
        format_value("\tgrid_start_pos()", navmesh:GridStartPos())
        format_value("\tgrid_end_pos()", navmesh:GridEndPos())
        format_value("\tgrid_size()", navmesh:GridSize())
        format_value("\tgrid_cell_length()", navmesh:GridCellLength())
        format_value("\tgrid_index_to_flat_index(index at mouse_pos)", navmesh:GridIndexToFlatIndex(navmesh:GridWorldToIndex(mouse_pos)))
        format_value("\tgrid_flat_index_to_index(flat_index at mouse_pos)", navmesh:GridFlatIndexToIndex(navmesh:GridWorldToFlatIndex(mouse_pos)))
        format_value("\tgrid_world_to_index(mouse_pos)", navmesh:GridWorldToIndex(mouse_pos))
        format_value("\tgrid_world_to_flat_index(mouse_pos)", navmesh:GridWorldToFlatIndex(mouse_pos))
        format_value("\tgrid_index_to_world(index at mouse_pos)", navmesh:GridIndexToWorld(navmesh:GridWorldToIndex(mouse_pos)))
        format_value("\tgrid_flat_index_to_world(flat index at mouse_pos)", navmesh:GridFlatIndexToWorld(navmesh:GridWorldToFlatIndex(mouse_pos)))
        format_value("\tclamp_world_on_grid(mouse_pos)", navmesh:ClampWorldOnGrid(mouse_pos))
        format_value("\tcell_type_from_index(index at mouse_pos)", navmesh:CellTypeFromIndex(navmesh:GridWorldToIndex(mouse_pos)))
        format_value("\tcell_type_from_flat_index(flat_index at mouse_pos)", navmesh:CellTypeFromFlatIndex(navmesh:GridWorldToFlatIndex(mouse_pos)))
        format_value("\tcell_type_from_world(mouse_pos)", navmesh:CellTypeFromWorld(mouse_pos))
    end
    ig.End()
end

local botm_draw = function()
    local from = player:AsAiClient()
    local to = game:MousePos()

    --is_direct_path demo
    local index = uint2()
    local is_direct_path = navmesh:IsDirectPath(from, to, index)
    local pos = navmesh:GridIndexToWorld(index)
    pos.y = navmesh:GetTerrainHeight(pos)
    local col = is_direct_path and 0xffffffff or 0xff00ff00
    graphics:DrawCircle3d(pos, 50, col, 8, 3)
    graphics:DrawLine3d(player:Path():Pos(), pos, col, 3)

    --calc_path demo
    local vec = navmesh:CalcPath(from, to)
    for i = 0, vec.n - 2 do
        graphics:DrawLine3d(vec.val[i], vec.val[i+1], 0xffffffff, 3)
    end
end

return {
    botm_draw_menu = botm_draw_menu,
    botm_draw = botm_draw,
}