
.text
.globl hello_world
.p2align 8
.type hello_world,@function
hello_world:
s_load_dwordx2 s[0:1], s[0:1] 0x0
v_mov_b32 v0, 3.14159
s_waitcnt lgkmcnt(0)
v_mov_b32 v1, s0
v_mov_b32 v2, s1
flat_store_dword v[1:2], v0
s_endpgm
.Lfunc_end0:
.size   hello_world, .Lfunc_end0-hello_world

.rodata
.p2align 6
.amdhsa_kernel hello_world
.amdhsa_user_sgpr_kernarg_segment_ptr 1
.amdhsa_next_free_vgpr .amdgcn.next_free_vgpr
.amdhsa_next_free_sgpr .amdgcn.next_free_sgpr
.end_amdhsa_kernel

.amdgpu_metadata
---
amdhsa.version:
- 1
- 0
amdhsa.kernels:
- .name: hello_world
  .symbol: hello_world.kd
  .kernarg_segment_size: 48
  .group_segment_fixed_size: 0
  .private_segment_fixed_size: 0
  .kernarg_segment_align: 4
  .wavefront_size: 64
  .sgpr_count: 2
  .vgpr_count: 3
  .max_flat_workgroup_size: 256
...
.end_amdgpu_metadata
