INCLUDE "constants.asm"

SECTION "audio/cries.asm@Cry Header Pointers", ROMX
CryHeaderPointers::
	dbw $3C, $57C5
 	dbw $3C, $57CE
 	dbw $3C, $57D7
 	dbw $3C, $57E0
 	dbw $3C, $57E9
 	dbw $3C, $57F2
 	dbw $3C, $57FB
 	dbw $3C, $5804
 	dbw $3C, $580D
 	dbw $3C, $5816
 	dbw $3C, $581F
 	dbw $3C, $5828
 	dbw $3C, $5831
 	dbw $3C, $583A
 	dbw $3C, $5843
 	dbw $3C, $584C
 	dbw $3C, $5855
 	dbw $3C, $585E
 	dbw $3C, $5867
 	dbw $3C, $5870
 	dbw $3C, $5879
 	dbw $3C, $5882
 	dbw $3C, $588B
 	dbw $3C, $5894
 	dbw $3C, $589D
 	dbw $3C, $58A6
 	dbw $3C, $58AF
 	dbw $3C, $58B8
 	dbw $3C, $58C1
 	dbw $3C, $58CA
 	dbw $3C, $58D3
 	dbw $3C, $58DC
 	dbw $3C, $58E5
 	dbw $3C, $58EE
 	dbw $3C, $58F7
 	dbw $3C, $5900
 	dbw $3C, $5909
 	dbw $3C, $5912

SECTION "audio/cries.asm@Cries", ROMX

CryHeaders:: ; TODO: Rip the data, then INCBIN it
