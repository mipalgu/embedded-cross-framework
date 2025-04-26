set(BOARD_DESCRIPTION "Raspberry Pi Pico RP2350")

set(PICO_CHIP rp2350)

include(${CMAKE_CURRENT_LIST_DIR}/raspberry_pico.cmake)

# RP2350-specific board definitions
set(${board_name}_CLASS "RP")        # Raspberry Pi
set(${board_name}_SUBCLASS "2")      # Dual-core
set(${board_name}_FAMILY "3")        # Arm Cortex-M33 architecture
set(${board_name}_MODEL "5")         # 520KB SRAM (log2(520/16) = 5)
set(${board_name}_VARIANT "0")       # No integrated flash

set(PICO_CLANG_RUNTIMES armv8m.main_soft_nofp armv8m.main-unknown-none-eabi)

# Derive MCU settings from board definitions
set(MCU_FAMILY "${${board_name}_CLASS}${${board_name}_SUBCLASS}${${board_name}_FAMILY}${${board_name}_MODEL}${${board_name}_VARIANT}")
set(MCU_CORE "${${board_name}_CPU}")
