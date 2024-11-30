; internal ROM name
org $00FFC0
    db "SMW SEGMENT     "

incsrc "defines.asm"
incsrc "hijacks.asm"
incsrc "overworld.asm" ; $108000

org $1FFFFF
    db $EA
