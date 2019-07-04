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


.amd_amdgpu_hsa_metadata
  Version: [ 1, 0 ]
  Printf: [ '1:1:4:%d\n', '2:1:8:%g\n' ]
  Kernels:
    - Name:            hello_world
      SymbolName:      hello_world@kd
      Language:        OpenCL C
      LanguageVersion: [ 2, 0 ]
      Attrs:
        ReqdWorkGroupSize: [ 1, 2, 4 ]
        WorkGroupSizeHint: [ 8, 16, 32 ]
        VecTypeHint:       int
      CodeProps:
        KernargSegmentSize:      24
        GroupSegmentFixedSize:   24
        PrivateSegmentFixedSize: 16
        KernargSegmentAlign:     16
        WavefrontSize:           64
        MaxFlatWorkGroupSize:    256
        NumSpilledSGPRs:         1
        NumSpilledVGPRs:         1
      Args:
        - TypeName:      char
          Size:          1
          Align:         1
          ValueKind:     ByValue
          ValueType:     I8
          AccQual:       Default
        - Size:          8
          Align:         8
          ValueKind:     HiddenGlobalOffsetX
          ValueType:     I64
        - Size:          8
          Align:         8
          ValueKind:     HiddenGlobalOffsetY
          ValueType:     I64
        - Size:          8
          Align:         8
          ValueKind:     HiddenGlobalOffsetZ
          ValueType:     I64
        - Size:          8
          Align:         8
          ValueKind:     HiddenPrintfBuffer
          ValueType:     I8
          AddrSpaceQual: Global
.end_amd_amdgpu_hsa_metadata
