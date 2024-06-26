set(CMAKE_SYSTEM_PROCESSOR RISCV32)
set(CMAKE_SYSTEM_NAME ESP)

set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

# Executable file extension
IF(WIN32)
    SET(TOOLCHAIN_EXE ".exe")
ELSE()
    SET(TOOLCHAIN_EXE "")
ENDIF()

# The triplet to use for the target
SET(TARGET_TRIPLET "riscv32-esp-elf")

# Supported architectures
set(RISCV32_ESP_TARGET_ARCHS
    GENERIC
)
set(RISCV32_ESP_LIBDIR_GENERIC        ".")

# Supported ABIs
set(RISCV32_SUPPORTED_ABIS
    ILP32
    ILP32D
    ILP32E
    ILP32F
    LP64
    LP64D
    LP64F
)
set(RISCV32_ABI_ILP32 "ilp32")
set(RISCV32_ABI_ILP32D "ilp32d")
set(RISCV32_ABI_ILP32E "ilp32e")
set(RISCV32_ABI_ILP32F "ilp32f")
set(RISCV32_ABI_LP64 "lp64")
set(RISCV32_ABI_LP64D "lp64d")
set(RISCV32_ABI_LP64F "lp64f")

foreach(abi ${RISCV32_SUPPORTED_ABIS})
    set(RISCV32_ABI_${abi}_FLAGS "-mabi=${RISCV32_ABI_${abi}")
endforeach()

find_program(TOOLCHAIN_COMPILER "${TARGET_TRIPLET}-gcc${TOOLCHAIN_EXE}")
MESSAGE(STATUS "TOOLCHAIN_COMPILER: " ${TOOLCHAIN_COMPILER})
get_filename_component(RISCV32_ESP_TOOLCHAIN_DIR ${TOOLCHAIN_COMPILER} DIRECTORY)
find_file(TOOLCHAIN_STRING_H NAMES "string.h" PATHS ${RISCV32_ESP_TOOLCHAIN_DIR}/../${TARGET_TRIPLET}/include /usr/local/${TARGET_TRIPLET}/include /usr/${TARGET_TRIPLET}/include /usr/include/${TARGET_TRIPLET} /Applications/RiscVGNUToolchain/*/${TARGET_TRIPLET}/${TARGET_TRIPLET}/include /Applications/Developer/RiscVGNUToolchain/*/${TARGET_TRIPLET}/${TARGET_TRIPLET}/include  /Applications/Devel/RiscVGNUToolchain/*/${TARGET_TRIPLET}/${TARGET_TRIPLET}/include)
get_filename_component(RISCV32_ESP_TOOLCHAIN_INCLUDE_DIR ${TOOLCHAIN_STRING_H} DIRECTORY)
foreach(arch ${RISCV32_ESP_TARGET_ARCHS})
    # FIXME: go through ABIs and find ABI-specific library paths (including no-rtti variants)
    find_library(RISCV32_ESP_${arch}_TOOLCHAIN_LIBC NAMES "c" PATHS ${RISCV32_ESP_TOOLCHAIN_DIR}/../${TARGET_TRIPLET}/lib/${RISCV32_ESP_LIBDIR_${arch}} /usr/local/${TARGET_TRIPLET}/lib/${RISCV32_ESP_LIBDIR_${arch}} /usr/${TARGET_TRIPLET}/lib/${RISCV32_ESP_LIBDIR_${arch}} /usr/local/lib/${TARGET_TRIPLET}/lib/${RISCV32_ESP_LIBDIR_${arch}} /Applications/RiscVGNUToolchain/*/${TARGET_TRIPLET}/${TARGET_TRIPLET}/lib/${RISCV32_ESP_LIBDIR_${arch}} /Applications/Developer/RiscVGNUToolchain/*/${TARGET_TRIPLET}/${TARGET_TRIPLET}/lib/${RISCV32_ESP_LIBDIR_${arch}}  /Applications/Devel/RiscVGNUToolchain/*/${TARGET_TRIPLET}/${TARGET_TRIPLET}/lib/${RISCV32_ESP_LIBDIR_${arch}})
    get_filename_component(RISCV32_ESP_${arch}_TOOLCHAIN_LIB_DIR ${RISCV32_ESP_${arch}_TOOLCHAIN_LIBC} DIRECTORY)
    find_library(RISCV32_ESP_${arch}_TOOLCHAIN_LIBGCC NAMES "gcc" PATHS ${RISCV32_ESP_TOOLCHAIN_DIR}/../${TARGET_TRIPLET}/lib/gcc/${TARGET_TRIPLET}/*/${RISCV32_ESP_LIBDIR_${arch}} /usr/local/${TARGET_TRIPLET}/lib/gcc/${TARGET_TRIPLET}/*/${RISCV32_ESP_LIBDIR_${arch}} /usr/${TARGET_TRIPLET}/lib/gcc/${TARGET_TRIPLET}/*/${RISCV32_ESP_LIBDIR_${arch}} /usr/local/lib/gcc/${TARGET_TRIPLET}/*/${TARGET_TRIPLET}/lib/${RISCV32_ESP_LIBDIR_${arch}} /Applications/RiscVGNUToolchain/*/${TARGET_TRIPLET}/lib/gcc/${TARGET_TRIPLET}/*/${RISCV32_ESP_LIBDIR_${arch}} /Applications/Developer/RiscVGNUToolchain/*/${TARGET_TRIPLET}/lib/gcc/${TARGET_TRIPLET}/*/${RISCV32_ESP_LIBDIR_${arch}}  /Applications/Devel/RiscVGNUToolchain/*/${TARGET_TRIPLET}/lib/gcc/${TARGET_TRIPLET}/*/${RISCV32_ESP_LIBDIR_${arch}})
    get_filename_component(RISCV32_ESP_${arch}_TOOLCHAIN_LIBGCC_DIR ${RISCV32_ESP_${arch}_TOOLCHAIN_LIBGCC} DIRECTORY)
    set(TOOLCHAIN_${arch}_INCLUDE_DIRS ${RISCV32_ESP_TOOLCHAIN_INCLUDE_DIR})
    set(TOOLCHAIN_${arch}_LIBDIR ${RISCV32_ESP_${arch}_TOOLCHAIN_LIB_DIR})
    set(TOOLCHAIN_${arch}_LIBGCC_DIR ${RISCV32_ESP_${arch}_TOOLCHAIN_LIBGCC_DIR})
    #set(TOOLCHAIN_LINKER_FLAG "-Xlinker")
    set(TOOLCHAIN_${arch}_LINKER_PREFIX "-Wl,")
    set(TOOLCHAIN_${arch}_LINKER_EXTRA_LDFLAGS ${TOOLCHAIN_LINKER_PREFIX}--print-memory-usage)
    #MESSAGE(STATUS "TOOLCHAIN_${arch}_LIBDIR: " ${TOOLCHAIN_${arch}_LIBDIR})
    #MESSAGE(STATUS "TOOLCHAIN_${arch}_LIBGCC: " ${TOOLCHAIN_${arch}_LIBGCC_DIR})
endforeach()

set(TOOLCHAIN_INCLUDE_DIRS ${RISCV32_ESP_TOOLCHAIN_INCLUDE_DIR})
set(TOOLCHAIN_LIBDIR ${RISCV32_ESP_GENERIC_TOOLCHAIN_LIB_DIR})
set(TOOLCHAIN_LIBGCC_DIR ${RISCV32_ESP_GENERIC_TOOLCHAIN_LIBGCC_DIR})
#set(TOOLCHAIN_LINKER_FLAG "-Xlinker")
set(TOOLCHAIN_LINKER_PREFIX "-Wl,")
set(TOOLCHAIN_XLINKER_PREFIX "-Xlinker")
set(TOOLCHAIN_LINKER_SCRIPT_PREFIX "-T")
set(TOOLCHAIN_LINKER_SCRIPT_FLAGS ${TOOLCHAIN_XLINKER_PREFIX} ${TOOLCHAIN_LINKER_SCRIPT_PREFIX})
set(TOOLCHAIN_LINKER_EXTRA_LDFLAGS ${TOOLCHAIN_LINKER_PREFIX}--print-memory-usage)
MESSAGE(STATUS "TOOLCHAIN_INCLUDE_DIR: " ${TOOLCHAIN_INCLUDE_DIRS})
MESSAGE(STATUS "TOOLCHAIN_LIBRARY_DIR: " ${TOOLCHAIN_LIBDIR})
MESSAGE(STATUS "TOOLCHAIN_LIBGCC_DIR : " ${TOOLCHAIN_LIBGCC_DIR})
MESSAGE(STATUS "TOOLCHAIN_LINKER_SCRIPT_FLAGS : " ${TOOLCHAIN_LINKER_SCRIPT_FLAGS})

set(RISCV32_ESP_BINUTILS_PATH ${RISCV32_ESP_TOOLCHAIN_DIR}) 
set(TOOLCHAIN_PREFIX ${RISCV32_ESP_TOOLCHAIN_DIR}/${TARGET_TRIPLET})

set(CMAKE_C_COMPILER "${TOOLCHAIN_PREFIX}-gcc${TOOLCHAIN_EXE}")
set(CMAKE_CXX_COMPILER "${TOOLCHAIN_PREFIX}-g++${TOOLCHAIN_EXE}")
set(CMAKE_ASM_COMPILER ${CMAKE_C_COMPILER})

set(CMAKE_OBJCOPY ${TOOLCHAIN_PREFIX}-objcopy${TOOLCHAIN_EXE} CACHE INTERNAL "objcopy tool")
set(CMAKE_OBJDUMP ${TOOLCHAIN_PREFIX}-objdump${TOOLCHAIN_EXE} CACHE INTERNAL "objdump tool")
set(CMAKE_RANLIB ${TOOLCHAIN_PREFIX}-ranlib${TOOLCHAIN_EXE} CACHE INTERNAL "ranlib tool")
set(CMAKE_READELF ${TOOLCHAIN_PREFIX}-readelf${TOOLCHAIN_EXE} CACHE INTERNAL "readelf tool")
set(CMAKE_SIZE ${TOOLCHAIN_PREFIX}-size${TOOLCHAIN_EXE} CACHE INTERNAL "size tool")
set(CMAKE_STRIP ${TOOLCHAIN_PREFIX}-strip{TOOLCHAIN_EXE} CACHE INTERNAL "strip tool")
set(CMAKE_AR ${TOOLCHAIN_PREFIX}-ar${TOOLCHAIN_EXE} CACHE INTERNAL "ar tool")
set(CMAKE_NM ${TOOLCHAIN_PREFIX}-nm${TOOLCHAIN_EXE} CACHE INTERNAL "nm tool")
set(CMAKE_LINKER ${TOOLCHAIN_PREFIX}-ld${TOOLCHAIN_EXE} CACHE INTERNAL "ld tool")

set(CMAKE_FIND_ROOT_PATH ${RISCV32_ESP_BINUTILS_PATH})
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

# Common flags for RiscV CPUs
#
# CPU core
set(RISCV32_CPU_SIFIVE_E20_FLAGS "-mcpu=sifive-e20")
set(RISCV32_CPU_SIFIVE_E21_FLAGS "-mcpu=sifive-e21")
set(RISCV32_CPU_SIFIVE_E24_FLAGS "-mcpu=sifive-e24")
set(RISCV32_CPU_SIFIVE_E31_FLAGS "-mcpu=sifive-e31")
set(RISCV32_CPU_SIFIVE_E34_FLAGS "-mcpu=sifive-e34")
set(RISCV32_CPU_SIFIVE_E76_FLAGS "-mcpu=sifive-e76")
set(RISCV32_CPU_SIFIVE_S21_FLAGS "-mcpu=sifive-s21")
set(RISCV32_CPU_SIFIVE_S51_FLAGS "-mcpu=sifive-s51")
set(RISCV32_CPU_SIFIVE_S54_FLAGS "-mcpu=sifive-s54")
set(RISCV32_CPU_SIFIVE_S76_FLAGS "-mcpu=sifive-s76")
set(RISCV32_CPU_SIFIVE_U54_FLAGS "-mcpu=sifive-u54")
set(RISCV32_CPU_SIFIVE_U74_FLAGS "-mcpu=sifive-u74")
set(RISCV32_CPU_THEAD_C906_FLAGS "-mcpu=thead-c906")

# Supported ISA specs
set(RISCV32_ISA_SPEC_2_2_FLAGS "-misa-spec=2.2")
set(RISCV32_ISA_SPEC_20190608_FLAGS "-misa-spec=20190608")
set(RISCV32_ISA_SPEC_20191213_FLAGS "-misa-spec=20191213")

# Supported data alignment choices
set(RISCV32_ALIGN_DATA_NATURAL_FLAGS "-malign-data=natural")
set(RISCV32_ALIGN_DATA_XLEN_FLAGS "-malign-data=xlen")

# Supported code models
set(RISCV32_CODE_MODEL_MEDANY_FLAGS "-mcmodel=medany")
set(RISCV32_CODE_MODEL_MEDLOW_FLAGS "-mcmodel=medlow")

# Supported stack protector guards
set(RISCV32_STACK_PROTECTOR_GLOBAL_FLAGS "-mstack-protector-guard=global")
set(RISCV32_STACK_PROTECTOR_TLS_FLAGS "-mstack-protector-guard=tls")

# Linker specs
set(RISCV32_SPEC_NANO_LINKER_FLAGS "--specs=nano.specs")
set(RISCV32_SPEC_NOSYS_LINKER_FLAGS "--specs=nosys.specs")

# Toolchain link libraries
set(TOOLCHAIN_LIBS
    -Wl,--start-group
    m
    c
    gcc
    nosys
    -Wl,--end-group
)

# Use -Os instead of -O3 in Release configuration
string(REPLACE "-O3" "-Os" CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE}")
string(REPLACE "-O3" "-Os" CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE}")
