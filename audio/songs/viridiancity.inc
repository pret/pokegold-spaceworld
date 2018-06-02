Song_ViridianCity:: ; ec1b9 (3b:41b9)
	db 3 << 6 | 0
	dw Song_ViridianCity_Ch0
	db 1
	dw Song_ViridianCity_Ch1
	db 2
	dw Song_ViridianCity_Ch2
	db 3
	dw Song_ViridianCity_Ch3

Song_ViridianCity_branch_ec1c5::
	tempo 232
	loopchannel 0, Song_ViridianCity_branch_ec1cf

Song_ViridianCity_Ch0:: ; ec1cc (3b:41cc)
	tempo 144

Song_ViridianCity_branch_ec1cf::
	volume 7, 7
	vibrato 8, 2, 4
	duty 3

Song_ViridianCity_branch_ec1d6::
	notetype 12, 12, 5
	octave 3
	G# 4
	F# 4
	E_ 2
	E_ 2
	F# 2
	D# 2
	E_ 2
	E_ 2
	D# 2
	C# 4
	D# 4
	E_ 2
	D# 4
	C# 2
	E_ 2
	E_ 4
	notetype 12, 10, 5
	C# 4
	octave 2
	B_ 6
	octave 3
	C# 2
	C# 4
	octave 2
	B_ 4
	notetype 12, 12, 5
	callchannel Song_ViridianCity_branch_ec2de
	octave 3
	D# 6
	E_ 2
	octave 2
	B_ 4
	notetype 12, 10, 5
	octave 3
	C# 2
	octave 2
	B_ 2
	A_ 4
	B_ 4
	B_ 2
	octave 3
	C# 2
	D# 2
	E_ 2
	D# 2
	C# 2
	D# 2
	notetype 12, 12, 5
	G# 2
	E_ 2
	F# 2
	E_ 2
	E_ 4
	F# 2
	D# 2
	E_ 4
	D# 2
	C# 4
	D# 4
	E_ 2
	D# 2
	C# 2
	C# 2
	E_ 2
	E_ 4
	notetype 12, 10, 5
	C# 2
	octave 2
	A_ 2
	B_ 6
	octave 3
	C# 2
	C# 2
	octave 2
	B_ 2
	B_ 4
	notetype 12, 12, 5
	callchannel Song_ViridianCity_branch_ec2de
	octave 3
	D# 4
	D# 2
	E_ 2
	octave 2
	B_ 2
	octave 3
	C# 2
	G# 2
	E_ 4
	octave 2
	B_ 2
	octave 3
	E_ 2
	notetype 12, 10, 5
	C# 4
	octave 2
	B_ 2
	octave 3
	D# 4
	C# 2
	E_ 4
	notetype 12, 11, 3
	callchannel Song_ViridianCity_branch_ec2eb
	A_ 2
	B_ 2
	A_ 2
	G# 2
	A_ 4
	F# 4
	G# 2
	E_ 2
	octave 2
	B_ 2
	octave 3
	E_ 4
	G# 2
	octave 2
	B_ 2
	octave 3
	E_ 2
	E_ 2
	F# 2
	E_ 2
	D# 2
	E_ 2
	D# 2
	C# 2
	octave 2
	B_ 2
	octave 3

Song_ViridianCity_branch_ec271::
	C# 2
	D# 2
	C# 2
	octave 2
	B_ 4
	B_ 2
	octave 3
	C# 2
	D# 2
	loopchannel 2, Song_ViridianCity_branch_ec271
	E_ 2
	octave 2
	B_ 4
	octave 3
	E_ 4
	octave 2
	B_ 2
	octave 3
	C# 2
	G# 2
	G# 2
	octave 2
	B_ 2
	octave 3
	F# 2
	octave 2
	B_ 2
	octave 3
	E_ 2
	octave 2
	B_ 2
	octave 3
	D# 2
	octave 2
	B_ 2
	octave 3
	callchannel Song_ViridianCity_branch_ec2eb
	A_ 2
	E_ 2
	A_ 2
	B_ 2
	A_ 2
	G# 2
	A_ 2
	F# 2
	G# 2
	E_ 2
	octave 2
	B_ 2
	octave 3
	E_ 2
	C# 2
	G# 2
	C# 2
	D# 2
	B_ 2
	E_ 2
	G# 2
	E_ 2
	F# 2
	E_ 4
	G# 2
	F# 2
	D# 2
	octave 2
	B_ 2
	octave 3
	D# 4
	F# 2
	D# 2
	D# 2
	F# 2
	octave 2
	B_ 2
	octave 3
	E_ 2
	octave 2
	B_ 2
	octave 3
	D# 2
	octave 2
	B_ 2
	B_ 2
	octave 3
	D# 2
	notetype 12, 11, 6
	F# 8
	F# 4
	D# 4
	E_ 8
	notetype 12, 8, 4
	octave 2
	B_ 4
	octave 3
	E_ 2
	F# 2
	loopchannel 0, Song_ViridianCity_branch_ec1d6

Song_ViridianCity_branch_ec2de::
	octave 3
	F# 2
	D# 4
	E_ 2
	D# 4
	C# 4
	octave 2
	B_ 4
	octave 3
	C# 2
	D# 2
	C# 2
	endchannel

Song_ViridianCity_branch_ec2eb::
	A_ 2
	E_ 2
	C# 2
	E_ 4
	A_ 2
	C# 2
	E_ 2
	endchannel


Song_ViridianCity_Ch1:: ; ec2f3 (3b:42f3)
	vibrato 5, 1, 5
	callchannel Song_ViridianCity_branch_ec368
	octave 4
	G# 2
	notetype 12, 12, 4
	E_ 6
	notetype 12, 12, 5
	duty 3
	octave 3
	C# 4
	D# 4
	E_ 6
	F# 6
	G# 4
	callchannel Song_ViridianCity_branch_ec368
	octave 4
	G# 2
	notetype 12, 12, 4
	E_ 14
	duty 3
	octave 3
	E_ 6
	F# 6
	G# 4
	notetype 12, 11, 7
	duty 2
	vibrato 8, 1, 7
	octave 5
	C# 12
	octave 4
	A_ 4
	octave 5
	E_ 8
	F# 2
	E_ 2
	D# 2
	C# 2
	octave 4
	B_ 12
	G# 4
	B_ 16
	F# 12
	G# 2
	A_ 2
	B_ 4
	A_ 4
	G# 4
	F# 4
	G# 12
	E_ 4
	B_ 16
	octave 5
	C# 12
	D# 2
	E_ 2
	F# 4
	E_ 4
	D# 4
	C# 4
	octave 4
	B_ 12
	octave 5
	C# 2
	D# 2
	C# 4
	octave 4
	B_ 4
	A_ 4
	G# 4
	A_ 12
	B_ 2
	octave 5
	C_ 2
	C_ 4
	octave 4
	B_ 4
	A_ 4
	F# 4
	notetype 12, 11, 7
	A_ 8
	octave 5
	C_ 8
	octave 4
	B_ 14
	notetype 12, 8, 4
	G# 1
	notetype 12, 10, 4
	A_ 1
	loopchannel 0, Song_ViridianCity_Ch1

Song_ViridianCity_branch_ec368::
	duty 2
	notetype 12, 12, 3
	octave 4
	B_ 4
	A_ 4
	notetype 12, 12, 4
	G# 10
	notetype 12, 12, 3
	G# 2
	A_ 2
	B_ 4
	B_ 2
	A_ 2
	G# 2
	A_ 2
	notetype 12, 12, 4
	F# 10
	notetype 12, 12, 5
	duty 3
	octave 3
	E_ 4
	D# 8
	E_ 4
	F# 4
	notetype 12, 12, 3
	duty 2
	octave 4
	A_ 4
	G# 4
	notetype 12, 12, 4
	F# 10
	notetype 12, 12, 3
	F# 2
	G# 2
	A_ 4
	A_ 2
	G# 2
	F# 2
	endchannel


Song_ViridianCity_Ch2:: ; ec3a2 (3b:43a2)
	notetype 12, 1, 1
	toggleperfectpitch
	rest 1
	rest 2

Song_ViridianCity_branch_ec3a8::
	vibrato 0, 0, 0
	octave 4
	callchannel Song_ViridianCity_branch_ec438
	callchannel Song_ViridianCity_branch_ec438
	callchannel Song_ViridianCity_branch_ec441
	G# 2
	E_ 2
	F# 2
	G# 2
	rest 2
	E_ 2
	F# 2
	G# 2
	callchannel Song_ViridianCity_branch_ec438
	B_ 2
	E_ 2
	F# 2
	G# 2
	rest 2
	E_ 2
	F# 2
	G# 2
	callchannel Song_ViridianCity_branch_ec438
	callchannel Song_ViridianCity_branch_ec441
	G# 2
	E_ 2
	F# 2
	G# 2
	rest 2
	G# 2
	E_ 2
	B_ 2
	rest 2
	E_ 2
	F# 2
	E_ 2
	G# 2
	E_ 2
	B_ 2
	E_ 2
	vibrato 8, 2, 5
	A_ 8
	E_ 8
	A_ 8
	F# 8
	G# 8
	E_ 8
	G# 12
	E_ 4
	F# 2
	F# 2
	D# 2
	E_ 4
	F# 2
	D# 2
	E_ 2
	F# 2
	F# 2
	B_ 2
	A_ 2
	G# 2
	A_ 2
	G# 2
	F# 2
	G# 2
	G# 2
	E_ 2
	G# 2
	rest 2
	E_ 2
	F# 2
	G# 2
	rest 2
	E_ 2
	F# 2
	G# 2
	B_ 2
	A_ 2
	G# 2
	F# 2
	A_ 8
	E_ 8
	A_ 8
	B_ 2
	A_ 2
	G# 2
	F# 2
	G# 8
	E_ 8
	B_ 4
	E_ 4
	F# 4
	G# 4
	rest 2
	D# 2
	E_ 2
	F# 2
	rest 2
	F# 2
	B_ 2
	A_ 2
	A_ 4
	G# 4
	F# 2
	D# 2
	A_ 2
	F# 2
	rest 2
	E_ 2
	F# 2
	G# 2
	rest 2
	E_ 2
	F# 1
	G# 1
	E_ 1
	F# 1
	G# 4
	B_ 2
	A_ 2
	G# 2
	A_ 2
	G# 2
	F# 2
	loopchannel 0, Song_ViridianCity_branch_ec3a8

Song_ViridianCity_branch_ec438::
	rest 2
	E_ 2
	F# 2
	G# 2
	rest 2
	E_ 2
	F# 2
	G# 2
	endchannel

Song_ViridianCity_branch_ec441::
	A_ 2
	F# 2
	G# 2
	A_ 2
	rest 2
	A_ 2
	G# 2
	F# 2
	rest 2
	F# 2
	G# 2
	A_ 2
	rest 2
	A_ 2
	G# 2
	F# 2
	D# 2
	D# 2
	E_ 2
	F# 2
	rest 2
	D# 2
	E_ 2
	F# 2
	rest 2
	D# 2
	E_ 2
	F# 2
	rest 2
	D# 2
	E_ 2
	F# 2
	endchannel


Song_ViridianCity_Ch3:: ; ec462 (3b:4462)
	drumset 0

Song_ViridianCity_branch_ec464::
	dspeed 12
	callchannel Song_ViridianCity_branch_ec49f

Song_ViridianCity_branch_ec469::
	callchannel Song_ViridianCity_branch_ec49f
	callchannel Song_ViridianCity_branch_ec4a7
	callchannel Song_ViridianCity_branch_ec4a7
	loopchannel 2, Song_ViridianCity_branch_ec469
	callchannel Song_ViridianCity_branch_ec49f
	callchannel Song_ViridianCity_branch_ec4b5
	callchannel Song_ViridianCity_branch_ec4ae
	triangle1 6
	triangle1 6
	triangle2 4
	callchannel Song_ViridianCity_branch_ec4bd
	callchannel Song_ViridianCity_branch_ec4b5
	callchannel Song_ViridianCity_branch_ec4ae
	callchannel Song_ViridianCity_branch_ec4bd
	callchannel Song_ViridianCity_branch_ec4ae
	triangle1 6
	triangle1 6
	triangle2 2
	triangle1 2
	triangle1 6
	triangle1 6
	triangle1 4
	triangle1 6
	snare6 6
	snare6 4
	loopchannel 0, Song_ViridianCity_branch_ec464

Song_ViridianCity_branch_ec49f::
	snare6 6
	snare6 6
	snare6 4
	snare6 6
	snare6 6
	snare6 2
	snare6 2
	endchannel

Song_ViridianCity_branch_ec4a7::
	snare6 6
	snare6 6
	snare6 4
	snare6 6
	snare6 6
	snare6 4
	endchannel

Song_ViridianCity_branch_ec4ae::
	triangle1 6
	triangle1 6
	triangle2 4
	triangle1 6
	triangle1 6
	triangle2 4
	endchannel

Song_ViridianCity_branch_ec4b5::
	triangle1 6
	triangle1 6
	triangle2 4
	triangle1 6
	triangle1 6
	triangle2 2
	triangle1 2
	endchannel

Song_ViridianCity_branch_ec4bd::
	triangle1 6
	triangle1 6
	triangle2 2
	triangle2 2
	endchannel
; 0xec4c2
