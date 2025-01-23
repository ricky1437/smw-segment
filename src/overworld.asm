include

org $108000
gamemode_0e_hijack:
        jsl $048241
        jsr display_warp_index
        jsr restore_graphics
        jsr test_warp
        rtl

incsrc "overworld/warp.asm"
incsrc "overworld/powerups.asm"

print "[src/overworld.asm]: ", pc, "/109000 bytes inserted."
