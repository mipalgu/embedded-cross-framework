set(CMAKE_SYSTEM_PROCESSOR ARM)
set(CMAKE_SYSTEM_NAME Generic)

set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

# Executable file extension
IF(WIN32)
    SET(TOOLCHAIN_EXE ".exe")
ELSE()
    SET(TOOLCHAIN_EXE "")
ENDIF()

# The triplet to use for the target
SET(TARGET_TRIPLET "arm-none-eabi")

find_program(TOOLCHAIN_COMPILER "clang${TOOLCHAIN_EXE}")
find_program(TOOLCHAIN_UTIL "${TARGET_TRIPLET}-objcopy${TOOLCHAIN_EXE}")
MESSAGE(STATUS "TOOLCHAIN_COMPILER: " ${TOOLCHAIN_COMPILER})
MESSAGE(STATUS "TOOLCHAIN_OBJCOPY:  " ${TOOLCHAIN_UTIL})
get_filename_component(ARM_EABI_TOOLCHAIN_DIR ${TOOLCHAIN_COMPILER} DIRECTORY)
get_filename_component(ARM_EABI_UTILS_DIR ${TOOLCHAIN_UTIL} DIRECTORY)
find_file(TOOLCHAIN_STRING_H NAMES "string.h" PATHS ${ARM_EABI_UTILS_DIR}/../${TARGET_TRIPLET}/include /usr/local/${TARGET_TRIPLET}/include /usr/${TARGET_TRIPLET}/include /usr/include/${TARGET_TRIPLET} /Applications/ArmGNUToolchain/*/${TARGET_TRIPLET}/${TARGET_TRIPLET}/include /Applications/Developer/ArmGNUToolchain/*/${TARGET_TRIPLET}/${TARGET_TRIPLET}/include  /Applications/Devel/ArmGNUToolchain/*/${TARGET_TRIPLET}/${TARGET_TRIPLET}/include)
get_filename_component(ARM_EABI_TOOLCHAIN_INCLUDE_DIR ${TOOLCHAIN_STRING_H} DIRECTORY)
find_library(TOOLCHAIN_LIBC NAMES "c" PATHS ${ARM_EABI_UTILS_DIR}/../${TARGET_TRIPLET}/lib /usr/local/${TARGET_TRIPLET}/lib /usr/${TARGET_TRIPLET}/lib /usr/lib/${TARGET_TRIPLET} /Applications/ArmGNUToolchain/*/${TARGET_TRIPLET}/${TARGET_TRIPLET}/lib /Applications/Developer/ArmGNUToolchain/*/${TARGET_TRIPLET}/${TARGET_TRIPLET}/lib  /Applications/Devel/ArmGNUToolchain/*/${TARGET_TRIPLET}/${TARGET_TRIPLET}/lib)
get_filename_component(ARM_EABI_TOOLCHAIN_LIB_DIR ${TOOLCHAIN_LIBC} DIRECTORY)
find_library(TOOLCHAIN_LIBGCC NAMES "gcc" PATHS ${ARM_EABI_UTILS_DIR}/../lib/gcc/${TARGET_TRIPLET}/* /usr/local/${TARGET_TRIPLET}/lib/gcc/* /usr/${TARGET_TRIPLET}/lib/gcc/* /usr/lib/gcc/${TARGET_TRIPLET}/* /Applications/ArmGNUToolchain/*/${TARGET_TRIPLET}/lib/gcc/${TARGET_TRIPLET}/* /Applications/Developer/ArmGNUToolchain/*/${TARGET_TRIPLET}/lib/gcc/${TARGET_TRIPLET}/*  /Applications/Devel/ArmGNUToolchain/*/${TARGET_TRIPLET}/lib/gcc/${TARGET_TRIPLET}/*)
get_filename_component(ARM_EABI_TOOLCHAIN_LIBGCC_DIR ${TOOLCHAIN_LIBGCC} DIRECTORY)
set(TOOLCHAIN_INCLUDE_DIRS ${ARM_EABI_TOOLCHAIN_INCLUDE_DIR})
set(TOOLCHAIN_LIBDIR ${ARM_EABI_TOOLCHAIN_LIB_DIR})
set(TOOLCHAIN_LIBGCC_DIR ${ARM_EABI_TOOLCHAIN_LIBGCC_DIR})
#set(TOOLCHAIN_LINKER_FLAG "-Xlinker")
set(TOOLCHAIN_LINKER_PREFIX "-Wl,")
#set(TOOLCHAIN_LINKER_EXTRA_LDFLAGS ${TOOLCHAIN_LINKER_PREFIX}--print-memory-usage)
MESSAGE(STATUS "TOOLCHAIN_INCLUDE_DIR: " ${TOOLCHAIN_INCLUDE_DIRS})
MESSAGE(STATUS "TOOLCHAIN_LIBRARY_DIR: " ${TOOLCHAIN_LIBDIR})
MESSAGE(STATUS "TOOLCHAIN_LIBGCC_DIR: " ${TOOLCHAIN_LIBGCC_DIR})

set(ARM_EABI_BINUTILS_PATH ${ARM_EABI_TOOLCHAIN_DIR}) 
set(TOOLCHAIN_COMPILER_PREFIX ${ARM_EABI_TOOLCHAIN_DIR}/${TARGET_TRIPLET})
set(TOOLCHAIN_PREFIX ${ARM_EABI_UTILS_DIR}/${TARGET_TRIPLET})

set(CMAKE_OBJCOPY ${TOOLCHAIN_PREFIX}-objcopy${TOOLCHAIN_EXE} CACHE INTERNAL "objcopy tool")
set(CMAKE_OBJDUMP ${TOOLCHAIN_PREFIX}-objdump${TOOLCHAIN_EXE} CACHE INTERNAL "objdump tool")
set(CMAKE_RANLIB ${TOOLCHAIN_PREFIX}-ranlib${TOOLCHAIN_EXE} CACHE INTERNAL "ranlib tool")
set(CMAKE_READELF ${TOOLCHAIN_PREFIX}-readelf${TOOLCHAIN_EXE} CACHE INTERNAL "readelf tool")
set(CMAKE_SIZE ${TOOLCHAIN_PREFIX}-size${TOOLCHAIN_EXE} CACHE INTERNAL "size tool")
set(CMAKE_STRIP ${TOOLCHAIN_PREFIX}-strip{TOOLCHAIN_EXE} CACHE INTERNAL "strip tool")
set(CMAKE_AR ${TOOLCHAIN_PREFIX}-ar${TOOLCHAIN_EXE} CACHE INTERNAL "ar tool")
set(CMAKE_NM ${TOOLCHAIN_PREFIX}-nm${TOOLCHAIN_EXE} CACHE INTERNAL "nm tool")
set(CMAKE_LINKER ${TOOLCHAIN_PREFIX}-ld${TOOLCHAIN_EXE} CACHE INTERNAL "ld tool")

set(CMAKE_C_COMPILER "clang${TOOLCHAIN_EXE}")
set(CMAKE_CXX_COMPILER "clang++${TOOLCHAIN_EXE}")
set(CMAKE_ASM_COMPILER "clang${TOOLCHAIN_EXE}")
set(CMAKE_Swift_COMPILER "swiftc${TOOLCHAIN_EXE}")

set(TOOLCHAIN_TARGET_FLAGS "-target ${TARGET_TRIPLET}")
#set(TOOLCHAIN_C_FLAGS ${TOOLCHAIN_TARGET_FLAGS})
#set(TOOLCHAIN_CXX_FLAGS ${TOOLCHAIN_TARGET_FLAGS})
#set(TOOLCHAIN_ASM_FLAGS ${TOOLCHAIN_TARGET_FLAGS})
set(TOOLCHAIN_LINK_FLAGS "-fuse-ld=${CMAKE_LINKER}")

set(CMAKE_C_FLAGS "${TOOLCHAIN_TARGET_FLAGS} -nostdlib")
set(CMAKE_CXX_FLAGS "${TOOLCHAIN_TARGET_FLAGS} -nostdlib")
set(CMAKE_ASM_FLAGS "${TOOLCHAIN_TARGET_FLAGS}")
set(CMAKE_Swift_FLAGS "${TOOLCHAIN_TARGET_FLAGS} -parse-stdlib")
set(CMAKE_LINK_FLAGS "${TOOLCHAIN_TARGET_FLAGS} -fuse-ld=${CMAKE_LINKER} -nostdlib")

set(CMAKE_FIND_ROOT_PATH ${ARM_EABI_BINUTILS_PATH})
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

# Common flags for Arm CPUs
#
# CPU core
set(ARM_CPU_CORTEX_M0_FLAGS "-mcpu=cortex-m0")
set(ARM_CPU_CORTEX_M0_SMALL_FLAGS "-mcpu=cortex-m0.small-multiply")
set(ARM_CPU_CORTEX_M0PLUS_FLAGS "-mcpu=cortex-m0plus")
set(ARM_CPU_CORTEX_M0PLUS_SMALL_FLAGS "-mcpu=cortex-m0plus.small-multiply")
set(ARM_CPU_CORTEX_M1_FLAGS "-mcpu=cortex-m1")
set(ARM_CPU_CORTEX_M1_SMALL_FLAGS "-mcpu=cortex-m1.small-multiply")
set(ARM_CPU_CORTEX_M3_FLAGS "-mcpu=cortex-m3")
set(ARM_CPU_CORTEX_M23_FLAGS "-mcpu=cortex-m23")
set(ARM_CPU_CORTEX_M33_FLAGS "-mcpu=cortex-m33")
set(ARM_CPU_CORTEX_M35P_FLAGS "-mcpu=cortex-m35p")
set(ARM_CPU_CORTEX_M4_FLAGS "-mcpu=cortex-m4")
set(ARM_CPU_CORTEX_M55_FLAGS "-mcpu=cortex-m55")
set(ARM_CPU_CORTEX_M7_FLAGS "-mcpu=cortex-m7")

set(ARM_CPU_CORTEX_R4_FLAGS "-mcpu=cortex-r4")
set(ARM_CPU_CORTEX_R4F_FLAGS "-mcpu=cortex-r4f")
set(ARM_CPU_CORTEX_R5_FLAGS "-mcpu=cortex-r5")
set(ARM_CPU_CORTEX_R7_FLAGS "-mcpu=cortex-r7")
set(ARM_CPU_CORTEX_R8_FLAGS "-mcpu=cortex-r8")
set(ARM_CPU_CORTEX_R52_FLAGS "-mcpu=cortex-r52")
set(ARM_CPU_CORTEX_R52_PLUS_FLAGS "-mcpu=cortex-r52plus")

set(ARM_CPU_CORTEX_A5_FLAGS "-mcpu=cortex-a5")
set(ARM_CPU_CORTEX_A7_FLAGS "-mcpu=cortex-a7")
set(ARM_CPU_CORTEX_A8_FLAGS "-mcpu=cortex-a8")
set(ARM_CPU_CORTEX_A9_FLAGS "-mcpu=cortex-a9")
set(ARM_CPU_CORTEX_A12_FLAGS "-mcpu=cortex-a12")
set(ARM_CPU_CORTEX_A15_FLAGS "-mcpu=cortex-a15")
set(ARM_CPU_CORTEX_A15_A7_FLAGS "-mcpu=cortex-a15.cortex-a7")
set(ARM_CPU_CORTEX_A17_FLAGS "-mcpu=cortex-a17")
set(ARM_CPU_CORTEX_A17_A7_FLAGS "-mcpu=cortex-a17.cortex-a7")
set(ARM_CPU_CORTEX_A32_FLAGS "-mcpu=cortex-a32")
set(ARM_CPU_CORTEX_A35_FLAGS "-mcpu=cortex-a35")
set(ARM_CPU_CORTEX_A53_FLAGS "-mcpu=cortex-a53")
set(ARM_CPU_CORTEX_A55_FLAGS "-mcpu=cortex-a55")
set(ARM_CPU_CORTEX_A57_FLAGS "-mcpu=cortex-a57")
set(ARM_CPU_CORTEX_A57_A53_FLAGS "-mcpu=cortex-a57.cortex-a53")
set(ARM_CPU_CORTEX_A72_FLAGS "-mcpu=cortex-a72")
set(ARM_CPU_CORTEX_A72_A53_FLAGS "-mcpu=cortex-a72.cortex-a53")
set(ARM_CPU_CORTEX_A73_FLAGS "-mcpu=cortex-a73")
set(ARM_CPU_CORTEX_A73_A35_FLAGS "-mcpu=cortex-a73.cortex-a35")
set(ARM_CPU_CORTEX_A73_A53_FLAGS "-mcpu=cortex-a73.cortex-a53")
set(ARM_CPU_CORTEX_A75_FLAGS "-mcpu=cortex-a75")
set(ARM_CPU_CORTEX_A75_A55_FLAGS "-mcpu=cortex-a75.cortex-a55")
set(ARM_CPU_CORTEX_A76_FLAGS "-mcpu=cortex-a76")
set(ARM_CPU_CORTEX_A76_A55_FLAGS "-mcpu=cortex-a76.cortex-a55")
set(ARM_CPU_CORTEX_A76AE_FLAGS "-mcpu=cortex-a76ae")
set(ARM_CPU_CORTEX_A77_FLAGS "-mcpu=cortex-a77")
set(ARM_CPU_CORTEX_A78_FLAGS "-mcpu=cortex-a78")
set(ARM_CPU_CORTEX_A78AE_FLAGS "-mcpu=cortex-a78ae")
set(ARM_CPU_CORTEX_A78C_FLAGS "-mcpu=cortex-a78c")
set(ARM_CPU_CORTEX_A710_FLAGS "-mcpu=cortex-a710")

# Thumb-2
set(ARM_CPU_CORTEX_THUMB_FLAGS "-mthumb")
set(ARM_CPU_CORTEX_THUMB_INTERWORK_FLAGS "-mthumb")

# Floating point ABI
set(ARM_CPU_ABI_SOFT_FLOAT_FLAGS "-mfloat-abi=soft")
set(ARM_CPU_ABI_HARD_FLOAT_FLAGS "-mfloat-abi=hard")
set(ARM_FPU_NEON_FLAGS "-mfpu=neon")
set(ARM_FPU_NEON_VFPV3_FLAGS "-mfpu=neon-vfpv3")
set(ARM_FPU_NEON_VFPV4_FLAGS "-mfpu=neon-vfpv4")
set(ARM_FPU_NEON_FP16_FLAGS "-mfpu=neon-fp16")
set(ARM_FPU_V3_FLAGS "-mfpu=vfpv3")
set(ARM_FPU_V3_FP16_FLAGS "-mfpu=vfpv3-fp16")
set(ARM_FPU_V3_D16_FLAGS "-mfpu=vfpv3-d16")
set(ARM_FPU_V3_D16_FP16_FLAGS "-mfpu=vfpv3-d16-fp16")
set(ARM_FPU_V3XD_FLAGS "-mfpu=vfpv3xD")
set(ARM_FPU_V3XD_FP16_FLAGS "-mfpu=vfpv3xd-fp16")
set(ARM_FPU_V4_FLAGS "-mfpu=vfpv4")
set(ARM_FPU_V4_D16_FLAGS "-mfpu=vfpv4-d16")
set(ARM_FPU_V4_SP_D16_FLAGS "-mfpu=fpv4-sp-d16")
set(ARM_FPU_VFPV4_SP_D16_FLAGS "-mfpu=vfpv4-sp-d16")

# Linker specs
set(ARM_SPEC_NANO_LINKER_FLAGS "--specs=nano.specs")
set(ARM_SPEC_NOSYS_LINKER_FLAGS "--specs=nosys.specs")

# Toolchain link libraries
set(TOOLCHAIN_LIBS
    -Wl,--start-group
    m
    c
    gcc
    nosys
    -Wl,--end-group
)

# Use -Oz instead of -O3 in Release configuration
string(REPLACE "-O3" "-Oz" CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE}")
string(REPLACE "-O3" "-Oz" CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE}")

# Toolchain link libraries for clang
set(TOOLCHAIN_LINK_LIBS "clang_stubs")
#get_filename_component(TOOLCHAIN_LINK_LIBS_SOURCESUBDIR ${CMAKE_TOOLCHAIN_FILE} DIRECTORY)
set(TOOLCHAIN_LINK_LIBS_SOURCESUBDIR "toolchains/${TARGET_TRIPLET}-clang")
set(TOOLCHAIN_LINK_LIB_clang_stubs_SOURCES
    ${CMAKE_CURRENT_SOURCE_DIR}/${TOOLCHAIN_LINK_LIBS_SOURCESUBDIR}/clang_stubs.c
)