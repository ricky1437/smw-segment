macro multiply_a(num)
    sta $4202
    lda #<num>
    sta $4203
    nop #4
endmacro

macro i8()
    sep #$10
endmacro

macro i16()
    rep #$10
endmacro

macro a8()
    sep #$20
endmacro

macro a16()
    rep #$20
endmacro

macro ai8()
    sep #$30
endmacro

macro ai16()
    rep #$30
endmacro

macro a8i16()
    sep #$20
    rep #$10
endmacro

macro a16i8()
    rep #$20
    sep #$10
endmacro