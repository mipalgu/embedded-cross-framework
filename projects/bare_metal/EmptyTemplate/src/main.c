//
// Simple, bare-metal firmware project template
//
#include "config.h"

// Function prototypes.
static void init_hardware(void);
static void configure_system_clock(void);
static void init_gpio(void);
// static void init_uart(void);
// static void init_ethernet(void);
// static void init_can(void);
static void abort_operation(void);

/// Main function called from the startup code.
int main(void)
{
    // Initialise the hardware
    init_hardware();

    // Main loop
    while (1)
    {
        // Do something
#ifdef GPIOA
        // Toggle the LED 1 pin.
        HAL_GPIO_TogglePin(GPIOA, LED1_PIN);
        // Sleep for half a second.
        HAL_Delay(500);
#endif
    }
}

/// Initialise the hardware.
static void init_hardware(void)
{
    // Initialise the Hardware abstraction layer.
    HAL_Init();

    // Initialise the system clock.
    configure_system_clock();

    // Initialise the peripherals used.
    init_gpio();
    // init_uart();
    // init_ethernet();
    // init_can();
}

/// Configure the system clock.
static void configure_system_clock(void) {
#ifdef RCC_OSCILLATORTYPE_HSI
    // Enable the HSI oscillator.
    RCC_OscInitTypeDef RCC_OscInitStruct = {0};
    RCC_OscInitStruct.OscillatorType = RCC_OSCILLATORTYPE_HSI;
    RCC_OscInitStruct.HSIState = RCC_HSI_ON;
    RCC_OscInitStruct.HSICalibrationValue = RCC_HSICALIBRATION_DEFAULT;
    RCC_OscInitStruct.PLL.PLLState = RCC_PLL_ON;
    RCC_OscInitStruct.PLL.PLLSource = RCC_PLLSOURCE_HSI;
    RCC_OscInitStruct.PLL.PLLM = 13;
    RCC_OscInitStruct.PLL.PLLN = 195;
    RCC_OscInitStruct.PLL.PLLP = RCC_PLLP_DIV2;
    RCC_OscInitStruct.PLL.PLLQ = 5;
    if (HAL_RCC_OscConfig(&RCC_OscInitStruct) != HAL_OK)
    {
        // Initialisation Error
        abort_operation():
    }

    // Initialise the clocks for the CPU, AHB, and APB busses.
    RCC_ClkInitTypeDef RCC_ClkInitStruct = {0};
    RCC_ClkInitStruct.ClockType = RCC_CLOCKTYPE_HCLK | RCC_CLOCKTYPE_SYSCLK | RCC_CLOCKTYPE_PCLK1 | RCC_CLOCKTYPE_PCLK2;
    RCC_ClkInitStruct.SYSCLKSource = RCC_SYSCLKSOURCE_PLLCLK;
    RCC_ClkInitStruct.AHBCLKDivider = RCC_SYSCLK_DIV1;
    RCC_ClkInitStruct.APB1CLKDivider = RCC_HCLK_DIV4;
    RCC_ClkInitStruct.APB2CLKDivider = RCC_HCLK_DIV2;
    if (HAL_RCC_ClockConfig(&RCC_ClkInitStruct, FLASH_LATENCY_5) != HAL_OK)
    {
        // Initialisation Error
        abort_operation():
    }
#endif
}

/// Initialise the GPIO pins.
static void init_gpio(void)
{
#ifdef __HAL_RCC_GPIOA_CLK_ENABLE
    // Enable the GPIO peripheral clocks.
    __HAL_RCC_GPIOA_CLK_ENABLE();
    __HAL_RCC_GPIOB_CLK_ENABLE();
    __HAL_RCC_GPIOC_CLK_ENABLE();
    __HAL_RCC_GPIOD_CLK_ENABLE();
    __HAL_RCC_GPIOG_CLK_ENABLE();
    __HAL_RCC_GPIOH_CLK_ENABLE();
#endif
#ifdef GPIO_PIN_RESET
    // Configure the GPIO pins.
    GPIO_InitTypeDef GPIO_InitStruct = {0};
    // Configure LED pins as output.
    HAL_GPIO_WritePin(GPIOB, LED1_PIN | LED2_PIN | LED3_PIN, GPIO_PIN_RESET);
    GPIO_InitStruct.Pin = LED1_PIN | LED2_PIN | LED3_PIN;
    GPIO_InitStruct.Mode = GPIO_MODE_OUTPUT_PP;
    GPIO_InitStruct.Pull = GPIO_NOPULL;
    GPIO_InitStruct.Speed = GPIO_SPEED_FREQ_LOW;
    HAL_GPIO_Init(GPIOB, &GPIO_InitStruct);
#endif
}
/// Abort in case of a fatal error.
static void abort_operation(void)
{
#ifdef __CMSIS_GCC_H
    __disable_irq();
#endif
    // Wait forever.
    while (1)
    {
    }
}