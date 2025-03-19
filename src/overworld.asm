include

org $118000
gamemode_0e_hijack:
        jsl $048241
        jsl fix_uninitialized
        jsr display_warp_index
        jsr restore_graphics
        jsr test_warp
        jsr test_player_status
        jsr load_sram 
        rtl

incsrc "overworld/warp.asm"
incsrc "overworld/player_status.asm"
incsrc "overworld/sram.asm"

print "[src/overworld.asm]: ", pc, "/119000 bytes inserted."
