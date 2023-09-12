# Executable file extension
IF(WIN32)
    SET(TOOLCHAIN_EXE ".exe")
ELSE()
    SET(TOOLCHAIN_EXE "")
ENDIF()

# The triplet to use for the target
SET(TARGET_TRIPLET "fpga-xilinx-unknown")

find_program(TOOLCHAIN_COMPILER "vivado${TOOLCHAIN_EXE}")

set(CMAKE_FPGA_COMPILER ${TOOLCHAIN_COMPILER})
set(CMAKE_FPGA_FLAGS -mode tcl -source)
set(${TARGET_TRIPLET}_USE_FPGA yes)
