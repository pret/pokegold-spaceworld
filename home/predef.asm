SECTION "Predef", ROM0[$2FDE]

Predef:: ; 2fde
    ld [wPredefID], a
    ldh a, [hROMBank]
    push af
    ld a, BANK(GetPredefPointer)
    call Bankswitch
    call GetPredefPointer
    call Bankswitch
    ld hl, .return
    push hl
    push de
    jr .save_regs

.return
    ld a, h
    ld [wPredefHL], a
    ld a, l
    ld [wPredefHL + 1], a
    pop hl
    ld a, h ; Could have used `pop af` instead
    call Bankswitch
    ld a, [wPredefHL]
    ld h, a
    ld a, [wPredefHL + 1]
    ld l, a
    ret

.save_regs
    ld a, h
    ld [wPredefHL], a
    ld a, l
    ld [wPredefHL + 1], a
    ld a, d
    ld [wPredefDE], a
    ld a, e
    ld [wPredefDE + 1], a
    ld a, b
    ld [wPredefBC], a
    ld a, c
    ld [wPredefBC + 1], a
    ret
