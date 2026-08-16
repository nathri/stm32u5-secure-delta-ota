# Bootloader

Phase 1 stub: reads a public key from a placeholder OTP/option-byte
location, checks a placeholder signature, and either jumps to the app or
halts. Fails closed — see `Core/Src/main.c`.

## Building

Bare CMake project, no CMSIS/HAL dependency (bootloaders should stay
minimal). Links against the placeholder linker script + startup file in
this directory.

```
cmake -S firmware -B build -DCMAKE_TOOLCHAIN_FILE=firmware/cmake/gcc-arm-none-eabi.cmake
cmake --build build
```

Requires `arm-none-eabi-gcc` on PATH.

## Known placeholders (see TODOs in source)

- OTP/option-byte address for the public key — not yet confirmed against RM0456
- Signature verification — stub, pending signing-library choice
- Vector table in `Core/Startup/startup_stub.s` — minimal (SP/Reset/NMI/HardFault
  only), not the full STM32U5 table. Replace with the STM32CubeMX-generated
  `startup_stm32u575xx.s` when the project is regenerated in CubeIDE.
- Flash/RAM sizes in the linker script — typical for STM32U575xI, unconfirmed
- App start address / partition layout — placeholder, pending Phase 2-4 design
