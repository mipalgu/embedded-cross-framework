#
# The nucleo_f207zg board configuration
#
string(TOUPPER ${board_name} BOARD_NAME_UPPERCASE)
set(${board_name}_CLASS "STM32")
set(${board_name}_SUBCLASS "F2")
set(${board_name}_FAMILY "07")
set(${board_name}_MODEL "ZG")
set(${board_name}_CPUNAME "ARM Cortex-M3")
set(${board_name}_CPU "ARM_CPU_CORTEX_M3")
set(${board_name}_DEFINES -D${BOARD_NAME_UPPERCASE} -D${${board_name}_CLASS} -D${${board_name}_CLASS}${${board_name}_SUBCLASS} -D${${board_name}_CLASS}${${board_name}_SUBCLASS}${${board_name}_FAMILY} -D${${board_name}_CLASS}${${board_name}_SUBCLASS}${${board_name}_FAMILY}xx -D${${board_name}_CLASS}${${board_name}_SUBCLASS}${${board_name}_FAMILY}${${board_name}_MODEL})
set(${board_name}_CFLAGS ${ARM_CPU_CORTEX_M3_FLAGS} ${ARM_CPU_CORTEX_THUMB_INTERWORK_FLAGS} ${ARM_CPU_ABI_SOFT_FLOAT_FLAGS} -ffunction-sections -fdata-sections -fno-common -fmessage-length=0)
set(${board_name}_LDFLAGS ${ARM_CPU_CORTEX_M3_FLAGS} ${ARM_CPU_CORTEX_THUMB_INTERWORK_FLAGS} ${ARM_CPU_ABI_SOFT_FLOAT_FLAGS} ${TOOLCHAIN_LINKER_FLAG} ${TOOLCHAIN_LINKER_PREFIX}--gc-sections ${TOOLCHAIN_LINKER_EXTRA_LDFLAGS})
MESSAGE(STATUS "${board_name}_LDFLAGS: ${${board_name}_LDFLAGS}")
set(${board_name}_FIRMWARE "STM32CubeF2")
set(${board_name}_FIRMWARE_DIR ${firmware_${${board_name}_FIRMWARE}_DIR})
set(${board_name}_HAL_DIR ${${board_name}_FIRMWARE_DIR}/Drivers/STM32F2xx_HAL_Driver)
set(${board_name}_HAL_INCDIR ${${board_name}_HAL_DIR}/Inc)
set(${board_name}_HAL_SRCDIR ${${board_name}_HAL_DIR}/Src)
set(${board_name}_CMSIS_DIR ${${board_name}_FIRMWARE_DIR}/Drivers/CMSIS)
set(${board_name}_CMSIS_INCDIR ${${board_name}_CMSIS_DIR}/Include)
set(${board_name}_CMSIS_DEVICE_INCDIR ${${board_name}_CMSIS_DIR}//Device/ST/STM32F2xx/Include)
set(${board_name}_CMSIS_DEVICE_SRCDIR ${${board_name}_CMSIS_DIR}//Device/ST/STM32F2xx/Source/Templates)
set(${board_name}_BOARD_RTOS_DIR ${${board_name}_FIRMWARE_DIR}/Middlewares/Third_Party/FreeRTOS/Source)
set(${board_name}_BOARD_RTOS_PORTABLE_DIR ${${board_name}_BOARD_RTOS_DIR}/portable)
set(${board_name}_BOARD_RTOS_PORTABLE_MEMMAN_DIR ${${board_name}_BOARD_RTOS_PORTABLE_DIR}/MemMang)
set(${board_name}_BOARD_RTOS_PORTABLE_CPU_DIR ${${board_name}_BOARD_RTOS_PORTABLE_DIR}/GCC/ARM_CM3)
set(${board_name}_BOARD_RTOS_INCDIR ${${board_name}_BOARD_RTOS_DIR}/include)
set(${board_name}_CMSIS_RTOS_DIR ${${board_name}_BOARD_RTOS_DIR}/CMSIS_RTOS_V2)
set(${board_name}_INCDIR ${${board_name}_DIR}/include)
set(${board_name}_INCDIR_HAL_LIB ${${board_name}_DIR}/hal/include)
set(${board_name}_HAL_INCDIR_LEGACY ${${board_name}_HAL_INCDIR}/Legacy)
set(${board_name}_CMSIS_RTOS_INCDIR ${${board_name}_CMSIS_RTOS_DIR})
set(${board_name}_BOARD_RTOS_PORTABLE_CPU_INCDIR ${${board_name}_BOARD_RTOS_PORTABLE_CPU_DIR})
set(${board_name}_BOARD_RTOS_PORTABLE_MEMMAN_INCDIR ${${board_name}_BOARD_RTOS_PORTABLE_MEMMAN_DIR})
set(${board_name}_STARTUP_SRC ${${board_name}_CMSIS_DEVICE_SRCDIR}/gcc/startup_stm32f207xx.s)
set(${board_name}_LINKER_SCRIPT ${${board_name}_FIRMWARE_DIR}/Projects/NUCLEO-F207ZG/Templates/SW4STM32/STM32F207xG_Nucleo/STM32F207ZGTx_FLASH.ld)
#set(${board_name}_LIBDIR ${TOOLCHAIN_LIBDIR} ${TOOLCHAIN_LIBGCC_DIR})

# The individual HAL source files
set(${board_name}_HAL_SRCS
    ${${board_name}_CMSIS_DEVICE_SRCDIR}/system_stm32f2xx.c
    ${${board_name}_HAL_SRCDIR}/stm32f2xx_hal.c
    ${${board_name}_HAL_SRCDIR}/stm32f2xx_hal_adc.c
    ${${board_name}_HAL_SRCDIR}/stm32f2xx_hal_adc_ex.c
    ${${board_name}_HAL_SRCDIR}/stm32f2xx_hal_can.c
    ${${board_name}_HAL_SRCDIR}/stm32f2xx_hal_cortex.c
    ${${board_name}_HAL_SRCDIR}/stm32f2xx_hal_crc.c
    ${${board_name}_HAL_SRCDIR}/stm32f2xx_hal_cryp.c
    ${${board_name}_HAL_SRCDIR}/stm32f2xx_hal_dac.c
    ${${board_name}_HAL_SRCDIR}/stm32f2xx_hal_dac_ex.c
    ${${board_name}_HAL_SRCDIR}/stm32f2xx_hal_dcmi.c
    ${${board_name}_HAL_SRCDIR}/stm32f2xx_hal_dcmi_ex.c
    ${${board_name}_HAL_SRCDIR}/stm32f2xx_hal_eth.c
    ${${board_name}_HAL_SRCDIR}/stm32f2xx_hal_exti.c
    ${${board_name}_HAL_SRCDIR}/stm32f2xx_hal_flash.c
    ${${board_name}_HAL_SRCDIR}/stm32f2xx_hal_flash_ex.c
    ${${board_name}_HAL_SRCDIR}/stm32f2xx_hal_gpio.c
    ${${board_name}_HAL_SRCDIR}/stm32f2xx_hal_hash.c
    ${${board_name}_HAL_SRCDIR}/stm32f2xx_hal_hcd.c
    ${${board_name}_HAL_SRCDIR}/stm32f2xx_hal_i2c.c
    ${${board_name}_HAL_SRCDIR}/stm32f2xx_hal_i2s.c
    ${${board_name}_HAL_SRCDIR}/stm32f2xx_hal_irda.c
    ${${board_name}_HAL_SRCDIR}/stm32f2xx_hal_iwdg.c
    ${${board_name}_HAL_SRCDIR}/stm32f2xx_hal_mmc.c
    ${${board_name}_HAL_SRCDIR}/stm32f2xx_hal_nand.c
    ${${board_name}_HAL_SRCDIR}/stm32f2xx_hal_nor.c
    ${${board_name}_HAL_SRCDIR}/stm32f2xx_hal_pccard.c
    ${${board_name}_HAL_SRCDIR}/stm32f2xx_hal_pcd.c
    ${${board_name}_HAL_SRCDIR}/stm32f2xx_hal_pcd_ex.c
    ${${board_name}_HAL_SRCDIR}/stm32f2xx_hal_pwr.c
    ${${board_name}_HAL_SRCDIR}/stm32f2xx_hal_pwr_ex.c
    ${${board_name}_HAL_SRCDIR}/stm32f2xx_hal_rcc.c
    ${${board_name}_HAL_SRCDIR}/stm32f2xx_hal_rcc_ex.c
    ${${board_name}_HAL_SRCDIR}/stm32f2xx_hal_rng.c
    ${${board_name}_HAL_SRCDIR}/stm32f2xx_hal_rtc.c
    ${${board_name}_HAL_SRCDIR}/stm32f2xx_hal_rtc_ex.c
    ${${board_name}_HAL_SRCDIR}/stm32f2xx_hal_sd.c
    ${${board_name}_HAL_SRCDIR}/stm32f2xx_hal_smartcard.c
    ${${board_name}_HAL_SRCDIR}/stm32f2xx_hal_spi.c
    ${${board_name}_HAL_SRCDIR}/stm32f2xx_hal_sram.c
    ${${board_name}_HAL_SRCDIR}/stm32f2xx_hal_tim.c
    ${${board_name}_HAL_SRCDIR}/stm32f2xx_hal_tim_ex.c
    ${${board_name}_HAL_SRCDIR}/stm32f2xx_hal_uart.c
    ${${board_name}_HAL_SRCDIR}/stm32f2xx_hal_usart.c
    ${${board_name}_HAL_SRCDIR}/stm32f2xx_hal_wwdg.c
    ${${board_name}_HAL_SRCDIR}/stm32f2xx_ll_adc.c
    ${${board_name}_HAL_SRCDIR}/stm32f2xx_ll_crc.c
    ${${board_name}_HAL_SRCDIR}/stm32f2xx_ll_dac.c
    ${${board_name}_HAL_SRCDIR}/stm32f2xx_ll_dma.c
    ${${board_name}_HAL_SRCDIR}/stm32f2xx_ll_exti.c
    ${${board_name}_HAL_SRCDIR}/stm32f2xx_ll_fsmc.c
    ${${board_name}_HAL_SRCDIR}/stm32f2xx_ll_gpio.c
    ${${board_name}_HAL_SRCDIR}/stm32f2xx_ll_i2c.c
    ${${board_name}_HAL_SRCDIR}/stm32f2xx_ll_pwr.c
    ${${board_name}_HAL_SRCDIR}/stm32f2xx_ll_rcc.c
    ${${board_name}_HAL_SRCDIR}/stm32f2xx_ll_rng.c
    ${${board_name}_HAL_SRCDIR}/stm32f2xx_ll_rtc.c
    ${${board_name}_HAL_SRCDIR}/stm32f2xx_ll_sdmmc.c
    ${${board_name}_HAL_SRCDIR}/stm32f2xx_ll_spi.c
    ${${board_name}_HAL_SRCDIR}/stm32f2xx_ll_tim.c
    ${${board_name}_HAL_SRCDIR}/stm32f2xx_ll_usart.c
    ${${board_name}_HAL_SRCDIR}/stm32f2xx_ll_usb.c
    ${${board_name}_HAL_SRCDIR}/stm32f2xx_ll_utils.c
)

# The individual FreeRTOS source files
set(${board_name}_FREERTOS_SRCS
    ${${board_name}_BOARD_RTOS_PORTABLE_CPU_DIR}/port.c
    ${${board_name}_BOARD_RTOS_PORTABLE_MEMMAN_DIR}/heap_4.c
    ${${board_name}_CMSIS_RTOS_DIR}/cmsis_os2.c
    ${${board_name}_BOARD_RTOS_DIR}/croutine.c
    ${${board_name}_BOARD_RTOS_DIR}/event_groups.c
    ${${board_name}_BOARD_RTOS_DIR}/list.c
    ${${board_name}_BOARD_RTOS_DIR}/queue.c
    ${${board_name}_BOARD_RTOS_DIR}/stream_buffer.c
    ${${board_name}_BOARD_RTOS_DIR}/tasks.c
    ${${board_name}_BOARD_RTOS_DIR}/timers.c
)

# The FreeRTOS library include directories
set(${board_name}_FREERTOS_INCDIRS
    ${${board_name}_BOARD_RTOS_PORTABLE_DIR}
    ${${board_name}_BOARD_RTOS_PORTABLE_MEMMAN_DIR}
    ${${board_name}_BOARD_RTOS_PORTABLE_CPU_DIR}
    ${${board_name}_CMSIS_RTOS_DIR}
    ${${board_name}_BOARD_RTOS_DIR}
    ${${board_name}_BOARD_RTOS_INCDIR}
    ${${board_name}_CMSIS_INCDIR}
)

add_library(${board_name}_HAL STATIC ${${board_name}_HAL_SRCS})
target_compile_options(${board_name}_HAL PRIVATE ${${board_name}_CFLAGS})
target_compile_definitions(${board_name}_HAL PRIVATE ${${board_name}_DEFINES})
target_include_directories(${board_name}_HAL
    PRIVATE ${${board_name}_INCDIR_HAL_LIB}
    PUBLIC ${${board_name}_INCDIR}
    ${${board_name}_HAL_INCDIR}
    ${${board_name}_HAL_INCDIR_LEGACY}
    ${${board_name}_CMSIS_DEVICE_INCDIR}
    ${${board_name}_CMSIS_INCDIR}
)

set(${board_name}_LIBS
    ${board_name}_HAL
    #${board_name}_CMSIS
    #${board_name}_CMSIS_DEVICE
)