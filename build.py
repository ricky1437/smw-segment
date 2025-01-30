#!/usr/bin/env python3

import os
import sys
import shutil
import subprocess
import datetime
from argparse import ArgumentParser
from termcolor import cprint
from watchfiles import Change, DefaultFilter, watch

c = subprocess.call

time = datetime.datetime.now().strftime("%H:%M:%S")

EMULATOR = "mesen-s"

ORIGINAL = "smw.sfc"
OUT_DIR = "patched"

OUT_FILE = "smw_segment.sfc"

OUT_PATH = os.path.join(OUT_DIR, OUT_FILE)

WATCH_ACTION_TYPE = {
    1: "Added",
    2: "Modified",
    3: "Deleted",
}


class extFilter(DefaultFilter):
    allowed_extensions = ".asm", ".bin"

    def __call__(self, change: Change, path: str) -> bool:
        return super().__call__(change, path) and path.endswith(self.allowed_extensions)


def print_action(action, path):
    time = datetime.datetime.now().strftime("%H:%M:%S")
    if action == "Added":
        color = "green"
    elif action == "Modified":
        color = "yellow"
    elif action == "Deleted":
        color = "red"
    else:
        color = "white"

    print(f"[{time}]", end=" ")
    cprint(f"{action.upper()}", color, attrs=["bold"], end="")
    print(f": {path}")


def assemble(isDebug: bool):
    time = datetime.datetime.now().strftime("%H:%M:%S")
    if os.path.exists(OUT_DIR):
        shutil.rmtree(OUT_DIR)
    os.mkdir(OUT_DIR)

    if isDebug:
        build_date: str = datetime.datetime.now().strftime("%y-%m-%d_%H-%M-%S")
        dest: str = f"ss_{build_date}.sfc"
        global dbg_out_path
        dbg_out_path = os.path.join(OUT_DIR, dest)
        OUT_PATH = dbg_out_path
    shutil.copy(ORIGINAL, OUT_PATH)
    print("Assembling...")
    c(f"asar src/main.asm {OUT_PATH}".split())
    print(f'[{time}]: Assembling finished. File: "{dbg_out_path}"')


def watch_event():
    for changes in watch("src", watch_filter=extFilter()):
        for action, path in changes:
            action_str = WATCH_ACTION_TYPE.get(action)
            print_action(action_str, path)
            assemble(isDebug)
            # Mesen-Sの場合、ホットリロード的な動作をする
            if EMULATOR == "mesen-s":
                c(f"{EMULATOR} {dbg_out_path}".split())


def debug():
    emu_process = subprocess.Popen(
        (f"{EMULATOR} {OUT_PATH}".split()),
    )
    pid = emu_process.pid
    print(f"[{time}]: Emulation process started with PID: {pid}")
    print("Watching file changes...")
    watch_event()


def main():
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
    isDebug = True
    debug()
else:
    main()
sys.exit()
