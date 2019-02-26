INCLUDE "constants.asm"

SECTION "audio/songs/evolution.asm", ROMX

Song_Evolution:: ; edb1c (3b:5b1c)
	db 2 << 6 | 0
	dw Song_Evolution_Ch0
	db 1
	dw Song_Evolution_Ch1
	db 2
	dw Song_Evolution_Ch2

Song_Evolution_Ch0:: ; edb25 (3b:5b25)
	tempo 132
	volume 7, 7
	vibrato 6, 3, 4
	toggleperfectpitch
	rest 1
	rest 2
	duty 2
	notetype 12, 9, 2
	octave 3
	pitchbend 0, 74
	C_ 1
	pitchbend 0, 74
	G_ 1
	pitchbend 0, 74
	C_ 1
	pitchbend 0, 74
	G_ 1
	rest 4
	duty 3

Song_Evolution_branch_edb49::
	callchannel Song_Evolution_branch_edb5b
	notetype 12, 10, 4
	F# 4
	callchannel Song_Evolution_branch_edb5b
	notetype 12, 10, 4
	F# 4
	loopchannel 0, Song_Evolution_branch_edb49

Song_Evolution_branch_edb5b::
	notetype 12, 10, 2
	octave 3
	C_ 4
	G_ 4
	C_ 4
	G_ 4
	C_ 4
	G_ 4
	C_ 4
	endchannel


Song_Evolution_Ch1:: ; edb67 (3b:5b67)
	duty 2
	vibrato 8, 2, 5
	notetype 12, 10, 2
	octave 4
	G_ 1
	D_ 1
	G_ 1
	D_ 1
	rest 4
	duty 3

Song_Evolution_branch_edb77::
	callchannel Song_Evolution_branch_edb89
	notetype 12, 11, 5
	A_ 4
	callchannel Song_Evolution_branch_edb89
	notetype 12, 11, 5
	B_ 4
	loopchannel 0, Song_Evolution_branch_edb77

Song_Evolution_branch_edb89::
	notetype 12, 11, 2
	octave 3
	G_ 4
	D_ 4
	G_ 4
	D_ 4
	G_ 4
	D_ 4
	G_ 4
	endchannel


Song_Evolution_Ch2:: ; edb95 (3b:5b95)
	notetype 12, 1, 0
	rest 8

Song_Evolution_branch_edb99::
	callchannel Song_Evolution_branch_edba7
	octave 4
	A_ 4
	callchannel Song_Evolution_branch_edba7
	octave 4
	B_ 4
	loopchannel 0, Song_Evolution_branch_edb99

Song_Evolution_branch_edba7::
	octave 3
	A_ 2
	rest 2
	octave 4
	D_ 2
	rest 2
	octave 3
	A_ 2
	rest 2
	octave 4
	D_ 2
	rest 2
	octave 3
	A_ 2
	rest 2
	octave 4
	D_ 2
	rest 2
	octave 3
	A_ 2
	rest 2
	endchannel
; 0xedbbd