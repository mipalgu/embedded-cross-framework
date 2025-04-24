/* Linker script for Pico2 (RP2350) board. Adjust as needed for your board's memory layout. */
MEMORY
{
  FLASH (rx) : ORIGIN = 0x10000000, LENGTH = 2M
  RAM (rwx) : ORIGIN = 0x20000000, LENGTH = 256K
}
