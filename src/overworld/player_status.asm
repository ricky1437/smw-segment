include

test_player_status:
        jsr swap_powerups
        lda !util_byetudlr_hold
        and #%00010000
        beq +
        jsr cycle_powerup
        jsr cycle_yoshi
        jsr load_sram
      + rts

cycle_powerup:
        lda !util_axlr_frame
        and #%00010000
        beq .done
        lda !util_axlr_hold
        and #%00100000
        bne .done

        lda !player_powerups
        inc a
        cmp #$04
        bne +
        lda #$00
      + sta !player_powerups
        sta !player_powerups_buffer

    .done:
        rts

swap_powerups:
        lda !util_byetudlr_frame
        and #%00100000
        beq .done
        lda !util_byetudlr_hold
        and #%00010000
        bne .done

        lda !player_powerups_buffer
        cmp #$02 ; マント
        bne +
        asl a
      + cmp #$03 ; ファイア
        bne +
        dec a
      + sta $00
        lda !player_item_box_buffer
        cmp #$02 ; ファイア
        bne +
        inc a
      + cmp #$04
        bne +
        lsr a
      + sta !player_powerups
        sta !player_powerups_buffer
        lda $00
        sta !player_item_box
        sta !player_item_box_buffer

    .done:
        rts

cycle_yoshi:
        lda !util_axlr_frame
        and #%00100000
        beq .done
        lda !util_axlr_hold
        and #%00010000
        bne .done

        lda !player_yoshi_color_buffer
      - inc a : inc a
        cmp #$02
        beq - 
        cmp #$0C
        bne +
        lda #$00
      + sta !player_yoshi_color
        sta !player_yoshi_color_buffer
        lda #$01
        sta !player_yoshi_flag
        
    .done:
        rts
      