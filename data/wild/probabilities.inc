MACRO mon_prob
; percent, index
	db \1, \2 * 2
ENDM

GrassMonProbTable:
	mon_prob  1,  0 ; start of morning block (#1)
	mon_prob  4,  1 ;
	mon_prob  5,  2 ;
	mon_prob  1,  3 ; start of day block (#4)
	mon_prob  4,  4 ;
	mon_prob 15,  5 ;
	mon_prob 20,  6 ;
	mon_prob  5,  7 ; start of night block (#8)
	mon_prob 10,  8 ;
	mon_prob 20,  9 ;
	mon_prob 15, 10 ; end of morning block (#11)
	mon_prob  5, 11 ;
	mon_prob  5, 12 ; end of day block (#13)
	mon_prob 20, 13 ;
	mon_prob 10, 14 ;
	mon_prob  5, 15 ;
	mon_prob  4, 16 ;
	mon_prob  1, 17 ; end of night block (#18)