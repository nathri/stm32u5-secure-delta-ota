# Secure Delta OTA for STM32U5

A secure, bandwidth-efficient firmware update system for resource-constrained
STM32U5 microcontrollers, built around delta patches, hardware-rooted trust,
and automatic rollback on failure.

## Overview

Most reference OTA implementations for microcontrollers assume a full
duplicate firmware slot and enough bandwidth to transfer complete images on
every update. This project addresses the common case where neither is
available: single-bank flash budgets and low-bandwidth or metered links.

Firmware updates are distributed as signed binary deltas rather than full
images, verified through a hardware-rooted chain of trust (STM32U5 PKA and
an OTP-provisioned public key), and applied through a power-loss-safe
staging process with automatic rollback if a new image fails a post-boot
health check.

## Key features

- Delta-based updates for smaller transfers and smaller flash footprint
- Hardware-accelerated signature verification (STM32U5 PKA, ECDSA P-256)
- TrustZone/GTZC secure-world isolation for verification and flash writes
- Power-loss-safe staging with atomic state transitions
- Automatic rollback on failed trial boot

## Status

Actively in development. Phase 1 (secure boot chain) is in progress. See
docs/ARCHITECTURE.md for full technical design and project status.

## Target hardware

STM32U5 series (Cortex-M33, TrustZone), developed and tested on a
Nucleo-U575ZI-Q board.

## Building

See firmware/bootloader/README.md for build instructions.

## License

All rights reserved. Source is provided for demonstration purposes; contact
the author regarding reuse or licensing.
