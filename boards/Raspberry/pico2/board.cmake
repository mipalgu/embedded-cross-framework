include(${CMAKE_CURRENT_LIST_DIR}/../raspberry_pico_2350.cmake)

set(BOARD_DESCRIPTION "Raspberry Pi Pico2 (RP2350, ARM M33 Core)")

list(APPEND PICO_PRE_DEFINES "PICO_ON_DEVICE=1")

# RP2350 ARM-specific board definitions
set(${board_name}_CPUNAME "ARM Cortex-M33")
set(${board_name}_CPU_ARCHITECTURE "ARM")
set(${board_name}_CPU "ARM_CORTEX_M33")

set(PICO_DEFAULT_COMPILER "pico_arm_cortex_m33_gcc")
set(PICO_CLANG_RUNTIMES armv8m.main_soft_nofp armv8m.main-unknown-none-eabi)

# RP2350-specific flags (Cortex-M33 with FP and DSP)
set(PICO_COMMON_LANG_FLAGS
    ${ARM_CPU_CORTEX_M33_FLAGS}
    ${ARM_CPU_CORTEX_THUMB_FLAGS}
    "-march=armv8-m.main+fp+dsp"
    ${ARM_CPU_ABI_SOFTFP_FLOAT_FLAGS}
)
if (NOT PICO_NO_CMSE)
    list(APPEND PICO_COMMON_LANG_FLAGS "-mcmse")
endif()

# Add RP2350-specifics to ${board_name}_DEFINES
list(APPEND ${board_name}_DEFINES
    -DPICO_FLOAT_SUPPORT_ROM_V1
    -DPICO_RP2350=1
)

include(${CMAKE_CURRENT_LIST_DIR}/../raspberry_pico_common.cmake)
