// This is the default HAL configuration file.
//
// Do not modify this file directly.  Instead,
// use your own configuration file and include it
// prior to including `hal.h`.

#ifndef STM32H7XX_HAL_CONF_H_
#define STM32H7XX_HAL_CONF_H_

// Module selection
#if !defined(HAL_MODULE_ENABLED) && !defined(HAL_MODULE_DISABLED)
#  define HAL_MODULE_ENABLED
#endif
// #define HAL_ADC_MODULE_ENABLED
// #define HAL_BDMA_MODULE_ENABLED
// #define HAL_CEC_MODULE_ENABLED
// #define HAL_COMP_MODULE_ENABLED
// #define HAL_CORDIC_MODULE_ENABLED
// #define HAL_CRC_MODULE_ENABLED
// #define HAL_CRYP_MODULE_ENABLED
// #define HAL_DAC_MODULE_ENABLED
// #define HAL_DCMI_MODULE_ENABLED
// #define HAL_DFSDM_MODULE_ENABLED
// #define HAL_DMA2D_MODULE_ENABLED
// #define HAL_DSI_MODULE_ENABLED
// #define HAL_DTS_MODULE_ENABLED
// #define HAL_ETH_MODULE_ENABLED
// #define HAL_EXTI_MODULE_ENABLED
// #define HAL_FDCAN_MODULE_ENABLED
// #define HAL_FMAC_MODULE_ENABLED
// #define HAL_GFXMMU_MODULE_ENABLED
// #define HAL_GPIO_MODULE_ENABLED
// #define HAL_HASH_MODULE_ENABLED
// #define HAL_HCD_MODULE_ENABLED
// #define HAL_HRTIM_MODULE_ENABLED
// #define HAL_HSEM_MODULE_ENABLED
// #define HAL_I2C_MODULE_ENABLED
// #define HAL_I2S_MODULE_ENABLED
// #define HAL_IRDA_MODULE_ENABLED
// #define HAL_IWDG_MODULE_ENABLED
// #define HAL_JPEG_MODULE_ENABLED
// #define HAL_LPTIM_MODULE_ENABLED
// #define HAL_LTDC_MODULE_ENABLED
// #define HAL_MDIOS_MODULE_ENABLED
// #define HAL_MDMA_MODULE_ENABLED
// #define HAL_MMC_MODULE_ENABLED
// #define HAL_NAND_MODULE_ENABLED
// #define HAL_NOR_MODULE_ENABLED
// #define HAL_OPAMP_MODULE_ENABLED
// #define HAL_OSPI_MODULE_ENABLED
// #define HAL_OTFDEC_MODULE_ENABLED
// #define HAL_PCD_MODULE_ENABLED
// #define HAL_PSSI_MODULE_ENABLED
// #define HAL_PWR_MODULE_ENABLED
// #define HAL_QSPI_MODULE_ENABLED
// #define HAL_RAMECC_MODULE_ENABLED
// #define HAL_RCC_MODULE_ENABLED
// #define HAL_RNG_MODULE_ENABLED
// #define HAL_RTC_MODULE_ENABLED
// #define HAL_SAI_MODULE_ENABLED
// #define HAL_SD_MODULE_ENABLED
// #define HAL_SDRAM_MODULE_ENABLED
// #define HAL_SMARTCARD_MODULE_ENABLED
// #define HAL_SMBUS_MODULE_ENABLED
// #define HAL_SPDIFRX_MODULE_ENABLED
// #define HAL_SPI_MODULE_ENABLED
// #define HAL_SRAM_MODULE_ENABLED
// #define HAL_SWPMI_MODULE_ENABLED
// #define HAL_TIM_MODULE_ENABLED
// #define HAL_UART_MODULE_ENABLED
// #define HAL_USART_MODULE_ENABLED
// #define HAL_WWDG_MODULE_ENABLED
// #define HAL_DMA_MODULE_ENABLED
// #define HAL_FLASH_MODULE_ENABLED
// #define HAL_CORTEX_MODULE_ENABLED

// By default, all HAL register callbacks are disabled.
#ifndef USE_HAL_ADC_REGISTER_CALLBACKS
#  define USE_HAL_ADC_REGISTER_CALLBACKS 0U
#endif
#ifndef USE_HAL_COMP_REGISTER_CALLBACKS
#  define USE_HAL_COMP_REGISTER_CALLBACKS 0U
#endif
#ifndef USE_HAL_CORDIC_REGISTER_CALLBACKS
#  define USE_HAL_CORDIC_REGISTER_CALLBACKS 0U
#endif
#ifndef USE_HAL_CRYP_REGISTER_CALLBACKS
#  define USE_HAL_CRYP_REGISTER_CALLBACKS 0U
#endif
#ifndef USE_HAL_DAC_REGISTER_CALLBACKS
#  define USE_HAL_DAC_REGISTER_CALLBACKS 0U
#endif
#ifndef USE_HAL_DCMI_REGISTER_CALLBACKS
#  define USE_HAL_DCMI_REGISTER_CALLBACKS 0U
#endif
#ifndef USE_HAL_DFSDM_REGISTER_CALLBACKS
#  define USE_HAL_DFSDM_REGISTER_CALLBACKS 0U
#endif
#ifndef USE_HAL_DMA2D_REGISTER_CALLBACKS
#  define USE_HAL_DMA2D_REGISTER_CALLBACKS 0U
#endif
#ifndef USE_HAL_DSI_REGISTER_CALLBACKS
#  define USE_HAL_DSI_REGISTER_CALLBACKS 0U
#endif
#ifndef USE_HAL_DTS_REGISTER_CALLBACKS
#  define USE_HAL_DTS_REGISTER_CALLBACKS 0U
#endif
#ifndef USE_HAL_ETH_REGISTER_CALLBACKS
#  define USE_HAL_ETH_REGISTER_CALLBACKS 0U
#endif
#ifndef USE_HAL_FDCAN_REGISTER_CALLBACKS
#  define USE_HAL_FDCAN_REGISTER_CALLBACKS 0U
#endif
#ifndef USE_HAL_FMAC_REGISTER_CALLBACKS
#  define USE_HAL_FMAC_REGISTER_CALLBACKS 0U
#endif
#ifndef USE_HAL_HASH_REGISTER_CALLBACKS
#  define USE_HAL_HASH_REGISTER_CALLBACKS 0U
#endif
#ifndef USE_HAL_HCD_REGISTER_CALLBACKS
#  define USE_HAL_HCD_REGISTER_CALLBACKS 0U
#endif
#ifndef USE_HAL_HRTIM_REGISTER_CALLBACKS
#  define USE_HAL_HRTIM_REGISTER_CALLBACKS 0U
#endif
#ifndef USE_HAL_I2C_REGISTER_CALLBACKS
#  define USE_HAL_I2C_REGISTER_CALLBACKS 0U
#endif
#ifndef USE_HAL_I2S_REGISTER_CALLBACKS
#  define USE_HAL_I2S_REGISTER_CALLBACKS 0U
#endif
#ifndef USE_HAL_IRDA_REGISTER_CALLBACKS
#  define USE_HAL_IRDA_REGISTER_CALLBACKS 0U
#endif
#ifndef USE_HAL_JPEG_REGISTER_CALLBACKS
#  define USE_HAL_JPEG_REGISTER_CALLBACKS 0U
#endif
#ifndef USE_HAL_LPTIM_REGISTER_CALLBACKS
#  define USE_HAL_LPTIM_REGISTER_CALLBACKS 0U
#endif
#ifndef USE_HAL_LTDC_REGISTER_CALLBACKS
#  define USE_HAL_LTDC_REGISTER_CALLBACKS 0U
#endif
#ifndef USE_HAL_MDIOS_REGISTER_CALLBACKS
#  define USE_HAL_MDIOS_REGISTER_CALLBACKS 0U
#endif
#ifndef USE_HAL_MMC_REGISTER_CALLBACKS
#  define USE_HAL_MMC_REGISTER_CALLBACKS 0U
#endif
#ifndef USE_HAL_NAND_REGISTER_CALLBACKS
#  define USE_HAL_NAND_REGISTER_CALLBACKS 0U
#endif
#ifndef USE_HAL_NOR_REGISTER_CALLBACKS
#  define USE_HAL_NOR_REGISTER_CALLBACKS 0U
#endif
#ifndef USE_HAL_OPAMP_REGISTER_CALLBACKS
#  define USE_HAL_OPAMP_REGISTER_CALLBACKS 0U
#endif
#ifndef USE_HAL_OSPI_REGISTER_CALLBACKS
#  define USE_HAL_OSPI_REGISTER_CALLBACKS 0U
#endif
#ifndef USE_HAL_OTFDEC_REGISTER_CALLBACKS
#  define USE_HAL_OTFDEC_REGISTER_CALLBACKS 0U
#endif
#ifndef USE_HAL_PCD_REGISTER_CALLBACKS
#  define USE_HAL_PCD_REGISTER_CALLBACKS 0U
#endif
#ifndef USE_HAL_PSSI_REGISTER_CALLBACKS
#  define USE_HAL_PSSI_REGISTER_CALLBACKS 0U
#endif
#ifndef USE_HAL_QSPI_REGISTER_CALLBACKS
#  define USE_HAL_QSPI_REGISTER_CALLBACKS 0U
#endif
#ifndef USE_HAL_RAMECC_REGISTER_CALLBACKS
#  define USE_HAL_RAMECC_REGISTER_CALLBACKS 0U
#endif
#ifndef USE_HAL_RNG_REGISTER_CALLBACKS
#  define USE_HAL_RNG_REGISTER_CALLBACKS 0U
#endif
#ifndef USE_HAL_RTC_REGISTER_CALLBACKS
#  define USE_HAL_RTC_REGISTER_CALLBACKS 0U
#endif
#ifndef USE_HAL_SAI_REGISTER_CALLBACKS
#  define USE_HAL_SAI_REGISTER_CALLBACKS 0U
#endif
#ifndef USE_HAL_SD_REGISTER_CALLBACKS
#  define USE_HAL_SD_REGISTER_CALLBACKS 0U
#endif
#ifndef USE_HAL_SDRAM_REGISTER_CALLBACKS
#  define USE_HAL_SDRAM_REGISTER_CALLBACKS 0U
#endif
#ifndef USE_HAL_SMARTCARD_REGISTER_CALLBACKS
#  define USE_HAL_SMARTCARD_REGISTER_CALLBACKS 0U
#endif
#ifndef USE_HAL_SMBUS_REGISTER_CALLBACKS
#  define USE_HAL_SMBUS_REGISTER_CALLBACKS 0U
#endif
#ifndef USE_HAL_SPDIFRX_REGISTER_CALLBACKS
#  define USE_HAL_SPDIFRX_REGISTER_CALLBACKS 0U
#endif
#ifndef USE_HAL_SPI_REGISTER_CALLBACKS
#  define USE_HAL_SPI_REGISTER_CALLBACKS 0U
#endif
#ifndef USE_HAL_SRAM_REGISTER_CALLBACKS
#  define USE_HAL_SRAM_REGISTER_CALLBACKS 0U
#endif
#ifndef USE_HAL_SWPMI_REGISTER_CALLBACKS
#  define USE_HAL_SWPMI_REGISTER_CALLBACKS 0U
#endif
#ifndef USE_HAL_TIM_REGISTER_CALLBACKS
#  define USE_HAL_TIM_REGISTER_CALLBACKS 0U
#endif
#ifndef USE_HAL_UART_REGISTER_CALLBACKS
#  define USE_HAL_UART_REGISTER_CALLBACKS 0U
#endif
#ifndef USE_HAL_USART_REGISTER_CALLBACKS
#  define USE_HAL_USART_REGISTER_CALLBACKS 0U
#endif
#ifndef USE_HAL_WWDG_REGISTER_CALLBACKS
#  define USE_HAL_WWDG_REGISTER_CALLBACKS 0U
#endif

#ifndef HSE_VALUE
/// External high-speed oscillator clock frequency in Hz.
#  define HSE_VALUE 8000000U
#endif

#ifndef HSE_STARTUP_TIMEOUT
/// External high-speed oscillator startup timeout in milliseconds.
#  define HSE_STARTUP_TIMEOUT 100U
#endif

#ifndef HSI_VALUE
/// Internal high-speed oscillator clock frequency in Hz.
#  define HSI_VALUE 64000000U
#endif

#ifndef CSI_VALUE
/// Internal clock security system clock frequency in Hz.
#  define CSI_VALUE 4000000U
#endif

#ifndef LSE_VALUE
/// External low-speed oscillator clock frequency in Hz.
#  define LSE_VALUE 32768U
#endif

#ifndef LSE_STARTUP_TIMEOUT
/// External low-speed oscillator startup timeout in milliseconds.
#  define LSE_STARTUP_TIMEOUT 5000U
#endif

#ifndef LSI_VALUE
/// Internal low-speed oscillator clock frequency in Hz.
#  define LSI_VALUE 32000U
#endif

#ifndef EXTERNAL_CLOCK_VALUE
/// External clock frequency in Hz.
#  define EXTERNAL_CLOCK_VALUE 12288000U
#endif

#ifndef VDD_VALUE
/// VDD in millivolts.
#  define VDD_VALUE 3300U
#endif

#ifndef TICK_INT_PRIORITY
/// Tick interrupt priority.
#  define TICK_INT_PRIORITY 0U
#endif

#ifndef USE_RTOS
/// Use RTOS.
#  define USE_RTOS 0U
#endif

#ifndef PREFETCH_ENABLE
/// Enable prefetch.
#  define PREFETCH_ENABLE 1U
#endif

#ifndef INSTRUCTION_CACHE_ENABLE
/// Enable instruction cache.
#  define INSTRUCTION_CACHE_ENABLE 1U
#endif

#ifndef DATA_CACHE_ENABLE
/// Enable data cache.
#  define DATA_CACHE_ENABLE 1U
#endif

// Ethernet configuration
#ifndef ETH_TX_DESC_CNT
/// Ethernet transmission descriptor count.
#  define ETH_TX_DESC_CNT 4U
#endif

#ifndef ETH_RX_DESC_CNT
/// Ethernet reception descriptor count.
#  define ETH_RX_DESC_CNT 4U
#endif

#ifndef ETH_MAC_ADDR0
/// MAC address byte 0.
#  define ETH_MAC_ADDR0 0x02U
#endif
#ifndef ETH_MAC_ADDR1
/// MAC address byte 1.
#  define ETH_MAC_ADDR1 0x00U
#endif
#ifndef ETH_MAC_ADDR2
/// MAC address byte 2.
#  define ETH_MAC_ADDR2 0x00U
#endif
#ifndef ETH_MAC_ADDR3
/// MAC address byte 3.
#  define ETH_MAC_ADDR3 0x00U
#endif
#ifndef ETH_MAC_ADDR4
/// MAC address byte 4.
#  define ETH_MAC_ADDR4 0x00U
#endif
#ifndef ETH_MAC_ADDR5
/// MAC address byte 5.
#  define ETH_MAC_ADDR5 0x00U
#endif

// LAN8742A PHY configuration.
#ifndef LAN8742A_PHY_ADDRESS
/// PHY address.
#  define LAN8742A_PHY_ADDRESS 0x00U
#endif

#ifndef PHY_RESET_DELAY
/// PHY reset delay in milliseconds.
#  define PHY_RESET_DELAY 0x000000FFU
#endif
#ifndef PHY_CONFIG_DELAY
/// PHY configuration delay in milliseconds.
#  define PHY_CONFIG_DELAY 0x00000FFFU
#endif
#ifndef PHY_READ_TO
/// PHY read timeout in milliseconds.
#  define PHY_READ_TO 0x0000FFFFU
#endif
#ifndef PHY_WRITE_TO
/// PHY write timeout in milliseconds.
#  define PHY_WRITE_TO 0x0000FFFFU
#endif

// Common PHY registers.
#ifndef PHY_BCR
/// PHY basic control register.
#  define PHY_BCR 0x00U
#endif
#ifndef PHY_BSR
/// PHY basic status register.
#  define PHY_BSR 0x01U
#endif

// Extended PHY registers.
#ifndef PHY_SR
/// PHY status register.
#  define PHY_SR 0x1FU
#endif

#ifndef PHY_RESET
/// PHY reset.
#  define PHY_RESET 0x8000U
#endif
#ifndef PHY_LOOPBACK
/// PHY loopback.
#  define PHY_LOOPBACK 0x4000U
#endif
#ifndef PHY_FULLDUPLEX_100M
/// PHY full-duplex at 100 Mbit/s.
#  define PHY_FULLDUPLEX_100M 0x2100U
#endif
#ifndef PHY_HALFDUPLEX_100M
/// PHY half-duplex at 100 Mbit/s.
#  define PHY_HALFDUPLEX_100M 0x2000U
#endif
#ifndef PHY_FULLDUPLEX_10M
/// PHY full-duplex at 10 Mbit/s.
#  define PHY_FULLDUPLEX_10M 0x0100U
#endif
#ifndef PHY_HALFDUPLEX_10M
/// PHY half-duplex at 10 Mbit/s.
#  define PHY_HALFDUPLEX_10M 0x0000U
#endif
#ifndef PHY_AUTONEGOTIATION
/// PHY auto-negotiation.
#  define PHY_AUTONEGOTIATION 0x1000U
#endif
#ifndef PHY_RESTART_AUTONEGOTIATION
/// PHY restart auto-negotiation.
#  define PHY_RESTART_AUTONEGOTIATION 0x0200U
#endif
#ifndef PHY_POWERDOWN
/// PHY power down.
#  define PHY_POWERDOWN 0x0800U
#endif
#ifndef PHY_ISOLATE
/// PHY isolate.
#  define PHY_ISOLATE 0x0400U
#endif
#ifndef PHY_AUTONEGO_COMPLETE
/// PHY auto-negotiation complete.
#  define PHY_AUTONEGO_COMPLETE 0x0020U
#endif
#ifndef PHY_LINKED_STATUS
/// PHY linked status.
#  define PHY_LINKED_STATUS 0x0004U
#endif
#ifndef PHY_JABBER_DETECTION
/// PHY jabber detection.
#  define PHY_JABBER_DETECTION 0x0002U
#endif

#ifndef PHY_SPEED_STATUS
/// PHY speed status.
#  define PHY_SPEED_STATUS 0x0004U
#endif
#ifndef PHY_DUPLEX_STATUS
/// PHY duplex status.
#  define PHY_DUPLEX_STATUS 0x0010U
#endif

// Serial peripheral interface (SPI) configuration.
#ifndef USE_SPI_CRC
/// Use SPI CRC.
#  define USE_SPI_CRC 0U
#endif

#endif /* STM32H7XX_HAL_CONF_H_ */