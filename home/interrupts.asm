INCLUDE "constants.asm"

SECTION "home/interrupts.asm@VBlank interrupt vector", ROM0
	jp VBlank

SECTION "home/interrupts.asm@LCD interrupt vector", ROM0
	jp LCD

SECTION "home/interrupts.asm@Timer interrupt vector", ROM0
	jp TimerDummy

SECTION "home/interrupts.asm@Serial interrupt vector", ROM0
	jp Serial

SECTION "home/interrupts.asm@Joypad interrupt vector", ROM0
	jp JoypadDummy


SECTION "home/interrupts.asm@Timer dummy interrupt", ROM0

TimerDummy: ; 042a
	reti


SECTION "home/interrupts.asm@Joypad dummy interrupt", ROM0

JoypadDummy: ; 07f7
	reti