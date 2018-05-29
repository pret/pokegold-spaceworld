; serial

ESTABLISH_CONNECTION_WITH_INTERNAL_CLOCK EQU $01
ESTABLISH_CONNECTION_WITH_EXTERNAL_CLOCK EQU $02

USING_EXTERNAL_CLOCK       EQU $01
USING_INTERNAL_CLOCK       EQU $02
CONNECTION_NOT_ESTABLISHED EQU $ff

; signals the start of an array of bytes transferred over the link cable
SERIAL_PREAMBLE_BYTE EQU $FD

; this byte is used when there is no data to send
SERIAL_NO_DATA_BYTE EQU $FE

; signals the end of one part of a patch list (there are two parts) for player/enemy party data
SERIAL_PATCH_LIST_PART_TERMINATOR EQU $FF
