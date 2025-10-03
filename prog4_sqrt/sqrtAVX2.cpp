#include <immintrin.h>
#include <stdint.h>

// assume N % VECTOR_WIDTH == 0.
void sqrtAVX2(int N,
    float initialGuess,
    float values[],
    float output[])
{

    const __m256 kThreshold = _mm256_set1_ps(0.00001f);

    for (int i = 0; i < N; i += 8) {
        __m256 x = _mm256_loadu_ps(values+i);
        __m256 guess = _mm256_set1_ps(initialGuess);

        __m256 prod = _mm256_mul_ps(_mm256_mul_ps(guess, guess), x);
        __m256 signed_error = _mm256_sub_ps(prod, _mm256_set1_ps(1.f));
        // (~0x80000000) & signed_error = 0x7FFFFFFF & signed_error to clear sign bit
        __m256 error = _mm256_andnot_ps(_mm256_set1_ps(-0.0f), signed_error);

        __m256 maskKeepIterating = _mm256_cmp_ps(error, kThreshold, _CMP_GT_OQ);

        // movemask takes only the sign bits from each lane and pack into int8
        // positive int -> at least one lane has error > kThreshold
        while (_mm256_movemask_ps(maskKeepIterating) > 0) {
            __m256 prod_gs_gs_x = _mm256_mul_ps(_mm256_mul_ps(guess, guess), x);
            __m256 lhs = _mm256_mul_ps(_mm256_set1_ps(3.f), guess);
            __m256 rhs = _mm256_mul_ps(prod_gs_gs_x, guess);
            __m256 diff = _mm256_sub_ps(lhs, rhs);
            guess = _mm256_mul_ps(diff, _mm256_set1_ps(0.5f));
            signed_error = _mm256_sub_ps(prod_gs_gs_x, _mm256_set1_ps(1.f));            
            error = _mm256_andnot_ps(_mm256_set1_ps(-0.0f), signed_error);

            maskKeepIterating = _mm256_cmp_ps(error, kThreshold, _CMP_GT_OQ);
        }

        _mm256_storeu_ps(output+i, _mm256_mul_ps(x, guess));
    }
}
