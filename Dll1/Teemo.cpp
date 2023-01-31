#include "Teemo.h"
#include <vector>

namespace Teemo
{
	void on_load(ScriptEnv *env)
	{
		env->chat->print("Hello from Teemo");
	}

	void draw_menu()
	{
		 if (igBegin("Teemo", NULL, ImGuiWindowFlags_None)) {
        igText(ICON_FA_BLACKBERRY);

    }
    igEnd();
	}


}
