# Executable file extension
IF(WIN32)
SET(TOOLCHAIN_EXE ".exe")
ELSE()
    SET(TOOLCHAIN_EXE "")
ENDIF()

# The triplet to use for the target
SET(TARGET_TRIPLET "fpga-xilinx-unknown")
set(HDL_BIN_PATH
    /bin
    /usr/bin
    /usr/local/bin
    /usr/local/tools/Xilinx/Vivado/2023.2/bin
    /usr/local/tools/Xilinx/Vivado/2023.1/bin
    /usr/local/tools/Xilinx/Vivado/2022.2/bin
    /usr/local/tools/Xilinx/Vivado/2022.1/bin
    /tools/Xilinx/Vivado/2023.2/bin
    /tools/Xilinx/Vivado/2023.1/bin
    /tools/Xilinx/Vivado/2022.2/bin
    /tools/Xilinx/Vivado/2022.1/bin
)
find_program(TOOLCHAIN_COMPILER "vivado${TOOLCHAIN_EXE}" PATHS ${HDL_BIN_PATH})
set(CMAKE_FPGA_FLAGS -mode tcl -source)
set(${TARGET_TRIPLET}_USE_FPGA yes)
