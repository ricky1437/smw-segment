include

org $108000
fix_uninitialized:
        lda #$A4
        sta $019D
        rtl