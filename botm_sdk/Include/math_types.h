#ifndef BOTM_MATH_H
#define BOTM_MATH_H

#include <math.h>
#include <stdbool.h>

#include "botm_config.h"

typedef unsigned int uint;

#ifdef __cplusplus

template<class T, int M> struct vec;

template<class T> struct vec<T,2>
{
	T x, y;
	constexpr vec() : x(0), y(0) {}
	constexpr vec(T x, T y) : x(x), y(y) {}
	constexpr bool operator==(const vec& b) const
	{
		return x == b.x && y == b.y;
	}
	constexpr bool operator!=(const vec& b) const
	{
		return x != b.x || y != b.y;
	}
	constexpr vec operator+(const vec& b) const
	{
		return vec(x + b.x, y + b.y);
	}
	constexpr vec operator-(const vec& b) const
	{
		return vec(x - b.x, y - b.y);
	}
	constexpr vec operator*(const T s) const
	{
		return vec(x * s, y * s);
	}
	constexpr T mul_inner(const vec& b) const
	{
		return x * b.x + y * b.y;
	}
	constexpr vec dup() const
	{
		return vec(x, y);
	}
	constexpr T len() const
	{
		return sqrtf(this->mul_inner(*this));
	}
	constexpr vec norm() const
	{
		T k = 1 / this->len();
		return *this * k;
	}
	constexpr T dist(const vec& b) const
	{
		const vec v = *this - b;
		return v.len();
	}
	constexpr T dist_sqr(const vec& b) const
	{
		const vec v = *this - b;
		return v.mul_inner(v);
	}
	constexpr vec lerp(const vec& b, T t) const
	{
		return *this + ((b - *this) * t);
	}
	constexpr vec lerpd(const vec& b, T d) const
	{
		const vec s = b - *this;
		return *this + s * (d / s.len());
	}
};

template<class T> struct vec<T,3>
{
	T x, y, z;
	constexpr vec() : x(0), y(0), z(0) {}
	constexpr vec(T x, T y, T z) : x(x), y(y), z(z) {}
	constexpr bool operator==(const vec& b) const
	{
		return x == b.x && y == b.y && z == b.z;
	}
	constexpr bool operator!=(const vec& b) const
	{
		return x != b.x || y != b.y || z != b.z;
	}
	constexpr vec operator+(const vec& b) const
	{
		return vec(x + b.x, y + b.y, z + b.z);
	}
	constexpr vec operator-(const vec& b) const
	{
		return vec(x - b.x, y - b.y, z - b.z);
	}
	constexpr vec operator*(const T s) const
	{
		return vec(x * s, y * s, z * s);
	}
	constexpr T mul_inner(const vec& b) const
	{
		return x * b.x + y * b.y + z * b.z;
	}
	constexpr vec dup() const
	{
		return vec(x, y, z);
	}
	constexpr T len() const
	{
		return sqrtf(this->mul_inner(*this));
	}
	constexpr vec norm() const
	{
		T k = 1 / this->len();
		return *this * k;
	}
	constexpr T dist(const vec& b) const
	{
		const vec v = *this - b;
		return v.len();
	}
	constexpr T dist_sqr(const vec& b) const
	{
		const vec v = *this - b;
		return v.mul_inner(v);
	}
	constexpr vec lerp(const vec& b, T t) const
	{
		return *this + ((b - *this) * t);
	}
	constexpr vec lerpd(const vec& b, T d) const
	{
		const vec s = b - *this;
		return *this + s * (d / s.len());
	}
};

template<class T> struct vec<T,4>
{
	T x, y, z, w;
	constexpr vec() : x(0), y(0), z(0), w(0) {}
	constexpr vec(T x, T y, T z, T w) : x(x), y(y), z(z), w(w) {}
	constexpr bool operator==(const vec& b) const
	{
		return x == b.x && y == b.y && z == b.z && w == b.w;
	}
	constexpr bool operator!=(const vec& b) const
	{
		return x != b.x || y != b.y || z != b.z || w != b.w;
	}
	constexpr vec operator+(const vec& b) const
	{
		return vec(x + b.x, y + b.y, z + b.z, w + b.w);
	}
	constexpr vec operator-(const vec& b) const
	{
		return vec(x - b.x, y - b.y, z - b.z, w - b.w);
	}
	constexpr vec operator*(const T s) const
	{
		return vec(x * s, y * s, z * s, w * s);
	}
	constexpr T mul_inner(const vec& b) const
	{
		return x * b.x + y * b.y + z * b.z + w * b.w;
	}
	constexpr vec dup() const
	{
		return vec(x, y, z, w);
	}
	constexpr T len() const
	{
		return sqrtf(this->mul_inner(*this));
	}
	constexpr vec norm() const
	{
		T k = 1 / this->len();
		return *this * k;
	}
	constexpr T dist(const vec& b) const
	{
		const vec v = *this - b;
		return v.len();
	}
	constexpr T dist_sqr(const vec& b) const
	{
		const vec v = *this - b;
		return v.mul_inner(v);
	}
	constexpr vec lerp(const vec& b, T t) const
	{
		return *this + ((b - *this) * t);
	}
	constexpr vec lerpd(const vec& b, T d) const
	{
		const vec s = b - *this;
		return *this + s * (d / s.len());
	}
};

typedef vec<float,2> float2;
typedef vec<float,3> float3;
typedef vec<float,4> float4;

typedef vec<short,2> short2;
typedef vec<short,3> short3;
typedef vec<short,4> short4;

typedef vec<int,2> int2;
typedef vec<int,3> int3;
typedef vec<int,4> int4;

typedef vec<unsigned int,2> uint2;
typedef vec<unsigned int,3> uint3;
typedef vec<unsigned int,4> uint4;

#else

#define BOTM_MATH_H_DEFINE_VEC2(t, n) \
typedef struct { \
	t x, y; \
} t##n;

#define BOTM_MATH_H_DEFINE_VEC3(t, n) \
typedef struct { \
	t x, y, z; \
} t##n;

#define BOTM_MATH_H_DEFINE_VEC4(t, n) \
typedef struct { \
	t x, y, z, w; \
} t##n; 

BOTM_MATH_H_DEFINE_VEC2(float, 2)
BOTM_MATH_H_DEFINE_VEC3(float, 3)
BOTM_MATH_H_DEFINE_VEC4(float, 4)

BOTM_MATH_H_DEFINE_VEC2(short, 2)
BOTM_MATH_H_DEFINE_VEC3(short, 3)
BOTM_MATH_H_DEFINE_VEC4(short, 4)

BOTM_MATH_H_DEFINE_VEC2(int, 2)
BOTM_MATH_H_DEFINE_VEC3(int, 3)
BOTM_MATH_H_DEFINE_VEC4(int, 4)

BOTM_MATH_H_DEFINE_VEC2(uint, 2)
BOTM_MATH_H_DEFINE_VEC3(uint, 3)
BOTM_MATH_H_DEFINE_VEC4(uint, 4)

#endif

#define BOTM_MATH_FUNC static inline

#define BOTM_MATH_H_IMPL_VEC2(t, n) \
BOTM_MATH_FUNC bool t##n##_eq(t##n const a, t##n const b) \
{ \
    return a.x == b.x && a.y == b.y; \
} \
BOTM_MATH_FUNC t##n t##n##_add(t##n const a, t##n const b) \
{ \
	t##n r; \
	r.x = a.x + b.x; \
	r.y = a.y + b.y; \
	return r; \
} \
BOTM_MATH_FUNC t##n t##n##_sub(t##n const a, t##n const b) \
{ \
	t##n r; \
	r.x = a.x - b.x; \
	r.y = a.y - b.y; \
	return r; \
} \
BOTM_MATH_FUNC t##n t##n##_scale(t##n const a, t const s) \
{ \
	t##n r; \
	r.x = a.x * s; \
	r.y = a.y * s; \
	return r; \
} \
BOTM_MATH_FUNC t t##n##_mul_inner(t##n const a, t##n const b) \
{ \
	return a.x*b.x + a.y*b.y; \
} \
BOTM_MATH_FUNC t##n t##n##_dup(t##n const src) \
{ \
	t##n r; \
	r.x = src.x; \
	r.y = src.y; \
	return r; \
} \
BOTM_MATH_FUNC t t##n##_len(t##n const a) \
{ \
	return sqrtf(t##n##_mul_inner(a, a)); \
} \
BOTM_MATH_FUNC t##n t##n##_norm(t##n const a) \
{ \
	t k = 1 / t##n##_len(a); \
	return t##n##_scale(a, k); \
} \
BOTM_MATH_FUNC t##n t##n##_lerp(t##n const a, t##n const b, t s) \
{ \
	return t##n##_add(a, t##n##_scale(t##n##_sub(b, a), s)); \
} \
BOTM_MATH_FUNC t t##n##_dist(t##n const a, t##n const b) \
{ \
	return t##n##_len(t##n##_sub(a, b)); \
} \
BOTM_MATH_FUNC t t##n##_dist_sqr(t##n const a, t##n const b) \
{ \
	t##n v = t##n##_sub(a, b); \
	return t##n##_mul_inner(v, v); \
} \
BOTM_MATH_FUNC t##n t##n##_lerpd(t##n const a, t##n const b, t d) \
{ \
	t##n s = t##n##_sub(b, a); \
	return t##n##_add(a, t##n##_scale(s, d / t##n##_len(s))); \
}

#define BOTM_MATH_H_IMPL_VEC3(t, n) \
BOTM_MATH_FUNC bool t##n##_eq(t##n const a, t##n const b) \
{ \
    return a.x == b.x && a.y == b.y && a.z == b.z; \
} \
BOTM_MATH_FUNC t##n t##n##_add(t##n const a, t##n const b) \
{ \
	t##n r; \
	r.x = a.x + b.x; \
	r.y = a.y + b.y; \
	r.z = a.z + b.z; \
	return r; \
} \
BOTM_MATH_FUNC t##n t##n##_sub(t##n const a, t##n const b) \
{ \
	t##n r; \
	r.x = a.x - b.x; \
	r.y = a.y - b.y; \
	r.z = a.z - b.z; \
	return r; \
} \
BOTM_MATH_FUNC t##n t##n##_scale(t##n const a, t const s) \
{ \
	t##n r; \
	r.x = a.x * s; \
	r.y = a.y * s; \
	r.z = a.z * s; \
	return r; \
} \
BOTM_MATH_FUNC t t##n##_mul_inner(t##n const a, t##n const b) \
{ \
	return a.x*b.x + a.y*b.y + a.z*b.z; \
} \
BOTM_MATH_FUNC t##n t##n##_dup(t##n const src) \
{ \
	t##n r; \
	r.x = src.x; \
	r.y = src.y; \
	r.z = src.z; \
	return r; \
} \
BOTM_MATH_FUNC t t##n##_len(t##n const a) \
{ \
	return sqrtf(t##n##_mul_inner(a, a)); \
} \
BOTM_MATH_FUNC t##n t##n##_norm(t##n const a) \
{ \
	t k = 1 / t##n##_len(a); \
	return t##n##_scale(a, k); \
} \
BOTM_MATH_FUNC t##n t##n##_lerp(t##n const a, t##n const b, t s) \
{ \
	return t##n##_add(a, t##n##_scale(t##n##_sub(b, a), s)); \
} \
BOTM_MATH_FUNC t t##n##_dist(t##n const a, t##n const b) \
{ \
	return t##n##_len(t##n##_sub(a, b)); \
} \
BOTM_MATH_FUNC t t##n##_dist_sqr(t##n const a, t##n const b) \
{ \
	t##n v = t##n##_sub(a, b); \
	return t##n##_mul_inner(v, v); \
} \
BOTM_MATH_FUNC t##n t##n##_lerpd(t##n const a, t##n const b, t d) \
{ \
	t##n s = t##n##_sub(b, a); \
	return t##n##_add(a, t##n##_scale(s, d / t##n##_len(s))); \
}

#define BOTM_MATH_H_IMPL_VEC3XZ(t, n) \
BOTM_MATH_FUNC bool t##n##xz_eq(t##n const a, t##n const b) \
{ \
    return a.x == b.x && a.z == b.z; \
} \
BOTM_MATH_FUNC t##n t##n##xz_add(t##n const a, t##n const b) \
{ \
	t##n r; \
	r.x = a.x + b.x; \
	r.z = a.z + b.z; \
	return r; \
} \
BOTM_MATH_FUNC t##n t##n##xz_sub(t##n const a, t##n const b) \
{ \
	t##n r; \
	r.x = a.x - b.x; \
	r.z = a.z - b.z; \
	return r; \
} \
BOTM_MATH_FUNC t##n t##n##xz_scale(t##n const a, t const s) \
{ \
	t##n r; \
	r.x = a.x * s; \
	r.z = a.z * s; \
	return r; \
} \
BOTM_MATH_FUNC t t##n##xz_mul_inner(t##n const a, t##n const b) \
{ \
	return a.x*b.x + a.z*b.z; \
} \
BOTM_MATH_FUNC t##n t##n##xz_dup(t##n const src) \
{ \
	t##n r; \
	r.x = src.x; \
	r.z = src.z; \
	return r; \
} \
BOTM_MATH_FUNC t t##n##xz_len(t##n const a) \
{ \
	return sqrtf(t##n##xz_mul_inner(a, a)); \
} \
BOTM_MATH_FUNC t##n t##n##xz_norm(t##n const a) \
{ \
	t k = 1 / t##n##xz_len(a); \
	return t##n##xz_scale(a, k); \
} \
BOTM_MATH_FUNC t##n t##n##xz_lerp(t##n const a, t##n const b, t s) \
{ \
	return t##n##xz_add(a, t##n##xz_scale(t##n##xz_sub(b, a), s)); \
} \
BOTM_MATH_FUNC t t##n##xz_dist(t##n const a, t##n const b) \
{ \
	return t##n##xz_len(t##n##xz_sub(a, b)); \
} \
BOTM_MATH_FUNC t t##n##xz_dist_sqr(t##n const a, t##n const b) \
{ \
	t##n v = t##n##xz_sub(a, b); \
	return t##n##xz_mul_inner(v, v); \
} \
BOTM_MATH_FUNC t##n t##n##xz_lerpd(t##n const a, t##n const b, t d) \
{ \
	t##n s = t##n##xz_sub(b, a); \
	return t##n##xz_add(a, t##n##xz_scale(s, d / t##n##xz_len(s))); \
}

#define BOTM_MATH_H_IMPL_VEC4(t, n) \
BOTM_MATH_FUNC bool t##n##_eq(t##n const a, t##n const b) \
{ \
    return a.x == b.x && a.y == b.y && a.z == b.z && a.w == b.w; \
} \
BOTM_MATH_FUNC t##n t##n##_add(t##n const a, t##n const b) \
{ \
	t##n r; \
	r.x = a.x + b.x; \
	r.y = a.y + b.y; \
	r.z = a.z + b.z; \
	r.w = a.w + b.w; \
	return r; \
} \
BOTM_MATH_FUNC t##n t##n##_sub(t##n const a, t##n const b) \
{ \
	t##n r; \
	r.x = a.x - b.x; \
	r.y = a.y - b.y; \
	r.z = a.z - b.z; \
	r.w = a.w - b.w; \
	return r; \
} \
BOTM_MATH_FUNC t##n t##n##_scale(t##n const a, t const s) \
{ \
	t##n r; \
	r.x = a.x * s; \
	r.y = a.y * s; \
	r.z = a.z * s; \
	r.w = a.w * s; \
	return r; \
} \
BOTM_MATH_FUNC t t##n##_mul_inner(t##n const a, t##n const b) \
{ \
	return a.x*b.x + a.y*b.y + a.z*b.z + a.w*b.w; \
} \
BOTM_MATH_FUNC t##n t##n##_dup(t##n const src) \
{ \
	t##n r; \
	r.x = src.x; \
	r.y = src.y; \
	r.z = src.z; \
	r.w = src.w; \
	return r; \
} \
BOTM_MATH_FUNC t t##n##_len(t##n const a) \
{ \
	return sqrtf(t##n##_mul_inner(a, a)); \
} \
BOTM_MATH_FUNC t##n t##n##_norm(t##n const a) \
{ \
	t k = 1 / t##n##_len(a); \
	return t##n##_scale(a, k); \
} \
BOTM_MATH_FUNC t##n t##n##_lerp(t##n const a, t##n const b, t s) \
{ \
	return t##n##_add(a, t##n##_scale(t##n##_sub(b, a), s)); \
} \
BOTM_MATH_FUNC t t##n##_dist(t##n const a, t##n const b) \
{ \
	return t##n##_len(t##n##_sub(a, b)); \
} \
BOTM_MATH_FUNC t t##n##_dist_sqr(t##n const a, t##n const b) \
{ \
	t##n v = t##n##_sub(a, b); \
	return t##n##_mul_inner(v, v); \
} \
BOTM_MATH_FUNC t##n t##n##_lerpd(t##n const a, t##n const b, t d) \
{ \
	t##n s = t##n##_sub(b, a); \
	return t##n##_add(a, t##n##_scale(s, d / t##n##_len(s))); \
}

BOTM_MATH_H_IMPL_VEC2(float, 2)
BOTM_MATH_H_IMPL_VEC3(float, 3)
BOTM_MATH_H_IMPL_VEC3XZ(float, 3)
BOTM_MATH_H_IMPL_VEC4(float, 4)

BOTM_MATH_H_IMPL_VEC2(short, 2)
BOTM_MATH_H_IMPL_VEC3(short, 3)
BOTM_MATH_H_IMPL_VEC3XZ(short, 3)
BOTM_MATH_H_IMPL_VEC4(short, 4)

BOTM_MATH_H_IMPL_VEC2(int, 2)
BOTM_MATH_H_IMPL_VEC3(int, 3)
BOTM_MATH_H_IMPL_VEC3XZ(int, 3)
BOTM_MATH_H_IMPL_VEC4(int, 4)

BOTM_MATH_H_IMPL_VEC2(uint, 2)
BOTM_MATH_H_IMPL_VEC3(uint, 3)
BOTM_MATH_H_IMPL_VEC3XZ(uint, 3)
BOTM_MATH_H_IMPL_VEC4(uint, 4)

#endif