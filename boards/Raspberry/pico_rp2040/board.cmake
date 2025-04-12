# Include common Raspberry Pi Pico definitions
include(${CMAKE_CURRENT_LIST_DIR}/../raspberry_pico.cmake)

set(BOARD_DESCRIPTION "Raspberry Pi Pico RP2040 (ARM M0+ Core)")

# RP2040-specific board definitions
set(${board_name}_CLASS "RP")        # Raspberry Pi
set(${board_name}_SUBCLASS "2")      # Dual-core
set(${board_name}_FAMILY "0")        # Cortex-M0+ architecture
set(${board_name}_MODEL "4")         # 264KB SRAM (log2(264/16) ≈ 4)
set(${board_name}_VARIANT "0")       # No integrated flash
set(${board_name}_CPUNAME "ARM Cortex-M0+")
set(${board_name}_CPU_ARCHITECTURE "ARM")
set(${board_name}_CPU "ARM_CORTEX_M0PLUS")

set(PICO_CHIP rp2040)
set(PICO_BOARD pico CACHE STRING "Board type")
set(PICO_CLANG_RUNTIMES armv6m_soft_nofp armv6m-unknown-none-eabi)

# RP2040-specific flags (Cortex-M0+)
set(PICO_COMMON_LANG_FLAGS
    ${ARM_CPU_CORTEX_M0PLUS_FLAGS}
    ${ARM_CPU_CORTEX_THUMB_FLAGS}
    ${ARM_CPU_ABI_SOFT_FLOAT_FLAGS}
    "-march=armv6-m"
)

include(${CMAKE_CURRENT_LIST_DIR}/../raspberry_pico_common.cmake)
