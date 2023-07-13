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

# Avoid trying to compile a Swift program for the host.
set(CMAKE_Swift_COMPILER_WORKS YES)

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
include(cmake/modules.cmake)
include(cmake/macros.cmake)

# Show toolchain used.
message(STATUS "Using toolchain ${CMAKE_TOOLCHAIN_FILE}")

# Find checked-out firmware libraries.
find_firmware(ALL_FIRMWARE)

# Find and check boards.
find_boards(ALL_BOARDS)
check_boards(ALL_BOARDS)

# Find projects.
find_projects(ALL_PROJECTS)

# Build all projects for the given boards.
build_projects_for_boards("${PROJECTS}" "${BOARDS}" "${ALL_PROJECTS}")
