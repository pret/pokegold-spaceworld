INCLUDE "constants.asm"

if DEBUG
SECTION "Copy functions", ROM0[$32F7]
else
SECTION "Copy functions", ROM0[$32BB]
endc

; Copy bc bytes from a:hl to de.
FarCopyBytes:: ; 32f7
    ld [wBuffer], a
    ldh a, [hROMBank]
    push af
    ld a, [wBuffer]
    call Bankswitch
    call CopyBytes
    pop af
    jp Bankswitch

; Copy bc bytes from hl to de
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

; Copy c bytes from hl to de
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
