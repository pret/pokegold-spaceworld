INCLUDE "constants.asm"

SECTION "audio/songs/nidorinointro.asm", ROMX

Music_NidorinoIntro::
	channel_count 4
	channel 1, Music_NidorinoIntro_Ch1
	channel 2, Music_NidorinoIntro_Ch2
	channel 3, Music_NidorinoIntro_Ch3
	channel 4, Music_NidorinoIntro_Ch4

Music_NidorinoIntro_Ch1::
	tempo 102
	volume 7, 7
	duty_cycle 3
	vibrato 6, 3, 4
	pitch_offset 1
	note_type 12, 11, 1
	rest 8
	octave 2
	note A_, 2
	note A_, 2
	note_type 12, 11, 4
	octave 3
	note D_, 4
	note_type 12, 11, 1
	octave 2
	note A_, 2
	note A_, 2
	note_type 12, 11, 4
	octave 3
	note D#, 4
	note_type 12, 11, 1
	octave 2
	note A_, 2
	note A_, 2
	note_type 12, 11, 4
	octave 3
	note D_, 4
	note_type 12, 11, 1
	octave 2
	note A_, 2
	note A_, 2
	note_type 12, 10, 0
	note A#, 4
	note_type 12, 11, 1
	note A_, 2
	note A_, 2
	note_type 12, 11, 4
	octave 3
	note D_, 4
	note_type 12, 11, 1
	octave 2
	note A_, 2
	note A_, 2
	note_type 12, 2, 9
	octave 3
	note G_, 4
	note_type 12, 11, 0
	note A_, 8
	octave 2
	note A_, 8
	note_type 12, 11, 7
	octave 3
	note F_, 8
	note_type 12, 4, 15
	octave 2
	note F_, 8
	note_type 12, 11, 1
	note A_, 2
	note A_, 2
	note_type 12, 11, 4
	octave 3
	note D_, 4
	note_type 12, 11, 1
	octave 2
	note A_, 2
	note A_, 2
	note_type 12, 11, 4
	octave 3
	note D#, 4
	note_type 12, 11, 1
	octave 2
	note A_, 2
	note A_, 2
	note_type 12, 11, 4
	octave 3
	note F_, 4
	note_type 12, 11, 1
	octave 2
	note A_, 2
	note A_, 2
	note_type 12, 11, 4
	octave 3
	note G_, 4
	note_type 12, 11, 0
	note F#, 16
	note_type 12, 11, 1
	octave 4
	note D_, 16
	sound_ret


Music_NidorinoIntro_Ch2::
	duty_cycle 3
	vibrato 8, 2, 5
	note_type 12, 12, 2
	rest 8
	octave 3
	note D_, 2
	note D_, 2
	note_type 12, 12, 5
	note A_, 4
	note_type 12, 12, 2
	note D_, 2
	note D_, 2
	note_type 12, 12, 5
	note A#, 4
	note_type 12, 12, 2
	note D_, 2
	note D_, 2
	note_type 12, 12, 5
	note A_, 4
	note_type 12, 12, 2
	note D_, 2
	note D_, 2
	note_type 12, 11, 7
	note C#, 4
	note_type 12, 12, 2
	note D_, 2
	note D_, 2
	note_type 12, 12, 5
	note A_, 4
	note_type 12, 12, 2
	octave 3
	note D_, 2
	note D_, 2
	note_type 12, 12, 7
	octave 4
	note C#, 4
	note D_, 8
	octave 3
	note D_, 8
	octave 4
	note C_, 8
	octave 3
	note C_, 8
	note_type 12, 12, 2
	note D_, 2
	note D_, 2
	note_type 12, 12, 5
	note A_, 4
	note_type 12, 12, 2
	note D_, 2
	note D_, 2
	note_type 12, 12, 5
	note A#, 4
	note_type 12, 12, 2
	note D_, 2
	note D_, 2
	note_type 12, 12, 5
	octave 4
	note C_, 4
	note_type 12, 12, 2
	octave 3
	note D_, 2
	note D_, 2
	note_type 12, 12, 5
	octave 4
	note C#, 4
	note_type 12, 2, 15
	note D_, 16
	note_type 12, 12, 1
	octave 5
	note D_, 16
	sound_ret


Music_NidorinoIntro_Ch3::
	note_type 12, 1, 0
	rest 8
	octave 4
	note D_, 1
	rest 1
	note D_, 1
	rest 1
	note A_, 4
	note D_, 1
	rest 1
	note D_, 1
	rest 1
	note A_, 4
	note D_, 1
	rest 1
	note D_, 1
	rest 1
	note A_, 4
	note D_, 1
	rest 1
	note D_, 1
	rest 1
	note F#, 4
	note D_, 1
	rest 1
	note D_, 1
	rest 1
	note A_, 4
	note D_, 1
	rest 1
	note D_, 1
	rest 1
	note A#, 4
	note A_, 8
	note D_, 8
	note A#, 8
	note D_, 8
	note D_, 1
	rest 1
	note D_, 1
	rest 1
	note A_, 4
	note D_, 1
	rest 1
	note D_, 1
	rest 1
	note A_, 4
	note D_, 1
	rest 1
	note D_, 1
	rest 1
	note A#, 4
	note D_, 1
	rest 1
	note D_, 1
	rest 1
	note A#, 4
	note A_, 16
	note D_, 1
	rest 15
	sound_ret


Music_NidorinoIntro_Ch4::
    toggle_noise 2
	drum_speed 6
	drum_note 4, 1
	drum_note 4, 1
	drum_note 4, 1
	drum_note 4, 1
	drum_note 3, 1
	drum_note 4, 1
	drum_note 3, 1
	drum_note 4, 1
	drum_note 3, 1
	drum_note 4, 1
	drum_note 3, 1
	drum_note 3, 1
	drum_note 3, 1
	drum_note 3, 1
	drum_note 2, 1
	drum_note 2, 1
	drum_note 2, 4
	drum_note 2, 4
	drum_note 4, 1
	drum_note 4, 1
	drum_note 4, 1
	drum_note 4, 1
	drum_note 3, 1
	drum_note 3, 1
	drum_note 3, 1
	drum_note 3, 1
	drum_note 2, 4
	drum_note 2, 4
	drum_note 2, 8
	drum_note 2, 4
	drum_note 2, 4
	drum_note 2, 8
	drum_note 2, 4
	drum_note 2, 4
	drum_note 4, 1
	drum_note 4, 1
	drum_note 4, 1
	drum_note 4, 1
	drum_note 3, 1
	drum_note 3, 1
	drum_note 3, 1
	drum_note 3, 1
	drum_note 2, 4
	drum_note 2, 4
	drum_note 2, 8
	drum_note 2, 4
	drum_note 2, 4
	drum_note 2, 4
	drum_note 4, 1
	drum_note 4, 1
	drum_note 3, 1
	drum_note 3, 1
	drum_note 2, 16
	drum_note 2, 16
	drum_note 2, 16
	drum_note 4, 1
	drum_note 4, 1
	drum_note 4, 1
	drum_note 4, 1
	drum_note 3, 1
	drum_note 4, 1
	drum_note 3, 1
	drum_note 4, 1
	drum_note 3, 1
	drum_note 3, 1
	drum_note 3, 1
	drum_note 3, 1
	drum_note 2, 1
	drum_note 2, 1
	drum_note 2, 1
	drum_note 2, 1
	drum_note 2, 4
	drum_note 2, 4
	drum_note 2, 8
	drum_note 2, 4
	drum_note 2, 4
	drum_note 4, 1
	drum_note 4, 1
	drum_note 4, 1
	drum_note 4, 1
	drum_note 3, 1
	drum_note 3, 1
	drum_note 3, 1
	drum_note 3, 1
	drum_note 2, 4
	drum_note 2, 4
	drum_note 2, 8
	drum_note 2, 4
	drum_note 2, 8
	drum_note 2, 4
	drum_note 2, 16
	drum_note 2, 16
	drum_note 2, 2
	rest 16
	rest 14
	sound_ret
