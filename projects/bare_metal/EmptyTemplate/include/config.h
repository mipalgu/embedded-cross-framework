//
// Project configuration
//
#ifndef CONFIG_H_

// Enable the following HAL modules.
#define HAL_GPIO_MODULE_ENABLED

#include "hal.h"

// Definitions used in the project.
#ifdef GPIO_PIN_0
#define LED1_PIN    GPIO_PIN_0
#define LED2_PIN    GPIO_PIN_7
#define LED3_PIN    GPIO_PIN_14
#else
#define LED1_PIN    0x0020
#define LED2_PIN    0x0080
#define LED3_PIN    0x4000
#endif
#ifdef GPIOB
#define LED1_GPIO   GPIOB
#define LED2_GPIO   GPIOB
#define LED2_GPIO   GPIOB
#endif

#endif // CONFIG_H_