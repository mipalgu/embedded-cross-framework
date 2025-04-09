/* Linker script for RP2350 RISC-V core
 * Memory layout:
 * Flash: 0x10000000 - 0x10200000 (2048K)
 * RAM:   0x20000000 - 0x20042000 (264K)
 */

MEMORY
{
    FLASH (rx)  : ORIGIN = 0x10000000, LENGTH = 2048K
    RAM   (rwx) : ORIGIN = 0x20000000, LENGTH = 264K
}

/* Entry Point */
ENTRY(Reset_Handler)

/* Sections */
SECTIONS
{
    .text :
    {
        KEEP(*(.vectors))
        *(.text*)
        *(.rodata*)
        . = ALIGN(4);
        _etext = .;
    } > FLASH

    .data :
    {
        _sdata = .;
        *(.data*)
        . = ALIGN(4);
        _edata = .;
    } > RAM AT > FLASH

    .bss :
    {
        _sbss = .;
        *(.bss*)
        *(COMMON)
        . = ALIGN(4);
        _ebss = .;
    } > RAM

    /* Stack and heap configuration */
    .stack (NOLOAD) :
    {
        . = ALIGN(8);
        _sstack = .;
        . = . + 0x2000; /* 8K stack */
        . = ALIGN(8);
        _estack = .;
    } > RAM

    .heap (NOLOAD) :
    {
        . = ALIGN(8);
        _heap_start = .;
        . = . + 0x4000; /* 16K heap */
        . = ALIGN(8);
        _heap_end = .;
    } > RAM

    /* These are used for startup code */
    _sidata = LOADADDR(.data);
    
    /* Discard unused sections */
    /DISCARD/ :
    {
        *(.comment)
        *(.note*)
        *(.eh_frame*)
    }
}

/* Provide symbols for startup code */
PROVIDE(_stack_start = ORIGIN(RAM) + LENGTH(RAM));
PROVIDE(_stack_size = 8K);
PROVIDE(_heap_size = 16K); 