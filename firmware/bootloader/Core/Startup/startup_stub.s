/* Minimal placeholder startup file for the Phase 1 bootloader stub.
 *
 * Only defines the reset/SP vectors plus a couple of core fault
 * handlers — NOT the full STM32U5 vector table (140+ entries). Replace
 * with the STM32CubeMX-generated startup_stm32u575xx.s once the project
 * is regenerated in CubeIDE.
 */
    .syntax unified
    .cpu cortex-m33
    .thumb

    .global Reset_Handler
    .global g_pfnVectors

    .section .isr_vector, "a", %progbits
g_pfnVectors:
    .word _estack
    .word Reset_Handler
    .word NMI_Handler
    .word HardFault_Handler
    /* TODO: remaining STM32U5 vector table entries */

    .section .text.Reset_Handler
    .weak Reset_Handler
    .type Reset_Handler, %function
Reset_Handler:
    ldr r0, =_sidata
    ldr r1, =_sdata
    ldr r2, =_edata
copy_data:
    cmp r1, r2
    bge copy_data_done
    ldr r3, [r0], #4
    str r3, [r1], #4
    b copy_data
copy_data_done:

    ldr r1, =_sbss
    ldr r2, =_ebss
    movs r3, #0
zero_bss:
    cmp r1, r2
    bge zero_bss_done
    str r3, [r1], #4
    adds r1, r1, #4
    b zero_bss
zero_bss_done:

    bl main
    b .
    .size Reset_Handler, .-Reset_Handler

    .section .text.Default_Handler, "ax", %progbits
Default_Handler:
    b .
    .size Default_Handler, .-Default_Handler

    .weak NMI_Handler
    .thumb_set NMI_Handler, Default_Handler
    .weak HardFault_Handler
    .thumb_set HardFault_Handler, Default_Handler
