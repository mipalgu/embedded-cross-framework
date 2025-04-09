# Include common Raspberry Pi Pico definitions
include(${CMAKE_CURRENT_LIST_DIR}/../pico/raspberry_pico.cmake)

# RP2040-specific board definitions
set(${board_name}_CLASS "RP")        # Raspberry Pi
set(${board_name}_SUBCLASS "2")      # Dual-core
set(${board_name}_FAMILY "0")        # Cortex-M0+ architecture
set(${board_name}_MODEL "4")         # 264KB SRAM (log2(264/16) ≈ 4)
set(${board_name}_VARIANT "0")       # No integrated flash
set(${board_name}_CPUNAME "ARM Cortex-M0+")
set(${board_name}_CPU "ARM_CPU_CORTEX_M0PLUS")

# Derive MCU settings from board definitions
set(MCU_FAMILY "${${board_name}_CLASS}${${board_name}_SUBCLASS}${${board_name}_FAMILY}${${board_name}_MODEL}${${board_name}_VARIANT}")
set(MCU_CORE "${${board_name}_CPU}")

# RP2040-specific defines
set(${board_name}_DEFINES 
    -D${BOARD_NAME_UPPERCASE} 
    -D${${board_name}_CLASS} 
    -D${${board_name}_CLASS}${${board_name}_SUBCLASS}
    -D${${board_name}_CLASS}${${board_name}_SUBCLASS}${${board_name}_FAMILY}
    -D${${board_name}_CLASS}${${board_name}_SUBCLASS}${${board_name}_FAMILY}${${board_name}_MODEL}
    -D${${board_name}_CLASS}${${board_name}_SUBCLASS}${${board_name}_FAMILY}${${board_name}_MODEL}${${board_name}_VARIANT}
)

# RP2040-specific flags (Cortex-M0+ without FPU)
set(${board_name}_CFLAGS 
    ${ARM_CPU_CORTEX_M0PLUS_FLAGS} 
    ${ARM_CPU_CORTEX_THUMB_INTERWORK_FLAGS} 
    ${ARM_CPU_ABI_SOFT_FLOAT_FLAGS}
    ${${board_name}_COMMON_FLAGS}
)

set(${board_name}_LDFLAGS 
    ${ARM_CPU_CORTEX_M0PLUS_FLAGS} 
    ${ARM_CPU_CORTEX_THUMB_INTERWORK_FLAGS} 
    ${ARM_CPU_ABI_SOFT_FLOAT_FLAGS}
    ${TOOLCHAIN_LINKER_FLAG} 
    ${TOOLCHAIN_LINKER_PREFIX}--gc-sections 
    ${TOOLCHAIN_LINKER_EXTRA_LDFLAGS}
)

# RP2040-specific SDK include directories
set(${board_name}_SDK_INCDIR
    ${${board_name}_SDK_INCDIR}
    ${${board_name}_SDK_DIR}/src/rp2040/hardware_regs/include
    ${${board_name}_SDK_DIR}/src/rp2040/hardware_structs/include
)

# RP2040 startup source
set(${board_name}_STARTUP_SRC
    ${${board_name}_SDK_DIR}/src/rp2_common/boot_stage2/boot2_w25q080.S
    ${${board_name}_SDK_DIR}/src/rp2_common/pico_bootrom/bootrom.c
    ${${board_name}_SDK_DIR}/src/rp2_common/hardware_irq/irq_handler_chain.S
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