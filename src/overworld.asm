include

org $108000
gamemode_0e_hijack:
        jsl $048241
        ; jsr test_gm0e
        jsr test_warp
        rtl

test_gm0e:
        inc !test_gm0e
        rts

test_warp:
        lda !util_byetudlr_hold
        and #%00110000
        cmp #%00110000
        beq update_player_position
        rts

update_player_position:
        ldx !warp_index
        lda.l overworld_submap_table,x
        sta !submap_id
        sta $1f11
        rep #$20
        txa
        asl
        tax
        lda.l overworld_pos_x_table,x
        and #$01FF
        sta !overworld_pos_x
        lsr #4
        sta $1F1F
        lda.l overworld_pos_y_table,x
        and #$01FF
        sta !overworld_pos_y
        lsr #4
        sta $1F21
        sep #$20
        stz $0DD5
        lda #$0B
        sta $0100
        rts 

incsrc "data/overworld_table.asm"

print "[src/overworld.asm]: ", pc, "/109000 inserted"
