INCLUDE "constants.asm"

SECTION "audio/songs/spottedrocket.asm", ROMX

Music_SpottedRocket::
	channel_count 3
	channel 1, Music_SpottedRocket_Ch1
	channel 2, Music_SpottedRocket_Ch2
	channel 3, Music_SpottedRocket_Ch3

Music_SpottedRocket_Ch1::
	tempo 124
	volume 7, 7
	duty_cycle 2
	pitch_offset 1
	note_type 12, 11, 1
	rest 4
	octave 3
	note D_, 2
	note C#, 2
	note_type 12, 4, 15
	note D_, 4

Music_SpottedRocket_branch_ed996::
	note_type 12, 10, 1
	note D_, 4
	note D_, 4
	note D_, 4
	note_type 12, 7, 0
	note D_, 4
	sound_loop 0, Music_SpottedRocket_branch_ed996


Music_SpottedRocket_Ch2::
	duty_cycle 1
	note_type 12, 11, 6
	octave 3
	note B_, 2
	note A#, 2
	note B_, 8

Music_SpottedRocket_branch_ed9ad::
	note_type 12, 12, 2
	octave 4
	note D#, 2
	note D_, 2
	note C#, 2
	note C_, 2
	octave 3
	note B_, 4
	note B_, 4
	note B_, 4
	note B_, 4
	note B_, 4
	note_type 12, 4, 15
	note A#, 4
	note_type 12, 12, 2
	note G_, 2
	note G#, 2
	note A_, 2
	note A#, 2
	note B_, 4
	note B_, 4
	note B_, 4
	note B_, 4
	note B_, 4
	note_type 12, 3, 15
	note A#, 4
	note_type 12, 12, 2
	sound_loop 0, Music_SpottedRocket_branch_ed9ad


Music_SpottedRocket_Ch3::
	note_type 12, 1, 0
	rest 8
	octave 4
	note F#, 1
	rest 1
	note F_, 1
	rest 1

Music_SpottedRocket_branch_ed9df::
	note F#, 1
	rest 3
	note F#, 1
	rest 3
	note F#, 1
	rest 3
	note A#, 4
	sound_loop 0, Music_SpottedRocket_branch_ed9df
