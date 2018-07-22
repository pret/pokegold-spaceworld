INCLUDE "constants.asm"

SECTION "audio/songs/heal.asm", ROMX

Song_Heal:: ; ed5f4 (3b:55f4)
	db 2 << 6 | 0
	dw Song_Heal_Ch0
	db 1
	dw Song_Heal_Ch1
	db 2
	dw Song_Heal_Ch2

Song_Heal_Ch0:: ; ed5fd (3b:55fd)
	tempo 144
	volume 7, 7
	duty 2
	toggleperfectpitch
	rest 1
	rest 2
	notetype 12, 8, 1
	rest 2
	pitchbend 0, 64
	B_ 2
	pitchbend 0, 85
	B_ 2
	pitchbend 0, 69
	E_ 2
	rest 4
	pitchbend 0, 48
	E_ 4
	pitchbend 0, 64
	B_ 4
	endchannel


Song_Heal_Ch1:: ; ed621 (3b:5621)
	duty 2
	notetype 12, 12, 3
	octave 4
	B_ 4
	B_ 4
	B_ 2
	G# 2
	notetype 12, 12, 4
	octave 5
	E_ 8
	endchannel


Song_Heal_Ch2:: ; ed631 (3b:5631)
	notetype 12, 1, 0
	octave 4
	E_ 2
	rest 2
	E_ 2
	rest 2
	E_ 2
	G# 2
	E_ 6
	rest 2
	endchannel
; 0xed63e