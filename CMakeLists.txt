# CMake file for building your project
#
# To use one of the templates, use the `--preset` flag, e.g.:
#   cmake --preset=arm-none-eabi-gcc-debug
#
cmake_minimum_required(VERSION 3.21)

# Print out extra messages.
set(CMAKE_VERBOSE_MAKEFILE ON)

# Set the project name
project(EmbeddedProject C CXX ASM)
set(EXECUTABLE_NAME ${PROJECT_NAME}.elf)

# Require the C standard to be C17,
# but allow extensions.
set(CMAKE_C_STANDARD 17)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_C_EXTENSIONS ON)

# Require the C++ standard to be C++20,
# but allow extensions.
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS ON)

# Set the default build type to Release.
if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Release)
endif()

# Flags required for embedded development.
set(CMAKE_STATIC_LIBRARY_PREFIX)
set(CMAKE_STATIC_LIBRARY_SUFFIX)
set(CMAKE_EXECUTABLE_PREFIX)
set(CMAKE_EXECUTABLE_SUFFIX)

# Include layout and configuration
include(cmake/layout.cmake)
include(cmake/flags.cmake)
include(cmake/config.cmake)

# Show toolchain used.
message(STATUS "Using toolchain ${CMAKE_TOOLCHAIN_FILE}")

# Sources to compile
set(EmbeddedProject_SOURCES
  ${BOOT_SOURCES}
  ${OS_SOURCES}
  ${DRIVERS_SOURCES}
  ${CMAKE_CURRENT_SOURCE_DIR}/src/main.cpp
)

add_executable(${EXECUTABLE_NAME} ${EmbeddedProject_SOURCES})
target_include_directories(${EXECUTABLE_NAME} PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/include
    ${OS_INCLUDES}
    ${DRIVERS_INCLUDES}
)

# include modules
include(cmake/modules.cmake)

# Link libraries
target_link_libraries(${EXECUTABLE_NAME} PRIVATE
    ${TOOLCHAIN_LIBS}
    ${OS_LIBS}
    ${DRIVER_LIBS}
)

# Create hex, bin, and s-records
add_custom_command(TARGET ${EXECUTABLE_NAME} POST_BUILD
    COMMAND ${CMAKE_OBJCOPY} -Oihex $<TARGET_FILE:${EXECUTABLE_NAME}> ${EXECUTABLE_NAME}.hex
    COMMAND ${CMAKE_OBJCOPY} -Obinary $<TARGET_FILE:${EXECUTABLE_NAME}> ${EXECUTABLE_NAME}.bin
    COMMAND ${CMAKE_OBJCOPY} -Osrec --srec-len=64 $<TARGET_FILE:${EXECUTABLE_NAME}> ${EXECUTABLE_NAME}.s19
)

# Print the binary size
add_custom_command(TARGET ${EXECUTABLE_NAME} POST_BUILD
    COMMAND ${CMAKE_SIZE} ${EXECUTABLE_NAME}
)
