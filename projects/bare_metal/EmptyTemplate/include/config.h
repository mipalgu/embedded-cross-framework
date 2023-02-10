//
// Project configuration
//
#ifndef CONFIG_H_

#include "hal.h"

// Definitions used in the project.
#ifdef GPIO_PIN_0
#define LED1_PIN    GPIO_PIN_5
#define LED2_PIN    GPIO_PIN_7
#define LED3_PIN    GPIO_PIN_14
#else
#define LED1_PIN    0x0020
#define LED2_PIN    0x0080
#define LED3_PIN    0x4000
#endif

#endif // CONFIG_H_