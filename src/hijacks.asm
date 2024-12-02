include

; overworld
org $00A165
    jsl gamemode_0e_hijack

org $05DC0A
    jsr display_warp_index
