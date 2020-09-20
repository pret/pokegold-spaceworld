INCLUDE "constants.asm"

SECTION "audio/songs/none.asm", ROMX

Song_None::
	db 3 << 6 | 0
	dw Song_None_Ch0
	db 1
	dw Song_None_Ch1
	db 2
	dw Song_None_Ch2
	db 3
	dw Song_None_Ch3

Song_None_Ch0::
Song_None_Ch1::
Song_None_Ch2::
Song_None_Ch3::
	endchannel
