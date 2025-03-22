# SMW Segment

SMW Segment is a mod for the segment practice of Super Mario World speedrunning.

## Supported Version

There are no plans to support anything other than the Japanese version, as it is the fastest for speedrunning.

## Building

You need [Asar v1.91](https://github.com/RPGHacker/asar) by RPGHacker for assembling.

Run `asar src/main.asm YOUR_ROM_FILE.sfc` to generate the patched ROM.

## Debugging

There is a Python script to make debugging easier.

You need:
- Python 3
- watchfiles
- Mesen-2

Install them and run `python build.py -d`.

ROM will be patched and Mesen will automatically reload the ROM if any file changes are detected.
