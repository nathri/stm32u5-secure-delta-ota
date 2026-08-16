# State store

The update-state store (pending / applied / confirmed / rollback flags,
redundant + sequence-numbered) will be built on top of the
[eeprom-emulation](eeprom-emulation) submodule
(https://github.com/nathri/stm32-eeprom-emulation) — a record-based,
log-structured EEPROM emulation library with wear-leveling, garbage
collection, and CRC-protected, power-loss-safe records.

## Open item: STM32U5 Flash/ECC behavior unverified

The library's own docs (see its `IMPLEMENTATION_NOTES.md`, "Flagged, not
fixed here") flag that it has **not been run on real hardware** — testing
so far is a host-simulated Flash model plus static analysis. Specifically:
several STM32 Flash families with ECC-protected Flash, including U5, are
not confirmed to reliably support a second partial program to an
already-programmed word (clearing additional bits only) — which is exactly
the write pattern the library's invalidate/state-transition records rely
on. F1/F4 (non-ECC) parts are fine; U5 is not yet confirmed either way, and
the host mock's simple AND-semantics model can't catch an ECC-related
failure because it doesn't model ECC at all.

This must be verified against real STM32U5 Flash/ECC behavior before this
component is trusted for the rollback-safety design — an unconfirmed
partial-program assumption here would undermine the exact power-loss
resilience guarantee (see ARCHITECTURE.md, "Design goals") that the state
store exists to provide.
