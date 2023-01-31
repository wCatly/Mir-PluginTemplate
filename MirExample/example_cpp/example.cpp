#include "botm_api.h"

void (__cdecl * print) (const char *fmt, ...);
Game *game;
Player *player;
ObjectManager *object_manager;

BOTM_EXPORT void BOTM_API botm_draw_menu()
{
    if (igBegin("IconTest", NULL, ImGuiWindowFlags_None)) {
        igText(ICON_FA_TELEGRAM " " ICON_FA_SCREWDRIVER_WRENCH);

    }
    igEnd();
}

BOTM_EXPORT bool BOTM_API botm_load(ScriptEnv *env)
{
    print = env->printf;
    game = env->game;
    player = env->player;
    object_manager = env->object_manager;

    print("Hello from C++ example\n");

    //class methods
    float health = player->health();
    print("health %f\n", health);

    //math vector operator overloading
    float3 a = game->mouse_pos();
    float3 b = player->pos();
    float3 c = a - b;
    print("len %f\n", c.len());

    //range-based for loops for vec_ types
    for (auto& hero : object_manager->heroes()) {
        print("hero %s\n", hero->name());
    }

    return true;
}

