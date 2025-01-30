; internal ROM name
org $00FFC0
    db "SMW SEGMENT     "

incsrc "macros.asm"
incsrc "defines.asm"
incsrc "hijacks.asm"
incsrc "edits.asm"
incsrc "fix.asm" ; $108000
incsrc "overworld.asm" ; $118000

org $1FFFFF
    db $EA
