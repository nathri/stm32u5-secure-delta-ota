#!/usr/bin/env python3
"""Diff/sign/manifest CLI — TODO, Phase 5 (see PROJECT_BRIEF.md).

Will eventually: compute a delta patch between two firmware images
(evaluate `detools`), sign it, and emit a manifest consumed by the
bootloader/host-side updater. Not implemented yet.
"""

import argparse


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("old_image", help="Path to the currently-running firmware image")
    parser.add_argument("new_image", help="Path to the new firmware image")
    parser.add_argument("-o", "--output", default="patch.bin", help="Output delta patch path")
    parser.parse_args()

    raise NotImplementedError("Phase 5 - delta/sign/manifest tooling not implemented yet")


if __name__ == "__main__":
    main()
