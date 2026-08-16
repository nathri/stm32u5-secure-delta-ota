/* Placeholder linker script for the Phase 1 bootloader stub.
 *
 * Flash/RAM sizes below are typical for STM32U575xI (2 MB flash /
 * ~768 KB SRAM) — TODO: confirm against RM0456 and your exact part
 * number. The 64 KB bootloader region and app start address are
 * placeholders pending the staging-partition layout decision (see
 * ARCHITECTURE.md "Open questions").
 */
MEMORY
{
  FLASH_BOOT (rx)  : ORIGIN = 0x08000000, LENGTH = 64K
  RAM        (rwx) : ORIGIN = 0x20000000, LENGTH = 768K
}

ENTRY(Reset_Handler)

SECTIONS
{
  .isr_vector :
  {
    KEEP(*(.isr_vector))
  } > FLASH_BOOT

  .text :
  {
    *(.text*)
    *(.rodata*)
  } > FLASH_BOOT

  _sidata = LOADADDR(.data);

  .data :
  {
    _sdata = .;
    *(.data*)
    _edata = .;
  } > RAM AT> FLASH_BOOT

  .bss :
  {
    _sbss = .;
    *(.bss*)
    *(COMMON)
    _ebss = .;
  } > RAM

  _estack = ORIGIN(RAM) + LENGTH(RAM);
}
