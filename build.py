#!/usr/bin/env python3

import os
import sys
import shutil
import subprocess
import datetime
from argparse import ArgumentParser
from watchfiles import Change, DefaultFilter, watch

c = subprocess.call

EMULATOR = "mesen-s"

ORIGINAL = "smw.sfc"
OUT_DIR = "patched"

OUT_FILE = "smw_segment.sfc"

OUT_PATH = os.path.join(OUT_DIR, OUT_FILE)

ACTIONS = {
    1: "ADDED",
    2: "MODIFIED",
    3: "DELETED",
}


class extensionFilter(DefaultFilter):
    allowed_extensions = ".asm", ".bin"

    def __call__(self, change: Change, path: str) -> bool:
        return super().__call__(change, path) and path.endswith(self.allowed_extensions)


def create_directory():
    if os.path.exists(OUT_DIR):
        shutil.rmtree(OUT_DIR)
    os.mkdir(OUT_DIR)


def copy_original_rom():
    shutil.copy(ORIGINAL, OUT_PATH)


def assemble():
    c(f"asar src/main.asm {OUT_PATH}".split())
    print(f"Assembling finished. File: {OUT_PATH}")


def debug():
    for changes in watch("src", watch_filter=extensionFilter()):
        for action, path in changes:
            time = datetime.datetime.now().strftime("%H:%M:%S")
            if action == 3:
                continue
            action_text = f"{time} | {ACTIONS.get(action)}:"
            print(action_text, path)
            create_directory()
            copy_original_rom()
            assemble()
            subprocess.Popen(f"mesen2 {OUT_PATH}".split())


def main():
    create_directory()
    copy_original_rom()
    assemble()


parser = ArgumentParser()
parser.add_argument(
    "-d",
    "--debug",
    action="store_true",
    help="option for debugging or development purpose.",
)
args = parser.parse_args()

if args.debug == True:
    debug()
else:
    main()
sys.exit()
