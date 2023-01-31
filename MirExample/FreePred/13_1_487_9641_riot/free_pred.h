#ifndef PRED_H
#define PRED_H

#include "botm_api.h"

enum CollisionFlags_ {
    CollisionFlags_None = 0,
    CollisionFlags_AlliedMinions = 1 << 1,
    CollisionFlags_EnemyMinions = 1 << 2,
    CollisionFlags_NeutralMinions = 1 << 3,
    CollisionFlags_AlliedLaneMinions = 1 << 4,
    CollisionFlags_EnemyLaneMinions = 1 << 5,
    CollisionFlags_EnemyHeroes = 1 << 6,
    CollisionFlags_AlliedHeroes = 1 << 7,
};

typedef int CollisionFlags;

typedef struct {
    float effect_radius;
    float cast_time;
    bool add_target_bbox;
    float target_range;
} PredInputCirclePrompt;

typedef struct {
    float effect_radius;
    float cast_time;
    float speed;
    bool add_target_bbox;
    float target_range;
} PredInputCircle;

typedef struct {
    float width;
    float cast_time;
    bool add_target_bbox;
    float target_range;
} PredInputLinePrompt;

typedef struct {
    float width;
    float cast_time;
    float speed;
    bool add_target_bbox;
    float target_range;
} PredInputLine;

typedef struct {
    float3 pos;
    float3 source_pos;
    bool is_in_target_range;
} PredResult;

typedef struct {
    bool target_just_changed_path;
    bool is_higher_hitchance;
    float time_to_hit;
    float distance;
} PredEval;

typedef struct Pred Pred;

//-----------------------------------------------------------------------------
// [Pred]
//-----------------------------------------------------------------------------
Pred* __cdecl Pred_init(ScriptEnv *env);
void __cdecl Pred_enable_debug(Pred * const me);
void __cdecl Pred_disable_debug(Pred * const me);
float3 __cdecl Pred_pos_after_time(Pred * const me, AIClient *source, float time);
void __cdecl Pred_circle_prompt_src3d(Pred * const me, PredInputCirclePrompt *input, AIClient *target, PredResult *res, const float3 source);
void __cdecl Pred_circle_prompt_src2d(Pred * const me, PredInputCirclePrompt *input, AIClient *target, PredResult *res, const float2 source);
void __cdecl Pred_circle_prompt_src(Pred * const me, PredInputCirclePrompt *input, AIClient *target, PredResult *res, AIClient *source);
void __cdecl Pred_circle_prompt(Pred * const me, PredInputCirclePrompt *input, AIClient *target, PredResult *res);
void __cdecl Pred_circle_src3d(Pred * const me, PredInputCircle *input, AIClient *target, PredResult *res, const float3 source);
void __cdecl Pred_circle_src2d(Pred * const me, PredInputCircle *input, AIClient *target, PredResult *res, const float2 source);
void __cdecl Pred_circle_src(Pred * const me, PredInputCircle *input, AIClient *target, PredResult *res, AIClient *source);
void __cdecl Pred_circle(Pred * const me, PredInputCircle *input, AIClient *target, PredResult *res);
void __cdecl Pred_line_prompt_src3d(Pred * const me, PredInputLinePrompt *input, AIClient *target, PredResult *res, const float3 source);
void __cdecl Pred_line_prompt_src2d(Pred * const me, PredInputLinePrompt *input, AIClient *target, PredResult *res, const float2 source);
void __cdecl Pred_line_prompt_src(Pred * const me, PredInputLinePrompt *input, AIClient *target, PredResult *res, AIClient *source);
void __cdecl Pred_line_prompt(Pred * const me, PredInputLinePrompt *input, AIClient *target, PredResult *res);
void __cdecl Pred_line_src3d(Pred * const me, PredInputLine *input, AIClient *target, PredResult *res, const float3 source);
void __cdecl Pred_line_src2d(Pred * const me, PredInputLine *input, AIClient *target, PredResult *res, const float2 source);
void __cdecl Pred_line_src(Pred * const me, PredInputLine *input, AIClient *target, PredResult *res, AIClient *source);
void __cdecl Pred_line(Pred * const me, PredInputLine *input, AIClient *target, PredResult *res);
bool __cdecl Pred_collision(Pred * const me, PredInputLine *input, PredResult *res, AIClient *target, CollisionFlags flags);
void __cdecl Pred_eval_circle_prompt(Pred * const me, PredInputCirclePrompt *input, PredResult *res, AIClient *target, PredEval *eval);
void __cdecl Pred_eval_circle(Pred * const me, PredInputCircle *input, PredResult *res, AIClient *target, PredEval *eval);
void __cdecl Pred_eval_line_prompt(Pred * const me, PredInputLinePrompt *input, PredResult *res, AIClient *target, PredEval *eval);
void __cdecl Pred_eval_line(Pred * const me, PredInputLine *input, PredResult *res, AIClient *target, PredEval *eval);

#endif