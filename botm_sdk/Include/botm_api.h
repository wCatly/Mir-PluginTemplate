#ifndef BOTM_API_H
#define BOTM_API_H

#include <stdarg.h>
#include <stdbool.h>
#include <stdint.h>
#include <windef.h>

#ifdef __cplusplus
	#include <iterator>
#endif

#include "botm_config.h"

#include "IconsFontAwesome6.h"
#include "IconsFontAwesome6Brands.h"
#define CIMGUI_NO_EXPORT
#define CIMGUI_DEFINE_ENUMS_AND_STRUCTS
#include "cimgui.h"
#include "cimgui_ext.h"


//-----------------------------------------------------------------------------
// [Enums]
//-----------------------------------------------------------------------------
enum BotMLanguage_ {
    BotMLanguage_En,
    BotMLanguage_Cn
};

enum GamePing_ {
    GamePing_Alert = 0,
    GamePing_Caution,
    GamePing_OnMyWay,
    GamePing_EnemyMissing,
    GamePing_Retreat,
    GamePing_AssistMe,
    GamePing_Push,
    GamePing_AllIn,
    GamePing_Hold,
    GamePing_Bait,
    GamePing_EnemyVision,
    GamePing_NeedVision,
    GamePing_VisionCleared,
    GamePing_COUNT
};

enum CellTypeFlags_ 
{
    CellTypeFlags_Grass = 1 << 0,
    CellTypeFlags_Wall = 1 << 1,
    CellTypeFlags_Structure = 1 << 2,
};

enum GameObjectType_ 
{
    GameObjectType_Unknown = 0,
    GameObjectType_Hero,
    GameObjectType_Minion,
    GameObjectType_Turret,
    GameObjectType_Inhib,
    GameObjectType_Nexus,
    GameObjectType_Missile,
    GameObjectType_Particle,
    GameObjectType_NeutralCamp
};

enum GameObjectTeam_ 
{
    GameObjectTeam_Ally = 0,
    GameObjectTeam_Enemy,
    GameObjectTeam_Neutral
};

enum CombatType_ 
{
    CombatType_None,
	CombatType_Melee,
	CombatType_Ranged
};

enum BuffType_ 
{
	BuffType_Internal = 0,
	BuffType_Aura,
	BuffType_CombatEnhancer,
	BuffType_CombatDehancer,
	BuffType_SpellShield,
	BuffType_Stun,
	BuffType_Invisibility,
	BuffType_Silence,
	BuffType_Taunt,
	BuffType_Berserk,
	BuffType_Polymorph,
	BuffType_Slow,
	BuffType_Snare,
	BuffType_Damage,
	BuffType_Heal,
	BuffType_Haste,
	BuffType_SpellImmunity,
	BuffType_PhysicalImmunity,
	BuffType_Invulnerability,
	BuffType_AttackspeedSlow,
	BuffType_Nearsight,
	BuffType_Currency,
	BuffType_Fear,
	BuffType_Charm,
	BuffType_Poison,
	BuffType_Suppression,
	BuffType_Blind,
	BuffType_Counter,
	BuffType_Shred,
	BuffType_Flee,
	BuffType_KnockUp,
	BuffType_KnockBack,
	BuffType_Disarm,
	BuffType_Grounded,
	BuffType_Drowsy,
	BuffType_Asleep,
	BuffType_Obscured,
	BuffType_ClickproofToEnemies,
	BuffType_Unkillable
};

enum SpellSlotEnum_ 
{
    SpellSlot_Q = 0,
    SpellSlot_W,
    SpellSlot_E,
    SpellSlot_R,
    SpellSlot_Summoner1,
    SpellSlot_Summoner2,
    SpellSlot_Item1,
    SpellSlot_Item2,
    SpellSlot_Item3,
    SpellSlot_Item4,
    SpellSlot_Item5,
    SpellSlot_Item6,
    SpellSlot_Trinket,
    SpellSlot_Recall,
    SpellSlot_14,
    SpellSlot_15,
    SpellSlot_16,
    SpellSlot_17,
    SpellSlot_18,
    SpellSlot_19,
    SpellSlot_20,
    SpellSlot_21,
    SpellSlot_22,
    SpellSlot_23,
    SpellSlot_24,
    SpellSlot_25,
    SpellSlot_26,
    SpellSlot_27,
    SpellSlot_28,
    SpellSlot_29,
    SpellSlot_30,
    SpellSlot_31,
    SpellSlot_32,
    SpellSlot_33,
    SpellSlot_34,
    SpellSlot_35,
    SpellSlot_36,
    SpellSlot_37,
    SpellSlot_38,
    SpellSlot_39,
    SpellSlot_40,
    SpellSlot_41,
    SpellSlot_42,
    SpellSlot_43,
    SpellSlot_44,
    SpellSlot_45,
    SpellSlot_46,
    SpellSlot_47,
    SpellSlot_48,
    SpellSlot_49,
    SpellSlot_50,
    SpellSlot_51,
    SpellSlot_52,
    SpellSlot_53,
    SpellSlot_54,
    SpellSlot_55,
    SpellSlot_56,
    SpellSlot_57,
    SpellSlot_58,
    SpellSlot_59,
    SpellSlot_60,
    SpellSlot_61,
    SpellSlot_62,
    SpellSlot_Passive,
    SpellSlot_COUNT
};

enum TargetingType_ 
{
    TargetingType_Self = 0,
    TargetingType_Target,
    TargetingType_Area,
    TargetingType_Unknown1,
    TargetingType_Cone,
    TargetingType_SelfAoe,
    TargetingType_TargetOrLocation,
    TargetingType_Location,
    TargetingType_Direction,
    TargetingType_Unknown2,
    TargetingType_DragDirection,
    TargetingType_LineTargetToCaster,
    TargetingType_AreaClamped,
    TargetingType_LocationClamped,
    TargetingType_TerrainLocation,
    TargetingType_TerrainType,
    TargetingType_LineTerrainToCaster
};

enum ItemSlotEnum_ 
{
    ItemSlot_0 = 0,
    ItemSlot_1,
    ItemSlot_2,
    ItemSlot_3,
    ItemSlot_4,
    ItemSlot_5,
    ItemSlot_COUNT
};

enum SpellCastStatusFlags_ 
{
    SpellCastStatusFlags_Ready = 0,
    SpellCastStatusFlags_NotAvailable = 1 << 1,
    SpellCastStatusFlags_NotLearned = 1 << 2,
    SpellCastStatusFlags_Disabled = 1 << 3,
    SpellCastStatusFlags_Supressed = 1 << 4,
    SpellCastStatusFlags_Cooldown = 1 << 5,
    SpellCastStatusFlags_OutOfMana = 1 << 6
};

enum IssueOrder_ 
{
    IssueOrder_Move = 0,
    IssueOrder_HoldPosition,
    IssueOrder_Stop,
    IssueOrder_AttackMove,
    IssueOrder_Attack,
    IssueOrder_PetMove,
    IssueOrder_PetAttack
};

enum GameEvent_ 
{
    GameEvent_PlayerMoveClick,
    GameEvent_PlayerReleaseMoveClick,
    GameEvent_PlayerMoveClick_MouseTriggered,
    GameEvent_PetMoveClick,
    GameEvent_PlayerAttackMove,
    GameEvent_PlayerAttackMoveClick,
    GameEvent_PlayerAttackMoveClick_MouseTriggered,
    GameEvent_PlayerAttackOnlyClick,
    GameEvent_PlayerStopPosition,
    GameEvent_PlayerHoldPosition,
    GameEvent_NormalCastVisionItem,
    GameEvent_SmartCastVisionItem,
    GameEvent_SmartPlusSelfCastItem2,
    GameEvent_SelfCastSpell4,
    GameEvent_SmartPlusSelfCastWithIndicatorItem2,
    GameEvent_SmartCastWithIndicatorItem2,
    GameEvent_SmartCastItem1,
    GameEvent_UseItem6,
    GameEvent_SmartCastItem4,
    GameEvent_SmartPlusSelfCastWithIndicatorItem1,
    GameEvent_UseItem5,
    GameEvent_SmartCastWithIndicatorItem6,
    GameEvent_SmartPlusSelfCastWithIndicatorVisionItem,
    GameEvent_UseItem1,
    GameEvent_CastSpell4,
    GameEvent_CastSpell3,
    GameEvent_CastSpell2,
    GameEvent_SelfCastItem2,
    GameEvent_CastSpell1,
    GameEvent_CastAvatarSpell2,
    GameEvent_CastAvatarSpell1,
    GameEvent_NormalCastSpell4,
    GameEvent_NormalCastSpell3,
    GameEvent_NormalCastSpell2,
    GameEvent_NormalCastSpell1,
    GameEvent_NormalCastAvatarSpell2,
    GameEvent_NormalCastAvatarSpell1,
    GameEvent_SmartCastSpell4,
    GameEvent_SmartCastSpell3,
    GameEvent_UseItem3,
    GameEvent_SmartCastSpell2,
    GameEvent_SmartCastSpell1,
    GameEvent_SmartCastAvatarSpell2,
    GameEvent_SmartCastAvatarSpell1,
    GameEvent_SmartCastWithIndicatorSpell4,
    GameEvent_SmartCastWithIndicatorSpell3,
    GameEvent_SmartCastWithIndicatorSpell2,
    GameEvent_SmartCastWithIndicatorSpell1,
    GameEvent_SmartCastWithIndicatorAvatarSpell2,
    GameEvent_SmartCastWithIndicatorAvatarSpell1,
    GameEvent_SelfCastSpell3,
    GameEvent_SelfCastSpell2,
    GameEvent_SelfCastSpell1,
    GameEvent_NormalCastItem5,
    GameEvent_SelfCastAvatarSpell2,
    GameEvent_SelfCastAvatarSpell1,
    GameEvent_SmartPlusSelfCastSpell4,
    GameEvent_SmartPlusSelfCastSpell3,
    GameEvent_SelfCastVisionItem,
    GameEvent_SmartPlusSelfCastSpell2,
    GameEvent_SmartPlusSelfCastSpell1,
    GameEvent_SmartPlusSelfCastAvatarSpell2,
    GameEvent_SmartCastWithIndicatorItem3,
    GameEvent_SmartPlusSelfCastAvatarSpell1,
    GameEvent_SmartPlusSelfCastWithIndicatorSpell4,
    GameEvent_SmartPlusSelfCastWithIndicatorSpell3,
    GameEvent_SmartPlusSelfCastWithIndicatorSpell2,
    GameEvent_SmartPlusSelfCastWithIndicatorSpell1,
    GameEvent_SmartPlusSelfCastWithIndicatorAvatarSpell2,
    GameEvent_SmartPlusSelfCastWithIndicatorAvatarSpell1,
    GameEvent_UseItem7,
    GameEvent_UseVisionItem,
    GameEvent_UseItem4,
    GameEvent_UseItem2,
    GameEvent_NormalCastItem6,
    GameEvent_NormalCastItem4,
    GameEvent_NormalCastItem3,
    GameEvent_NormalCastItem2,
    GameEvent_NormalCastItem1,
    GameEvent_SmartCastItem6,
    GameEvent_SmartCastItem5,
    GameEvent_SmartCastItem3,
    GameEvent_SmartCastItem2,
    GameEvent_SmartCastWithIndicatorVisionItem,
    GameEvent_SmartCastWithIndicatorItem5,
    GameEvent_SmartCastWithIndicatorItem4,
    GameEvent_SmartCastWithIndicatorItem1,
    GameEvent_SelfCastItem6,
    GameEvent_SelfCastItem5,
    GameEvent_SelfCastItem4,
    GameEvent_SelfCastItem3,
    GameEvent_SelfCastItem1,
    GameEvent_SmartPlusSelfCastVisionItem,
    GameEvent_SmartPlusSelfCastItem6,
    GameEvent_SmartPlusSelfCastItem5,
    GameEvent_SmartPlusSelfCastItem4,
    GameEvent_SmartPlusSelfCastItem3,
    GameEvent_SmartPlusSelfCastItem1,
    GameEvent_SmartPlusSelfCastWithIndicatorItem6,
    GameEvent_SmartPlusSelfCastWithIndicatorItem5,
    GameEvent_SmartPlusSelfCastWithIndicatorItem4,
    GameEvent_SmartPlusSelfCastWithIndicatorItem3,
};

typedef int BotMLanguage;
typedef int GamePing;
typedef int CellTypeFlags;
typedef int GameObjectType;
typedef int GameObjectTeam;
typedef int CombatType;
typedef int BuffType;
typedef int SpellSlotEnum;
typedef int TargetingType;
typedef int ItemSlotEnum;
typedef int SpellCastStatusFlags;
typedef int IssueOrder;
typedef int GameEvent;
typedef int CollisionFlags;

#ifdef BOTM_CPP_EXT

//-----------------------------------------------------------------------------
// [Modules]
//-----------------------------------------------------------------------------
class Console;
class BotM;
class ScriptTor;
class Game;
class Hud;
class Navmesh;
class Chat;
class Shop;
class Minimap;
class Camera;
class Options;
class Graphics;
class Ini;
class ObjectManager;
class Pred;

//-----------------------------------------------------------------------------
// [Game classes]
//-----------------------------------------------------------------------------
class Texture;
class HudElement;
class HudHitRegion;
class HudText;
class HudTexture;
class HudGroup;
class HudButton;
class HudBase;
class FloatingInfoBar;
class AttackSlotData;
class CharacterData;
class CharacterRecord;
class Buff;
class SpellDataEffectAmount;
class SpellDataValue;
class SpellCalculation;
class SpellDataResource;
class SpellSlot;
class Spell;
class Path;
class Rune;
class ItemSlot;

//-----------------------------------------------------------------------------
// [GameObjects]
//-----------------------------------------------------------------------------
class GameObject;
class AttackableUnit;
class AIClient;
class Particle;
class NeutralCamp;
class Inhib;
class Nexus;
class Missile;
class Turret;
class Hero;
class Minion;
class Player;

#else

//-----------------------------------------------------------------------------
// [Modules]
//-----------------------------------------------------------------------------
typedef struct Console Console;
typedef struct BotM BotM;
typedef struct ScriptTor ScriptTor;
typedef struct Game Game;
typedef struct Hud Hud;
typedef struct Navmesh Navmesh;
typedef struct Chat Chat;
typedef struct Shop Shop;
typedef struct Minimap Minimap;
typedef struct Camera Camera;
typedef struct Options Options;
typedef struct Graphics Graphics;
typedef struct Ini Ini;
typedef struct ObjectManager ObjectManager;

//-----------------------------------------------------------------------------
// [Game classes]
//-----------------------------------------------------------------------------
typedef struct Texture Texture;
typedef struct HudElement HudElement;
typedef struct HudHitRegion HudHitRegion;
typedef struct HudText HudText;
typedef struct HudTexture HudTexture;
typedef struct HudGroup HudGroup;
typedef struct HudButton HudButton;
typedef struct HudBase HudBase;
typedef struct FloatingInfoBar FloatingInfoBar;
typedef struct AttackSlotData AttackSlotData;
typedef struct CharacterData CharacterData;
typedef struct CharacterRecord CharacterRecord;
typedef struct Buff Buff;
typedef struct SpellDataEffectAmount SpellDataEffectAmount;
typedef struct SpellDataValue SpellDataValue;
typedef struct SpellCalculation SpellCalculation;
typedef struct SpellDataResource SpellDataResource;
typedef struct SpellSlot SpellSlot;
typedef struct Spell Spell;
typedef struct Path Path;
typedef struct Rune Rune;
typedef struct ItemSlot ItemSlot;

//-----------------------------------------------------------------------------
// [GameObjects]
//-----------------------------------------------------------------------------
typedef struct GameObject GameObject;
typedef struct AttackableUnit AttackableUnit;
typedef struct AIClient AIClient;
typedef struct Particle Particle;
typedef struct NeutralCamp NeutralCamp;
typedef struct Inhib Inhib;
typedef struct Nexus Nexus;
typedef struct Missile Missile;
typedef struct Turret Turret;
typedef struct Hero Hero;
typedef struct Minion Minion;
typedef struct Player Player;

#endif

typedef struct {
	float2 p_min;
	float2 p_max;
} Rect;

//-----------------------------------------------------------------------------
// [Vector types]
//-----------------------------------------------------------------------------

#ifdef BOTM_CPP_EXT

template <class T> 
struct kvec_t {
    union {
        size_t n;
        size_t size;
    };
	size_t m;
    T *val;

	struct Iterator {
		using iterator_category = std::forward_iterator_tag;
		using difference_type = std::ptrdiff_t;
		using value_type = T;
		using pointer = T*;
		using reference = T&;

		Iterator(pointer ptr) : p(ptr) {}

		reference operator*() const { return *p; }
		pointer operator->() { return p; }
		Iterator& operator++() { p++; return *this; }  
		Iterator operator++(int) { Iterator tmp = *this; ++(*this); return tmp; }
		friend bool operator== (const Iterator& a, const Iterator& b) { return a.p == b.p; };
		friend bool operator!= (const Iterator& a, const Iterator& b) { return a.p != b.p; };   

	private:
		pointer p;
	};

	Iterator begin() { return Iterator(val); }
    Iterator end() { return Iterator(&val[n]); }
};

template struct kvec_t<float>;
template struct kvec_t<int>;
template struct kvec_t<const char*>;
template struct kvec_t<float3>;
template struct kvec_t<Texture*>;
template struct kvec_t<HudElement*>;
template struct kvec_t<HudBase*>;
template struct kvec_t<AttackSlotData*>;
template struct kvec_t<Buff*>;
template struct kvec_t<FloatingInfoBar*>;
template struct kvec_t<Spell*>;
template struct kvec_t<SpellCalculation*>;
template struct kvec_t<Rune*>;
template struct kvec_t<GameObject*>;
template struct kvec_t<Particle*>;
template struct kvec_t<NeutralCamp*>;
template struct kvec_t<Missile*>;
template struct kvec_t<Inhib*>;
template struct kvec_t<Nexus*>;
template struct kvec_t<Turret*>;
template struct kvec_t<Minion*>;
template struct kvec_t<Hero*>;
template struct kvec_t<AttackableUnit*>;
template struct kvec_t<AIClient*>;

typedef kvec_t<float> vec_float_t;
typedef kvec_t<int> vec_int_t;
typedef kvec_t<const char*> vec_string_t;
typedef kvec_t<float3> vec_float3_t;
typedef kvec_t<Texture*> vec_texture_t;
typedef kvec_t<HudElement*> vec_hud_element_t;
typedef kvec_t<HudBase*> vec_hud_base_t;
typedef kvec_t<AttackSlotData*> vec_attack_slot_data_t;
typedef kvec_t<Buff*> vec_buff_t;
typedef kvec_t<FloatingInfoBar*> vec_floating_info_bar_t;
typedef kvec_t<Spell*> vec_spell_t;
typedef kvec_t<SpellCalculation*> vec_spell_calculation_t;
typedef kvec_t<Rune*> vec_rune_t;
typedef kvec_t<GameObject*> vec_game_object_t;
typedef kvec_t<Particle*> vec_particle_t;
typedef kvec_t<NeutralCamp*> vec_neutral_camp_t;
typedef kvec_t<Missile*> vec_missile_t;
typedef kvec_t<Inhib*> vec_inhib_t;
typedef kvec_t<Nexus*> vec_nexus_t;
typedef kvec_t<Turret*> vec_turret_t;
typedef kvec_t<Minion*> vec_minion_t;
typedef kvec_t<Hero*> vec_hero_t;
typedef kvec_t<AttackableUnit*> vec_attackable_unit_t;
typedef kvec_t<AIClient*> vec_ai_client_t;

#else

typedef struct {
    union {
        size_t n;
        size_t size;
    };
	size_t m;
	float *val;
} vec_float_t;

typedef struct {
    union {
        size_t n;
        size_t size;
    };
	size_t m;
	int *val;
} vec_int_t;

typedef struct {
    union {
        size_t n;
        size_t size;
    };
	size_t m;
	const char **val;
} vec_string_t;

typedef struct {
    union {
        size_t n;
        size_t size;
    };
	size_t m;
	float3 *val;
} vec_float3_t;

typedef struct {
    union {
        size_t n;
        size_t size;
    };
	size_t m;
	Texture **val;
} vec_texture_t;

typedef struct {
    union {
        size_t n;
        size_t size;
    };
	size_t m;
	HudElement **val;
} vec_hud_element_t;  

typedef struct {
    union {
        size_t n;
        size_t size;
    };
	size_t m;
	HudBase **val;
} vec_hud_base_t;  

typedef struct {
    union {
        size_t n;
        size_t size;
    };
	size_t m;
	AttackSlotData **val;
} vec_attack_slot_data_t;  

typedef struct {
    union {
        size_t n;
        size_t size;
    };
	size_t m;
	Buff **val;
} vec_buff_t;

typedef struct {
    union {
        size_t n;
        size_t size;
    };
	size_t m;
	FloatingInfoBar **val;
} vec_floating_info_bar_t;

typedef struct {
    union {
        size_t n;
        size_t size;
    };
	size_t m;
	Spell **val;
} vec_spell_t;

typedef struct {
    union {
        size_t n;
        size_t size;
    };
	size_t m;
	SpellCalculation **val;
} vec_spell_calculation_t;

typedef struct {
    union {
        size_t n;
        size_t size;
    };
	size_t m;
	Rune **val;
} vec_rune_t;

typedef struct {
    union {
        size_t n;
        size_t size;
    };
	size_t m;
    GameObject **val;
} vec_game_object_t;

typedef struct {
    union {
        size_t n;
        size_t size;
    };
	size_t m;
	Particle **val;
} vec_particle_t;

typedef struct {
    union {
        size_t n;
        size_t size;
    };
	size_t m;
	NeutralCamp **val;
} vec_neutral_camp_t;

typedef struct {
    union {
        size_t n;
        size_t size;
    };
	size_t m;
	Missile **val;
} vec_missile_t;

typedef struct {
    union {
        size_t n;
        size_t size;
    };
	size_t m;
	Inhib **val;
} vec_inhib_t;

typedef struct {
    union {
        size_t n;
        size_t size;
    };
	size_t m;
	Nexus **val;
} vec_nexus_t;

typedef struct {
    union {
        size_t n;
        size_t size;
    };
	size_t m;
	Turret **val;
} vec_turret_t;

typedef struct {
    union {
        size_t n;
        size_t size;
    };
	size_t m;
	Minion **val;
} vec_minion_t;

typedef struct {
    union {
        size_t n;
        size_t size;
    };
	size_t m;
    Hero **val;
} vec_hero_t;

typedef struct {
    union {
        size_t n;
        size_t size;
    };
	size_t m;
    AttackableUnit **val;
} vec_attackable_unit_t;

typedef struct {
    union {
        size_t n;
        size_t size;
    };
	size_t m;
    AIClient **val;
} vec_ai_client_t;

#endif

//-----------------------------------------------------------------------------
// [Structs]
//-----------------------------------------------------------------------------

typedef struct {
    GameEvent type;
    uint8_t state;
    bool block;
    int32_t x;
    int32_t y;
} GameEventInfo;

typedef struct {
    SpellSlotEnum slot;
    float3 pos;
    float3 pos2;
    AttackableUnit *target;
    bool block;
} CastSpellInfo;

typedef struct {
    IssueOrder order;
    float3 pos;
    AttackableUnit *target;
    bool block;
} IssueOrderInfo;

typedef struct {
    void (__cdecl * printf)(const char *fmt, ...);
    Console *console;
    BotM *bot;
    ScriptTor *script_tor;
    ObjectManager *object_manager;
    Game *game;
	Hud *hud;
    Navmesh *navmesh;
    Chat *chat;
    Shop *shop;
    Minimap *minimap;
    Camera *camera;
    Options *options;
    Graphics *graphics;
    Ini *ini;
    Player *player;
} ScriptEnv;


#ifdef __cplusplus
extern "C"
{
#endif

//-----------------------------------------------------------------------------
// [C Exclusive]
//-----------------------------------------------------------------------------
bool __cdecl ScriptHandler_register_library(HMODULE module);

//-----------------------------------------------------------------------------
// [Callbacks]
//-----------------------------------------------------------------------------
BOTM_EXPORT void __cdecl botm_request_save_settings();
BOTM_EXPORT bool __cdecl botm_load(ScriptEnv *env);
BOTM_EXPORT void __cdecl botm_unload();
BOTM_EXPORT void __cdecl botm_uncapped_tick();
BOTM_EXPORT void __cdecl botm_before_tick();
BOTM_EXPORT void __cdecl botm_tick();
BOTM_EXPORT void __cdecl botm_after_tick();
BOTM_EXPORT void __cdecl botm_lazy_tick();
BOTM_EXPORT void __cdecl botm_draw_world();
BOTM_EXPORT void __cdecl botm_draw();
BOTM_EXPORT void __cdecl botm_draw_menu();
BOTM_EXPORT void __cdecl botm_key_up(uint32_t vk_code);
BOTM_EXPORT void __cdecl botm_key_down(uint32_t vk_code);
BOTM_EXPORT void __cdecl botm_mouse_up(uint32_t vk_code);
BOTM_EXPORT void __cdecl botm_mouse_down(uint32_t vk_code);
BOTM_EXPORT void __cdecl botm_create_object(GameObject *obj);
BOTM_EXPORT void __cdecl botm_delete_object(GameObjectType type, uint32_t id);
BOTM_EXPORT void __cdecl botm_process_spell(Spell *spell);
BOTM_EXPORT void __cdecl botm_spell_execute(Spell *spell);
BOTM_EXPORT void __cdecl botm_spell_cancel(Spell *spell);
BOTM_EXPORT void __cdecl botm_gain_buff(Buff *buff);
BOTM_EXPORT void __cdecl botm_lose_buff(Buff *buff);
BOTM_EXPORT void __cdecl botm_update_buff(Buff *buff);
BOTM_EXPORT void __cdecl botm_play_animation(GameObject *obj, const char *name);
BOTM_EXPORT void __cdecl botm_waypoints_change(Hero *obj);
BOTM_EXPORT void __cdecl botm_game_event(GameEventInfo *info);
BOTM_EXPORT void __cdecl botm_game_end();
BOTM_EXPORT void __cdecl botm_cast_spell(CastSpellInfo *info);
BOTM_EXPORT void __cdecl botm_issue_order(IssueOrderInfo *info);


//-----------------------------------------------------------------------------
// [Console]
//-----------------------------------------------------------------------------
void __cdecl Console_printf(Console * const me, const char *fmt, ...);
void __cdecl Console_printf_va(Console * const me, const char *fmt, va_list args);
int16_t __cdecl Console_set_attributes(Console * const me, int16_t attributes);
int16_t __cdecl Console_get_attributes(Console * const me);

//-----------------------------------------------------------------------------
// [BotM]
//-----------------------------------------------------------------------------
const char* __cdecl BotM_version(BotM * const me);
BotMLanguage __cdecl BotM_language(BotM * const me);
const char* __cdecl BotM_get_directory(BotM * const me);
const char* __cdecl BotM_get_script_directory(BotM * const me);
bool __cdecl BotM_is_menu_open(BotM * const me);
bool __cdecl BotM_issue_toggle_menu(BotM * const me);
bool __cdecl BotM_is_draw_enabled(BotM * const me);
bool __cdecl BotM_issue_toggle_drawings(BotM * const me);
const char* __cdecl BotM_compat_game_version(BotM * const me);
const char* __cdecl BotM_compat_game_server(BotM * const me);

//-----------------------------------------------------------------------------
// [ScriptTor]
//-----------------------------------------------------------------------------
bool __cdecl ScriptTor_add_script(ScriptTor * const me, const char *dir, const char *script_entry);
bool __cdecl ScriptTor_remove_script(ScriptTor * const me, const char *dir);
bool __cdecl ScriptTor_set_script_display_name(ScriptTor * const me, const char *dir, const char *display_name);
bool __cdecl ScriptTor_set_script_author(ScriptTor * const me, const char *dir, const char *author);
bool __cdecl ScriptTor_set_script_version(ScriptTor * const me, const char *dir, const char *version);
bool __cdecl ScriptTor_set_script_icon(ScriptTor * const me, const char *dir, const char *icon);
bool __cdecl ScriptTor_set_script_loadscript_id(ScriptTor * const me, const char *dir, const char *loadscript_id);
bool __cdecl ScriptTor_set_script_enabled(ScriptTor * const me, const char *dir, bool enabled);
bool __cdecl ScriptTor_issue_reload(ScriptTor * const me);
bool __cdecl ScriptTor_issue_unload(ScriptTor * const me);
bool __cdecl ScriptTor_issue_toggle(ScriptTor * const me);

//-----------------------------------------------------------------------------
// [Game]
//-----------------------------------------------------------------------------
float3 __cdecl Game_mouse_pos(Game * const me);
void __cdecl Game_mouse_pos_Ptr(Game * const me, float3 *out);
float2 __cdecl Game_cursor_pos(Game * const me);
void __cdecl Game_cursor_pos_Ptr(Game * const me, float2 *out);
float __cdecl Game_time(Game * const me);
float __cdecl Game_latency(Game * const me);
float __cdecl Game_path_update_timer(Game * const me);
uint32_t __cdecl Game_fnv_hash(Game * const me, const char *str);
const char* __cdecl Game_command_line(Game * const me);
int __cdecl Game_map_id(Game * const me);
const char* __cdecl Game_map(Game * const me);
vec_string_t __cdecl Game_mutators(Game * const me);
void __cdecl Game_mutators_Ptr(Game * const me, vec_string_t *out);
const char* __cdecl Game_mode(Game * const me);
const char* __cdecl Game_type(Game * const me);
const char* __cdecl Game_id(Game * const me);
const char* __cdecl Game_platform_id(Game * const me);
const char* __cdecl Game_version(Game * const me);
bool __cdecl Game_is_window_focused(Game * const me);
GameObject* __cdecl Game_selected_target(Game * const me);
GameObject* __cdecl Game_hovered_target(Game * const me);
vec_texture_t __cdecl Game_textures(Game * const me);
void __cdecl Game_textures_Ptr(Game * const me, vec_texture_t *out);
void __cdecl Game_ping(Game * const me, GamePing ping, const float3 pos, GameObject *target);
void __cdecl Game_ping_client(Game * const me, GamePing ping, const float3 pos, GameObject *target);

//-----------------------------------------------------------------------------
// [Hud]
//-----------------------------------------------------------------------------
vec_hud_base_t __cdecl Hud_bases(Hud * const me);
void __cdecl Hud_bases_Ptr(Hud * const me, vec_hud_base_t *out);

//-----------------------------------------------------------------------------
// [Navmesh]
//-----------------------------------------------------------------------------
float3 __cdecl Navmesh_grid_start_pos(Navmesh * const me);
void __cdecl Navmesh_grid_start_pos_Ptr(Navmesh * const me, float3 *out);
float3 __cdecl Navmesh_grid_end_pos(Navmesh * const me);
void __cdecl Navmesh_grid_end_pos_Ptr(Navmesh * const me, float3 *out);
uint2 __cdecl Navmesh_grid_size(Navmesh * const me);
void __cdecl Navmesh_grid_size_Ptr(Navmesh * const me, uint2 *out);
float __cdecl Navmesh_grid_cell_length(Navmesh * const me);
size_t __cdecl Navmesh_grid_index_to_flat_index(Navmesh * const me, const uint2 index);
size_t __cdecl Navmesh_grid_index_to_flat_index_Ptr(Navmesh * const me, uint2 *p_index);
uint2 __cdecl Navmesh_grid_flat_index_to_index(Navmesh * const me, size_t flat_index);
void __cdecl Navmesh_grid_flat_index_to_index_Ptr(Navmesh * const me, size_t flat_index, uint2 *out);
uint2 __cdecl Navmesh_grid_world_to_index(Navmesh * const me, const float3 pos);
void __cdecl Navmesh_grid_world_to_index_Ptr(Navmesh * const me, float3 *p_pos, uint2 *out);
size_t __cdecl Navmesh_grid_world_to_flat_index(Navmesh * const me, const float3 pos);
size_t __cdecl Navmesh_grid_world_to_flat_index_Ptr(Navmesh * const me, float3 *p_pos);
float3 __cdecl Navmesh_grid_index_to_world(Navmesh * const me, const uint2 index);
void __cdecl Navmesh_grid_index_to_world_Ptr(Navmesh * const me, uint2 *p_index, float3 *out);
float3 __cdecl Navmesh_grid_flat_index_to_world(Navmesh * const me, size_t flat_index);
void __cdecl Navmesh_grid_flat_index_to_world_Ptr(Navmesh * const me, size_t flat_index, float3 *out);
float3 __cdecl Navmesh_clamp_world_on_grid(Navmesh * const me, const float3 pos);
void __cdecl Navmesh_clamp_world_on_grid_Ptr(Navmesh * const me, float3 *p_pos, float3 *out);
CellTypeFlags __cdecl Navmesh_cell_type_from_index(Navmesh * const me, const uint2 index);
CellTypeFlags __cdecl Navmesh_cell_type_from_index_Ptr(Navmesh * const me, uint2 *p_index);
CellTypeFlags __cdecl Navmesh_cell_type_from_flat_index(Navmesh * const me, size_t flat_index);
CellTypeFlags __cdecl Navmesh_cell_type_from_world(Navmesh * const me, const float3 pos);
CellTypeFlags __cdecl Navmesh_cell_type_from_world_Ptr(Navmesh * const me, float3 *p_pos);
bool __cdecl Navmesh_is_grass(Navmesh * const me, const float3 pos);
bool __cdecl Navmesh_is_grass_Ptr(Navmesh * const me, float3 *p_pos);
bool __cdecl Navmesh_is_wall(Navmesh * const me, const float3 pos);
bool __cdecl Navmesh_is_wall_Ptr(Navmesh * const me, float3 *p_pos);
bool __cdecl Navmesh_is_structure(Navmesh * const me, const float3 pos);
bool __cdecl Navmesh_is_structure_Ptr(Navmesh * const me, float3 *p_pos);
float __cdecl Navmesh_get_terrain_height(Navmesh * const me, const float3 pos);
float __cdecl Navmesh_get_terrain_height_Ptr(Navmesh * const me, float3 *p_pos);
bool __cdecl Navmesh_is_direct_path(Navmesh * const me, AIClient *from, const float3 to, uint2 *index_out);
bool __cdecl Navmesh_is_direct_path_Ptr(Navmesh * const me, AIClient *from, float3 *p_to, uint2 *index_out);
vec_float3_t __cdecl Navmesh_calc_path(Navmesh * const me, AIClient *from, const float3 to);
void __cdecl Navmesh_calc_path_Ptr(Navmesh * const me, AIClient *from, float3 *p_to, vec_float3_t *out);
uint32_t __cdecl Navmesh_gameplay_area(Navmesh * const me, const float3 pos);
uint32_t __cdecl Navmesh_gameplay_area_Ptr(Navmesh * const me, float3 *p_pos);
bool __cdecl Navmesh_is_in_platform(Navmesh * const me, const float3 pos);
bool __cdecl Navmesh_is_in_platform_Ptr(Navmesh * const me, float3 *p_pos);
bool __cdecl Navmesh_is_in_base(Navmesh * const me, const float3 pos);
bool __cdecl Navmesh_is_in_base_Ptr(Navmesh * const me, float3 *p_pos);
bool __cdecl Navmesh_is_in_bot_lane(Navmesh * const me, const float3 pos);
bool __cdecl Navmesh_is_in_bot_lane_Ptr(Navmesh * const me, float3 *p_pos);
bool __cdecl Navmesh_is_in_mid_lane(Navmesh * const me, const float3 pos);
bool __cdecl Navmesh_is_in_mid_lane_Ptr(Navmesh * const me, float3 *p_pos);
bool __cdecl Navmesh_is_in_top_lane(Navmesh * const me, const float3 pos);
bool __cdecl Navmesh_is_in_top_lane_Ptr(Navmesh * const me, float3 *p_pos);
bool __cdecl Navmesh_is_in_bot_river(Navmesh * const me, const float3 pos);
bool __cdecl Navmesh_is_in_bot_river_Ptr(Navmesh * const me, float3 *p_pos);
bool __cdecl Navmesh_is_in_top_river(Navmesh * const me, const float3 pos);
bool __cdecl Navmesh_is_in_top_river_Ptr(Navmesh * const me, float3 *p_pos);
bool __cdecl Navmesh_is_in_bot_jungle(Navmesh * const me, const float3 pos);
bool __cdecl Navmesh_is_in_bot_jungle_Ptr(Navmesh * const me, float3 *p_pos);
bool __cdecl Navmesh_is_in_top_jungle(Navmesh * const me, const float3 pos);
bool __cdecl Navmesh_is_in_top_jungle_Ptr(Navmesh * const me, float3 *p_pos);

//-----------------------------------------------------------------------------
// [Chat]
//-----------------------------------------------------------------------------
bool __cdecl Chat_is_open(Chat * const me);
size_t __cdecl Chat_start(Chat * const me);
size_t __cdecl Chat_index(Chat * const me);
size_t __cdecl Chat_size(Chat * const me);
bool __cdecl Chat_send(Chat * const me, const char *message);
bool __cdecl Chat_print(Chat * const me, const char *message);
const char* __cdecl Chat_message(Chat * const me, size_t index);
void __cdecl Chat_replace(Chat * const me, size_t index, const char *message);

//-----------------------------------------------------------------------------
// [Shop]
//-----------------------------------------------------------------------------
bool __cdecl Shop_is_open(Shop * const me);
bool __cdecl Shop_can_shop(Shop * const me);
void __cdecl Shop_switch_item(Shop * const me, ItemSlotEnum old_slot, ItemSlotEnum new_slot);
void __cdecl Shop_buy_item(Shop * const me, uint32_t id);
void __cdecl Shop_sell_item(Shop * const me, ItemSlotEnum slot);
void __cdecl Shop_undo(Shop * const me);

//-----------------------------------------------------------------------------
// [Minimap]
//-----------------------------------------------------------------------------
float2 __cdecl Minimap_pos(Minimap * const me);
void __cdecl Minimap_pos_Ptr(Minimap * const me, float2 *out);
float2 __cdecl Minimap_size(Minimap * const me);
void __cdecl Minimap_size_Ptr(Minimap * const me, float2 *out);
float2 __cdecl Minimap_world_bounds(Minimap * const me);
void __cdecl Minimap_world_bounds_Ptr(Minimap * const me, float2 *out);
bool __cdecl Minimap_is_on_map(Minimap * const me, const float2 pos);
bool __cdecl Minimap_is_on_map_Ptr(Minimap * const me, float2 *p_pos);
float2 __cdecl Minimap_world_to_map(Minimap * const me, const float3 pos);
void __cdecl Minimap_world_to_map_Ptr(Minimap * const me, float3 *p_pos, float2 *out);

//-----------------------------------------------------------------------------
// [Camera]
//-----------------------------------------------------------------------------
float3 __cdecl Camera_pos(Camera * const me);
void __cdecl Camera_pos_Ptr(Camera * const me, float3 *out);
float __cdecl Camera_height(Camera * const me);
float __cdecl Camera_pitch(Camera * const me);
float __cdecl Camera_yaw(Camera * const me);
bool __cdecl Camera_is_locked(Camera * const me);
void __cdecl Camera_set_height(Camera * const me, float height);
void __cdecl Camera_set_pitch(Camera * const me, float pitch);
void __cdecl Camera_set_yaw(Camera * const me, float yaw);
void __cdecl Camera_set_const(Camera * const me, size_t offset, float value);
void __cdecl Camera_set_lock(Camera * const me, bool lock);

//-----------------------------------------------------------------------------
// [Options]
//-----------------------------------------------------------------------------
void __cdecl Options_print(Options * const me);
bool __cdecl Options_find_bool(Options * const me, const char *category, const char *name);
void __cdecl Options_change_bool(Options * const me, const char *category, const char *name, bool value);
uint32_t __cdecl Options_find_int(Options * const me, const char *category, const char *name);
void __cdecl Options_change_int(Options * const me, const char *category, const char *name, uint32_t value);
float __cdecl Options_find_float(Options * const me, const char *category, const char *name);
void __cdecl Options_change_float(Options * const me, const char *category, const char *name, float value);
int __cdecl Options_find_key_pair(Options * const me, const char *category, const char *name, char *out);
void __cdecl Options_change_key_pair(Options * const me, const char *category, const char *name, const char *key_main, const char *key_alt);

//-----------------------------------------------------------------------------
// [Graphics]
//-----------------------------------------------------------------------------
bool __cdecl Graphics_is_dx9(Graphics * const me);
void* __cdecl Graphics_dx9_device(Graphics * const me);
bool __cdecl Graphics_is_dx11(Graphics * const me);
void* __cdecl Graphics_dx11_device(Graphics * const me);
void* __cdecl Graphics_dx11_device_context(Graphics * const me);
void* __cdecl Graphics_dx11_swap_chain(Graphics * const me);
float* __cdecl Graphics_view_projection_matrix(Graphics * const me);
float __cdecl Graphics_screen_width(Graphics * const me);
float __cdecl Graphics_screen_height(Graphics * const me);
float2 __cdecl Graphics_screen_size(Graphics * const me);
void __cdecl Graphics_screen_size_Ptr(Graphics * const me, float2 *out);
float2 __cdecl Graphics_world_to_screen(Graphics * const me, const float3 pos);
void __cdecl Graphics_world_to_screen_Ptr(Graphics * const me, float3 *p_pos, float2 *out);
bool __cdecl Graphics_is_on_screen_2d(Graphics * const me, const float2 pos);
bool __cdecl Graphics_is_on_screen_2d_Ptr(Graphics * const me, float2 *p_pos);
bool __cdecl Graphics_is_on_screen_3d(Graphics * const me, const float3 pos);
bool __cdecl Graphics_is_on_screen_3d_Ptr(Graphics * const me, float3 *p_pos);
void __cdecl Graphics_draw_line_2d(Graphics * const me, const float2 from, const float2 to, uint32_t col, float thickness);
void __cdecl Graphics_draw_line_2d_Ptr(Graphics * const me, float2 *p_from, float2 *p_to, uint32_t col, float thickness);
void __cdecl Graphics_draw_line_3d(Graphics * const me, const float3 from, const float3 to, uint32_t col, float thickness);
void __cdecl Graphics_draw_line_3d_Ptr(Graphics * const me, float3 *p_from, float3 *p_to, uint32_t col, float thickness);
void __cdecl Graphics_draw_rectangle_2d(Graphics * const me, const float2 p_min, const float2 p_max, uint32_t col, float thickness);
void __cdecl Graphics_draw_rectangle_2d_Ptr(Graphics * const me, float2 *p_min, float2 *p_max, uint32_t col, float thickness);
void __cdecl Graphics_draw_filled_rectangle_2d(Graphics * const me, const float2 p_min, const float2 p_max, uint32_t col);
void __cdecl Graphics_draw_filled_rectangle_2d_Ptr(Graphics * const me, float2 *p_min, float2 *p_max, uint32_t col);
void __cdecl Graphics_draw_circle_in_rectangle_2d(Graphics * const me, const float2 center, float radius, const float2 p_min, const float2 p_max, uint32_t col, size_t num_segments, float thickness);
void __cdecl Graphics_draw_circle_in_rectangle_2d_Ptr(Graphics * const me, float2 *p_center, float radius, float2 *p_min, float2 *p_max, uint32_t col, size_t num_segments, float thickness);
void __cdecl Graphics_draw_triangle_2d(Graphics * const me, const float2 p1, const float2 p2, const float2 p3, uint32_t col, float thickness);
void __cdecl Graphics_draw_triangle_2d_Ptr(Graphics * const me, float2 *p_p1, float2 *p_p2, float2 *p_p3, uint32_t col, float thickness);
void __cdecl Graphics_draw_filled_triangle_2d(Graphics * const me, const float2 p1, const float2 p2, const float2 p3, uint32_t col);
void __cdecl Graphics_draw_filled_triangle_2d_Ptr(Graphics * const me, float2 *p_p1, float2 *p_p2, float2 *p_p3, uint32_t col);
void __cdecl Graphics_draw_triangle_3d(Graphics * const me, const float3 p1, const float3 p2, const float3 p3, uint32_t col, float thickness);
void __cdecl Graphics_draw_triangle_3d_Ptr(Graphics * const me, float3 *p_p1, float3 *p_p2, float3 *p_p3, uint32_t col, float thickness);
void __cdecl Graphics_draw_filled_triangle_3d(Graphics * const me, const float3 p1, const float3 p2, const float3 p3, uint32_t col);
void __cdecl Graphics_draw_filled_triangle_3d_Ptr(Graphics * const me, float3 *p_p1, float3 *p_p2, float3 *p_p3, uint32_t col);
void __cdecl Graphics_draw_circle_2d(Graphics * const me, const float2 center, float radius, uint32_t col, size_t num_segments, float thickness);
void __cdecl Graphics_draw_circle_2d_Ptr(Graphics * const me, float2 *p_center, float radius, uint32_t col, size_t num_segments, float thickness);
void __cdecl Graphics_draw_filled_circle_2d(Graphics * const me, const float2 center, float radius, uint32_t col, size_t num_segments);
void __cdecl Graphics_draw_filled_circle_2d_Ptr(Graphics * const me, float2 *p_center, float radius, uint32_t col, size_t num_segments);
void __cdecl Graphics_draw_circle_3d(Graphics * const me, const float3 center, float radius, uint32_t col, size_t num_segments, float thickness);
void __cdecl Graphics_draw_circle_3d_Ptr(Graphics * const me, float3 *p_center, float radius, uint32_t col, size_t num_segments, float thickness);
void __cdecl Graphics_draw_filled_circle_3d(Graphics * const me, const float3 center, float radius, uint32_t col, size_t num_segments);
void __cdecl Graphics_draw_filled_circle_3d_Ptr(Graphics * const me, float3 *p_center, float radius, uint32_t col, size_t num_segments);
void __cdecl Graphics_draw_polyline_2d(Graphics * const me, float2 *points, size_t num_points, uint32_t col, float thickness);
void __cdecl Graphics_draw_polyline_2d_ex(Graphics * const me, float2 *points, size_t num_points, uint32_t col, uint32_t flags, float thickness);
void __cdecl Graphics_draw_polyline_3d(Graphics * const me, float3 *points, size_t num_points, uint32_t col, float thickness);
void __cdecl Graphics_draw_polyline_3d_ex(Graphics * const me, float3 *points, size_t num_points, uint32_t col, uint32_t flags, float thickness);
void __cdecl Graphics_draw_text_2d(Graphics * const me, const float2 pos, uint32_t col, const char *text);
void __cdecl Graphics_draw_text_2d_Ptr(Graphics * const me, float2 *p_pos, uint32_t col, const char *text);
void __cdecl Graphics_draw_sized_text_2d(Graphics * const me, float font_size, const float2 pos, uint32_t col, const char *text);
void __cdecl Graphics_draw_sized_text_2d_Ptr(Graphics * const me, float font_size, float2 *p_pos, uint32_t col, const char *text);
void __cdecl Graphics_draw_text_3d(Graphics * const me, const float3 pos, uint32_t col, const char *text);
void __cdecl Graphics_draw_text_3d_Ptr(Graphics * const me, float3 *p_pos, uint32_t col, const char *text);
void __cdecl Graphics_draw_sized_text_3d(Graphics * const me, float font_size, const float3 pos, uint32_t col, const char *text);
void __cdecl Graphics_draw_sized_text_3d_Ptr(Graphics * const me, float font_size, float3 *p_pos, uint32_t col, const char *text);
void __cdecl Graphics_draw_image_2d(Graphics * const me, Texture *tex, const float2 pos);
void __cdecl Graphics_draw_image_2d_Ptr(Graphics * const me, Texture *tex, float2 *p_pos);
void __cdecl Graphics_draw_image_2d_ex(Graphics * const me, Texture *tex, float2 pos, const float2 size, const float2 uv0, const float2 uv1, uint32_t col);
void __cdecl Graphics_draw_image_2d_ex_Ptr(Graphics * const me, Texture *tex, float2 *p_pos, float2 *p_size, float2 *p_uv0, float2 *p_uv1, uint32_t col);
void __cdecl Graphics_draw_image_3d(Graphics * const me, Texture *tex, const float3 pos);
void __cdecl Graphics_draw_image_3d_Ptr(Graphics * const me, Texture *tex, float3 *p_pos);
void __cdecl Graphics_draw_image_3d_ex(Graphics * const me, Texture *tex, const float3 pos, const float2 size, const float2 uv0, const float2 uv1, uint32_t col);
void __cdecl Graphics_draw_image_3d_ex_Ptr(Graphics * const me, Texture *tex, float3 *p_pos, float2 *p_size, float2 *p_uv0, float2 *p_uv1, uint32_t col);
Texture* __cdecl Graphics_load_image_from_memory(Graphics * const me, void *data, size_t size);
Texture* __cdecl Graphics_load_image_from_file(Graphics * const me, const char *path);
void __cdecl Graphics_push_chinese_font(Graphics * const me);
void __cdecl Graphics_pop_chinese_font(Graphics * const me);

//-----------------------------------------------------------------------------
// [Ini]
//-----------------------------------------------------------------------------
void __cdecl Ini_set_target(Ini * const me, const char *target);
bool __cdecl Ini_get_bool(Ini * const me, const char *section, const char *key, bool default_value);
long __cdecl Ini_get_long(Ini * const me, const char *section, const char *key, long default_value);
float __cdecl Ini_get_float(Ini * const me, const char *section, const char *key, float default_value);
bool __cdecl Ini_get_string(Ini * const me, const char *section, const char *key, const char *default_string, char *returned_string, size_t buf_size);
void __cdecl Ini_get_hotkey(Ini * const me, const char *section, const char *key, Hotkey *hotkey, long default_key, bool default_is_toggle, bool default_toggle_state);
bool __cdecl Ini_set_bool(Ini * const me, const char *section, const char *key, bool value);
bool __cdecl Ini_set_long(Ini * const me, const char *section, const char *key, long value);
bool __cdecl Ini_set_float(Ini * const me, const char *section, const char *key, float value);
bool __cdecl Ini_set_string(Ini * const me, const char *section, const char *key, const char *string);
bool __cdecl Ini_set_hotkey(Ini * const me, const char *section, const char *key, Hotkey *hotkey);

//-----------------------------------------------------------------------------
// [ObjectManager]
//-----------------------------------------------------------------------------
GameObject* __cdecl ObjectManager_get_object_by_id(ObjectManager * const me, uint32_t id);
GameObject* __cdecl ObjectManager_get_object_by_index(ObjectManager * const me, uint32_t index);
GameObject* __cdecl ObjectManager_get_object_by_network_id(ObjectManager * const me, uint32_t network_id);
void __cdecl ObjectManager_sort_heroes(ObjectManager * const me, vec_hero_t vec);
void __cdecl ObjectManager_sort_heroes_Ptr(ObjectManager * const me, vec_hero_t *p_vec);
void __cdecl ObjectManager_sort_heroes_health_percent(ObjectManager * const me, vec_hero_t vec);
void __cdecl ObjectManager_sort_heroes_health_percent_Ptr(ObjectManager * const me, vec_hero_t *p_vec);
void __cdecl ObjectManager_sort_heroes_health_absolute(ObjectManager * const me, vec_hero_t vec);
void __cdecl ObjectManager_sort_heroes_health_absolute_Ptr(ObjectManager * const me, vec_hero_t *p_vec);
void __cdecl ObjectManager_sort_heroes_effective_health_magical(ObjectManager * const me, vec_hero_t vec);
void __cdecl ObjectManager_sort_heroes_effective_health_magical_Ptr(ObjectManager * const me, vec_hero_t *p_vec);
void __cdecl ObjectManager_sort_heroes_effective_health_physical(ObjectManager * const me, vec_hero_t vec);
void __cdecl ObjectManager_sort_heroes_effective_health_physical_Ptr(ObjectManager * const me, vec_hero_t *p_vec);
void __cdecl ObjectManager_sort_minions(ObjectManager * const me, vec_minion_t vec);
void __cdecl ObjectManager_sort_minions_Ptr(ObjectManager * const me, vec_minion_t *p_vec);
vec_particle_t __cdecl ObjectManager_particles(ObjectManager * const me);
vec_neutral_camp_t __cdecl ObjectManager_neutral_camps(ObjectManager * const me);
vec_missile_t __cdecl ObjectManager_missiles(ObjectManager * const me);
vec_inhib_t __cdecl ObjectManager_inhibs(ObjectManager * const me);
vec_nexus_t __cdecl ObjectManager_nexus(ObjectManager * const me);
vec_turret_t __cdecl ObjectManager_turrets(ObjectManager * const me);
vec_minion_t __cdecl ObjectManager_minions(ObjectManager * const me);
vec_hero_t __cdecl ObjectManager_heroes(ObjectManager * const me);
vec_missile_t __cdecl ObjectManager_allied_missiles(ObjectManager * const me);
vec_missile_t __cdecl ObjectManager_enemy_missiles(ObjectManager * const me);
vec_missile_t __cdecl ObjectManager_neutral_missiles(ObjectManager * const me);
vec_inhib_t __cdecl ObjectManager_allied_inhibs(ObjectManager * const me);
vec_inhib_t __cdecl ObjectManager_enemy_inhibs(ObjectManager * const me);
vec_inhib_t __cdecl ObjectManager_neutral_inhibs(ObjectManager * const me);
vec_nexus_t __cdecl ObjectManager_allied_nexus(ObjectManager * const me);
vec_nexus_t __cdecl ObjectManager_enemy_nexus(ObjectManager * const me);
vec_nexus_t __cdecl ObjectManager_neutral_nexus(ObjectManager * const me);
vec_turret_t __cdecl ObjectManager_allied_turrets(ObjectManager * const me);
vec_turret_t __cdecl ObjectManager_enemy_turrets(ObjectManager * const me);
vec_turret_t __cdecl ObjectManager_neutral_turrets(ObjectManager * const me);
vec_turret_t __cdecl ObjectManager_allied_outer_turrets(ObjectManager * const me);
vec_turret_t __cdecl ObjectManager_enemy_outer_turrets(ObjectManager * const me);
vec_turret_t __cdecl ObjectManager_neutral_outer_turrets(ObjectManager * const me);
vec_turret_t __cdecl ObjectManager_allied_inner_turrets(ObjectManager * const me);
vec_turret_t __cdecl ObjectManager_enemy_inner_turrets(ObjectManager * const me);
vec_turret_t __cdecl ObjectManager_neutral_inner_turrets(ObjectManager * const me);
vec_turret_t __cdecl ObjectManager_allied_inhib_turrets(ObjectManager * const me);
vec_turret_t __cdecl ObjectManager_enemy_inhib_turrets(ObjectManager * const me);
vec_turret_t __cdecl ObjectManager_neutral_inhib_turrets(ObjectManager * const me);
vec_turret_t __cdecl ObjectManager_allied_nexus_turrets(ObjectManager * const me);
vec_turret_t __cdecl ObjectManager_enemy_nexus_turrets(ObjectManager * const me);
vec_turret_t __cdecl ObjectManager_neutral_nexus_turrets(ObjectManager * const me);
vec_turret_t __cdecl ObjectManager_allied_shrines(ObjectManager * const me);
vec_turret_t __cdecl ObjectManager_enemy_shrines(ObjectManager * const me);
vec_turret_t __cdecl ObjectManager_neutral_shrines(ObjectManager * const me);
vec_minion_t __cdecl ObjectManager_allied_minions(ObjectManager * const me);
vec_minion_t __cdecl ObjectManager_enemy_minions(ObjectManager * const me);
vec_minion_t __cdecl ObjectManager_neutral_minions(ObjectManager * const me);
vec_minion_t __cdecl ObjectManager_allied_lane_minions(ObjectManager * const me);
vec_minion_t __cdecl ObjectManager_enemy_lane_minions(ObjectManager * const me);
vec_minion_t __cdecl ObjectManager_allied_melee_minions(ObjectManager * const me);
vec_minion_t __cdecl ObjectManager_enemy_melee_minions(ObjectManager * const me);
vec_minion_t __cdecl ObjectManager_allied_ranged_minions(ObjectManager * const me);
vec_minion_t __cdecl ObjectManager_enemy_ranged_minions(ObjectManager * const me);
vec_minion_t __cdecl ObjectManager_allied_siege_minions(ObjectManager * const me);
vec_minion_t __cdecl ObjectManager_enemy_siege_minions(ObjectManager * const me);
vec_minion_t __cdecl ObjectManager_allied_super_minions(ObjectManager * const me);
vec_minion_t __cdecl ObjectManager_enemy_super_minions(ObjectManager * const me);
vec_minion_t __cdecl ObjectManager_jungle_minions(ObjectManager * const me);
vec_minion_t __cdecl ObjectManager_monsters(ObjectManager * const me);
vec_minion_t __cdecl ObjectManager_camp_monsters(ObjectManager * const me);
vec_minion_t __cdecl ObjectManager_medium_monsters(ObjectManager * const me);
vec_minion_t __cdecl ObjectManager_large_monsters(ObjectManager * const me);
vec_minion_t __cdecl ObjectManager_epic_monsters(ObjectManager * const me);
vec_minion_t __cdecl ObjectManager_wolves(ObjectManager * const me);
vec_minion_t __cdecl ObjectManager_gromps(ObjectManager * const me);
vec_minion_t __cdecl ObjectManager_krugs(ObjectManager * const me);
vec_minion_t __cdecl ObjectManager_raptors(ObjectManager * const me);
vec_minion_t __cdecl ObjectManager_buffs(ObjectManager * const me);
vec_minion_t __cdecl ObjectManager_blues(ObjectManager * const me);
vec_minion_t __cdecl ObjectManager_reds(ObjectManager * const me);
vec_minion_t __cdecl ObjectManager_crabs(ObjectManager * const me);
vec_minion_t __cdecl ObjectManager_dragons(ObjectManager * const me);
vec_minion_t __cdecl ObjectManager_special_void_minions(ObjectManager * const me);
vec_minion_t __cdecl ObjectManager_heralds(ObjectManager * const me);
vec_minion_t __cdecl ObjectManager_barons(ObjectManager * const me);
vec_minion_t __cdecl ObjectManager_allied_wards(ObjectManager * const me);
vec_minion_t __cdecl ObjectManager_enemy_wards(ObjectManager * const me);
vec_minion_t __cdecl ObjectManager_neutral_wards(ObjectManager * const me);
vec_minion_t __cdecl ObjectManager_allied_special_minions(ObjectManager * const me);
vec_minion_t __cdecl ObjectManager_enemy_special_minions(ObjectManager * const me);
vec_minion_t __cdecl ObjectManager_neutral_special_minions(ObjectManager * const me);
vec_minion_t __cdecl ObjectManager_allied_plants(ObjectManager * const me);
vec_minion_t __cdecl ObjectManager_enemy_plants(ObjectManager * const me);
vec_minion_t __cdecl ObjectManager_neutral_plants(ObjectManager * const me);
vec_minion_t __cdecl ObjectManager_allied_traps(ObjectManager * const me);
vec_minion_t __cdecl ObjectManager_enemy_traps(ObjectManager * const me);
vec_minion_t __cdecl ObjectManager_neutral_traps(ObjectManager * const me);
vec_minion_t __cdecl ObjectManager_allied_summons(ObjectManager * const me);
vec_minion_t __cdecl ObjectManager_enemy_summons(ObjectManager * const me);
vec_minion_t __cdecl ObjectManager_neutral_summons(ObjectManager * const me);
vec_minion_t __cdecl ObjectManager_allied_large_summons(ObjectManager * const me);
vec_minion_t __cdecl ObjectManager_enemy_large_summons(ObjectManager * const me);
vec_minion_t __cdecl ObjectManager_neutral_large_summons(ObjectManager * const me);
vec_hero_t __cdecl ObjectManager_allied_heroes(ObjectManager * const me);
vec_hero_t __cdecl ObjectManager_enemy_heroes(ObjectManager * const me);
vec_hero_t __cdecl ObjectManager_neutral_heroes(ObjectManager * const me);
vec_attackable_unit_t __cdecl ObjectManager_attackable_units(ObjectManager * const me);
vec_attackable_unit_t __cdecl ObjectManager_allied_attackable_units(ObjectManager * const me);
vec_attackable_unit_t __cdecl ObjectManager_enemy_attackable_units(ObjectManager * const me);
vec_attackable_unit_t __cdecl ObjectManager_neutral_attackable_units(ObjectManager * const me);
vec_ai_client_t __cdecl ObjectManager_ai_clients(ObjectManager * const me);
vec_ai_client_t __cdecl ObjectManager_allied_ai_clients(ObjectManager * const me);
vec_ai_client_t __cdecl ObjectManager_enemy_ai_clients(ObjectManager * const me);
vec_ai_client_t __cdecl ObjectManager_neutral_ai_clients(ObjectManager * const me);

void __cdecl ObjectManager_particles_Ptr(ObjectManager * const me, vec_particle_t *out);
void __cdecl ObjectManager_neutral_camps_Ptr(ObjectManager * const me, vec_neutral_camp_t *out);
void __cdecl ObjectManager_missiles_Ptr(ObjectManager * const me, vec_missile_t *out);
void __cdecl ObjectManager_inhibs_Ptr(ObjectManager * const me, vec_inhib_t *out);
void __cdecl ObjectManager_nexus_Ptr(ObjectManager * const me, vec_nexus_t *out);
void __cdecl ObjectManager_turrets_Ptr(ObjectManager * const me, vec_turret_t *out);
void __cdecl ObjectManager_minions_Ptr(ObjectManager * const me, vec_minion_t *out);
void __cdecl ObjectManager_heroes_Ptr(ObjectManager * const me, vec_hero_t *out);
void __cdecl ObjectManager_allied_missiles_Ptr(ObjectManager * const me, vec_missile_t *out);
void __cdecl ObjectManager_enemy_missiles_Ptr(ObjectManager * const me, vec_missile_t *out);
void __cdecl ObjectManager_neutral_missiles_Ptr(ObjectManager * const me, vec_missile_t *out);
void __cdecl ObjectManager_allied_inhibs_Ptr(ObjectManager * const me, vec_inhib_t *out);
void __cdecl ObjectManager_enemy_inhibs_Ptr(ObjectManager * const me, vec_inhib_t *out);
void __cdecl ObjectManager_neutral_inhibs_Ptr(ObjectManager * const me, vec_inhib_t *out);
void __cdecl ObjectManager_allied_nexus_Ptr(ObjectManager * const me, vec_nexus_t *out);
void __cdecl ObjectManager_enemy_nexus_Ptr(ObjectManager * const me, vec_nexus_t *out);
void __cdecl ObjectManager_neutral_nexus_Ptr(ObjectManager * const me, vec_nexus_t *out);
void __cdecl ObjectManager_allied_turrets_Ptr(ObjectManager * const me, vec_turret_t *out);
void __cdecl ObjectManager_enemy_turrets_Ptr(ObjectManager * const me, vec_turret_t *out);
void __cdecl ObjectManager_neutral_turrets_Ptr(ObjectManager * const me, vec_turret_t *out);
void __cdecl ObjectManager_allied_outer_turrets_Ptr(ObjectManager * const me, vec_turret_t *out);
void __cdecl ObjectManager_enemy_outer_turrets_Ptr(ObjectManager * const me, vec_turret_t *out);
void __cdecl ObjectManager_neutral_outer_turrets_Ptr(ObjectManager * const me, vec_turret_t *out);
void __cdecl ObjectManager_allied_inner_turrets_Ptr(ObjectManager * const me, vec_turret_t *out);
void __cdecl ObjectManager_enemy_inner_turrets_Ptr(ObjectManager * const me, vec_turret_t *out);
void __cdecl ObjectManager_neutral_inner_turrets_Ptr(ObjectManager * const me, vec_turret_t *out);
void __cdecl ObjectManager_allied_inhib_turrets_Ptr(ObjectManager * const me, vec_turret_t *out);
void __cdecl ObjectManager_enemy_inhib_turrets_Ptr(ObjectManager * const me, vec_turret_t *out);
void __cdecl ObjectManager_neutral_inhib_turrets_Ptr(ObjectManager * const me, vec_turret_t *out);
void __cdecl ObjectManager_allied_nexus_turrets_Ptr(ObjectManager * const me, vec_turret_t *out);
void __cdecl ObjectManager_enemy_nexus_turrets_Ptr(ObjectManager * const me, vec_turret_t *out);
void __cdecl ObjectManager_neutral_nexus_turrets_Ptr(ObjectManager * const me, vec_turret_t *out);
void __cdecl ObjectManager_allied_shrines_Ptr(ObjectManager * const me, vec_turret_t *out);
void __cdecl ObjectManager_enemy_shrines_Ptr(ObjectManager * const me, vec_turret_t *out);
void __cdecl ObjectManager_neutral_shrines_Ptr(ObjectManager * const me, vec_turret_t *out);
void __cdecl ObjectManager_allied_minions_Ptr(ObjectManager * const me, vec_minion_t *out);
void __cdecl ObjectManager_enemy_minions_Ptr(ObjectManager * const me, vec_minion_t *out);
void __cdecl ObjectManager_neutral_minions_Ptr(ObjectManager * const me, vec_minion_t *out);
void __cdecl ObjectManager_allied_lane_minions_Ptr(ObjectManager * const me, vec_minion_t *out);
void __cdecl ObjectManager_enemy_lane_minions_Ptr(ObjectManager * const me, vec_minion_t *out);
void __cdecl ObjectManager_allied_melee_minions_Ptr(ObjectManager * const me, vec_minion_t *out);
void __cdecl ObjectManager_enemy_melee_minions_Ptr(ObjectManager * const me, vec_minion_t *out);
void __cdecl ObjectManager_allied_ranged_minions_Ptr(ObjectManager * const me, vec_minion_t *out);
void __cdecl ObjectManager_enemy_ranged_minions_Ptr(ObjectManager * const me, vec_minion_t *out);
void __cdecl ObjectManager_allied_siege_minions_Ptr(ObjectManager * const me, vec_minion_t *out);
void __cdecl ObjectManager_enemy_siege_minions_Ptr(ObjectManager * const me, vec_minion_t *out);
void __cdecl ObjectManager_allied_super_minions_Ptr(ObjectManager * const me, vec_minion_t *out);
void __cdecl ObjectManager_enemy_super_minions_Ptr(ObjectManager * const me, vec_minion_t *out);
void __cdecl ObjectManager_jungle_minions_Ptr(ObjectManager * const me, vec_minion_t *out);
void __cdecl ObjectManager_monsters_Ptr(ObjectManager * const me, vec_minion_t *out);
void __cdecl ObjectManager_camp_monsters_Ptr(ObjectManager * const me, vec_minion_t *out);
void __cdecl ObjectManager_medium_monsters_Ptr(ObjectManager * const me, vec_minion_t *out);
void __cdecl ObjectManager_large_monsters_Ptr(ObjectManager * const me, vec_minion_t *out);
void __cdecl ObjectManager_epic_monsters_Ptr(ObjectManager * const me, vec_minion_t *out);
void __cdecl ObjectManager_wolves_Ptr(ObjectManager * const me, vec_minion_t *out);
void __cdecl ObjectManager_gromps_Ptr(ObjectManager * const me, vec_minion_t *out);
void __cdecl ObjectManager_krugs_Ptr(ObjectManager * const me, vec_minion_t *out);
void __cdecl ObjectManager_raptors_Ptr(ObjectManager * const me, vec_minion_t *out);
void __cdecl ObjectManager_buffs_Ptr(ObjectManager * const me, vec_minion_t *out);
void __cdecl ObjectManager_blues_Ptr(ObjectManager * const me, vec_minion_t *out);
void __cdecl ObjectManager_reds_Ptr(ObjectManager * const me, vec_minion_t *out);
void __cdecl ObjectManager_crabs_Ptr(ObjectManager * const me, vec_minion_t *out);
void __cdecl ObjectManager_dragons_Ptr(ObjectManager * const me, vec_minion_t *out);
void __cdecl ObjectManager_special_void_minions_Ptr(ObjectManager * const me, vec_minion_t *out);
void __cdecl ObjectManager_heralds_Ptr(ObjectManager * const me, vec_minion_t *out);
void __cdecl ObjectManager_barons_Ptr(ObjectManager * const me, vec_minion_t *out);
void __cdecl ObjectManager_allied_wards_Ptr(ObjectManager * const me, vec_minion_t *out);
void __cdecl ObjectManager_enemy_wards_Ptr(ObjectManager * const me, vec_minion_t *out);
void __cdecl ObjectManager_neutral_wards_Ptr(ObjectManager * const me, vec_minion_t *out);
void __cdecl ObjectManager_allied_special_minions_Ptr(ObjectManager * const me, vec_minion_t *out);
void __cdecl ObjectManager_enemy_special_minions_Ptr(ObjectManager * const me, vec_minion_t *out);
void __cdecl ObjectManager_neutral_special_minions_Ptr(ObjectManager * const me, vec_minion_t *out);
void __cdecl ObjectManager_allied_plants_Ptr(ObjectManager * const me, vec_minion_t *out);
void __cdecl ObjectManager_enemy_plants_Ptr(ObjectManager * const me, vec_minion_t *out);
void __cdecl ObjectManager_neutral_plants_Ptr(ObjectManager * const me, vec_minion_t *out);
void __cdecl ObjectManager_allied_traps_Ptr(ObjectManager * const me, vec_minion_t *out);
void __cdecl ObjectManager_enemy_traps_Ptr(ObjectManager * const me, vec_minion_t *out);
void __cdecl ObjectManager_neutral_traps_Ptr(ObjectManager * const me, vec_minion_t *out);
void __cdecl ObjectManager_allied_summons_Ptr(ObjectManager * const me, vec_minion_t *out);
void __cdecl ObjectManager_enemy_summons_Ptr(ObjectManager * const me, vec_minion_t *out);
void __cdecl ObjectManager_neutral_summons_Ptr(ObjectManager * const me, vec_minion_t *out);
void __cdecl ObjectManager_allied_large_summons_Ptr(ObjectManager * const me, vec_minion_t *out);
void __cdecl ObjectManager_enemy_large_summons_Ptr(ObjectManager * const me, vec_minion_t *out);
void __cdecl ObjectManager_neutral_large_summons_Ptr(ObjectManager * const me, vec_minion_t *out);
void __cdecl ObjectManager_allied_heroes_Ptr(ObjectManager * const me, vec_hero_t *out);
void __cdecl ObjectManager_enemy_heroes_Ptr(ObjectManager * const me, vec_hero_t *out);
void __cdecl ObjectManager_neutral_heroes_Ptr(ObjectManager * const me, vec_hero_t *out);
void __cdecl ObjectManager_attackable_units_Ptr(ObjectManager * const me, vec_attackable_unit_t *out);
void __cdecl ObjectManager_allied_attackable_units_Ptr(ObjectManager * const me, vec_attackable_unit_t *out);
void __cdecl ObjectManager_enemy_attackable_units_Ptr(ObjectManager * const me, vec_attackable_unit_t *out);
void __cdecl ObjectManager_neutral_attackable_units_Ptr(ObjectManager * const me, vec_attackable_unit_t *out);
void __cdecl ObjectManager_ai_clients_Ptr(ObjectManager * const me, vec_ai_client_t *out);
void __cdecl ObjectManager_allied_ai_clients_Ptr(ObjectManager * const me, vec_ai_client_t *out);
void __cdecl ObjectManager_enemy_ai_clients_Ptr(ObjectManager * const me, vec_ai_client_t *out);
void __cdecl ObjectManager_neutral_ai_clients_Ptr(ObjectManager * const me, vec_ai_client_t *out);

//-----------------------------------------------------------------------------
// [Texture]
//-----------------------------------------------------------------------------
uint32_t __cdecl Texture_memory_address(Texture * const me);
void __cdecl Texture_release(Texture * const me);
const char* __cdecl Texture_name(Texture * const me);
uint16_t __cdecl Texture_width(Texture * const me);
uint16_t __cdecl Texture_height(Texture * const me);
float2 __cdecl Texture_size(Texture * const me);
void __cdecl Texture_size_Ptr(Texture * const me, float2 *out);
ImTextureID __cdecl Texture_tex_id(Texture * const me);
bool __cdecl Texture_has_uv(Texture * const me);
Rect __cdecl Texture_uv(Texture * const me);
void __cdecl Texture_uv_Ptr(Texture * const me, Rect *out);

//-----------------------------------------------------------------------------
// [HudElement]
//-----------------------------------------------------------------------------
uint32_t __cdecl HudElement_memory_address(HudElement * const me);
const char* __cdecl HudElement_name(HudElement * const me);
HudBase* __cdecl HudElement_parent(HudElement * const me);
Rect __cdecl HudElement_calc_rect(HudElement * const me);
void __cdecl HudElement_calc_rect_Ptr(HudElement * const me, Rect *out);
bool __cdecl HudElement_is_hud_hit_region(HudElement * const me);
bool __cdecl HudElement_is_hud_text(HudElement * const me);
bool __cdecl HudElement_is_hud_texture(HudElement * const me);
bool __cdecl HudElement_is_hud_group(HudElement * const me);
bool __cdecl HudElement_is_hud_button(HudElement * const me);

//-----------------------------------------------------------------------------
// [HudHitRegion]
//-----------------------------------------------------------------------------
bool __cdecl HudHitRegion_is_active(HudHitRegion * const me);
// [HudHitRegion] [HudElement] ------------------------------------------------
uint32_t __cdecl HudHitRegion_memory_address(HudHitRegion * const me);
const char* __cdecl HudHitRegion_name(HudHitRegion * const me);
HudBase* __cdecl HudHitRegion_parent(HudHitRegion * const me);
Rect __cdecl HudHitRegion_calc_rect(HudHitRegion * const me);
void __cdecl HudHitRegion_calc_rect_Ptr(HudHitRegion * const me, Rect *out);
bool __cdecl HudHitRegion_is_hud_hit_region(HudHitRegion * const me);
bool __cdecl HudHitRegion_is_hud_text(HudHitRegion * const me);
bool __cdecl HudHitRegion_is_hud_texture(HudHitRegion * const me);
bool __cdecl HudHitRegion_is_hud_group(HudHitRegion * const me);
bool __cdecl HudHitRegion_is_hud_button(HudHitRegion * const me);

//-----------------------------------------------------------------------------
// [HudText]
//-----------------------------------------------------------------------------
const char* __cdecl HudText_text(HudText * const me);
// [HudText] [HudHitRegion] ---------------------------------------------------
bool __cdecl HudText_is_active(HudText * const me);
// [HudText] [HudElement] -----------------------------------------------------
uint32_t __cdecl HudText_memory_address(HudText * const me);
const char* __cdecl HudText_name(HudText * const me);
HudBase* __cdecl HudText_parent(HudText * const me);
Rect __cdecl HudText_calc_rect(HudText * const me);
void __cdecl HudText_calc_rect_Ptr(HudText * const me, Rect *out);
bool __cdecl HudText_is_hud_hit_region(HudText * const me);
bool __cdecl HudText_is_hud_text(HudText * const me);
bool __cdecl HudText_is_hud_texture(HudText * const me);
bool __cdecl HudText_is_hud_group(HudText * const me);
bool __cdecl HudText_is_hud_button(HudText * const me);

//-----------------------------------------------------------------------------
// [HudTexture]
//-----------------------------------------------------------------------------
Texture* __cdecl HudTexture_texture(HudTexture * const me);
float2 __cdecl HudTexture_size(HudTexture * const me);
void __cdecl HudTexture_size_Ptr(HudTexture * const me, float2 *out);
Rect __cdecl HudTexture_uv(HudTexture * const me);
void __cdecl HudTexture_uv_Ptr(HudTexture * const me, Rect *out);
// [HudTexture] [HudHitRegion] ------------------------------------------------
bool __cdecl HudTexture_is_active(HudTexture * const me);
// [HudTexture] [HudElement] --------------------------------------------------
uint32_t __cdecl HudTexture_memory_address(HudTexture * const me);
const char* __cdecl HudTexture_name(HudTexture * const me);
HudBase* __cdecl HudTexture_parent(HudTexture * const me);
Rect __cdecl HudTexture_calc_rect(HudTexture * const me);
void __cdecl HudTexture_calc_rect_Ptr(HudTexture * const me, Rect *out);
bool __cdecl HudTexture_is_hud_hit_region(HudTexture * const me);
bool __cdecl HudTexture_is_hud_text(HudTexture * const me);
bool __cdecl HudTexture_is_hud_texture(HudTexture * const me);
bool __cdecl HudTexture_is_hud_group(HudTexture * const me);
bool __cdecl HudTexture_is_hud_button(HudTexture * const me);

//-----------------------------------------------------------------------------
// [HudGroup]
//-----------------------------------------------------------------------------
size_t __cdecl HudGroup_group_index(HudGroup * const me);
// [HudGroup] [HudElement] ----------------------------------------------------
uint32_t __cdecl HudGroup_memory_address(HudGroup * const me);
const char* __cdecl HudGroup_name(HudGroup * const me);
HudBase* __cdecl HudGroup_parent(HudGroup * const me);
Rect __cdecl HudGroup_calc_rect(HudGroup * const me);
void __cdecl HudGroup_calc_rect_Ptr(HudGroup * const me, Rect *out);
bool __cdecl HudGroup_is_hud_hit_region(HudGroup * const me);
bool __cdecl HudGroup_is_hud_text(HudGroup * const me);
bool __cdecl HudGroup_is_hud_texture(HudGroup * const me);
bool __cdecl HudGroup_is_hud_group(HudGroup * const me);
bool __cdecl HudGroup_is_hud_button(HudGroup * const me);

//-----------------------------------------------------------------------------
// [HudButton]
//-----------------------------------------------------------------------------
bool __cdecl HudButton_can_trigger(HudButton * const me);
void __cdecl HudButton_trigger(HudButton * const me);
HudHitRegion* __cdecl HudButton_hit_region(HudButton * const me);
// [HudButton] [HudGroup] -----------------------------------------------------
size_t __cdecl HudButton_group_index(HudButton * const me);
// [HudButton] [HudElement] ---------------------------------------------------
uint32_t __cdecl HudButton_memory_address(HudButton * const me);
const char* __cdecl HudButton_name(HudButton * const me);
HudBase* __cdecl HudButton_parent(HudButton * const me);
Rect __cdecl HudButton_calc_rect(HudButton * const me);
void __cdecl HudButton_calc_rect_Ptr(HudButton * const me, Rect *out);
bool __cdecl HudButton_is_hud_hit_region(HudButton * const me);
bool __cdecl HudButton_is_hud_text(HudButton * const me);
bool __cdecl HudButton_is_hud_texture(HudButton * const me);
bool __cdecl HudButton_is_hud_group(HudButton * const me);
bool __cdecl HudButton_is_hud_button(HudButton * const me);

//-----------------------------------------------------------------------------
// [HudBase]
//-----------------------------------------------------------------------------
uint32_t __cdecl HudBase_memory_address(HudBase * const me);
const char* __cdecl HudBase_name(HudBase * const me);
HudBase* __cdecl HudBase_parent(HudBase * const me);
bool __cdecl HudBase_is_root(HudBase * const me);
HudBase* __cdecl HudBase_root(HudBase * const me);
vec_hud_element_t __cdecl HudBase_elements(HudBase * const me);
void __cdecl HudBase_elements_Ptr(HudBase * const me, vec_hud_element_t *out);
vec_hud_base_t __cdecl HudBase_children(HudBase * const me);
void __cdecl HudBase_children_Ptr(HudBase * const me, vec_hud_base_t *out);
bool __cdecl HudBase_is_active(HudBase * const me);
bool __cdecl HudBase_is_dragged(HudBase * const me);


//-----------------------------------------------------------------------------
// [FloatingInfoBar]
//-----------------------------------------------------------------------------
uint32_t __cdecl FloatingInfoBar_memory_address(FloatingInfoBar * const me);
HudBase* __cdecl FloatingInfoBar_hud_base(FloatingInfoBar * const me);
bool __cdecl FloatingInfoBar_is_rendered(FloatingInfoBar * const me);

//-----------------------------------------------------------------------------
// [Buff]
//-----------------------------------------------------------------------------
uint32_t __cdecl Buff_memory_address(Buff * const me);
const char* __cdecl Buff_name(Buff * const me);
uint32_t __cdecl Buff_fnv_hash(Buff * const me);
BuffType __cdecl Buff_type(Buff * const me);
size_t __cdecl Buff_stacks(Buff * const me);
size_t __cdecl Buff_stacks2(Buff * const me);
float __cdecl Buff_start_time(Buff * const me);
float __cdecl Buff_end_time(Buff * const me);
GameObject* __cdecl Buff_owner(Buff * const me);
GameObject* __cdecl Buff_source(Buff * const me);

//-----------------------------------------------------------------------------
// [SpellDataValue]
//-----------------------------------------------------------------------------
const char* __cdecl SpellDataValue_name(SpellDataValue * const me);
float* __cdecl SpellDataValue_values_array(SpellDataValue * const me);
size_t __cdecl SpellDataValue_values_array_size(SpellDataValue * const me);

//-----------------------------------------------------------------------------
// [SpellCalculation]
//-----------------------------------------------------------------------------
uint32_t __cdecl SpellCalculation_hash(SpellCalculation * const me);
float __cdecl SpellCalculation_result(SpellCalculation * const me, int level);

//-----------------------------------------------------------------------------
// [SpellDataEffectAmount]
//-----------------------------------------------------------------------------
float* __cdecl SpellDataEffectAmount_values_array(SpellDataEffectAmount * const me);
size_t __cdecl SpellDataEffectAmount_values_array_size(SpellDataEffectAmount * const me);

//-----------------------------------------------------------------------------
// [SpellDataResource]
//-----------------------------------------------------------------------------
uint32_t __cdecl SpellDataResource_memory_address(SpellDataResource * const me);
uint32_t __cdecl SpellDataResource_flags(SpellDataResource * const me);
uint32_t __cdecl SpellDataResource_affects_type_flags(SpellDataResource * const me);
uint32_t __cdecl SpellDataResource_affects_status_flags(SpellDataResource * const me);
float __cdecl SpellDataResource_coefficient(SpellDataResource * const me);
float __cdecl SpellDataResource_coefficient2(SpellDataResource * const me);
float __cdecl SpellDataResource_cast_time(SpellDataResource * const me);
vec_float_t __cdecl SpellDataResource_channel_durations(SpellDataResource * const me);
void __cdecl SpellDataResource_channel_durations_Ptr(SpellDataResource * const me, vec_float_t *out);
vec_float_t __cdecl SpellDataResource_cooldown_times(SpellDataResource * const me);
void __cdecl SpellDataResource_cooldown_times_Ptr(SpellDataResource * const me, vec_float_t *out);
float __cdecl SpellDataResource_delay_cast_offset_percent(SpellDataResource * const me);
float __cdecl SpellDataResource_delay_total_time_percent(SpellDataResource * const me);
float __cdecl SpellDataResource_pre_cast_lockout_delta_time(SpellDataResource * const me);
float __cdecl SpellDataResource_post_cast_lockout_delta_time(SpellDataResource * const me);
bool __cdecl SpellDataResource_is_delayed_by_cast_locked(SpellDataResource * const me);
float __cdecl SpellDataResource_start_cooldown(SpellDataResource * const me);
vec_float_t __cdecl SpellDataResource_cast_range_growth_max(SpellDataResource * const me);
void __cdecl SpellDataResource_cast_range_growth_max_Ptr(SpellDataResource * const me, vec_float_t *out);
vec_float_t __cdecl SpellDataResource_cast_range_growth_start_times(SpellDataResource * const me);
void __cdecl SpellDataResource_cast_range_growth_start_times_Ptr(SpellDataResource * const me, vec_float_t *out);
float __cdecl SpellDataResource_charge_update_interval(SpellDataResource * const me);
float __cdecl SpellDataResource_cancel_charge_on_recast_time(SpellDataResource * const me);
vec_int_t __cdecl SpellDataResource_max_ammo(SpellDataResource * const me);
void __cdecl SpellDataResource_max_ammo_Ptr(SpellDataResource * const me, vec_int_t *out);
vec_int_t __cdecl SpellDataResource_ammo_used(SpellDataResource * const me);
void __cdecl SpellDataResource_ammo_used_Ptr(SpellDataResource * const me, vec_int_t *out);
vec_float_t __cdecl SpellDataResource_ammo_recharge_times(SpellDataResource * const me);
void __cdecl SpellDataResource_ammo_recharge_times_Ptr(SpellDataResource * const me, vec_float_t *out);
bool __cdecl SpellDataResource_ammo_not_affected_by_cdr(SpellDataResource * const me);
bool __cdecl SpellDataResource_cooldown_not_affected_by_cdr(SpellDataResource * const me);
bool __cdecl SpellDataResource_ammo_count_hidden_in_ui(SpellDataResource * const me);
bool __cdecl SpellDataResource_cost_always_shown_in_ui(SpellDataResource * const me);
bool __cdecl SpellDataResource_cannot_be_suppressed(SpellDataResource * const me);
bool __cdecl SpellDataResource_can_cast_while_disabled(SpellDataResource * const me);
bool __cdecl SpellDataResource_can_trigger_charge_spell_while_disabled(SpellDataResource * const me);
bool __cdecl SpellDataResource_can_cast_or_queue_while_casting(SpellDataResource * const me);
bool __cdecl SpellDataResource_can_only_cast_while_disabled(SpellDataResource * const me);
bool __cdecl SpellDataResource_cant_cancel_while_winding_up(SpellDataResource * const me);
bool __cdecl SpellDataResource_cant_cancel_while_channeling(SpellDataResource * const me);
bool __cdecl SpellDataResource_cant_cast_while_rooted(SpellDataResource * const me);
bool __cdecl SpellDataResource_channel_is_interrupted_by_disables(SpellDataResource * const me);
bool __cdecl SpellDataResource_channel_is_interrupted_by_attacking(SpellDataResource * const me);
bool __cdecl SpellDataResource_apply_attack_damage(SpellDataResource * const me);
bool __cdecl SpellDataResource_apply_attack_effect(SpellDataResource * const me);
bool __cdecl SpellDataResource_apply_material_on_hit_sound(SpellDataResource * const me);
bool __cdecl SpellDataResource_doesnt_break_channels(SpellDataResource * const me);
bool __cdecl SpellDataResource_belongs_to_avatar(SpellDataResource * const me);
bool __cdecl SpellDataResource_is_disabled_while_dead(SpellDataResource * const me);
bool __cdecl SpellDataResource_can_only_cast_while_dead(SpellDataResource * const me);
bool __cdecl SpellDataResource_cursor_changes_in_grass(SpellDataResource * const me);
bool __cdecl SpellDataResource_cursor_changes_in_terrain(SpellDataResource * const me);
bool __cdecl SpellDataResource_project_target_to_cast_range(SpellDataResource * const me);
bool __cdecl SpellDataResource_spell_reveals_champion(SpellDataResource * const me);
bool __cdecl SpellDataResource_use_minimap_targeting(SpellDataResource * const me);
bool __cdecl SpellDataResource_cast_range_use_bounding_boxes(SpellDataResource * const me);
bool __cdecl SpellDataResource_minimap_icon_rotation(SpellDataResource * const me);
bool __cdecl SpellDataResource_use_charge_channeling(SpellDataResource * const me);
bool __cdecl SpellDataResource_can_move_while_channeling(SpellDataResource * const me);
bool __cdecl SpellDataResource_disable_cast_bar(SpellDataResource * const me);
bool __cdecl SpellDataResource_show_channel_bar(SpellDataResource * const me);
bool __cdecl SpellDataResource_always_snap_facing(SpellDataResource * const me);
bool __cdecl SpellDataResource_use_animator_framerate(SpellDataResource * const me);
bool __cdecl SpellDataResource_have_hit_effect(SpellDataResource * const me);
bool __cdecl SpellDataResource_is_toggle_spell(SpellDataResource * const me);
bool __cdecl SpellDataResource_do_not_need_to_face_target(SpellDataResource * const me);
float __cdecl SpellDataResource_turn_speed_scalar(SpellDataResource * const me);
bool __cdecl SpellDataResource_no_winddown_if_cancelled(SpellDataResource * const me);
bool __cdecl SpellDataResource_ignore_range_check(SpellDataResource * const me);
bool __cdecl SpellDataResource_orient_radius_texture_from_player(SpellDataResource * const me);
bool __cdecl SpellDataResource_ignore_anim_continue_until_cast_frame(SpellDataResource * const me);
bool __cdecl SpellDataResource_hide_range_indicator_when_casting(SpellDataResource * const me);
bool __cdecl SpellDataResource_update_rotation_when_casting(SpellDataResource * const me);
bool __cdecl SpellDataResource_pingable_while_disabled(SpellDataResource * const me);
bool __cdecl SpellDataResource_considered_as_auto_attack(SpellDataResource * const me);
bool __cdecl SpellDataResource_does_not_consume_mana(SpellDataResource * const me);
bool __cdecl SpellDataResource_does_not_consume_cooldown(SpellDataResource * const me);
bool __cdecl SpellDataResource_locked_spell_origination_cast_id(SpellDataResource * const me);
uint16_t __cdecl SpellDataResource_minimap_icon_display_flag(SpellDataResource * const me);
vec_float_t __cdecl SpellDataResource_cast_ranges(SpellDataResource * const me);
void __cdecl SpellDataResource_cast_ranges_Ptr(SpellDataResource * const me, vec_float_t *out);
vec_float_t __cdecl SpellDataResource_cast_range_display_overrides(SpellDataResource * const me);
void __cdecl SpellDataResource_cast_range_display_overrides_Ptr(SpellDataResource * const me, vec_float_t *out);
vec_float_t __cdecl SpellDataResource_cast_radius(SpellDataResource * const me);
void __cdecl SpellDataResource_cast_radius_Ptr(SpellDataResource * const me, vec_float_t *out);
vec_float_t __cdecl SpellDataResource_cast_radius_secondary(SpellDataResource * const me);
void __cdecl SpellDataResource_cast_radius_secondary_Ptr(SpellDataResource * const me, vec_float_t *out);
float __cdecl SpellDataResource_cast_cone_angle(SpellDataResource * const me);
float __cdecl SpellDataResource_cast_cone_distance(SpellDataResource * const me);
float __cdecl SpellDataResource_cast_target_additional_units_radius(SpellDataResource * const me);
float __cdecl SpellDataResource_lua_on_missile_update_distance_interval(SpellDataResource * const me);
uint32_t __cdecl SpellDataResource_cast_type(SpellDataResource * const me);
float __cdecl SpellDataResource_cast_frame(SpellDataResource * const me);
float __cdecl SpellDataResource_missile_speed(SpellDataResource * const me);
uint32_t __cdecl SpellDataResource_missile_effect_key(SpellDataResource * const me);
uint32_t __cdecl SpellDataResource_missile_effect_player_key(SpellDataResource * const me);
uint32_t __cdecl SpellDataResource_missile_effect_enemy_key(SpellDataResource * const me);
float __cdecl SpellDataResource_line_width(SpellDataResource * const me);
float __cdecl SpellDataResource_line_drag_length(SpellDataResource * const me);
uint32_t __cdecl SpellDataResource_look_at_policy(SpellDataResource * const me);
uint32_t __cdecl SpellDataResource_hit_effect_orient_type(SpellDataResource * const me);
uint32_t __cdecl SpellDataResource_hit_effect_key(SpellDataResource * const me);
uint32_t __cdecl SpellDataResource_hit_effect_player_key(SpellDataResource * const me);
uint32_t __cdecl SpellDataResource_after_effect_key(SpellDataResource * const me);
bool __cdecl SpellDataResource_have_hit_bone(SpellDataResource * const me);
int3 __cdecl SpellDataResource_particle_start_offset(SpellDataResource * const me);
void __cdecl SpellDataResource_particle_start_offset_Ptr(SpellDataResource * const me, int3 *out);
vec_int_t __cdecl SpellDataResource_float_vars_decimals(SpellDataResource * const me);
void __cdecl SpellDataResource_float_vars_decimals_Ptr(SpellDataResource * const me, vec_int_t *out);
vec_float_t __cdecl SpellDataResource_mana(SpellDataResource * const me);
void __cdecl SpellDataResource_mana_Ptr(SpellDataResource * const me, vec_float_t *out);
vec_float_t __cdecl SpellDataResource_mana_ui_overrides(SpellDataResource * const me);
void __cdecl SpellDataResource_mana_ui_overrides_Ptr(SpellDataResource * const me, vec_float_t *out);
uint32_t __cdecl SpellDataResource_selection_priority(SpellDataResource * const me);
float __cdecl SpellDataResource_spell_cooldown_or_sealed_queue_threshold(SpellDataResource * const me);
const char* __cdecl SpellDataResource_required_unit_tags(SpellDataResource * const me);
const char* __cdecl SpellDataResource_excluded_unit_tags(SpellDataResource * const me);
const char* __cdecl SpellDataResource_alternate_name(SpellDataResource * const me);
const char* __cdecl SpellDataResource_animation_name(SpellDataResource * const me);
const char* __cdecl SpellDataResource_animation_loop_name(SpellDataResource * const me);
const char* __cdecl SpellDataResource_animation_winddown_name(SpellDataResource * const me);
const char* __cdecl SpellDataResource_animation_lead_out_name(SpellDataResource * const me);
const char* __cdecl SpellDataResource_minimap_icon_name(SpellDataResource * const me);
const char* __cdecl SpellDataResource_keyword_when_acquired(SpellDataResource * const me);
const char* __cdecl SpellDataResource_missile_effect_name(SpellDataResource * const me);
const char* __cdecl SpellDataResource_missile_effect_player_name(SpellDataResource * const me);
const char* __cdecl SpellDataResource_missile_effect_enemy_name(SpellDataResource * const me);
const char* __cdecl SpellDataResource_hit_effect_name(SpellDataResource * const me);
const char* __cdecl SpellDataResource_hit_effect_player_name(SpellDataResource * const me);
const char* __cdecl SpellDataResource_after_effect_name(SpellDataResource * const me);
const char* __cdecl SpellDataResource_hit_bone_name(SpellDataResource * const me);
const char* __cdecl SpellDataResource_voevent_category(SpellDataResource * const me);
SpellDataEffectAmount* __cdecl SpellDataResource_effect_amount_vector(SpellDataResource * const me, size_t index);
size_t __cdecl SpellDataResource_effect_amount_vector_size(SpellDataResource * const me);
SpellDataValue* __cdecl SpellDataResource_data_values_vector(SpellDataResource * const me, size_t index);
size_t __cdecl SpellDataResource_data_values_vector_size(SpellDataResource * const me);
const char* __cdecl SpellDataResource_spell_tags_vector(SpellDataResource * const me, size_t index);
size_t __cdecl SpellDataResource_spell_tags_vector_size(SpellDataResource * const me);

//-----------------------------------------------------------------------------
// [SpellSlot]
//-----------------------------------------------------------------------------

uint32_t __cdecl SpellSlot_memory_address(SpellSlot * const me);
SpellDataResource* __cdecl SpellSlot_spell_data_resource(SpellSlot * const me);
int __cdecl SpellSlot_level(SpellSlot * const me);
float __cdecl SpellSlot_cooldown_end(SpellSlot * const me);
float __cdecl SpellSlot_total_cooldown(SpellSlot * const me);
uint32_t __cdecl SpellSlot_ammo(SpellSlot * const me);
float __cdecl SpellSlot_ammo_cooldown_end(SpellSlot * const me);
float __cdecl SpellSlot_animation_end(SpellSlot * const me);
bool __cdecl SpellSlot_is_in_animation(SpellSlot * const me);
uint8_t __cdecl SpellSlot_toggle_state(SpellSlot * const  me);
const char* __cdecl SpellSlot_name(SpellSlot * const me);
uint32_t __cdecl SpellSlot_fnv_hash(SpellSlot * const me);
uint32_t __cdecl SpellSlot_hash(SpellSlot * const me);
TargetingType __cdecl SpellSlot_targeting_type(SpellSlot * const me);
Texture* __cdecl SpellSlot_icon(SpellSlot * const me);

//-----------------------------------------------------------------------------
// [Spell]
//-----------------------------------------------------------------------------
uint32_t __cdecl Spell_memory_address(Spell * const me);
SpellDataResource* __cdecl Spell_spell_data_resource(Spell * const me);
float3 __cdecl Spell_start_pos(Spell * const me);
void __cdecl Spell_start_pos_Ptr(Spell * const me, float3 *out);
float3 __cdecl Spell_end_pos(Spell * const me);
void __cdecl Spell_end_pos_Ptr(Spell * const me, float3 *out);
float3 __cdecl Spell_end_pos_line(Spell * const me);
void __cdecl Spell_end_pos_line_Ptr(Spell * const me, float3 *out);
bool __cdecl Spell_has_target(Spell * const me);
float __cdecl Spell_wind_up_time(Spell * const me);
float __cdecl Spell_animation_time(Spell * const me);
SpellSlotEnum __cdecl Spell_slot(Spell * const me);
bool __cdecl Spell_is_basic_attack(Spell * const me);
const char* __cdecl Spell_name(Spell * const me);
uint32_t __cdecl Spell_hash(Spell * const me);
GameObject* __cdecl Spell_source(Spell * const me);
GameObject* __cdecl Spell_target(Spell * const me);

//-----------------------------------------------------------------------------
// [AttackSlotData]
//-----------------------------------------------------------------------------
uint32_t __cdecl AttackSlotData_memory_address(AttackSlotData * const me);
float __cdecl AttackSlotData_attack_total_time(AttackSlotData * const me);
float __cdecl AttackSlotData_attack_cast_time(AttackSlotData * const me);
float __cdecl AttackSlotData_attack_delay_cast_offset_percent(AttackSlotData * const me);
float __cdecl AttackSlotData_attack_delay_cast_offset_percent_attack_speed_ratio(AttackSlotData * const me);
float __cdecl AttackSlotData_attack_probability(AttackSlotData * const me);
const char* __cdecl AttackSlotData_attack_name(AttackSlotData * const me);

//-----------------------------------------------------------------------------
// [CharacterData]
//-----------------------------------------------------------------------------
uint32_t __cdecl CharacterData_memory_address(CharacterData * const me);
const char* __cdecl CharacterData_model(CharacterData * const me);
int __cdecl CharacterData_skin_id(CharacterData * const me);
const char* __cdecl CharacterData_skin_name(CharacterData * const me);
CharacterRecord* __cdecl CharacterData_record(CharacterData * const me);

//-----------------------------------------------------------------------------
// [CharacterRecord]
//-----------------------------------------------------------------------------
uint32_t __cdecl CharacterRecord_memory_address(CharacterRecord * const me);
const char* __cdecl CharacterRecord_character_name(CharacterRecord * const me);
const char* __cdecl CharacterRecord_fallback_character_name(CharacterRecord * const me);
float __cdecl CharacterRecord_base_hp(CharacterRecord * const me);
float __cdecl CharacterRecord_hp_per_level(CharacterRecord * const me);
float __cdecl CharacterRecord_base_static_hp_regen(CharacterRecord * const me);
float __cdecl CharacterRecord_base_factor_hp_regen(CharacterRecord * const me);
float __cdecl CharacterRecord_health_bar_height(CharacterRecord * const me);
bool __cdecl CharacterRecord_health_bar_full_parallax(CharacterRecord * const me);
const char* __cdecl CharacterRecord_self_champ_specific_health_suffix(CharacterRecord * const me);
const char* __cdecl CharacterRecord_self_cb_champ_specific_health_suffix(CharacterRecord * const me);
const char* __cdecl CharacterRecord_ally_champ_specific_health_suffix(CharacterRecord * const me);
const char* __cdecl CharacterRecord_enemy_champ_specific_health_suffix(CharacterRecord * const me);
bool __cdecl CharacterRecord_highlight_healthbar_icons(CharacterRecord * const me);
float __cdecl CharacterRecord_base_damage(CharacterRecord * const me);
float __cdecl CharacterRecord_damage_per_level(CharacterRecord * const me);
float __cdecl CharacterRecord_base_armor(CharacterRecord * const me);
float __cdecl CharacterRecord_armor_per_level(CharacterRecord * const me);
float __cdecl CharacterRecord_base_spell_block(CharacterRecord * const me);
float __cdecl CharacterRecord_base_dodge(CharacterRecord * const me);
float __cdecl CharacterRecord_dodge_per_level(CharacterRecord * const me);
float __cdecl CharacterRecord_base_miss_chance(CharacterRecord * const me);
float __cdecl CharacterRecord_base_crit_chance(CharacterRecord * const me);
float __cdecl CharacterRecord_crit_damage_multiplier(CharacterRecord * const me);
float __cdecl CharacterRecord_crit_per_level(CharacterRecord * const me);
float __cdecl CharacterRecord_base_move_speed(CharacterRecord * const me);
float __cdecl CharacterRecord_attack_range(CharacterRecord * const me);
float __cdecl CharacterRecord_attack_speed(CharacterRecord * const me);
float __cdecl CharacterRecord_attack_speed_ratio(CharacterRecord * const me);
float __cdecl CharacterRecord_attack_speed_per_level(CharacterRecord * const me);
float __cdecl CharacterRecord_ability_power_inc_per_level(CharacterRecord * const me);
float __cdecl CharacterRecord_adaptive_force_to_ability_power_weight(CharacterRecord * const me);
AttackSlotData* __cdecl CharacterRecord_basic_attack(CharacterRecord * const me);
vec_attack_slot_data_t __cdecl CharacterRecord_extra_attacks(CharacterRecord * const me);
void __cdecl CharacterRecord_extra_attacks_Ptr(CharacterRecord * const me, vec_attack_slot_data_t *out);
vec_attack_slot_data_t __cdecl CharacterRecord_crit_attacks(CharacterRecord * const me);
void __cdecl CharacterRecord_crit_attacks_Ptr(CharacterRecord * const me, vec_attack_slot_data_t *out);
float __cdecl CharacterRecord_attack_auto_interrupt_percent(CharacterRecord * const me);
float __cdecl CharacterRecord_acquisition_range(CharacterRecord * const me);
float __cdecl CharacterRecord_wake_up_range(CharacterRecord * const me);
float __cdecl CharacterRecord_first_acquisition_range(CharacterRecord * const me);
float __cdecl CharacterRecord_tower_targeting_priority_boost(CharacterRecord * const me);
float __cdecl CharacterRecord_exp_given_on_death(CharacterRecord * const me);
float __cdecl CharacterRecord_gold_given_on_death(CharacterRecord * const me);
float __cdecl CharacterRecord_gold_radius(CharacterRecord * const me);
float __cdecl CharacterRecord_experience_radius(CharacterRecord * const me);
float __cdecl CharacterRecord_death_event_listening_radius(CharacterRecord * const me);
float __cdecl CharacterRecord_local_gold_given_on_death(CharacterRecord * const me);
float __cdecl CharacterRecord_local_exp_given_on_death(CharacterRecord * const me);
bool __cdecl CharacterRecord_local_gold_split_with_last_hitter(CharacterRecord * const me);
float __cdecl CharacterRecord_global_gold_given_on_death(CharacterRecord * const me);
float __cdecl CharacterRecord_global_exp_given_on_death(CharacterRecord * const me);
float __cdecl CharacterRecord_perception_bubble_radius(CharacterRecord * const me);
float3 __cdecl CharacterRecord_perception_bounding_box_size(CharacterRecord * const me);
void __cdecl CharacterRecord_perception_bounding_box_size_Ptr(CharacterRecord * const me, float3 *out);
float __cdecl CharacterRecord_significance(CharacterRecord * const me);
float __cdecl CharacterRecord_untargetable_spawn_time(CharacterRecord * const me);
float __cdecl CharacterRecord_ability_power(CharacterRecord * const me);
uint32_t __cdecl CharacterRecord_on_kill_event(CharacterRecord * const me);
uint32_t __cdecl CharacterRecord_on_kill_event_steal(CharacterRecord * const me);
uint32_t __cdecl CharacterRecord_on_kill_event_for_spectator(CharacterRecord * const me);
const char* __cdecl CharacterRecord_critical_attack(CharacterRecord * const me);
const char* __cdecl CharacterRecord_passive_name(CharacterRecord * const me);
const char* __cdecl CharacterRecord_passive_lua_name(CharacterRecord * const me);
const char* __cdecl CharacterRecord_passive_tool_tip(CharacterRecord * const me);
const char* __cdecl CharacterRecord_passive_spell(CharacterRecord * const me);
float __cdecl CharacterRecord_passive_range(CharacterRecord * const me);
const char* __cdecl CharacterRecord_icon_name(CharacterRecord * const me);
const char* __cdecl CharacterRecord_friendly_tooltip(CharacterRecord * const me);
const char* __cdecl CharacterRecord_name(CharacterRecord * const me);
const char* __cdecl CharacterRecord_par_name(CharacterRecord * const me);
const char* __cdecl CharacterRecord_hover_indicator_texture_name(CharacterRecord * const me);
float __cdecl CharacterRecord_hover_indicator_radius(CharacterRecord * const me);
const char* __cdecl CharacterRecord_hover_line_indicator_base_texture_name(CharacterRecord * const me);
const char* __cdecl CharacterRecord_hover_line_indicator_target_texture_name(CharacterRecord * const me);
float __cdecl CharacterRecord_hover_indicator_width(CharacterRecord * const me);
bool __cdecl CharacterRecord_hover_indicator_rotate_to_player(CharacterRecord * const me);
const char* __cdecl CharacterRecord_hover_indicator_minimap_override(CharacterRecord * const me);
const char* __cdecl CharacterRecord_minimap_icon_override(CharacterRecord * const me);
float __cdecl CharacterRecord_hover_indicator_radius_minimap(CharacterRecord * const me);
float __cdecl CharacterRecord_hover_line_indicator_width_minimap(CharacterRecord * const me);
float __cdecl CharacterRecord_area_indicator_radius(CharacterRecord * const me);
float __cdecl CharacterRecord_area_indicator_min_radius(CharacterRecord * const me);
float __cdecl CharacterRecord_area_indicator_max_distsance(CharacterRecord * const me);
float __cdecl CharacterRecord_area_indicator_target_distsance(CharacterRecord * const me);
float __cdecl CharacterRecord_area_indicator_min_distsance(CharacterRecord * const me);
const char* __cdecl CharacterRecord_area_indicator_texture_name(CharacterRecord * const me);
float __cdecl CharacterRecord_area_indicator_texture_size(CharacterRecord * const me);
const char* __cdecl CharacterRecord_char_audio_name_override(CharacterRecord * const me);
bool __cdecl CharacterRecord_use_cc_animations(CharacterRecord * const me);
const char* __cdecl CharacterRecord_joint_for_anim_adjusted_selection(CharacterRecord * const me);
float __cdecl CharacterRecord_outline_bbox_expansion(CharacterRecord * const me);
const char* __cdecl CharacterRecord_silhouette_attachment_anim(CharacterRecord * const me);
float __cdecl CharacterRecord_hit_fx_scale(CharacterRecord * const me);
float __cdecl CharacterRecord_selection_radius(CharacterRecord * const me);
float __cdecl CharacterRecord_selection_height(CharacterRecord * const me);
float __cdecl CharacterRecord_pathfinding_collision_radius(CharacterRecord * const me);
float __cdecl CharacterRecord_override_gameplay_collision_radius(CharacterRecord * const me);
const char* __cdecl CharacterRecord_unit_tags_string(CharacterRecord * const me);
uint32_t __cdecl CharacterRecord_friendly_ux_override_team(CharacterRecord * const me);
const char* __cdecl CharacterRecord_friendly_ux_override_include_tags_string(CharacterRecord * const me);
const char* __cdecl CharacterRecord_friendly_ux_override_exclude_tags_string(CharacterRecord * const me);
bool __cdecl CharacterRecord_platform_enabled(CharacterRecord * const me);
bool __cdecl CharacterRecord_record_as_ward(CharacterRecord * const me);
float __cdecl CharacterRecord_minion_score_value(CharacterRecord * const me);
bool __cdecl CharacterRecord_use_riot_relationships(CharacterRecord * const me);
uint32_t __cdecl CharacterRecord_flags(CharacterRecord * const me);
uint32_t __cdecl CharacterRecord_minion_flags(CharacterRecord * const me);
float __cdecl CharacterRecord_death_time(CharacterRecord * const me);
float __cdecl CharacterRecord_occluded_unit_selectable_distance(CharacterRecord * const me);
float __cdecl CharacterRecord_moving_toward_enemy_activation_angle(CharacterRecord * const me);
vec_string_t __cdecl CharacterRecord_spell_names(CharacterRecord * const me);
void __cdecl CharacterRecord_spell_names_Ptr(CharacterRecord * const me, vec_string_t *out);
vec_string_t __cdecl CharacterRecord_extra_spells(CharacterRecord * const me);
void __cdecl CharacterRecord_extra_spells_Ptr(CharacterRecord * const me, vec_string_t *out);

//-----------------------------------------------------------------------------
// [Path]
//-----------------------------------------------------------------------------
uint32_t __cdecl Path_memory_address(Path * const me);
float3 __cdecl Path_end_pos(Path * const me);
void __cdecl Path_end_pos_Ptr(Path * const me, float3 *out);
float3 __cdecl Path_pos(Path * const me);
void __cdecl Path_pos_Ptr(Path * const me, float3 *out);
float3 __cdecl Path_velocity(Path * const me);
void __cdecl Path_velocity_Ptr(Path * const me, float3 *out);
bool __cdecl Path_is_active(Path * const me);
bool __cdecl Path_is_dashing(Path * const me);
float __cdecl Path_dash_speed(Path * const me);
float __cdecl Path_move_speed(Path * const me);
float __cdecl Path_speed(Path * const me);
size_t __cdecl Path_index(Path * const me);
vec_float3_t __cdecl Path_waypoints(Path * const me);
void __cdecl Path_waypoints_Ptr(Path * const me, vec_float3_t *out);
GameObject* __cdecl Path_source(Path * const me);

//-----------------------------------------------------------------------------
// [Rune]
//-----------------------------------------------------------------------------
uint32_t __cdecl Rune_memory_address(Rune * const me);
int __cdecl Rune_id(Rune * const me);
const char* __cdecl Rune_name(Rune * const me);
uint32_t __cdecl Rune_fnv_hash(Rune * const me);
Texture* __cdecl Rune_icon(Rune * const me);

//-----------------------------------------------------------------------------
// [ItemSlot]
//-----------------------------------------------------------------------------
uint32_t __cdecl ItemSlot_memory_address(ItemSlot * const me);
uint8_t __cdecl ItemSlot_stacks(ItemSlot * const me);
uint8_t __cdecl ItemSlot_max_stacks(ItemSlot * const me);
uint8_t __cdecl ItemSlot_spell_stacks(ItemSlot * const me);
float __cdecl ItemSlot_purchase_time(ItemSlot * const me);
int __cdecl ItemSlot_id(ItemSlot * const me);
int __cdecl ItemSlot_cost(ItemSlot * const me);
const char* __cdecl ItemSlot_name(ItemSlot * const me);
Texture* __cdecl ItemSlot_icon(ItemSlot * const me);

//-----------------------------------------------------------------------------
// [GameObject]
//-----------------------------------------------------------------------------
uint32_t __cdecl GameObject_memory_address(GameObject * const me);
uint32_t __cdecl GameObject_id(GameObject * const me);
uint32_t __cdecl GameObject_index(GameObject * const me);
GameObjectType __cdecl GameObject_type(GameObject * const me);
GameObjectTeam __cdecl GameObject_team(GameObject * const me);
const char* __cdecl GameObject_name(GameObject * const me);
bool __cdecl GameObject_is_on_screen(GameObject * const me);
uint32_t __cdecl GameObject_network_id(GameObject * const me);
float3 __cdecl GameObject_pos(GameObject * const me);
void __cdecl GameObject_pos_Ptr(GameObject * const me, float3 *out);
bool __cdecl GameObject_is_zombie(GameObject * const me);
bool __cdecl GameObject_is_ally(GameObject * const me);
bool __cdecl GameObject_is_enemy(GameObject * const me);
bool __cdecl GameObject_is_neutral(GameObject * const me);
bool __cdecl GameObject_is_player(GameObject * const me);
bool __cdecl GameObject_is_hero(GameObject * const me);
bool __cdecl GameObject_is_minion(GameObject * const me);
bool __cdecl GameObject_is_turret(GameObject * const me);
bool __cdecl GameObject_is_inhib(GameObject * const me);
bool __cdecl GameObject_is_nexus(GameObject * const me);
bool __cdecl GameObject_is_missile(GameObject * const me);
bool __cdecl GameObject_is_particle(GameObject * const me);
bool __cdecl GameObject_is_neutral_camp(GameObject * const me);
bool __cdecl GameObject_is_attackable_unit(GameObject * const me);
bool __cdecl GameObject_is_ai_client(GameObject * const me);

//-----------------------------------------------------------------------------
// [AttackableUnit]
//-----------------------------------------------------------------------------
float __cdecl AttackableUnit_base_collision_radius(AttackableUnit * const me);
bool __cdecl AttackableUnit_is_visible(AttackableUnit * const me);
float __cdecl AttackableUnit_death_time(AttackableUnit * const me);
bool __cdecl AttackableUnit_is_dead(AttackableUnit * const me);
float __cdecl AttackableUnit_health(AttackableUnit * const me);
float __cdecl AttackableUnit_max_health(AttackableUnit * const me);
float __cdecl AttackableUnit_health_max_penalty(AttackableUnit * const me);
float __cdecl AttackableUnit_all_shield(AttackableUnit * const me);
float __cdecl AttackableUnit_physical_shield(AttackableUnit * const me);
float __cdecl AttackableUnit_magical_shield(AttackableUnit * const me);
float __cdecl AttackableUnit_champ_specific_health(AttackableUnit * const me);
float __cdecl AttackableUnit_incoming_healing_enemy(AttackableUnit * const me);
float __cdecl AttackableUnit_incoming_healing_allied(AttackableUnit * const me);
float __cdecl AttackableUnit_stop_shield_fade(AttackableUnit * const me);
bool __cdecl AttackableUnit_is_targetable(AttackableUnit * const me);
float __cdecl AttackableUnit_mana(AttackableUnit * const me);
float __cdecl AttackableUnit_max_mana(AttackableUnit * const me);
float __cdecl AttackableUnit_par(AttackableUnit * const me);
float __cdecl AttackableUnit_max_par(AttackableUnit * const me);
uint32_t __cdecl AttackableUnit_par_state(AttackableUnit * const me);
float __cdecl AttackableUnit_sar(AttackableUnit * const me);
float __cdecl AttackableUnit_max_sar(AttackableUnit * const me);
bool __cdecl AttackableUnit_sar_enabled(AttackableUnit * const me);
uint32_t __cdecl AttackableUnit_sar_state(AttackableUnit * const me);
// [AttackableUnit] [GameObject] -------------------------------------------------------
uint32_t __cdecl AttackableUnit_memory_address(AttackableUnit * const me);
uint32_t __cdecl AttackableUnit_id(AttackableUnit * const me);
uint32_t __cdecl AttackableUnit_index(AttackableUnit * const me);
GameObjectType __cdecl AttackableUnit_type(AttackableUnit * const me);
GameObjectTeam __cdecl AttackableUnit_team(AttackableUnit * const me);
const char* __cdecl AttackableUnit_name(AttackableUnit * const me);
bool __cdecl AttackableUnit_is_on_screen(AttackableUnit * const me);
uint32_t __cdecl AttackableUnit_network_id(AttackableUnit * const me);
float3 __cdecl AttackableUnit_pos(AttackableUnit * const me);
void __cdecl AttackableUnit_pos_Ptr(AttackableUnit * const me, float3 *out);
bool __cdecl AttackableUnit_is_zombie(AttackableUnit * const me);
bool __cdecl AttackableUnit_is_ally(AttackableUnit * const me);
bool __cdecl AttackableUnit_is_enemy(AttackableUnit * const me);
bool __cdecl AttackableUnit_is_neutral(AttackableUnit * const me);
bool __cdecl AttackableUnit_is_player(AttackableUnit * const me);
bool __cdecl AttackableUnit_is_hero(AttackableUnit * const me);
bool __cdecl AttackableUnit_is_minion(AttackableUnit * const me);
bool __cdecl AttackableUnit_is_turret(AttackableUnit * const me);
bool __cdecl AttackableUnit_is_inhib(AttackableUnit * const me);
bool __cdecl AttackableUnit_is_nexus(AttackableUnit * const me);
bool __cdecl AttackableUnit_is_missile(AttackableUnit * const me);
bool __cdecl AttackableUnit_is_particle(AttackableUnit * const me);
bool __cdecl AttackableUnit_is_neutral_camp(AttackableUnit * const me);
bool __cdecl AttackableUnit_is_attackable_unit(AttackableUnit * const me);
bool __cdecl AttackableUnit_is_ai_client(AttackableUnit * const me);

//-----------------------------------------------------------------------------
// [AIClient]
//-----------------------------------------------------------------------------
CharacterData* __cdecl AIClient_base_character_data(AIClient * const me);
CharacterData* __cdecl AIClient_character_data(AIClient * const me);
CharacterRecord* __cdecl AIClient_character_record(AIClient * const me);
void __cdecl AIClient_set_character_model(AIClient * const me, const char *model, int skin_id);
vec_spell_calculation_t __cdecl AIClient_spell_calculations(AIClient * const me, SpellSlotEnum slot);
void __cdecl AIClient_spell_calculations_Ptr(AIClient * const me, SpellSlotEnum slot, vec_spell_calculation_t *out);
SpellCalculation* __cdecl AIClient_find_spell_calculation_by_hash(AIClient * const me, SpellSlotEnum slot, uint32_t hash);
float __cdecl AIClient_calc_attack_cast_delay(AIClient * const me);
float __cdecl AIClient_calc_attack_delay(AIClient * const me);
Texture* __cdecl AIClient_icon_square(AIClient * const me);
Texture* __cdecl AIClient_icon_circle(AIClient * const me);
bool __cdecl AIClient_has_bar_pos(AIClient * const me);
float2 __cdecl AIClient_bar_pos(AIClient * const me);
void __cdecl AIClient_bar_pos_Ptr(AIClient * const me, float2 *out);
vec_floating_info_bar_t __cdecl AIClient_floating_info_bars(AIClient * const me);
void __cdecl AIClient_floating_info_bars_Ptr(AIClient * const me, vec_floating_info_bar_t *out);
float __cdecl AIClient_collision_radius(AIClient * const me);
vec_buff_t __cdecl AIClient_buffs(AIClient * const me);
void __cdecl AIClient_buffs_Ptr(AIClient * const me, vec_buff_t *out);
Buff* __cdecl AIClient_find_buff(AIClient * const me, BuffType type);
Buff* __cdecl AIClient_find_buff_by_name(AIClient * const me, const char *name);
Buff* __cdecl AIClient_find_buff_by_hash(AIClient * const me, uint32_t fnv_hash);
Spell* __cdecl AIClient_active_spell(AIClient * const me);
SpellSlot* __cdecl AIClient_spell_slot(AIClient * const me, SpellSlotEnum slot);
vec_spell_t __cdecl AIClient_basic_attacks(AIClient * const me);
void __cdecl AIClient_basic_attacks_Ptr(AIClient * const me, vec_spell_t *out);
Path* __cdecl AIClient_path(AIClient * const me);
const char* __cdecl AIClient_char_name(AIClient * const me);
uint32_t __cdecl AIClient_char_name_fnv_hash(AIClient * const me);
float3 __cdecl AIClient_direction(AIClient * const me);
void __cdecl AIClient_direction_Ptr(AIClient * const me, float3 *out);
uint32_t __cdecl AIClient_action_state(AIClient * const me);
uint32_t __cdecl AIClient_action_state2(AIClient * const me);
CombatType __cdecl AIClient_combat_type(AIClient * const me);
bool __cdecl AIClient_is_melee(AIClient * const me);
bool __cdecl AIClient_is_ranged(AIClient * const me);
float __cdecl AIClient_base_attack_damage(AIClient * const me);
float __cdecl AIClient_armor(AIClient * const me);
float __cdecl AIClient_spell_block(AIClient * const me);
float __cdecl AIClient_attack_speed_mod(AIClient * const me);
float __cdecl AIClient_flat_physical_damage_mod(AIClient * const me);
float __cdecl AIClient_percent_physical_damage_mod(AIClient * const me);
float __cdecl AIClient_flat_magic_damage_mod(AIClient * const me);
float __cdecl AIClient_percent_magic_damage_mod(AIClient * const me);
float __cdecl AIClient_health_regen_rate(AIClient * const me);
float __cdecl AIClient_primary_ar_regen_rate_rep(AIClient * const me);
float __cdecl AIClient_flat_magic_reduction(AIClient * const me);
float __cdecl AIClient_percent_magic_reduction(AIClient * const me);
float __cdecl AIClient_percent_bonus_armor_penetration(AIClient * const me);
float __cdecl AIClient_percent_crit_bonus_armor_penetration(AIClient * const me);
float __cdecl AIClient_percent_crit_total_armor_penetration(AIClient * const me);
float __cdecl AIClient_percent_bonus_magic_penetration(AIClient * const me);
float __cdecl AIClient_physical_lethality(AIClient * const me);
float __cdecl AIClient_magic_lethality(AIClient * const me);
float __cdecl AIClient_base_health_regen_rate(AIClient * const me);
float __cdecl AIClient_primary_ar_base_regen_rate_rep(AIClient * const me);
float __cdecl AIClient_secondary_ar_regen_rate_rep(AIClient * const me);
float __cdecl AIClient_secondary_ar_base_regen_rate_rep(AIClient * const me);
float __cdecl AIClient_percent_cooldown_cap_mod(AIClient * const me);
float __cdecl AIClient_percent_cc_reduction(AIClient * const me);
float __cdecl AIClient_percent_exp_bonus(AIClient * const me);
float __cdecl AIClient_flat_base_attack_damage_mod(AIClient * const me);
float __cdecl AIClient_percent_base_attack_damage_mod(AIClient * const me);
float __cdecl AIClient_base_attack_damage_sans_percent_scale(AIClient * const me);
float __cdecl AIClient_bonus_armor(AIClient * const me);
float __cdecl AIClient_bonus_spell_block(AIClient * const me);
float __cdecl AIClient_percent_bonus_physical_damage_mod(AIClient * const me);
float __cdecl AIClient_percent_base_physical_damage_as_flat_bonus(AIClient * const me);
float __cdecl AIClient_percent_attack_speed_mod(AIClient * const me);
float __cdecl AIClient_percent_multiplicative_attack_speed_mod(AIClient * const me);
float __cdecl AIClient_crit_damage_multiplier(AIClient * const me);
float __cdecl AIClient_ability_haste_mod(AIClient * const me);
float __cdecl AIClient_flat_bubble_radius_mod(AIClient * const me);
float __cdecl AIClient_percent_bubble_radius_mod(AIClient * const me);
float __cdecl AIClient_move_speed(AIClient * const me);
float __cdecl AIClient_move_speed_base_increase(AIClient * const me);
float __cdecl AIClient_scale_skin_coef(AIClient * const me);
float __cdecl AIClient_pathfinding_radius_mod(AIClient * const me);
float __cdecl AIClient_base_ability_damage(AIClient * const me);
float __cdecl AIClient_crit(AIClient * const me);
float __cdecl AIClient_par_regen_rate(AIClient * const me);
float __cdecl AIClient_attack_range(AIClient * const me);
float __cdecl AIClient_flat_cast_range_mod(AIClient * const me);
float __cdecl AIClient_percent_cooldown_mod(AIClient * const me);
float __cdecl AIClient_passive_cooldown_end_time(AIClient * const me);
float __cdecl AIClient_passive_cooldown_total_time(AIClient * const me);
float __cdecl AIClient_flat_armor_penetration(AIClient * const me);
float __cdecl AIClient_percent_armor_penetration(AIClient * const me);
float __cdecl AIClient_flat_magic_penetration(AIClient * const me);
float __cdecl AIClient_percent_magic_penetration(AIClient * const me);
float __cdecl AIClient_percent_life_steal_mod(AIClient * const me);
float __cdecl AIClient_percent_spell_vamp_mod(AIClient * const me);
float __cdecl AIClient_physical_damage_percent_modifier(AIClient * const me);
float __cdecl AIClient_magical_damage_percent_modifier(AIClient * const me);
float __cdecl AIClient_percent_damage_to_barracks_minion_mod(AIClient * const me);
float __cdecl AIClient_flat_damage_reduction_from_barracks_minion_mod(AIClient * const me);
float __cdecl AIClient_base_health(AIClient * const me);
float __cdecl AIClient_base_health_per_level(AIClient * const me);
float __cdecl AIClient_base_mana(AIClient * const me);
float __cdecl AIClient_base_mana_per_level(AIClient * const me);
float __cdecl AIClient_base_move_speed(AIClient * const me);
// [AIClient] [AttackableUnit] --------------------------------------------------
float __cdecl AIClient_base_collision_radius(AIClient * const me);
bool __cdecl AIClient_is_visible(AIClient * const me);
float __cdecl AIClient_death_time(AIClient * const me);
bool __cdecl AIClient_is_dead(AIClient * const me);
float __cdecl AIClient_health(AIClient * const me);
float __cdecl AIClient_max_health(AIClient * const me);
float __cdecl AIClient_health_max_penalty(AIClient * const me);
float __cdecl AIClient_all_shield(AIClient * const me);
float __cdecl AIClient_physical_shield(AIClient * const me);
float __cdecl AIClient_magical_shield(AIClient * const me);
float __cdecl AIClient_champ_specific_health(AIClient * const me);
float __cdecl AIClient_incoming_healing_enemy(AIClient * const me);
float __cdecl AIClient_incoming_healing_allied(AIClient * const me);
float __cdecl AIClient_stop_shield_fade(AIClient * const me);
bool __cdecl AIClient_is_targetable(AIClient * const me);
float __cdecl AIClient_mana(AIClient * const me);
float __cdecl AIClient_max_mana(AIClient * const me);
float __cdecl AIClient_par(AIClient * const me);
float __cdecl AIClient_max_par(AIClient * const me);
uint32_t __cdecl AIClient_par_state(AIClient * const me);
float __cdecl AIClient_sar(AIClient * const me);
float __cdecl AIClient_max_sar(AIClient * const me);
bool __cdecl AIClient_sar_enabled(AIClient * const me);
uint32_t __cdecl AIClient_sar_state(AIClient * const me);
// [AIClient] [GameObject] ------------------------------------------------------
uint32_t __cdecl AIClient_memory_address(AIClient * const me);
uint32_t __cdecl AIClient_id(AIClient * const me);
uint32_t __cdecl AIClient_index(AIClient * const me);
GameObjectType __cdecl AIClient_type(AIClient * const me);
GameObjectTeam __cdecl AIClient_team(AIClient * const me);
const char* __cdecl AIClient_name(AIClient * const me);
bool __cdecl AIClient_is_on_screen(AIClient * const me);
uint32_t __cdecl AIClient_network_id(AIClient * const me);
float3 __cdecl AIClient_pos(AIClient * const me);
void __cdecl AIClient_pos_Ptr(AIClient * const me, float3 *out);
bool __cdecl AIClient_is_zombie(AIClient * const me);
bool __cdecl AIClient_is_ally(AIClient * const me);
bool __cdecl AIClient_is_enemy(AIClient * const me);
bool __cdecl AIClient_is_neutral(AIClient * const me);
bool __cdecl AIClient_is_player(AIClient * const me);
bool __cdecl AIClient_is_hero(AIClient * const me);
bool __cdecl AIClient_is_minion(AIClient * const me);
bool __cdecl AIClient_is_turret(AIClient * const me);
bool __cdecl AIClient_is_inhib(AIClient * const me);
bool __cdecl AIClient_is_nexus(AIClient * const me);
bool __cdecl AIClient_is_missile(AIClient * const me);
bool __cdecl AIClient_is_particle(AIClient * const me);
bool __cdecl AIClient_is_neutral_camp(AIClient * const me);
bool __cdecl AIClient_is_attackable_unit(AIClient * const me);
bool __cdecl AIClient_is_ai_client(AIClient * const me);

//-----------------------------------------------------------------------------
// [Particle]
//-----------------------------------------------------------------------------
float __cdecl Particle_visibility_radius(Particle * const me);
float3 __cdecl Particle_orientation(Particle * const me);
void __cdecl Particle_orientation_Ptr(Particle * const me, float3 *out);
GameObject* __cdecl Particle_attachment_object(Particle * const me);
GameObject* __cdecl Particle_target_attachment_object(Particle * const me);
// [Particle] [GameObject] --------------------------------------------------------
uint32_t __cdecl Particle_memory_address(Particle * const me);
uint32_t __cdecl Particle_id(Particle * const me);
uint32_t __cdecl Particle_index(Particle * const me);
GameObjectType __cdecl Particle_type(Particle * const me);
GameObjectTeam __cdecl Particle_team(Particle * const me);
const char* __cdecl Particle_name(Particle * const me);
bool __cdecl Particle_is_on_screen(Particle * const me);
uint32_t __cdecl Particle_network_id(Particle * const me);
float3 __cdecl Particle_pos(Particle * const me);
void __cdecl Particle_pos_Ptr(Particle * const me, float3 *out);
bool __cdecl Particle_is_zombie(Particle * const me);
bool __cdecl Particle_is_ally(Particle * const me);
bool __cdecl Particle_is_enemy(Particle * const me);
bool __cdecl Particle_is_neutral(Particle * const me);
bool __cdecl Particle_is_player(Particle * const me);
bool __cdecl Particle_is_hero(Particle * const me);
bool __cdecl Particle_is_minion(Particle * const me);
bool __cdecl Particle_is_turret(Particle * const me);
bool __cdecl Particle_is_inhib(Particle * const me);
bool __cdecl Particle_is_nexus(Particle * const me);
bool __cdecl Particle_is_missile(Particle * const me);
bool __cdecl Particle_is_particle(Particle * const me);
bool __cdecl Particle_is_neutral_camp(Particle * const me);
bool __cdecl Particle_is_attackable_unit(Particle * const me);
bool __cdecl Particle_is_ai_client(Particle * const me);

//-----------------------------------------------------------------------------
// [NeutralCamp]
//-----------------------------------------------------------------------------
uint32_t __cdecl NeutralCamp_camp_id(NeutralCamp * const me);
const char* __cdecl NeutralCamp_camp_type(NeutralCamp * const me);
uint32_t __cdecl NeutralCamp_camp_team(NeutralCamp * const me);
vec_game_object_t __cdecl NeutralCamp_objects(NeutralCamp * const me);
void __cdecl NeutralCamp_objects_Ptr(NeutralCamp * const me, vec_game_object_t *out);
uint32_t __cdecl NeutralCamp_fnv_hash(NeutralCamp * const me);
bool __cdecl NeutralCamp_is_alive(NeutralCamp * const me);
float __cdecl NeutralCamp_spawn_time(NeutralCamp * const me);
// [NeutralCamp] [GameObject] --------------------------------------------------------
uint32_t __cdecl NeutralCamp_memory_address(NeutralCamp * const me);
uint32_t __cdecl NeutralCamp_id(NeutralCamp * const me);
uint32_t __cdecl NeutralCamp_index(NeutralCamp * const me);
GameObjectType __cdecl NeutralCamp_type(NeutralCamp * const me);
GameObjectTeam __cdecl NeutralCamp_team(NeutralCamp * const me);
const char* __cdecl NeutralCamp_name(NeutralCamp * const me);
bool __cdecl NeutralCamp_is_on_screen(NeutralCamp * const me);
uint32_t __cdecl NeutralCamp_network_id(NeutralCamp * const me);
float3 __cdecl NeutralCamp_pos(NeutralCamp * const me);
void __cdecl NeutralCamp_pos_Ptr(NeutralCamp * const me, float3 *out);
bool __cdecl NeutralCamp_is_zombie(NeutralCamp * const me);
bool __cdecl NeutralCamp_is_ally(NeutralCamp * const me);
bool __cdecl NeutralCamp_is_enemy(NeutralCamp * const me);
bool __cdecl NeutralCamp_is_neutral(NeutralCamp * const me);
bool __cdecl NeutralCamp_is_player(NeutralCamp * const me);
bool __cdecl NeutralCamp_is_hero(NeutralCamp * const me);
bool __cdecl NeutralCamp_is_minion(NeutralCamp * const me);
bool __cdecl NeutralCamp_is_turret(NeutralCamp * const me);
bool __cdecl NeutralCamp_is_inhib(NeutralCamp * const me);
bool __cdecl NeutralCamp_is_nexus(NeutralCamp * const me);
bool __cdecl NeutralCamp_is_missile(NeutralCamp * const me);
bool __cdecl NeutralCamp_is_particle(NeutralCamp * const me);
bool __cdecl NeutralCamp_is_neutral_camp(NeutralCamp * const me);
bool __cdecl NeutralCamp_is_attackable_unit(NeutralCamp * const me);
bool __cdecl NeutralCamp_is_ai_client(NeutralCamp * const me);

//-----------------------------------------------------------------------------
// [Inhib]
//-----------------------------------------------------------------------------
float __cdecl Inhib_respawn_timer(Inhib * const me);
// [Inhib] [AttackableUnit]
float __cdecl Inhib_base_collision_radius(Inhib * const me);
bool __cdecl Inhib_is_visible(Inhib * const me);
float __cdecl Inhib_death_time(Inhib * const me);
bool __cdecl Inhib_is_dead(Inhib * const me);
float __cdecl Inhib_health(Inhib * const me);
float __cdecl Inhib_max_health(Inhib * const me);
float __cdecl Inhib_health_max_penalty(Inhib * const me);
float __cdecl Inhib_all_shield(Inhib * const me);
float __cdecl Inhib_physical_shield(Inhib * const me);
float __cdecl Inhib_magical_shield(Inhib * const me);
float __cdecl Inhib_champ_specific_health(Inhib * const me);
float __cdecl Inhib_incoming_healing_enemy(Inhib * const me);
float __cdecl Inhib_incoming_healing_allied(Inhib * const me);
float __cdecl Inhib_stop_shield_fade(Inhib * const me);
bool __cdecl Inhib_is_targetable(Inhib * const me);
float __cdecl Inhib_mana(Inhib * const me);
float __cdecl Inhib_max_mana(Inhib * const me);
float __cdecl Inhib_par(Inhib * const me);
float __cdecl Inhib_max_par(Inhib * const me);
uint32_t __cdecl Inhib_par_state(Inhib * const me);
float __cdecl Inhib_sar(Inhib * const me);
float __cdecl Inhib_max_sar(Inhib * const me);
bool __cdecl Inhib_sar_enabled(Inhib * const me);
uint32_t __cdecl Inhib_sar_state(Inhib * const me);
// [Inhib] [GameObject] -------------------------------------------------------
uint32_t __cdecl Inhib_memory_address(Inhib * const me);
uint32_t __cdecl Inhib_id(Inhib * const me);
uint32_t __cdecl Inhib_index(Inhib * const me);
GameObjectType __cdecl Inhib_type(Inhib * const me);
GameObjectTeam __cdecl Inhib_team(Inhib * const me);
const char* __cdecl Inhib_name(Inhib * const me);
bool __cdecl Inhib_is_on_screen(Inhib * const me);
uint32_t __cdecl Inhib_network_id(Inhib * const me);
float3 __cdecl Inhib_pos(Inhib * const me);
void __cdecl Inhib_pos_Ptr(Inhib * const me, float3 *out);
bool __cdecl Inhib_is_zombie(Inhib * const me);
bool __cdecl Inhib_is_ally(Inhib * const me);
bool __cdecl Inhib_is_enemy(Inhib * const me);
bool __cdecl Inhib_is_neutral(Inhib * const me);
bool __cdecl Inhib_is_player(Inhib * const me);
bool __cdecl Inhib_is_hero(Inhib * const me);
bool __cdecl Inhib_is_minion(Inhib * const me);
bool __cdecl Inhib_is_turret(Inhib * const me);
bool __cdecl Inhib_is_inhib(Inhib * const me);
bool __cdecl Inhib_is_nexus(Inhib * const me);
bool __cdecl Inhib_is_missile(Inhib * const me);
bool __cdecl Inhib_is_particle(Inhib * const me);
bool __cdecl Inhib_is_neutral_camp(Inhib * const me);
bool __cdecl Inhib_is_attackable_unit(Inhib * const me);
bool __cdecl Inhib_is_ai_client(Inhib * const me);

//-----------------------------------------------------------------------------
// [Nexus]
// [Nexus] [AttackableUnit]
//-----------------------------------------------------------------------------
float __cdecl Nexus_base_collision_radius(Nexus * const me);
bool __cdecl Nexus_is_visible(Nexus * const me);
float __cdecl Nexus_death_time(Nexus * const me);
bool __cdecl Nexus_is_dead(Nexus * const me);
float __cdecl Nexus_health(Nexus * const me);
float __cdecl Nexus_max_health(Nexus * const me);
float __cdecl Nexus_health_max_penalty(Nexus * const me);
float __cdecl Nexus_all_shield(Nexus * const me);
float __cdecl Nexus_physical_shield(Nexus * const me);
float __cdecl Nexus_magical_shield(Nexus * const me);
float __cdecl Nexus_champ_specific_health(Nexus * const me);
float __cdecl Nexus_incoming_healing_enemy(Nexus * const me);
float __cdecl Nexus_incoming_healing_allied(Nexus * const me);
float __cdecl Nexus_stop_shield_fade(Nexus * const me);
bool __cdecl Nexus_is_targetable(Nexus * const me);
float __cdecl Nexus_mana(Nexus * const me);
float __cdecl Nexus_max_mana(Nexus * const me);
float __cdecl Nexus_par(Nexus * const me);
float __cdecl Nexus_max_par(Nexus * const me);
uint32_t __cdecl Nexus_par_state(Nexus * const me);
float __cdecl Nexus_sar(Nexus * const me);
float __cdecl Nexus_max_sar(Nexus * const me);
bool __cdecl Nexus_sar_enabled(Nexus * const me);
uint32_t __cdecl Nexus_sar_state(Nexus * const me);
// [Nexus] [GameObject] -------------------------------------------------------
uint32_t __cdecl Nexus_memory_address(Nexus * const me);
uint32_t __cdecl Nexus_id(Nexus * const me);
uint32_t __cdecl Nexus_index(Nexus * const me);
GameObjectType __cdecl Nexus_type(Nexus * const me);
GameObjectTeam __cdecl Nexus_team(Nexus * const me);
const char* __cdecl Nexus_name(Nexus * const me);
bool __cdecl Nexus_is_on_screen(Nexus * const me);
uint32_t __cdecl Nexus_network_id(Nexus * const me);
float3 __cdecl Nexus_pos(Nexus * const me);
void __cdecl Nexus_pos_Ptr(Nexus * const me, float3 *out);
bool __cdecl Nexus_is_zombie(Nexus * const me);
bool __cdecl Nexus_is_ally(Nexus * const me);
bool __cdecl Nexus_is_enemy(Nexus * const me);
bool __cdecl Nexus_is_neutral(Nexus * const me);
bool __cdecl Nexus_is_player(Nexus * const me);
bool __cdecl Nexus_is_hero(Nexus * const me);
bool __cdecl Nexus_is_minion(Nexus * const me);
bool __cdecl Nexus_is_turret(Nexus * const me);
bool __cdecl Nexus_is_inhib(Nexus * const me);
bool __cdecl Nexus_is_nexus(Nexus * const me);
bool __cdecl Nexus_is_missile(Nexus * const me);
bool __cdecl Nexus_is_particle(Nexus * const me);
bool __cdecl Nexus_is_neutral_camp(Nexus * const me);
bool __cdecl Nexus_is_attackable_unit(Nexus * const me);
bool __cdecl Nexus_is_ai_client(Nexus * const me);

//-----------------------------------------------------------------------------
// [Missile]
//-----------------------------------------------------------------------------
float3 __cdecl Missile_start_pos(Missile * const me);
void __cdecl Missile_start_pos_Ptr(Missile * const me, float3 *out);
float3 __cdecl Missile_end_pos(Missile * const me);
void __cdecl Missile_end_pos_Ptr(Missile * const me, float3 *out);
float __cdecl Missile_speed(Missile * const me);
float __cdecl Missile_width(Missile * const me);
GameObject* __cdecl Missile_source(Missile * const me);
GameObject* __cdecl Missile_target(Missile * const me);
Spell* __cdecl Missile_spell(Missile * const me);
// [Missile] [GameObject] -----------------------------------------------------
uint32_t __cdecl Missile_memory_address(Missile * const me);
uint32_t __cdecl Missile_id(Missile * const me);
uint32_t __cdecl Missile_index(Missile * const me);
GameObjectType __cdecl Missile_type(Missile * const me);
GameObjectTeam __cdecl Missile_team(Missile * const me);
const char* __cdecl Missile_name(Missile * const me);
bool __cdecl Missile_is_on_screen(Missile * const me);
uint32_t __cdecl Missile_network_id(Missile * const me);
float3 __cdecl Missile_pos(Missile * const me);
void __cdecl Missile_pos_Ptr(Missile * const me, float3 *out);
bool __cdecl Missile_is_zombie(Missile * const me);
bool __cdecl Missile_is_ally(Missile * const me);
bool __cdecl Missile_is_enemy(Missile * const me);
bool __cdecl Missile_is_neutral(Missile * const me);
bool __cdecl Missile_is_player(Missile * const me);
bool __cdecl Missile_is_hero(Missile * const me);
bool __cdecl Missile_is_minion(Missile * const me);
bool __cdecl Missile_is_turret(Missile * const me);
bool __cdecl Missile_is_inhib(Missile * const me);
bool __cdecl Missile_is_nexus(Missile * const me);
bool __cdecl Missile_is_missile(Missile * const me);
bool __cdecl Missile_is_particle(Missile * const me);
bool __cdecl Missile_is_neutral_camp(Missile * const me);
bool __cdecl Missile_is_attackable_unit(Missile * const me);
bool __cdecl Missile_is_ai_client(Missile * const me);

//-----------------------------------------------------------------------------
// [Turret]
//-----------------------------------------------------------------------------
bool __cdecl Turret_is_outer_turret(Turret * const me);
bool __cdecl Turret_is_inner_turret(Turret * const me);
bool __cdecl Turret_is_inhib_turret(Turret * const me);
bool __cdecl Turret_is_nexus_turret(Turret * const me);
bool __cdecl Turret_is_shrine(Turret * const me);
// [Turret] [AIClient] --------------------------------------------------------
CharacterData* __cdecl Turret_base_character_data(Turret * const me);
CharacterData* __cdecl Turret_character_data(Turret * const me);
CharacterRecord* __cdecl Turret_character_record(Turret * const me);
void __cdecl Turret_set_character_model(Turret * const me, const char *model, int skin_id);
vec_spell_calculation_t __cdecl Turret_spell_calculations(Turret * const me, SpellSlotEnum slot);
void __cdecl Turret_spell_calculations_Ptr(Turret * const me, SpellSlotEnum slot, vec_spell_calculation_t *out);
SpellCalculation* __cdecl Turret_find_spell_calculation_by_hash(Turret * const me, SpellSlotEnum slot, uint32_t hash);
float __cdecl Turret_calc_attack_cast_delay(Turret * const me);
float __cdecl Turret_calc_attack_delay(Turret * const me);
Texture* __cdecl Turret_icon_square(Turret * const me);
Texture* __cdecl Turret_icon_circle(Turret * const me);
bool __cdecl Turret_has_bar_pos(Turret * const me);
float2 __cdecl Turret_bar_pos(Turret * const me);
void __cdecl Turret_bar_pos_Ptr(Turret * const me, float2 *out);
vec_floating_info_bar_t __cdecl Turret_floating_info_bars(Turret * const me);
void __cdecl Turret_floating_info_bars_Ptr(Turret * const me, vec_floating_info_bar_t *out);
float __cdecl Turret_collision_radius(Turret * const me);
vec_buff_t __cdecl Turret_buffs(Turret * const me);
void __cdecl Turret_buffs_Ptr(Turret * const me, vec_buff_t *out);
Buff* __cdecl Turret_find_buff(Turret * const me, BuffType type);
Buff* __cdecl Turret_find_buff_by_name(Turret * const me, const char *name);
Buff* __cdecl Turret_find_buff_by_hash(Turret * const me, uint32_t fnv_hash);
Spell* __cdecl Turret_active_spell(Turret * const me);
SpellSlot* __cdecl Turret_spell_slot(Turret * const me, SpellSlotEnum slot);
vec_spell_t __cdecl Turret_basic_attacks(Turret * const me);
void __cdecl Turret_basic_attacks_Ptr(Turret * const me, vec_spell_t *out);
Path* __cdecl Turret_path(Turret * const me);
const char* __cdecl Turret_char_name(Turret * const me);
uint32_t __cdecl Turret_char_name_fnv_hash(Turret * const me);
float3 __cdecl Turret_direction(Turret * const me);
void __cdecl Turret_direction_Ptr(Turret * const me, float3 *out);
uint32_t __cdecl Turret_action_state(Turret * const me);
uint32_t __cdecl Turret_action_state2(Turret * const me);
CombatType __cdecl Turret_combat_type(Turret * const me);
bool __cdecl Turret_is_melee(Turret * const me);
bool __cdecl Turret_is_ranged(Turret * const me);
float __cdecl Turret_base_attack_damage(Turret * const me);
float __cdecl Turret_armor(Turret * const me);
float __cdecl Turret_spell_block(Turret * const me);
float __cdecl Turret_attack_speed_mod(Turret * const me);
float __cdecl Turret_flat_physical_damage_mod(Turret * const me);
float __cdecl Turret_percent_physical_damage_mod(Turret * const me);
float __cdecl Turret_flat_magic_damage_mod(Turret * const me);
float __cdecl Turret_percent_magic_damage_mod(Turret * const me);
float __cdecl Turret_health_regen_rate(Turret * const me);
float __cdecl Turret_primary_ar_regen_rate_rep(Turret * const me);
float __cdecl Turret_flat_magic_reduction(Turret * const me);
float __cdecl Turret_percent_magic_reduction(Turret * const me);
float __cdecl Turret_percent_bonus_armor_penetration(Turret * const me);
float __cdecl Turret_percent_crit_bonus_armor_penetration(Turret * const me);
float __cdecl Turret_percent_crit_total_armor_penetration(Turret * const me);
float __cdecl Turret_percent_bonus_magic_penetration(Turret * const me);
float __cdecl Turret_physical_lethality(Turret * const me);
float __cdecl Turret_magic_lethality(Turret * const me);
float __cdecl Turret_base_health_regen_rate(Turret * const me);
float __cdecl Turret_primary_ar_base_regen_rate_rep(Turret * const me);
float __cdecl Turret_secondary_ar_regen_rate_rep(Turret * const me);
float __cdecl Turret_secondary_ar_base_regen_rate_rep(Turret * const me);
float __cdecl Turret_percent_cooldown_cap_mod(Turret * const me);
float __cdecl Turret_percent_cc_reduction(Turret * const me);
float __cdecl Turret_percent_exp_bonus(Turret * const me);
float __cdecl Turret_flat_base_attack_damage_mod(Turret * const me);
float __cdecl Turret_percent_base_attack_damage_mod(Turret * const me);
float __cdecl Turret_base_attack_damage_sans_percent_scale(Turret * const me);
float __cdecl Turret_bonus_armor(Turret * const me);
float __cdecl Turret_bonus_spell_block(Turret * const me);
float __cdecl Turret_percent_bonus_physical_damage_mod(Turret * const me);
float __cdecl Turret_percent_base_physical_damage_as_flat_bonus(Turret * const me);
float __cdecl Turret_percent_attack_speed_mod(Turret * const me);
float __cdecl Turret_percent_multiplicative_attack_speed_mod(Turret * const me);
float __cdecl Turret_crit_damage_multiplier(Turret * const me);
float __cdecl Turret_ability_haste_mod(Turret * const me);
float __cdecl Turret_flat_bubble_radius_mod(Turret * const me);
float __cdecl Turret_percent_bubble_radius_mod(Turret * const me);
float __cdecl Turret_move_speed(Turret * const me);
float __cdecl Turret_move_speed_base_increase(Turret * const me);
float __cdecl Turret_scale_skin_coef(Turret * const me);
float __cdecl Turret_pathfinding_radius_mod(Turret * const me);
float __cdecl Turret_base_ability_damage(Turret * const me);
float __cdecl Turret_crit(Turret * const me);
float __cdecl Turret_par_regen_rate(Turret * const me);
float __cdecl Turret_attack_range(Turret * const me);
float __cdecl Turret_flat_cast_range_mod(Turret * const me);
float __cdecl Turret_percent_cooldown_mod(Turret * const me);
float __cdecl Turret_passive_cooldown_end_time(Turret * const me);
float __cdecl Turret_passive_cooldown_total_time(Turret * const me);
float __cdecl Turret_flat_armor_penetration(Turret * const me);
float __cdecl Turret_percent_armor_penetration(Turret * const me);
float __cdecl Turret_flat_magic_penetration(Turret * const me);
float __cdecl Turret_percent_magic_penetration(Turret * const me);
float __cdecl Turret_percent_life_steal_mod(Turret * const me);
float __cdecl Turret_percent_spell_vamp_mod(Turret * const me);
float __cdecl Turret_physical_damage_percent_modifier(Turret * const me);
float __cdecl Turret_magical_damage_percent_modifier(Turret * const me);
float __cdecl Turret_percent_damage_to_barracks_minion_mod(Turret * const me);
float __cdecl Turret_flat_damage_reduction_from_barracks_minion_mod(Turret * const me);
float __cdecl Turret_base_health(Turret * const me);
float __cdecl Turret_base_health_per_level(Turret * const me);
float __cdecl Turret_base_mana(Turret * const me);
float __cdecl Turret_base_mana_per_level(Turret * const me);
float __cdecl Turret_base_move_speed(Turret * const me);
// [Turret] [AttackableUnit] --------------------------------------------------
float __cdecl Turret_base_collision_radius(Turret * const me);
bool __cdecl Turret_is_visible(Turret * const me);
float __cdecl Turret_death_time(Turret * const me);
bool __cdecl Turret_is_dead(Turret * const me);
float __cdecl Turret_health(Turret * const me);
float __cdecl Turret_max_health(Turret * const me);
float __cdecl Turret_health_max_penalty(Turret * const me);
float __cdecl Turret_all_shield(Turret * const me);
float __cdecl Turret_physical_shield(Turret * const me);
float __cdecl Turret_magical_shield(Turret * const me);
float __cdecl Turret_champ_specific_health(Turret * const me);
float __cdecl Turret_incoming_healing_enemy(Turret * const me);
float __cdecl Turret_incoming_healing_allied(Turret * const me);
float __cdecl Turret_stop_shield_fade(Turret * const me);
bool __cdecl Turret_is_targetable(Turret * const me);
float __cdecl Turret_mana(Turret * const me);
float __cdecl Turret_max_mana(Turret * const me);
float __cdecl Turret_par(Turret * const me);
float __cdecl Turret_max_par(Turret * const me);
uint32_t __cdecl Turret_par_state(Turret * const me);
float __cdecl Turret_sar(Turret * const me);
float __cdecl Turret_max_sar(Turret * const me);
bool __cdecl Turret_sar_enabled(Turret * const me);
uint32_t __cdecl Turret_sar_state(Turret * const me);
// [Turret] [GameObject] ------------------------------------------------------
uint32_t __cdecl Turret_memory_address(Turret * const me);
uint32_t __cdecl Turret_id(Turret * const me);
uint32_t __cdecl Turret_index(Turret * const me);
GameObjectType __cdecl Turret_type(Turret * const me);
GameObjectTeam __cdecl Turret_team(Turret * const me);
const char* __cdecl Turret_name(Turret * const me);
bool __cdecl Turret_is_on_screen(Turret * const me);
uint32_t __cdecl Turret_network_id(Turret * const me);
float3 __cdecl Turret_pos(Turret * const me);
void __cdecl Turret_pos_Ptr(Turret * const me, float3 *pos);
bool __cdecl Turret_is_zombie(Turret * const me);
bool __cdecl Turret_is_ally(Turret * const me);
bool __cdecl Turret_is_enemy(Turret * const me);
bool __cdecl Turret_is_neutral(Turret * const me);
bool __cdecl Turret_is_player(Turret * const me);
bool __cdecl Turret_is_hero(Turret * const me);
bool __cdecl Turret_is_minion(Turret * const me);
bool __cdecl Turret_is_turret(Turret * const me);
bool __cdecl Turret_is_inhib(Turret * const me);
bool __cdecl Turret_is_nexus(Turret * const me);
bool __cdecl Turret_is_missile(Turret * const me);
bool __cdecl Turret_is_particle(Turret * const me);
bool __cdecl Turret_is_neutral_camp(Turret * const me);
bool __cdecl Turret_is_attackable_unit(Turret * const me);
bool __cdecl Turret_is_ai_client(Turret * const me);

//-----------------------------------------------------------------------------
// [Hero]
//-----------------------------------------------------------------------------
bool __cdecl Hero_is_teleporting(Hero * const me);
const char* __cdecl Hero_teleport_type(Hero * const me);
const char* __cdecl Hero_teleport_name(Hero * const me);
int __cdecl Hero_level(Hero * const me);
float __cdecl Hero_exp(Hero * const me);
vec_rune_t __cdecl Hero_runes(Hero * const me);
void __cdecl Hero_runes_Ptr(Hero * const me, vec_rune_t *out);
ItemSlot* __cdecl Hero_item_slot(Hero * const me, ItemSlotEnum slot);
// [Hero] [AIClient] ----------------------------------------------------------
CharacterData* __cdecl Hero_base_character_data(Hero * const me);
CharacterData* __cdecl Hero_character_data(Hero * const me);
CharacterRecord* __cdecl Hero_character_record(Hero * const me);
void __cdecl Hero_set_character_model(Hero * const me, const char *model, int skin_id);
vec_spell_calculation_t __cdecl Hero_spell_calculations(Hero * const me, SpellSlotEnum slot);
void __cdecl Hero_spell_calculations_Ptr(Hero * const me, SpellSlotEnum slot, vec_spell_calculation_t *out);
SpellCalculation* __cdecl Hero_find_spell_calculation_by_hash(Hero * const me, SpellSlotEnum slot, uint32_t hash);
float __cdecl Hero_calc_attack_cast_delay(Hero * const me);
float __cdecl Hero_calc_attack_delay(Hero * const me);
Texture* __cdecl Hero_icon_square(Hero * const me);
Texture* __cdecl Hero_icon_circle(Hero * const me);
bool __cdecl Hero_has_bar_pos(Hero * const me);
float2 __cdecl Hero_bar_pos(Hero * const me);
void __cdecl Hero_bar_pos_Ptr(Hero * const me, float2 *out);
vec_floating_info_bar_t __cdecl Hero_floating_info_bars(Hero * const me);
void __cdecl Hero_floating_info_bars_Ptr(Hero * const me, vec_floating_info_bar_t *out);
float __cdecl Hero_collision_radius(Hero * const me);
vec_buff_t __cdecl Hero_buffs(Hero * const me);
void __cdecl Hero_buffs_Ptr(Hero * const me, vec_buff_t *out);
Buff* __cdecl Hero_find_buff(Hero * const me, BuffType type);
Buff* __cdecl Hero_find_buff_by_name(Hero * const me, const char *name);
Buff* __cdecl Hero_find_buff_by_hash(Hero * const me, uint32_t fnv_hash);
Spell* __cdecl Hero_active_spell(Hero * const me);
SpellSlot* __cdecl Hero_spell_slot(Hero * const me, SpellSlotEnum slot);
vec_spell_t __cdecl Hero_basic_attacks(Hero * const me);
void __cdecl Hero_basic_attacks_Ptr(Hero * const me, vec_spell_t *out);
Path* __cdecl Hero_path(Hero * const me);
const char* __cdecl Hero_char_name(Hero * const me);
uint32_t __cdecl Hero_char_name_fnv_hash(Hero * const me);
float3 __cdecl Hero_direction(Hero * const me);
void __cdecl Hero_direction_Ptr(Hero * const me, float3 *out);
uint32_t __cdecl Hero_action_state(Hero * const me);
uint32_t __cdecl Hero_action_state2(Hero * const me);
CombatType __cdecl Hero_combat_type(Hero * const me);
bool __cdecl Hero_is_melee(Hero * const me);
bool __cdecl Hero_is_ranged(Hero * const me);
void __cdecl Hero_set_sort_heuristic(Hero * const me, float heuristic);
float __cdecl Hero_base_attack_damage(Hero * const me);
float __cdecl Hero_armor(Hero * const me);
float __cdecl Hero_spell_block(Hero * const me);
float __cdecl Hero_attack_speed_mod(Hero * const me);
float __cdecl Hero_flat_physical_damage_mod(Hero * const me);
float __cdecl Hero_percent_physical_damage_mod(Hero * const me);
float __cdecl Hero_flat_magic_damage_mod(Hero * const me);
float __cdecl Hero_percent_magic_damage_mod(Hero * const me);
float __cdecl Hero_health_regen_rate(Hero * const me);
float __cdecl Hero_primary_ar_regen_rate_rep(Hero * const me);
float __cdecl Hero_flat_magic_reduction(Hero * const me);
float __cdecl Hero_percent_magic_reduction(Hero * const me);
float __cdecl Hero_percent_bonus_armor_penetration(Hero * const me);
float __cdecl Hero_percent_crit_bonus_armor_penetration(Hero * const me);
float __cdecl Hero_percent_crit_total_armor_penetration(Hero * const me);
float __cdecl Hero_percent_bonus_magic_penetration(Hero * const me);
float __cdecl Hero_physical_lethality(Hero * const me);
float __cdecl Hero_magic_lethality(Hero * const me);
float __cdecl Hero_base_health_regen_rate(Hero * const me);
float __cdecl Hero_primary_ar_base_regen_rate_rep(Hero * const me);
float __cdecl Hero_secondary_ar_regen_rate_rep(Hero * const me);
float __cdecl Hero_secondary_ar_base_regen_rate_rep(Hero * const me);
float __cdecl Hero_percent_cooldown_cap_mod(Hero * const me);
float __cdecl Hero_percent_cc_reduction(Hero * const me);
float __cdecl Hero_percent_exp_bonus(Hero * const me);
float __cdecl Hero_flat_base_attack_damage_mod(Hero * const me);
float __cdecl Hero_percent_base_attack_damage_mod(Hero * const me);
float __cdecl Hero_base_attack_damage_sans_percent_scale(Hero * const me);
float __cdecl Hero_bonus_armor(Hero * const me);
float __cdecl Hero_bonus_spell_block(Hero * const me);
float __cdecl Hero_percent_bonus_physical_damage_mod(Hero * const me);
float __cdecl Hero_percent_base_physical_damage_as_flat_bonus(Hero * const me);
float __cdecl Hero_percent_attack_speed_mod(Hero * const me);
float __cdecl Hero_percent_multiplicative_attack_speed_mod(Hero * const me);
float __cdecl Hero_crit_damage_multiplier(Hero * const me);
float __cdecl Hero_ability_haste_mod(Hero * const me);
float __cdecl Hero_flat_bubble_radius_mod(Hero * const me);
float __cdecl Hero_percent_bubble_radius_mod(Hero * const me);
float __cdecl Hero_move_speed(Hero * const me);
float __cdecl Hero_move_speed_base_increase(Hero * const me);
float __cdecl Hero_scale_skin_coef(Hero * const me);
float __cdecl Hero_pathfinding_radius_mod(Hero * const me);
float __cdecl Hero_base_ability_damage(Hero * const me);
float __cdecl Hero_crit(Hero * const me);
float __cdecl Hero_par_regen_rate(Hero * const me);
float __cdecl Hero_attack_range(Hero * const me);
float __cdecl Hero_flat_cast_range_mod(Hero * const me);
float __cdecl Hero_percent_cooldown_mod(Hero * const me);
float __cdecl Hero_passive_cooldown_end_time(Hero * const me);
float __cdecl Hero_passive_cooldown_total_time(Hero * const me);
float __cdecl Hero_flat_armor_penetration(Hero * const me);
float __cdecl Hero_percent_armor_penetration(Hero * const me);
float __cdecl Hero_flat_magic_penetration(Hero * const me);
float __cdecl Hero_percent_magic_penetration(Hero * const me);
float __cdecl Hero_percent_life_steal_mod(Hero * const me);
float __cdecl Hero_percent_spell_vamp_mod(Hero * const me);
float __cdecl Hero_physical_damage_percent_modifier(Hero * const me);
float __cdecl Hero_magical_damage_percent_modifier(Hero * const me);
float __cdecl Hero_percent_damage_to_barracks_minion_mod(Hero * const me);
float __cdecl Hero_flat_damage_reduction_from_barracks_minion_mod(Hero * const me);
float __cdecl Hero_base_health(Hero * const me);
float __cdecl Hero_base_health_per_level(Hero * const me);
float __cdecl Hero_base_mana(Hero * const me);
float __cdecl Hero_base_mana_per_level(Hero * const me);
float __cdecl Hero_base_move_speed(Hero * const me);
// [Hero] [AttackableUnit] ----------------------------------------------------
float __cdecl Hero_base_collision_radius(Hero * const me);
bool __cdecl Hero_is_visible(Hero * const me);
float __cdecl Hero_death_time(Hero * const me);
bool __cdecl Hero_is_dead(Hero * const me);
float __cdecl Hero_health(Hero * const me);
float __cdecl Hero_max_health(Hero * const me);
float __cdecl Hero_health_max_penalty(Hero * const me);
float __cdecl Hero_all_shield(Hero * const me);
float __cdecl Hero_physical_shield(Hero * const me);
float __cdecl Hero_magical_shield(Hero * const me);
float __cdecl Hero_champ_specific_health(Hero * const me);
float __cdecl Hero_incoming_healing_enemy(Hero * const me);
float __cdecl Hero_incoming_healing_allied(Hero * const me);
float __cdecl Hero_stop_shield_fade(Hero * const me);
bool __cdecl Hero_is_targetable(Hero * const me);
float __cdecl Hero_mana(Hero * const me);
float __cdecl Hero_max_mana(Hero * const me);
float __cdecl Hero_par(Hero * const me);
float __cdecl Hero_max_par(Hero * const me);
uint32_t __cdecl Hero_par_state(Hero * const me);
float __cdecl Hero_sar(Hero * const me);
float __cdecl Hero_max_sar(Hero * const me);
bool __cdecl Hero_sar_enabled(Hero * const me);
uint32_t __cdecl Hero_sar_state(Hero * const me);
// [Hero] [GameObject] --------------------------------------------------------
uint32_t __cdecl Hero_memory_address(Hero * const me);
uint32_t __cdecl Hero_id(Hero * const me);
uint32_t __cdecl Hero_index(Hero * const me);
GameObjectType __cdecl Hero_type(Hero * const me);
GameObjectTeam __cdecl Hero_team(Hero * const me);
const char* __cdecl Hero_name(Hero * const me);
bool __cdecl Hero_is_on_screen(Hero * const me);
uint32_t __cdecl Hero_network_id(Hero * const me);
float3 __cdecl Hero_pos(Hero * const me);
void __cdecl Hero_pos_Ptr(Hero * const me, float3 *out);
bool __cdecl Hero_is_zombie(Hero * const me);
bool __cdecl Hero_is_ally(Hero * const me);
bool __cdecl Hero_is_enemy(Hero * const me);
bool __cdecl Hero_is_neutral(Hero * const me);
bool __cdecl Hero_is_player(Hero * const me);
bool __cdecl Hero_is_hero(Hero * const me);
bool __cdecl Hero_is_minion(Hero * const me);
bool __cdecl Hero_is_turret(Hero * const me);
bool __cdecl Hero_is_inhib(Hero * const me);
bool __cdecl Hero_is_nexus(Hero * const me);
bool __cdecl Hero_is_missile(Hero * const me);
bool __cdecl Hero_is_particle(Hero * const me);
bool __cdecl Hero_is_neutral_camp(Hero * const me);
bool __cdecl Hero_is_attackable_unit(Hero * const me);
bool __cdecl Hero_is_ai_client(Hero * const me);

//-----------------------------------------------------------------------------
// [Minion]
//-----------------------------------------------------------------------------
Hero* __cdecl Minion_owner(Minion * const me);
bool __cdecl Minion_is_lane_minion(Minion * const me);
bool __cdecl Minion_is_melee_minion(Minion * const me);
bool __cdecl Minion_is_ranged_minion(Minion * const me);
bool __cdecl Minion_is_siege_minion(Minion * const me);
bool __cdecl Minion_is_super_minion(Minion * const me);
bool __cdecl Minion_is_monster(Minion * const me);
bool __cdecl Minion_is_camp_monster(Minion * const me);
bool __cdecl Minion_is_medium_monster(Minion * const me);
bool __cdecl Minion_is_large_monster(Minion * const me);
bool __cdecl Minion_is_epic_monster(Minion * const me);
bool __cdecl Minion_is_wolf(Minion * const me);
bool __cdecl Minion_is_gromp(Minion * const me);
bool __cdecl Minion_is_raptor(Minion * const me);
bool __cdecl Minion_is_krug(Minion * const me);
bool __cdecl Minion_is_buff(Minion * const me);
bool __cdecl Minion_is_blue(Minion * const me);
bool __cdecl Minion_is_red(Minion * const me);
bool __cdecl Minion_is_crab(Minion * const me);
bool __cdecl Minion_is_dragon(Minion * const me);
bool __cdecl Minion_is_special_void_minion(Minion * const me);
bool __cdecl Minion_is_herald(Minion * const me);
bool __cdecl Minion_is_baron(Minion * const me);
bool __cdecl Minion_is_ward(Minion * const me);
bool __cdecl Minion_is_special_minion(Minion * const me);
bool __cdecl Minion_is_plant(Minion * const me);
bool __cdecl Minion_is_trap(Minion * const me);
bool __cdecl Minion_is_summon(Minion * const me);
bool __cdecl Minion_is_large_summon(Minion * const me);
// [Minion] [AIClient] --------------------------------------------------------
CharacterData* __cdecl Minion_base_character_data(Minion * const me);
CharacterData* __cdecl Minion_character_data(Minion * const me);
CharacterRecord* __cdecl Minion_character_record(Minion * const me);
void __cdecl Minion_set_character_model(Minion * const me, const char *model, int skin_id);
vec_spell_calculation_t __cdecl Minion_spell_calculations(Minion * const me, SpellSlotEnum slot);
void __cdecl Minion_spell_calculations_Ptr(Minion * const me, SpellSlotEnum slot, vec_spell_calculation_t *out);
SpellCalculation* __cdecl Minion_find_spell_calculation_by_hash(Minion * const me, SpellSlotEnum slot, uint32_t hash);
float __cdecl Minion_calc_attack_cast_delay(Minion * const me);
float __cdecl Minion_calc_attack_delay(Minion * const me);
Texture* __cdecl Minion_icon_square(Minion * const me);
Texture* __cdecl Minion_icon_circle(Minion * const me);
bool __cdecl Minion_has_bar_pos(Minion * const me);
float2 __cdecl Minion_bar_pos(Minion * const me);
void __cdecl Minion_bar_pos_Ptr(Minion * const me, float2 *out);
vec_floating_info_bar_t __cdecl Minion_floating_info_bars(Minion * const me);
void __cdecl Minion_floating_info_bars_Ptr(Minion * const me, vec_floating_info_bar_t *out);
float __cdecl Minion_collision_radius(Minion * const me);
vec_buff_t __cdecl Minion_buffs(Minion * const me);
void __cdecl Minion_buffs_Ptr(Minion * const me, vec_buff_t *out);
Buff* __cdecl Minion_find_buff(Minion * const me, BuffType type);
Buff* __cdecl Minion_find_buff_by_name(Minion * const me, const char *name);
Buff* __cdecl Minion_find_buff_by_hash(Minion * const me, uint32_t fnv_hash);
Spell* __cdecl Minion_active_spell(Minion * const me);
SpellSlot* __cdecl Minion_spell_slot(Minion * const me, SpellSlotEnum slot);
vec_spell_t __cdecl Minion_basic_attacks(Minion * const me);
void __cdecl Minion_basic_attacks_Ptr(Minion * const me, vec_spell_t *out);
Path* __cdecl Minion_path(Minion * const me);
const char* __cdecl Minion_char_name(Minion * const me);
uint32_t __cdecl Minion_char_name_fnv_hash(Minion * const me);
float3 __cdecl Minion_direction(Minion * const me);
void __cdecl Minion_direction_Ptr(Minion * const me, float3 *out);
uint32_t __cdecl Minion_action_state(Minion * const me);
uint32_t __cdecl Minion_action_state2(Minion * const me);
CombatType __cdecl Minion_combat_type(Minion * const me);
bool __cdecl Minion_is_melee(Minion * const me);
bool __cdecl Minion_is_ranged(Minion * const me);
void __cdecl Minion_set_sort_heuristic(Minion * const me, float heuristic);
float __cdecl Minion_base_attack_damage(Minion * const me);
float __cdecl Minion_armor(Minion * const me);
float __cdecl Minion_spell_block(Minion * const me);
float __cdecl Minion_attack_speed_mod(Minion * const me);
float __cdecl Minion_flat_physical_damage_mod(Minion * const me);
float __cdecl Minion_percent_physical_damage_mod(Minion * const me);
float __cdecl Minion_flat_magic_damage_mod(Minion * const me);
float __cdecl Minion_percent_magic_damage_mod(Minion * const me);
float __cdecl Minion_health_regen_rate(Minion * const me);
float __cdecl Minion_primary_ar_regen_rate_rep(Minion * const me);
float __cdecl Minion_flat_magic_reduction(Minion * const me);
float __cdecl Minion_percent_magic_reduction(Minion * const me);
float __cdecl Minion_percent_bonus_armor_penetration(Minion * const me);
float __cdecl Minion_percent_crit_bonus_armor_penetration(Minion * const me);
float __cdecl Minion_percent_crit_total_armor_penetration(Minion * const me);
float __cdecl Minion_percent_bonus_magic_penetration(Minion * const me);
float __cdecl Minion_physical_lethality(Minion * const me);
float __cdecl Minion_magic_lethality(Minion * const me);
float __cdecl Minion_base_health_regen_rate(Minion * const me);
float __cdecl Minion_primary_ar_base_regen_rate_rep(Minion * const me);
float __cdecl Minion_secondary_ar_regen_rate_rep(Minion * const me);
float __cdecl Minion_secondary_ar_base_regen_rate_rep(Minion * const me);
float __cdecl Minion_percent_cooldown_cap_mod(Minion * const me);
float __cdecl Minion_percent_cc_reduction(Minion * const me);
float __cdecl Minion_percent_exp_bonus(Minion * const me);
float __cdecl Minion_flat_base_attack_damage_mod(Minion * const me);
float __cdecl Minion_percent_base_attack_damage_mod(Minion * const me);
float __cdecl Minion_base_attack_damage_sans_percent_scale(Minion * const me);
float __cdecl Minion_bonus_armor(Minion * const me);
float __cdecl Minion_bonus_spell_block(Minion * const me);
float __cdecl Minion_percent_bonus_physical_damage_mod(Minion * const me);
float __cdecl Minion_percent_base_physical_damage_as_flat_bonus(Minion * const me);
float __cdecl Minion_percent_attack_speed_mod(Minion * const me);
float __cdecl Minion_percent_multiplicative_attack_speed_mod(Minion * const me);
float __cdecl Minion_crit_damage_multiplier(Minion * const me);
float __cdecl Minion_ability_haste_mod(Minion * const me);
float __cdecl Minion_flat_bubble_radius_mod(Minion * const me);
float __cdecl Minion_percent_bubble_radius_mod(Minion * const me);
float __cdecl Minion_move_speed(Minion * const me);
float __cdecl Minion_move_speed_base_increase(Minion * const me);
float __cdecl Minion_scale_skin_coef(Minion * const me);
float __cdecl Minion_pathfinding_radius_mod(Minion * const me);
float __cdecl Minion_base_ability_damage(Minion * const me);
float __cdecl Minion_crit(Minion * const me);
float __cdecl Minion_par_regen_rate(Minion * const me);
float __cdecl Minion_attack_range(Minion * const me);
float __cdecl Minion_flat_cast_range_mod(Minion * const me);
float __cdecl Minion_percent_cooldown_mod(Minion * const me);
float __cdecl Minion_passive_cooldown_end_time(Minion * const me);
float __cdecl Minion_passive_cooldown_total_time(Minion * const me);
float __cdecl Minion_flat_armor_penetration(Minion * const me);
float __cdecl Minion_percent_armor_penetration(Minion * const me);
float __cdecl Minion_flat_magic_penetration(Minion * const me);
float __cdecl Minion_percent_magic_penetration(Minion * const me);
float __cdecl Minion_percent_life_steal_mod(Minion * const me);
float __cdecl Minion_percent_spell_vamp_mod(Minion * const me);
float __cdecl Minion_physical_damage_percent_modifier(Minion * const me);
float __cdecl Minion_magical_damage_percent_modifier(Minion * const me);
float __cdecl Minion_percent_damage_to_barracks_minion_mod(Minion * const me);
float __cdecl Minion_flat_damage_reduction_from_barracks_minion_mod(Minion * const me);
float __cdecl Minion_base_health(Minion * const me);
float __cdecl Minion_base_health_per_level(Minion * const me);
float __cdecl Minion_base_mana(Minion * const me);
float __cdecl Minion_base_mana_per_level(Minion * const me);
float __cdecl Minion_base_move_speed(Minion * const me);
// [Minion] [AttackableUnit] --------------------------------------------------
float __cdecl Minion_base_collision_radius(Minion * const me);
bool __cdecl Minion_is_visible(Minion * const me);
float __cdecl Minion_death_time(Minion * const me);
bool __cdecl Minion_is_dead(Minion * const me);
float __cdecl Minion_health(Minion * const me);
float __cdecl Minion_max_health(Minion * const me);
float __cdecl Minion_health_max_penalty(Minion * const me);
float __cdecl Minion_all_shield(Minion * const me);
float __cdecl Minion_physical_shield(Minion * const me);
float __cdecl Minion_magical_shield(Minion * const me);
float __cdecl Minion_champ_specific_health(Minion * const me);
float __cdecl Minion_incoming_healing_enemy(Minion * const me);
float __cdecl Minion_incoming_healing_allied(Minion * const me);
float __cdecl Minion_stop_shield_fade(Minion * const me);
bool __cdecl Minion_is_targetable(Minion * const me);
float __cdecl Minion_mana(Minion * const me);
float __cdecl Minion_max_mana(Minion * const me);
float __cdecl Minion_par(Minion * const me);
float __cdecl Minion_max_par(Minion * const me);
uint32_t __cdecl Minion_par_state(Minion * const me);
float __cdecl Minion_sar(Minion * const me);
float __cdecl Minion_max_sar(Minion * const me);
bool __cdecl Minion_sar_enabled(Minion * const me);
uint32_t __cdecl Minion_sar_state(Minion * const me);
// [Minion] [GameObject] ------------------------------------------------------
uint32_t __cdecl Minion_memory_address(Minion * const me);
uint32_t __cdecl Minion_id(Minion * const me);
uint32_t __cdecl Minion_index(Minion * const me);
GameObjectType __cdecl Minion_type(Minion * const me);
GameObjectTeam __cdecl Minion_team(Minion * const me);
const char* __cdecl Minion_name(Minion * const me);
bool __cdecl Minion_is_on_screen(Minion * const me);
uint32_t __cdecl Minion_network_id(Minion * const me);
float3 __cdecl Minion_pos(Minion * const me);
void __cdecl Minion_pos_Ptr(Minion * const me, float3 *out);
bool __cdecl Minion_is_zombie(Minion * const me);
bool __cdecl Minion_is_ally(Minion * const me);
bool __cdecl Minion_is_enemy(Minion * const me);
bool __cdecl Minion_is_neutral(Minion * const me);
bool __cdecl Minion_is_player(Minion * const me);
bool __cdecl Minion_is_hero(Minion * const me);
bool __cdecl Minion_is_minion(Minion * const me);
bool __cdecl Minion_is_turret(Minion * const me);
bool __cdecl Minion_is_inhib(Minion * const me);
bool __cdecl Minion_is_nexus(Minion * const me);
bool __cdecl Minion_is_missile(Minion * const me);
bool __cdecl Minion_is_particle(Minion * const me);
bool __cdecl Minion_is_neutral_camp(Minion * const me);
bool __cdecl Minion_is_attackable_unit(Minion * const me);
bool __cdecl Minion_is_ai_client(Minion * const me);

//-----------------------------------------------------------------------------
// [Player]
//-----------------------------------------------------------------------------
SpellCastStatusFlags __cdecl Player_spell_cast_status(Player * const me, SpellSlotEnum slot);
bool __cdecl Player_spell_cast_is_ready(Player * const me, SpellSlotEnum slot);
bool __cdecl Player_spell_cast_is_not_available(Player * const me, SpellSlotEnum slot);
bool __cdecl Player_spell_cast_is_not_learned(Player * const me, SpellSlotEnum slot);
bool __cdecl Player_spell_cast_is_disabled(Player * const me, SpellSlotEnum slot);
bool __cdecl Player_spell_cast_is_supressed(Player * const me, SpellSlotEnum slot);
bool __cdecl Player_spell_cast_is_on_cooldown(Player * const me, SpellSlotEnum slot);
bool __cdecl Player_spell_cast_is_out_of_mana(Player * const me, SpellSlotEnum slot);
bool __cdecl Player_is_cast_spell_limited(Player * const me, SpellSlotEnum slot);
void __cdecl Player_reset_cast_spell_limiter(Player * const me, SpellSlotEnum slot);
bool __cdecl Player_can_cast_spell(Player * const me, SpellSlotEnum slot);
bool __cdecl Player_cast_spell(Player * const me, SpellSlotEnum slot);
bool __cdecl Player_cast_spell_target(Player * const me, SpellSlotEnum slot, AttackableUnit *target);
bool __cdecl Player_cast_spell_pos(Player * const me, SpellSlotEnum slot, const float3 pos);
bool __cdecl Player_cast_spell_pos_Ptr(Player * const me, SpellSlotEnum slot, float3 *p_pos);
bool __cdecl Player_cast_spell_line(Player * const me, SpellSlotEnum slot, const float3 from, const float3 to);
bool __cdecl Player_cast_spell_line_Ptr(Player * const me, SpellSlotEnum slot, float3 *p_from, float3 *p_to);
bool __cdecl Player_is_release_spell_limited(Player * const me, SpellSlotEnum slot);
void __cdecl Player_reset_release_spell_limiter(Player * const me, SpellSlotEnum slot);
bool __cdecl Player_release_spell(Player * const me, SpellSlotEnum slot, const float3 pos);
bool __cdecl Player_release_spell_Ptr(Player * const me, SpellSlotEnum slot, float3 *p_pos);
bool __cdecl Player_is_move_limited(Player * const me);
void __cdecl Player_reset_move_limiter(Player * const me);
bool __cdecl Player_can_move(Player * const me);
bool __cdecl Player_move(Player * const me, const float3 pos);
bool __cdecl Player_move_Ptr(Player * const me, float3 *p_pos);
bool __cdecl Player_hold_position(Player * const me);
bool __cdecl Player_stop(Player * const me);
bool __cdecl Player_is_attack_limited(Player * const me);
void __cdecl Player_reset_attack_limiter(Player * const me);
bool __cdecl Player_can_attack(Player * const me);
bool __cdecl Player_attack_move(Player * const me, const float3 pos);
bool __cdecl Player_attack_move_Ptr(Player * const me, float3 *p_pos);
bool __cdecl Player_attack(Player * const me, AttackableUnit *target);
bool __cdecl Player_pet_move(Player * const me, const float3 pos);
bool __cdecl Player_pet_move_Ptr(Player * const me, float3 *p_pos);
bool __cdecl Player_pet_attack(Player * const me, AttackableUnit *target);
float __cdecl Player_gold(Player * const me);
float __cdecl Player_total_gold(Player * const me);
bool __cdecl Player_is_following_target(Player * const me);
GameObject* __cdecl Player_follow_target(Player * const me);
// [Player] [Hero] ------------------------------------------------------------
bool __cdecl Player_is_teleporting(Player * const me);
const char* __cdecl Player_teleport_type(Player * const me);
const char* __cdecl Player_teleport_name(Player * const me);
int __cdecl Player_level(Player * const me);
float __cdecl Player_exp(Player * const me);
vec_rune_t __cdecl Player_runes(Player * const me);
void __cdecl Player_runes_Ptr(Player * const me, vec_rune_t *out);
ItemSlot* __cdecl Player_item_slot(Player * const me, ItemSlotEnum slot);
// [Player] [AIClient] --------------------------------------------------------
CharacterData* __cdecl Player_base_character_data(Player * const me);
CharacterData* __cdecl Player_character_data(Player * const me);
CharacterRecord* __cdecl Player_character_record(Player * const me);
void __cdecl Player_set_character_model(Player * const me, const char *model, int skin_id);
vec_spell_calculation_t __cdecl Player_spell_calculations(Player * const me, SpellSlotEnum slot);
void __cdecl Player_spell_calculations_Ptr(Player * const me, SpellSlotEnum slot, vec_spell_calculation_t *out);
SpellCalculation* __cdecl Player_find_spell_calculation_by_hash(Player * const me, SpellSlotEnum slot, uint32_t hash);
float __cdecl Player_calc_attack_cast_delay(Player * const me);
float __cdecl Player_calc_attack_delay(Player * const me);
Texture* __cdecl Player_icon_square(Player * const me);
Texture* __cdecl Player_icon_circle(Player * const me);
bool __cdecl Player_has_bar_pos(Player * const me);
float2 __cdecl Player_bar_pos(Player * const me);
void __cdecl Player_bar_pos_Ptr(Player * const me, float2 *out);
vec_floating_info_bar_t __cdecl Player_floating_info_bars(Player * const me);
void __cdecl Player_floating_info_bars_Ptr(Player * const me, vec_floating_info_bar_t *out);
float __cdecl Player_collision_radius(Player * const me);
vec_buff_t __cdecl Player_buffs(Player * const me);
void __cdecl Player_buffs_Ptr(Player * const me, vec_buff_t *out);
Buff* __cdecl Player_find_buff(Player * const me, BuffType type);
Buff* __cdecl Player_find_buff_by_name(Player * const me, const char *name);
Buff* __cdecl Player_find_buff_by_hash(Player * const me, uint32_t fnv_hash);
Spell* __cdecl Player_active_spell(Player * const me);
SpellSlot* __cdecl Player_spell_slot(Player * const me, SpellSlotEnum slot);
vec_spell_t __cdecl Player_basic_attacks(Player * const me);
void __cdecl Player_basic_attacks_Ptr(Player * const me, vec_spell_t *out);
Path* __cdecl Player_path(Player * const me);
const char* __cdecl Player_char_name(Player * const me);
uint32_t __cdecl Player_char_name_fnv_hash(Player * const me);
float3 __cdecl Player_direction(Player * const me);
void __cdecl Player_direction_Ptr(Player * const me, float3 *out);
uint32_t __cdecl Player_action_state(Player * const me);
uint32_t __cdecl Player_action_state2(Player * const me);
CombatType __cdecl Player_combat_type(Player * const me);
bool __cdecl Player_is_melee(Player * const me);
bool __cdecl Player_is_ranged(Player * const me);
void __cdecl Player_set_sort_heuristic(Player * const me, float heuristic);
float __cdecl Player_base_attack_damage(Player * const me);
float __cdecl Player_armor(Player * const me);
float __cdecl Player_spell_block(Player * const me);
float __cdecl Player_attack_speed_mod(Player * const me);
float __cdecl Player_flat_physical_damage_mod(Player * const me);
float __cdecl Player_percent_physical_damage_mod(Player * const me);
float __cdecl Player_flat_magic_damage_mod(Player * const me);
float __cdecl Player_percent_magic_damage_mod(Player * const me);
float __cdecl Player_health_regen_rate(Player * const me);
float __cdecl Player_primary_ar_regen_rate_rep(Player * const me);
float __cdecl Player_flat_magic_reduction(Player * const me);
float __cdecl Player_percent_magic_reduction(Player * const me);
float __cdecl Player_percent_bonus_armor_penetration(Player * const me);
float __cdecl Player_percent_crit_bonus_armor_penetration(Player * const me);
float __cdecl Player_percent_crit_total_armor_penetration(Player * const me);
float __cdecl Player_percent_bonus_magic_penetration(Player * const me);
float __cdecl Player_physical_lethality(Player * const me);
float __cdecl Player_magic_lethality(Player * const me);
float __cdecl Player_base_health_regen_rate(Player * const me);
float __cdecl Player_primary_ar_base_regen_rate_rep(Player * const me);
float __cdecl Player_secondary_ar_regen_rate_rep(Player * const me);
float __cdecl Player_secondary_ar_base_regen_rate_rep(Player * const me);
float __cdecl Player_percent_cooldown_cap_mod(Player * const me);
float __cdecl Player_percent_cc_reduction(Player * const me);
float __cdecl Player_percent_exp_bonus(Player * const me);
float __cdecl Player_flat_base_attack_damage_mod(Player * const me);
float __cdecl Player_percent_base_attack_damage_mod(Player * const me);
float __cdecl Player_base_attack_damage_sans_percent_scale(Player * const me);
float __cdecl Player_bonus_armor(Player * const me);
float __cdecl Player_bonus_spell_block(Player * const me);
float __cdecl Player_percent_bonus_physical_damage_mod(Player * const me);
float __cdecl Player_percent_base_physical_damage_as_flat_bonus(Player * const me);
float __cdecl Player_percent_attack_speed_mod(Player * const me);
float __cdecl Player_percent_multiplicative_attack_speed_mod(Player * const me);
float __cdecl Player_crit_damage_multiplier(Player * const me);
float __cdecl Player_ability_haste_mod(Player * const me);
float __cdecl Player_flat_bubble_radius_mod(Player * const me);
float __cdecl Player_percent_bubble_radius_mod(Player * const me);
float __cdecl Player_move_speed(Player * const me);
float __cdecl Player_move_speed_base_increase(Player * const me);
float __cdecl Player_scale_skin_coef(Player * const me);
float __cdecl Player_pathfinding_radius_mod(Player * const me);
float __cdecl Player_base_ability_damage(Player * const me);
float __cdecl Player_crit(Player * const me);
float __cdecl Player_par_regen_rate(Player * const me);
float __cdecl Player_attack_range(Player * const me);
float __cdecl Player_flat_cast_range_mod(Player * const me);
float __cdecl Player_percent_cooldown_mod(Player * const me);
float __cdecl Player_passive_cooldown_end_time(Player * const me);
float __cdecl Player_passive_cooldown_total_time(Player * const me);
float __cdecl Player_flat_armor_penetration(Player * const me);
float __cdecl Player_percent_armor_penetration(Player * const me);
float __cdecl Player_flat_magic_penetration(Player * const me);
float __cdecl Player_percent_magic_penetration(Player * const me);
float __cdecl Player_percent_life_steal_mod(Player * const me);
float __cdecl Player_percent_spell_vamp_mod(Player * const me);
float __cdecl Player_physical_damage_percent_modifier(Player * const me);
float __cdecl Player_magical_damage_percent_modifier(Player * const me);
float __cdecl Player_percent_damage_to_barracks_minion_mod(Player * const me);
float __cdecl Player_flat_damage_reduction_from_barracks_minion_mod(Player * const me);
float __cdecl Player_base_health(Player * const me);
float __cdecl Player_base_health_per_level(Player * const me);
float __cdecl Player_base_mana(Player * const me);
float __cdecl Player_base_mana_per_level(Player * const me);
float __cdecl Player_base_move_speed(Player * const me);
// [Player] [AttackableUnit] --------------------------------------------------
float __cdecl Player_base_collision_radius(Player * const me);
bool __cdecl Player_is_visible(Player * const me);
float __cdecl Player_death_time(Player * const me);
bool __cdecl Player_is_dead(Player * const me);
float __cdecl Player_health(Player * const me);
float __cdecl Player_max_health(Player * const me);
float __cdecl Player_health_max_penalty(Player * const me);
float __cdecl Player_all_shield(Player * const me);
float __cdecl Player_physical_shield(Player * const me);
float __cdecl Player_magical_shield(Player * const me);
float __cdecl Player_champ_specific_health(Player * const me);
float __cdecl Player_incoming_healing_enemy(Player * const me);
float __cdecl Player_incoming_healing_allied(Player * const me);
float __cdecl Player_stop_shield_fade(Player * const me);
bool __cdecl Player_is_targetable(Player * const me);
float __cdecl Player_mana(Player * const me);
float __cdecl Player_max_mana(Player * const me);
float __cdecl Player_par(Player * const me);
float __cdecl Player_max_par(Player * const me);
uint32_t __cdecl Player_par_state(Player * const me);
float __cdecl Player_sar(Player * const me);
float __cdecl Player_max_sar(Player * const me);
bool __cdecl Player_sar_enabled(Player * const me);
uint32_t __cdecl Player_sar_state(Player * const me);
// [Player] [GameObject] ------------------------------------------------------
uint32_t __cdecl Player_memory_address(Player * const me);
uint32_t __cdecl Player_id(Player * const me);
uint32_t __cdecl Player_index(Player * const me);
GameObjectType __cdecl Player_type(Player * const me);
GameObjectTeam __cdecl Player_team(Player * const me);
const char* __cdecl Player_name(Player * const me);
bool __cdecl Player_is_on_screen(Player * const me);
uint32_t __cdecl Player_network_id(Player * const me);
float3 __cdecl Player_pos(Player * const me);
void __cdecl Player_pos_Ptr(Player * const me, float3 *out);
bool __cdecl Player_is_zombie(Player * const me);
bool __cdecl Player_is_ally(Player * const me);
bool __cdecl Player_is_enemy(Player * const me);
bool __cdecl Player_is_neutral(Player * const me);
bool __cdecl Player_is_player(Player * const me);
bool __cdecl Player_is_hero(Player * const me);
bool __cdecl Player_is_minion(Player * const me);
bool __cdecl Player_is_turret(Player * const me);
bool __cdecl Player_is_inhib(Player * const me);
bool __cdecl Player_is_nexus(Player * const me);
bool __cdecl Player_is_missile(Player * const me);
bool __cdecl Player_is_particle(Player * const me);
bool __cdecl Player_is_neutral_camp(Player * const me);
bool __cdecl Player_is_attackable_unit(Player * const me);
bool __cdecl Player_is_ai_client(Player * const me);

#ifdef __cplusplus
}
#endif

#ifdef BOTM_CPP_EXT

class Console {
public:
    void printf(const char *fmt, ...)
	{
        va_list args;
        va_start(args, fmt);
		Console_printf_va(this, fmt, args);
        va_end(args);
	}
    void printf_va(const char *fmt, va_list args)
	{
        Console_printf_va(this, fmt, args);
	}
	int16_t set_attributes(int16_t attributes)
	{
		return Console_set_attributes(this, attributes);
	}
	int16_t get_attributes()
	{
		return Console_get_attributes(this);
	}
};

class BotM {
public:
	const char* version()
	{
		return BotM_version(this);
	}
	BotMLanguage language()
	{
		return BotM_language(this);
	}
	const char* get_directory()
	{
		return BotM_get_directory(this);
	}
	const char* get_script_directory()
	{
		return BotM_get_script_directory(this);
	}
	bool is_menu_open()
	{
		return BotM_is_menu_open(this);
	}
	bool issue_toggle_menu()
	{
		return BotM_issue_toggle_menu(this);
	}
	bool is_draw_enabled()
	{
		return BotM_is_draw_enabled(this);
	}
	bool issue_toggle_drawings()
	{
		return BotM_issue_toggle_drawings(this);
	}
};

class ScriptTor {
public:
	bool add_script(const char *dir, const char *script_entry)
	{
		return ScriptTor_add_script(this, dir, script_entry);
	}
	bool remove_script(const char *dir)
	{
		return ScriptTor_remove_script(this, dir);
	}
	bool set_script_display_name(const char *dir, const char *display_name)
	{
		return ScriptTor_set_script_display_name(this, dir, display_name);
	}
	bool set_script_author(const char *dir, const char *author)
	{
		return ScriptTor_set_script_author(this, dir, author);
	}
	bool set_script_version(const char *dir, const char *version)
	{
		return ScriptTor_set_script_version(this, dir, version);
	}
	bool set_script_icon(const char *dir, const char *icon)
	{
		return ScriptTor_set_script_icon(this, dir, icon);
	}
	bool set_script_loadscript_id(const char *dir, const char *loadscript_id)
	{
		return ScriptTor_set_script_loadscript_id(this, dir, loadscript_id);
	}
	bool set_script_enabled(const char *dir, bool enabled)
	{
		return ScriptTor_set_script_enabled(this, dir, enabled);
	}
	bool issue_reload()
	{
		return ScriptTor_issue_reload(this);
	}
	bool issue_unload()
	{
		return ScriptTor_issue_unload(this);
	}
	bool issue_toggle()
	{
		return ScriptTor_issue_toggle(this);
	}
};

class Game {
public:
	float3 mouse_pos()
	{
		float3 out;
		Game_mouse_pos_Ptr(this, &out);
		return out;
	}
	float2 cursor_pos()
	{
		float2 out;
		Game_cursor_pos_Ptr(this, &out);
		return out;
	}
	float time()
	{
		return Game_time(this);
	}
	float latency()
	{
		return Game_latency(this);
	}
	float path_update_timer()
	{
		return Game_path_update_timer(this);
	}
	uint32_t fnv_hash(const char *str)
	{
		return Game_fnv_hash(this, str);
	}
	const char* command_line()
	{
		return Game_command_line(this);
	}
	int map_id()
	{
		return Game_map_id(this);
	}
	const char* map()
	{
		return Game_map(this);
	}
	vec_string_t mutators()
	{
		vec_string_t out;
		Game_mutators_Ptr(this, &out);
		return out;
	}
	const char* mode()
	{
		return Game_mode(this);
	}
	const char* type()
	{
		return Game_type(this);
	}
	const char* id()
	{
		return Game_id(this);
	}
	const char* platform_id()
	{
		return Game_platform_id(this);
	}
	const char* version()
	{
		return Game_version(this);
	}
	bool is_window_focused()
	{
		return Game_is_window_focused(this);
	}
	GameObject* selected_target()
	{
		return Game_selected_target(this);
	}
	GameObject* hovered_target()
	{
		return Game_hovered_target(this);
	}
	vec_texture_t textures()
	{
		vec_texture_t out;
		Game_textures_Ptr(this, &out);
		return out;
	}
	void ping(GamePing ping, const float3 pos, GameObject *target)
	{
		return Game_ping(this, ping, pos, target);
	}
	void ping_client(GamePing ping, const float3 pos, GameObject *target)
	{
		return Game_ping_client(this, ping, pos, target);
	}
};

class Hud {
public:
	vec_hud_base_t bases()
	{
		vec_hud_base_t out;
		Hud_bases_Ptr(this, &out);
		return out;
	}
};

class Navmesh {
public:
	float3 grid_start_pos()
	{
		float3 out;
		Navmesh_grid_start_pos_Ptr(this, &out);
		return out;
	}
	float3 grid_end_pos()
	{
		float3 out;
		Navmesh_grid_end_pos_Ptr(this, &out);
		return out;
	}
	uint2 grid_size()
	{
		uint2 out;
		Navmesh_grid_size_Ptr(this, &out);
		return out;
	}
	float grid_cell_length()
	{
		return Navmesh_grid_cell_length(this);
	}
	size_t grid_index_to_flat_index(uint2 &index)
	{
		return Navmesh_grid_index_to_flat_index_Ptr(this, &index);
	}
	uint2 grid_flat_index_to_index(size_t flat_index)
	{
		uint2 out;
		Navmesh_grid_flat_index_to_index_Ptr(this, flat_index, &out);
		return out;
	}
	uint2 grid_world_to_index(float3 &pos)
	{
		uint2 out;
		Navmesh_grid_world_to_index_Ptr(this, &pos, &out);
		return out;
	}
	size_t grid_world_to_flat_index(float3 &pos)
	{
		return Navmesh_grid_world_to_flat_index_Ptr(this, &pos);
	}
	float3 grid_index_to_world(uint2 &index)
	{
		float3 out;
		Navmesh_grid_index_to_world_Ptr(this, &index, &out);
		return out;
	}
	float3 grid_flat_index_to_world(size_t flat_index)
	{
		float3 out;
		Navmesh_grid_flat_index_to_world_Ptr(this, flat_index, &out);
		return out;
	}
	float3 clamp_world_on_grid(float3 &pos)
	{
		float3 out;
		Navmesh_clamp_world_on_grid_Ptr(this, &pos, &out);
		return out;
	}
	CellTypeFlags cell_type_from_index(uint2 &index)
	{
		return Navmesh_cell_type_from_index_Ptr(this, &index);
	}
	CellTypeFlags cell_type_from_flat_index(size_t flat_index)
	{
		return Navmesh_cell_type_from_flat_index(this, flat_index);
	}
	CellTypeFlags cell_type_from_world(float3 &pos)
	{
		return Navmesh_cell_type_from_world_Ptr(this, &pos);
	}
	bool is_grass(float3 &pos)
	{
		return Navmesh_is_grass_Ptr(this, &pos);
	}
	bool is_wall(float3 &pos)
	{
		return Navmesh_is_wall_Ptr(this, &pos);
	}
	bool is_structure(float3 &pos)
	{
		return Navmesh_is_structure_Ptr(this, &pos);
	}
	float get_terrain_height(float3 &pos)
	{
		return Navmesh_get_terrain_height_Ptr(this, &pos);
	}
	bool is_direct_path(AIClient *from, float3 &to, uint2 *index_out)
	{
		return Navmesh_is_direct_path_Ptr(this, from, &to, index_out);
	}
	vec_float3_t calc_path(AIClient *from, float3 &to)
	{
		vec_float3_t out;
		Navmesh_calc_path_Ptr(this, from, &to, &out);
		return out;
	}
	uint32_t gameplay_area(float3 &pos)
	{
		return Navmesh_gameplay_area_Ptr(this, &pos);
	}
	bool is_in_platform(float3 &pos)
	{
		return Navmesh_is_in_platform_Ptr(this, &pos);
	}
	bool is_in_base(float3 &pos)
	{
		return Navmesh_is_in_base_Ptr(this, &pos);
	}
	bool is_in_bot_lane(float3 &pos)
	{
		return Navmesh_is_in_bot_lane_Ptr(this, &pos);
	}
	bool is_in_mid_lane(float3 &pos)
	{
		return Navmesh_is_in_mid_lane_Ptr(this, &pos);
	}
	bool is_in_top_lane(float3 &pos)
	{
		return Navmesh_is_in_top_lane_Ptr(this, &pos);
	}
	bool is_in_bot_river(float3 &pos)
	{
		return Navmesh_is_in_bot_river_Ptr(this, &pos);
	}
	bool is_in_top_river(float3 &pos)
	{
		return Navmesh_is_in_top_river_Ptr(this, &pos);
	}
	bool is_in_bot_jungle(float3 &pos)
	{
		return Navmesh_is_in_bot_jungle_Ptr(this, &pos);
	}
	bool is_in_top_jungle(float3 &pos)
	{
		return Navmesh_is_in_top_jungle_Ptr(this, &pos);
	}
};

class Chat {
public:
	bool is_open()
	{
		return Chat_is_open(this);
	}
	size_t start()
	{
		return Chat_start(this);
	}
	size_t index()
	{
		return Chat_index(this);
	}
	size_t size()
	{
		return Chat_size(this);
	}
	bool send(const char *message)
	{
		return Chat_send(this, message);
	}
	bool print(const char *message)
	{
		return Chat_print(this, message);
	}
	const char* message(size_t index)
	{
		return Chat_message(this, index);
	}
	void replace(size_t index, const char *message)
	{
		return Chat_replace(this, index, message);
	}
};

class Shop {
public:
	bool is_open()
	{
		return Shop_is_open(this);
	}
	bool can_shop()
	{
		return Shop_can_shop(this);
	}
	void switch_item(ItemSlotEnum old_slot, ItemSlotEnum new_slot)
	{
		return Shop_switch_item(this, old_slot, new_slot);
	}
	void buy_item(uint32_t id)
	{
		return Shop_buy_item(this, id);
	}
	void sell_item(ItemSlotEnum slot)
	{
		return Shop_sell_item(this, slot);
	}
	void undo()
	{
		return Shop_undo(this);
	}
};

class Minimap {
public:
	float2 pos()
	{
		float2 out;
		Minimap_pos_Ptr(this, &out);
		return out;
	}
	float2 size()
	{
		float2 out;
		Minimap_size_Ptr(this, &out);
		return out;
	}
	float2 world_bounds()
	{
		float2 out;
		Minimap_world_bounds_Ptr(this, &out);
		return out;
	}
	bool is_on_map(float2 &pos)
	{
		return Minimap_is_on_map_Ptr(this, &pos);
	}
	float2 world_to_map(float3 pos)
	{
		float2 out;
		Minimap_world_to_map_Ptr(this, &pos, &out);
		return out;
	}
};

class Camera {
public:
	float3 pos()
	{
		float3 out;
		Camera_pos_Ptr(this, &out);
		return out;
	}
	float height()
	{
		return Camera_height(this);
	}
	float pitch()
	{
		return Camera_pitch(this);
	}
	float yaw()
	{
		return Camera_yaw(this);
	}
	bool is_locked()
	{
		return Camera_is_locked(this);
	}
	void set_height(float height)
	{
		return Camera_set_height(this, height);
	}
	void set_pitch(float pitch)
	{
		return Camera_set_pitch(this, pitch);
	}
	void set_yaw(float yaw)
	{
		return Camera_set_yaw(this, yaw);
	}
	void set_const(size_t offset, float value)
	{
		return Camera_set_const(this, offset, value);
	}
	void set_lock(bool lock)
	{
		return Camera_set_lock(this, lock);
	}
};

class Options {
public:
	void print()
	{
		return Options_print(this);
	}
	bool find_bool(const char *category, const char *name)
	{
		return Options_find_bool(this, category, name);
	}
	void change_bool(const char *category, const char *name, bool value)
	{
		return Options_change_bool(this, category, name, value);
	}
	uint32_t find_int(const char *category, const char *name)
	{
		return Options_find_int(this, category, name);
	}
	void change_int(const char *category, const char *name, uint32_t value)
	{
		return Options_change_int(this, category, name, value);
	}
	float find_float(const char *category, const char *name)
	{
		return Options_find_float(this, category, name);
	}
	void change_float(const char *category, const char *name, float value)
	{
		return Options_change_float(this, category, name, value);
	}
	int find_key_pair(const char *category, const char *name, char *out)
	{
		return Options_find_key_pair(this, category, name, out);
	}
	void change_key_pair(const char *category, const char *name, const char *key_main, const char *key_alt)
	{
		return Options_change_key_pair(this, category, name, key_main, key_alt);
	}
};

class Graphics {
public:
	bool is_dx9()
	{
		return Graphics_is_dx9(this);
	}
	void* dx9_device()
	{
		return Graphics_dx9_device(this);
	}
	bool is_dx11()
	{
		return Graphics_is_dx11(this);
	}
	void* dx11_device()
	{
		return Graphics_dx11_device(this);
	}
	void* dx11_device_context()
	{
		return Graphics_dx11_device_context(this);
	}
	void* dx11_swap_chain()
	{
		return Graphics_dx11_swap_chain(this);
	}
	float* view_projection_matrix()
	{
		return Graphics_view_projection_matrix(this);
	}
	float screen_width()
	{
		return Graphics_screen_width(this);
	}
	float screen_height()
	{
		return Graphics_screen_height(this);
	}
	float2 screen_size()
	{
		float2 out;
		Graphics_screen_size_Ptr(this, &out);
		return out;
	}
	float2 world_to_screen(float3 &pos)
	{
		float2 out;
		Graphics_world_to_screen_Ptr(this, &pos, &out);
		return out;
	}
	bool is_on_screen_2d(float2 &pos)
	{
		return Graphics_is_on_screen_2d_Ptr(this, &pos);
	}
	bool is_on_screen_3d(float3 &pos)
	{
		return Graphics_is_on_screen_3d_Ptr(this, &pos);
	}
	void draw_line_2d(float2 &from, float2 &to, uint32_t col, float thickness)
	{
		return Graphics_draw_line_2d_Ptr(this, &from, &to, col, thickness);
	}
	void draw_line_3d(float3 &from, float3 &to, uint32_t col, float thickness)
	{
		return Graphics_draw_line_3d_Ptr(this, &from, &to, col, thickness);
	}
	void draw_rectangle_2d(float2 &p_min, float2 &p_max, uint32_t col, float thickness)
	{
		return Graphics_draw_rectangle_2d_Ptr(this, &p_min, &p_max, col, thickness);
	}
	void draw_filled_rectangle_2d(float2 &p_min, float2 &p_max, uint32_t col)
	{
		return Graphics_draw_filled_rectangle_2d_Ptr(this, &p_min, &p_max, col);
	}
	void draw_circle_in_rectangle_2d(float2 &center, float radius, float2 &p_min, float2 &p_max, uint32_t col, size_t num_segments, float thickness)
	{
		return Graphics_draw_circle_in_rectangle_2d_Ptr(this, &center, radius, &p_min, &p_max, col, num_segments, thickness);
	}
	void draw_triangle_2d(float2 &p1, float2 &p2, float2 &p3, uint32_t col, float thickness)
	{
		return Graphics_draw_triangle_2d_Ptr(this, &p1, &p2, &p3, col, thickness);
	}
	void draw_filled_triangle_2d(float2 &p1, float2 &p2, float2 &p3, uint32_t col)
	{
		return Graphics_draw_filled_triangle_2d_Ptr(this, &p1, &p2, &p3, col);
	}
	void draw_triangle_3d(float3 &p1, float3 &p2, float3 &p3, uint32_t col, float thickness)
	{
		return Graphics_draw_triangle_3d_Ptr(this, &p1, &p2, &p3, col, thickness);
	}
	void draw_filled_triangle_3d(float3 &p1, float3 &p2, float3 &p3, uint32_t col)
	{
		return Graphics_draw_filled_triangle_3d_Ptr(this, &p1, &p2, &p3, col);
	}
	void draw_circle_2d(float2 &center, float radius, uint32_t col, size_t num_segments, float thickness)
	{
		return Graphics_draw_circle_2d_Ptr(this, &center, radius, col, num_segments, thickness);
	}
	void draw_filled_circle_2d(float2 &center, float radius, uint32_t col, size_t num_segments)
	{
		return Graphics_draw_filled_circle_2d_Ptr(this, &center, radius, col, num_segments);
	}
	void draw_circle_3d(float3 &center, float radius, uint32_t col, size_t num_segments, float thickness)
	{
		return Graphics_draw_circle_3d_Ptr(this, &center, radius, col, num_segments, thickness);
	}
	void draw_filled_circle_3d(float3 &center, float radius, uint32_t col, size_t num_segments)
	{
		return Graphics_draw_filled_circle_3d_Ptr(this, &center, radius, col, num_segments);
	}
	void draw_polyline_2d(float2 *points, size_t num_points, uint32_t col, float thickness)
	{
		return Graphics_draw_polyline_2d(this, points, num_points, col, thickness);
	}
	void draw_polyline_2d_ex(float2 *points, size_t num_points, uint32_t col, uint32_t flags, float thickness)
	{
		return Graphics_draw_polyline_2d_ex(this, points, num_points, col, flags, thickness);
	}
	void draw_polyline_3d(float3 *points, size_t num_points, uint32_t col, float thickness)
	{
		return Graphics_draw_polyline_3d(this, points, num_points, col, thickness);
	}
	void draw_polyline_3d_ex(float3 *points, size_t num_points, uint32_t col, uint32_t flags, float thickness)
	{
		return Graphics_draw_polyline_3d_ex(this, points, num_points, col, flags, thickness);
	}
	void draw_text_2d(float2& pos, uint32_t col, const char *text)
	{
		return Graphics_draw_text_2d_Ptr(this, &pos, col, text);
	}
	void draw_sized_text_2d(float font_size, float2 &pos, uint32_t col, const char *text)
	{
		return Graphics_draw_sized_text_2d_Ptr(this, font_size, &pos, col, text);
	}
	void draw_text_3d(float3 &pos, uint32_t col, const char *text)
	{
		return Graphics_draw_text_3d_Ptr(this, &pos, col, text);
	}
	void draw_sized_text_3d(float font_size, float3 &pos, uint32_t col, const char *text)
	{
		return Graphics_draw_sized_text_3d_Ptr(this, font_size, &pos, col, text);
	}
	void draw_image_2d(Texture *tex, float2 &pos)
	{
		return Graphics_draw_image_2d_Ptr(this, tex, &pos);
	}
	void draw_image_2d_ex(Texture *tex, float2 &pos, float2 &size, float2 &uv0, float2 &uv1, uint32_t col)
	{
		return Graphics_draw_image_2d_ex_Ptr(this, tex, &pos, &size, &uv0, &uv1, col);
	}
	void draw_image_3d(Texture *tex, float3 &pos)
	{
		return Graphics_draw_image_3d_Ptr(this, tex, &pos);
	}
	void draw_image_3d_ex(Texture *tex, float3 &pos, float2 &size, float2 &uv0, float2 &uv1, uint32_t col)
	{
		return Graphics_draw_image_3d_ex_Ptr(this, tex, &pos, &size, &uv0, &uv1, col);
	}
	Texture* load_image_from_memory(void *data, size_t size)
	{
		return Graphics_load_image_from_memory(this, data, size);
	}
	Texture* load_image_from_file(const char *path)
	{
		return Graphics_load_image_from_file(this, path);
	}
	void push_chinese_font()
	{
		return Graphics_push_chinese_font(this);
	}
	void pop_chinese_font()
	{
		return Graphics_pop_chinese_font(this);
	}
};

class Ini {
public:
	void set_target(const char *target)
	{
		return Ini_set_target(this, target);
	}
	bool get_bool(const char *section, const char *key, bool default_value)
	{
		return Ini_get_bool(this, section, key, default_value);
	}
	long get_long(const char *section, const char *key, long default_value)
	{
		return Ini_get_long(this, section, key, default_value);
	}
	float get_float(const char *section, const char *key, float default_value)
	{
		return Ini_get_float(this, section, key, default_value);
	}
	bool get_string(const char *section, const char *key, const char *default_string, char *returned_string, size_t buf_size)
	{
		return Ini_get_string(this, section, key, default_string, returned_string, buf_size);
	}
	void get_hotkey(const char *section, const char *key, Hotkey *hotkey, long default_key, bool default_is_toggle, bool default_toggle_state)
	{
		return Ini_get_hotkey(this, section, key, hotkey, default_key, default_is_toggle, default_toggle_state);
	}
	bool set_bool(const char *section, const char *key, bool value)
	{
		return Ini_set_bool(this, section, key, value);
	}
	bool set_long(const char *section, const char *key, long value)
	{
		return Ini_set_long(this, section, key, value);
	}
	bool set_float(const char *section, const char *key, float value)
	{
		return Ini_set_float(this, section, key, value);
	}
	bool set_string(const char *section, const char *key, const char *string)
	{
		return Ini_set_string(this, section, key, string);
	}
	bool set_hotkey(const char *section, const char *key, Hotkey *hotkey)
	{
		return Ini_set_hotkey(this, section, key, hotkey);
	}
};

class ObjectManager {
public:
	GameObject* get_object_by_id(uint32_t id)
	{
		return ObjectManager_get_object_by_id(this, id);
	}
	GameObject* get_object_by_index(uint32_t index)
	{
		return ObjectManager_get_object_by_index(this, index);
	}
	GameObject* get_object_by_network_id(uint32_t network_id)
	{
		return ObjectManager_get_object_by_network_id(this, network_id);
	}
	void sort_heroes(vec_hero_t &vec)
	{
		return ObjectManager_sort_heroes_Ptr(this, &vec);
	}
	void sort_heroes_health_percent(vec_hero_t &vec)
	{
		return ObjectManager_sort_heroes_health_percent_Ptr(this, &vec);
	}
	void sort_heroes_health_absolute(vec_hero_t &vec)
	{
		return ObjectManager_sort_heroes_health_absolute_Ptr(this, &vec);
	}
	void sort_heroes_effective_health_magical(vec_hero_t &vec)
	{
		return ObjectManager_sort_heroes_effective_health_magical_Ptr(this, &vec);
	}
	void sort_heroes_effective_health_physical(vec_hero_t &vec)
	{
		return ObjectManager_sort_heroes_effective_health_physical_Ptr(this, &vec);
	}
	void sort_minions(vec_minion_t &vec)
	{
		return ObjectManager_sort_minions_Ptr(this, &vec);
	}
	vec_particle_t particles()
	{
		vec_particle_t out;
		ObjectManager_particles_Ptr(this, &out);
		return out;
	}
	vec_neutral_camp_t neutral_camps()
	{
		vec_neutral_camp_t out;
		ObjectManager_neutral_camps_Ptr(this, &out);
		return out;
	}
	vec_missile_t missiles()
	{
		vec_missile_t out;
		ObjectManager_missiles_Ptr(this, &out);
		return out;
	}
	vec_inhib_t inhibs()
	{
		vec_inhib_t out;
		ObjectManager_inhibs_Ptr(this, &out);
		return out;
	}
	vec_nexus_t nexus()
	{
		vec_nexus_t out;
		ObjectManager_nexus_Ptr(this, &out);
		return out;
	}
	vec_turret_t turrets()
	{
		vec_turret_t out;
		ObjectManager_turrets_Ptr(this, &out);
		return out;
	}
	vec_minion_t minions()
	{
		vec_minion_t out;
		ObjectManager_minions_Ptr(this, &out);
		return out;
	}
	vec_hero_t heroes()
	{
		vec_hero_t out;
		ObjectManager_heroes_Ptr(this, &out);
		return out;
	}
	vec_missile_t allied_missiles()
	{
		vec_missile_t out;
		ObjectManager_allied_missiles_Ptr(this, &out);
		return out;
	}
	vec_missile_t enemy_missiles()
	{
		vec_missile_t out;
		ObjectManager_enemy_missiles_Ptr(this, &out);
		return out;
	}
	vec_missile_t neutral_missiles()
	{
		vec_missile_t out;
		ObjectManager_neutral_missiles_Ptr(this, &out);
		return out;
	}
	vec_inhib_t allied_inhibs()
	{
		vec_inhib_t out;
		ObjectManager_allied_inhibs_Ptr(this, &out);
		return out;
	}
	vec_inhib_t enemy_inhibs()
	{
		vec_inhib_t out;
		ObjectManager_enemy_inhibs_Ptr(this, &out);
		return out;
	}
	vec_inhib_t neutral_inhibs()
	{
		vec_inhib_t out;
		ObjectManager_neutral_inhibs_Ptr(this, &out);
		return out;
	}
	vec_nexus_t allied_nexus()
	{
		vec_nexus_t out;
		ObjectManager_allied_nexus_Ptr(this, &out);
		return out;
	}
	vec_nexus_t enemy_nexus()
	{
		vec_nexus_t out;
		ObjectManager_enemy_nexus_Ptr(this, &out);
		return out;
	}
	vec_nexus_t neutral_nexus()
	{
		vec_nexus_t out;
		ObjectManager_neutral_nexus_Ptr(this, &out);
		return out;
	}
	vec_turret_t allied_turrets()
	{
		vec_turret_t out;
		ObjectManager_allied_turrets_Ptr(this, &out);
		return out;
	}
	vec_turret_t enemy_turrets()
	{
		vec_turret_t out;
		ObjectManager_enemy_turrets_Ptr(this, &out);
		return out;
	}
	vec_turret_t neutral_turrets()
	{
		vec_turret_t out;
		ObjectManager_neutral_turrets_Ptr(this, &out);
		return out;
	}
	vec_turret_t allied_outer_turrets()
	{
		vec_turret_t out;
		ObjectManager_allied_outer_turrets_Ptr(this, &out);
		return out;
	}
	vec_turret_t enemy_outer_turrets()
	{
		vec_turret_t out;
		ObjectManager_enemy_outer_turrets_Ptr(this, &out);
		return out;
	}
	vec_turret_t neutral_outer_turrets()
	{
		vec_turret_t out;
		ObjectManager_neutral_outer_turrets_Ptr(this, &out);
		return out;
	}
	vec_turret_t allied_inner_turrets()
	{
		vec_turret_t out;
		ObjectManager_allied_inner_turrets_Ptr(this, &out);
		return out;
	}
	vec_turret_t enemy_inner_turrets()
	{
		vec_turret_t out;
		ObjectManager_enemy_inner_turrets_Ptr(this, &out);
		return out;
	}
	vec_turret_t neutral_inner_turrets()
	{
		vec_turret_t out;
		ObjectManager_neutral_inner_turrets_Ptr(this, &out);
		return out;
	}
	vec_turret_t allied_inhib_turrets()
	{
		vec_turret_t out;
		ObjectManager_allied_inhib_turrets_Ptr(this, &out);
		return out;
	}
	vec_turret_t enemy_inhib_turrets()
	{
		vec_turret_t out;
		ObjectManager_enemy_inhib_turrets_Ptr(this, &out);
		return out;
	}
	vec_turret_t neutral_inhib_turrets()
	{
		vec_turret_t out;
		ObjectManager_neutral_inhib_turrets_Ptr(this, &out);
		return out;
	}
	vec_turret_t allied_nexus_turrets()
	{
		vec_turret_t out;
		ObjectManager_allied_nexus_turrets_Ptr(this, &out);
		return out;
	}
	vec_turret_t enemy_nexus_turrets()
	{
		vec_turret_t out;
		ObjectManager_enemy_nexus_turrets_Ptr(this, &out);
		return out;
	}
	vec_turret_t neutral_nexus_turrets()
	{
		vec_turret_t out;
		ObjectManager_neutral_nexus_turrets_Ptr(this, &out);
		return out;
	}
	vec_turret_t allied_shrines()
	{
		vec_turret_t out;
		ObjectManager_allied_shrines_Ptr(this, &out);
		return out;
	}
	vec_turret_t enemy_shrines()
	{
		vec_turret_t out;
		ObjectManager_enemy_shrines_Ptr(this, &out);
		return out;
	}
	vec_turret_t neutral_shrines()
	{
		vec_turret_t out;
		ObjectManager_neutral_shrines_Ptr(this, &out);
		return out;
	}
	vec_minion_t allied_minions()
	{
		vec_minion_t out;
		ObjectManager_allied_minions_Ptr(this, &out);
		return out;
	}
	vec_minion_t enemy_minions()
	{
		vec_minion_t out;
		ObjectManager_enemy_minions_Ptr(this, &out);
		return out;
	}
	vec_minion_t neutral_minions()
	{
		vec_minion_t out;
		ObjectManager_neutral_minions_Ptr(this, &out);
		return out;
	}
	vec_minion_t allied_lane_minions()
	{
		vec_minion_t out;
		ObjectManager_allied_lane_minions_Ptr(this, &out);
		return out;
	}
	vec_minion_t enemy_lane_minions()
	{
		vec_minion_t out;
		ObjectManager_enemy_lane_minions_Ptr(this, &out);
		return out;
	}
	vec_minion_t allied_melee_minions()
	{
		vec_minion_t out;
		ObjectManager_allied_melee_minions_Ptr(this, &out);
		return out;
	}
	vec_minion_t enemy_melee_minions()
	{
		vec_minion_t out;
		ObjectManager_enemy_melee_minions_Ptr(this, &out);
		return out;
	}
	vec_minion_t allied_ranged_minions()
	{
		vec_minion_t out;
		ObjectManager_allied_ranged_minions_Ptr(this, &out);
		return out;
	}
	vec_minion_t enemy_ranged_minions()
	{
		vec_minion_t out;
		ObjectManager_enemy_ranged_minions_Ptr(this, &out);
		return out;
	}
	vec_minion_t allied_siege_minions()
	{
		vec_minion_t out;
		ObjectManager_allied_siege_minions_Ptr(this, &out);
		return out;
	}
	vec_minion_t enemy_siege_minions()
	{
		vec_minion_t out;
		ObjectManager_enemy_siege_minions_Ptr(this, &out);
		return out;
	}
	vec_minion_t allied_super_minions()
	{
		vec_minion_t out;
		ObjectManager_allied_super_minions_Ptr(this, &out);
		return out;
	}
	vec_minion_t enemy_super_minions()
	{
		vec_minion_t out;
		ObjectManager_enemy_super_minions_Ptr(this, &out);
		return out;
	}
	vec_minion_t jungle_minions()
	{
		vec_minion_t out;
		ObjectManager_jungle_minions_Ptr(this, &out);
		return out;
	}
	vec_minion_t monsters()
	{
		vec_minion_t out;
		ObjectManager_monsters_Ptr(this, &out);
		return out;
	}
	vec_minion_t camp_monsters()
	{
		vec_minion_t out;
		ObjectManager_camp_monsters_Ptr(this, &out);
		return out;
	}
	vec_minion_t medium_monsters()
	{
		vec_minion_t out;
		ObjectManager_medium_monsters_Ptr(this, &out);
		return out;
	}
	vec_minion_t large_monsters()
	{
		vec_minion_t out;
		ObjectManager_large_monsters_Ptr(this, &out);
		return out;
	}
	vec_minion_t epic_monsters()
	{
		vec_minion_t out;
		ObjectManager_epic_monsters_Ptr(this, &out);
		return out;
	}
	vec_minion_t wolves()
	{
		vec_minion_t out;
		ObjectManager_wolves_Ptr(this, &out);
		return out;
	}
	vec_minion_t gromps()
	{
		vec_minion_t out;
		ObjectManager_gromps_Ptr(this, &out);
		return out;
	}
	vec_minion_t krugs()
	{
		vec_minion_t out;
		ObjectManager_krugs_Ptr(this, &out);
		return out;
	}
	vec_minion_t raptors()
	{
		vec_minion_t out;
		ObjectManager_raptors_Ptr(this, &out);
		return out;
	}
	vec_minion_t buffs()
	{
		vec_minion_t out;
		ObjectManager_buffs_Ptr(this, &out);
		return out;
	}
	vec_minion_t blues()
	{
		vec_minion_t out;
		ObjectManager_blues_Ptr(this, &out);
		return out;
	}
	vec_minion_t reds()
	{
		vec_minion_t out;
		ObjectManager_reds_Ptr(this, &out);
		return out;
	}
	vec_minion_t crabs()
	{
		vec_minion_t out;
		ObjectManager_crabs_Ptr(this, &out);
		return out;
	}
	vec_minion_t dragons()
	{
		vec_minion_t out;
		ObjectManager_dragons_Ptr(this, &out);
		return out;
	}
	vec_minion_t special_void_minions()
	{
		vec_minion_t out;
		ObjectManager_special_void_minions_Ptr(this, &out);
		return out;
	}
	vec_minion_t heralds()
	{
		vec_minion_t out;
		ObjectManager_heralds_Ptr(this, &out);
		return out;
	}
	vec_minion_t barons()
	{
		vec_minion_t out;
		ObjectManager_barons_Ptr(this, &out);
		return out;
	}
	vec_minion_t allied_wards()
	{
		vec_minion_t out;
		ObjectManager_allied_wards_Ptr(this, &out);
		return out;
	}
	vec_minion_t enemy_wards()
	{
		vec_minion_t out;
		ObjectManager_enemy_wards_Ptr(this, &out);
		return out;
	}
	vec_minion_t neutral_wards()
	{
		vec_minion_t out;
		ObjectManager_neutral_wards_Ptr(this, &out);
		return out;
	}
	vec_minion_t allied_special_minions()
	{
		vec_minion_t out;
		ObjectManager_allied_special_minions_Ptr(this, &out);
		return out;
	}
	vec_minion_t enemy_special_minions()
	{
		vec_minion_t out;
		ObjectManager_enemy_special_minions_Ptr(this, &out);
		return out;
	}
	vec_minion_t neutral_special_minions()
	{
		vec_minion_t out;
		ObjectManager_neutral_special_minions_Ptr(this, &out);
		return out;
	}
	vec_minion_t allied_plants()
	{
		vec_minion_t out;
		ObjectManager_allied_plants_Ptr(this, &out);
		return out;
	}
	vec_minion_t enemy_plants()
	{
		vec_minion_t out;
		ObjectManager_enemy_plants_Ptr(this, &out);
		return out;
	}
	vec_minion_t neutral_plants()
	{
		vec_minion_t out;
		ObjectManager_neutral_plants_Ptr(this, &out);
		return out;
	}
	vec_minion_t allied_traps()
	{
		vec_minion_t out;
		ObjectManager_allied_traps_Ptr(this, &out);
		return out;
	}
	vec_minion_t enemy_traps()
	{
		vec_minion_t out;
		ObjectManager_enemy_traps_Ptr(this, &out);
		return out;
	}
	vec_minion_t neutral_traps()
	{
		vec_minion_t out;
		ObjectManager_neutral_traps_Ptr(this, &out);
		return out;
	}
	vec_minion_t allied_summons()
	{
		vec_minion_t out;
		ObjectManager_allied_summons_Ptr(this, &out);
		return out;
	}
	vec_minion_t enemy_summons()
	{
		vec_minion_t out;
		ObjectManager_enemy_summons_Ptr(this, &out);
		return out;
	}
	vec_minion_t neutral_summons()
	{
		vec_minion_t out;
		ObjectManager_neutral_summons_Ptr(this, &out);
		return out;
	}
	vec_minion_t allied_large_summons()
	{
		vec_minion_t out;
		ObjectManager_allied_large_summons_Ptr(this, &out);
		return out;
	}
	vec_minion_t enemy_large_summons()
	{
		vec_minion_t out;
		ObjectManager_enemy_large_summons_Ptr(this, &out);
		return out;
	}
	vec_minion_t neutral_large_summons()
	{
		vec_minion_t out;
		ObjectManager_neutral_large_summons_Ptr(this, &out);
		return out;
	}
	vec_hero_t allied_heroes()
	{
		vec_hero_t out;
		ObjectManager_allied_heroes_Ptr(this, &out);
		return out;
	}
	vec_hero_t enemy_heroes()
	{
		vec_hero_t out;
		ObjectManager_enemy_heroes_Ptr(this, &out);
		return out;
	}
	vec_hero_t neutral_heroes()
	{
		vec_hero_t out;
		ObjectManager_neutral_heroes_Ptr(this, &out);
		return out;
	}
	vec_attackable_unit_t attackable_units()
	{
		vec_attackable_unit_t out;
		ObjectManager_attackable_units_Ptr(this, &out);
		return out;
	}
	vec_attackable_unit_t allied_attackable_units()
	{
		vec_attackable_unit_t out;
		ObjectManager_allied_attackable_units_Ptr(this, &out);
		return out;
	}
	vec_attackable_unit_t enemy_attackable_units()
	{
		vec_attackable_unit_t out;
		ObjectManager_enemy_attackable_units_Ptr(this, &out);
		return out;
	}
	vec_attackable_unit_t neutral_attackable_units()
	{
		vec_attackable_unit_t out;
		ObjectManager_neutral_attackable_units_Ptr(this, &out);
		return out;
	}
	vec_ai_client_t ai_clients()
	{
		vec_ai_client_t out;
		ObjectManager_ai_clients_Ptr(this, &out);
		return out;
	}
	vec_ai_client_t allied_ai_clients()
	{
		vec_ai_client_t out;
		ObjectManager_allied_ai_clients_Ptr(this, &out);
		return out;
	}
	vec_ai_client_t enemy_ai_clients()
	{
		vec_ai_client_t out;
		ObjectManager_enemy_ai_clients_Ptr(this, &out);
		return out;
	}
	vec_ai_client_t neutral_ai_clients()
	{
		vec_ai_client_t out;
		ObjectManager_neutral_ai_clients_Ptr(this, &out);
		return out;
	}
};

class Texture {
public:
	uint32_t memory_address()
	{
		return Texture_memory_address(this);
	}
	void release() 
	{
		return Texture_release(this);
	}
	const char* name()
	{
		return Texture_name(this);
	}
	uint16_t width()
	{
		return Texture_width(this);
	}
	uint16_t height()
	{
		return Texture_height(this);
	}
	float2 size()
	{
		float2 out;
		Texture_size_Ptr(this, &out);
		return out;
	}
	void* tex_id()
	{
		return Texture_tex_id(this);
	}
	bool has_uv()
	{
		return Texture_has_uv(this);
	}
	Rect uv()
	{
		Rect out;
		Texture_uv_Ptr(this, &out);
		return out;
	}
};

class HudElement {
public:
	uint32_t memory_address()
	{
		return HudElement_memory_address(this);
	}
	const char* name()
	{
		return HudElement_name(this);
	}
	HudBase* parent()
	{
		return HudElement_parent(this);
	}
	Rect calc_rect()
	{
		Rect out;
		HudElement_calc_rect_Ptr(this, &out);
		return out;
	}
	bool is_hud_hit_region()
	{
		return HudElement_is_hud_hit_region(this);
	}
	bool is_hud_text()
	{
		return HudElement_is_hud_text(this);
	}
	bool is_hud_texture()
	{
		return HudElement_is_hud_texture(this);
	}
	bool is_hud_group()
	{
		return HudElement_is_hud_group(this);
	}
	bool is_hud_button()
	{
		return HudElement_is_hud_button(this);
	}
};

class HudHitRegion : public HudElement {
public:
	bool is_active()
	{
		return HudHitRegion_is_active(this);
	}
};

class HudText : public HudHitRegion {
public:
	const char* text()
	{
		return HudText_text(this);
	}
};

class HudTexture : public HudHitRegion {
public:
	Texture* texture()
	{
		return HudTexture_texture(this);
	}
	float2 size()
	{
		float2 out;
		HudTexture_size_Ptr(this, &out);
		return out;
	}
	Rect uv()
	{
		Rect out;
		HudTexture_uv_Ptr(this, &out);
		return out;
	}
};

class HudGroup : public HudElement {
public:
	size_t group_index()
	{
		return HudGroup_group_index(this);
	}
};

class HudButton : public HudGroup {
public:
	bool can_trigger()
	{
		return HudButton_can_trigger(this);
	}
	void trigger()
	{
		return HudButton_trigger(this);
	}
	HudHitRegion* hit_region()
	{
		return HudButton_hit_region(this);
	}
};

class HudBase {
public:
	uint32_t memory_address()
	{
		return HudBase_memory_address(this);
	}
	const char* name()
	{
		return HudBase_name(this);
	}
	HudBase* parent()
	{
		return HudBase_parent(this);
	}
	bool is_root()
	{
		return HudBase_is_root(this);
	}
	HudBase* root()
	{
		return HudBase_root(this);
	}
	vec_hud_element_t elements()
	{
		vec_hud_element_t out;
		HudBase_elements_Ptr(this, &out);
		return out;
	}
	vec_hud_base_t children()
	{
		vec_hud_base_t out;
		HudBase_children_Ptr(this, &out);
		return out;
	}
	bool is_active()
	{
		return HudBase_is_active(this);
	}
	bool is_dragged()
	{
		return HudBase_is_dragged(this);
	}
};

class FloatingInfoBar {
public:
	uint32_t memory_address()
	{
		return FloatingInfoBar_memory_address(this);
	}
	HudBase* hud_base()
	{
		return FloatingInfoBar_hud_base(this);
	}
	bool is_rendered()
	{
		return FloatingInfoBar_is_rendered(this);
	}
};

class Buff {
public:
	uint32_t memory_address()
	{
		return Buff_memory_address(this);
	}
	const char* name()
	{
		return Buff_name(this);
	}
	uint32_t fnv_hash()
	{
		return Buff_fnv_hash(this);
	}
	BuffType type()
	{
		return Buff_type(this);
	}
	size_t stacks()
	{
		return Buff_stacks(this);
	}
	size_t stacks2()
	{
		return Buff_stacks2(this);
	}
	float start_time()
	{
		return Buff_start_time(this);
	}
	float end_time()
	{
		return Buff_end_time(this);
	}
	GameObject* owner()
	{
		return Buff_owner(this);
	}
	GameObject* source()
	{
		return Buff_source(this);
	}
};

class SpellDataValue {
public:
	const char* name()
	{
		return SpellDataValue_name(this);
	}
	float* values_array()
	{
		return SpellDataValue_values_array(this);
	}
	size_t values_array_size()
	{
		return SpellDataValue_values_array_size(this);
	}
};

class SpellCalculation {
public:
	uint32_t hash()
	{
		return SpellCalculation_hash(this);
	}
	float result(int level)
	{
		return SpellCalculation_result(this, level);
	}
};

class SpellDataEffectAmount {
public:
	float* values_array()
	{
		return SpellDataEffectAmount_values_array(this);
	}
	size_t values_array_size()
	{
		return SpellDataEffectAmount_values_array_size(this);
	}
};

class SpellDataResource {
public:
	uint32_t memory_address()
	{
		return SpellDataResource_memory_address(this);
	}
	uint32_t flags()
	{
		return SpellDataResource_flags(this);
	}
	uint32_t affects_type_flags()
	{
		return SpellDataResource_affects_type_flags(this);
	}
	uint32_t affects_status_flags()
	{
		return SpellDataResource_affects_status_flags(this);
	}
	float coefficient()
	{
		return SpellDataResource_coefficient(this);
	}
	float coefficient2()
	{
		return SpellDataResource_coefficient2(this);
	}
	float cast_time()
	{
		return SpellDataResource_cast_time(this);
	}
	vec_float_t channel_durations()
	{
		vec_float_t out;
		SpellDataResource_channel_durations_Ptr(this, &out);
		return out;
	}
	vec_float_t cooldown_times()
	{
		vec_float_t out;
		SpellDataResource_cooldown_times_Ptr(this, &out);
		return out;
	}
	float delay_cast_offset_percent()
	{
		return SpellDataResource_delay_cast_offset_percent(this);
	}
	float delay_total_time_percent()
	{
		return SpellDataResource_delay_total_time_percent(this);
	}
	float pre_cast_lockout_delta_time()
	{
		return SpellDataResource_pre_cast_lockout_delta_time(this);
	}
	float post_cast_lockout_delta_time()
	{
		return SpellDataResource_post_cast_lockout_delta_time(this);
	}
	bool is_delayed_by_cast_locked()
	{
		return SpellDataResource_is_delayed_by_cast_locked(this);
	}
	float start_cooldown()
	{
		return SpellDataResource_start_cooldown(this);
	}
	vec_float_t cast_range_growth_max()
	{
		vec_float_t out;
		SpellDataResource_cast_range_growth_max_Ptr(this, &out);
		return out;
	}
	vec_float_t cast_range_growth_start_times()
	{
		vec_float_t out;
		SpellDataResource_cast_range_growth_start_times_Ptr(this, &out);
		return out;
	}
	float charge_update_interval()
	{
		return SpellDataResource_charge_update_interval(this);
	}
	float cancel_charge_on_recast_time()
	{
		return SpellDataResource_cancel_charge_on_recast_time(this);
	}
	vec_int_t max_ammo()
	{
		vec_int_t out;
		SpellDataResource_max_ammo_Ptr(this, &out);
		return out;
	}
	vec_int_t ammo_used()
	{
		vec_int_t out;
		SpellDataResource_ammo_used_Ptr(this, &out);
		return out;
	}
	vec_float_t ammo_recharge_times()
	{
		vec_float_t out;
		SpellDataResource_ammo_recharge_times_Ptr(this, &out);
		return out;
	}
	bool ammo_not_affected_by_cdr()
	{
		return SpellDataResource_ammo_not_affected_by_cdr(this);
	}
	bool cooldown_not_affected_by_cdr()
	{
		return SpellDataResource_cooldown_not_affected_by_cdr(this);
	}
	bool ammo_count_hidden_in_ui()
	{
		return SpellDataResource_ammo_count_hidden_in_ui(this);
	}
	bool cost_always_shown_in_ui()
	{
		return SpellDataResource_cost_always_shown_in_ui(this);
	}
	bool cannot_be_suppressed()
	{
		return SpellDataResource_cannot_be_suppressed(this);
	}
	bool can_cast_while_disabled()
	{
		return SpellDataResource_can_cast_while_disabled(this);
	}
	bool can_trigger_charge_spell_while_disabled()
	{
		return SpellDataResource_can_trigger_charge_spell_while_disabled(this);
	}
	bool can_cast_or_queue_while_casting()
	{
		return SpellDataResource_can_cast_or_queue_while_casting(this);
	}
	bool can_only_cast_while_disabled()
	{
		return SpellDataResource_can_only_cast_while_disabled(this);
	}
	bool cant_cancel_while_winding_up()
	{
		return SpellDataResource_cant_cancel_while_winding_up(this);
	}
	bool cant_cancel_while_channeling()
	{
		return SpellDataResource_cant_cancel_while_channeling(this);
	}
	bool cant_cast_while_rooted()
	{
		return SpellDataResource_cant_cast_while_rooted(this);
	}
	bool channel_is_interrupted_by_disables()
	{
		return SpellDataResource_channel_is_interrupted_by_disables(this);
	}
	bool channel_is_interrupted_by_attacking()
	{
		return SpellDataResource_channel_is_interrupted_by_attacking(this);
	}
	bool apply_attack_damage()
	{
		return SpellDataResource_apply_attack_damage(this);
	}
	bool apply_attack_effect()
	{
		return SpellDataResource_apply_attack_effect(this);
	}
	bool apply_material_on_hit_sound()
	{
		return SpellDataResource_apply_material_on_hit_sound(this);
	}
	bool doesnt_break_channels()
	{
		return SpellDataResource_doesnt_break_channels(this);
	}
	bool belongs_to_avatar()
	{
		return SpellDataResource_belongs_to_avatar(this);
	}
	bool is_disabled_while_dead()
	{
		return SpellDataResource_is_disabled_while_dead(this);
	}
	bool can_only_cast_while_dead()
	{
		return SpellDataResource_can_only_cast_while_dead(this);
	}
	bool cursor_changes_in_grass()
	{
		return SpellDataResource_cursor_changes_in_grass(this);
	}
	bool cursor_changes_in_terrain()
	{
		return SpellDataResource_cursor_changes_in_terrain(this);
	}
	bool project_target_to_cast_range()
	{
		return SpellDataResource_project_target_to_cast_range(this);
	}
	bool spell_reveals_champion()
	{
		return SpellDataResource_spell_reveals_champion(this);
	}
	bool use_minimap_targeting()
	{
		return SpellDataResource_use_minimap_targeting(this);
	}
	bool cast_range_use_bounding_boxes()
	{
		return SpellDataResource_cast_range_use_bounding_boxes(this);
	}
	bool minimap_icon_rotation()
	{
		return SpellDataResource_minimap_icon_rotation(this);
	}
	bool use_charge_channeling()
	{
		return SpellDataResource_use_charge_channeling(this);
	}
	bool can_move_while_channeling()
	{
		return SpellDataResource_can_move_while_channeling(this);
	}
	bool disable_cast_bar()
	{
		return SpellDataResource_disable_cast_bar(this);
	}
	bool show_channel_bar()
	{
		return SpellDataResource_show_channel_bar(this);
	}
	bool always_snap_facing()
	{
		return SpellDataResource_always_snap_facing(this);
	}
	bool use_animator_framerate()
	{
		return SpellDataResource_use_animator_framerate(this);
	}
	bool have_hit_effect()
	{
		return SpellDataResource_have_hit_effect(this);
	}
	bool is_toggle_spell()
	{
		return SpellDataResource_is_toggle_spell(this);
	}
	bool do_not_need_to_face_target()
	{
		return SpellDataResource_do_not_need_to_face_target(this);
	}
	float turn_speed_scalar()
	{
		return SpellDataResource_turn_speed_scalar(this);
	}
	bool no_winddown_if_cancelled()
	{
		return SpellDataResource_no_winddown_if_cancelled(this);
	}
	bool ignore_range_check()
	{
		return SpellDataResource_ignore_range_check(this);
	}
	bool orient_radius_texture_from_player()
	{
		return SpellDataResource_orient_radius_texture_from_player(this);
	}
	bool ignore_anim_continue_until_cast_frame()
	{
		return SpellDataResource_ignore_anim_continue_until_cast_frame(this);
	}
	bool hide_range_indicator_when_casting()
	{
		return SpellDataResource_hide_range_indicator_when_casting(this);
	}
	bool update_rotation_when_casting()
	{
		return SpellDataResource_update_rotation_when_casting(this);
	}
	bool pingable_while_disabled()
	{
		return SpellDataResource_pingable_while_disabled(this);
	}
	bool considered_as_auto_attack()
	{
		return SpellDataResource_considered_as_auto_attack(this);
	}
	bool does_not_consume_mana()
	{
		return SpellDataResource_does_not_consume_mana(this);
	}
	bool does_not_consume_cooldown()
	{
		return SpellDataResource_does_not_consume_cooldown(this);
	}
	bool locked_spell_origination_cast_id()
	{
		return SpellDataResource_locked_spell_origination_cast_id(this);
	}
	uint16_t minimap_icon_display_flag()
	{
		return SpellDataResource_minimap_icon_display_flag(this);
	}
	vec_float_t cast_ranges()
	{
		vec_float_t out;
		SpellDataResource_cast_ranges_Ptr(this, &out);
		return out;
	}
	vec_float_t cast_range_display_overrides()
	{
		vec_float_t out;
		SpellDataResource_cast_range_display_overrides_Ptr(this, &out);
		return out;
	}
	vec_float_t cast_radius()
	{
		vec_float_t out;
		SpellDataResource_cast_radius_Ptr(this, &out);
		return out;
	}
	vec_float_t cast_radius_secondary()
	{
		vec_float_t out;
		SpellDataResource_cast_radius_secondary_Ptr(this, &out);
		return out;
	}
	float cast_cone_angle()
	{
		return SpellDataResource_cast_cone_angle(this);
	}
	float cast_cone_distance()
	{
		return SpellDataResource_cast_cone_distance(this);
	}
	float cast_target_additional_units_radius()
	{
		return SpellDataResource_cast_target_additional_units_radius(this);
	}
	float lua_on_missile_update_distance_interval()
	{
		return SpellDataResource_lua_on_missile_update_distance_interval(this);
	}
	uint32_t cast_type()
	{
		return SpellDataResource_cast_type(this);
	}
	float cast_frame()
	{
		return SpellDataResource_cast_frame(this);
	}
	float missile_speed()
	{
		return SpellDataResource_missile_speed(this);
	}
	uint32_t missile_effect_key()
	{
		return SpellDataResource_missile_effect_key(this);
	}
	uint32_t missile_effect_player_key()
	{
		return SpellDataResource_missile_effect_player_key(this);
	}
	uint32_t missile_effect_enemy_key()
	{
		return SpellDataResource_missile_effect_enemy_key(this);
	}
	float line_width()
	{
		return SpellDataResource_line_width(this);
	}
	float line_drag_length()
	{
		return SpellDataResource_line_drag_length(this);
	}
	uint32_t look_at_policy()
	{
		return SpellDataResource_look_at_policy(this);
	}
	uint32_t hit_effect_orient_type()
	{
		return SpellDataResource_hit_effect_orient_type(this);
	}
	uint32_t hit_effect_key()
	{
		return SpellDataResource_hit_effect_key(this);
	}
	uint32_t hit_effect_player_key()
	{
		return SpellDataResource_hit_effect_player_key(this);
	}
	uint32_t after_effect_key()
	{
		return SpellDataResource_after_effect_key(this);
	}
	bool have_hit_bone()
	{
		return SpellDataResource_have_hit_bone(this);
	}
	int3 particle_start_offset()
	{
		int3 out;
		SpellDataResource_particle_start_offset_Ptr(this, &out);
		return out;
	}
	vec_int_t float_vars_decimals()
	{
		vec_int_t out;
		SpellDataResource_float_vars_decimals_Ptr(this, &out);
		return out;
	}
	vec_float_t mana()
	{
		vec_float_t out;
		SpellDataResource_mana_Ptr(this, &out);
		return out;
	}
	vec_float_t mana_ui_overrides()
	{
		vec_float_t out;
		SpellDataResource_mana_ui_overrides_Ptr(this, &out);
		return out;
	}
	uint32_t selection_priority()
	{
		return SpellDataResource_selection_priority(this);
	}
	float spell_cooldown_or_sealed_queue_threshold()
	{
		return SpellDataResource_spell_cooldown_or_sealed_queue_threshold(this);
	}
	const char* required_unit_tags()
	{
		return SpellDataResource_required_unit_tags(this);
	}
	const char* excluded_unit_tags()
	{
		return SpellDataResource_excluded_unit_tags(this);
	}
	const char* alternate_name()
	{
		return SpellDataResource_alternate_name(this);
	}
	const char* animation_name()
	{
		return SpellDataResource_animation_name(this);
	}
	const char* animation_loop_name()
	{
		return SpellDataResource_animation_loop_name(this);
	}
	const char* animation_winddown_name()
	{
		return SpellDataResource_animation_winddown_name(this);
	}
	const char* animation_lead_out_name()
	{
		return SpellDataResource_animation_lead_out_name(this);
	}
	const char* minimap_icon_name()
	{
		return SpellDataResource_minimap_icon_name(this);
	}
	const char* keyword_when_acquired()
	{
		return SpellDataResource_keyword_when_acquired(this);
	}
	const char* missile_effect_name()
	{
		return SpellDataResource_missile_effect_name(this);
	}
	const char* missile_effect_player_name()
	{
		return SpellDataResource_missile_effect_player_name(this);
	}
	const char* missile_effect_enemy_name()
	{
		return SpellDataResource_missile_effect_enemy_name(this);
	}
	const char* hit_effect_name()
	{
		return SpellDataResource_hit_effect_name(this);
	}
	const char* hit_effect_player_name()
	{
		return SpellDataResource_hit_effect_player_name(this);
	}
	const char* after_effect_name()
	{
		return SpellDataResource_after_effect_name(this);
	}
	const char* hit_bone_name()
	{
		return SpellDataResource_hit_bone_name(this);
	}
	const char* voevent_category()
	{
		return SpellDataResource_voevent_category(this);
	}
	SpellDataEffectAmount* effect_amount_vector(size_t index)
	{
		return SpellDataResource_effect_amount_vector(this, index);
	}
	size_t effect_amount_vector_size()
	{
		return SpellDataResource_effect_amount_vector_size(this);
	}
	SpellDataValue* data_values_vector(size_t index)
	{
		return SpellDataResource_data_values_vector(this, index);
	}
	size_t data_values_vector_size()
	{
		return SpellDataResource_data_values_vector_size(this);
	}
	const char* spell_tags_vector(size_t index)
	{
		return SpellDataResource_spell_tags_vector(this, index);
	}
	size_t spell_tags_vector_size()
	{
		return SpellDataResource_spell_tags_vector_size(this);
	}
};

class SpellSlot {
public:
	uint32_t memory_address()
	{
		return SpellSlot_memory_address(this);
	}
	SpellDataResource* spell_data_resource()
	{
		return SpellSlot_spell_data_resource(this);
	}
	int level()
	{
		return SpellSlot_level(this);
	}
	float cooldown_end()
	{
		return SpellSlot_cooldown_end(this);
	}
	float total_cooldown()
	{
		return SpellSlot_total_cooldown(this);
	}
	uint32_t ammo()
	{
		return SpellSlot_ammo(this);
	}
	float ammo_cooldown_end()
	{
		return SpellSlot_ammo_cooldown_end(this);
	}
	float animation_end()
	{
		return SpellSlot_animation_end(this);
	}
	bool is_in_animation()
	{
		return SpellSlot_is_in_animation(this);
	}
	uint8_t toggle_state()
	{
		return SpellSlot_toggle_state(this);
	}
	const char* name()
	{
		return SpellSlot_name(this);
	}
	uint32_t fnv_hash()
	{
		return SpellSlot_fnv_hash(this);
	}
	uint32_t hash()
	{
		return SpellSlot_hash(this);
	}
	TargetingType targeting_type()
	{
		return SpellSlot_targeting_type(this);
	}
	Texture* icon()
	{
		return SpellSlot_icon(this);
	}
};

class Spell {
public:
	uint32_t memory_address()
	{
		return Spell_memory_address(this);
	}
	SpellDataResource* spell_data_resource()
	{
		return Spell_spell_data_resource(this);
	}
	float3 start_pos()
	{
		float3 out;
		Spell_start_pos_Ptr(this, &out);
		return out;
	}
	float3 end_pos()
	{
		float3 out;
		Spell_end_pos_Ptr(this, &out);
		return out;
	}
	float3 end_pos_line()
	{
		float3 out;
		Spell_end_pos_line_Ptr(this, &out);
		return out;
	}
	bool has_target()
	{
		return Spell_has_target(this);
	}
	float wind_up_time()
	{
		return Spell_wind_up_time(this);
	}
	float animation_time()
	{
		return Spell_animation_time(this);
	}
	SpellSlotEnum slot()
	{
		return Spell_slot(this);
	}
	bool is_basic_attack()
	{
		return Spell_is_basic_attack(this);
	}
	const char* name()
	{
		return Spell_name(this);
	}
	uint32_t hash()
	{
		return Spell_hash(this);
	}
	GameObject* source()
	{
		return Spell_source(this);
	}
	GameObject* target()
	{
		return Spell_target(this);
	}
};

class AttackSlotData {
public:
	uint32_t memory_address()
	{
		return AttackSlotData_memory_address(this);
	}
	float attack_total_time()
	{
		return AttackSlotData_attack_total_time(this);
	}
	float attack_cast_time()
	{
		return AttackSlotData_attack_cast_time(this);
	}
	float attack_delay_cast_offset_percent()
	{
		return AttackSlotData_attack_delay_cast_offset_percent(this);
	}
	float attack_delay_cast_offset_percent_attack_speed_ratio()
	{
		return AttackSlotData_attack_delay_cast_offset_percent_attack_speed_ratio(this);
	}
	float attack_probability()
	{
		return AttackSlotData_attack_probability(this);
	}
	const char* attack_name()
	{
		return AttackSlotData_attack_name(this);
	}
};

class CharacterData {
public:
	uint32_t memory_address()
	{
		return CharacterData_memory_address(this);
	}
	const char* model()
	{
		return CharacterData_model(this);
	}
	int skin_id()
	{
		return CharacterData_skin_id(this);
	}
	const char* skin_name()
	{
		return CharacterData_skin_name(this);
	}
	CharacterRecord* record()
	{
		return CharacterData_record(this);
	}
};

class CharacterRecord {
public:
	uint32_t memory_address()
	{
		return CharacterRecord_memory_address(this);
	}
	const char* character_name()
	{
		return CharacterRecord_character_name(this);
	}
	const char* fallback_character_name()
	{
		return CharacterRecord_fallback_character_name(this);
	}
	float base_hp()
	{
		return CharacterRecord_base_hp(this);
	}
	float hp_per_level()
	{
		return CharacterRecord_hp_per_level(this);
	}
	float base_static_hp_regen()
	{
		return CharacterRecord_base_static_hp_regen(this);
	}
	float base_factor_hp_regen()
	{
		return CharacterRecord_base_factor_hp_regen(this);
	}
	float health_bar_height()
	{
		return CharacterRecord_health_bar_height(this);
	}
	bool health_bar_full_parallax()
	{
		return CharacterRecord_health_bar_full_parallax(this);
	}
	const char* self_champ_specific_health_suffix()
	{
		return CharacterRecord_self_champ_specific_health_suffix(this);
	}
	const char* self_cb_champ_specific_health_suffix()
	{
		return CharacterRecord_self_cb_champ_specific_health_suffix(this);
	}
	const char* ally_champ_specific_health_suffix()
	{
		return CharacterRecord_ally_champ_specific_health_suffix(this);
	}
	const char* enemy_champ_specific_health_suffix()
	{
		return CharacterRecord_enemy_champ_specific_health_suffix(this);
	}
	bool highlight_healthbar_icons()
	{
		return CharacterRecord_highlight_healthbar_icons(this);
	}
	float base_damage()
	{
		return CharacterRecord_base_damage(this);
	}
	float damage_per_level()
	{
		return CharacterRecord_damage_per_level(this);
	}
	float base_armor()
	{
		return CharacterRecord_base_armor(this);
	}
	float armor_per_level()
	{
		return CharacterRecord_armor_per_level(this);
	}
	float base_spell_block()
	{
		return CharacterRecord_base_spell_block(this);
	}
	float base_dodge()
	{
		return CharacterRecord_base_dodge(this);
	}
	float dodge_per_level()
	{
		return CharacterRecord_dodge_per_level(this);
	}
	float base_miss_chance()
	{
		return CharacterRecord_base_miss_chance(this);
	}
	float base_crit_chance()
	{
		return CharacterRecord_base_crit_chance(this);
	}
	float crit_damage_multiplier()
	{
		return CharacterRecord_crit_damage_multiplier(this);
	}
	float crit_per_level()
	{
		return CharacterRecord_crit_per_level(this);
	}
	float base_move_speed()
	{
		return CharacterRecord_base_move_speed(this);
	}
	float attack_range()
	{
		return CharacterRecord_attack_range(this);
	}
	float attack_speed()
	{
		return CharacterRecord_attack_speed(this);
	}
	float attack_speed_ratio()
	{
		return CharacterRecord_attack_speed_ratio(this);
	}
	float attack_speed_per_level()
	{
		return CharacterRecord_attack_speed_per_level(this);
	}
	float ability_power_inc_per_level()
	{
		return CharacterRecord_ability_power_inc_per_level(this);
	}
	float adaptive_force_to_ability_power_weight()
	{
		return CharacterRecord_adaptive_force_to_ability_power_weight(this);
	}
	AttackSlotData* basic_attack()
	{
		return CharacterRecord_basic_attack(this);
	}
	vec_attack_slot_data_t extra_attacks()
	{
		vec_attack_slot_data_t out;
		CharacterRecord_extra_attacks_Ptr(this, &out);
		return out;
	}
	vec_attack_slot_data_t crit_attacks()
	{
		vec_attack_slot_data_t out;
		CharacterRecord_crit_attacks_Ptr(this, &out);
		return out;
	}
	float attack_auto_interrupt_percent()
	{
		return CharacterRecord_attack_auto_interrupt_percent(this);
	}
	float acquisition_range()
	{
		return CharacterRecord_acquisition_range(this);
	}
	float wake_up_range()
	{
		return CharacterRecord_wake_up_range(this);
	}
	float first_acquisition_range()
	{
		return CharacterRecord_first_acquisition_range(this);
	}
	float tower_targeting_priority_boost()
	{
		return CharacterRecord_tower_targeting_priority_boost(this);
	}
	float exp_given_on_death()
	{
		return CharacterRecord_exp_given_on_death(this);
	}
	float gold_given_on_death()
	{
		return CharacterRecord_gold_given_on_death(this);
	}
	float gold_radius()
	{
		return CharacterRecord_gold_radius(this);
	}
	float experience_radius()
	{
		return CharacterRecord_experience_radius(this);
	}
	float death_event_listening_radius()
	{
		return CharacterRecord_death_event_listening_radius(this);
	}
	float local_gold_given_on_death()
	{
		return CharacterRecord_local_gold_given_on_death(this);
	}
	float local_exp_given_on_death()
	{
		return CharacterRecord_local_exp_given_on_death(this);
	}
	bool local_gold_split_with_last_hitter()
	{
		return CharacterRecord_local_gold_split_with_last_hitter(this);
	}
	float global_gold_given_on_death()
	{
		return CharacterRecord_global_gold_given_on_death(this);
	}
	float global_exp_given_on_death()
	{
		return CharacterRecord_global_exp_given_on_death(this);
	}
	float perception_bubble_radius()
	{
		return CharacterRecord_perception_bubble_radius(this);
	}
	float3 perception_bounding_box_size()
	{
		float3 out;
		CharacterRecord_perception_bounding_box_size_Ptr(this, &out);
		return out;
	}
	float significance()
	{
		return CharacterRecord_significance(this);
	}
	float untargetable_spawn_time()
	{
		return CharacterRecord_untargetable_spawn_time(this);
	}
	float ability_power()
	{
		return CharacterRecord_ability_power(this);
	}
	uint32_t on_kill_event()
	{
		return CharacterRecord_on_kill_event(this);
	}
	uint32_t on_kill_event_steal()
	{
		return CharacterRecord_on_kill_event_steal(this);
	}
	uint32_t on_kill_event_for_spectator()
	{
		return CharacterRecord_on_kill_event_for_spectator(this);
	}
	const char* critical_attack()
	{
		return CharacterRecord_critical_attack(this);
	}
	const char* passive_name()
	{
		return CharacterRecord_passive_name(this);
	}
	const char* passive_lua_name()
	{
		return CharacterRecord_passive_lua_name(this);
	}
	const char* passive_tool_tip()
	{
		return CharacterRecord_passive_tool_tip(this);
	}
	const char* passive_spell()
	{
		return CharacterRecord_passive_spell(this);
	}
	float passive_range()
	{
		return CharacterRecord_passive_range(this);
	}
	const char* icon_name()
	{
		return CharacterRecord_icon_name(this);
	}
	const char* friendly_tooltip()
	{
		return CharacterRecord_friendly_tooltip(this);
	}
	const char* name()
	{
		return CharacterRecord_name(this);
	}
	const char* par_name()
	{
		return CharacterRecord_par_name(this);
	}
	const char* hover_indicator_texture_name()
	{
		return CharacterRecord_hover_indicator_texture_name(this);
	}
	float hover_indicator_radius()
	{
		return CharacterRecord_hover_indicator_radius(this);
	}
	const char* hover_line_indicator_base_texture_name()
	{
		return CharacterRecord_hover_line_indicator_base_texture_name(this);
	}
	const char* hover_line_indicator_target_texture_name()
	{
		return CharacterRecord_hover_line_indicator_target_texture_name(this);
	}
	float hover_indicator_width()
	{
		return CharacterRecord_hover_indicator_width(this);
	}
	bool hover_indicator_rotate_to_player()
	{
		return CharacterRecord_hover_indicator_rotate_to_player(this);
	}
	const char* hover_indicator_minimap_override()
	{
		return CharacterRecord_hover_indicator_minimap_override(this);
	}
	const char* minimap_icon_override()
	{
		return CharacterRecord_minimap_icon_override(this);
	}
	float hover_indicator_radius_minimap()
	{
		return CharacterRecord_hover_indicator_radius_minimap(this);
	}
	float hover_line_indicator_width_minimap()
	{
		return CharacterRecord_hover_line_indicator_width_minimap(this);
	}
	float area_indicator_radius()
	{
		return CharacterRecord_area_indicator_radius(this);
	}
	float area_indicator_min_radius()
	{
		return CharacterRecord_area_indicator_min_radius(this);
	}
	float area_indicator_max_distsance()
	{
		return CharacterRecord_area_indicator_max_distsance(this);
	}
	float area_indicator_target_distsance()
	{
		return CharacterRecord_area_indicator_target_distsance(this);
	}
	float area_indicator_min_distsance()
	{
		return CharacterRecord_area_indicator_min_distsance(this);
	}
	const char* area_indicator_texture_name()
	{
		return CharacterRecord_area_indicator_texture_name(this);
	}
	float area_indicator_texture_size()
	{
		return CharacterRecord_area_indicator_texture_size(this);
	}
	const char* char_audio_name_override()
	{
		return CharacterRecord_char_audio_name_override(this);
	}
	bool use_cc_animations()
	{
		return CharacterRecord_use_cc_animations(this);
	}
	const char* joint_for_anim_adjusted_selection()
	{
		return CharacterRecord_joint_for_anim_adjusted_selection(this);
	}
	float outline_bbox_expansion()
	{
		return CharacterRecord_outline_bbox_expansion(this);
	}
	const char* silhouette_attachment_anim()
	{
		return CharacterRecord_silhouette_attachment_anim(this);
	}
	float hit_fx_scale()
	{
		return CharacterRecord_hit_fx_scale(this);
	}
	float selection_radius()
	{
		return CharacterRecord_selection_radius(this);
	}
	float selection_height()
	{
		return CharacterRecord_selection_height(this);
	}
	float pathfinding_collision_radius()
	{
		return CharacterRecord_pathfinding_collision_radius(this);
	}
	float override_gameplay_collision_radius()
	{
		return CharacterRecord_override_gameplay_collision_radius(this);
	}
	const char* unit_tags_string()
	{
		return CharacterRecord_unit_tags_string(this);
	}
	uint32_t friendly_ux_override_team()
	{
		return CharacterRecord_friendly_ux_override_team(this);
	}
	const char* friendly_ux_override_include_tags_string()
	{
		return CharacterRecord_friendly_ux_override_include_tags_string(this);
	}
	const char* friendly_ux_override_exclude_tags_string()
	{
		return CharacterRecord_friendly_ux_override_exclude_tags_string(this);
	}
	bool platform_enabled()
	{
		return CharacterRecord_platform_enabled(this);
	}
	bool record_as_ward()
	{
		return CharacterRecord_record_as_ward(this);
	}
	float minion_score_value()
	{
		return CharacterRecord_minion_score_value(this);
	}
	bool use_riot_relationships()
	{
		return CharacterRecord_use_riot_relationships(this);
	}
	uint32_t flags()
	{
		return CharacterRecord_flags(this);
	}
	uint32_t minion_flags()
	{
		return CharacterRecord_minion_flags(this);
	}
	float death_time()
	{
		return CharacterRecord_death_time(this);
	}
	float occluded_unit_selectable_distance()
	{
		return CharacterRecord_occluded_unit_selectable_distance(this);
	}
	float moving_toward_enemy_activation_angle()
	{
		return CharacterRecord_moving_toward_enemy_activation_angle(this);
	}
	vec_string_t spell_names()
	{
		vec_string_t out;
		CharacterRecord_spell_names_Ptr(this, &out);
		return out;
	}
	vec_string_t extra_spells()
	{
		vec_string_t out;
		CharacterRecord_extra_spells_Ptr(this, &out);
		return out;
	}
};

class Path {
public:
	uint32_t memory_address()
	{
		return Path_memory_address(this);
	}
	float3 end_pos()
	{
		float3 out;
		Path_end_pos_Ptr(this, &out);
		return out;
	}
	float3 pos()
	{
		float3 out;
		Path_pos_Ptr(this, &out);
		return out;
	}
	float3 velocity()
	{
		float3 out;
		Path_velocity_Ptr(this, &out);
		return out;
	}
	bool is_active()
	{
		return Path_is_active(this);
	}
	bool is_dashing()
	{
		return Path_is_dashing(this);
	}
	float dash_speed()
	{
		return Path_dash_speed(this);
	}
	float move_speed()
	{
		return Path_move_speed(this);
	}
	float speed()
	{
		return Path_speed(this);
	}
	size_t index()
	{
		return Path_index(this);
	}
	vec_float3_t waypoints()
	{
		vec_float3_t out;
		Path_waypoints_Ptr(this, &out);
		return out;
	}
	GameObject* source()
	{
		return Path_source(this);
	}
};

class Rune {
public:
	uint32_t memory_address()
	{
		return Rune_memory_address(this);
	}
	int id()
	{
		return Rune_id(this);
	}
	const char* name()
	{
		return Rune_name(this);
	}
	uint32_t fnv_hash()
	{
		return Rune_fnv_hash(this);
	}
	Texture* icon()
	{
		return Rune_icon(this);
	}
};

class ItemSlot {
public:
	uint32_t memory_address()
	{
		return ItemSlot_memory_address(this);
	}
	uint8_t stacks()
	{
		return ItemSlot_stacks(this);
	}
	uint8_t max_stacks()
	{
		return ItemSlot_max_stacks(this);
	}
	uint8_t spell_stacks()
	{
		return ItemSlot_spell_stacks(this);
	}
	float purchase_time()
	{
		return ItemSlot_purchase_time(this);
	}
	int id()
	{
		return ItemSlot_id(this);
	}
	int cost()
	{
		return ItemSlot_cost(this);
	}
	const char* name()
	{
		return ItemSlot_name(this);
	}
	Texture* icon()
	{
		return ItemSlot_icon(this);
	}
};

class GameObject {
public:
	uint32_t memory_address()
	{
		return GameObject_memory_address(this);
	}
	uint32_t id()
	{
		return GameObject_id(this);
	}
	uint32_t index()
	{
		return GameObject_index(this);
	}
	GameObjectType type()
	{
		return GameObject_type(this);
	}
	GameObjectTeam team()
	{
		return GameObject_team(this);
	}
	const char* name()
	{
		return GameObject_name(this);
	}
	bool is_on_screen()
	{
		return GameObject_is_on_screen(this);
	}
	uint32_t network_id()
	{
		return GameObject_network_id(this);
	}
	float3 pos()
	{
		float3 out;
		GameObject_pos_Ptr(this, &out);
		return out;
	}
	bool is_zombie()
	{
		return GameObject_is_zombie(this);
	}
	bool is_ally()
	{
		return GameObject_is_ally(this);
	}
	bool is_enemy()
	{
		return GameObject_is_enemy(this);
	}
	bool is_neutral()
	{
		return GameObject_is_neutral(this);
	}
	bool is_player()
	{
		return GameObject_is_player(this);
	}
	bool is_hero()
	{
		return GameObject_is_hero(this);
	}
	bool is_minion()
	{
		return GameObject_is_minion(this);
	}
	bool is_turret()
	{
		return GameObject_is_turret(this);
	}
	bool is_inhib()
	{
		return GameObject_is_inhib(this);
	}
	bool is_nexus()
	{
		return GameObject_is_nexus(this);
	}
	bool is_missile()
	{
		return GameObject_is_missile(this);
	}
	bool is_particle()
	{
		return GameObject_is_particle(this);
	}
	bool is_neutral_camp()
	{
		return GameObject_is_neutral_camp(this);
	}
	bool is_attackable_unit()
	{
		return GameObject_is_attackable_unit(this);
	}
	bool is_ai_client()
	{
		return GameObject_is_ai_client(this);
	}
	GameObject* as_game_object()
	{
		return (GameObject*)this;
	}
	Particle* as_particle()
	{
		return (Particle*)this;
	}
	NeutralCamp* as_neutral_camp()
	{
		return (NeutralCamp*)this;
	}
	Missile* as_missile()
	{
		return (Missile*)this;
	}
	Inhib* as_inhib()
	{
		return (Inhib*)this;
	}
	Nexus* as_nexus()
	{
		return (Nexus*)this;
	}
	Turret* as_turret()
	{
		return (Turret*)this;
	}
	Minion* as_minion()
	{
		return (Minion*)this;
	}
	Hero* as_hero()
	{
		return (Hero*)this;
	}
	Player* as_player()
	{
		return (Player*)this;
	}
	AttackableUnit* as_attackable_unit()
	{
		return (AttackableUnit*)this;
	}
	AIClient* as_ai_client()
	{
		return (AIClient*)this;
	}
};

class AttackableUnit : public GameObject {
public:
	float base_collision_radius()
	{
		return AttackableUnit_base_collision_radius(this);
	}
	bool is_visible()
	{
		return AttackableUnit_is_visible(this);
	}
	float death_time()
	{
		return AttackableUnit_death_time(this);
	}
	bool is_dead()
	{
		return AttackableUnit_is_dead(this);
	}
	float health()
	{
		return AttackableUnit_health(this);
	}
	float max_health()
	{
		return AttackableUnit_max_health(this);
	}
	float health_max_penalty()
	{
		return AttackableUnit_health_max_penalty(this);
	}
	float all_shield()
	{
		return AttackableUnit_all_shield(this);
	}
	float physical_shield()
	{
		return AttackableUnit_physical_shield(this);
	}
	float magical_shield()
	{
		return AttackableUnit_magical_shield(this);
	}
	float champ_specific_health()
	{
		return AttackableUnit_champ_specific_health(this);
	}
	float incoming_healing_enemy()
	{
		return AttackableUnit_incoming_healing_enemy(this);
	}
	float incoming_healing_allied()
	{
		return AttackableUnit_incoming_healing_allied(this);
	}
	float stop_shield_fade()
	{
		return AttackableUnit_stop_shield_fade(this);
	}
	bool is_targetable()
	{
		return AttackableUnit_is_targetable(this);
	}
	float mana()
	{
		return AttackableUnit_mana(this);
	}
	float max_mana()
	{
		return AttackableUnit_max_mana(this);
	}
	float par()
	{
		return AttackableUnit_par(this);
	}
	float max_par()
	{
		return AttackableUnit_max_par(this);
	}
	uint32_t par_state()
	{
		return AttackableUnit_par_state(this);
	}
	float sar()
	{
		return AttackableUnit_sar(this);
	}
	float max_sar()
	{
		return AttackableUnit_max_sar(this);
	}
	bool sar_enabled()
	{
		return AttackableUnit_sar_enabled(this);
	}
	uint32_t sar_state()
	{
		return AttackableUnit_sar_state(this);
	}
};

class AIClient : public AttackableUnit {
public:
	CharacterData* base_character_data()
	{
		return AIClient_base_character_data(this);
	}
	CharacterData* character_data()
	{
		return AIClient_character_data(this);
	}
	CharacterRecord* character_record()
	{
		return AIClient_character_record(this);
	}
	void set_character_model(const char *model, int skin_id)
	{
		return AIClient_set_character_model(this, model, skin_id);
	}
	vec_spell_calculation_t spell_calculations(SpellSlotEnum slot)
	{
		vec_spell_calculation_t out;
		AIClient_spell_calculations_Ptr(this, slot, &out);
		return out;
	}
	SpellCalculation* find_spell_calculation_by_hash(SpellSlotEnum slot, uint32_t hash)
	{
		return AIClient_find_spell_calculation_by_hash(this, slot, hash);
	}
	float calc_attack_cast_delay()
	{
		return AIClient_calc_attack_cast_delay(this);
	}
	float calc_attack_delay()
	{
		return AIClient_calc_attack_delay(this);
	}
	Texture* icon_square()
	{
		return AIClient_icon_square(this);
	}
	Texture* icon_circle()
	{
		return AIClient_icon_circle(this);
	}
	bool has_bar_pos()
	{
		return AIClient_has_bar_pos(this);
	}
	float2 bar_pos()
	{
		float2 out;
		AIClient_bar_pos_Ptr(this, &out);
		return out;
	}
	vec_floating_info_bar_t floating_info_bars()
	{
		vec_floating_info_bar_t out;
		AIClient_floating_info_bars_Ptr(this, &out);
		return out;
	}
	float collision_radius()
	{
		return AIClient_collision_radius(this);
	}
	vec_buff_t buffs()
	{
		vec_buff_t out;
		AIClient_buffs_Ptr(this, &out);
		return out;
	}
	Buff* find_buff(BuffType type)
	{
		return AIClient_find_buff(this, type);
	}
	Buff* find_buff_by_name(const char *name)
	{
		return AIClient_find_buff_by_name(this, name);
	}
	Buff* find_buff_by_hash(uint32_t fnv_hash)
	{
		return AIClient_find_buff_by_hash(this, fnv_hash);
	}
	Spell* active_spell()
	{
		return AIClient_active_spell(this);
	}
	SpellSlot* spell_slot(SpellSlotEnum slot)
	{
		return AIClient_spell_slot(this, slot);
	}
	vec_spell_t basic_attacks()
	{
		vec_spell_t out;
		AIClient_basic_attacks_Ptr(this, &out);
		return out;
	}
	Path* path()
	{
		return AIClient_path(this);
	}
	const char* char_name()
	{
		return AIClient_char_name(this);
	}
	uint32_t char_name_fnv_hash()
	{
		return AIClient_char_name_fnv_hash(this);
	}
	float3 direction()
	{
		float3 out;
		AIClient_direction_Ptr(this, &out);
		return out;
	}
	uint32_t action_state()
	{
		return AIClient_action_state(this);
	}
	uint32_t action_state2()
	{
		return AIClient_action_state2(this);
	}
	CombatType combat_type()
	{
		return AIClient_combat_type(this);
	}
	bool is_melee()
	{
		return AIClient_is_melee(this);
	}
	bool is_ranged()
	{
		return AIClient_is_ranged(this);
	}
	float base_attack_damage()
	{
		return AIClient_base_attack_damage(this);
	}
	float armor()
	{
		return AIClient_armor(this);
	}
	float spell_block()
	{
		return AIClient_spell_block(this);
	}
	float attack_speed_mod()
	{
		return AIClient_attack_speed_mod(this);
	}
	float flat_physical_damage_mod()
	{
		return AIClient_flat_physical_damage_mod(this);
	}
	float percent_physical_damage_mod()
	{
		return AIClient_percent_physical_damage_mod(this);
	}
	float flat_magic_damage_mod()
	{
		return AIClient_flat_magic_damage_mod(this);
	}
	float percent_magic_damage_mod()
	{
		return AIClient_percent_magic_damage_mod(this);
	}
	float health_regen_rate()
	{
		return AIClient_health_regen_rate(this);
	}
	float primary_ar_regen_rate_rep()
	{
		return AIClient_primary_ar_regen_rate_rep(this);
	}
	float flat_magic_reduction()
	{
		return AIClient_flat_magic_reduction(this);
	}
	float percent_magic_reduction()
	{
		return AIClient_percent_magic_reduction(this);
	}
	float percent_bonus_armor_penetration()
	{
		return AIClient_percent_bonus_armor_penetration(this);
	}
	float percent_crit_bonus_armor_penetration()
	{
		return AIClient_percent_crit_bonus_armor_penetration(this);
	}
	float percent_crit_total_armor_penetration()
	{
		return AIClient_percent_crit_total_armor_penetration(this);
	}
	float percent_bonus_magic_penetration()
	{
		return AIClient_percent_bonus_magic_penetration(this);
	}
	float physical_lethality()
	{
		return AIClient_physical_lethality(this);
	}
	float magic_lethality()
	{
		return AIClient_magic_lethality(this);
	}
	float base_health_regen_rate()
	{
		return AIClient_base_health_regen_rate(this);
	}
	float primary_ar_base_regen_rate_rep()
	{
		return AIClient_primary_ar_base_regen_rate_rep(this);
	}
	float secondary_ar_regen_rate_rep()
	{
		return AIClient_secondary_ar_regen_rate_rep(this);
	}
	float secondary_ar_base_regen_rate_rep()
	{
		return AIClient_secondary_ar_base_regen_rate_rep(this);
	}
	float percent_cooldown_cap_mod()
	{
		return AIClient_percent_cooldown_cap_mod(this);
	}
	float percent_cc_reduction()
	{
		return AIClient_percent_cc_reduction(this);
	}
	float percent_exp_bonus()
	{
		return AIClient_percent_exp_bonus(this);
	}
	float flat_base_attack_damage_mod()
	{
		return AIClient_flat_base_attack_damage_mod(this);
	}
	float percent_base_attack_damage_mod()
	{
		return AIClient_percent_base_attack_damage_mod(this);
	}
	float base_attack_damage_sans_percent_scale()
	{
		return AIClient_base_attack_damage_sans_percent_scale(this);
	}
	float bonus_armor()
	{
		return AIClient_bonus_armor(this);
	}
	float bonus_spell_block()
	{
		return AIClient_bonus_spell_block(this);
	}
	float percent_bonus_physical_damage_mod()
	{
		return AIClient_percent_bonus_physical_damage_mod(this);
	}
	float percent_base_physical_damage_as_flat_bonus()
	{
		return AIClient_percent_base_physical_damage_as_flat_bonus(this);
	}
	float percent_attack_speed_mod()
	{
		return AIClient_percent_attack_speed_mod(this);
	}
	float percent_multiplicative_attack_speed_mod()
	{
		return AIClient_percent_multiplicative_attack_speed_mod(this);
	}
	float crit_damage_multiplier()
	{
		return AIClient_crit_damage_multiplier(this);
	}
	float ability_haste_mod()
	{
		return AIClient_ability_haste_mod(this);
	}
	float flat_bubble_radius_mod()
	{
		return AIClient_flat_bubble_radius_mod(this);
	}
	float percent_bubble_radius_mod()
	{
		return AIClient_percent_bubble_radius_mod(this);
	}
	float move_speed()
	{
		return AIClient_move_speed(this);
	}
	float move_speed_base_increase()
	{
		return AIClient_move_speed_base_increase(this);
	}
	float scale_skin_coef()
	{
		return AIClient_scale_skin_coef(this);
	}
	float pathfinding_radius_mod()
	{
		return AIClient_pathfinding_radius_mod(this);
	}
	float base_ability_damage()
	{
		return AIClient_base_ability_damage(this);
	}
	float crit()
	{
		return AIClient_crit(this);
	}
	float par_regen_rate()
	{
		return AIClient_par_regen_rate(this);
	}
	float attack_range()
	{
		return AIClient_attack_range(this);
	}
	float flat_cast_range_mod()
	{
		return AIClient_flat_cast_range_mod(this);
	}
	float percent_cooldown_mod()
	{
		return AIClient_percent_cooldown_mod(this);
	}
	float passive_cooldown_end_time()
	{
		return AIClient_passive_cooldown_end_time(this);
	}
	float passive_cooldown_total_time()
	{
		return AIClient_passive_cooldown_total_time(this);
	}
	float flat_armor_penetration()
	{
		return AIClient_flat_armor_penetration(this);
	}
	float percent_armor_penetration()
	{
		return AIClient_percent_armor_penetration(this);
	}
	float flat_magic_penetration()
	{
		return AIClient_flat_magic_penetration(this);
	}
	float percent_magic_penetration()
	{
		return AIClient_percent_magic_penetration(this);
	}
	float percent_life_steal_mod()
	{
		return AIClient_percent_life_steal_mod(this);
	}
	float percent_spell_vamp_mod()
	{
		return AIClient_percent_spell_vamp_mod(this);
	}
	float physical_damage_percent_modifier()
	{
		return AIClient_physical_damage_percent_modifier(this);
	}
	float magical_damage_percent_modifier()
	{
		return AIClient_magical_damage_percent_modifier(this);
	}
	float percent_damage_to_barracks_minion_mod()
	{
		return AIClient_percent_damage_to_barracks_minion_mod(this);
	}
	float flat_damage_reduction_from_barracks_minion_mod()
	{
		return AIClient_flat_damage_reduction_from_barracks_minion_mod(this);
	}
	float base_health()
	{
		return AIClient_base_health(this);
	}
	float base_health_per_level()
	{
		return AIClient_base_health_per_level(this);
	}
	float base_mana()
	{
		return AIClient_base_mana(this);
	}
	float base_mana_per_level()
	{
		return AIClient_base_mana_per_level(this);
	}
	float base_move_speed()
	{
		return AIClient_base_move_speed(this);
	}
};

class Particle : public GameObject {
public:
	float visibility_radius()
	{
		return Particle_visibility_radius(this);
	}
	float3 orientation()
	{
		float3 out;
		Particle_orientation_Ptr(this, &out);
		return out;
	}
	GameObject* attachment_object()
	{
		return Particle_attachment_object(this);
	}
	GameObject* target_attachment_object()
	{
		return Particle_target_attachment_object(this);
	}
};

class NeutralCamp : public GameObject {
public:
	uint32_t camp_id()
	{
		return NeutralCamp_camp_id(this);
	}
	const char* camp_type()
	{
		return NeutralCamp_camp_type(this);
	}
	uint32_t camp_team()
	{
		return NeutralCamp_camp_team(this);
	}
	vec_game_object_t objects()
	{
		vec_game_object_t out;
		NeutralCamp_objects_Ptr(this, &out);
		return out;
	}
	uint32_t fnv_hash()
	{
		return NeutralCamp_fnv_hash(this);
	}
	bool is_alive()
	{
		return NeutralCamp_is_alive(this);
	}
	float spawn_time()
	{
		return NeutralCamp_spawn_time(this);
	}
};

class Inhib : public AttackableUnit {
public:
	float respawn_timer()
	{
		return Inhib_respawn_timer(this);
	}
};

class Nexus : public AttackableUnit {
public:
	
};

class Missile : public GameObject {
public:
	float3 start_pos()
	{
		float3 out;
		Missile_start_pos_Ptr(this, &out);
		return out;
	}
	float3 end_pos()
	{
		float3 out;
		Missile_end_pos_Ptr(this, &out);
		return out;
	}
	float speed()
	{
		return Missile_speed(this);
	}
	float width()
	{
		return Missile_width(this);
	}
	GameObject* source()
	{
		return Missile_source(this);
	}
	GameObject* target()
	{
		return Missile_target(this);
	}
	Spell* spell()
	{
		return Missile_spell(this);
	}
};

class Turret : public AIClient {
public:
	bool is_outer_turret()
	{
		return Turret_is_outer_turret(this);
	}
	bool is_inner_turret()
	{
		return Turret_is_inner_turret(this);
	}
	bool is_inhib_turret()
	{
		return Turret_is_inhib_turret(this);
	}
	bool is_nexus_turret()
	{
		return Turret_is_nexus_turret(this);
	}
	bool is_shrine()
	{
		return Turret_is_shrine(this);
	}
};

class Hero : public AIClient {
public:
	bool is_teleporting()
	{
		return Hero_is_teleporting(this);
	}
	const char* teleport_type()
	{
		return Hero_teleport_type(this);
	}
	const char* teleport_name()
	{
		return Hero_teleport_name(this);
	}
	int level()
	{
		return Hero_level(this);
	}
	float exp()
	{
		return Hero_exp(this);
	}
	vec_rune_t runes()
	{
		vec_rune_t out;
		Hero_runes_Ptr(this, &out);
		return out;
	}
	ItemSlot* item_slot(ItemSlotEnum slot)
	{
		return Hero_item_slot(this, slot);
	}
};

class Minion : public AIClient {
public:
	Hero* owner()
	{
		return Minion_owner(this);
	}
	bool is_lane_minion()
	{
		return Minion_is_lane_minion(this);
	}
	bool is_melee_minion()
	{
		return Minion_is_melee_minion(this);
	}
	bool is_ranged_minion()
	{
		return Minion_is_ranged_minion(this);
	}
	bool is_siege_minion()
	{
		return Minion_is_siege_minion(this);
	}
	bool is_super_minion()
	{
		return Minion_is_super_minion(this);
	}
	bool is_monster()
	{
		return Minion_is_monster(this);
	}
	bool is_camp_monster()
	{
		return Minion_is_camp_monster(this);
	}
	bool is_medium_monster()
	{
		return Minion_is_medium_monster(this);
	}
	bool is_large_monster()
	{
		return Minion_is_large_monster(this);
	}
	bool is_epic_monster()
	{
		return Minion_is_epic_monster(this);
	}
	bool is_wolf()
	{
		return Minion_is_wolf(this);
	}
	bool is_gromp()
	{
		return Minion_is_gromp(this);
	}
	bool is_raptor()
	{
		return Minion_is_raptor(this);
	}
	bool is_krug()
	{
		return Minion_is_krug(this);
	}
	bool is_buff()
	{
		return Minion_is_buff(this);
	}
	bool is_blue()
	{
		return Minion_is_blue(this);
	}
	bool is_red()
	{
		return Minion_is_red(this);
	}
	bool is_crab()
	{
		return Minion_is_crab(this);
	}
	bool is_dragon()
	{
		return Minion_is_dragon(this);
	}
	bool is_special_void_minion()
	{
		return Minion_is_special_void_minion(this);
	}
	bool is_herald()
	{
		return Minion_is_herald(this);
	}
	bool is_baron()
	{
		return Minion_is_baron(this);
	}
	bool is_ward()
	{
		return Minion_is_ward(this);
	}
	bool is_special_minion()
	{
		return Minion_is_special_minion(this);
	}
	bool is_plant()
	{
		return Minion_is_plant(this);
	}
	bool is_trap()
	{
		return Minion_is_trap(this);
	}
	bool is_summon()
	{
		return Minion_is_summon(this);
	}
	bool is_large_summon()
	{
		return Minion_is_large_summon(this);
	}
};

class Player : public Hero {
public:
	SpellCastStatusFlags spell_cast_status(SpellSlotEnum slot)
	{
		return Player_spell_cast_status(this, slot);
	}
	bool spell_cast_is_ready(SpellSlotEnum slot)
	{
		return Player_spell_cast_is_ready(this, slot);
	}
	bool spell_cast_is_not_available(SpellSlotEnum slot)
	{
		return Player_spell_cast_is_not_available(this, slot);
	}
	bool spell_cast_is_not_learned(SpellSlotEnum slot)
	{
		return Player_spell_cast_is_not_learned(this, slot);
	}
	bool spell_cast_is_disabled(SpellSlotEnum slot)
	{
		return Player_spell_cast_is_disabled(this, slot);
	}
	bool spell_cast_is_supressed(SpellSlotEnum slot)
	{
		return Player_spell_cast_is_supressed(this, slot);
	}
	bool spell_cast_is_on_cooldown(SpellSlotEnum slot)
	{
		return Player_spell_cast_is_on_cooldown(this, slot);
	}
	bool spell_cast_is_out_of_mana(SpellSlotEnum slot)
	{
		return Player_spell_cast_is_out_of_mana(this, slot);
	}
	bool is_cast_spell_limited(SpellSlotEnum slot)
	{
		return Player_is_cast_spell_limited(this, slot);
	}
	void reset_cast_spell_limiter(SpellSlotEnum slot)
	{
		return Player_reset_cast_spell_limiter(this, slot);
	}
	bool can_cast_spell(SpellSlotEnum slot)
	{
		return Player_can_cast_spell(this, slot);
	}
	bool cast_spell(SpellSlotEnum slot)
	{
		return Player_cast_spell(this, slot);
	}
	bool cast_spell_target(SpellSlotEnum slot, AttackableUnit *target)
	{
		return Player_cast_spell_target(this, slot, target);
	}
	bool cast_spell_pos(SpellSlotEnum slot, float3 &pos)
	{
		return Player_cast_spell_pos_Ptr(this, slot, &pos);
	}
	bool cast_spell_line(SpellSlotEnum slot, float3 &from, float3 &to)
	{
		return Player_cast_spell_line_Ptr(this, slot, &from, &to);
	}
	bool is_release_spell_limited(SpellSlotEnum slot)
	{
		return Player_is_release_spell_limited(this, slot);
	}
	void reset_release_spell_limiter(SpellSlotEnum slot)
	{
		return Player_reset_release_spell_limiter(this, slot);
	}
	bool release_spell(SpellSlotEnum slot, float3 &pos)
	{
		return Player_release_spell_Ptr(this, slot, &pos);
	}
	bool is_move_limited()
	{
		return Player_is_move_limited(this);
	}
	void reset_move_limiter()
	{
		return Player_reset_move_limiter(this);
	}
	bool can_move()
	{
		return Player_can_move(this);
	}
	bool move(float3 &pos)
	{
		return Player_move_Ptr(this, &pos);
	}
	bool hold_position()
	{
		return Player_hold_position(this);
	}
	bool stop()
	{
		return Player_stop(this);
	}
	bool is_attack_limited()
	{
		return Player_is_attack_limited(this);
	}
	void reset_attack_limiter()
	{
		return Player_reset_attack_limiter(this);
	}
	bool can_attack()
	{
		return Player_can_attack(this);
	}
	bool attack_move(float3 &pos)
	{
		return Player_attack_move_Ptr(this, &pos);
	}
	bool attack(AttackableUnit *target)
	{
		return Player_attack(this, target);
	}
	bool pet_move(float3 &pos)
	{
		return Player_pet_move_Ptr(this, &pos);
	}
	bool pet_attack(AttackableUnit *target)
	{
		return Player_pet_attack(this, target);
	}
	float gold()
	{
		return Player_gold(this);
	}
	float total_gold()
	{
		return Player_total_gold(this);
	}
	bool is_following_target()
	{
		return Player_is_following_target(this);
	}
	GameObject* follow_target()
	{
		return Player_follow_target(this);
	}
};

#endif

#endif