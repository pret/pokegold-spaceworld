INCLUDE "constants.asm"

SECTION "audio/songs/victorytrainer.asm", ROMX

Song_VictoryTrainer:: ; ed9ea (3b:59ea)
	db 2 << 6 | 0
	dw Song_VictoryTrainer_Ch0
	db 1
	dw Song_VictoryTrainer_Ch1
	db 2
	dw Song_VictoryTrainer_Ch2

Song_VictoryTrainer_Ch0:: ; ed9f3 (3b:59f3)
	tempo 224
	volume 7, 7
	duty 2
	toggleperfectpitch
	rest 1
	rest 2
	tempo 224
	notetype 4, 10, 2
	octave 4
	D_ 2
	tempo 224
	D_ 2
	D_ 2
	D_ 2
	octave 3
	A_ 2
	octave 4
	D_ 2
	notetype 4, 11, 3
	F# 12
	duty 1
	tempo 224

Song_VictoryTrainer_branch_eda18::
	notetype 4, 6, 3
	octave 3
	A_ 6
	F# 3
	A_ 3
	B_ 6
	G# 3
	B_ 3
	octave 4
	C# 3
	octave 3
	B_ 3
	A_ 3
	G_ 3
	A_ 3
	B_ 3
	A_ 3
	G_ 3
	A_ 6
	F# 3
	A_ 3
	B_ 6
	G# 3
	B_ 3
	octave 4
	C# 3
	D_ 3
	E_ 3
	F# 3
	C# 3
	octave 3
	B_ 3
	A_ 3
	octave 4
	C# 3
	octave 3
	A_ 6
	F# 3
	A_ 3
	B_ 6
	G# 3
	B_ 3
	octave 4
	C_ 6
	octave 3
	A_ 3
	octave 4
	C_ 3
	D_ 3
	octave 3
	B_ 3
	octave 4
	D_ 6
	C# 3
	octave 3
	B_ 3
	A_ 3
	G_ 3
	F# 3
	G_ 3
	A_ 3
	B_ 3
	A_ 3
	G_ 3
	F# 3
	E_ 3
	F# 3
	G_ 3
	A_ 3
	B_ 3
	loopchannel 0, Song_VictoryTrainer_branch_eda18


Song_VictoryTrainer_Ch1:: ; eda64 (3b:5a64)
	duty 2
	notetype 4, 12, 3
	octave 4
	A_ 2
	A_ 2
	A_ 2
	A_ 2
	B_ 2
	octave 5
	C# 2
	notetype 4, 12, 4
	D_ 12

Song_VictoryTrainer_branch_eda75::
	notetype 4, 8, 5
	octave 4
	D_ 6
	octave 3
	A_ 3
	octave 4
	D_ 3
	E_ 6
	octave 3
	B_ 3
	octave 4
	E_ 3
	F# 3
	G_ 3
	A_ 6
	E_ 3
	F# 3
	G_ 6
	D_ 6
	octave 3
	A_ 3
	octave 4
	D_ 3
	E_ 6
	octave 3
	B_ 3
	octave 4
	E_ 3
	F# 3
	G_ 3
	A_ 6
	F# 3
	G_ 3
	A_ 6
	D_ 6
	octave 3
	A_ 3
	octave 4
	D_ 3
	E_ 6
	octave 3
	B_ 3
	octave 4
	E_ 3
	F_ 6
	C_ 3
	F_ 3
	G_ 3
	D_ 3
	G_ 6
	notetype 4, 7, 0
	F# 12
	notetype 4, 7, 7
	F# 12
	notetype 4, 6, 0
	E_ 12
	notetype 4, 6, 7
	E_ 12
	loopchannel 0, Song_VictoryTrainer_branch_eda75


Song_VictoryTrainer_Ch2:: ; edabd (3b:5abd)
	notetype 4, 1, 0
	octave 5
	D_ 2
	D_ 2
	D_ 2
	octave 4
	B_ 2
	A_ 2
	G_ 2
	A_ 12
	notetype 4, 2, 1

Song_VictoryTrainer_branch_edacc::
	F# 3
	rest 3
	F# 3
	rest 3
	G# 3
	rest 3
	G# 3
	rest 3
	A_ 3
	rest 3
	A_ 3
	rest 3
	B_ 3
	rest 3
	B_ 3
	rest 3
	F# 3
	rest 3
	F# 3
	rest 3
	G# 3
	rest 3
	G# 3
	rest 3
	A_ 3
	rest 3
	A_ 3
	rest 3
	octave 5
	C# 3
	rest 3
	C# 3
	octave 4
	A_ 3
	F# 3
	octave 5
	D_ 3
	octave 4
	F# 3
	rest 3
	G# 3
	octave 5
	E_ 3
	octave 4
	G# 3
	rest 3
	A_ 3
	octave 5
	F_ 3
	octave 4
	A_ 3
	rest 3
	B_ 3
	octave 5
	G_ 3
	octave 4
	B_ 3
	A# 3
	A_ 3
	rest 3
	A_ 3
	rest 3
	A_ 3
	rest 3
	A_ 3
	octave 5
	C_ 3
	C# 3
	rest 3
	C# 3
	rest 3
	C# 3
	rest 3
	C# 3
	octave 4
	A_ 3
	loopchannel 0, Song_VictoryTrainer_branch_edacc
; 0xedb1c
