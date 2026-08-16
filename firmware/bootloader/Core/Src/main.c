#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>

/* ---------------------------------------------------------------------
 * Phase 1: minimal bootloader stub.
 *
 * Reads a public key from a fixed OTP/option-byte location and checks a
 * signature placeholder before jumping to the app. The actual crypto
 * verification is a TODO pending the signing-library decision (see
 * PROJECT_BRIEF.md, Phase 1 / Phase 5). Fails closed: if verification
 * doesn't pass, the bootloader halts rather than jumping to an
 * unverified image.
 * ------------------------------------------------------------------- */

/* TODO: confirm key length once the signing scheme is chosen
 * (e.g. Ed25519 public keys are 32 bytes). */
#define PUBKEY_LEN 32u

/* TODO: not yet verified against RM0456 (STM32U5 reference manual).
 * Placeholder location in the OTP/option-byte area. */
static const uint8_t *const OTP_PUBKEY_ADDR = (const uint8_t *)0x0BFA0000UL;

/* TODO: placeholder assuming a 64 KB bootloader region (see the linker
 * script). Finalize once the staging-partition layout is decided (see
 * ARCHITECTURE.md "Open questions"). */
#define APP_START_ADDR 0x08010000UL

typedef void (*app_entry_t)(void);

static void read_public_key(uint8_t *out, size_t len)
{
    const uint8_t *src = OTP_PUBKEY_ADDR;
    for (size_t i = 0; i < len; i++) {
        out[i] = src[i];
    }
}

/* TODO: replace with a real signature check once the signing library is
 * chosen. Stub always fails so the bootloader never jumps to an
 * unverified image in the meantime. */
static bool verify_app_signature(const uint8_t *pubkey, uint32_t app_addr)
{
    (void)pubkey;
    (void)app_addr;
    return false;
}

static void jump_to_app(uint32_t app_addr)
{
    uint32_t app_stack = *(volatile uint32_t *)app_addr;
    uint32_t app_reset = *(volatile uint32_t *)(app_addr + 4u);

    __asm volatile("msr msp, %0" : : "r"(app_stack));

    app_entry_t app_entry = (app_entry_t)app_reset;
    app_entry();
}

int main(void)
{
    uint8_t pubkey[PUBKEY_LEN];
    read_public_key(pubkey, sizeof(pubkey));

    if (verify_app_signature(pubkey, APP_START_ADDR)) {
        jump_to_app(APP_START_ADDR);
    }

    /* Verification failed (or not yet implemented): halt rather than
     * run an unverified image. Rollback/recovery handling is Phase 4. */
    for (;;) {
    }
}
