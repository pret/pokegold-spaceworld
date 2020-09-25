INCLUDE "constants.asm"

SECTION "audio/songs/bicycle.asm", ROMX

Music_Bicycle::
	channel_count 4
	channel 1, Music_Bicycle_Ch1
	channel 2, Music_Bicycle_Ch2
	channel 3, Music_Bicycle_Ch3
	channel 4, Music_Bicycle_Ch4

Music_Bicycle_Ch1::
	tempo 144
	volume 7, 7
	duty_cycle 3
	vibrato 8, 1, 4
	note_type 12, 11, 5
	octave 3
	note G_, 2

Music_Bicycle_branch_ed659::
	octave 4
	note C_, 4
	note D_, 4
	note E_, 2
	note C_, 2
	note E_, 2
	note G_, 2
	note G_, 2
	note F_, 2
	note E_, 2
	note F_, 4
	note E_, 2
	note D_, 2
	note F_, 4
	note D_, 4
	octave 3
	note B_, 2
	octave 4
	note F_, 4
	note D_, 4
	note E_, 2
	note F_, 2
	note G_, 2
	note C_, 2
	note E_, 2
	note C_, 2
	note D_, 2
	note E_, 2
	note_type 12, 11, 6
	note F_, 10
	note_type 12, 10, 6
	note F_, 2
	note E_, 2
	note F_, 2
	note G_, 10
	note E_, 2
	note D_, 2
	note E_, 2
	note F_, 6
	pitch_offset 1
	note_type 12, 11, 3
	note E_, 2
	note D_, 2
	note D_, 1
	note E_, 1
	note F_, 2
	note E_, 1
	note F_, 1
	pitch_offset 1
	note_type 12, 11, 5
	note G_, 6
	note G_, 6
	note A_, 2
	note F_, 2
	note G_, 6
	note_type 12, 11, 4
	note G_, 2
	note F_, 4
	note_type 12, 10, 4
	note E_, 2
	note D_, 2
	note_type 12, 9, 3
	octave 3
	note A_, 2
	octave 4
	note C_, 4
	note C_, 2
	octave 3
	note B_, 2
	note A_, 1
	note B_, 1
	note A_, 2
	note B_, 2
	octave 4
	note C_, 2
	note C_, 4
	note C_, 2
	octave 3
	note A_, 2
	note B_, 2
	note B_, 2
	note A_, 2
	octave 4
	note C_, 4
	octave 3
	note A_, 2
	note B_, 1
	octave 4
	note C_, 1
	octave 3
	note B_, 2
	octave 4
	note D_, 4
	octave 3
	note B_, 2
	octave 4
	note C_, 4
	octave 3
	note B_, 1
	octave 4
	note C_, 1
	note D_, 1
	octave 3
	note B_, 1
	octave 4
	note C_, 4
	note_type 12, 3, 13
	note C_, 4
	note_type 12, 11, 4
	note F_, 6
	note G_, 4
	note F_, 1
	note G_, 1
	note F_, 4
	note E_, 6
	note F_, 2
	note E_, 2
	note D_, 1
	note E_, 1
	note D_, 2
	note C_, 2
	note_type 12, 11, 5
	octave 3
	note A_, 4
	octave 4
	note D_, 4
	octave 3
	note B_, 4
	octave 4
	note E_, 4
	note C_, 4
	note F_, 4
	note D_, 4
	note F#, 4
	vibrato 10, 2, 6
	note_type 12, 8, 0
	note G_, 16
	note G_, 4
	note_type 12, 8, 7
	note G_, 12
	note_type 12, 11, 5
	vibrato 8, 1, 4
	sound_loop 0, Music_Bicycle_branch_ed659


Music_Bicycle_Ch2::
	duty_cycle 2
	vibrato 6, 1, 5
	note_type 12, 12, 3
	octave 4
	note C_, 2

Music_Bicycle_branch_ed717::
	note E_, 4
	note F_, 4
	note G_, 4
	octave 5
	note C_, 4
	octave 4
	note B_, 6
	note A_, 1
	note B_, 1
	note A_, 10
	note F_, 2
	note G_, 2
	note A_, 2
	octave 5
	note D_, 2
	note C_, 2
	octave 4
	note B_, 2
	note A_, 1
	note B_, 1
	octave 5
	note C_, 6
	octave 4
	note A_, 2
	note G_, 4
	duty_cycle 3
	note_type 12, 8, 4
	note A#, 6
	duty_cycle 2
	note_type 12, 12, 5
	octave 5
	note C_, 2
	octave 4
	note B_, 2
	octave 5
	note C_, 2
	octave 4
	note A_, 10
	octave 5
	note C_, 2
	octave 4
	note B_, 2
	octave 5
	note C_, 2
	octave 4
	note G_, 10
	note_type 12, 12, 3
	octave 5
	note C_, 4
	note E_, 2
	note D_, 2
	note C_, 2
	octave 4
	note B_, 2
	octave 5
	note C_, 2
	note_type 12, 11, 0
	note D_, 4
	note_type 12, 12, 7
	note D_, 10
	note D_, 1
	note C_, 1
	note_type 12, 11, 0
	octave 4
	note B_, 4
	note_type 12, 12, 7
	note B_, 12
	note_type 12, 12, 4
	note F_, 6
	note F_, 2
	note G_, 2
	note F_, 2
	note E_, 2
	note D_, 2
	note E_, 6
	note E_, 2
	note F_, 2
	note E_, 2
	note D_, 2
	note C_, 2
	note F_, 2
	note E_, 2
	note D_, 2
	note F_, 2
	note G_, 4
	note A_, 2
	note F_, 2
	note E_, 2
	note G_, 4
	note F_, 2
	note E_, 6
	note_type 6, 12, 2
	note F_, 1
	note G_, 1
	note A_, 1
	note B_, 1
	note_type 12, 12, 3
	octave 5
	note C_, 2
	octave 4
	note B_, 2
	note A_, 2
	octave 5
	note C_, 2
	octave 4
	note B_, 4
	note A_, 4
	note G_, 2
	note A#, 4
	note A_, 2
	note G_, 4
	note F_, 2
	note E_, 2
	note_type 8, 12, 4
	note A_, 4
	note G_, 4
	note F_, 4
	note B_, 4
	note A_, 4
	note G_, 4
	octave 5
	note C_, 4
	octave 4
	note B_, 4
	note A_, 4
	octave 5
	note D_, 4
	note E_, 4
	note C_, 4
	note_type 12, 12, 7
	note D_, 12
	note C_, 4
	note_type 12, 11, 0
	octave 4
	note B_, 4
	note_type 12, 12, 7
	note B_, 12
	note_type 12, 12, 3
	sound_loop 0, Music_Bicycle_branch_ed717


Music_Bicycle_Ch3::
	note_type 12, 1, 3
	rest 2

Music_Bicycle_branch_ed7c9::
	octave 4
	note C_, 1
	rest 1
	note E_, 1
	rest 1
	octave 3
	note G_, 1
	rest 1
	octave 4
	note E_, 1
	rest 1
	note C_, 1
	rest 1
	note E_, 1
	rest 1
	note C_, 1
	rest 1
	note G_, 1
	rest 1
	note F_, 1
	rest 1
	note A_, 1
	rest 1
	note C_, 1
	rest 1
	note A_, 1
	rest 1
	note F_, 1
	rest 1
	note A_, 1
	rest 1
	note E_, 1
	rest 1
	note A_, 1
	rest 1
	note D_, 1
	rest 1
	note F_, 1
	rest 1
	octave 3
	note A_, 1
	rest 1
	octave 4
	note F_, 1
	rest 1
	note D_, 1
	rest 1
	note F_, 1
	rest 1
	note E_, 1
	rest 1
	note F_, 1
	rest 1
	note E_, 1
	rest 1
	note G_, 1
	rest 1
	note C_, 1
	rest 1
	note G_, 1
	rest 1
	note E_, 1
	rest 1
	note G_, 1
	rest 1
	note E_, 1
	rest 1
	note G_, 1
	rest 1
	note F_, 1
	rest 1
	note A_, 1
	rest 1
	note C_, 1
	rest 1
	note A_, 1
	rest 1
	note F_, 1
	rest 1
	note G_, 1
	rest 1
	note A_, 1
	rest 1
	note G_, 1
	rest 1
	note E_, 1
	rest 1
	note G_, 1
	rest 1
	note C_, 1
	rest 1
	note G_, 1
	rest 1
	note E_, 1
	rest 1
	note G_, 1
	rest 1
	note E_, 1
	rest 1
	note G_, 1
	rest 1
	note D_, 1
	rest 1
	note F_, 1
	rest 1
	octave 3
	note A_, 1
	rest 1
	octave 4
	note F_, 1
	rest 1
	note D_, 1
	rest 1
	note F_, 1
	rest 1
	note D_, 1
	rest 1
	note F_, 1
	rest 1
	note G_, 1
	rest 1
	note C_, 1
	rest 1
	note D_, 1
	rest 1
	note G_, 1
	rest 1
	note D_, 1
	rest 1
	note G_, 1
	rest 1
	note D_, 1
	rest 1
	note G_, 1
	rest 1
	note D_, 1
	rest 1
	octave 3
	note B_, 1
	rest 1
	octave 4
	note D_, 1
	rest 1
	note G_, 1
	rest 1
	note D_, 1
	rest 1
	note G_, 1
	rest 1
	octave 3
	note B_, 1
	rest 1
	octave 4
	note G_, 1
	rest 1
	note D_, 1
	rest 1
	note F_, 1
	rest 1
	octave 3
	note A_, 1
	rest 1
	octave 4
	note F_, 1
	rest 1
	note D_, 1
	rest 1
	note F_, 1
	rest 1
	note D_, 1
	rest 1
	note F_, 1
	rest 1
	note E_, 1
	rest 1
	note G_, 1
	rest 1
	note C_, 1
	rest 1
	note G_, 1
	rest 1
	note E_, 1
	rest 1
	note G_, 1
	rest 1
	note E_, 1
	rest 1
	note G_, 1
	rest 1
	note D_, 1
	rest 1
	note F_, 1
	rest 1
	octave 3
	note A_, 1
	rest 1
	octave 4
	note F_, 1
	rest 1
	note F_, 1
	rest 1
	note E_, 1
	rest 1
	note D_, 1
	rest 1
	note F_, 1
	rest 1
	note E_, 1
	rest 1
	note C_, 1
	rest 1
	note G_, 1
	rest 1
	note C_, 1
	rest 1
	note E_, 1
	rest 1
	note G_, 1
	rest 1
	note E_, 1
	rest 1
	note G_, 1
	rest 1
	note F_, 1
	rest 1
	note A_, 1
	rest 1
	note C_, 1
	rest 1
	note A_, 1
	rest 1
	note F_, 1
	rest 1
	note A_, 1
	rest 1
	note A_, 1
	rest 1
	note F_, 1
	rest 1
	note G_, 1
	rest 1
	note A#, 1
	rest 1
	note E_, 1
	rest 1
	note A#, 1
	rest 1
	note G_, 1
	rest 1
	note A#, 1
	rest 1
	note A#, 1
	rest 1
	note G_, 1
	rest 1
	note F_, 1
	rest 1
	note D_, 1
	rest 1
	note F_, 1
	rest 1
	note A_, 1
	rest 1
	note G_, 1
	rest 1
	note E_, 1
	rest 1
	note G_, 1
	rest 1
	note B_, 1
	rest 1
	note A_, 1
	rest 1
	note F_, 1
	rest 1
	note A_, 1
	rest 1
	octave 5
	note C_, 1
	rest 1
	octave 4
	note B_, 1
	rest 1
	note A_, 1
	rest 1
	octave 5
	note C_, 1
	rest 1
	octave 4
	note A_, 1
	rest 1
	note G_, 1
	rest 1
	octave 5
	note C_, 1
	rest 1
	octave 4
	note G_, 1
	rest 1
	octave 5
	note C_, 1
	rest 1
	octave 4
	note G_, 1
	rest 1
	octave 5
	note C_, 1
	rest 1
	octave 4
	note G_, 1
	rest 1
	octave 5
	note C_, 1
	rest 1
	octave 4
	note G_, 1
	rest 1
	note B_, 1
	rest 1
	note G_, 1
	rest 1
	note B_, 1
	rest 1
	note F_, 1
	rest 1
	note A_, 1
	rest 1
	octave 3
	note B_, 1
	rest 1
	octave 4
	note F_, 1
	rest 1
	sound_loop 0, Music_Bicycle_branch_ed7c9

Music_Bicycle_Ch4::
    toggle_noise 1 
	drum_speed 12
	rest 2

Music_Bicycle_branch_ed91f::
	sound_call Music_Bicycle_branch_ed95c
	sound_call Music_Bicycle_branch_ed965
	sound_call Music_Bicycle_branch_ed95c
	sound_call Music_Bicycle_branch_ed96e
	sound_call Music_Bicycle_branch_ed965
	sound_call Music_Bicycle_branch_ed965
	sound_call Music_Bicycle_branch_ed95c
	sound_call Music_Bicycle_branch_ed95c
	sound_call Music_Bicycle_branch_ed95c
	sound_call Music_Bicycle_branch_ed95c
	sound_call Music_Bicycle_branch_ed965
	sound_call Music_Bicycle_branch_ed95c
	sound_call Music_Bicycle_branch_ed96e
	sound_call Music_Bicycle_branch_ed95c
	sound_call Music_Bicycle_branch_ed965
	sound_call Music_Bicycle_branch_ed95c
	sound_call Music_Bicycle_branch_ed95c
	sound_call Music_Bicycle_branch_ed95c
	sound_call Music_Bicycle_branch_ed95c
	sound_loop 0, Music_Bicycle_branch_ed91f

Music_Bicycle_branch_ed95c::
	rest 2
	drum_note 9, 2
	rest 2
	drum_note 9, 2
	rest 2
	drum_note 9, 2
	rest 2
	drum_note 9, 2
	sound_ret

Music_Bicycle_branch_ed965::
	rest 2
	drum_note 9, 2
	rest 2
	drum_note 9, 2
	rest 2
	drum_note 9, 2
	drum_note 9, 2
	drum_note 9, 2
	sound_ret

Music_Bicycle_branch_ed96e::
	rest 2
	drum_note 9, 2
	rest 2
	drum_note 9, 2
	rest 2
	drum_note 9, 2
	rest 2
	drum_note 9, 1
	drum_note 9, 1
	sound_ret
