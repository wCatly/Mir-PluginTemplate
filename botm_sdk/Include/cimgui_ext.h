#ifndef CIMGUI_EXT_H
#define CIMGUI_EXT_H

#include "cimgui.h"

typedef struct Hotkey Hotkey;

CIMGUI_API int16_t Hotkey_get_key(Hotkey * const me);
CIMGUI_API const char* Hotkey_get_key_string(Hotkey * const me);
CIMGUI_API void Hotkey_set_key(Hotkey * const me, int16_t vk);
CIMGUI_API void Hotkey_set_is_toggle(Hotkey * const me, bool is_toggle);
CIMGUI_API void Hotkey_set_toggle_state(Hotkey * const me, bool is_toggle_pressed);
CIMGUI_API bool Hotkey_is_toggle(Hotkey * const me);
CIMGUI_API bool Hotkey_is_pressed(Hotkey * const me);

CIMGUI_API Hotkey* igCreateHotkey();
CIMGUI_API void igHotkey(const char *label, Hotkey *hotkey);

CIMGUI_API void igPushChineseFont();
CIMGUI_API void igPopChineseFont();

#ifdef BOTM_CPP_EXT

class Hotkey {
public:
	int16_t get_key()
	{
		return Hotkey_get_key(this);
	}
	const char* get_key_string()
	{
		return Hotkey_get_key_string(this);
	}
	void set_key(int16_t vk)
	{
		return Hotkey_set_key(this, vk);
	}
	void set_is_toggle(bool v)
	{
		return Hotkey_set_is_toggle(this, v);
	}
	void set_toggle_state(bool v)
	{
		return Hotkey_set_toggle_state(this, v);
	}
	bool is_toggle()
	{
		return Hotkey_is_toggle(this);
	}
	bool is_pressed()
	{
		return Hotkey_is_pressed(this);
	}
};

#endif

#endif