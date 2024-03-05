#
# The LaunchXL2-570LC43 board configuration
#
string(TOUPPER ${board_name} BOARD_NAME_UPPERCASE)
set(${board_name}_CLASS "Launch")
set(${board_name}_SUBCLASS "XL2")
set(${board_name}_FAMILY "570LC")
set(${board_name}_MODEL "43")
set(${board_name}_CPUNAME "ARM Cortex-R5")
set(${board_name}_CPU "ARM_CPU_CORTEX_V7R5")
set(${board_name}_DEFINES -D${BOARD_NAME_UPPERCASE} -D${${board_name}_CLASS} -D${${board_name}_CLASS}${${board_name}_SUBCLASS} -D${${board_name}_CLASS}${${board_name}_SUBCLASS}${${board_name}_FAMILY} -D${${board_name}_CLASS}${${board_name}_SUBCLASS}${${board_name}_FAMILY}xx -D${${board_name}_CLASS}${${board_name}_SUBCLASS}${${board_name}_FAMILY}${${board_name}_MODEL})
set(${board_name}_ASM_FLAGS ${ARM_CPU_CORTEX_V7R5_FLAGS})
set(${board_name}_CFLAGS ${ARM_CPU_CORTEX_V7R5_FLAGS})
set(${board_name}_LDFLAGS ${ARM_CPU_CORTEX_V7R5_FLAGS} --be32 ${TOOLCHAIN_LINKER_FLAG} ${TOOLCHAIN_LINKER_EXTRA_LDFLAGS})
#set(${board_name}_LIBDIR ${TOOLCHAIN_LIBDIR} ${TOOLCHAIN_LIBGCC_DIR})
set(${board_name}_LIBS ${TOOLCHAIN_LIBC})