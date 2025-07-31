#ifndef __VECTOR_TYPES_H__
#define __VECTOR_TYPES_H__

#include <stddef.h>

// CUDA vector types
struct __device_builtin__ char1
{
    signed char x;
};

struct __device_builtin__ uchar1
{
    unsigned char x;
};

struct __device_builtin__ char2
{
    signed char x, y;
};

struct __device_builtin__ uchar2
{
    unsigned char x, y;
};

struct __device_builtin__ char3
{
    signed char x, y, z;
};

struct __device_builtin__ uchar3
{
    unsigned char x, y, z;
};

struct __device_builtin__ char4
{
    signed char x, y, z, w;
};

struct __device_builtin__ uchar4
{
    unsigned char x, y, z, w;
};

struct __device_builtin__ short1
{
    short x;
};

struct __device_builtin__ ushort1
{
    unsigned short x;
};

struct __device_builtin__ short2
{
    short x, y;
};

struct __device_builtin__ ushort2
{
    unsigned short x, y;
};

struct __device_builtin__ short3
{
    short x, y, z;
};

struct __device_builtin__ ushort3
{
    unsigned short x, y, z;
};

struct __device_builtin__ short4
{
    short x, y, z, w;
};

struct __device_builtin__ ushort4
{
    unsigned short x, y, z, w;
};

struct __device_builtin__ int1
{
    int x;
};

struct __device_builtin__ uint1
{
    unsigned int x;
};

struct __device_builtin__ int2
{
    int x, y;
};

struct __device_builtin__ uint2
{
    unsigned int x, y;
};

struct __device_builtin__ int3
{
    int x, y, z;
};

struct __device_builtin__ uint3
{
    unsigned int x, y, z;
};

struct __device_builtin__ int4
{
    int x, y, z, w;
};

struct __device_builtin__ uint4
{
    unsigned int x, y, z, w;
};

struct __device_builtin__ long1
{
    long int x;
};

struct __device_builtin__ ulong1
{
    unsigned long x;
};

struct __device_builtin__ long2
{
    long int x, y;
};

struct __device_builtin__ ulong2
{
    unsigned long int x, y;
};

struct __device_builtin__ long3
{
    long int x, y, z;
};

struct __device_builtin__ ulong3
{
    unsigned long int x, y, z;
};

struct __device_builtin__ long4
{
    long int x, y, z, w;
};

struct __device_builtin__ ulong4
{
    unsigned long int x, y, z, w;
};

struct __device_builtin__ longlong1
{
    long long int x;
};

struct __device_builtin__ ulonglong1
{
    unsigned long long int x;
};

struct __device_builtin__ longlong2
{
    long long int x, y;
};

struct __device_builtin__ ulonglong2
{
    unsigned long long int x, y;
};

struct __device_builtin__ longlong3
{
    long long int x, y, z;
};

struct __device_builtin__ ulonglong3
{
    unsigned long long int x, y, z;
};

struct __device_builtin__ longlong4
{
    long long int x, y, z, w;
};

struct __device_builtin__ ulonglong4
{
    unsigned long long int x, y, z, w;
};

struct __device_builtin__ float1
{
    float x;
};

struct __device_builtin__ float2
{
    float x, y;
};

struct __device_builtin__ float3
{
    float x, y, z;
};

struct __device_builtin__ float4
{
    float x, y, z, w;
};

struct __device_builtin__ double1
{
    double x;
};

struct __device_builtin__ double2
{
    double x, y;
};

struct __device_builtin__ double3
{
    double x, y, z;
};

struct __device_builtin__ double4
{
    double x, y, z, w;
};

// Dim3 type for kernel launch parameters
typedef struct dim3
{
    unsigned int x, y, z;
#if defined(__cplusplus)
    __host__ __device__ dim3(unsigned int vx = 1, unsigned int vy = 1, unsigned int vz = 1) : x(vx), y(vy), z(vz) {}
    __host__ __device__ dim3(uint3 v) : x(v.x), y(v.y), z(v.z) {}
    __host__ __device__ operator uint3(void) { uint3 t; t.x = x; t.y = y; t.z = z; return t; }
#endif
} dim3;

#endif /* __VECTOR_TYPES_H__ */