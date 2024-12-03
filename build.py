#!/usr/bin/env python3

import os
import sys
import shutil
from argparse import ArgumentParser
from subprocess import call

c = call
parser = ArgumentParser()

original = "smw.sfc"
out_dir = "patched"
out_file = "smw_segment.sfc"


def debug():
    main()
    c("mesen-s patched/smw_segment.sfc")


def main():
    if os.path.exists(out_dir):
        print("Output data detected, cleaning output directory...")
        shutil.rmtree(out_dir)
    os.mkdir(out_dir)
    shutil.copy(original, out_dir + "/" + out_file)
    print("Assembling...")
    c("asar src/main.asm patched/smw_segment.sfc".split())
    print("Assembling finished.")


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
