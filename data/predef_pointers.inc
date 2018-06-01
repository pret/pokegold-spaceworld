; Predef routines can be used with the "predef" and "predef_jump" macros.
; This preserves registers bc, de, hl and f.

add_predef: MACRO
\1Predef::
	dab \1
ENDM

PredefPointers:: ; 1:62d3
; To YOU who is reading this:
; Please be a peach and nuke the hell out of these:
; WE NEED LABELS!
; Thank youu~
	dbw 1, $6445 ; 0
	dbw 1, $5D27
	dbw 1, $6713
	dbw 1, $66B1
	dbw 1, $4031
	dbw 3, $4E10
	dbw 3, $4D6F
	dbw 3, $4DE3
	dbw 3, $4DE3 ; 8
	dbw 3, $4DE3
	dbw 3, $4DF9
	dbw 3, $4E10
	dbw 3, $4D33
	dbw 3, Func_0x366C
	dbw 3, $4E3C
	dbw 3, $5A28
	dbw 3, $5886 ; 10
	dbw 3, $5A4F
	dbw 3, $5AC8
	dbw 3, $5CFC
	dbw 3, $5C16
	dbw 3, $5D5C
	dbw 3, $5E79
	dbw 3, $4E7C
	dbw 3, $5F7D ; 18
	dbw 3, $5F91
	dbw 4, $528F
	dbw 4, $52C1
	dbw 10, $4C98
	dbw 11, $5663
	dbw 15, $55CE
	dbw 15, $7019
	dbw 15, $7068 ; 20
	dbw 15, $704A
	dbw 15, $508C
	dbw 15, $567C
	dbw 15, $61A4
	dbw 15, $6F19
	dbw 15, $6874
	dbw 15, $691E
	dbw 15, $6963 ; 28
	dbw 16, $61F8
	dbw 16, $6252
	dbw 16, $5FA1
	dbw 10, $4DA4
	dbw 10, $4D6E
	dbw 16, $4AC7
	dbw 16, $4000
	dbw 16, $4B5C ; 30
	dbw 20, $4000
	dbw 20, $4BFE
	dbw 20, $4BCD
	dbw 20, $4B92
	dbw 20, $48C4
	dbw 20, $4771
	dbw 20, $4774
	dbw 20, $481F ; 38
	dbw 20, $46D4
	dbw 20, $469E
	dbw 20, $42B5
	dbw 20, $4244
	dbw 20, $4248
	dbw 20, $40C6
	dbw 20, $40A0
	dbw 20, $4073 ; 40
	dbw 20, $4ED9
	dbw 50, $76FF
	dbw 50, $7710
	dbw 50, $7733
	dbw 5, $45B8
	dbw 5, $46DC
	dbw 5, $45DE
	dbw 50, $4000 ; 48
	dbw 5, $457A
	dbw 5, $43E0
	dbw 2, $5695
	dbw 2, $528B
	dbw 2, $4786
	dbw 35, $44BE
	dbw 35, $49C6
	dbw 35, $4940 ; 50
	dbw 51, $4001
	dbw 51, $4000
	dbw 51, $4000
	dbw 63, $5B66
	dbw 4, $640B
	dbw $ff, InexplicablyEmptyFunction
