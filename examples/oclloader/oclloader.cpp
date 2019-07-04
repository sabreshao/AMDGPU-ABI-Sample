#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <CL/opencl.h>
#include <iostream>
#include <fstream>


int main( int argc, char* argv[] )  
{
    cl_int err, berr;
    cl_mem d_c;
    cl_platform_id cpPlatform;        
    cl_device_id device_id;           
    cl_context context;     
    cl_command_queue queue;           // command queue
    cl_program program;               // program
    cl_kernel kernel;                 // kernel
    std::fstream file;
    const unsigned char* buffer;
    size_t file_size;

    err = clGetPlatformIDs(1, &cpPlatform, NULL);
    err = clGetDeviceIDs(cpPlatform, CL_DEVICE_TYPE_GPU, 1, &device_id, NULL);
    context = clCreateContext(0, 1, &device_id, NULL, NULL, &err);

    if (argc >= 3 || err != 0)
    {
      std::cout << argv[1] << " " << argv[2] << std::endl;
      file.open(argv[1], std::ios::in | std::ios::binary);
      file.seekg(0, std::ios_base::end);
      file_size = file.tellg();
      file.seekg(0);
      buffer = (unsigned char*)malloc(file_size);
      file.read((char*)buffer, file_size);
      program = clCreateProgramWithBinary(context, 1, &device_id, &file_size, &buffer, &berr, &err);
      std::cout << "program err " << err << " PASSED!\n";

      kernel  = clCreateKernel(program, argv[2], &err);
      
      std::cout << "kernel err " << err << " PASSED!\n";
      free((void*)buffer);
      clReleaseKernel(kernel);
      clReleaseProgram(program);
      file.close();
    }
    else
    {
      std::cout << "module file kernel\n";
    }

    clReleaseContext(context);
    return 0;
}


