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

message("Searching for vhd files in ${${CMAKE_PROJECT_NAME}_HDL_SOURCES_DIR}." DEBUG)

file(GLOB ${CMAKE_PROJECT_NAME}_SRCS CONFIGURE_DEPENDS "${${CMAKE_PROJECT_NAME}_HDL_SOURCES_DIR}/*.vhd")
file(GLOB ${CMAKE_PROJECT_NAME}_CONSTRAINTS CONFIGURE_DEPENDS "${${CMAKE_PROJECT_NAME}_CONSTRAINTS_DIR}/*.xdc")

add_custom_target(SOURCE_VIVADO_SETTINGS COMMAND bash -c "source ${VIVADO_SETTINGS_LOCATION}")
add_custom_target(XILINX_OPEN_PROJECT bash -c "vivado -mode tcl -source <(echo \"open_project ${XILINX_PROJECT_FILE};add_files ${${CMAKE_PROJECT_NAME}_SRCS}\")" VERBATIM DEPENDS SOURCE_VIVADO_SETTINGS)
add_custom_target(XILINX_ADD_FILES
    bash -c "vivado -mode tcl -source <(echo \"add_files ${${CMAKE_PROJECT_NAME}_SRCS}\")" VERBATIM
    COMMAND bash -c "vivado -mode tcl -source <(echo \"add_files ${${CMAKE_PROJECT_NAME}_CONSTRAINTS}\")" VERBATIM
    DEPENDS XILINX_OPEN_PROJECT
)
add_custom_target(XILINX_SYNTHESIS bash -c "vivado -mode tcl -source <(echo \"launch_runs synth_1 -jobs 8\")" VERBATIM COMMAND bash -c "vivado -mode tcl -source <(echo \"wait_on_run synth_1\")" VERBATIM DEPENDS XILINX_ADD_FILES)
add_custom_target(XILINX_IMPLEMENTATION bash -c "vivado -mode tcl -source <(echo \"launch_runs impl_1 -jobs 8\")" VERBATIM COMMAND bash -c "vivado -mode tcl -source <(echo \"wait_on_run impl_1\")" VERBATIM DEPENDS XILINX_SYNTHESIS)
add_custom_target(XILINX_BITSTREAM bash -c "vivado -mode tcl -source <(echo \"launch_runs impl_1 -to_step write_bitstream -jobs 8\")" VERBATIM COMMAND bash -c "vivado -mode tcl -source <(echo \"wait_on_run impl_1\")" VERBATIM DEPENDS XILINX_IMPLEMENTATION)
add_custom_target(XILINX_WRITE_BITSTREAM bash -c "vivado -mode tcl -source <(echo \"write_bitstream -force ${${CMAKE_PROJECT_NAME}_PROJECT_DIRECTORY}/${CMAKE_PROJECT_NAME}.runs/impl_1/${CMAKE_PROJECT_NAME}.bit\")" VERBATIM DEPENDS XILINX_BITSTREAM)
add_custom_target(XILINX_BUILD ALL bash -c "vivado -mode tcl -source <(echo \"close_project\")" VERBATIM DEPENDS XILINX_WRITE_BITSTREAM)
add_custom_target(XILINX_CLEAN bash -c "vivado -mode tcl -source <(echo \"reset_run synth_1\")" VERBATIM)

