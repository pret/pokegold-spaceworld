INCLUDE "constants.asm"

SECTION "audio/songs/bicycle.asm", ROMX

Song_Bicycle:: ; ed63e (3b:563e)
	db 3 << 6 | 0
	dw Song_Bicycle_Ch0
	db 1
	dw Song_Bicycle_Ch1
	db 2
	dw Song_Bicycle_Ch2
	db 3
	dw Song_Bicycle_Ch3

Song_Bicycle_Ch0:: ; ed64a (3b:564a)
	tempo 144
	volume 7, 7
	duty 3
	vibrato 8, 1, 4
	notetype 12, 11, 5
	octave 3
	G_ 2

Song_Bicycle_branch_ed659::
	octave 4
	C_ 4
	D_ 4
	E_ 2
	C_ 2
	E_ 2
	G_ 2
	G_ 2
	F_ 2
	E_ 2
	F_ 4
	E_ 2
	D_ 2
	F_ 4
	D_ 4
	octave 3
	B_ 2
	octave 4
	F_ 4
	D_ 4
	E_ 2
	F_ 2
	G_ 2
	C_ 2
	E_ 2
	C_ 2
	D_ 2
	E_ 2
	notetype 12, 11, 6
	F_ 10
	notetype 12, 10, 6
	F_ 2
	E_ 2
	F_ 2
	G_ 10
	E_ 2
	D_ 2
	E_ 2
	F_ 6
	toggleperfectpitch
	rest 1
	rest 2
	notetype 12, 11, 3
	E_ 2
	D_ 2
	D_ 1
	E_ 1
	F_ 2
	E_ 1
	F_ 1
	toggleperfectpitch
	rest 1
	rest 2
	notetype 12, 11, 5
	G_ 6
	G_ 6
	A_ 2
	F_ 2
	G_ 6
	notetype 12, 11, 4
	G_ 2
	F_ 4
	notetype 12, 10, 4
	E_ 2
	D_ 2
	notetype 12, 9, 3
	octave 3
	A_ 2
	octave 4
	C_ 4
	C_ 2
	octave 3
	B_ 2
	A_ 1
	B_ 1
	A_ 2
	B_ 2
	octave 4
	C_ 2
	C_ 4
	C_ 2
	octave 3
	A_ 2
	B_ 2
	B_ 2
	A_ 2
	octave 4
	C_ 4
	octave 3
	A_ 2
	B_ 1
	octave 4
	C_ 1
	octave 3
	B_ 2
	octave 4
	D_ 4
	octave 3
	B_ 2
	octave 4
	C_ 4
	octave 3
	B_ 1
	octave 4
	C_ 1
	D_ 1
	octave 3
	B_ 1
	octave 4
	C_ 4
	notetype 12, 3, 13
	C_ 4
	notetype 12, 11, 4
	F_ 6
	G_ 4
	F_ 1
	G_ 1
	F_ 4
	E_ 6
	F_ 2
	E_ 2
	D_ 1
	E_ 1
	D_ 2
	C_ 2
	notetype 12, 11, 5
	octave 3
	A_ 4
	octave 4
	D_ 4
	octave 3
	B_ 4
	octave 4
	E_ 4
	C_ 4
	F_ 4
	D_ 4
	F# 4
	vibrato 10, 2, 6
	notetype 12, 8, 0
	G_ 16
	G_ 4
	notetype 12, 8, 7
	G_ 12
	notetype 12, 11, 5
	vibrato 8, 1, 4
	loopchannel 0, Song_Bicycle_branch_ed659


Song_Bicycle_Ch1:: ; ed70d (3b:570d)
	duty 2
	vibrato 6, 1, 5
	notetype 12, 12, 3
	octave 4
	C_ 2

Song_Bicycle_branch_ed717::
	E_ 4
	F_ 4
	G_ 4
	octave 5
	C_ 4
	octave 4
	B_ 6
	A_ 1
	B_ 1
	A_ 10
	F_ 2
	G_ 2
	A_ 2
	octave 5
	D_ 2
	C_ 2
	octave 4
	B_ 2
	A_ 1
	B_ 1
	octave 5
	C_ 6
	octave 4
	A_ 2
	G_ 4
	duty 3
	notetype 12, 8, 4
	A# 6
	duty 2
	notetype 12, 12, 5
	octave 5
	C_ 2
	octave 4
	B_ 2
	octave 5
	C_ 2
	octave 4
	A_ 10
	octave 5
	C_ 2
	octave 4
	B_ 2
	octave 5
	C_ 2
	octave 4
	G_ 10
	notetype 12, 12, 3
	octave 5
	C_ 4
	E_ 2
	D_ 2
	C_ 2
	octave 4
	B_ 2
	octave 5
	C_ 2
	notetype 12, 11, 0
	D_ 4
	notetype 12, 12, 7
	D_ 10
	D_ 1
	C_ 1
	notetype 12, 11, 0
	octave 4
	B_ 4
	notetype 12, 12, 7
	B_ 12
	notetype 12, 12, 4
	F_ 6
	F_ 2
	G_ 2
	F_ 2
	E_ 2
	D_ 2
	E_ 6
	E_ 2
	F_ 2
	E_ 2
	D_ 2
	C_ 2
	F_ 2
	E_ 2
	D_ 2
	F_ 2
	G_ 4
	A_ 2
	F_ 2
	E_ 2
	G_ 4
	F_ 2
	E_ 6
	notetype 6, 12, 2
	F_ 1
	G_ 1
	A_ 1
	B_ 1
	notetype 12, 12, 3
	octave 5
	C_ 2
	octave 4
	B_ 2
	A_ 2
	octave 5
	C_ 2
	octave 4
	B_ 4
	A_ 4
	G_ 2
	A# 4
	A_ 2
	G_ 4
	F_ 2
	E_ 2
	notetype 8, 12, 4
	A_ 4
	G_ 4
	F_ 4
	B_ 4
	A_ 4
	G_ 4
	octave 5
	C_ 4
	octave 4
	B_ 4
	A_ 4
	octave 5
	D_ 4
	E_ 4
	C_ 4
	notetype 12, 12, 7
	D_ 12
	C_ 4
	notetype 12, 11, 0
	octave 4
	B_ 4
	notetype 12, 12, 7
	B_ 12
	notetype 12, 12, 3
	loopchannel 0, Song_Bicycle_branch_ed717


Song_Bicycle_Ch2:: ; ed7c5 (3b:57c5)
	notetype 12, 1, 3
	rest 2

Song_Bicycle_branch_ed7c9::
	octave 4
	C_ 1
	rest 1
	E_ 1
	rest 1
	octave 3
	G_ 1
	rest 1
	octave 4
	E_ 1
	rest 1
	C_ 1
	rest 1
	E_ 1
	rest 1
	C_ 1
	rest 1
	G_ 1
	rest 1
	F_ 1
	rest 1
	A_ 1
	rest 1
	C_ 1
	rest 1
	A_ 1
	rest 1
	F_ 1
	rest 1
	A_ 1
	rest 1
	E_ 1
	rest 1
	A_ 1
	rest 1
	D_ 1
	rest 1
	F_ 1
	rest 1
	octave 3
	A_ 1
	rest 1
	octave 4
	F_ 1
	rest 1
	D_ 1
	rest 1
	F_ 1
	rest 1
	E_ 1
	rest 1
	F_ 1
	rest 1
	E_ 1
	rest 1
	G_ 1
	rest 1
	C_ 1
	rest 1
	G_ 1
	rest 1
	E_ 1
	rest 1
	G_ 1
	rest 1
	E_ 1
	rest 1
	G_ 1
	rest 1
	F_ 1
	rest 1
	A_ 1
	rest 1
	C_ 1
	rest 1
	A_ 1
	rest 1
	F_ 1
	rest 1
	G_ 1
	rest 1
	A_ 1
	rest 1
	G_ 1
	rest 1
	E_ 1
	rest 1
	G_ 1
	rest 1
	C_ 1
	rest 1
	G_ 1
	rest 1
	E_ 1
	rest 1
	G_ 1
	rest 1
	E_ 1
	rest 1
	G_ 1
	rest 1
	D_ 1
	rest 1
	F_ 1
	rest 1
	octave 3
	A_ 1
	rest 1
	octave 4
	F_ 1
	rest 1
	D_ 1
	rest 1
	F_ 1
	rest 1
	D_ 1
	rest 1
	F_ 1
	rest 1
	G_ 1
	rest 1
	C_ 1
	rest 1
	D_ 1
	rest 1
	G_ 1
	rest 1
	D_ 1
	rest 1
	G_ 1
	rest 1
	D_ 1
	rest 1
	G_ 1
	rest 1
	D_ 1
	rest 1
	octave 3
	B_ 1
	rest 1
	octave 4
	D_ 1
	rest 1
	G_ 1
	rest 1
	D_ 1
	rest 1
	G_ 1
	rest 1
	octave 3
	B_ 1
	rest 1
	octave 4
	G_ 1
	rest 1
	D_ 1
	rest 1
	F_ 1
	rest 1
	octave 3
	A_ 1
	rest 1
	octave 4
	F_ 1
	rest 1
	D_ 1
	rest 1
	F_ 1
	rest 1
	D_ 1
	rest 1
	F_ 1
	rest 1
	E_ 1
	rest 1
	G_ 1
	rest 1
	C_ 1
	rest 1
	G_ 1
	rest 1
	E_ 1
	rest 1
	G_ 1
	rest 1
	E_ 1
	rest 1
	G_ 1
	rest 1
	D_ 1
	rest 1
	F_ 1
	rest 1
	octave 3
	A_ 1
	rest 1
	octave 4
	F_ 1
	rest 1
	F_ 1
	rest 1
	E_ 1
	rest 1
	D_ 1
	rest 1
	F_ 1
	rest 1
	E_ 1
	rest 1
	C_ 1
	rest 1
	G_ 1
	rest 1
	C_ 1
	rest 1
	E_ 1
	rest 1
	G_ 1
	rest 1
	E_ 1
	rest 1
	G_ 1
	rest 1
	F_ 1
	rest 1
	A_ 1
	rest 1
	C_ 1
	rest 1
	A_ 1
	rest 1
	F_ 1
	rest 1
	A_ 1
	rest 1
	A_ 1
	rest 1
	F_ 1
	rest 1
	G_ 1
	rest 1
	A# 1
	rest 1
	E_ 1
	rest 1
	A# 1
	rest 1
	G_ 1
	rest 1
	A# 1
	rest 1
	A# 1
	rest 1
	G_ 1
	rest 1
	F_ 1
	rest 1
	D_ 1
	rest 1
	F_ 1
	rest 1
	A_ 1
	rest 1
	G_ 1
	rest 1
	E_ 1
	rest 1
	G_ 1
	rest 1
	B_ 1
	rest 1
	A_ 1
	rest 1
	F_ 1
	rest 1
	A_ 1
	rest 1
	octave 5
	C_ 1
	rest 1
	octave 4
	B_ 1
	rest 1
	A_ 1
	rest 1
	octave 5
	C_ 1
	rest 1
	octave 4
	A_ 1
	rest 1
	G_ 1
	rest 1
	octave 5
	C_ 1
	rest 1
	octave 4
	G_ 1
	rest 1
	octave 5
	C_ 1
	rest 1
	octave 4
	G_ 1
	rest 1
	octave 5
	C_ 1
	rest 1
	octave 4
	G_ 1
	rest 1
	octave 5
	C_ 1
	rest 1
	octave 4
	G_ 1
	rest 1
	B_ 1
	rest 1
	G_ 1
	rest 1
	B_ 1
	rest 1
	F_ 1
	rest 1
	A_ 1
	rest 1
	octave 3
	B_ 1
	rest 1
	octave 4
	F_ 1
	rest 1
	loopchannel 0, Song_Bicycle_branch_ed7c9


Song_Bicycle_Ch3:: ; ed91a (3b:591a)
	drumset 1
	dspeed 12
	rest 2

Song_Bicycle_branch_ed91f::
	callchannel Song_Bicycle_branch_ed95c
	callchannel Song_Bicycle_branch_ed965
	callchannel Song_Bicycle_branch_ed95c
	callchannel Song_Bicycle_branch_ed96e
	callchannel Song_Bicycle_branch_ed965
	callchannel Song_Bicycle_branch_ed965
	callchannel Song_Bicycle_branch_ed95c
	callchannel Song_Bicycle_branch_ed95c
	callchannel Song_Bicycle_branch_ed95c
	callchannel Song_Bicycle_branch_ed95c
	callchannel Song_Bicycle_branch_ed965
	callchannel Song_Bicycle_branch_ed95c
	callchannel Song_Bicycle_branch_ed96e
	callchannel Song_Bicycle_branch_ed95c
	callchannel Song_Bicycle_branch_ed965
	callchannel Song_Bicycle_branch_ed95c
	callchannel Song_Bicycle_branch_ed95c
	callchannel Song_Bicycle_branch_ed95c
	callchannel Song_Bicycle_branch_ed95c
	loopchannel 0, Song_Bicycle_branch_ed91f

Song_Bicycle_branch_ed95c::
	rest 2
	snare7 2
	rest 2
	snare7 2
	rest 2
	snare7 2
	rest 2
	snare7 2
	endchannel

Song_Bicycle_branch_ed965::
	rest 2
	snare7 2
	rest 2
	snare7 2
	rest 2
	snare7 2
	snare7 2
	snare7 2
	endchannel

Song_Bicycle_branch_ed96e::
	rest 2
	snare7 2
	rest 2
	snare7 2
	rest 2
	snare7 2
	rest 2
	snare7 1
	snare7 1
	endchannel
; 0xed978