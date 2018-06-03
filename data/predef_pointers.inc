; Predef routines can be used with the "predef" and "predef_jump" macros.
; This preserves registers bc, de, hl and f.

add_predef: MACRO
\1Predef::
	dba \1
ENDM

PredefPointers:: ; 1:62d3
; To YOU who is reading this:
; Please be a peach and nuke the hell out of these:
; WE NEED LABELS!
; Thank youu~
	add_predef Function_6445
	add_predef Function_5d27
	add_predef Function_6713
	add_predef Function_66b1
	add_predef Function_4031
	add_predef Function_ce10
	add_predef Function_cd6f
	add_predef Function_cde3
	add_predef Function_cde3_2
	add_predef Function_cde3_3
	add_predef Function_cdf9
	add_predef Function_ce10_2
	add_predef Function_cd33
Function_366cPredef::
	dbw 3, Function_366c
	add_predef Function_ce3c
	add_predef Function_da28
	add_predef Function_d886
	add_predef Function_da4f
	add_predef Function_dac8
	add_predef Function_dcfc
	add_predef Function_dc16
	add_predef Function_dd5c
	add_predef Function_de79
	add_predef Function_ce7c
	add_predef Function_df7d
	add_predef Function_df91
	add_predef Function_1128f
	add_predef Function_112c1
	add_predef Function_28c98
	add_predef Function_2d663
	add_predef Function_3d5ce
	add_predef Function_3f019
	add_predef Function_3f068
	add_predef Function_3f04a
	add_predef Function_3d08c
	add_predef Function_3d67c
	add_predef Function_3e1a4
	add_predef Function_3ef19
	add_predef Function_3e874
	add_predef Function_3e91e
	add_predef Function_3e963
	add_predef Function_421f8
	add_predef Function_42252
	add_predef Function_41fa1
	add_predef Function_28da4
	add_predef Function_28d6e
	add_predef Function_40ac7
	add_predef Function_40000
	add_predef Function_40b5c
	add_predef Function_50000
	add_predef Function_50bfe
	add_predef Function_50bcd
	add_predef Function_50b92
	add_predef Function_508c4
	add_predef Function_50771
	add_predef Function_50774
	add_predef Function_5081f
	add_predef Function_506d4
	add_predef Function_5069e
	add_predef Function_502b5
	add_predef Function_50244
	add_predef Function_50248
	add_predef Function_500c6
	add_predef Function_500a0
	add_predef Function_50073
	add_predef Function_50ed9
	add_predef Function_cb6ff
	add_predef Function_cb710
	add_predef Function_cb733
	add_predef Function_145b8
	add_predef Function_146dc
	add_predef Function_145de
	add_predef Function_c8000
	add_predef Function_1457a
	add_predef Function_143e0
	add_predef Function_9695
	add_predef Function_928b
	add_predef Function_8786
	add_predef Function_8c4be
	add_predef Function_8c9c6
	add_predef Function_8c940
	add_predef Function_cc001
	add_predef Function_cc000
	add_predef Function_cc000_2
	add_predef Function_fdb66
	add_predef Function_1240b
	dbw $ff, InexplicablyEmptyFunction
