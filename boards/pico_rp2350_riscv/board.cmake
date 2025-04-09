string(TOUPPER ${board_name} BOARD_NAME_UPPERCASE)
set(BOARD_VENDOR "Raspberry Pi")
set(BOARD_DESCRIPTION "Raspberry Pi Pico RP2350 (RISC-V Core)")

# MCU settings
set(MCU_FAMILY "RP2350")
set(MCU_CORE "RISCV")
set(MCU_ARCH "RV32IMC")

# Memory layout
set(FLASH_START_ADDRESS "0x10000000")
set(FLASH_SIZE "2048K")
set(RAM_START_ADDRESS "0x20000000")
set(RAM_SIZE "264K")

# Default architecture flags
set(ARCH_FLAGS ${RISCV_ARCH_RV32IMC_FLAGS})

# Board-specific compiler flags
set(BOARD_COMPILER_FLAGS
    -mcmodel=medlow
    -msmall-data-limit=8
    ${RISCV_SPEC_NANO_LINKER_FLAGS}
    ${RISCV_SPEC_NOSYS_LINKER_FLAGS}
)

# Board-specific linker flags
set(BOARD_LINKER_FLAGS
    ${TOOLCHAIN_LINKER_PREFIX}--gc-sections
    ${TOOLCHAIN_LINKER_PREFIX}--sort-section=alignment
    ${TOOLCHAIN_LINKER_PREFIX}--cref
)

# Board-specific definitions
set(BOARD_DEFINITIONS
    PICO_RP2350=1
    PICO_RISCV=1
    __RISCV__=1
)

# Include directories specific to this board
set(BOARD_INCLUDE_DIRS
    ${CMAKE_CURRENT_LIST_DIR}/include
)

# Source files specific to this board
set(BOARD_SOURCES
    ${CMAKE_CURRENT_LIST_DIR}/src/board.c
    ${CMAKE_CURRENT_LIST_DIR}/src/startup.c
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
foreach(definition ${BOARD_DEFINITIONS})
    set(COMMON_FLAGS ${COMMON_FLAGS} -D${definition})
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