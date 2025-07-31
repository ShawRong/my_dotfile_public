#ifndef CUDA_KEYWORDS_H
#define CUDA_KEYWORDS_H

// CUDA function qualifiers
#define __global__
#define __device__
#define __host__
#define __constant__
#define __shared__
#define __restrict__

// CUDA synchronization
extern __device__ void __syncthreads(void);
extern __device__ void __threadfence(void);
extern __device__ void __threadfence_block(void);
extern __device__ void __threadfence_system(void);

// Atomic operations
extern __device__ int atomicAdd(int* address, int val);
extern __device__ unsigned int atomicAdd(unsigned int* address, unsigned int val);
extern __device__ float atomicAdd(float* address, float val);
extern __device__ int atomicSub(int* address, int val);
extern __device__ int atomicExch(int* address, int val);
extern __device__ int atomicMin(int* address, int val);
extern __device__ int atomicMax(int* address, int val);
extern __device__ int atomicInc(unsigned int* address, unsigned int val);
extern __device__ int atomicDec(unsigned int* address, unsigned int val);
extern __device__ int atomicCAS(int* address, int compare, int val);
extern __device__ int atomicAnd(int* address, int val);
extern __device__ int atomicOr(int* address, int val);
extern __device__ int atomicXor(int* address, int val);

// Memory fence operations
extern __device__ void __threadfence_block(void);
extern __device__ void __threadfence(void);
extern __device__ void __threadfence_system(void);

// Warp functions
extern __device__ int __all(int predicate);
extern __device__ int __any(int predicate);
extern __device__ unsigned int __ballot(int predicate);
extern __device__ int __popc(unsigned int x);
extern __device__ int __clz(int x);
extern __device__ int __ffs(int x);

// Math functions
extern __device__ float __sinf(float x);
extern __device__ float __cosf(float x);
extern __device__ float __tanf(float x);
extern __device__ float __expf(float x);
extern __device__ float __logf(float x);
extern __device__ float __sqrtf(float x);
extern __device__ float __powf(float x, float y);
extern __device__ float __fabsf(float x);

#endif // CUDA_KEYWORDS_H