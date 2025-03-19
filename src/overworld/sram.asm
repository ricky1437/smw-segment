include

save_to_sram:
        lda !util_axlr_hold
        cmp #%00110000
        bne .done

	lda #$01
	sta !isSramUsed

        lda !player_powerups_buffer
        sta !sram_powerups
        lda !player_item_box_buffer
        sta !sram_item_box
        lda !player_yoshi_color_buffer
        sta !sram_yoshi_color
        lda !warp_index
        sta !sram_warp_index

        ; セーブ時SFX
        lda #$29
        sta $1dfc
    .done:
        rts

print pc
load_sram:
	lda !isSramUsed
	cmp #$01
	bne .done

        lda !util_axlr_hold
        cmp #%00110000
        bne .done

        lda !sram_powerups
        sta !player_powerups : sta !player_powerups_buffer
        lda !sram_item_box
        sta !player_item_box : sta !player_item_box_buffer
        lda !sram_yoshi_color
        sta !player_yoshi_color : sta !player_yoshi_color_buffer
        lda !sram_warp_index
        sta !warp_index

        lda #$0C
        sta $1DF9
        ; 更新
        jsr do_warp
    .done:
        rts
