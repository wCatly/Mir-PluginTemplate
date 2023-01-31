#include "botm_api.h"

void (__cdecl * print) (const char *fmt, ...);
Game *game;
Player *player;
ObjectManager *object_manager;

BOTM_EXPORT void BOTM_API botm_tick()
{
    //print("Game time %f\n", Game_time(game));
    
}

BOTM_EXPORT void BOTM_API botm_draw_menu()
{
    if (igBegin("MyMenu", NULL, ImGuiWindowFlags_None)) {
        igText("Hello");

    }
    igEnd();
}

BOTM_EXPORT bool BOTM_API botm_load(ScriptEnv *env)
{
    print = env->printf;
    game = env->game;
    player = env->player;
    object_manager = env->object_manager;

    print("Hello from C example\n");

    float health = Player_health(player);
    print("health %f\n", health);

    float3 a = Game_mouse_pos(game);
    float3 b = Player_pos(player);
    float3 c = float3_sub(a, b);
    print("len %f\n", float3_len(c));

    vec_hero_t vec = ObjectManager_heroes(object_manager);
    for (size_t i = 0; i < vec.n; i++) {
        print("hero %s\n", Hero_name(vec.val[i]));
    }

    return true;
}

