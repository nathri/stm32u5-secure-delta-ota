# Project Brief — Secure Delta OTA on STM32U5

## Context
Personal portfolio project, built evenings/weekends. Independent, clean-room
design — not tied to any client or third-party pitch.

## What's decided
- Problem: secure, power-loss-safe, bandwidth-efficient OTA for
  flash/bandwidth-constrained MCUs, via delta patches instead of full A/B images
- Board: STM32U5 — low power priority, reuses existing EEPROM emulation project
- Security: GTZC-based secure/non-secure isolation, boot-ROM-rooted chain of
  trust, RDP
- Update flow: delta patch → staged write → state-tracked → trial boot →
  health check → confirm or auto-rollback
- v1 transport: UART, PC running a Python script as the "server" (no second
  board required)

## Phased roadmap
- Phase 1 — Secure boot + signed image verification
- Phase 2 — Adapt existing EEPROM emulation project into the update-state
  store (pending / applied / confirmed / rollback flags, redundant +
  sequence-numbered)
- Phase 3 — Delta patch engine (evaluate detools) applied to full firmware image
- Phase 4 — Trial boot + health check + rollback controller
- Phase 5 — Host-side tooling: diff/sign/manifest CLI script (Python)
- Phase 6 (stretch) — swap UART for a wireless bridge

## Immediate next steps
- [ ] Confirm exact U5 board/dev kit in hand
- [ ] Pull existing EEPROM emulation project in as the state-store starting point
- [ ] Scaffold repo (structure below)
- [ ] Implement Phase 1 first — nothing else matters until secure boot works

## Suggested repo structure
```
ota-project/
  firmware/
    bootloader/
    app/
    state_store/       <- adapt from existing EEPROM emulation project
    crypto/
  host_tools/
    diff_and_sign.py
    manifest_schema.json
  docs/
    ARCHITECTURE.md
  README.md
```
