INCLUDE "constants.asm"

SECTION "audio/songs/route1.asm", ROMX

Song_Route1::
	db 3 << 6 | 0
	dw Song_Route1_Ch0
	db 1
	dw Song_Route1_Ch1
	db 2
	dw Song_Route1_Ch2
	db 3
	dw Song_Route1_Ch3

Song_Route1_Ch0::
	tempo 152
	volume 7, 7
	vibrato 4, 2, 3
	duty 2
	toggleperfectpitch
	rest 1
	rest 2

Song_Route1_branch_ec4db::
	notetype 12, 10, 1
	rest 4
	octave 4
	D_ 2
	D_ 6
	D_ 2
	D_ 6
	D_ 2
	D_ 1
	C# 1
	octave 3
	B_ 1
	octave 4
	C# 1
	octave 3
	A_ 2
	A_ 2
	A_ 6
	octave 4
	C# 2
	C# 6
	C# 2
	C# 4
	octave 3
	A_ 2
	octave 4
	C# 2
	octave 3
	B_ 2
	octave 4
	C# 4
	octave 3
	A_ 2
	A_ 6
	octave 4
	D_ 2
	D_ 6
	D_ 2
	D_ 6
	D_ 2
	D_ 1
	E_ 1
	D_ 1
	C# 1
	octave 3
	B_ 2
	A_ 2
	A_ 6
	octave 4
	C# 2
	C# 6
	octave 3
	A_ 2
	octave 4
	E_ 2
	octave 3
	A_ 2
	notetype 12, 10, 2
	octave 4
	G_ 4
	E_ 4
	F# 2
	notetype 12, 10, 1
	octave 3
	A_ 2
	A_ 6
	A_ 2
	F# 2
	A_ 4
	B_ 2
	octave 4
	C# 2
	octave 3
	B_ 4
	A_ 2
	F# 2
	A_ 4
	G_ 2
	E_ 2
	C# 4
	A_ 2
	octave 4
	D_ 2
	octave 3
	A_ 4
	B_ 2
	G_ 2
	B_ 4
	octave 4
	D_ 2
	E_ 2
	C# 2
	D_ 2
	octave 3
	A_ 2
	A_ 2
	loopchannel 0, Song_Route1_branch_ec4db
	endchannel


Song_Route1_Ch1::
	duty 2

Song_Route1_branch_ec548::
	notetype 12, 13, 1
	callchannel Song_Route1_branch_ec55b
	callchannel Song_Route1_branch_ec56e
	callchannel Song_Route1_branch_ec55b
	callchannel Song_Route1_branch_ec586
	loopchannel 0, Song_Route1_branch_ec548

Song_Route1_branch_ec55b::
	octave 4
	D_ 1
	E_ 1
	F# 2
	F# 2
	F# 2
	D_ 1
	E_ 1
	F# 2
	F# 2
	F# 2
	D_ 1
	E_ 1
	F# 2
	F# 2
	G_ 3
	F# 1
	E_ 6
	endchannel

Song_Route1_branch_ec56e::
	C# 1
	D_ 1
	E_ 2
	E_ 2
	E_ 2
	C# 1
	D_ 1
	E_ 2
	E_ 2
	E_ 2
	C# 1
	D_ 1
	stereopanning 41
	D# 8
	E_ 2
	E_ 2
	F# 1
	E_ 1
	E_ 1
	F# 1
	D_ 4
	F# 2
	endchannel

Song_Route1_branch_ec586::
	C# 1
	D_ 1
	E_ 2
	G_ 2
	F# 2
	E_ 2
	D_ 2
	C# 2
	octave 3
	B_ 2
	octave 4
	C# 2
	notetype 12, 13, 2
	B_ 4
	notetype 6, 13, 1
	octave 3
	B_ 1
	octave 4
	C# 1
	notetype 12, 13, 1
	octave 3
	B_ 1
	A_ 1
	octave 4
	C# 1
	D_ 6
	notetype 12, 13, 2
	F# 1
	G_ 1
	A_ 2
	A_ 2
	F# 2
	D_ 2
	octave 5
	D_ 2
	C# 2
	octave 4
	B_ 2
	octave 5
	C# 2
	octave 4
	A_ 2
	F# 2
	D_ 3
	F# 1
	E_ 6
	F# 1
	G_ 1
	A_ 2
	A_ 2
	F# 2
	A_ 2
	octave 5
	D_ 2
	C# 2
	octave 4
	B_ 3
	G_ 1
	A_ 2
	octave 5
	D_ 2
	C# 2
	E_ 2
	D_ 2
	notetype 12, 13, 1
	octave 4
	D_ 2
	D_ 2
	endchannel
	endchannel


Song_Route1_Ch2::
	vibrato 8, 2, 5
	notetype 12, 1, 3

Song_Route1_branch_ec5dc::
	rest 2
	octave 4
	D_ 4
	C# 4
	octave 3
	B_ 4
	A_ 4
	octave 4
	D_ 4
	octave 3
	A_ 4
	B_ 4
	A_ 4
	octave 4
	C# 4
	octave 3
	A_ 4
	B_ 4
	octave 4
	C_ 4
	C# 4
	octave 3
	A_ 4
	octave 4
	D_ 4
	octave 3
	A_ 4
	octave 4
	D_ 4
	C# 4
	octave 3
	B_ 4
	A_ 4
	octave 4
	D_ 4
	octave 3
	A_ 4
	B_ 4
	A_ 4
	octave 4
	C# 4
	octave 3
	B_ 4
	A_ 4
	B_ 4
	octave 4
	C# 4
	octave 3
	A_ 4
	octave 4
	D_ 4
	octave 3
	A_ 4
	octave 4
	D_ 8
	octave 3
	G_ 8
	A_ 8
	octave 4
	C# 8
	D_ 8
	octave 3
	G_ 8
	A_ 8
	octave 4
	D_ 6
	loopchannel 0, Song_Route1_branch_ec5dc
	endchannel


Song_Route1_Ch3::
	drumset 2

Song_Route1_branch_ec625::
	dspeed 12
	rest 4
	snare4 2
	rest 2
	snare4 2
	rest 2
	snare4 2
	rest 2
	snare4 2
	rest 2
	snare4 2
	rest 2
	snare4 2
	rest 2
	snare4 2
	snare4 2
	rest 4
	snare4 2
	rest 2
	snare4 2
	rest 2
	snare4 2
	rest 2
	snare4 2
	rest 2
	snare4 2
	rest 2
	snare4 2
	snare4 2
	snare4 2
	snare4 2
	rest 4
	snare4 2
	rest 2
	snare4 2
	rest 2
	snare4 2
	rest 2
	snare4 2
	rest 2
	snare4 2
	rest 2
	snare4 2
	rest 2
	snare4 2
	snare4 2
	rest 4
	snare4 2
	rest 2
	snare4 2
	rest 2
	snare4 2
	rest 2
	snare4 2
	rest 2
	snare4 2
	rest 2
	snare4 2
	rest 2
	snare4 2
	snare4 2
	snare4 2
	rest 2
	snare4 2
	snare4 2
	rest 4
	snare4 2
	snare4 2
	snare4 2
	rest 2
	snare4 2
	snare4 2
	rest 4
	snare4 2
	snare4 2
	snare4 2
	rest 2
	snare4 2
	snare4 2
	rest 4
	snare4 2
	snare4 2
	snare4 2
	rest 2
	snare4 2
	snare4 2
	snare4 2
	rest 2
	snare4 2
	snare4 2
	loopchannel 0, Song_Route1_branch_ec625
	endchannel
