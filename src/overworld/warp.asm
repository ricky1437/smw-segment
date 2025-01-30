include

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
        jsr update_special_status
        jsr update_switch_palace
        ; jsl reload_overworld
        rts

update_player_position:
        ldx !warp_index
        lda.l overworld_submap_table,x
        sta !overworld_submap
        %a16()
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
        %a8()
        stz $0DD5
        lda #$0B
        sta $0100
        rts 

update_player_score:
        lda !warp_index
        sta $00
        asl a
        clc
        adc $00 ; X=3
        tax
        %a16()
        lda.l overworld_score_table,x ; only loads word bytes.
        sta $0F34
        %a8()
        inx #2 ; move data pointer to the high byte of score data.
        lda.l overworld_score_table,x
        sta $0F36 ; store in the high byte of score.
        rts

update_special_status:
        lda !warp_index
        tax
        lda.l special_table,x
        sta !is_special_beaten
        rts

update_switch_palace:
        ldy #$00
        lda !warp_index
        asl a : asl a
        tax
      - lda.l switch_palace_table,x
        sta !switch_palace,y
        inx
        iny
        cpy #$04
        bne -
        rts


incsrc "data/position_table.asm"
incsrc "data/score_table.asm"
incsrc "data/special_table.asm"
incsrc "data/switch_palace_table.asm"


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
        jsr test_upload_stripe
        plb
        rts

test_upload_stripe:
        %a16()
        ldx #$06
      - lda tbl_test_stripe,x
        sta $7F837D,x
        dex
        bpl -
        clc
        lda $7F837D+4
        adc !warp_index
        sta $7F837D+4
        lda #$06
        sta $7F837B
        %a8()
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
        %a16()
        ldx #$06
      - lda tbl_test_recover_stripe,x
        sta $7F837D,x
        dex
        bpl -
        clc
        lda #$06
        sta $7F837B
        %a8()
        stz !menu_flag
        rts

tbl_test_stripe:
        db $50,$00,$00,$01,$22,$39,$FF

tbl_test_recover_stripe:
        db $50,$00,$00,$01,$FE,$38,$FF