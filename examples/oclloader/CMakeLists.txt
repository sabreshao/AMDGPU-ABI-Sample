
set(MY_SOURCE_FILES oclloader.cpp)
set(MY_TARGET_NAME oclloader)

add_executable(${MY_TARGET_NAME} ${MY_SOURCE_FILES})



include_directories(/opt/rocm/opencl/include)
link_directories(/opt/rocm/opencl/lib)
link_libraries(libOpenCL)
target_link_libraries(${MY_TARGET_NAME} -lOpenCL -L/opt/rocm/opencl/lib)
