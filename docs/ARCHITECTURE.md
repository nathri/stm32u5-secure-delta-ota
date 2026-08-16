# Secure Delta OTA — STM32U5

## Problem
Most reference OTA implementations assume a full second flash slot (A/B) and
cheap bandwidth to resend a whole image every update. This project targets
the opposite case: a single-bank-friendly, low-power MCU on a slow/simple
link, updated via signed delta patches instead of full images, with
power-loss-safe staging and automatic rollback.

## Goals
- Hardware-rooted trust: boot ROM + RDP + OTP public key, not software-only checks
- Power-loss resilience: no update state is undefined after a cut at any point
- Bandwidth/flash efficiency: delta patches, not full-image duplication
- Automatic rollback if the new image fails a post-boot health check

## Non-goals (v1)
- Multi-device fleet management
- Key rotation / revocation
- Wireless transport (UART only for v1 — PC is the "server", no second board)

## Target hardware
- Board: STM32U5 (Nucleo-U575ZI-Q class), Cortex-M33 w/ TrustZone
- Rationale: ultra-low-power line fits the intended use case; reuses your
  existing EEPROM-emulation codebase for the state store; TrustZone via GTZC
  gives secure/non-secure isolation

## Corrections locked in from earlier discussion
- U5 has NO hardware EDATA — state store uses **software EEPROM emulation**
  (AN4894-style), built on your existing EEPROM emulation project
- TrustZone isolation on U5 is via **GTZC** (Global TrustZone Controller),
  not RIF — RIF is STM32N6/MP2 only

## Key design decisions (locked)
| Decision | Choice | Rationale |
| --- | --- | --- |
| Board | STM32U5 | low power, reuse of existing EEPROM emulation work |
| State store | Software EEPROM emulation | U5 has no hardware EDATA |
| TrustZone mechanism | GTZC | correct for U5 (not RIF) |
| Transport (v1) | UART | simplest end-to-end proof, no second board |
| Delta algorithm | TBD — evaluate detools | lightweight, embedded-oriented, streamable |
| Key management (v1) | Static public key in OTP/option bytes | no rotation needed for portfolio scope |

## Open questions
- Exact manifest schema (fields, JSON vs CBOR)
- Health-check criteria for confirming trial boot
- Staging partition size/location in the U5 flash map
