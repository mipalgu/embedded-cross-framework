# Include common Raspberry Pi Pico definitions
include(${CMAKE_CURRENT_LIST_DIR}/../raspberry_pico.cmake)

set(BOARD_DESCRIPTION "Raspberry Pi Pico RP2350 (ARM M33 Core)")

# RP2350-specific board definitions
set(${board_name}_CLASS "RP")        # Raspberry Pi
set(${board_name}_SUBCLASS "2")      # Dual-core
set(${board_name}_FAMILY "3")        # Arm Cortex-M33 architecture
set(${board_name}_MODEL "5")         # 520KB SRAM (log2(520/16) = 5)
set(${board_name}_VARIANT "0")       # No integrated flash
set(${board_name}_CPUNAME "ARM Cortex-M33")
set(${board_name}_CPU_ARCHITECTURE "ARM")
set(${board_name}_CPU "ARM_CORTEX_M33")

set(PICO_BOARD pico2 CACHE STRING "Board type")

# Derive MCU settings from board definitions
set(MCU_FAMILY "${${board_name}_CLASS}${${board_name}_SUBCLASS}${${board_name}_FAMILY}${${board_name}_MODEL}${${board_name}_VARIANT}")
set(MCU_CORE "${${board_name}_CPU}")

# RP2350-specific defines
set(${board_name}_DEFINES
    -D${BOARD_NAME_UPPERCASE}
    -D${${board_name}_CLASS}
    -D${${board_name}_CLASS}${${board_name}_SUBCLASS}
    -D${${board_name}_CLASS}${${board_name}_SUBCLASS}xx
    -D${${board_name}_CLASS}${${board_name}_SUBCLASS}${${board_name}_FAMILY}
    -D${${board_name}_CLASS}${${board_name}_SUBCLASS}${${board_name}_FAMILY}xx
    -D${${board_name}_CLASS}${${board_name}_SUBCLASS}${${board_name}_FAMILY}${${board_name}_MODEL}
    -D${${board_name}_CLASS}${${board_name}_SUBCLASS}${${board_name}_FAMILY}${${board_name}_MODEL}x
    -D${${board_name}_CLASS}${${board_name}_SUBCLASS}${${board_name}_FAMILY}${${board_name}_MODEL}${${board_name}_VARIANT}
    -D${${board_name}_CLASS}${${board_name}_SUBCLASS}${${board_name}_FAMILY}${${board_name}_MODEL}${${board_name}_VARIANT}_${${board_name}_CPU_ARCHITECTURE}
    -D${${board_name}_CLASS}${${board_name}_SUBCLASS}${${board_name}_FAMILY}${${board_name}_MODEL}${${board_name}_VARIANT}_${${board_name}_CPU}
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

# RP2350 startup source
set(${board_name}_STARTUP_SRC
    ${${board_name}_SDK_DIR}/src/rp2_common/boot_stage2/boot2_w25q080.S
    ${${board_name}_SDK_DIR}/src/rp2_common/pico_bootrom/bootrom.c
    ${${board_name}_SDK_DIR}/src/rp2_common/hardware_irq/irq_handler_chain.S
    ${${board_name}_SDK_DIR}/src/rp2_common/pico_float/float_v1_rom_shim.S
    ${${board_name}_SDK_DIR}/src/rp2_common/pico_double/double_v1_rom_shim.S
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
add_library(${board_name}_SDK STATIC
    ${${board_name}_SDK_SRCS}
    ${${board_name}_STARTUP_SRC}
)
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
