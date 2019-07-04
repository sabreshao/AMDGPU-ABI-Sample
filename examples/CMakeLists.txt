################################################################################
##
## The University of Illinois/NCSA
## Open Source License (NCSA)
##
## Copyright (c) 2016, Advanced Micro Devices, Inc. All rights reserved.
##
## Developed by:
##
##                 AMD Research and AMD HSA Software Development
##
##                 Advanced Micro Devices, Inc.
##
##                 www.amd.com
##
## Permission is hereby granted, free of charge, to any person obtaining a copy
## of this software and associated documentation files (the "Software"), to
## deal with the Software without restriction, including without limitation
## the rights to use, copy, modify, merge, publish, distribute, sublicense,
## and#or sell copies of the Software, and to permit persons to whom the
## Software is furnished to do so, subject to the following conditions:
##
##  - Redistributions of source code must retain the above copyright notice,
##    this list of conditions and the following disclaimers.
##  - Redistributions in binary form must reproduce the above copyright
##    notice, this list of conditions and the following disclaimers in
##    the documentation and#or other materials provided with the distribution.
##  - Neither the names of Advanced Micro Devices, Inc,
##    nor the names of its contributors may be used to endorse or promote
##    products derived from this Software without specific prior written
##    permission.
##
## THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
## IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
## FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
## THE CONTRIBUTORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
## OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
## ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
## DEALINGS WITH THE SOFTWARE.
##
################################################################################

set(CLANG "/opt/rocm/opencl/bin/x86_64/clang")
set(CLANG-OCL "/opt/rocm/bin/clang-ocl")
set(OPENCL_BC "/opt/rocm/opencl/lib/x86_64/bitcode")
set(OPENCL_HDR "/opt/rocm/opencl/include")


macro(asm_assemble f)
add_custom_command(
  OUTPUT ${f}.o
  COMMAND
    ${CLANG} -x assembler -mcode-object-v3  -target amdgcn--amdhsa -mcpu=gfx906 -c -o ${f}.o ${CMAKE_CURRENT_SOURCE_DIR}/${f}.s
  DEPENDS ${f}.s
  COMMENT "Assembling ${f}.s to ${f}.o"
)
endmacro(asm_assemble)

macro(asm_assemble_v2 f)
add_custom_command(
  OUTPUT ${f}.o
  COMMAND
    ${CLANG} -x assembler -mno-code-object-v3   -target amdgcn--amdhsa -mcpu=gfx906 -c -o ${f}.o ${CMAKE_CURRENT_SOURCE_DIR}/${f}.s
  DEPENDS ${f}.s
  COMMENT "Assembling ${f}.s to ${f}.o"
)
endmacro(asm_assemble_v2)


macro(asm_link f)
add_custom_command(
  OUTPUT ${f}.co
  COMMAND
    ${CLANG} -target amdgcn--amdhsa ${f}.o -o ${f}.co
  DEPENDS ${f}.o
  COMMENT "Linking ${f}.o to ${f}.co with clang"
)
endmacro(asm_link)

macro(asm_example f)
  asm_assemble(${f})
  asm_link(${f})
  add_custom_target(${f}_co ALL DEPENDS ${f}.co)
  install(FILES ${CMAKE_CURRENT_BINARY_DIR}/${f}.co DESTINATION bin COMPONENT examples)
endmacro(asm_example)

macro(asm_example_v2 f)
  asm_assemble_v2(${f})
  asm_link(${f})
  add_custom_target(${f}_co ALL DEPENDS ${f}.co)
  install(FILES ${CMAKE_CURRENT_BINARY_DIR}/${f}.co DESTINATION bin COMPONENT examples)
endmacro(asm_example_v2)

macro(ocl_example f)
  add_custom_command(
    OUTPUT ${f}.so
    COMMAND 
    ${CLANG-OCL} -mcpu=gfx906 -o ${f}.so ${CMAKE_CURRENT_SOURCE_DIR}/${f}.cl
    DEPENDS ${f}.cl
    COMMENT "Building ${f}.cl to ${f}.so"
  )
  add_custom_target(${f}_co ALL DEPENDS ${f}.so)
  install(FILES ${CMAKE_CURRENT_BINARY_DIR}/${f}.so DESTINATION bin COMPONENT examples)
endmacro(ocl_example)

add_subdirectory(asmv2)
add_subdirectory(asmv3)
add_subdirectory(ocl)
add_subdirectory(hiploader)
add_subdirectory(oclloader)
