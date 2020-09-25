INCLUDE "constants.asm"

SECTION "audio/songs/none.asm", ROMX

Music_None::
	channel_count 4
	channel 1, Music_None_Ch1
	channel 2, Music_None_Ch2
	channel 3, Music_None_Ch3
	channel 4, Music_None_Ch4

Music_None_Ch1::
Music_None_Ch2::
Music_None_Ch3::
Music_None_Ch4::
	sound_ret
