
local ffi = require "ffi"

local demo_h = require "demo_h"
local format_value = demo_h.format_value

local botm_draw_menu = function(p_open)
    if ig.Begin("Demo: Callbacks", p_open) then
        if ig.TreeNode("Callback list") then
            ig.BulletText("void __cdecl botm_request_save_settings();")
            ig.BulletText("bool __cdecl botm_load(ScriptEnv *env);")
            ig.BulletText("void __cdecl botm_unload();")
            ig.BulletText("void __cdecl botm_uncapped_tick();")
            ig.BulletText("void __cdecl botm_before_tick();")
            ig.BulletText("void __cdecl botm_tick();")
            ig.BulletText("void __cdecl botm_after_tick();")
            ig.BulletText("void __cdecl botm_lazy_tick();")
            ig.BulletText("void __cdecl botm_draw_world();")
            ig.BulletText("void __cdecl botm_draw();")
            ig.BulletText("void __cdecl botm_draw_menu();")
            ig.BulletText("void __cdecl botm_key_up(uint32_t vk_code);")
            ig.BulletText("void __cdecl botm_key_down(uint32_t vk_code);")
            ig.BulletText("void __cdecl botm_mouse_up(uint32_t vk_code);")
            ig.BulletText("void __cdecl botm_mouse_down(uint32_t vk_code);")
            ig.BulletText("void __cdecl botm_create_object(GameObject *obj);")
            ig.BulletText("void __cdecl botm_delete_object(GameObjectType type, uint32_t id);")
            ig.BulletText("void __cdecl botm_process_spell(Spell *spell);")
            ig.BulletText("void __cdecl botm_spell_execute(Spell *spell);")
            ig.BulletText("void __cdecl botm_spell_cancel(Spell *spell);")
            ig.BulletText("void __cdecl botm_gain_buff(Buff *buff);")
            ig.BulletText("void __cdecl botm_lose_buff(Buff *buff);")
            ig.BulletText("void __cdecl botm_update_buff(Buff *buff);")
            ig.BulletText("void __cdecl botm_play_animation(GameObject *obj, const char *name);")
            ig.BulletText("void __cdecl botm_waypoints_change(Hero *obj);")
            ig.BulletText("void __cdecl botm_game_event(GameEventInfo *info);")
            ig.BulletText("void __cdecl botm_game_end();")
            ig.BulletText("void __cdecl botm_cast_spell(CastSpellInfo *info);")
            ig.BulletText("void __cdecl botm_issue_order(IssueOrderInfo *info);")
            ig.TreePop()
        end

        ig.NewLine()
        ig.TextWrapped("Registering a callback function is done by setting it in the scripts environment \"botm\" table")
        ig.NewLine()
        ig.PushStyleColor(ig.lib.ImGuiCol_Text, demo_h.col_text)
        ig.Text("botm.load = function(env)")
        ig.Text("\tprint(\"hello world\")")
        ig.Text("\treturn true")
        ig.Text("end")
        ig.PopStyleColor(1)
        ig.NewLine()
        ig.TextWrapped("When writing in C you have to export your callback function")
        ig.NewLine()
        ig.PushStyleColor(ig.lib.ImGuiCol_Text, demo_h.col_text)
        ig.Text("#include \"botm_api.h\"")
        ig.NewLine()
        ig.Text("BOTM_EXPORT void BOTM_API botm_load(ScriptEnv *env)")
        ig.Text("{\n")
        ig.Text("\tenv->print(\"hello world\");")
        ig.Text("\treturn true;")
        ig.Text("}")
        ig.PopStyleColor(1)
    end 
    ig.End()
end

return {
    botm_draw_menu = botm_draw_menu,
}