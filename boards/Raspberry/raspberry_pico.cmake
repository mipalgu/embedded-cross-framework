# Common Raspberry Pi Pico board configuration
string(TOUPPER ${board_name} BOARD_NAME_UPPERCASE)
set(BOARD_VENDOR "Raspberry Pi")

# Default values, can be overwritten by the board configuration
set(BOARD_DESCRIPTION "Raspberry Pi Pico")
set(${board_name}_CLASS "RP")        # Raspberry Pi
set(${board_name}_SUBCLASS "2")      # Dual-core
set(${board_name}_FAMILY "0")        # Cortex-M0+ architecture
set(${board_name}_MODEL "4")         # 264KB SRAM (log2(264/16) ≈ 4)
set(${board_name}_VARIANT "0")       # No integrated flash

set(${board_name}_CPUNAME "ARM Cortex-M0+")
set(${board_name}_CPU "ARM_CPU_CORTEX_M0PLUS")

set(PICO_BOARD pico CACHE STRING "Board type")

#
# Raspberry Pi Pico specific settings
#
if(WIN32)
    set(USERHOME $ENV{USERPROFILE})
else()
    set(USERHOME $ENV{HOME})
endif()
set(sdkVersion 2.1.1)
set(toolchainVersion 14_2_Rel1)
set(picotoolVersion 2.1.1)
#set(picoVscode ${USERHOME}/.pico-sdk/cmake/pico-vscode.cmake)
#if (EXISTS ${picoVscode})
#    include(${picoVscode})
#endif()

# Common compiler flags
set(${board_name}_COMMON_FLAGS -ffunction-sections -fdata-sections -fno-common -fmessage-length=0)

# Pico SDK paths
set(${board_name}_FIRMWARE "pico-sdk")
set(${board_name}_FIRMWARE_DIR ${firmware_${${board_name}_FIRMWARE}_DIR})
set(${board_name}_SDK_DIR ${${board_name}_FIRMWARE_DIR})

if (NOT PICO_SDK_PATH)
    if (DEFINED ENV{PICO_SDK_PATH})
        set(PICO_SDK_PATH $ENV{PICO_SDK_PATH})
        message("Using PICO_SDK_PATH from environment ('${PICO_SDK_PATH}')")
    else()
        set(PICO_SDK_PATH ${${board_name}_SDK_DIR})
        message("Using PICO_SDK_PATH: '${PICO_SDK_PATH}'")
    endif()
endif()

if (NOT PICO_TOOLCHAIN_PATH)
    if (DEFINED ENV{PICO_TOOLCHAIN_PATH})
        set(PICO_TOOLCHAIN_PATH $ENV{PICO_TOOLCHAIN_PATH})
        message("Using PICO_SDK_PATH from environment ('${PICO_SDK_PATH}')")
    else()
        set(PICO_TOOLCHAIN_PATH ${${board_name}_SDK_DIR})
        message("Using PICO_SDK_PATH: '${PICO_SDK_PATH}'")
    endif()
endif()

# Pull in Raspberry Pi Pico SDK (must be before project)
include(${${board_name}_SDK_DIR}/external/pico_sdk_import.cmake)

# Common SDK include directories
set(${board_name}_SDK_INCDIR
    ${${board_name}_SDK_DIR}/src/common/pico_base/include
    ${${board_name}_SDK_DIR}/src/common/pico_stdlib/include
    ${${board_name}_SDK_DIR}/src/rp2_common/hardware_gpio/include
    ${${board_name}_SDK_DIR}/src/rp2_common/hardware_uart/include
    ${${board_name}_SDK_DIR}/src/rp2_common/hardware_i2c/include
    ${${board_name}_SDK_DIR}/src/rp2_common/hardware_spi/include
    ${${board_name}_SDK_DIR}/src/rp2_common/hardware_pwm/include
    ${${board_name}_SDK_DIR}/src/rp2_common/hardware_timer/include
    ${${board_name}_SDK_DIR}/src/rp2_common/hardware_adc/include
    ${${board_name}_SDK_DIR}/src/rp2_common/hardware_dma/include
    ${${board_name}_SDK_DIR}/src/rp2_common/hardware_irq/include
    ${${board_name}_SDK_DIR}/src/rp2_common/hardware_pio/include
    ${${board_name}_SDK_DIR}/src/rp2_common/hardware_pll/include
    ${${board_name}_SDK_DIR}/src/rp2_common/hardware_sync/include
    ${${board_name}_SDK_DIR}/src/rp2_common/hardware_watchdog/include
    ${${board_name}_SDK_DIR}/src/rp2_common/hardware_xosc/include
    ${${board_name}_SDK_DIR}/src/rp2_common/hardware_clocks/include
    ${${board_name}_SDK_DIR}/src/rp2_common/hardware_flash/include
    ${${board_name}_SDK_DIR}/src/rp2_common/hardware_systimer/include
    ${${board_name}_SDK_DIR}/src/rp2_common/hardware_rtc/include
    ${${board_name}_SDK_DIR}/src/rp2_common/hardware_resets/include
    ${${board_name}_SDK_DIR}/src/rp2_common/hardware_claim/include
    ${${board_name}_SDK_DIR}/src/rp2_common/hardware_divider/include
    ${${board_name}_SDK_DIR}/src/rp2_common/hardware_exception/include
    ${${board_name}_SDK_DIR}/src/rp2_common/hardware_interp/include
    ${${board_name}_SDK_DIR}/src/rp2_common/pico_platform/include
)

# Common SDK source files
set(${board_name}_SDK_SRCS
    ${${board_name}_SDK_DIR}/src/rp2_common/hardware_gpio/gpio.c
    ${${board_name}_SDK_DIR}/src/rp2_common/hardware_uart/uart.c
    ${${board_name}_SDK_DIR}/src/rp2_common/hardware_i2c/i2c.c
    ${${board_name}_SDK_DIR}/src/rp2_common/hardware_spi/spi.c
    ${${board_name}_SDK_DIR}/src/rp2_common/hardware_pwm/pwm.c
    ${${board_name}_SDK_DIR}/src/rp2_common/hardware_timer/timer.c
    ${${board_name}_SDK_DIR}/src/rp2_common/hardware_adc/adc.c
    ${${board_name}_SDK_DIR}/src/rp2_common/hardware_dma/dma.c
    ${${board_name}_SDK_DIR}/src/rp2_common/hardware_irq/irq.c
    ${${board_name}_SDK_DIR}/src/rp2_common/hardware_pio/pio.c
    ${${board_name}_SDK_DIR}/src/rp2_common/hardware_pll/pll.c
    ${${board_name}_SDK_DIR}/src/rp2_common/hardware_sync/sync.c
    ${${board_name}_SDK_DIR}/src/rp2_common/hardware_watchdog/watchdog.c
    ${${board_name}_SDK_DIR}/src/rp2_common/hardware_xosc/xosc.c
    ${${board_name}_SDK_DIR}/src/rp2_common/hardware_clocks/clocks.c
    ${${board_name}_SDK_DIR}/src/rp2_common/hardware_flash/flash.c
    ${${board_name}_SDK_DIR}/src/rp2_common/hardware_systimer/systimer.c
    ${${board_name}_SDK_DIR}/src/rp2_common/hardware_rtc/rtc.c
    ${${board_name}_SDK_DIR}/src/rp2_common/hardware_resets/resets.c
    ${${board_name}_SDK_DIR}/src/rp2_common/hardware_claim/claim.c
    ${${board_name}_SDK_DIR}/src/rp2_common/hardware_divider/divider.c
    ${${board_name}_SDK_DIR}/src/rp2_common/hardware_exception/exception.c
    ${${board_name}_SDK_DIR}/src/rp2_common/hardware_interp/interp.c
    ${${board_name}_SDK_DIR}/src/rp2_common/pico_platform/platform.c
)

set(${board_name}_INCDIR ${${board_name}_DIR}/include)
set(${board_name}_INCDIR_HAL_LIB ${${board_name}_DIR}/hal/include)