INCLUDE "constants.asm"

SECTION "Copy functions", ROM0[$0D2A]

FarCopyData::
; copy bc bytes from a:hl to de
    ld [wBuffer], a
    ldh a, [hROMBank]
    push af
    ld a, [wBuffer]
    call Bankswitch

    call CopyBytes

    pop af
    call Bankswitch
    ret


FarCopyBytesDouble:
; Copy bc bytes from a:hl to bc*2 bytes at de,
; doubling each byte in the process.

    ld [wBuffer], a
    ldh a, [hROMBank]
    push af
    ld a, [wBuffer]
    call Bankswitch

; switcheroo, de <> hl
    ld a, h
    ld h, d
    ld d, a
    ld a, l
    ld l, e
    ld e, a
    ld a, b
    and a
    jr z, .inc

    ld a, c
    and a
    jr z, .loop

.inc
    inc b

.loop
    ld a, [de]
    inc de
    ld [hli], a
    ld [hli], a
    dec c
    jr nz, .loop

    dec b
    jr nz, .loop

    pop af
    call Bankswitch
    ret


Request2bpp::
    ldh a, [hBGMapMode]
    push af
    xor a
    ldh [hBGMapMode], a

    ldh a, [hROMBank]
    push af
    ld a, b
    call Bankswitch

    ld a, e
    ld [wRequested2bppSource], a
    ld a, d
    ld [wRequested2bppSource + 1], a
    ld a, l
    ld [wRequested2bppDest], a
    ld a, h
    ld [wRequested2bppDest + 1], a

.loop
    ; Keep looping bigcopy until we have less than 8 bytes left
    ld a, c
    cp 8
    jr nc, .bigcopy

    ld [wRequested2bpp], a
    call DelayFrame

    pop af
    call Bankswitch
    pop af
    ldh [hBGMapMode], a
    ret

.bigcopy
    ; Copy 8 bytes
    ld a, 8
    ld [wRequested2bpp], a
    call DelayFrame

    ld a, c
    sub 8
    ld c, a
    jr .loop


SECTION "Second copy functions", ROM0[$32F7]

FarCopyBytes:: ; 32f7
    ld [wBuffer], a
    ldh a, [hROMBank]
    push af
    ld a, [wBuffer]
    call Bankswitch
    call CopyBytes
    pop af
    jp Bankswitch

CopyBytes:: ; 330a
    ld a, b
    and a
    jr z, CopyBytesSmall
    ld a, c
    and a
    jr z, .next
    inc b
.next
    call CopyBytesSmall
    dec b
    jr nz, .next
    ret

CopyBytesSmall:: ; 331a
    ld a, [hli]
    ld [de], a
    inc de
    dec c
    jr nz, CopyBytesSmall
    ret


GetFarByte:: ; 3321
    ld [wBuffer], a
    ldh a, [hROMBank]
    push af
    ld a, [wBuffer]
    call Bankswitch
    ld a, [hl]
    ld [wBuffer], a
    pop af
    call Bankswitch
    ld a, [wBuffer]
    ret


ByteFill:: ; 3339
    push af
    ld a, b
    and a
    jr z, .small_fill
    ld a, c
    and a
    jr z, .start_filling
.small_fill
    inc b
.start_filling
    pop af
.loop
    ld [hli], a
    dec c
    jr nz, .loop
    dec b
    jr nz, .loop
    ret
