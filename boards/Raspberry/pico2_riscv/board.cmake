set(PICO_DEFAULT_PLATFORM "rp2350-riscv")

# RP2350 RISCV-specific board definitions
set(PICO_DEFAULT_GCC_TRIPLE riscv32-unknown-elf riscv32-corev-elf)

# Include common Raspberry Pi Pico definitions
include(${CMAKE_CURRENT_LIST_DIR}/../raspberry_pico_2350.cmake)

set(BOARD_DESCRIPTION "Raspberry Pi Pico RP2350 (RISC-V Core)")

list(APPEND PICO_PRE_DEFINES "PICO_ON_DEVICE=1")

# Board-specific definitions
set(${board_name}_CLASS "RP")        # Raspberry Pi
set(${board_name}_SUBCLASS "2")      # Dual-core
set(${board_name}_FAMILY "3")        # RISC-V Hazard3 architecture
set(${board_name}_MODEL "5")         # 520KB SRAM (log2(520/16) = 5)
set(${board_name}_VARIANT "0")       # No integrated flash
set(${board_name}_CPUNAME "RISC-V")
set(${board_name}_CPU_ARCHITECTURE "RISCV")
set(${board_name}_CPU "RISCV_RV32IMAC_PLUS")

set(PICO_BOARD pico2 CACHE STRING "Board type")

# RP2350-specific flags (RISC-V)
set(PICO_COMMON_LANG_FLAGS
    ${RISCV_ARCH_RV32IMAC_ZICSR_ZIFENCEI_ZBABSKB_FLAGS}
    ${RISCV_ABI_SOFT_FLOAT_FLAGS}
)


# Default linker script
set(LINKER_SCRIPT ${CMAKE_CURRENT_LIST_DIR}/rp2350_riscv.ld)

# Debug interface settings
set(DEBUG_INTERFACE "SWD")
set(OPENOCD_CHIP_CONFIG "rp2040.cfg")

# Add board-specific flags to common flags
set(COMMON_FLAGS
    ${COMMON_FLAGS}
    ${BOARD_COMPILER_FLAGS}
)

# Add board-specific definitions
foreach(definition ${${board_name}_DEFINES})
    set(COMMON_FLAGS ${COMMON_FLAGS} ${definition})
endforeach()

# Update C/C++/ASM flags with board-specific settings
foreach(lang C CXX ASM)
    set(CMAKE_${lang}_FLAGS "${CMAKE_${lang}_FLAGS} ${COMMON_FLAGS}")
endforeach()

# Set linker flags
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} ${BOARD_LINKER_FLAGS}")

# Set board source files and include directories
set(BOARD_SOURCES ${BOARD_SOURCES})
include_directories(${BOARD_INCLUDE_DIRS})
