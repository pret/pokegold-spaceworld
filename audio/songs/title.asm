INCLUDE "constants.asm"

SECTION "audio/songs/title.asm", ROMX

Song_Title:: ; f22fe (3c:62fe)
	db 3 << 6 | 0
	dw Song_Title_Ch0
	db 1
	dw Song_Title_Ch1
	db 2
	dw Song_Title_Ch2
	db 3
	dw Song_Title_Ch3

Song_Title_Ch0:: ; f230a (3c:630a)
	tempo 144
	volume 7, 7
	vibrato 9, 3, 4
	duty 3
	notetype 12, 12, 1
	octave 2
	E_ 1
	G_ 1
	B_ 1
	octave 3
	D_ 1
	octave 2
	G_ 4
	G_ 6
	G_ 1
	G_ 1
	G_ 4
	G_ 4
	G_ 4
	notetype 8, 12, 1
	A_ 2
	A_ 2
	A_ 2
	A_ 2
	A_ 2
	F# 2

Song_Title_branch_f232e::
	callchannel Song_Title_branch_f2395
	callchannel Song_Title_branch_f239f
	callchannel Song_Title_branch_f2395
	octave 3
	C_ 8
	notetype 8, 12, 6
	E_ 4
	E_ 4
	C_ 4
	notetype 12, 12, 6
	octave 2
	B_ 8
	notetype 8, 14, 7
	octave 3
	F_ 4
	E_ 4
	C_ 4
	notetype 12, 14, 7
	D_ 10
	notetype 12, 12, 6
	octave 2
	B_ 2
	octave 3
	C_ 2
	D_ 2
	callchannel Song_Title_branch_f2395
	callchannel Song_Title_branch_f239f
	callchannel Song_Title_branch_f2395
	C_ 6
	C_ 6
	E_ 4
	D_ 6
	F_ 2
	G_ 2
	D_ 4
	G_ 2
	G_ 6
	A_ 4
	F_ 2
	A_ 2
	octave 4
	C_ 2
	octave 3
	D_ 12
	E_ 4
	F_ 8
	G_ 4
	F_ 4
	E_ 12
	F_ 4
	G_ 8
	notetype 12, 11, 6
	octave 4
	C_ 4
	C# 4
	callchannel Song_Title_branch_f23b3
	notetype 8, 11, 4
	octave 4
	C_ 4
	C_ 4
	C# 4
	callchannel Song_Title_branch_f23b3
	notetype 8, 11, 2
	octave 3
	E_ 4
	E_ 4
	C# 4
	loopchannel 0, Song_Title_branch_f232e

Song_Title_branch_f2395::
	notetype 12, 12, 6
	octave 3
	D_ 6
	octave 2
	B_ 2
	octave 3
	D_ 8
	endchannel

Song_Title_branch_f239f::
	C_ 6
	F_ 6
	C_ 4
	D_ 8
	notetype 12, 14, 7
	F_ 6
	E_ 1
	D# 1
	D_ 8
	notetype 8, 12, 6
	C_ 4
	octave 2
	B_ 4
	octave 3
	C_ 4
	endchannel

Song_Title_branch_f23b3::
	notetype 12, 12, 1
	D_ 1
	rest 1
	octave 2
	D_ 1
	D_ 1
	D_ 1
	rest 1
	D_ 1
	D_ 1
	D_ 1
	rest 1
	D_ 1
	D_ 1
	D_ 1
	rest 1
	D_ 1
	D_ 1
	D_ 1
	rest 1
	D_ 1
	D_ 1
	D_ 1
	rest 1
	D_ 1
	D_ 1
	endchannel


Song_Title_Ch1:: ; f23d0 (3c:63d0)
	vibrato 16, 4, 6
	duty 1
	notetype 12, 14, 1
	octave 2
	G_ 1
	B_ 1
	octave 3
	D_ 1
	F# 1
	G_ 4
	G_ 6
	G_ 1
	G_ 1
	G_ 4
	G_ 4
	G_ 4
	notetype 8, 14, 1
	F_ 2
	F_ 2
	F_ 2
	F_ 2
	F_ 2
	F# 2

Song_Title_branch_f23ee::
	vibrato 16, 4, 6
	callchannel Song_Title_branch_f248a
	unknown_f9
	octave 2
	A_ 4
	F_ 4
	callchannel Song_Title_branch_f2496
	octave 2
	A_ 8
	B_ 16
	callchannel Song_Title_branch_f248a
	octave 2
	A_ 6
	F_ 2
	notetype 8, 14, 7
	octave 4
	C_ 4
	octave 3
	B_ 4
	octave 4
	C_ 4
	notetype 12, 14, 7
	D_ 8
	notetype 12, 9, 5
	octave 2
	D_ 6
	D_ 1
	F# 1
	G_ 16
	callchannel Song_Title_branch_f248a
	octave 2
	A_ 2
	F_ 6
	callchannel Song_Title_branch_f2496
	octave 3
	C_ 2
	octave 2
	A_ 6
	B_ 6
	G_ 2
	F_ 8
	callchannel Song_Title_branch_f248a
	notetype 8, 9, 5
	octave 2
	G_ 4
	F_ 5
	A_ 3
	notetype 8, 14, 6
	octave 4
	F_ 4
	E_ 4
	F_ 4
	notetype 12, 14, 7
	G_ 6
	A# 2
	G_ 8
	unknown_f9
	vibrato 16, 2, 6
	duty 3
	notetype 12, 0, 11
	G_ 8
	notetype 12, 14, 7
	A_ 8
	duty 1
	notetype 12, 14, 7
	A# 6
	F_ 2
	F_ 8
	octave 3
	D_ 8
	octave 4
	A# 4
	B_ 4
	octave 5
	C_ 6
	octave 4
	G_ 2
	G_ 8
	octave 3
	E_ 8
	notetype 12, 13, 7
	octave 5
	C_ 4
	C# 4
	callchannel Song_Title_branch_f24a2
	rest 3
	D_ 1
	rest 3
	D_ 1
	notetype 8, 14, 5
	octave 5
	C_ 4
	C_ 4
	C# 4
	callchannel Song_Title_branch_f24a2
	D_ 1
	rest 2
	D_ 1
	rest 3
	D_ 1
	notetype 8, 14, 3
	octave 5
	C_ 4
	C_ 4
	octave 4
	B_ 4
	loopchannel 0, Song_Title_branch_f23ee

Song_Title_branch_f248a::
	notetype 12, 14, 7
	octave 3
	G_ 6
	B_ 2
	octave 4
	D_ 8
	notetype 12, 9, 5
	endchannel

Song_Title_branch_f2496::
	notetype 12, 14, 7
	octave 4
	F_ 6
	E_ 1
	D# 1
	D_ 8
	notetype 12, 9, 5
	endchannel

Song_Title_branch_f24a2::
	notetype 12, 14, 1
	D_ 1
	rest 2
	octave 4
	D_ 1
	rest 3
	D_ 1
	rest 3
	D_ 1
	rest 3
	D_ 1
	endchannel


Song_Title_Ch2:: ; f24b0 (3c:64b0)
	notetype 12, 1, 0
	octave 3
	G_ 1
	rest 1
	D_ 1
	rest 1
	G_ 1
	rest 3
	G_ 1
	rest 5
	G_ 1
	G_ 1
	G_ 1
	rest 3
	G_ 1
	rest 3
	G_ 1
	rest 3
	notetype 8, 1, 0
	F_ 2
	F_ 2
	F_ 2
	F_ 2
	F_ 2
	A_ 2

Song_Title_branch_f24cd::
	callchannel Song_Title_branch_f253a
	callchannel Song_Title_branch_f2541

Song_Title_branch_f24d3::
	callchannel Song_Title_branch_f253a
	callchannel Song_Title_branch_f253a
	callchannel Song_Title_branch_f253a
	callchannel Song_Title_branch_f2541
	loopchannel 3, Song_Title_branch_f24d3
	callchannel Song_Title_branch_f253a
	G_ 6
	D_ 3
	A_ 6
	F_ 3
	A_ 3
	F_ 3
	callchannel Song_Title_branch_f2548
	A# 3
	F_ 3
	callchannel Song_Title_branch_f2548
	B_ 3
	G_ 3
	callchannel Song_Title_branch_f254d
	octave 4
	C_ 3
	octave 3
	G_ 3
	callchannel Song_Title_branch_f254d
	octave 4
	C# 3
	octave 3
	A_ 3
	callchannel Song_Title_branch_f2556
	octave 5
	pitchbend 0, 67
	D_ 4
	rest 4
	octave 6
	pitchbend 0, 51
	D_ 4
	octave 5
	pitchbend 0, 67
	D_ 4
	rest 2
	notetype 8, 1, 0
	octave 4
	C_ 4
	C_ 4
	C# 4
	callchannel Song_Title_branch_f2556
	octave 6
	pitchbend 0, 51
	D_ 4
	rest 4
	octave 5
	pitchbend 0, 67
	D_ 4
	rest 6
	notetype 8, 1, 0
	octave 4
	C_ 4
	C_ 4
	octave 3
	B_ 4
	loopchannel 0, Song_Title_branch_f24cd

Song_Title_branch_f253a::
	G_ 6
	D_ 3
	G_ 6
	D_ 3
	G_ 3
	D_ 3
	endchannel

Song_Title_branch_f2541::
	F_ 6
	C_ 3
	F_ 6
	C_ 3
	F_ 3
	C_ 3
	endchannel

Song_Title_branch_f2548::
	A# 6
	F_ 3
	A# 6
	F_ 3
	endchannel

Song_Title_branch_f254d::
	octave 4
	C_ 6
	octave 3
	G_ 3
	octave 4
	C_ 6
	octave 3
	G_ 3
	endchannel

Song_Title_branch_f2556::
	notetype 12, 1, 0
	octave 4
	D_ 1
	rest 5
	endchannel


Song_Title_Ch3:: ; f255d (3c:655d)
	drumset 0
	dspeed 6
	rest 4
	snare3 1
	snare3 1
	snare4 1
	snare4 1
	dspeed 12
	snare2 1
	rest 3
	snare2 1
	rest 5
	snare2 1
	snare2 1
	snare2 1
	rest 3
	snare2 1
	rest 3
	snare2 1
	rest 3
	dspeed 8
	snare3 2
	snare4 2
	snare2 2
	snare3 2
	snare2 2
	snare1 2

Song_Title_branch_f257c::
	dspeed 12
	snare2 1
	rest 3
	snare2 1
	rest 5
	snare2 1
	snare2 1
	snare3 1
	rest 3
	callchannel Song_Title_branch_f263c
	callchannel Song_Title_branch_f263c
	snare2 1
	rest 3
	snare2 1
	rest 5
	snare2 1
	snare2 1
	snare3 1
	rest 1
	snare3 1
	snare2 1
	callchannel Song_Title_branch_f2645
	snare2 1
	rest 3
	snare2 1
	rest 5
	snare2 1
	snare3 1
	snare2 1
	rest 1
	snare2 1
	rest 1
	callchannel Song_Title_branch_f2645
	snare2 1
	rest 3
	snare2 1
	rest 5
	snare2 1
	snare3 1
	snare2 1
	rest 1
	dspeed 6
	snare3 1
	snare3 1
	snare4 1
	snare4 1
	dspeed 12
	callchannel Song_Title_branch_f263c
	callchannel Song_Title_branch_f2645
	snare2 1
	rest 3
	snare2 1
	rest 5
	snare2 1
	snare3 1
	snare2 1
	rest 3
	snare2 1
	rest 3
	snare2 1
	rest 5
	snare3 1
	snare2 1
	snare2 1
	rest 1
	snare3 1
	snare2 1
	callchannel Song_Title_branch_f263c
	callchannel Song_Title_branch_f2645
	snare2 1
	rest 3
	snare2 1
	rest 5
	snare3 1
	snare2 1
	snare2 1
	rest 1
	snare4 1
	snare3 1
	snare2 1
	rest 3
	snare3 1
	rest 5
	snare2 1
	snare4 1
	snare2 1
	rest 1
	dspeed 6
	snare3 1
	snare3 1
	snare4 1
	snare4 1
	dspeed 12
	snare1 1
	rest 3
	snare2 1
	rest 5
	snare3 1
	snare2 1
	snare1 1
	rest 3
	snare2 1
	rest 3
	snare3 1
	rest 5
	snare3 1
	snare2 1
	snare3 1
	rest 3
	snare2 1
	rest 3
	snare3 1
	rest 5
	snare2 1
	snare3 1
	snare4 1
	rest 1
	snare3 1
	snare2 1
	snare2 1
	rest 3
	snare3 1
	rest 5
	snare2 1
	snare3 1
	snare2 1
	rest 3
	snare5 1
	rest 5
	snare2 1
	rest 3
	snare3 1
	snare2 1
	snare1 1
	rest 5
	snare2 1
	snare3 1
	snare2 1
	rest 1
	snare1 1
	rest 1
	dspeed 8
	snare2 4
	snare3 4
	snare1 4
	dspeed 12
	snare5 1
	rest 5
	snare2 1
	rest 3
	snare3 1
	snare2 1
	snare3 1
	rest 5
	snare2 1
	snare3 1
	snare1 1
	rest 1
	snare3 1
	snare2 1
	dspeed 8
	snare2 4
	snare3 4
	snare2 4
	loopchannel 0, Song_Title_branch_f257c

Song_Title_branch_f263c::
	snare2 1
	rest 3
	snare2 1
	rest 5
	snare2 1
	snare3 1
	snare2 1
	rest 3
	endchannel

Song_Title_branch_f2645::
	snare2 1
	rest 3
	snare2 1
	rest 5
	snare3 1
	snare2 1
	snare2 1
	rest 3
	endchannel
; 0xf264e
