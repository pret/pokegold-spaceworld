INCLUDE "constants.asm"

SECTION "audio/songs/nidorinointro.asm", ROMX

Song_NidorinoIntro:: ; ec000 (3b:4000)
	db 3 << 6 | 0
	dw Song_NidorinoIntro_Ch0
	db 1
	dw Song_NidorinoIntro_Ch1
	db 2
	dw Song_NidorinoIntro_Ch2
	db 3
	dw Song_NidorinoIntro_Ch3

Song_NidorinoIntro_Ch0:: ; ec00c (3b:400c)
	tempo 102
	volume 7, 7
	duty 3
	vibrato 6, 3, 4
	toggleperfectpitch
	rest 1
	rest 2
	notetype 12, 11, 1
	rest 8
	octave 2
	A_ 2
	A_ 2
	notetype 12, 11, 4
	octave 3
	D_ 4
	notetype 12, 11, 1
	octave 2
	A_ 2
	A_ 2
	notetype 12, 11, 4
	octave 3
	D# 4
	notetype 12, 11, 1
	octave 2
	A_ 2
	A_ 2
	notetype 12, 11, 4
	octave 3
	D_ 4
	notetype 12, 11, 1
	octave 2
	A_ 2
	A_ 2
	notetype 12, 10, 0
	A# 4
	notetype 12, 11, 1
	A_ 2
	A_ 2
	notetype 12, 11, 4
	octave 3
	D_ 4
	notetype 12, 11, 1
	octave 2
	A_ 2
	A_ 2
	notetype 12, 2, 9
	octave 3
	G_ 4
	notetype 12, 11, 0
	A_ 8
	octave 2
	A_ 8
	notetype 12, 11, 7
	octave 3
	F_ 8
	notetype 12, 4, 15
	octave 2
	F_ 8
	notetype 12, 11, 1
	A_ 2
	A_ 2
	notetype 12, 11, 4
	octave 3
	D_ 4
	notetype 12, 11, 1
	octave 2
	A_ 2
	A_ 2
	notetype 12, 11, 4
	octave 3
	D# 4
	notetype 12, 11, 1
	octave 2
	A_ 2
	A_ 2
	notetype 12, 11, 4
	octave 3
	F_ 4
	notetype 12, 11, 1
	octave 2
	A_ 2
	A_ 2
	notetype 12, 11, 4
	octave 3
	G_ 4
	notetype 12, 11, 0
	F# 16
	notetype 12, 11, 1
	octave 4
	D_ 16
	endchannel


Song_NidorinoIntro_Ch1:: ; ec09f (3b:409f)
	duty 3
	vibrato 8, 2, 5
	notetype 12, 12, 2
	rest 8
	octave 3
	D_ 2
	D_ 2
	notetype 12, 12, 5
	A_ 4
	notetype 12, 12, 2
	D_ 2
	D_ 2
	notetype 12, 12, 5
	A# 4
	notetype 12, 12, 2
	D_ 2
	D_ 2
	notetype 12, 12, 5
	A_ 4
	notetype 12, 12, 2
	D_ 2
	D_ 2
	notetype 12, 11, 7
	C# 4
	notetype 12, 12, 2
	D_ 2
	D_ 2
	notetype 12, 12, 5
	A_ 4
	notetype 12, 12, 2
	octave 3
	D_ 2
	D_ 2
	notetype 12, 12, 7
	octave 4
	C# 4
	D_ 8
	octave 3
	D_ 8
	octave 4
	C_ 8
	octave 3
	C_ 8
	notetype 12, 12, 2
	D_ 2
	D_ 2
	notetype 12, 12, 5
	A_ 4
	notetype 12, 12, 2
	D_ 2
	D_ 2
	notetype 12, 12, 5
	A# 4
	notetype 12, 12, 2
	D_ 2
	D_ 2
	notetype 12, 12, 5
	octave 4
	C_ 4
	notetype 12, 12, 2
	octave 3
	D_ 2
	D_ 2
	notetype 12, 12, 5
	octave 4
	C# 4
	notetype 12, 2, 15
	D_ 16
	notetype 12, 12, 1
	octave 5
	D_ 16
	endchannel


Song_NidorinoIntro_Ch2:: ; ec116 (3b:4116)
	notetype 12, 1, 0
	rest 8
	octave 4
	D_ 1
	rest 1
	D_ 1
	rest 1
	A_ 4
	D_ 1
	rest 1
	D_ 1
	rest 1
	A_ 4
	D_ 1
	rest 1
	D_ 1
	rest 1
	A_ 4
	D_ 1
	rest 1
	D_ 1
	rest 1
	F# 4
	D_ 1
	rest 1
	D_ 1
	rest 1
	A_ 4
	D_ 1
	rest 1
	D_ 1
	rest 1
	A# 4
	A_ 8
	D_ 8
	A# 8
	D_ 8
	D_ 1
	rest 1
	D_ 1
	rest 1
	A_ 4
	D_ 1
	rest 1
	D_ 1
	rest 1
	A_ 4
	D_ 1
	rest 1
	D_ 1
	rest 1
	A# 4
	D_ 1
	rest 1
	D_ 1
	rest 1
	A# 4
	A_ 16
	D_ 1
	rest 15
	endchannel


Song_NidorinoIntro_Ch3:: ; ec155 (3b:4155)
	drumset 2
	dspeed 6
	snare4 1
	snare4 1
	snare4 1
	snare4 1
	snare3 1
	snare4 1
	snare3 1
	snare4 1
	snare3 1
	snare4 1
	snare3 1
	snare3 1
	snare3 1
	snare3 1
	snare2 1
	snare2 1
	snare2 4
	snare2 4
	snare4 1
	snare4 1
	snare4 1
	snare4 1
	snare3 1
	snare3 1
	snare3 1
	snare3 1
	snare2 4
	snare2 4
	snare2 8
	snare2 4
	snare2 4
	snare2 8
	snare2 4
	snare2 4
	snare4 1
	snare4 1
	snare4 1
	snare4 1
	snare3 1
	snare3 1
	snare3 1
	snare3 1
	snare2 4
	snare2 4
	snare2 8
	snare2 4
	snare2 4
	snare2 4
	snare4 1
	snare4 1
	snare3 1
	snare3 1
	snare2 16
	snare2 16
	snare2 16
	snare4 1
	snare4 1
	snare4 1
	snare4 1
	snare3 1
	snare4 1
	snare3 1
	snare4 1
	snare3 1
	snare3 1
	snare3 1
	snare3 1
	snare2 1
	snare2 1
	snare2 1
	snare2 1
	snare2 4
	snare2 4
	snare2 8
	snare2 4
	snare2 4
	snare4 1
	snare4 1
	snare4 1
	snare4 1
	snare3 1
	snare3 1
	snare3 1
	snare3 1
	snare2 4
	snare2 4
	snare2 8
	snare2 4
	snare2 8
	snare2 4
	snare2 16
	snare2 16
	snare2 2
	rest 16
	rest 14
	endchannel
; 0xec1b9
