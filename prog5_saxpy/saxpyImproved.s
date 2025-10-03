	.file	"saxpyImproved.cpp"
# GNU C++17 (Ubuntu 13.3.0-6ubuntu2~24.04) version 13.3.0 (x86_64-linux-gnu)
#	compiled by GNU C version 13.3.0, GMP version 6.3.0, MPFR version 4.2.1, MPC version 1.3.1, isl version isl-0.26-GMP

# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -march=skylake -mmmx -mpopcnt -msse -msse2 -msse3 -mssse3 -msse4.1 -msse4.2 -mavx -mavx2 -mno-sse4a -mno-fma4 -mno-xop -mfma -mno-avx512f -mbmi -mbmi2 -maes -mpclmul -mno-avx512vl -mno-avx512bw -mno-avx512dq -mno-avx512cd -mno-avx512er -mno-avx512pf -mno-avx512vbmi -mno-avx512ifma -mno-avx5124vnniw -mno-avx5124fmaps -mno-avx512vpopcntdq -mno-avx512vbmi2 -mno-gfni -mno-vpclmulqdq -mno-avx512vnni -mno-avx512bitalg -mno-avx512bf16 -mno-avx512vp2intersect -mno-3dnow -madx -mabm -mno-cldemote -mclflushopt -mno-clwb -mno-clzero -mcx16 -mno-enqcmd -mf16c -mfsgsbase -mfxsr -mno-hle -msahf -mno-lwp -mlzcnt -mmovbe -mno-movdir64b -mno-movdiri -mno-mwaitx -mno-pconfig -mno-pku -mno-prefetchwt1 -mprfchw -mno-ptwrite -mno-rdpid -mrdrnd -mrdseed -mno-rtm -mno-serialize -msgx -mno-sha -mno-shstk -mno-tbm -mno-tsxldtrk -mno-vaes -mno-waitpkg -mno-wbnoinvd -mxsave -mxsavec -mxsaveopt -mxsaves -mno-amx-tile -mno-amx-int8 -mno-amx-bf16 -mno-uintr -mno-hreset -mno-kl -mno-widekl -mno-avxvnni -mno-avx512fp16 -mno-avxifma -mno-avxvnniint8 -mno-avxneconvert -mno-cmpccxadd -mno-amx-fp16 -mno-prefetchi -mno-raoint -mno-amx-complex --param=l1-cache-size=32 --param=l1-cache-line-size=64 --param=l2-cache-size=8192 -mtune=skylake -m64 -O3 -fasynchronous-unwind-tables -fstack-protector-strong -fstack-clash-protection -fcf-protection
	.text
	.p2align 4
	.globl	_Z13saxpyImprovedifPfS_S_
	.type	_Z13saxpyImprovedifPfS_S_, @function
_Z13saxpyImprovedifPfS_S_:
.LFB6444:
	.cfi_startproc
	endbr64	
	movl	%edi, %r9d	# tmp212, N
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:1330: 				 __A, __A, __A, __A };
	vbroadcastss	%xmm0, %ymm2	# scale, _32
# saxpyImproved.cpp:13:     for (; i <= N - 8; i += 8) {
	cmpl	$7, %edi	#, N
	jle	.L13	#,
	leal	-8(%rdi), %edi	#, tmp177
	xorl	%eax, %eax	# ivtmp.73
	shrl	$3, %edi	#, _72
	leal	1(%rdi), %r8d	#,
	movq	%r8, %rdi	#,
	salq	$5, %r8	#, _69
	.p2align 4,,10
	.p2align 3
.L3:
# /usr/lib/gcc/x86_64-linux-gnu/13/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vmovups	(%rsi,%rax), %ymm1	# MEM[(__m256_u * {ref-all})X_25(D) + ivtmp.73_111 * 1], tmp180
	vfmadd213ps	(%rdx,%rax), %ymm2, %ymm1	# MEM[(__m256_u * {ref-all})Y_26(D) + ivtmp.73_111 * 1], _32, tmp180
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:1029:   __builtin_ia32_movntps256 (__P, (__v8sf)__A);
	vmovntps	%ymm1, (%rcx,%rax)	# tmp180,* ivtmp.73
# saxpyImproved.cpp:13:     for (; i <= N - 8; i += 8) {
	addq	$32, %rax	#, ivtmp.73
	cmpq	%rax, %r8	# ivtmp.73, _69
	jne	.L3	#,
	sall	$3, %edi	#, tmp.28
.L2:
# /usr/lib/gcc/x86_64-linux-gnu/13/include/xmmintrin.h:1304:   __builtin_ia32_sfence ();
	sfence	
# saxpyImproved.cpp:21:     for (; i < N; ++i) {
	cmpl	%edi, %r9d	# tmp.28, N
	jle	.L34	#,
# saxpyImproved.cpp:9: {
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movl	%r9d, %r11d	# N, niters.25
	movslq	%edi, %rax	# tmp.28, ivtmp.44
	subl	%edi, %r11d	# tmp.28, niters.25
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
	pushq	%r14	#
	pushq	%r13	#
	pushq	%r12	#
	.cfi_offset 14, -24
	.cfi_offset 13, -32
	.cfi_offset 12, -40
	leal	-1(%r11), %r12d	#, _37
	pushq	%rbx	#
	.cfi_offset 3, -48
	cmpl	$2, %r12d	#, _37
	jbe	.L11	#,
	leaq	0(,%rax,4), %r10	#, _19
	leaq	(%rcx,%r10), %rbx	#, _18
	leaq	4(%r10), %r8	#, _6
	leaq	(%rsi,%r8), %r14	#, tmp186
	movq	%rbx, %r13	# _18, tmp187
	subq	%r14, %r13	# tmp186, tmp187
	cmpq	$24, %r13	#, tmp187
	jbe	.L11	#,
	addq	%rdx, %r8	# Y, tmp190
	movq	%rbx, %r13	# _18, tmp191
	subq	%r8, %r13	# tmp190, tmp191
	cmpq	$24, %r13	#, tmp191
	jbe	.L11	#,
	cmpl	$6, %r12d	#, _37
	jbe	.L14	#,
	movl	%r11d, %r12d	# niters.25, bnd.12
	leaq	(%rsi,%r10), %r13	#, vectp.16
# saxpyImproved.cpp:21:     for (; i < N; ++i) {
	xorl	%r8d, %r8d	# ivtmp.57
	addq	%rdx, %r10	# Y, vectp.20
	shrl	$3, %r12d	#,
	salq	$5, %r12	#, _112
	.p2align 4,,10
	.p2align 3
.L7:
# saxpyImproved.cpp:22:         result[i] = scale * X[i] + Y[i];
	vmovups	0(%r13,%r8), %ymm1	# MEM <vector(8) float> [(float *)vectp.16_123 + ivtmp.57_125 * 1], vect__16.22
	vfmadd213ps	(%r10,%r8), %ymm2, %ymm1	# MEM <vector(8) float> [(float *)vectp.20_131 + ivtmp.57_125 * 1], _32, vect__16.22
# saxpyImproved.cpp:22:         result[i] = scale * X[i] + Y[i];
	vmovups	%ymm1, (%rbx,%r8)	# vect__16.22, MEM <vector(8) float> [(float *)_18 + ivtmp.57_125 * 1]
	addq	$32, %r8	#, ivtmp.57
	cmpq	%r8, %r12	# ivtmp.57, _112
	jne	.L7	#,
	movl	%r11d, %r8d	# niters.25, niters_vector_mult_vf.13
	andl	$-8, %r8d	#,
	addl	%r8d, %edi	# niters_vector_mult_vf.13, tmp.28
	testb	$7, %r11b	#, niters.25
	je	.L32	#,
	subl	%r8d, %r11d	# niters_vector_mult_vf.13, niters.25
	leal	-1(%r11), %r10d	#, tmp199
	cmpl	$2, %r10d	#, tmp199
	jbe	.L9	#,
.L6:
	addq	%r8, %rax	# niters_vector_mult_vf.13, tmp201
# saxpyImproved.cpp:22:         result[i] = scale * X[i] + Y[i];
	vshufps	$0, %xmm0, %xmm0, %xmm1	# scale, tmp203
	vmovups	(%rdx,%rax,4), %xmm3	# MEM <vector(4) float> [(float *)vectp.34_187], tmp225
	vfmadd132ps	(%rsi,%rax,4), %xmm3, %xmm1	# MEM <vector(4) float> [(float *)vectp.30_177], tmp225, vect__106.36
# saxpyImproved.cpp:22:         result[i] = scale * X[i] + Y[i];
	vmovups	%xmm1, (%rcx,%rax,4)	# vect__106.36, MEM <vector(4) float> [(float *)vectp.38_196]
	movl	%r11d, %eax	# niters.25, niters_vector_mult_vf.27
	andl	$-4, %eax	#, niters_vector_mult_vf.27
	addl	%eax, %edi	# niters_vector_mult_vf.27, tmp.28
	andl	$3, %r11d	#, niters.25
	je	.L32	#,
.L9:
# saxpyImproved.cpp:22:         result[i] = scale * X[i] + Y[i];
	movslq	%edi, %r8	# tmp.28, tmp.28
# saxpyImproved.cpp:22:         result[i] = scale * X[i] + Y[i];
	vmovss	(%rsi,%r8,4), %xmm1	# *_10, _29
# saxpyImproved.cpp:22:         result[i] = scale * X[i] + Y[i];
	leaq	0(,%r8,4), %rax	#, _9
# saxpyImproved.cpp:22:         result[i] = scale * X[i] + Y[i];
	vfmadd213ss	(%rdx,%r8,4), %xmm0, %xmm1	# *_14, scale, _29
# saxpyImproved.cpp:21:     for (; i < N; ++i) {
	leal	1(%rdi), %r8d	#, i
# saxpyImproved.cpp:22:         result[i] = scale * X[i] + Y[i];
	vmovss	%xmm1, (%rcx,%rax)	# _29, *_16
# saxpyImproved.cpp:21:     for (; i < N; ++i) {
	cmpl	%r8d, %r9d	# i, N
	jle	.L32	#,
# saxpyImproved.cpp:22:         result[i] = scale * X[i] + Y[i];
	vmovss	4(%rsi,%rax), %xmm1	# *_103, _92
# saxpyImproved.cpp:21:     for (; i < N; ++i) {
	addl	$2, %edi	#, i
# saxpyImproved.cpp:22:         result[i] = scale * X[i] + Y[i];
	vfmadd213ss	4(%rdx,%rax), %xmm0, %xmm1	# *_106, scale, _92
# saxpyImproved.cpp:22:         result[i] = scale * X[i] + Y[i];
	vmovss	%xmm1, 4(%rcx,%rax)	# _92, *_146
# saxpyImproved.cpp:21:     for (; i < N; ++i) {
	cmpl	%edi, %r9d	# i, N
	jle	.L32	#,
# saxpyImproved.cpp:22:         result[i] = scale * X[i] + Y[i];
	vmovss	8(%rdx,%rax), %xmm4	# *_158, tmp229
	vfmadd132ss	8(%rsi,%rax), %xmm4, %xmm0	# *_155, tmp229, _161
# saxpyImproved.cpp:22:         result[i] = scale * X[i] + Y[i];
	vmovss	%xmm0, 8(%rcx,%rax)	# _161, *_160
.L32:
	vzeroupper
# saxpyImproved.cpp:24: }
	popq	%rbx	#
	popq	%r12	#
	popq	%r13	#
	popq	%r14	#
	popq	%rbp	#
	.cfi_remember_state
	.cfi_def_cfa 7, 8
	ret	
	.p2align 4,,10
	.p2align 3
.L11:
	.cfi_restore_state
# saxpyImproved.cpp:22:         result[i] = scale * X[i] + Y[i];
	vmovss	(%rsi,%rax,4), %xmm1	# MEM[(float *)X_25(D) + ivtmp.44_148 * 4], _89
	vfmadd213ss	(%rdx,%rax,4), %xmm0, %xmm1	# MEM[(float *)Y_26(D) + ivtmp.44_148 * 4], scale, _89
# saxpyImproved.cpp:22:         result[i] = scale * X[i] + Y[i];
	vmovss	%xmm1, (%rcx,%rax,4)	# _89, MEM[(float *)result_27(D) + ivtmp.44_148 * 4]
# saxpyImproved.cpp:21:     for (; i < N; ++i) {
	incq	%rax	# ivtmp.44
	cmpl	%eax, %r9d	# ivtmp.44, N
	jg	.L11	#,
	jmp	.L32	#
	.p2align 4,,10
	.p2align 3
.L34:
	.cfi_def_cfa 7, 8
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 14
	vzeroupper
	ret	
	.p2align 4,,10
	.p2align 3
.L13:
# saxpyImproved.cpp:12:     int i = 0;
	xorl	%edi, %edi	# tmp.28
	jmp	.L2	#
.L14:
	.cfi_def_cfa 6, 16
	.cfi_offset 3, -48
	.cfi_offset 6, -16
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
# saxpyImproved.cpp:21:     for (; i < N; ++i) {
	xorl	%r8d, %r8d	#
	jmp	.L6	#
	.cfi_endproc
.LFE6444:
	.size	_Z13saxpyImprovedifPfS_S_, .-_Z13saxpyImprovedifPfS_S_
	.p2align 4
	.globl	_Z21saxpyImprovedUnrolledifPfS_S_
	.type	_Z21saxpyImprovedUnrolledifPfS_S_, @function
_Z21saxpyImprovedUnrolledifPfS_S_:
.LFB6445:
	.cfi_startproc
	endbr64	
	movl	%edi, %r9d	# tmp279, N
	movq	%rcx, %r8	# tmp283, result
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:1330: 				 __A, __A, __A, __A };
	vbroadcastss	%xmm0, %ymm1	# scale, _55
# saxpyImproved.cpp:31: {
	movq	%rdx, %rdi	# tmp282, Y
# saxpyImproved.cpp:38:     for (; i <= N - 32; i += 32) {
	cmpl	$31, %r9d	#, N
	jle	.L52	#,
	leal	-32(%r9), %r11d	#, tmp217
	movq	%rdx, %rcx	# Y, ivtmp.150
	movq	%rsi, %rax	# X, ivtmp.149
	movq	%r8, %rdx	# result, ivtmp.151
	shrl	$5, %r11d	#, _251
	movl	%r11d, %r10d	# _251, _251
	salq	$7, %r10	#, tmp220
	leaq	128(%rsi,%r10), %r10	#, _185
	.p2align 4,,10
	.p2align 3
.L40:
# /usr/lib/gcc/x86_64-linux-gnu/13/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vmovups	(%rax), %ymm5	# MEM[(__m256_u * {ref-all})_257], tmp221
	vmovups	32(%rax), %ymm4	# MEM[(__m256_u * {ref-all})_257 + 32B], tmp224
# saxpyImproved.cpp:38:     for (; i <= N - 32; i += 32) {
	subq	$-128, %rax	#, ivtmp.149
	subq	$-128, %rcx	#, ivtmp.150
# /usr/lib/gcc/x86_64-linux-gnu/13/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vmovups	-64(%rax), %ymm3	# MEM[(__m256_u * {ref-all})_257 + 64B], tmp227
	vmovups	-32(%rax), %ymm2	# MEM[(__m256_u * {ref-all})_257 + 96B], tmp230
# saxpyImproved.cpp:38:     for (; i <= N - 32; i += 32) {
	subq	$-128, %rdx	#, ivtmp.151
# /usr/lib/gcc/x86_64-linux-gnu/13/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vfmadd213ps	-128(%rcx), %ymm1, %ymm5	# MEM[(__m256_u * {ref-all})_256], _55, tmp221
	vfmadd213ps	-96(%rcx), %ymm1, %ymm4	# MEM[(__m256_u * {ref-all})_256 + 32B], _55, tmp224
	vfmadd213ps	-64(%rcx), %ymm1, %ymm3	# MEM[(__m256_u * {ref-all})_256 + 64B], _55, tmp227
	vfmadd213ps	-32(%rcx), %ymm1, %ymm2	# MEM[(__m256_u * {ref-all})_256 + 96B], _55, tmp230
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:1029:   __builtin_ia32_movntps256 (__P, (__v8sf)__A);
	vmovntps	%ymm5, -128(%rdx)	# tmp221,
	vmovntps	%ymm4, -96(%rdx)	# tmp224,
	vmovntps	%ymm3, -64(%rdx)	# tmp227,
	vmovntps	%ymm2, -32(%rdx)	# tmp230,
# saxpyImproved.cpp:38:     for (; i <= N - 32; i += 32) {
	cmpq	%r10, %rax	# _185, ivtmp.149
	jne	.L40	#,
	leal	1(%r11), %edx	#, tmp240
	sall	$5, %edx	#, tmp.97
.L39:
# saxpyImproved.cpp:64:     for (; i <= N - 8; i += 8) {
	leal	-7(%r9), %eax	#, tmp241
	cmpl	%edx, %eax	# tmp.97, tmp241
	jle	.L41	#,
	leal	-8(%r9), %r10d	#, tmp242
	movslq	%edx, %rcx	# tmp.97, _177
	subl	%edx, %r10d	# tmp.97, tmp243
	leaq	0(,%rcx,4), %rax	#, ivtmp.143
	shrl	$3, %r10d	#, _146
	leal	0(,%r10,8), %r11d	#, tmp246
	leaq	8(%rcx,%r11), %rcx	#, tmp247
	salq	$2, %rcx	#, _98
	.p2align 4,,10
	.p2align 3
.L42:
# /usr/lib/gcc/x86_64-linux-gnu/13/include/fmaintrin.h:65:   return (__m256)__builtin_ia32_vfmaddps256 ((__v8sf)__A, (__v8sf)__B,
	vmovups	(%rsi,%rax), %ymm2	# MEM[(__m256_u * {ref-all})X_48(D) + ivtmp.143_174 * 1], tmp248
	vfmadd213ps	(%rdi,%rax), %ymm1, %ymm2	# MEM[(__m256_u * {ref-all})Y_49(D) + ivtmp.143_174 * 1], _55, tmp248
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:1029:   __builtin_ia32_movntps256 (__P, (__v8sf)__A);
	vmovntps	%ymm2, (%r8,%rax)	# tmp248,* ivtmp.143
# saxpyImproved.cpp:64:     for (; i <= N - 8; i += 8) {
	addq	$32, %rax	#, ivtmp.143
	cmpq	%rax, %rcx	# ivtmp.143, _98
	jne	.L42	#,
	leal	8(%rdx,%r10,8), %edx	#, tmp.97
.L41:
# /usr/lib/gcc/x86_64-linux-gnu/13/include/xmmintrin.h:1304:   __builtin_ia32_sfence ();
	sfence	
# saxpyImproved.cpp:73:     for (; i < N; ++i) {
	cmpl	%edx, %r9d	# tmp.97, N
	jle	.L74	#,
# saxpyImproved.cpp:31: {
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movl	%r9d, %r11d	# N, niters.94
	movslq	%edx, %rax	# tmp.97, ivtmp.113
	subl	%edx, %r11d	# tmp.97, niters.94
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
	pushq	%r14	#
	pushq	%r13	#
	pushq	%r12	#
	.cfi_offset 14, -24
	.cfi_offset 13, -32
	.cfi_offset 12, -40
	leal	-1(%r11), %r12d	#, _112
	pushq	%rbx	#
	.cfi_offset 3, -48
	cmpl	$2, %r12d	#, _112
	jbe	.L50	#,
	leaq	0(,%rax,4), %r10	#, _109
	leaq	(%r8,%r10), %rbx	#, _108
	leaq	4(%r10), %rcx	#, _105
	leaq	(%rdi,%rcx), %r14	#, tmp254
	movq	%rbx, %r13	# _108, tmp255
	subq	%r14, %r13	# tmp254, tmp255
	cmpq	$24, %r13	#, tmp255
	jbe	.L50	#,
	addq	%rsi, %rcx	# X, tmp258
	movq	%rbx, %r13	# _108, tmp259
	subq	%rcx, %r13	# tmp258, tmp259
	cmpq	$24, %r13	#, tmp259
	jbe	.L50	#,
	cmpl	$6, %r12d	#, _112
	jbe	.L53	#,
	movl	%r11d, %r12d	# niters.94, bnd.81
	leaq	(%rsi,%r10), %r13	#, vectp.85
# saxpyImproved.cpp:73:     for (; i < N; ++i) {
	xorl	%ecx, %ecx	# ivtmp.125
	addq	%rdi, %r10	# Y, vectp.89
	shrl	$3, %r12d	#,
	salq	$5, %r12	#, _200
	.p2align 4,,10
	.p2align 3
.L46:
# saxpyImproved.cpp:74:         result[i] = scale * X[i] + Y[i];
	vmovups	0(%r13,%rcx), %ymm2	# MEM <vector(8) float> [(float *)vectp.85_175 + ivtmp.125_217 * 1], vect__37.91
	vfmadd213ps	(%r10,%rcx), %ymm1, %ymm2	# MEM <vector(8) float> [(float *)vectp.89_183 + ivtmp.125_217 * 1], _55, vect__37.91
# saxpyImproved.cpp:74:         result[i] = scale * X[i] + Y[i];
	vmovups	%ymm2, (%rbx,%rcx)	# vect__37.91, MEM <vector(8) float> [(float *)_108 + ivtmp.125_217 * 1]
	addq	$32, %rcx	#, ivtmp.125
	cmpq	%rcx, %r12	# ivtmp.125, _200
	jne	.L46	#,
	movl	%r11d, %ecx	# niters.94, niters_vector_mult_vf.82
	andl	$-8, %ecx	#,
	addl	%ecx, %edx	# niters_vector_mult_vf.82, tmp.97
	testb	$7, %r11b	#, niters.94
	je	.L72	#,
	subl	%ecx, %r11d	# niters_vector_mult_vf.82, niters.94
	leal	-1(%r11), %r10d	#, tmp267
	cmpl	$2, %r10d	#, tmp267
	jbe	.L48	#,
.L45:
	addq	%rcx, %rax	# niters_vector_mult_vf.82, tmp269
# saxpyImproved.cpp:74:         result[i] = scale * X[i] + Y[i];
	vshufps	$0, %xmm0, %xmm0, %xmm1	# scale, tmp271
	vmovups	(%rdi,%rax,4), %xmm6	# MEM <vector(4) float> [(float *)vectp.103_239], tmp296
	vfmadd132ps	(%rsi,%rax,4), %xmm6, %xmm1	# MEM <vector(4) float> [(float *)vectp.99_229], tmp296, vect__158.105
# saxpyImproved.cpp:74:         result[i] = scale * X[i] + Y[i];
	vmovups	%xmm1, (%r8,%rax,4)	# vect__158.105, MEM <vector(4) float> [(float *)vectp.107_248]
	movl	%r11d, %eax	# niters.94, niters_vector_mult_vf.96
	andl	$-4, %eax	#, niters_vector_mult_vf.96
	addl	%eax, %edx	# niters_vector_mult_vf.96, tmp.97
	andl	$3, %r11d	#, niters.94
	je	.L72	#,
.L48:
# saxpyImproved.cpp:74:         result[i] = scale * X[i] + Y[i];
	movslq	%edx, %rcx	# tmp.97, tmp.97
# saxpyImproved.cpp:74:         result[i] = scale * X[i] + Y[i];
	vmovss	(%rsi,%rcx,4), %xmm1	# *_31, _52
# saxpyImproved.cpp:74:         result[i] = scale * X[i] + Y[i];
	leaq	0(,%rcx,4), %rax	#, _30
# saxpyImproved.cpp:74:         result[i] = scale * X[i] + Y[i];
	vfmadd213ss	(%rdi,%rcx,4), %xmm0, %xmm1	# *_34, scale, _52
# saxpyImproved.cpp:73:     for (; i < N; ++i) {
	leal	1(%rdx), %ecx	#, i
# saxpyImproved.cpp:74:         result[i] = scale * X[i] + Y[i];
	vmovss	%xmm1, (%r8,%rax)	# _52, *_37
# saxpyImproved.cpp:73:     for (; i < N; ++i) {
	cmpl	%ecx, %r9d	# i, N
	jle	.L72	#,
# saxpyImproved.cpp:74:         result[i] = scale * X[i] + Y[i];
	vmovss	4(%rsi,%rax), %xmm1	# *_155, _144
# saxpyImproved.cpp:73:     for (; i < N; ++i) {
	addl	$2, %edx	#, i
# saxpyImproved.cpp:74:         result[i] = scale * X[i] + Y[i];
	vfmadd213ss	4(%rdi,%rax), %xmm0, %xmm1	# *_158, scale, _144
# saxpyImproved.cpp:74:         result[i] = scale * X[i] + Y[i];
	vmovss	%xmm1, 4(%r8,%rax)	# _144, *_198
# saxpyImproved.cpp:73:     for (; i < N; ++i) {
	cmpl	%edx, %r9d	# i, N
	jle	.L72	#,
# saxpyImproved.cpp:74:         result[i] = scale * X[i] + Y[i];
	vmovss	8(%rdi,%rax), %xmm7	# *_210, tmp300
	vfmadd132ss	8(%rsi,%rax), %xmm7, %xmm0	# *_207, tmp300, _213
# saxpyImproved.cpp:74:         result[i] = scale * X[i] + Y[i];
	vmovss	%xmm0, 8(%r8,%rax)	# _213, *_212
.L72:
	vzeroupper
# saxpyImproved.cpp:76: }
	popq	%rbx	#
	popq	%r12	#
	popq	%r13	#
	popq	%r14	#
	popq	%rbp	#
	.cfi_remember_state
	.cfi_def_cfa 7, 8
	ret	
	.p2align 4,,10
	.p2align 3
.L50:
	.cfi_restore_state
# saxpyImproved.cpp:74:         result[i] = scale * X[i] + Y[i];
	vmovss	(%rsi,%rax,4), %xmm1	# MEM[(float *)X_48(D) + ivtmp.113_230 * 4], _141
	vfmadd213ss	(%rdi,%rax,4), %xmm0, %xmm1	# MEM[(float *)Y_49(D) + ivtmp.113_230 * 4], scale, _141
# saxpyImproved.cpp:74:         result[i] = scale * X[i] + Y[i];
	vmovss	%xmm1, (%r8,%rax,4)	# _141, MEM[(float *)result_50(D) + ivtmp.113_230 * 4]
# saxpyImproved.cpp:73:     for (; i < N; ++i) {
	incq	%rax	# ivtmp.113
	cmpl	%eax, %r9d	# ivtmp.113, N
	jg	.L50	#,
	jmp	.L72	#
	.p2align 4,,10
	.p2align 3
.L74:
	.cfi_def_cfa 7, 8
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 14
	vzeroupper
	ret	
	.p2align 4,,10
	.p2align 3
.L52:
# saxpyImproved.cpp:34:     int i = 0;
	xorl	%edx, %edx	# tmp.97
	jmp	.L39	#
.L53:
	.cfi_def_cfa 6, 16
	.cfi_offset 3, -48
	.cfi_offset 6, -16
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
# saxpyImproved.cpp:73:     for (; i < N; ++i) {
	xorl	%ecx, %ecx	#
	jmp	.L45	#
	.cfi_endproc
.LFE6445:
	.size	_Z21saxpyImprovedUnrolledifPfS_S_, .-_Z21saxpyImprovedUnrolledifPfS_S_
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
