cmake_minimum_required(VERSION 3.22)

# Cross-compiling: configure with
#   cmake -S firmware -B build -DCMAKE_TOOLCHAIN_FILE=cmake/gcc-arm-none-eabi.cmake
if(NOT CMAKE_TOOLCHAIN_FILE)
    message(WARNING
        "No toolchain file set. Configure with:\n"
        "  cmake -S firmware -B build -DCMAKE_TOOLCHAIN_FILE=cmake/gcc-arm-none-eabi.cmake")
endif()

project(secure_delta_ota C ASM)

add_subdirectory(bootloader)

# TODO(Phase 3+): add_subdirectory(app) once app firmware exists.
