/*
Copyright (c) 2015 - present Advanced Micro Devices, Inc. All rights reserved.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
*/


#include "hip/hip_runtime.h"
#include "hip/hip_runtime_api.h"
#include <iostream>
#include <fstream>
#include <vector>

#ifdef __HIP_PLATFORM_HCC__
#include <hip/hip_hcc.h>
#endif

#define LEN 64
#define SIZE LEN << 2

#define HIP_CHECK(status)                                                                          \
    if (status != hipSuccess) {                                                                    \
        std::cout << "Got Status: " << status << " at Line: " << __LINE__ << std::endl;            \
        exit(0);                                                                                   \
    }

int main(int argc, char** argv) {
    hipDeviceptr_t Ad, Bd;

    hipInit(0);
    hipDevice_t device;
    hipCtx_t context;
    hipModule_t Module;
    hipFunction_t Function;
    hipDeviceGet(&device, 0);
    hipCtxCreate(&context, 0, device);

    if (argc >= 3)
    {
        std::cout << argv[1] << " " << argv[2] << std::endl;
        HIP_CHECK(hipModuleLoad(&Module, argv[1]));
        HIP_CHECK(hipModuleGetFunction(&Function, Module, argv[2]));
        std::cout << "func "<< Function << " PASSED!\n";
    }
    else
    {
        std::cout << "module file kernel\n";
    }

    hipCtxDestroy(context);
    return 0;
}
