INCLUDE "constants.asm"

SECTION "audio/songs/viridiancity.asm", ROMX

Music_ViridianCity::
	channel_count 4
	channel 1, Music_ViridianCity_Ch1
	channel 2, Music_ViridianCity_Ch2
	channel 3, Music_ViridianCity_Ch3
	channel 4, Music_ViridianCity_Ch4

Music_ViridianCity_branch_ec1c5::
	tempo 232
	sound_loop 0, Music_ViridianCity_branch_ec1cf

Music_ViridianCity_Ch1::
	tempo 144

Music_ViridianCity_branch_ec1cf::
	volume 7, 7
	vibrato 8, 2, 4
	duty_cycle 3

Music_ViridianCity_branch_ec1d6::
	note_type 12, 12, 5
	octave 3
	note G#, 4
	note F#, 4
	note E_, 2
	note E_, 2
	note F#, 2
	note D#, 2
	note E_, 2
	note E_, 2
	note D#, 2
	note C#, 4
	note D#, 4
	note E_, 2
	note D#, 4
	note C#, 2
	note E_, 2
	note E_, 4
	note_type 12, 10, 5
	note C#, 4
	octave 2
	note B_, 6
	octave 3
	note C#, 2
	note C#, 4
	octave 2
	note B_, 4
	note_type 12, 12, 5
	sound_call Music_ViridianCity_branch_ec2de
	octave 3
	note D#, 6
	note E_, 2
	octave 2
	note B_, 4
	note_type 12, 10, 5
	octave 3
	note C#, 2
	octave 2
	note B_, 2
	note A_, 4
	note B_, 4
	note B_, 2
	octave 3
	note C#, 2
	note D#, 2
	note E_, 2
	note D#, 2
	note C#, 2
	note D#, 2
	note_type 12, 12, 5
	note G#, 2
	note E_, 2
	note F#, 2
	note E_, 2
	note E_, 4
	note F#, 2
	note D#, 2
	note E_, 4
	note D#, 2
	note C#, 4
	note D#, 4
	note E_, 2
	note D#, 2
	note C#, 2
	note C#, 2
	note E_, 2
	note E_, 4
	note_type 12, 10, 5
	note C#, 2
	octave 2
	note A_, 2
	note B_, 6
	octave 3
	note C#, 2
	note C#, 2
	octave 2
	note B_, 2
	note B_, 4
	note_type 12, 12, 5
	sound_call Music_ViridianCity_branch_ec2de
	octave 3
	note D#, 4
	note D#, 2
	note E_, 2
	octave 2
	note B_, 2
	octave 3
	note C#, 2
	note G#, 2
	note E_, 4
	octave 2
	note B_, 2
	octave 3
	note E_, 2
	note_type 12, 10, 5
	note C#, 4
	octave 2
	note B_, 2
	octave 3
	note D#, 4
	note C#, 2
	note E_, 4
	note_type 12, 11, 3
	sound_call Music_ViridianCity_branch_ec2eb
	note A_, 2
	note B_, 2
	note A_, 2
	note G#, 2
	note A_, 4
	note F#, 4
	note G#, 2
	note E_, 2
	octave 2
	note B_, 2
	octave 3
	note E_, 4
	note G#, 2
	octave 2
	note B_, 2
	octave 3
	note E_, 2
	note E_, 2
	note F#, 2
	note E_, 2
	note D#, 2
	note E_, 2
	note D#, 2
	note C#, 2
	octave 2
	note B_, 2
	octave 3

Music_ViridianCity_branch_ec271::
	note C#, 2
	note D#, 2
	note C#, 2
	octave 2
	note B_, 4
	note B_, 2
	octave 3
	note C#, 2
	note D#, 2
	sound_loop 2, Music_ViridianCity_branch_ec271
	note E_, 2
	octave 2
	note B_, 4
	octave 3
	note E_, 4
	octave 2
	note B_, 2
	octave 3
	note C#, 2
	note G#, 2
	note G#, 2
	octave 2
	note B_, 2
	octave 3
	note F#, 2
	octave 2
	note B_, 2
	octave 3
	note E_, 2
	octave 2
	note B_, 2
	octave 3
	note D#, 2
	octave 2
	note B_, 2
	octave 3
	sound_call Music_ViridianCity_branch_ec2eb
	note A_, 2
	note E_, 2
	note A_, 2
	note B_, 2
	note A_, 2
	note G#, 2
	note A_, 2
	note F#, 2
	note G#, 2
	note E_, 2
	octave 2
	note B_, 2
	octave 3
	note E_, 2
	note C#, 2
	note G#, 2
	note C#, 2
	note D#, 2
	note B_, 2
	note E_, 2
	note G#, 2
	note E_, 2
	note F#, 2
	note E_, 4
	note G#, 2
	note F#, 2
	note D#, 2
	octave 2
	note B_, 2
	octave 3
	note D#, 4
	note F#, 2
	note D#, 2
	note D#, 2
	note F#, 2
	octave 2
	note B_, 2
	octave 3
	note E_, 2
	octave 2
	note B_, 2
	octave 3
	note D#, 2
	octave 2
	note B_, 2
	note B_, 2
	octave 3
	note D#, 2
	note_type 12, 11, 6
	note F#, 8
	note F#, 4
	note D#, 4
	note E_, 8
	note_type 12, 8, 4
	octave 2
	note B_, 4
	octave 3
	note E_, 2
	note F#, 2
	sound_loop 0, Music_ViridianCity_branch_ec1d6

Music_ViridianCity_branch_ec2de::
	octave 3
	note F#, 2
	note D#, 4
	note E_, 2
	note D#, 4
	note C#, 4
	octave 2
	note B_, 4
	octave 3
	note C#, 2
	note D#, 2
	note C#, 2
	sound_ret

Music_ViridianCity_branch_ec2eb::
	note A_, 2
	note E_, 2
	note C#, 2
	note E_, 4
	note A_, 2
	note C#, 2
	note E_, 2
	sound_ret


Music_ViridianCity_Ch2::
	vibrato 5, 1, 5
	sound_call Music_ViridianCity_branch_ec368
	octave 4
	note G#, 2
	note_type 12, 12, 4
	note E_, 6
	note_type 12, 12, 5
	duty_cycle 3
	octave 3
	note C#, 4
	note D#, 4
	note E_, 6
	note F#, 6
	note G#, 4
	sound_call Music_ViridianCity_branch_ec368
	octave 4
	note G#, 2
	note_type 12, 12, 4
	note E_, 14
	duty_cycle 3
	octave 3
	note E_, 6
	note F#, 6
	note G#, 4
	note_type 12, 11, 7
	duty_cycle 2
	vibrato 8, 1, 7
	octave 5
	note C#, 12
	octave 4
	note A_, 4
	octave 5
	note E_, 8
	note F#, 2
	note E_, 2
	note D#, 2
	note C#, 2
	octave 4
	note B_, 12
	note G#, 4
	note B_, 16
	note F#, 12
	note G#, 2
	note A_, 2
	note B_, 4
	note A_, 4
	note G#, 4
	note F#, 4
	note G#, 12
	note E_, 4
	note B_, 16
	octave 5
	note C#, 12
	note D#, 2
	note E_, 2
	note F#, 4
	note E_, 4
	note D#, 4
	note C#, 4
	octave 4
	note B_, 12
	octave 5
	note C#, 2
	note D#, 2
	note C#, 4
	octave 4
	note B_, 4
	note A_, 4
	note G#, 4
	note A_, 12
	note B_, 2
	octave 5
	note C_, 2
	note C_, 4
	octave 4
	note B_, 4
	note A_, 4
	note F#, 4
	note_type 12, 11, 7
	note A_, 8
	octave 5
	note C_, 8
	octave 4
	note B_, 14
	note_type 12, 8, 4
	note G#, 1
	note_type 12, 10, 4
	note A_, 1
	sound_loop 0, Music_ViridianCity_Ch2

Music_ViridianCity_branch_ec368::
	duty_cycle 2
	note_type 12, 12, 3
	octave 4
	note B_, 4
	note A_, 4
	note_type 12, 12, 4
	note G#, 10
	note_type 12, 12, 3
	note G#, 2
	note A_, 2
	note B_, 4
	note B_, 2
	note A_, 2
	note G#, 2
	note A_, 2
	note_type 12, 12, 4
	note F#, 10
	note_type 12, 12, 5
	duty_cycle 3
	octave 3
	note E_, 4
	note D#, 8
	note E_, 4
	note F#, 4
	note_type 12, 12, 3
	duty_cycle 2
	octave 4
	note A_, 4
	note G#, 4
	note_type 12, 12, 4
	note F#, 10
	note_type 12, 12, 3
	note F#, 2
	note G#, 2
	note A_, 4
	note A_, 2
	note G#, 2
	note F#, 2
	sound_ret


Music_ViridianCity_Ch3::
	note_type 12, 1, 1
	pitch_offset 1

Music_ViridianCity_branch_ec3a8::
	vibrato 0, 0, 0
	octave 4
	sound_call Music_ViridianCity_branch_ec438
	sound_call Music_ViridianCity_branch_ec438
	sound_call Music_ViridianCity_branch_ec441
	note G#, 2
	note E_, 2
	note F#, 2
	note G#, 2
	rest 2
	note E_, 2
	note F#, 2
	note G#, 2
	sound_call Music_ViridianCity_branch_ec438
	note B_, 2
	note E_, 2
	note F#, 2
	note G#, 2
	rest 2
	note E_, 2
	note F#, 2
	note G#, 2
	sound_call Music_ViridianCity_branch_ec438
	sound_call Music_ViridianCity_branch_ec441
	note G#, 2
	note E_, 2
	note F#, 2
	note G#, 2
	rest 2
	note G#, 2
	note E_, 2
	note B_, 2
	rest 2
	note E_, 2
	note F#, 2
	note E_, 2
	note G#, 2
	note E_, 2
	note B_, 2
	note E_, 2
	vibrato 8, 2, 5
	note A_, 8
	note E_, 8
	note A_, 8
	note F#, 8
	note G#, 8
	note E_, 8
	note G#, 12
	note E_, 4
	note F#, 2
	note F#, 2
	note D#, 2
	note E_, 4
	note F#, 2
	note D#, 2
	note E_, 2
	note F#, 2
	note F#, 2
	note B_, 2
	note A_, 2
	note G#, 2
	note A_, 2
	note G#, 2
	note F#, 2
	note G#, 2
	note G#, 2
	note E_, 2
	note G#, 2
	rest 2
	note E_, 2
	note F#, 2
	note G#, 2
	rest 2
	note E_, 2
	note F#, 2
	note G#, 2
	note B_, 2
	note A_, 2
	note G#, 2
	note F#, 2
	note A_, 8
	note E_, 8
	note A_, 8
	note B_, 2
	note A_, 2
	note G#, 2
	note F#, 2
	note G#, 8
	note E_, 8
	note B_, 4
	note E_, 4
	note F#, 4
	note G#, 4
	rest 2
	note D#, 2
	note E_, 2
	note F#, 2
	rest 2
	note F#, 2
	note B_, 2
	note A_, 2
	note A_, 4
	note G#, 4
	note F#, 2
	note D#, 2
	note A_, 2
	note F#, 2
	rest 2
	note E_, 2
	note F#, 2
	note G#, 2
	rest 2
	note E_, 2
	note F#, 1
	note G#, 1
	note E_, 1
	note F#, 1
	note G#, 4
	note B_, 2
	note A_, 2
	note G#, 2
	note A_, 2
	note G#, 2
	note F#, 2
	sound_loop 0, Music_ViridianCity_branch_ec3a8

Music_ViridianCity_branch_ec438::
	rest 2
	note E_, 2
	note F#, 2
	note G#, 2
	rest 2
	note E_, 2
	note F#, 2
	note G#, 2
	sound_ret

Music_ViridianCity_branch_ec441::
	note A_, 2
	note F#, 2
	note G#, 2
	note A_, 2
	rest 2
	note A_, 2
	note G#, 2
	note F#, 2
	rest 2
	note F#, 2
	note G#, 2
	note A_, 2
	rest 2
	note A_, 2
	note G#, 2
	note F#, 2
	note D#, 2
	note D#, 2
	note E_, 2
	note F#, 2
	rest 2
	note D#, 2
	note E_, 2
	note F#, 2
	rest 2
	note D#, 2
	note E_, 2
	note F#, 2
	rest 2
	note D#, 2
	note E_, 2
	note F#, 2
	sound_ret

Music_ViridianCity_Ch4::
	toggle_noise 0

Music_ViridianCity_branch_ec464::
	drum_speed 12
	sound_call Music_ViridianCity_branch_ec49f

Music_ViridianCity_branch_ec469::
	sound_call Music_ViridianCity_branch_ec49f
	sound_call Music_ViridianCity_branch_ec4a7
	sound_call Music_ViridianCity_branch_ec4a7
	sound_loop 2, Music_ViridianCity_branch_ec469
	sound_call Music_ViridianCity_branch_ec49f
	sound_call Music_ViridianCity_branch_ec4b5
	sound_call Music_ViridianCity_branch_ec4ae
	drum_note 6, 6
	drum_note 6, 6
	drum_note 7, 4
	sound_call Music_ViridianCity_branch_ec4bd
	sound_call Music_ViridianCity_branch_ec4b5
	sound_call Music_ViridianCity_branch_ec4ae
	sound_call Music_ViridianCity_branch_ec4bd
	sound_call Music_ViridianCity_branch_ec4ae
	drum_note 6, 6
	drum_note 6, 6
	drum_note 7, 2
	drum_note 6, 2
	drum_note 6, 6
	drum_note 6, 6
	drum_note 6, 4
	drum_note 6, 6
	drum_note 8, 6
	drum_note 8, 4
	sound_loop 0, Music_ViridianCity_branch_ec464

Music_ViridianCity_branch_ec49f::
	drum_note 8, 6
	drum_note 8, 6
	drum_note 8, 4
	drum_note 8, 6
	drum_note 8, 6
	drum_note 8, 2
	drum_note 8, 2
	sound_ret

Music_ViridianCity_branch_ec4a7::
	drum_note 8, 6
	drum_note 8, 6
	drum_note 8, 4
	drum_note 8, 6
	drum_note 8, 6
	drum_note 8, 4
	sound_ret

Music_ViridianCity_branch_ec4ae::
	drum_note 6, 6
	drum_note 6, 6
	drum_note 7, 4
	drum_note 6, 6
	drum_note 6, 6
	drum_note 7, 4
	sound_ret

Music_ViridianCity_branch_ec4b5::
	drum_note 6, 6
	drum_note 6, 6
	drum_note 7, 4
	drum_note 6, 6
	drum_note 6, 6
	drum_note 7, 2
	drum_note 6, 2
	sound_ret

Music_ViridianCity_branch_ec4bd::
	drum_note 6, 6
	drum_note 6, 6
	drum_note 7, 2
	drum_note 7, 2
	sound_ret
