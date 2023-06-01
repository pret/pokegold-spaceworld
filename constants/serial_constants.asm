; serial

DEF ESTABLISH_CONNECTION_WITH_INTERNAL_CLOCK EQU $01
DEF ESTABLISH_CONNECTION_WITH_EXTERNAL_CLOCK EQU $02

DEF USING_EXTERNAL_CLOCK       EQU $01
DEF USING_INTERNAL_CLOCK       EQU $02
DEF CONNECTION_NOT_ESTABLISHED EQU $ff

; signals the start of an array of bytes transferred over the link cable
DEF SERIAL_PREAMBLE_BYTE EQU $FD

; this byte is used when there is no data to send
DEF SERIAL_NO_DATA_BYTE EQU $FE

; signals the end of one part of a patch list (there are two parts) for player/enemy party data
DEF SERIAL_PATCH_LIST_PART_TERMINATOR EQU $FF
