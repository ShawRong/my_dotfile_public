#ifndef __DEVICE_LAUNCH_PARAMETERS_H__
#define __DEVICE_LAUNCH_PARAMETERS_H__

#if defined(__CUDACC__)

#include "vector_types.h"

// Built-in vector types
struct __device_builtin__ uint3
{
    unsigned int x, y, z;
};

struct __device_builtin__ int3
{
    int x, y, z;
};

struct __device_builtin__ dim3
{
    unsigned int x, y, z;
#if defined(__cplusplus)
    __host__ __device__ dim3(unsigned int vx = 1, unsigned int vy = 1, unsigned int vz = 1) : x(vx), y(vy), z(vz) {}
    __host__ __device__ dim3(uint3 v) : x(v.x), y(v.y), z(v.z) {}
    __host__ __device__ operator uint3(void) { uint3 t; t.x = x; t.y = y; t.z = z; return t; }
#endif /* __cplusplus */
};

// Thread and block indexing
extern __device__ __builtin_var__ uint3 threadIdx;
extern __device__ __builtin_var__ uint3 blockIdx;
extern __device__ __builtin_var__ dim3 blockDim;
extern __device__ __builtin_var__ dim3 gridDim;
extern __device__ __builtin_var__ int warpSize;

#endif /* __CUDACC__ */

#endif /* !__DEVICE_LAUNCH_PARAMETERS_H__ */