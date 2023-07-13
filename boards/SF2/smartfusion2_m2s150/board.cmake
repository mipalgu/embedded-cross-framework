#
# The nucleo_f207zg board configuration
#
string(TOUPPER ${board_name} BOARD_NAME_UPPERCASE)
set(${board_name}_CLASS "SmartFusion")
set(${board_name}_SUBCLASS "2")
set(${board_name}_FAMILY "M2S")
set(${board_name}_MODEL "150")
set(${board_name}_CPUNAME "ARM Cortex-M3")
set(${board_name}_CPU "ARM_CPU_CORTEX_M3")
set(${board_name}_DEFINES -D${BOARD_NAME_UPPERCASE} -D${${board_name}_CLASS} -D${${board_name}_CLASS}${${board_name}_SUBCLASS} -D${${board_name}_CLASS}${${board_name}_SUBCLASS}${${board_name}_FAMILY} -D${${board_name}_CLASS}${${board_name}_SUBCLASS}${${board_name}_FAMILY}xx -D${${board_name}_CLASS}${${board_name}_SUBCLASS}${${board_name}_FAMILY}${${board_name}_MODEL})
set(${board_name}_CFLAGS ${ARM_CPU_CORTEX_M3_FLAGS} ${ARM_CPU_CORTEX_THUMB_INTERWORK_FLAGS} ${ARM_CPU_ABI_SOFT_FLOAT_FLAGS} -ffunction-sections -fdata-sections -fno-common -fmessage-length=0)
set(${board_name}_LDFLAGS ${ARM_CPU_CORTEX_M3_FLAGS} ${ARM_CPU_CORTEX_THUMB_INTERWORK_FLAGS} ${ARM_CPU_ABI_SOFT_FLOAT_FLAGS} ${TOOLCHAIN_LINKER_FLAG} ${TOOLCHAIN_LINKER_PREFIX}--gc-sections ${TOOLCHAIN_LINKER_EXTRA_LDFLAGS})
#set(${board_name}_LIBDIR ${TOOLCHAIN_LIBDIR} ${TOOLCHAIN_LIBGCC_DIR})
