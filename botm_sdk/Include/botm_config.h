#ifndef BOTM_CONFIG_H
#define BOTM_CONFIG_H

#define BOTM_API __cdecl

#include "math_types.h"

typedef float2 ImVec2;
typedef float4 ImVec4;

#ifdef __cplusplus
    #define BOTM_EXPORT extern "C" __declspec(dllexport)
    #ifndef BOTM_NO_CPP_EXT
		#define BOTM_CPP_EXT
	#endif
#else
    #define BOTM_EXPORT __declspec(dllexport)
#endif

#endif