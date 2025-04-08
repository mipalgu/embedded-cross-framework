#ifndef STM32H7XX_HAL_GPIO_EX_COMPAT_H_
#define STM32H7XX_HAL_GPIO_EX_COMPAT_H_

#ifdef __cplusplus
extern "C" {
#endif

/* Compatibility definitions for GPIO alternate functions */
#ifndef GPIO_AF11_ETH
#define GPIO_AF11_ETH           ((uint8_t)0x0B)  /* ETH Alternate Function mapping     */
#endif
#ifndef GPIO_AF10_OTG_FS
#define GPIO_AF10_OTG_FS        ((uint8_t)0x0A)  /* OTG_FS Alternate Function mapping  */
#endif
#ifndef RCC_PLLP_DIV2
#define RCC_PLLP_DIV2           ((uint32_t)0x00000002)  /* PLLP Divider for 2nd stage post-division */
#endif

#ifdef __cplusplus
}
#endif

#endif /* STM32H7XX_HAL_GPIO_EX_COMPAT_H_ */ 