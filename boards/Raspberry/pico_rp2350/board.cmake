# Include common Raspberry Pi Pico definitions
include(${CMAKE_CURRENT_LIST_DIR}/../pico/raspberry_pico.cmake)

# RP2350-specific defines
set(${board_name}_DEFINES 
    -D${BOARD_NAME_UPPERCASE} 
    -D${${board_name}_CLASS} 
    -D${${board_name}_CLASS}${${board_name}_SUBCLASS}
    -DRP2350
    -DPICO_FLOAT_SUPPORT_ROM_V1
)

# RP2350-specific flags (Cortex-M0+ with FPU and SIMD)
set(${board_name}_CFLAGS 
    ${ARM_CPU_CORTEX_M0PLUS_FLAGS} 
    ${ARM_CPU_CORTEX_THUMB_INTERWORK_FLAGS} 
    ${ARM_CPU_ABI_HARD_FLOAT_FLAGS}
    ${ARM_FPU_V4_SP_D16_FLAGS}
    ${${board_name}_COMMON_FLAGS}
)

set(${board_name}_LDFLAGS 
    ${ARM_CPU_CORTEX_M0PLUS_FLAGS} 
    ${ARM_CPU_CORTEX_THUMB_INTERWORK_FLAGS} 
    ${ARM_CPU_ABI_HARD_FLOAT_FLAGS}
    ${ARM_FPU_V4_SP_D16_FLAGS}
    ${TOOLCHAIN_LINKER_FLAG} 
    ${TOOLCHAIN_LINKER_PREFIX}--gc-sections 
    ${TOOLCHAIN_LINKER_EXTRA_LDFLAGS}
)

# RP2350-specific SDK include directories
set(${board_name}_SDK_INCDIR
    ${${board_name}_SDK_INCDIR}
    ${${board_name}_SDK_DIR}/src/rp2350/hardware_regs/include
    ${${board_name}_SDK_DIR}/src/rp2350/hardware_structs/include
    ${${board_name}_SDK_DIR}/src/rp2_common/pico_float/include
    ${${board_name}_SDK_DIR}/src/rp2_common/pico_double/include
)

# Additional RP2350-specific SDK source files
set(${board_name}_SDK_SRCS
    ${${board_name}_SDK_SRCS}
    ${${board_name}_SDK_DIR}/src/rp2_common/pico_float/float_init_rom.c
    ${${board_name}_SDK_DIR}/src/rp2_common/pico_float/float_math.c
    ${${board_name}_SDK_DIR}/src/rp2_common/pico_double/double_init_rom.c
    ${${board_name}_SDK_DIR}/src/rp2_common/pico_double/double_math.c
)

# Create the SDK library
add_library(${board_name}_SDK STATIC ${${board_name}_SDK_SRCS})
target_compile_options(${board_name}_SDK PRIVATE ${${board_name}_CFLAGS})
target_compile_definitions(${board_name}_SDK PRIVATE ${${board_name}_DEFINES})
target_include_directories(${board_name}_SDK
    PRIVATE ${${board_name}_INCDIR_HAL_LIB}
    PUBLIC ${${board_name}_INCDIR}
    ${${board_name}_SDK_INCDIR}
)

set(${board_name}_LIBS
    ${board_name}_SDK
) 