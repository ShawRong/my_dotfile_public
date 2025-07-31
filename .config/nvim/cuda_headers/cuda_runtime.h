#ifndef CUDA_RUNTIME_H
#define CUDA_RUNTIME_H

// CUDA runtime API types
typedef struct {
    int x, y;
} dim3;

typedef enum {
    cudaSuccess = 0,
    cudaErrorInvalidValue = 1,
    cudaErrorMemoryAllocation = 2,
    cudaErrorInitializationError = 3,
    cudaErrorLaunchFailure = 4,
    cudaErrorLaunchTimeout = 5,
    cudaErrorInvalidDeviceFunction = 8,
    cudaErrorInvalidConfiguration = 9,
    cudaErrorInvalidDevice = 10,
    cudaErrorInvalidValue = 11,
    cudaErrorInvalidPitchValue = 12,
    cudaErrorInvalidSymbol = 13,
    cudaErrorMapBufferObjectFailed = 14,
    cudaErrorUnmapBufferObjectFailed = 15,
    cudaErrorInvalidHostPointer = 16,
    cudaErrorInvalidDevicePointer = 17,
    cudaErrorInvalidTexture = 18,
    cudaErrorInvalidTextureBinding = 19,
    cudaErrorInvalidChannelDescriptor = 20,
    cudaErrorInvalidMemcpyDirection = 21
} cudaError_t;

typedef enum {
    cudaMemcpyHostToHost = 0,
    cudaMemcpyHostToDevice = 1,
    cudaMemcpyDeviceToHost = 2,
    cudaMemcpyDeviceToDevice = 3,
    cudaMemcpyDefault = 4
} cudaMemcpyKind;

// CUDA runtime functions
extern cudaError_t cudaMalloc(void **devPtr, size_t size);
extern cudaError_t cudaFree(void *devPtr);
extern cudaError_t cudaMemcpy(void *dst, const void *src, size_t count, cudaMemcpyKind kind);
extern cudaError_t cudaMemset(void *devPtr, int value, size_t count);
extern cudaError_t cudaDeviceSynchronize(void);
extern cudaError_t cudaGetLastError(void);
extern const char* cudaGetErrorString(cudaError_t error);

// Device management
extern cudaError_t cudaGetDeviceCount(int *count);
extern cudaError_t cudaSetDevice(int device);
extern cudaError_t cudaGetDevice(int *device);

// Stream management
typedef struct CUstream_st *cudaStream_t;
extern cudaError_t cudaStreamCreate(cudaStream_t *pStream);
extern cudaError_t cudaStreamDestroy(cudaStream_t stream);
extern cudaError_t cudaStreamSynchronize(cudaStream_t stream);

// Execution control
extern cudaError_t cudaLaunchKernel(const void *func, dim3 gridDim, dim3 blockDim, void **args, size_t sharedMem, cudaStream_t stream);

// Built-in variables (available in device code)
extern __device__ int threadIdx;
extern __device__ int blockIdx;
extern __device__ int blockDim;
extern __device__ int gridDim;
extern __device__ int warpSize;

#endif // CUDA_RUNTIME_H