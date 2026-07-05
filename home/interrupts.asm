SECTION "VBlank interrupt vector", ROM0[$0040]
	jp VBlank

SECTION "LCD interrupt vector", ROM0[$0048]
	jp LCD

SECTION "Timer interrupt vector", ROM0[$0050]
	jp TimerDummy

SECTION "Serial interrupt vector", ROM0[$0058]
	jp Serial

SECTION "Joypad interrupt vector", ROM0[$0060]
	jp JoypadDummy
