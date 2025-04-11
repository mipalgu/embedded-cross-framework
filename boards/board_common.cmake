
# Board-specific defines
set(${board_name}_DEFINES
    -D${BOARD_NAME_UPPERCASE}
    -D${${board_name}_CLASS}
    -D${${board_name}_CLASS}${${board_name}_SUBCLASS}
    -D${${board_name}_CLASS}${${board_name}_SUBCLASS}xx
    -D${${board_name}_CLASS}${${board_name}_SUBCLASS}${${board_name}_FAMILY}
    -D${${board_name}_CLASS}${${board_name}_SUBCLASS}${${board_name}_FAMILY}xx
    -D${${board_name}_CLASS}${${board_name}_SUBCLASS}${${board_name}_FAMILY}${${board_name}_MODEL}
    -D${${board_name}_CLASS}${${board_name}_SUBCLASS}${${board_name}_FAMILY}${${board_name}_MODEL}x
    -D${${board_name}_CLASS}${${board_name}_SUBCLASS}${${board_name}_FAMILY}${${board_name}_MODEL}${${board_name}_VARIANT}
    -D${${board_name}_CLASS}${${board_name}_SUBCLASS}${${board_name}_FAMILY}${${board_name}_MODEL}${${board_name}_VARIANT}_${${board_name}_CPU_ARCHITECTURE}
    -D${${board_name}_CLASS}${${board_name}_SUBCLASS}${${board_name}_FAMILY}${${board_name}_MODEL}${${board_name}_VARIANT}_${${board_name}_CPU}
)

# Derive MCU settings from board definitions
set(MCU_FAMILY "${${board_name}_CLASS}${${board_name}_SUBCLASS}${${board_name}_FAMILY}${${board_name}_MODEL}${${board_name}_VARIANT}")
set(MCU_CORE "${${board_name}_CPU}")
