INCLUDE "constants.asm"

SECTION "audio/songs/spottedrocket.asm", ROMX

Song_SpottedRocket:: ; ed978 (3b:5978)
	db 2 << 6 | 0
	dw Song_SpottedRocket_Ch0
	db 1
	dw Song_SpottedRocket_Ch1
	db 2
	dw Song_SpottedRocket_Ch2

Song_SpottedRocket_Ch0:: ; ed981 (3b:5981)
	tempo 124
	volume 7, 7
	duty 2
	toggleperfectpitch
	rest 1
	rest 2
	notetype 12, 11, 1
	rest 4
	octave 3
	D_ 2
	C# 2
	notetype 12, 4, 15
	D_ 4

Song_SpottedRocket_branch_ed996::
	notetype 12, 10, 1
	D_ 4
	D_ 4
	D_ 4
	notetype 12, 7, 0
	D_ 4
	loopchannel 0, Song_SpottedRocket_branch_ed996


Song_SpottedRocket_Ch1:: ; ed9a4 (3b:59a4)
	duty 1
	notetype 12, 11, 6
	octave 3
	B_ 2
	A# 2
	B_ 8

Song_SpottedRocket_branch_ed9ad::
	notetype 12, 12, 2
	octave 4
	D# 2
	D_ 2
	C# 2
	C_ 2
	octave 3
	B_ 4
	B_ 4
	B_ 4
	B_ 4
	B_ 4
	notetype 12, 4, 15
	A# 4
	notetype 12, 12, 2
	G_ 2
	G# 2
	A_ 2
	A# 2
	B_ 4
	B_ 4
	B_ 4
	B_ 4
	B_ 4
	notetype 12, 3, 15
	A# 4
	notetype 12, 12, 2
	loopchannel 0, Song_SpottedRocket_branch_ed9ad


Song_SpottedRocket_Ch2:: ; ed9d6 (3b:59d6)
	notetype 12, 1, 0
	rest 8
	octave 4
	F# 1
	rest 1
	F_ 1
	rest 1

Song_SpottedRocket_branch_ed9df::
	F# 1
	rest 3
	F# 1
	rest 3
	F# 1
	rest 3
	A# 4
	loopchannel 0, Song_SpottedRocket_branch_ed9df
; 0xed9ea