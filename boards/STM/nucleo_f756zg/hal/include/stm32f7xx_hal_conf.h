/* This is the default HAL configuration file for STM32F7 series. */

#ifndef STM32F7XX_HAL_CONF_H_
#define STM32F7XX_HAL_CONF_H_

#define HAL_MODULE_ENABLED

// Module selection
#define HAL_ADC_MODULE_ENABLED
#define HAL_CRYP_MODULE_ENABLED
#define HAL_CAN_MODULE_ENABLED
// #define HAL_CEC_MODULE_ENABLED
#define HAL_CORTEX_MODULE_ENABLED
#define HAL_CRC_MODULE_ENABLED
#define HAL_CRYP_MODULE_ENABLED
#define HAL_DAC_MODULE_ENABLED
#define HAL_DCMI_MODULE_ENABLED
#define HAL_DMA_MODULE_ENABLED
#define HAL_DMA2D_MODULE_ENABLED
// #define HAL_ETH_MODULE_ENABLED
// #define HAL_EXTI_MODULE_ENABLED
// #define HAL_FLASH_MODULE_ENABLED
// #define HAL_GPIO_MODULE_ENABLED
#define HAL_HASH_MODULE_ENABLED
// #define HAL_HCD_MODULE_ENABLED
#define HAL_I2C_MODULE_ENABLED
// #define HAL_I2S_MODULE_ENABLED
// #define HAL_IRDA_MODULE_ENABLED
// #define HAL_IWDG_MODULE_ENABLED
// #define HAL_LPTIM_MODULE_ENABLED
// #define HAL_LTDC_MODULE_ENABLED
// #define HAL_NAND_MODULE_ENABLED
// #define HAL_NOR_MODULE_ENABLED
// #define HAL_PCD_MODULE_ENABLED
// #define HAL_PWR_MODULE_ENABLED
// #define HAL_QSPI_MODULE_ENABLED
// #define HAL_RCC_MODULE_ENABLED
// #define HAL_RNG_MODULE_ENABLED
// #define HAL_RTC_MODULE_ENABLED
// #define HAL_SAI_MODULE_ENABLED
// #define HAL_SD_MODULE_ENABLED
// #define HAL_SMARTCARD_MODULE_ENABLED
// #define HAL_SPDIFRX_MODULE_ENABLED
#define HAL_SPI_MODULE_ENABLED
// #define HAL_SRAM_MODULE_ENABLED
// #define HAL_SDRAM_MODULE_ENABLED
#define HAL_TIM_MODULE_ENABLED
#define HAL_UART_MODULE_ENABLED
// #define HAL_USART_MODULE_ENABLED
// #define HAL_WWDG_MODULE_ENABLED

/* HSE Frequency in Hz. */
#ifndef HSE_VALUE
#  define HSE_VALUE 8000000U
#endif

/* HSE startup timeout in milliseconds. */
#ifndef HSE_STARTUP_TIMEOUT
#  define HSE_STARTUP_TIMEOUT 100U
#endif

/* Internal high-speed oscillator clock frequency in Hz. */
#ifndef HSI_VALUE
#  define HSI_VALUE 16000000U
#endif

/* Internal low-speed oscillator clock frequency in Hz. */
#ifndef LSI_VALUE
#  define LSI_VALUE 32000U
#endif

/* External low-speed oscillator clock frequency in Hz. */
#ifndef LSE_VALUE
#  define LSE_VALUE 32768U
#endif

/* External low-speed oscillator startup timeout in milliseconds. */
#ifndef LSE_STARTUP_TIMEOUT
#  define LSE_STARTUP_TIMEOUT 5000U
#endif

/* External clock frequency in Hz. */
#ifndef EXTERNAL_CLOCK_VALUE
#  define EXTERNAL_CLOCK_VALUE 12288000U
#endif

/* VDD in millivolts. */
#ifndef VDD_VALUE
#  define VDD_VALUE 3300U
#endif

/* Tick interrupt priority. */
#ifndef TICK_INT_PRIORITY
#  define TICK_INT_PRIORITY 0U
#endif

/* Use RTOS. */
#ifndef USE_RTOS
#  define USE_RTOS 0U
#endif

/* Enable prefetch. */
#ifndef PREFETCH_ENABLE
#  define PREFETCH_ENABLE 1U
#endif

/* Enable instruction cache. */
#ifndef INSTRUCTION_CACHE_ENABLE
#  define INSTRUCTION_CACHE_ENABLE 1U
#endif

/* Enable data cache. */
#ifndef DATA_CACHE_ENABLE
#  define DATA_CACHE_ENABLE 1U
#endif

/* Enable ART accelerator */
#ifndef ART_ACCLERATOR_ENABLE
#  define ART_ACCLERATOR_ENABLE 1U
#endif

/* Callback registers. */
#ifndef USE_HAL_ADC_REGISTER_CALLBACKS
#  define USE_HAL_ADC_REGISTER_CALLBACKS 0U
#endif
#ifndef USE_HAL_CAN_REGISTER_CALLBACKS
#  define USE_HAL_CAN_REGISTER_CALLBACKS 0U
#endif
#ifndef USE_HAL_CEC_REGISTER_CALLBACKS
#  define USE_HAL_CEC_REGISTER_CALLBACKS 0U
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
#ifndef USE_HAL_ETH_REGISTER_CALLBACKS
#  define USE_HAL_ETH_REGISTER_CALLBACKS 0U
#endif
#ifndef USE_HAL_HASH_REGISTER_CALLBACKS
#  define USE_HAL_HASH_REGISTER_CALLBACKS 0U
#endif
#ifndef USE_HAL_HCD_REGISTER_CALLBACKS
#  define USE_HAL_HCD_REGISTER_CALLBACKS 0U
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
#ifndef USE_HAL_LPTIM_REGISTER_CALLBACKS
#  define USE_HAL_LPTIM_REGISTER_CALLBACKS 0U
#endif
#ifndef USE_HAL_LTDC_REGISTER_CALLBACKS
#  define USE_HAL_LTDC_REGISTER_CALLBACKS 0U
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
#ifndef USE_HAL_PCCARD_REGISTER_CALLBACKS
#  define USE_HAL_PCCARD_REGISTER_CALLBACKS 0U
#endif
#ifndef USE_HAL_PCD_REGISTER_CALLBACKS
#  define USE_HAL_PCD_REGISTER_CALLBACKS 0U
#endif
#ifndef USE_HAL_QSPI_REGISTER_CALLBACKS
#  define USE_HAL_QSPI_REGISTER_CALLBACKS 0U
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
#ifndef USE_HAL_SMARTCARD_REGISTER_CALLBACKS
#  define USE_HAL_SMARTCARD_REGISTER_CALLBACKS 0U
#endif
#ifndef USE_HAL_SDRAM_REGISTER_CALLBACKS
#  define USE_HAL_SDRAM_REGISTER_CALLBACKS 0U
#endif
#ifndef USE_HAL_SRAM_REGISTER_CALLBACKS
#  define USE_HAL_SRAM_REGISTER_CALLBACKS 0U
#endif
#ifndef USE_HAL_SPDIFRX_REGISTER_CALLBACKS
#  define USE_HAL_SPDIFRX_REGISTER_CALLBACKS 0U
#endif
#ifndef USE_HAL_SMBUS_REGISTER_CALLBACKS
#  define USE_HAL_SMBUS_REGISTER_CALLBACKS 0U
#endif
#ifndef USE_HAL_SPI_REGISTER_CALLBACKS
#  define USE_HAL_SPI_REGISTER_CALLBACKS 0U
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
/// Ethernet MAC address byte 0.
#  define ETH_MAC_ADDR0 2U
#endif
#ifndef ETH_MAC_ADDR1
/// Ethernet MAC address byte 1.
#  define ETH_MAC_ADDR1 0U
#endif
#ifndef ETH_MAC_ADDR2
/// Ethernet MAC address byte 2.
#  define ETH_MAC_ADDR2 0U
#endif
#ifndef ETH_MAC_ADDR3
/// Ethernet MAC address byte 3.
#  define ETH_MAC_ADDR3 0U
#endif
#ifndef ETH_MAC_ADDR4
/// Ethernet MAC address byte 4.
#  define ETH_MAC_ADDR4 0U
#endif
#ifndef ETH_MAC_ADDR5
/// Ethernet MAC address byte 5.
#  define ETH_MAC_ADDR5 0U
#endif

// DP83848 PHY configuration.
#ifndef DP83848_PHY_ADDRESS
/// DP83848 PHY address.
#  define DP83848_PHY_ADDRESS 1U
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
#ifndef PHY_BCR
/// PHY basic control register.
#  define PHY_BCR 0x0000U
#endif
#ifndef PHY_BSR
/// PHY basic status register.
#  define PHY_BSR 0x0001U
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

#ifndef PHY_SR
/// PHY status register address.
#  define PHY_SR 0x10U
#endif
#ifndef PHY_SPEED_STATUS
/// PHY speed status.
#  define PHY_SPEED_STATUS 0x0002U
#endif
#ifndef PHY_DUPLEX_STATUS
/// PHY duplex status.
#  define PHY_DUPLEX_STATUS 0x0004U
#endif

/// Use SPI CRC.
#ifndef USE_SPI_CRC
#  define USE_SPI_CRC 0U
#endif

// Include the configured HAL modules.
#ifdef HAL_RCC_MODULE_ENABLED
#  include "stm32f7xx_hal_rcc.h"
#endif
#ifdef HAL_GPIO_MODULE_ENABLED
#  include "stm32f7xx_hal_gpio.h"
#endif
#ifdef HAL_EXTI_MODULE_ENABLED
#  include "stm32f7xx_hal_exti.h"
#endif
#ifdef HAL_DMA_MODULE_ENABLED
#  include "stm32f7xx_hal_dma.h"
#endif
#ifdef HAL_CORTEX_MODULE_ENABLED
#  include "stm32f7xx_hal_cortex.h"
#endif
#ifdef HAL_ADC_MODULE_ENABLED
#  include "stm32f7xx_hal_adc.h"
#endif
#ifdef HAL_CAN_LEGACY_MODULE_ENABLED
#  include "stm32f7xx_hal_can_legacy.h"
#endif
#ifdef HAL_CAN_MODULE_ENABLED
#  include "stm32f7xx_hal_can.h"
#endif
#ifdef HAL_CEC_MODULE_ENABLED
#  include "stm32f7xx_hal_cec.h"
#endif
#ifdef HAL_CRC_MODULE_ENABLED
#  include "stm32f7xx_hal_crc.h"
#endif
#ifdef HAL_CRYP_MODULE_ENABLED
#  include "stm32f7xx_hal_cryp.h"
#endif
#ifdef HAL_DAC_MODULE_ENABLED
#  include "stm32f7xx_hal_dac.h"
#endif
#ifdef HAL_DCMI_MODULE_ENABLED
#  include "stm32f7xx_hal_dcmi.h"
#endif
#ifdef HAL_DMA2D_MODULE_ENABLED
#  include "stm32f7xx_hal_dma2d.h"
#endif
#ifdef HAL_ETH_MODULE_ENABLED
#  include "stm32f7xx_hal_eth.h"
#endif
#ifdef HAL_FLASH_MODULE_ENABLED
#  include "stm32f7xx_hal_flash.h"
#endif
#ifdef HAL_NAND_MODULE_ENABLED
#  include "stm32f7xx_hal_nand.h"
#endif
#ifdef HAL_NOR_MODULE_ENABLED
#  include "stm32f7xx_hal_nor.h"
#endif
#ifdef HAL_PCCARD_MODULE_ENABLED
#  include "stm32f7xx_hal_pccard.h"
#endif
#ifdef HAL_SRAM_MODULE_ENABLED
#  include "stm32f7xx_hal_sram.h"
#endif
#ifdef HAL_SDRAM_MODULE_ENABLED
#  include "stm32f7xx_hal_sdram.h"
#endif
#ifdef HAL_HASH_MODULE_ENABLED
#  include "stm32f7xx_hal_hash.h"
#endif
#ifdef HAL_I2C_MODULE_ENABLED
#  include "stm32f7xx_hal_i2c.h"
#endif
#ifdef HAL_I2S_MODULE_ENABLED
#  include "stm32f7xx_hal_i2s.h"
#endif
#ifdef HAL_IWDG_MODULE_ENABLED
#  include "stm32f7xx_hal_iwdg.h"
#endif
#ifdef HAL_LPTIM_MODULE_ENABLED
#  include "stm32f7xx_hal_lptim.h"
#endif
#ifdef HAL_LTDC_MODULE_ENABLED
#  include "stm32f7xx_hal_ltdc.h"
#endif
#ifdef HAL_PWR_MODULE_ENABLED
#  include "stm32f7xx_hal_pwr.h"
#endif
#ifdef HAL_QSPI_MODULE_ENABLED
#  include "stm32f7xx_hal_qspi.h"
#endif
#ifdef HAL_RNG_MODULE_ENABLED
#  include "stm32f7xx_hal_rng.h"
#endif
#ifdef HAL_RTC_MODULE_ENABLED
#  include "stm32f7xx_hal_rtc.h"
#endif
#ifdef HAL_SAI_MODULE_ENABLED
#  include "stm32f7xx_hal_sai.h"
#endif
#ifdef HAL_SD_MODULE_ENABLED
#  include "stm32f7xx_hal_sd.h"
#endif
#ifdef HAL_SPDIFRX_MODULE_ENABLED
#  include "stm32f7xx_hal_spdifrx.h"
#endif
#ifdef HAL_SPI_MODULE_ENABLED
#  include "stm32f7xx_hal_spi.h"
#endif
#ifdef HAL_TIM_MODULE_ENABLED
#  include "stm32f7xx_hal_tim.h"
#endif
#ifdef HAL_UART_MODULE_ENABLED
#  include "stm32f7xx_hal_uart.h"
#endif
#ifdef HAL_USART_MODULE_ENABLED
#  include "stm32f7xx_hal_usart.h"
#endif
#ifdef HAL_IRDA_MODULE_ENABLED
#  include "stm32f7xx_hal_irda.h"
#endif
#ifdef HAL_SMARTCARD_MODULE_ENABLED
#  include "stm32f7xx_hal_smartcard.h"
#endif
#ifdef HAL_WWDG_MODULE_ENABLED
#  include "stm32f7xx_hal_wwdg.h"
#endif
#ifdef HAL_PCD_MODULE_ENABLED
#  include "stm32f7xx_hal_pcd.h"
#endif
#ifdef HAL_HCD_MODULE_ENABLED
#  include "stm32f7xx_hal_hcd.h"
#endif

// Assertions.
#ifdef USE_FULL_ASSERT
#  ifndef assert_param
#    define assert_param(expr) ((expr) ? (void)0 : assert_failed((uint8_t *)__FILE__, __LINE__))
#  endif
#else
#  ifndef assert_param
#    define assert_param(expr) ((void)0)
#  endif
#endif

#endif /* STM32F7XX_HAL_CONF_H_ */
