INCLUDE "constants.asm"

SECTION "audio/songs/none.asm", ROMX

Song_None:: ; e92ee (3a:52ee)
	db 3 << 6 | 0
	dw Song_None_Ch0
	db 1
	dw Song_None_Ch1
	db 2
	dw Song_None_Ch2
	db 3
	dw Song_None_Ch3

Song_None_Ch0:: ; e92fa (3a:52fa)
Song_None_Ch1:: ; e92fa (3a:52fa)
Song_None_Ch2:: ; e92fa (3a:52fa)
Song_None_Ch3:: ; e92fa (3a:52fa)
	endchannel
; 0xe92fb