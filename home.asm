INCLUDE "constants.asm"


INCLUDE "home/rst.asm"
INCLUDE "home/interrupts.asm"
INCLUDE "home/init.asm"
INCLUDE "home/vblank.asm"
INCLUDE "home/lcd.asm"
INCLUDE "home/serial.asm"

SECTION "Empty function", ROM0[$2F97]

InexplicablyEmptyFunction:: ; 2f97
REPT 16
    nop
ENDR
    ret

INCLUDE "home/farcall.asm"
INCLUDE "home/predef.asm"
INCLUDE "home/sram.asm"
INCLUDE "home/bankswitch.asm"
INCLUDE "home/clear_sprites.asm"
INCLUDE "home/copy.asm"
INCLUDE "home/copy_tilemap.asm"
INCLUDE "home/audio.asm"
INCLUDE "home/oam_dma.asm"


; TODO:
; 1. Figure out what these are. Might be related to RTC, like ClearRTCStatus and the ilk.
; 2. Give them proper names.
; 3. Move them to their own file(s).

SECTION "Unknown functions", ROM0[$1FF4]

_1FF4:: ; 1ff4
    ld a, BANK(s0_a600)
    call OpenSRAM
    ld hl, s0_a600 ; TODO: label this.
    ld bc, 7
    xor a
    call ByteFill
    call CloseSRAM
    ret

_2007:: ; 2007
    ld a, BANK(s0_a600)
    call OpenSRAM
    ld a, [s0_a600]
    and 8
    ld [wce5f], a
    call CloseSRAM
    ret
