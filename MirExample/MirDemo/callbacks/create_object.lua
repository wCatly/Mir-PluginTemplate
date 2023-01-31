
local ffi = require "ffi"

local demo_h = require "demo_h"
local format_value = demo_h.format_value

local col_good = ig.ColorConvertU32ToFloat4(0xff009900)

local botm_draw_menu = function(p_open)
    if ig.Begin("Demo: Callback Create/Delete Object", p_open) then
        format_value("void __cdecl botm_create_object(GameObject *obj);", " ")
        format_value("void __cdecl botm_delete_object(GameObjectType type, uint32_t id);", " ")
        ig.NewLine()
        ig.TextWrapped("Callback functions triggered when a GameObject is created or deleted")
        ig.PushStyleColor(ig.lib.ImGuiCol_Text, 0xff00ffff)
        ig.TextWrapped("The delete function should be as simple as possible, only checking against obj:Id()")
        ig.PopStyleColor(1)
        ig.NewLine()
        ig.Text("Example:")
        ig.NewLine()
        ig.PushStyleColor(ig.lib.ImGuiCol_Text, demo_h.col_text)
        ig.Text("local my_missile")
        ig.NewLine()
        ig.Text("botm.create_object(obj)")
        ig.Text("\tif not obj:IsMissile() then")
        ig.Text("\t\treturn")
        ig.Text("\tend")
        ig.Text("\tlocal obj = obj:AsMissile()")
        ig.Text("\tif not my_missile then")
        ig.Text("\t\tlocal source = obj:Source()")
        ig.Text("\t\tif source and source:IsPlayer() then")
        ig.TextColored(col_good, "\t\t\tmy_missile = obj")
        ig.Text("\t\tend")
        ig.Text("\tend")
        ig.Text("end")
        ig.NewLine()
        ig.Text("botm.delete_object(type, id)")
        ig.Text("\tif my_missile and my_missile:Id() == id then")
        ig.TextColored(col_good, "\t\tmy_missile = nil")
        ig.Text("\tend")
        ig.Text("end")
        ig.NewLine()
        ig.Text("botm.tick = function()")
        ig.Text("\tif my_missile then")
        ig.TextColored(col_good, "\t\tprint(my_missile:Name(), my_missile:Pos())")
        ig.Text("\tend")
        ig.Text("end")
        ig.PopStyleColor(1)
    end 
    ig.End()
end

local my_missile

local botm_create_object = function(obj)
    if not obj:IsMissile() then
        return
    end
    local obj = obj:AsMissile()
    if not my_missile then
        local source = obj:Source()
        if source and source:IsPlayer() then
            my_missile = obj
        end
    end
end

local botm_delete_object = function(type, id)
    if my_missile and my_missile:Id() == id then
        my_missile = nil
    end
end

local botm_tick = function()
    if my_missile then
        print(my_missile:Name(), my_missile:Pos())
    end
end

return {
    botm_draw_menu = botm_draw_menu,
    botm_create_object = botm_create_object,
    botm_delete_object = botm_delete_object,
    botm_tick = botm_tick,
}