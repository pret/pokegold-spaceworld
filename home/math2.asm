SubtractAbsolute:: ; unreferenced
; Return |a - b|, sign in carry.
	sub b
	ret nc
	cpl
	add 1
	scf
	ret
