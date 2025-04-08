#
# The Raspberry Pi Pico board configuration
#
string(TOUPPER ${board_name} BOARD_NAME_UPPERCASE)
set(${board_name}_CLASS "Raspberry")
set(${board_name}_SUBCLASS "Pico")
set(${board_name}_CPUNAME "ARM Cortex-M0+")
set(${board_name}_CPU "ARM_CPU_CORTEX_M0PLUS")
set(${board_name}_DEFINES -D${BOARD_NAME_UPPERCASE} -D${${board_name}_CLASS} -D${${board_name}_CLASS}${${board_name}_SUBCLASS})
set(${board_name}_CFLAGS ${ARM_CPU_CORTEX_M0PLUS_FLAGS} ${ARM_CPU_CORTEX_THUMB_INTERWORK_FLAGS} ${ARM_CPU_ABI_SOFT_FLOAT_FLAGS} -ffunction-sections -fdata-sections -fno-common -fmessage-length=0)
set(${board_name}_LDFLAGS ${ARM_CPU_CORTEX_M0PLUS_FLAGS} ${ARM_CPU_CORTEX_THUMB_INTERWORK_FLAGS} ${ARM_CPU_ABI_SOFT_FLOAT_FLAGS} ${TOOLCHAIN_LINKER_FLAG} ${TOOLCHAIN_LINKER_PREFIX}--gc-sections ${TOOLCHAIN_LINKER_EXTRA_LDFLAGS})

# Pico SDK paths
set(${board_name}_FIRMWARE "pico-sdk")
set(${board_name}_FIRMWARE_DIR ${firmware_${${board_name}_FIRMWARE}_DIR})
set(${board_name}_SDK_DIR ${${board_name}_FIRMWARE_DIR})
set(${board_name}_SDK_INCDIR ${${board_name}_SDK_DIR}/src/common/pico_base/include
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
                            ${${board_name}_SDK_DIR}/src/rp2_common/hardware_dma/include
                            ${${board_name}_SDK_DIR}/src/rp2_common/hardware_exception/include
                            ${${board_name}_SDK_DIR}/src/rp2_common/hardware_interp/include
                            ${${board_name}_SDK_DIR}/src/rp2_common/hardware_pio/include
                            ${${board_name}_SDK_DIR}/src/rp2_common/hardware_pll/include
                            ${${board_name}_SDK_DIR}/src/rp2_common/hardware_rtc/include
                            ${${board_name}_SDK_DIR}/src/rp2_common/hardware_systimer/include
                            ${${board_name}_SDK_DIR}/src/rp2_common/hardware_timer/include
                            ${${board_name}_SDK_DIR}/src/rp2_common/hardware_uart/include
                            ${${board_name}_SDK_DIR}/src/rp2_common/hardware_watchdog/include
                            ${${board_name}_SDK_DIR}/src/rp2_common/hardware_xosc/include
                            ${${board_name}_SDK_DIR}/src/rp2_common/pico_platform/include
                            ${${board_name}_SDK_DIR}/src/rp2040/hardware_regs/include
                            ${${board_name}_SDK_DIR}/src/rp2040/hardware_structs/include)

set(${board_name}_SDK_SRCDIR ${${board_name}_SDK_DIR}/src/common/pico_base
                            ${${board_name}_SDK_DIR}/src/common/pico_stdlib
                            ${${board_name}_SDK_DIR}/src/rp2_common/hardware_gpio
                            ${${board_name}_SDK_DIR}/src/rp2_common/hardware_uart
                            ${${board_name}_SDK_DIR}/src/rp2_common/hardware_i2c
                            ${${board_name}_SDK_DIR}/src/rp2_common/hardware_spi
                            ${${board_name}_SDK_DIR}/src/rp2_common/hardware_pwm
                            ${${board_name}_SDK_DIR}/src/rp2_common/hardware_timer
                            ${${board_name}_SDK_DIR}/src/rp2_common/hardware_adc
                            ${${board_name}_SDK_DIR}/src/rp2_common/hardware_dma
                            ${${board_name}_SDK_DIR}/src/rp2_common/hardware_irq
                            ${${board_name}_SDK_DIR}/src/rp2_common/hardware_pio
                            ${${board_name}_SDK_DIR}/src/rp2_common/hardware_pll
                            ${${board_name}_SDK_DIR}/src/rp2_common/hardware_sync
                            ${${board_name}_SDK_DIR}/src/rp2_common/hardware_watchdog
                            ${${board_name}_SDK_DIR}/src/rp2_common/hardware_xosc
                            ${${board_name}_SDK_DIR}/src/rp2_common/hardware_clocks
                            ${${board_name}_SDK_DIR}/src/rp2_common/hardware_flash
                            ${${board_name}_SDK_DIR}/src/rp2_common/hardware_systimer
                            ${${board_name}_SDK_DIR}/src/rp2_common/hardware_rtc
                            ${${board_name}_SDK_DIR}/src/rp2_common/hardware_resets
                            ${${board_name}_SDK_DIR}/src/rp2_common/hardware_claim
                            ${${board_name}_SDK_DIR}/src/rp2_common/hardware_divider
                            ${${board_name}_SDK_DIR}/src/rp2_common/hardware_dma
                            ${${board_name}_SDK_DIR}/src/rp2_common/hardware_exception
                            ${${board_name}_SDK_DIR}/src/rp2_common/hardware_interp
                            ${${board_name}_SDK_DIR}/src/rp2_common/hardware_pio
                            ${${board_name}_SDK_DIR}/src/rp2_common/hardware_pll
                            ${${board_name}_SDK_DIR}/src/rp2_common/hardware_rtc
                            ${${board_name}_SDK_DIR}/src/rp2_common/hardware_systimer
                            ${${board_name}_SDK_DIR}/src/rp2_common/hardware_timer
                            ${${board_name}_SDK_DIR}/src/rp2_common/hardware_uart
                            ${${board_name}_SDK_DIR}/src/rp2_common/hardware_watchdog
                            ${${board_name}_SDK_DIR}/src/rp2_common/hardware_xosc
                            ${${board_name}_SDK_DIR}/src/rp2_common/pico_platform
                            ${${board_name}_SDK_DIR}/src/rp2040/hardware_regs
                            ${${board_name}_SDK_DIR}/src/rp2040/hardware_structs)

set(${board_name}_INCDIR ${${board_name}_DIR}/include)
set(${board_name}_INCDIR_HAL_LIB ${${board_name}_DIR}/hal/include)

# The individual SDK source files
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

add_library(${board_name}_SDK STATIC ${${board_name}_SDK_SRCS})
target_compile_options(${board_name}_SDK PRIVATE ${${board_name}_CFLAGS})
target_compile_definitions(${board_name}_SDK PRIVATE ${${board_name}_DEFINES})
target_include_directories(${board_name}_SDK
    PRIVATE ${${board_name}_INCDIR_HAL_LIB}
    PUBLIC ${${board_name}_INCDIR}
    ${${board_name}_SDK_INCDIR}
)

set(${board_name}_LIBS
    ${board_name}_SDK
) 