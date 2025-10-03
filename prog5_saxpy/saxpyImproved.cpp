#include <immintrin.h>
#include <stdint.h>

// https://preshing.com/20120625/memory-ordering-at-compile-time/
// #define COMPILER_BARRIER() asm ("" ::: "memory")

void saxpyImproved(int N,
    float scale,
    float X[],
    float Y[],
    float result[])
{
    __m256 s = _mm256_set1_ps(scale);
    
    int i = 0;
    for (; i <= N - 8; i += 8) {
        __m256 x = _mm256_loadu_ps(&X[i]);
        __m256 y = _mm256_loadu_ps(&Y[i]);
        __m256 res = _mm256_fmadd_ps(s, x, y);
        _mm256_stream_ps(&result[i], res);  // stream to memory
    }

    // synchronize NT stores to prevent data race between threads due to compile-time reordering
    // maybe not necessary in this program?...
    _mm_sfence();
    // COMPILER_BARRIER();

    for (; i < N; ++i) {
        result[i] = scale * X[i] + Y[i];
    }
}

void saxpyImprovedUnrolled(int N,
    float scale,
    float X[],
    float Y[],
    float result[])
{
    __m256 s = _mm256_set1_ps(scale);
    
    int i = 0;

    // before unroll:
    // .L3:
    //     vmovups	(%rsi,%rax), %ymm1   # vectorized load x[i]
    //     vfmadd213ps	(%rdx,%rax), %ymm2, %ymm1  # fused multiply-add y[i] * scale + x[i]
    //     vmovntps	%ymm1, (%rcx,%rax)  # non-temporal store result[i]
    //     addq	$32, %rax  # i += 8
    //     cmpq	%rax, %r8  # compare i to N
    //     jne	.L3

    // after unroll:
    // .L40:
	//     vmovups	(%rax), %ymm5
	//     vmovups	32(%rax), %ymm4
	//     subq	$-128, %rax
	//     subq	$-128, %rcx
	//     vmovups	-64(%rax), %ymm3
	//     vmovups	-32(%rax), %ymm2
	//     subq	$-128, %rdx
	//     vfmadd213ps	-128(%rcx), %ymm1, %ymm5
	//     vfmadd213ps	-96(%rcx), %ymm1, %ymm4
	//     vfmadd213ps	-64(%rcx), %ymm1, %ymm3
	//     vfmadd213ps	-32(%rcx), %ymm1, %ymm2
	//     vmovntps	%ymm5, -128(%rdx)
	//     vmovntps	%ymm4, -96(%rdx)
	//     vmovntps	%ymm3, -64(%rdx)
	//     vmovntps	%ymm2, -32(%rdx)
	//     cmpq	%r10, %rax
    //     jne	.L40


    for (; i <= N - 32; i += 32) {
        __m256 x0 = _mm256_loadu_ps(&X[i]);
        __m256 x1 = _mm256_loadu_ps(&X[i+8]);
        __m256 x2 = _mm256_loadu_ps(&X[i+16]);
        __m256 x3 = _mm256_loadu_ps(&X[i+24]);
        
        __m256 y0 = _mm256_loadu_ps(&Y[i]);
        __m256 y1 = _mm256_loadu_ps(&Y[i+8]);
        __m256 y2 = _mm256_loadu_ps(&Y[i+16]);
        __m256 y3 = _mm256_loadu_ps(&Y[i+24]);
        
        __m256 res0 = _mm256_fmadd_ps(s, x0, y0);
        __m256 res1 = _mm256_fmadd_ps(s, x1, y1);
        __m256 res2 = _mm256_fmadd_ps(s, x2, y2);
        __m256 res3 = _mm256_fmadd_ps(s, x3, y3);
        
        // ispc docs: "Store 256-bits from a into memory using a non-temporal memory hint.
        //   mem_addr must be aligned on a 32-byte boundary or a general-protection exception may be generated."
        // given we align result before passing it in, we can stream directly to memory without the additional write-allocate memory op
        _mm256_stream_ps(&result[i], res0);
        _mm256_stream_ps(&result[i+8], res1);
        _mm256_stream_ps(&result[i+16], res2);
        _mm256_stream_ps(&result[i+24], res3);
    }
    
    // handle remainder
    for (; i <= N - 8; i += 8) {
        __m256 x = _mm256_loadu_ps(&X[i]);
        __m256 y = _mm256_loadu_ps(&Y[i]);
        __m256 res = _mm256_fmadd_ps(s, x, y);
        _mm256_stream_ps(&result[i], res);
    }

    _mm_sfence();
    // COMPILER_BARRIER();

    // handle tail
    for (; i < N; ++i) {
        result[i] = scale * X[i] + Y[i];
    }
}
