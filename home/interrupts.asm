INCLUDE "constants.asm"

SECTION "VBlank interrupt vector", ROM0[$040]
    jp VBlank

SECTION "LCD interrupt vector", ROM0[$048]
    jp LCD

SECTION "Timer interrupt vector", ROM0[$050]
    jp TimerDummy

SECTION "Serial interrupt vector", ROM0[$058]
    jp Serial

SECTION "Joypad interrupt vector", ROM0[$060]
    jp JoypadDummy


SECTION "Timer dummy interrupt", ROM0[$42A]

TimerDummy: ; 042a
    reti


SECTION "Joypad dummy interrupt", ROM0[$7F7]

JoypadDummy: ; 07f7
    reti
