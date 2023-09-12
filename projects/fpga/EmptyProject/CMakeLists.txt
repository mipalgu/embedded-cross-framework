cmake_minimum_required(VERSION 3.12)
project(EmptyProject NONE)

set(${CMAKE_PROJECT_NAME}_PROJECT_DIRECTORY ${PROJECT_SOURCE_DIR}/vivado_project)
set(XILINX_DIRECTORY /usr/local/tools/Xilinx)
set(VIVADO_VERSION 2022.2)
set(VIVADO_INSTALL_LOCATION ${XILINX_DIRECTORY}/Vivado/${VIVADO_VERSION})
set(VIVADO_SETTINGS_LOCATION ${VIVADO_INSTALL_LOCATION}/settings64.sh)
set(${CMAKE_PROJECT_NAME}_SOURCES_PARENT_DIR ${${CMAKE_PROJECT_NAME}_PROJECT_DIRECTORY}/${CMAKE_PROJECT_NAME}.srcs)
set(${CMAKE_PROJECT_NAME}_HDL_SOURCES_DIR ${${CMAKE_PROJECT_NAME}_SOURCES_PARENT_DIR}/sources_1/new)
set(${CMAKE_PROJECT_NAME}_CONSTRAINTS_DIR ${${CMAKE_PROJECT_NAME}_SOURCES_PARENT_DIR}/constrs_1/new)
set(XILINX_FPGA xc7z020)
set(XILINX_FAMILY Zynq-7000)
set(XILINX_PACKAGE clg400)
set(XILINX_SPEED_GRADE -1)
set(XILINX_PART ${XILINX_FPGA}${XILINX_PACKAGE}${XILINX_SPEED_GRADE})
set(XILINX_PROJECT_FILE ${${CMAKE_PROJECT_NAME}_PROJECT_DIRECTORY}/${CMAKE_PROJECT_NAME}.xpr)
set(VIVADO_BIN ${VIVADO_INSTALL_LOCATION}/bin/vivado)
set(VIVADO_BITSTREAM ${${CMAKE_PROJECT_NAME}_PROJECT_DIRECTORY}/${CMAKE_PROJECT_NAME}.runs/impl_1/${CMAKE_PROJECT_NAME}.bit)

file(GLOB ${CMAKE_PROJECT_NAME}_SRCS CONFIGURE_DEPENDS "${${CMAKE_PROJECT_NAME}_HDL_SOURCES_DIR}/*.vhd" "${${CMAKE_PROJECT_NAME}_HDL_SOURCES_DIR}/*.v")
file(GLOB ${CMAKE_PROJECT_NAME}_CONSTRAINTS CONFIGURE_DEPENDS "${${CMAKE_PROJECT_NAME}_CONSTRAINTS_DIR}/*.xdc")

set(XILINX_BUILD_COMMANDS
    "open_project ${XILINX_PROJECT_FILE}"
    "add_files ${${CMAKE_PROJECT_NAME}_SRCS}"
    "add_files ${${CMAKE_PROJECT_NAME}_CONSTRAINTS}"
    "launch_runs synth_1 -jobs 8"
    "wait_on_run synth_1"
    "launch_runs impl_1 -jobs 8"
    "wait_on_run impl_1"
    "open_run impl_1"
    "write_bitstream -force ${VIVADO_BITSTREAM}"
    "close_project"
)
string(REPLACE ";" "\n" XILINX_BUILD_SCRIPT "${XILINX_BUILD_COMMANDS}")

set(XILINX_CLEAN_COMMANDS
    "open_project ${XILINX_PROJECT_FILE}"
    "reset_run synth_1"
    "close_project"
)
string(REPLACE ";" "\n" XILINX_CLEAN_SCRIPT "${XILINX_CLEAN_COMMANDS}")

set(XILINX_UPLOAD_COMMANDS
    "open_project ${XILINX_PROJECT_FILE}"
    "open_hw_manager"
    "connect_hw_server"
    "open_hw_target"
    "create_hw_bitstream -hw_device [current_hw_device] ${VIVADO_BITSTREAM}"
    "program_hw_device"
    "close_hw_target"
    "disconnect_hw_server"
    "close_project"
    "quit"
)
string(REPLACE ";" "\n" XILINX_UPLOAD_SCRIPT "${XILINX_UPLOAD_COMMANDS}")

set(BUILD_SCRIPT ${CMAKE_CURRENT_BINARY_DIR}/build.tcl)
set(CLEAN_SCRIPT ${CMAKE_CURRENT_BINARY_DIR}/clean.tcl)
set(UPLOAD_SCRIPT ${CMAKE_CURRENT_BINARY_DIR}/upload.tcl)


file(WRITE ${CLEAN_SCRIPT} ${XILINX_CLEAN_SCRIPT})
file(WRITE ${UPLOAD_SCRIPT} ${XILINX_UPLOAD_SCRIPT})
file(WRITE ${BUILD_SCRIPT} ${XILINX_BUILD_SCRIPT})

add_custom_target(
    xilinx-build ALL
    ${VIVADO_BIN} -mode tcl -source ${CMAKE_CURRENT_BINARY_DIR}/build.tcl VERBATIM
    BYPRODUCTS ${VIVADO_BITSTREAM}
    DEPENDS ${BUILD_SCRIPT}
)

add_custom_target(
    xilinx-clean
    ${VIVADO_BIN} -mode tcl -source ${CMAKE_CURRENT_BINARY_DIR}/clean.tcl VERBATIM
    DEPENDS ${CLEAN_SCRIPT}
)
# add_custom_target(xilinx-install ${VIVADO_BIN} -mode tcl -source ${CMAKE_CURRENT_BINARY_DIR}/upload.tcl VERBATIM DEPENDS ${VIVADO_BITSTREAM})
install(
    CODE "execute_process(COMMAND ${VIVADO_BIN} -mode tcl -source ${UPLOAD_SCRIPT})"
    DEPENDS ${VIVADO_BITSTREAM} ${UPLOAD_SCRIPT}
)

