# Secure Delta OTA — STM32U5

Personal portfolio project. See [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md)
and [docs/PROJECT_BRIEF.md](docs/PROJECT_BRIEF.md) for design and roadmap.

## Status

Phase 1 in progress: a bootloader stub that reads a public key from a
placeholder OTP/option-byte location and checks a placeholder signature
before jumping to the app. It fails closed (halts) until real signature
verification is wired in. See [firmware/bootloader/README.md](firmware/bootloader/README.md).

## Structure

```
firmware/
  bootloader/   Phase 1 (in progress)
  app/          not started
  state_store/  Phase 2
  crypto/       Phase 1 / 5
host_tools/     Phase 5
docs/
```
