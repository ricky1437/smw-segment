#!/usr/bin/env python3

import os
import sys
import shutil
from subprocess import call

c = call

original = "smw.sfc"
out_dir = "patched"
out_file = "smw_segment.sfc"


def main():
    if os.path.exists(out_dir):
        shutil.rmtree(out_dir)
        print("Cleaning output directory.")
    os.mkdir(out_dir)
    shutil.copy(original, out_dir + "/" + out_file)
    c("asar src/main.asm patched/smw_segment.sfc".split())
    print("Assembling finished.")


main()
sys.exit()
