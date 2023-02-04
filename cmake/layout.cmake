# Customise the following variables to suit your needs,
# depending on the environment and type of system you are running.

# Locations
set(CORE_OS_DIR src/os/Core)
set(DRIVER_DIR src/OS/Drivers)
set(CORE_OS_SRC ${CORE_OS_DIR}/Src)
set(DRIVER_SRC ${DRIVER_DIR}/STM32F2xx_HAL_Driver/Src)
set(CORE_OS_INC ${CORE_OS_DIR}/Inc)
set(DRIVER_INC ${DRIVER_DIR}/STM32F2xx_HAL_Driver/Inc)

# Boot up sources to compile
set(BOOT_SOURCES
#    ${CORE_OS_DIR}/Startup/startup_stm32f207xx.s
)

# Operating System Sources to compile
set(OS_SOURCES
    #${CORE_OS_SRC}/syscalls.c
    #${CORE_OS_SRC}/sysmem.c  
    #${CORE_OS_SRC}/system_stm32f2xx.c
    #${CORE_OS_SRC}/stm32f2xx_hal_msp.c
    #${CORE_OS_SRC}/stm32f2xx_it.c
    #src/Drivers/STM32F2xx_HAL_Driver/Src/stm32f2xx_hal.c
)

# Operating System include directories
set(OS_INCLUDES
    ${CORE_OS_INC}
)

# Driver Sources to compile
set(DRIVER_SOURCES
    #${DRIVER_SRC}/stm32f2xx_hal.c
    #${DRIVER_SRC}/stm32f2xx_hal_cortex.c
    #${DRIVER_SRC}/stm32f2xx_hal_can.c
    #${DRIVER_SRC}/stm32f2xx_hal_dma.c
    #${DRIVER_SRC}/stm32f2xx_hal_dma_ex.c
    #${DRIVER_SRC}/stm32f2xx_hal_flash.c
    #${DRIVER_SRC}/stm32f2xx_hal_flash_ex.c
    #${DRIVER_SRC}/stm32f2xx_hal_gpio.c
    #${DRIVER_SRC}/stm32f2xx_hal_pwr.c
    #${DRIVER_SRC}/stm32f2xx_hal_pwr_ex.c
    #${DRIVER_SRC}/stm32f2xx_hal_rcc.c
    #${DRIVER_SRC}/stm32f2xx_hal_rcc_ex.c
    #${DRIVER_SRC}/stm32f2xx_hal_tim.c
    #${DRIVER_SRC}/stm32f2xx_hal_tim_ex.c
    #${DRIVER_SRC}/stm32f2xx_hal_uart.c
    #${DRIVER_SRC}/stm32f2xx_ll_usb.c
)

# Driver include directories
set(DRIVER_INCLUDES
    ${DRIVER_INC}
)
