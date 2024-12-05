include

org $108000
gamemode_0e_hijack:
        jsl $048241
        jsr display_warp_index
        jsr restore_graphics
        jsr test_warp
        rtl

test_warp:
        lda #$00
        sta $13d4

        lda !util_byetudlr_hold
        and #%00110000
        cmp #%00110000
        beq do_warp
        lda !util_byetudlr_hold
        and #%00010000
        cmp #%00010000
        beq control_warp
        rts

control_warp:
        lda !util_byetudlr_frame
        and #%00001100
        cmp #%00001000
        beq .up
        cmp #%00000100
        beq .down
        rts

    .up:
        lda !warp_index
        inc
        cmp #$0A
        beq .reset
        bra .store

    .down:
        lda !warp_index
        dec
        cmp #$FF
        bne .store
        lda #$09
        bra .store

    .reset:
        stz !warp_index
        rts

    .store:
        sta !warp_index
        rts
        
do_warp:
    jsr update_player_position
    jsr update_player_score
    rts

update_player_position:
        ldx !warp_index
        lda.l overworld_submap_table,x
        sta !overworld_submap
        rep #$20
        txa
        asl
        tax
        lda.l overworld_pos_x_table,x
        and #$01FF
        sta !overworld_pos_x
        lsr #4
        sta !overworld_pos_pointer_x
        lda.l overworld_pos_y_table,x
        and #$01FF
        sta !overworld_pos_y
        lsr #4
        sta !overworld_pos_pointer_y
        sep #$20
        stz $0DD5
        lda #$0B
        sta $0100
        rts 

update_player_score:
        rts

display_warp_index:
        phb
        phk
        plb
        lda !util_byetudlr_hold
        and #%00010000
        cmp #%00010000
        beq .display_warp
        plb
        rts

    .display_warp:
        lda #$01
        sta !menu_flag
        jsr test_stripe
        plb
        rts

test_stripe:
        rep #$20
        ldx #$06
      - lda tbl_test_stripe,x
        sta $7f837d,x
        dex
        bpl -
        clc
        lda $7f837d+4
        adc !warp_index
        sta $7f837d+4
        lda #$06
        sta $7f837b
        sep #$20
        rts

restore_graphics:
        phb
        phk
        plb 
        lda !menu_flag
        cmp #$01
        bne +
        lda !util_byetudlr_hold
        and #%00010000
        cmp #%00000000
        bne +
        jsr test_recover_stripe
      + plb
        rts

test_recover_stripe:
        rep #$20
        ldx #$06
      - lda tbl_test_recover_stripe,x
        sta $7f837d,x
        dex
        bpl -
        clc
        lda #$06
        sta $7f837b
        sep #$20
        stz !menu_flag
        rts

tbl_test_stripe:
    db $50,$00,$00,$01,$22,$39,$FF

tbl_test_recover_stripe:
    db $50,$00,$00,$01,$FE,$38,$FF

incsrc "data/overworld_table.asm"

print "[src/overworld.asm]: ", pc, "/109000 inserted"
