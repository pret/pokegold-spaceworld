INCLUDE "constants.asm"

SECTION "audio/cries.asm@Cry Header Pointers", ROMX
CryHeaderPointers::
	dba CryHeader_f17c5
	dba CryHeader_f17ce
	dba CryHeader_f17d7
	dba CryHeader_f17e0
	dba CryHeader_f17e9
	dba CryHeader_f17f2
	dba CryHeader_f17fb
	dba CryHeader_f1804
	dba CryHeader_f180d
	dba CryHeader_f1816
	dba CryHeader_f181f
	dba CryHeader_f1828
	dba CryHeader_f1831
	dba CryHeader_f183a
	dba CryHeader_f1843
	dba CryHeader_f184c
	dba CryHeader_f1855
	dba CryHeader_f185e
	dba CryHeader_f1867
	dba CryHeader_f1870
	dba CryHeader_f1879
	dba CryHeader_f1882
	dba CryHeader_f188b
	dba CryHeader_f1894
	dba CryHeader_f189d
	dba CryHeader_f18a6
	dba CryHeader_f18af
	dba CryHeader_f18b8
	dba CryHeader_f18c1
	dba CryHeader_f18ca
	dba CryHeader_f18d3
	dba CryHeader_f18dc
	dba CryHeader_f18e5
	dba CryHeader_f18ee
	dba CryHeader_f18f7
	dba CryHeader_f1900
	dba CryHeader_f1909
	dba CryHeader_f1912

SECTION "audio/cries.asm@Cries", ROMX

CryHeaders:: ; TODO: Rip the data, then INCBIN it
