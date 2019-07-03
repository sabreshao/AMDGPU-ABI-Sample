.hsa_code_object_version 2,1
.hsa_code_object_isa

.text
.globl  hello_world
.p2align 8
.type hello_world,@function
.amdgpu_hsa_kernel hello_world

hello_world:

  .amd_kernel_code_t
  enable_sgpr_kernarg_segment_ptr = 1
  is_ptr64 = 1
  compute_pgm_rsrc1_vgprs = 0
  compute_pgm_rsrc1_sgprs = 0
  compute_pgm_rsrc2_user_sgpr = 2
  .end_amd_kernel_code_t

  s_load_dwordx2 s[0:1], s[0:1] 0x0
  v_mov_b32 v0, 3.14159
  s_waitcnt lgkmcnt(0)
  v_mov_b32 v1, s0
  v_mov_b32 v2, s1
  flat_store_dword v[1:2], v0
  s_endpgm
.Lfunc_end0:
     .size   hello_world, .Lfunc_end0-hello_world
