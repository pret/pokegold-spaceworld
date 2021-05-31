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
mon_cry: MACRO
; index, pitch, length
	dw \1, \2, \3
ENDM
Cries::
	mon_cry    17,     0,   256
	mon_cry     3,     0,   256
	mon_cry     0,     0,   256
	mon_cry    25,   204,   129
	mon_cry    16,     0,   256
	mon_cry     6,   237,   256
	mon_cry     9,     0,   256
	mon_cry    31,     0,   256
	mon_cry    15,    32,   256
	mon_cry    13,     0,   256
	mon_cry    12,     0,   256
	mon_cry    11,     0,   256
	mon_cry     5,     0,   256
	mon_cry     7,     0,   383
	mon_cry     1,     0,   256
	mon_cry    10,     0,   256
	mon_cry    25,     0,   256
	mon_cry     4,     0,   256
	mon_cry    27,     0,   256
	mon_cry    21,     0,   256
	mon_cry    30,   238,   383
	mon_cry    23,     0,   256
	mon_cry    24,     0,   256
	mon_cry    26,     0,   256
	mon_cry    28,     0,   256
	mon_cry    22,     0,   256
	mon_cry    30,     2,   160
	mon_cry    19,     0,   256
	mon_cry    20,     0,   256
	mon_cry    18,     0,   256
	mon_cry     0,     0,     0
	mon_cry     0,     0,     0
	mon_cry    31,    32,   192
	mon_cry    23,   255,   320
	mon_cry    24,    64,   288
	mon_cry    14,   223,   132
	mon_cry     2,     0,   256
	mon_cry    28,   168,   320
	mon_cry    36,     0,   256
	mon_cry    20,    10,   320
	mon_cry    31,    72,   224
	mon_cry    32,     8,   192
	mon_cry    18,   128,   320
	mon_cry    12,   238,   320
	mon_cry    23,   224,   144
	mon_cry    30,    66,   383
	mon_cry    33,    32,   224
	mon_cry    13,   136,   160
	mon_cry    18,   224,   192
	mon_cry     0,     0,     0
	mon_cry     4,   255,   176
	mon_cry     0,     0,     0
	mon_cry     6,   143,   383
	mon_cry    28,    32,   320
	mon_cry    18,   230,   349
	mon_cry     0,     0,     0
	mon_cry    10,   221,   224
	mon_cry    12,   136,   320
	mon_cry    11,   170,   129
	mon_cry    29,    17,   192
	mon_cry     0,     0,     0
	mon_cry     0,     0,     0
	mon_cry     0,     0,     0
	mon_cry    16,   221,   129
	mon_cry    26,    68,   192
	mon_cry    15,    60,   320
	mon_cry     0,   128,    16
	mon_cry     0,     0,     0
	mon_cry    29,   224,     0
	mon_cry    11,   187,   129
	mon_cry    14,   255,   383
	mon_cry    13,   255,   383
	mon_cry     9,   248,   192
	mon_cry     9,   128,   192
	mon_cry    24,   255,   256
	mon_cry    14,   255,   383
	mon_cry    25,   119,   144
	mon_cry    32,    32,   352
	mon_cry    34,   255,    64
	mon_cry     0,     0,     0
	mon_cry    14,   224,    96
	mon_cry    36,    79,   144
	mon_cry    36,   136,   224
	mon_cry    15,   238,   129
	mon_cry     9,   238,   136
	mon_cry     0,     0,     0
	mon_cry     0,     0,     0
	mon_cry    15,    96,   192
	mon_cry    15,    64,   256
	mon_cry    22,   187,   192
	mon_cry    24,   238,   129
	mon_cry    25,   153,   144
	mon_cry    25,    60,   129
	mon_cry    15,    64,   192
	mon_cry    15,    32,   192
	mon_cry     0,    32,   192
	mon_cry     0,   255,   383
	mon_cry    31,   240,   129
	mon_cry    31,   255,   192
	mon_cry    14,   255,   181
	mon_cry    14,   104,   224
	mon_cry    26,   136,   224
	mon_cry    26,    16,   160
	mon_cry    26,    61,   256
	mon_cry    26,   170,   383
	mon_cry    31,   238,   129
	mon_cry    29,   224,   256
	mon_cry    23,    18,   192
	mon_cry    30,    32,   352
	mon_cry    14,   119,   224
	mon_cry    14,     0,   383
	mon_cry    21,   238,   129
	mon_cry    19,   255,   129
	mon_cry    19,    96,   256
	mon_cry     0,     0,     0
	mon_cry    11,   153,   160
	mon_cry    10,   175,   192
	mon_cry    11,    42,   144
	mon_cry    26,    41,   256
	mon_cry    12,    35,   383
	mon_cry     0,     0,     0
	mon_cry     0,     0,     0
	mon_cry    22,   128,   160
	mon_cry    28,   204,   129
	mon_cry    22,   119,   192
	mon_cry    31,     8,   320
	mon_cry    17,    32,    16
	mon_cry    33,   255,   192
	mon_cry    13,   238,   192
	mon_cry    29,   250,   256
	mon_cry    30,   153,   383
	mon_cry     5,    85,   129
	mon_cry    23,   128,   128
	mon_cry     0,     0,     0
	mon_cry     0,     0,     0
	mon_cry     7,   239,   383
	mon_cry    15,    64,     0
	mon_cry    32,   238,   352
	mon_cry    24,   111,   352
	mon_cry     0,     0,     0
	mon_cry     6,   168,   272
	mon_cry    25,   170,   160
	mon_cry    18,   255,   383
	mon_cry    25,   153,   383
	mon_cry     8,    79,   224
	mon_cry     0,     0,     0
	mon_cry    28,    48,   192
	mon_cry    28,   192,   129
	mon_cry    28,   152,   383
	mon_cry    20,    40,   320
	mon_cry    20,    17,   383
	mon_cry    30,     0,   256
	mon_cry    15,   128,   129
	mon_cry    15,     0,   320
	mon_cry    26,   238,   383
	mon_cry     0,     0,     0
	mon_cry    22,   128,   192
	mon_cry    22,    16,   383
	mon_cry     0,     0,     0
	mon_cry     0,     0,     0
	mon_cry     0,     0,     0
	mon_cry     0,     0,     0
	mon_cry    37,     0,   256
	mon_cry    37,    32,   320
	mon_cry    34,     0,   256
	mon_cry    34,    32,   383
	mon_cry     0,    44,   320
	mon_cry     1,    44,   352
	mon_cry    36,   240,   144
	mon_cry    37,   170,   383
	mon_cry    35,    32,   368
	mon_cry     0,     0,     0
	mon_cry    28,   128,   224
	mon_cry     0,     0,     0
	mon_cry     0,     0,     0
	mon_cry     4,    96,   192
	mon_cry    29,    96,   192
	mon_cry     4,    32,   192
	mon_cry    29,    32,   192
	mon_cry     4,     0,   256
	mon_cry    29,     0,     0
	mon_cry     0,     0,     0
	mon_cry     0,     0,     0
	mon_cry     0,     0,     0
	mon_cry     8,   221,   129
	mon_cry     8,   170,   192
	mon_cry    35,    34,   383
	mon_cry    33,    85,   129
	mon_cry    37,    68,   160
	mon_cry    37,   102,   332
	mon_cry     0,     0,   256
	mon_cry     0,     0,   256
	mon_cry     0,     0,   256
	mon_cry     0,     0,   256
	mon_cry     0,     0,   256
	mon_cry     0,     0,   256
	mon_cry     0,     0,   256
	mon_cry     0,     0,   256
	mon_cry     0,     0,   256
	mon_cry     0,     0,   256
	mon_cry     0,     0,   256
	mon_cry     0,     0,   256
	mon_cry     0,     0,   256
	mon_cry     0,     0,   256
	mon_cry     0,     0,   256
	mon_cry     0,     0,   256
	mon_cry     0,     0,   256
	mon_cry     0,     0,   256
	mon_cry     0,     0,   256
	mon_cry     0,     0,   256
	mon_cry     0,     0,   256
	mon_cry     0,     0,   256
	mon_cry     0,     0,   256
	mon_cry     0,     0,   256
	mon_cry     0,     0,   256
	mon_cry     0,     0,   256
	mon_cry     0,     0,   256
	mon_cry     0,     0,   256
	mon_cry     0,     0,   256
	mon_cry     0,     0,   256
	mon_cry     0,     0,   256
	mon_cry     0,     0,   256
	mon_cry     0,     0,   256
	mon_cry     0,     0,   256
	mon_cry     0,     0,   256
	mon_cry     0,     0,   256
	mon_cry     0,     0,   256
	mon_cry     0,     0,   256
	mon_cry     0,     0,   256
	mon_cry     0,     0,   256
	mon_cry     0,     0,   256
	mon_cry     0,     0,   256
	mon_cry     0,     0,   256
	mon_cry     0,     0,   256
	mon_cry     0,     0,   256
	mon_cry     0,     0,   256
	mon_cry     0,     0,   256
	mon_cry     0,     0,   256
	mon_cry     0,     0,   256
	mon_cry     0,     0,   256
	mon_cry     0,     0,   256
	mon_cry     0,     0,   256
	mon_cry     0,     0,   256
	mon_cry     0,     0,   256
	mon_cry     0,     0,   256
	mon_cry     0,     0,   256
	mon_cry     0,     0,   256
	mon_cry     0,     0,   256
	mon_cry     0,     0,   256
	mon_cry     0,     0,   256
	mon_cry     0,     0,   256
	mon_cry     0,     0,   256
	mon_cry     0,     0,   256
	mon_cry     0,     0,   256
	mon_cry     0,     0,   256

SECTION "audio/cries.asm@CryHeaders", ROMX
CryHeader_f17c5:
	channel_count 3
	channel 5, cry_f1bbf
	channel 6, cry_f1bce
	channel 8, cry_f1bdd

CryHeader_f17ce:
	channel_count 3
	channel 5, cry_f1dcf
	channel 6, cry_f1de2
	channel 8, cry_f1df5

CryHeader_f17d7:
	channel_count 3
	channel 5, cry_f1d44
	channel 6, cry_f1d53
	channel 8, cry_f1d61

CryHeader_f17e0:
	channel_count 3
	channel 5, cry_f1ade
	channel 6, cry_f1afd
	channel 8, cry_f1b1c

CryHeader_f17e9:
	channel_count 3
	channel 5, cry_f1e8d
	channel 6, cry_f1eac
	channel 8, cry_f1ecb

CryHeader_f17f2:
	channel_count 3
	channel 5, cry_f1c6d
	channel 6, cry_f1c80
	channel 8, cry_f1c92

CryHeader_f17fb:
	channel_count 3
	channel 5, cry_f1c17
	channel 6, cry_f1c31
	channel 8, cry_f1c32

CryHeader_f1804:
	channel_count 3
	channel 5, cry_f1c45
	channel 6, cry_f1c54
	channel 8, cry_f1c63

CryHeader_f180d:
	channel_count 3
	channel 5, cry_f1e5d
	channel 6, cry_f1e70
	channel 8, cry_f1e83

CryHeader_f1816:
	channel_count 3
	channel 5, cry_f1967
	channel 6, cry_f1984
	channel 8, cry_f19a5

CryHeader_f181f:
	channel_count 3
	channel 5, cry_f1e02
	channel 6, cry_f1e21
	channel 8, cry_f1e44

CryHeader_f1828:
	channel_count 3
	channel 5, cry_f1c93
	channel 6, cry_f1cbe
	channel 8, cry_f1cdd

CryHeader_f1831:
	channel_count 3
	channel 5, cry_f1cf6
	channel 6, cry_f1d1d
	channel 8, cry_f1d43

CryHeader_f183a:
	channel_count 3
	channel 5, cry_f1d62
	channel 6, cry_f1d81
	channel 8, cry_f1db0

CryHeader_f1843:
	channel_count 3
	channel 5, cry_f1be7
	channel 6, cry_f1bfa
	channel 8, cry_f1c0d

CryHeader_f184c:
	channel_count 3
	channel 5, cry_f1b29
	channel 6, cry_f1b44
	channel 8, cry_f1b5f

CryHeader_f1855:
	channel_count 3
	channel 5, cry_f1b6f
	channel 6, cry_f1b92
	channel 8, cry_f1bb5

CryHeader_f185e:
	channel_count 3
	channel 5, cry_f1a4b
	channel 6, cry_f1a6a
	channel 8, cry_f1a8d

CryHeader_f1867:
	channel_count 3
	channel 5, cry_f1f63
	channel 6, cry_f1f76
	channel 8, cry_f1f89

CryHeader_f1870:
	channel_count 3
	channel 5, cry_f1f96
	channel 6, cry_f1fb1
	channel 8, cry_f1fcc

CryHeader_f1879:
	channel_count 3
	channel 5, cry_f1fdf
	channel 6, cry_f1fee
	channel 8, cry_f1ffd

CryHeader_f1882:
	channel_count 3
	channel 5, cry_f206d
	channel 6, cry_f2088
	channel 8, cry_f20a3

CryHeader_f188b:
	channel_count 3
	channel 5, cry_f1f00
	channel 6, cry_f1f0f
	channel 8, cry_f1f1e

CryHeader_f1894:
	channel_count 3
	channel 5, cry_f20b6
	channel 6, cry_f20c9
	channel 8, cry_f20dc

CryHeader_f189d:
	channel_count 3
	channel 5, cry_f21c6
	channel 6, cry_f21e9
	channel 8, cry_f220c

CryHeader_f18a6:
	channel_count 3
	channel 5, cry_f1ede
	channel 6, cry_f1eed
	channel 8, cry_f1eff

CryHeader_f18af:
	channel_count 3
	channel 5, cry_f2137
	channel 6, cry_f2152
	channel 8, cry_f216d

CryHeader_f18b8:
	channel_count 3
	channel 5, cry_f1f28
	channel 6, cry_f1f3f
	channel 8, cry_f1f56

CryHeader_f18c1:
	channel_count 3
	channel 5, cry_f20e9
	channel 6, cry_f210c
	channel 8, cry_f2127

CryHeader_f18ca:
	channel_count 3
	channel 5, cry_f2180
	channel 6, cry_f219b
	channel 8, cry_f21b6

CryHeader_f18d3:
	channel_count 3
	channel 5, cry_f2007
	channel 6, cry_f202a
	channel 8, cry_f2051

CryHeader_f18dc:
	channel_count 3
	channel 5, cry_f221f
	channel 6, cry_f2232
	channel 8, cry_f2245

CryHeader_f18e5:
	channel_count 3
	channel 5, cry_f2252
	channel 6, cry_f2265
	channel 8, cry_f2278

CryHeader_f18ee:
	channel_count 3
	channel 5, cry_f2285
	channel 6, cry_f22a8
	channel 8, cry_f22ca

CryHeader_f18f7:
	channel_count 3
	channel 5, cry_f22cb
	channel 6, cry_f22de
	channel 8, cry_f22f1

CryHeader_f1900:
	channel_count 3
	channel 5, cry_f19be
	channel 6, cry_f19d5
	channel 8, cry_f19e8

CryHeader_f1909:
	channel_count 3
	channel 5, cry_f19f5
	channel 6, cry_f1a18
	channel 8, cry_f1a3b

CryHeader_f1912:
	channel_count 3
	channel 5, cry_f1aa3
	channel 6, cry_f1aba
	channel 8, cry_f1ad1

cry_f191b: ; unreferenced
	duty_cycle_pattern 3, 3, 0, 0
	square_note 15, 14, 0, 1920
	square_note 15, 15, 0, 1924
	square_note 15, 12, 3, 1504
	square_note 15, 12, 4, 1536
	square_note 10, 6, -4, 1920
	square_note 8, 7, 1, 1924
	sound_ret

cry_f1936: ; unreferenced
	duty_cycle_pattern 0, 0, 1, 1
	square_note 15, 10, 0, 1857
	square_note 15, 11, 0, 1859
	square_note 15, 9, 3, 1457
	square_note 15, 9, 4, 1473
	square_note 10, 4, -4, 1857
	square_note 8, 3, 1, 1862
	sound_ret

cry_f1951: ; unreferenced
	noise_note 2, 15, 2, 76
	noise_note 6, 14, 0, 58
	noise_note 15, 13, 0, 58
	noise_note 8, 13, 0, 44
	noise_note 6, 14, 6, 76
	noise_note 12, 7, -5, 76
	noise_note 15, 13, 3, 76
	sound_ret

cry_f1967:
	duty_cycle_pattern 3, 3, 0, 0
	square_note 15, 15, 7, 1952
	square_note 6, 14, 6, 1955
	square_note 10, 15, 4, 1952
	duty_cycle_pattern 2, 2, 1, 1
	square_note 10, 15, 6, 2008
	square_note 4, 14, 3, 2007
	square_note 15, 15, 2, 2008
	sound_ret

cry_f1984:
	duty_cycle_pattern 0, 0, 1, 1
	square_note 2, 0, 8, 0
	square_note 15, 10, 7, 1697
	square_note 6, 8, 6, 1698
	square_note 10, 7, 4, 1697
	duty_cycle_pattern 1, 1, 3, 3
	square_note 10, 7, 6, 1750
	square_note 4, 8, 3, 1753
	square_note 15, 10, 2, 1751
	sound_ret

cry_f19a5:
	noise_note 2, 15, 2, 60
	noise_note 8, 14, 4, 62
	noise_note 15, 13, 7, 60
	noise_note 6, 12, 5, 59
	noise_note 6, 14, 4, 61
	noise_note 8, 11, 6, 60
	noise_note 6, 13, 4, 61
	noise_note 8, 12, 1, 59
	sound_ret

cry_f19be:
	duty_cycle_pattern 3, 3, 0, 0
	square_note 15, 15, 7, 1984
	square_note 6, 14, 4, 1985
	square_note 10, 15, 6, 1984
	square_note 4, 13, 3, 1986
	square_note 8, 12, 1, 1984
	sound_ret

cry_f19d5:
	duty_cycle_pattern 1, 1, 3, 3
	square_note 15, 9, 7, 1921
	square_note 6, 8, 4, 1920
	square_note 10, 9, 6, 1921
	square_note 15, 8, 3, 1921
	sound_ret

cry_f19e8:
	noise_note 3, 15, 2, 60
	noise_note 13, 14, 6, 44
	noise_note 15, 13, 7, 60
	noise_note 8, 12, 1, 44
	sound_ret

cry_f19f5:
	duty_cycle_pattern 3, 3, 0, 0
	square_note 15, 15, 7, 1664
	square_note 10, 14, 6, 1668
	square_note 15, 13, 7, 1680
	square_note 8, 13, 5, 1680
	square_note 6, 12, 4, 1672
	square_note 5, 13, 3, 1648
	square_note 4, 13, 3, 1632
	square_note 8, 12, 1, 1600
	sound_ret

cry_f1a18:
	duty_cycle_pattern 0, 0, 1, 1
	square_note 15, 11, 7, 1601
	square_note 10, 9, 6, 1602
	square_note 15, 10, 7, 1617
	square_note 8, 10, 5, 1617
	square_note 6, 9, 4, 1607
	square_note 5, 10, 3, 1585
	square_note 4, 9, 3, 1570
	square_note 8, 7, 1, 1537
	sound_ret

cry_f1a3b:
	noise_note 15, 14, 4, 60
	noise_note 10, 12, 7, 76
	noise_note 10, 12, 7, 60
	noise_note 12, 11, 7, 76
	noise_note 15, 10, 2, 92
	sound_ret

cry_f1a4b:
	duty_cycle_pattern 3, 3, 0, 0
	square_note 6, 15, 7, 1952
	square_note 8, 14, 6, 1956
	square_note 4, 13, 6, 1952
	square_note 15, 13, 3, 1824
	square_note 8, 12, 3, 1827
	square_note 2, 12, 2, 1832
	square_note 8, 11, 1, 1840
	sound_ret

cry_f1a6a:
	duty_cycle_pattern 0, 0, 2, 2
	square_note 4, 0, 8, 0
	square_note 6, 10, 7, 1857
	square_note 8, 8, 6, 1859
	square_note 4, 7, 6, 1857
	square_note 13, 8, 3, 1730
	square_note 7, 7, 3, 1729
	square_note 3, 8, 2, 1740
	square_note 8, 7, 1, 1752
	sound_ret

cry_f1a8d:
	noise_note 2, 15, 2, 76
	noise_note 6, 14, 6, 58
	noise_note 4, 13, 7, 58
	noise_note 6, 13, 6, 44
	noise_note 8, 14, 5, 60
	noise_note 12, 13, 2, 61
	noise_note 8, 13, 1, 44
	sound_ret

cry_f1aa3:
	duty_cycle_pattern 2, 2, 1, 1
	square_note 6, 15, 4, 1856
	square_note 15, 14, 3, 1840
	square_note 4, 15, 4, 1856
	square_note 5, 11, 3, 1864
	square_note 8, 13, 1, 1872
	sound_ret

cry_f1aba:
	duty_cycle_pattern 1, 3, 1, 3
	square_note 6, 12, 3, 1810
	square_note 15, 11, 3, 1796
	square_note 3, 12, 3, 1810
	square_note 4, 12, 3, 1825
	square_note 8, 11, 1, 1842
	sound_ret

cry_f1ad1:
	noise_note 8, 13, 6, 44
	noise_note 12, 12, 6, 60
	noise_note 10, 11, 6, 44
	noise_note 8, 9, 1, 28
	sound_ret

cry_f1ade:
	duty_cycle_pattern 3, 3, 0, 0
	square_note 4, 15, 7, 1544
	square_note 6, 14, 6, 1536
	square_note 6, 13, 7, 1520
	square_note 6, 12, 4, 1504
	square_note 5, 13, 3, 1472
	square_note 4, 13, 3, 1440
	square_note 8, 14, 1, 1408
	sound_ret

cry_f1afd:
	duty_cycle_pattern 0, 0, 2, 2
	square_note 4, 12, 7, 1284
	square_note 6, 10, 6, 1282
	square_note 6, 9, 7, 1265
	square_note 4, 11, 4, 1249
	square_note 5, 10, 3, 1218
	square_note 4, 11, 3, 1187
	square_note 8, 12, 1, 1154
	sound_ret

cry_f1b1c:
	noise_note 12, 14, 4, 76
	noise_note 10, 12, 7, 92
	noise_note 12, 11, 6, 76
	noise_note 15, 10, 2, 92
	sound_ret

cry_f1b29:
	duty_cycle_pattern 3, 3, 0, 1
	square_note 4, 15, 7, 1984
	square_note 12, 14, 6, 1986
	square_note 6, 11, 5, 1664
	square_note 4, 12, 4, 1648
	square_note 4, 11, 5, 1632
	square_note 8, 12, 1, 1600
	sound_ret

cry_f1b44:
	duty_cycle_pattern 3, 0, 3, 0
	square_note 3, 12, 7, 1921
	square_note 12, 11, 6, 1920
	square_note 6, 10, 5, 1601
	square_note 4, 12, 4, 1586
	square_note 6, 11, 5, 1569
	square_note 8, 10, 1, 1538
	sound_ret

cry_f1b5f:
	noise_note 3, 14, 4, 60
	noise_note 12, 13, 6, 44
	noise_note 4, 14, 4, 60
	noise_note 8, 11, 7, 92
	noise_note 15, 12, 2, 93
	sound_ret

cry_f1b6f:
	duty_cycle_pattern 3, 0, 2, 1
	square_note 8, 15, 7, 1664
	square_note 2, 15, 7, 1632
	square_note 1, 14, 7, 1600
	square_note 1, 14, 7, 1568
	square_note 15, 13, 1, 1536
	square_note 4, 12, 7, 1856
	square_note 4, 10, 7, 1840
	square_note 15, 9, 1, 1824
	sound_ret

cry_f1b92:
	duty_cycle_pattern 1, 3, 2, 1
	square_note 10, 14, 7, 1666
	square_note 2, 14, 7, 1634
	square_note 1, 13, 7, 1602
	square_note 1, 13, 7, 1570
	square_note 15, 12, 1, 1538
	square_note 4, 11, 7, 1858
	square_note 2, 9, 7, 1842
	square_note 15, 8, 1, 1826
	sound_ret

cry_f1bb5:
	noise_note 4, 7, 4, 33
	noise_note 4, 7, 4, 16
	noise_note 4, 7, 1, 32
	sound_ret

cry_f1bbf:
	duty_cycle_pattern 3, 3, 1, 1
	square_note 4, 15, 3, 1816
	square_note 15, 14, 5, 1944
	square_note 8, 9, 1, 1880
	sound_ret

cry_f1bce:
	duty_cycle_pattern 2, 2, 0, 0
	square_note 5, 11, 3, 1800
	square_note 15, 12, 5, 1928
	square_note 8, 7, 1, 1864
	sound_ret

cry_f1bdd:
	noise_note 3, 10, 1, 28
	noise_note 14, 9, 4, 44
	noise_note 8, 8, 1, 28
	sound_ret

cry_f1be7:
	duty_cycle_pattern 2, 2, 1, 1
	square_note 4, 14, 1, 1792
	square_note 4, 15, 2, 1920
	square_note 2, 9, 2, 1856
	square_note 8, 14, 1, 1536
	sound_ret

cry_f1bfa:
	duty_cycle_pattern 0, 0, 2, 2
	square_note 4, 11, 1, 1761
	square_note 3, 12, 2, 1761
	square_note 3, 6, 2, 1665
	square_note 8, 11, 1, 1505
	sound_ret

cry_f1c0d:
	noise_note 2, 6, 1, 50
	noise_note 2, 6, 1, 33
	noise_note 8, 6, 1, 17
	sound_ret

cry_f1c17:
	duty_cycle_pattern 3, 3, 2, 2
	square_note 6, 8, 3, 583
	square_note 15, 6, 2, 550
	square_note 4, 5, 2, 581
	square_note 9, 6, 3, 518
	square_note 15, 8, 2, 549
	square_note 15, 4, 2, 519

cry_f1c31:
	sound_ret

cry_f1c32:
	noise_note 8, 13, 4, 140
	noise_note 4, 14, 2, 156
	noise_note 15, 12, 6, 140
	noise_note 8, 14, 4, 172
	noise_note 15, 13, 7, 156
	noise_note 15, 15, 2, 172
	sound_ret

cry_f1c45:
	duty_cycle_pattern 3, 3, 0, 0
	square_note 4, 15, 3, 1760
	square_note 15, 14, 4, 1600
	square_note 8, 12, 1, 1568
	sound_ret

cry_f1c54:
	duty_cycle_pattern 0, 0, 2, 2
	square_note 3, 12, 3, 1667
	square_note 14, 11, 4, 1538
	square_note 8, 10, 1, 1537
	sound_ret

cry_f1c63:
	noise_note 4, 13, 3, 92
	noise_note 15, 14, 6, 76
	noise_note 8, 11, 1, 92
	sound_ret

cry_f1c6d:
	duty_cycle_pattern 0, 0, 2, 2
	square_note 6, 14, 2, 1280
	square_note 6, 14, 3, 1408
	square_note 6, 13, 3, 1392
	square_note 8, 10, 1, 1376
	sound_ret

cry_f1c80:
	duty_cycle_pattern 3, 3, 1, 1
	square_note 6, 14, 2, 1154
	square_note 6, 13, 3, 1281
	square_note 6, 11, 2, 1250
	square_note 8, 8, 1, 1217

cry_f1c92:
	sound_ret

cry_f1c93:
	duty_cycle_pattern 3, 0, 3, 0
	square_note 4, 15, 1, 1792
	square_note 4, 14, 1, 1920
	square_note 4, 13, 1, 1856
	square_note 4, 14, 1, 1856
	square_note 4, 15, 1, 1920
	square_note 4, 13, 1, 1792
	square_note 4, 15, 1, 1793
	square_note 4, 13, 1, 1922
	square_note 4, 12, 1, 1858
	square_note 8, 11, 1, 1857
	sound_ret

cry_f1cbe:
	duty_cycle_pattern 1, 0, 1, 0
	square_note 12, 0, 8, 0
	square_note 4, 15, 1, 1793
	square_note 4, 14, 1, 1922
	square_note 4, 13, 1, 1857
	square_note 4, 14, 1, 1857
	square_note 4, 15, 1, 1922
	square_note 8, 13, 1, 1793
	sound_ret

cry_f1cdd:
	noise_note 15, 0, 8, 0
	noise_note 4, 0, 8, 0
	noise_note 4, 13, 1, 76
	noise_note 4, 11, 1, 44
	noise_note 4, 13, 1, 60
	noise_note 4, 11, 1, 60
	noise_note 4, 12, 1, 44
	noise_note 8, 10, 1, 76
	sound_ret

cry_f1cf6:
	duty_cycle_pattern 3, 0, 3, 0
	square_note 8, 15, 5, 1536
	square_note 2, 13, 2, 1592
	square_note 2, 12, 2, 1584
	square_note 2, 12, 2, 1576
	square_note 2, 11, 2, 1568
	square_note 2, 11, 2, 1552
	square_note 2, 10, 2, 1560
	square_note 2, 11, 2, 1552
	square_note 8, 12, 1, 1568
	sound_ret

cry_f1d1d:
	duty_cycle_pattern 1, 0, 1, 0
	square_note 12, 12, 3, 1472
	square_note 3, 11, 1, 1529
	square_note 2, 10, 1, 1521
	square_note 2, 10, 1, 1513
	square_note 2, 9, 1, 1505
	square_note 2, 9, 1, 1497
	square_note 2, 8, 1, 1489
	square_note 2, 9, 1, 1497
	square_note 8, 9, 1, 1505

cry_f1d43:
	sound_ret

cry_f1d44:
	duty_cycle_pattern 0, 0, 0, 0
	square_note 8, 15, 5, 1152
	square_note 2, 14, 1, 1504
	square_note 8, 13, 1, 1500
	sound_ret

cry_f1d53:
	duty_cycle_pattern 2, 2, 1, 1
	square_note 7, 9, 5, 1089
	square_note 2, 8, 1, 1313
	square_note 8, 6, 1, 1306

cry_f1d61:
	sound_ret

cry_f1d62:
	duty_cycle_pattern 2, 0, 2, 0
	square_note 5, 15, 2, 1616
	square_note 9, 13, 1, 1632
	square_note 5, 14, 2, 1554
	square_note 9, 12, 1, 1570
	square_note 5, 15, 2, 1552
	square_note 6, 13, 1, 1568
	sound_loop 2, cry_f1d62
	sound_ret

cry_f1d81:
	duty_cycle_pattern 1, 0, 0, 0
	square_note 4, 0, 8, 0
	square_note 5, 15, 2, 1617
	square_note 9, 13, 1, 1633
	square_note 5, 14, 2, 1556
	square_note 8, 12, 1, 1572
	square_note 5, 15, 2, 1553
	square_note 12, 13, 1, 1569
	square_note 5, 14, 2, 1556
	square_note 8, 12, 1, 1572
	square_note 5, 15, 2, 1553
	square_note 4, 13, 1, 1569
	sound_ret

cry_f1db0:
	noise_note 6, 13, 2, 28
	noise_note 9, 11, 1, 44
	noise_note 8, 12, 2, 44
	noise_note 9, 11, 1, 60
	noise_note 6, 12, 2, 44
	noise_note 9, 10, 2, 60
	noise_note 7, 12, 2, 44
	noise_note 5, 10, 1, 60
	noise_note 9, 12, 2, 44
	noise_note 4, 10, 1, 60
	sound_ret

cry_f1dcf:
	duty_cycle_pattern 2, 2, 0, 0
	square_note 4, 15, 3, 1536
	square_note 8, 13, 5, 1888
	square_note 3, 14, 2, 1824
	square_note 8, 13, 1, 1808
	sound_ret

cry_f1de2:
	duty_cycle_pattern 1, 1, 2, 2
	square_note 5, 11, 3, 1777
	square_note 7, 12, 5, 1874
	square_note 3, 10, 2, 1809
	square_note 8, 11, 1, 1537
	sound_ret

cry_f1df5:
	noise_note 3, 10, 2, 60
	noise_note 12, 9, 4, 44
	noise_note 3, 8, 2, 28
	noise_note 8, 7, 1, 44
	sound_ret

cry_f1e02:
	duty_cycle_pattern 3, 3, 0, 0
	square_note 8, 15, 7, 1760
	square_note 6, 14, 6, 1765
	square_note 3, 15, 4, 1760
	square_note 3, 15, 6, 1744
	square_note 3, 14, 3, 1728
	square_note 4, 15, 2, 1712
	square_note 15, 10, 2, 1736
	sound_ret

cry_f1e21:
	duty_cycle_pattern 0, 0, 1, 1
	square_note 3, 0, 8, 0
	square_note 8, 10, 7, 1697
	square_note 6, 8, 6, 1699
	square_note 3, 7, 4, 1697
	square_note 3, 7, 6, 1681
	square_note 3, 8, 3, 1666
	square_note 4, 10, 2, 1649
	square_note 15, 7, 2, 1673
	sound_ret

cry_f1e44:
	noise_note 2, 15, 2, 60
	noise_note 8, 14, 4, 62
	noise_note 8, 13, 7, 60
	noise_note 5, 12, 5, 59
	noise_note 3, 13, 4, 44
	noise_note 2, 11, 6, 60
	noise_note 3, 10, 4, 44
	noise_note 8, 9, 1, 60
	sound_ret

cry_f1e5d:
	duty_cycle_pattern 3, 3, 0, 0
	square_note 15, 15, 6, 1381
	square_note 10, 14, 4, 1404
	square_note 3, 12, 2, 1372
	square_note 15, 11, 2, 1340
	sound_ret

cry_f1e70:
	duty_cycle_pattern 1, 1, 2, 2
	square_note 14, 13, 6, 1283
	square_note 9, 11, 4, 1307
	square_note 4, 9, 2, 1274
	square_note 15, 10, 2, 1243
	sound_ret

cry_f1e83:
	noise_note 12, 14, 6, 76
	noise_note 11, 13, 7, 92
	noise_note 15, 12, 2, 76
	sound_ret

cry_f1e8d:
	duty_cycle_pattern 3, 3, 0, 0
	square_note 4, 15, 7, 1696
	square_note 8, 14, 6, 1700
	square_note 4, 13, 6, 1696
	square_note 12, 13, 3, 1568
	square_note 8, 12, 3, 1572
	square_note 4, 12, 2, 1568
	square_note 8, 11, 1, 1552
	sound_ret

cry_f1eac:
	duty_cycle_pattern 1, 1, 2, 2
	square_note 4, 14, 7, 1537
	square_note 8, 13, 6, 1539
	square_note 4, 12, 6, 1537
	square_note 12, 12, 3, 1409
	square_note 8, 11, 3, 1411
	square_note 4, 11, 2, 1410
	square_note 8, 10, 1, 1393
	sound_ret

cry_f1ecb:
	noise_note 7, 13, 6, 92
	noise_note 8, 14, 6, 76
	noise_note 4, 13, 4, 92
	noise_note 4, 13, 4, 76
	noise_note 7, 12, 3, 76
	noise_note 8, 10, 1, 92
	sound_ret

cry_f1ede:
	duty_cycle_pattern 0, 1, 2, 3
	square_note 7, 13, 2, 1856
	square_note 15, 14, 5, 1888
	square_note 24, 12, 1, 1840
	sound_ret

cry_f1eed:
	duty_cycle_pattern 2, 0, 0, 1
	square_note 2, 12, 2, 1793
	square_note 4, 12, 2, 1800
	square_note 15, 13, 7, 1857
	square_note 24, 10, 2, 1793

cry_f1eff:
	sound_ret

cry_f1f00:
	duty_cycle_pattern 3, 3, 0, 0
	square_note 15, 13, 7, 1920
	square_note 4, 14, 6, 1952
	square_note 15, 13, 2, 1856
	sound_ret

cry_f1f0f:
	duty_cycle_pattern 1, 1, 2, 2
	square_note 15, 12, 7, 1875
	square_note 5, 11, 6, 1906
	square_note 15, 12, 2, 1809
	sound_ret

cry_f1f1e:
	noise_note 13, 15, 6, 76
	noise_note 4, 14, 6, 60
	noise_note 15, 15, 2, 76
	sound_ret

cry_f1f28:
	duty_cycle_pattern 3, 3, 0, 0
	square_note 6, 15, 7, 1728
	square_note 15, 14, 7, 1792
	square_note 4, 15, 4, 1776
	square_note 4, 14, 4, 1760
	square_note 8, 13, 1, 1744
	sound_ret

cry_f1f3f:
	duty_cycle_pattern 0, 0, 2, 2
	square_note 7, 14, 6, 1665
	square_note 14, 13, 5, 1729
	square_note 4, 12, 4, 1713
	square_note 4, 13, 4, 1697
	square_note 8, 12, 1, 1681
	sound_ret

cry_f1f56:
	noise_note 10, 10, 6, 60
	noise_note 14, 9, 4, 44
	noise_note 5, 10, 3, 60
	noise_note 8, 9, 1, 44
	sound_ret

cry_f1f63:
	duty_cycle_pattern 2, 2, 1, 1
	square_note 12, 15, 2, 1088
	square_note 15, 14, 3, 1184
	square_note 4, 13, 2, 1168
	square_note 8, 13, 1, 1152
	sound_ret

cry_f1f76:
	duty_cycle_pattern 3, 2, 3, 2
	square_note 11, 13, 2, 1080
	square_note 14, 12, 6, 1176
	square_note 3, 11, 2, 1160
	square_note 8, 11, 1, 1144
	sound_ret

cry_f1f89:
	noise_note 10, 14, 6, 108
	noise_note 15, 13, 2, 92
	noise_note 3, 12, 2, 108
	noise_note 8, 13, 1, 92
	sound_ret

cry_f1f96:
	duty_cycle_pattern 0, 3, 0, 3
	square_note 15, 15, 6, 1472
	square_note 8, 14, 3, 1468
	square_note 6, 13, 2, 1488
	square_note 6, 11, 2, 1504
	square_note 6, 12, 2, 1520
	square_note 8, 11, 1, 1536
	sound_ret

cry_f1fb1:
	duty_cycle_pattern 2, 1, 2, 1
	square_note 14, 12, 6, 1201
	square_note 7, 12, 3, 1197
	square_note 5, 11, 2, 1217
	square_note 8, 9, 2, 1233
	square_note 6, 10, 2, 1249
	square_note 8, 9, 1, 1265
	sound_ret

cry_f1fcc:
	noise_note 10, 14, 6, 92
	noise_note 10, 13, 6, 108
	noise_note 4, 12, 2, 76
	noise_note 6, 13, 3, 92
	noise_note 8, 11, 3, 76
	noise_note 8, 10, 1, 92
	sound_ret

cry_f1fdf:
	duty_cycle_pattern 3, 3, 0, 0
	square_note 8, 14, 4, 1936
	square_note 15, 15, 5, 1984
	square_note 8, 13, 1, 2008
	sound_ret

cry_f1fee:
	duty_cycle_pattern 2, 2, 1, 1
	square_note 10, 12, 4, 1905
	square_note 15, 11, 6, 1954
	square_note 8, 10, 1, 1975
	sound_ret

cry_f1ffd:
	noise_note 8, 14, 4, 76
	noise_note 14, 12, 4, 60
	noise_note 8, 13, 1, 44
	sound_ret

cry_f2007:
	duty_cycle_pattern 3, 3, 0, 0
	square_note 6, 15, 2, 1536
	square_note 6, 14, 2, 1600
	square_note 6, 13, 2, 1664
	square_note 6, 14, 2, 1728
	square_note 6, 13, 2, 1792
	square_note 6, 12, 2, 1856
	square_note 6, 11, 2, 1920
	square_note 8, 10, 1, 1984
	sound_ret

cry_f202a:
	duty_cycle_pattern 0, 1, 0, 1
	square_note 3, 0, 8, 1
	square_note 6, 12, 2, 1473
	square_note 6, 11, 2, 1538
	square_note 6, 10, 2, 1601
	square_note 6, 11, 2, 1666
	square_note 6, 10, 2, 1730
	square_note 6, 9, 2, 1793
	square_note 6, 10, 2, 1858
	square_note 8, 8, 1, 1921
	sound_ret

cry_f2051:
	noise_note 6, 0, 8, 1
	noise_note 5, 14, 2, 92
	noise_note 5, 12, 2, 76
	noise_note 5, 13, 2, 60
	noise_note 5, 11, 2, 44
	noise_note 5, 12, 2, 28
	noise_note 5, 10, 2, 27
	noise_note 5, 9, 2, 26
	noise_note 8, 8, 1, 24
	sound_ret

cry_f206d:
	duty_cycle_pattern 3, 3, 0, 0
	square_note 4, 15, 3, 1920
	square_note 15, 14, 7, 1792
	square_note 8, 13, 3, 1808
	square_note 4, 12, 2, 1792
	square_note 4, 13, 2, 1776
	square_note 8, 12, 1, 1760
	sound_ret

cry_f2088:
	duty_cycle_pattern 1, 1, 2, 2
	square_note 6, 12, 3, 1793
	square_note 14, 11, 7, 1665
	square_note 7, 11, 3, 1682
	square_note 3, 10, 2, 1665
	square_note 4, 11, 2, 1650
	square_note 8, 10, 1, 1633
	sound_ret

cry_f20a3:
	noise_note 6, 14, 3, 92
	noise_note 14, 13, 6, 76
	noise_note 6, 12, 6, 60
	noise_note 3, 11, 3, 76
	noise_note 3, 10, 2, 92
	noise_note 8, 11, 1, 108
	sound_ret

cry_f20b6:
	duty_cycle_pattern 0, 0, 3, 3
	square_note 15, 15, 7, 1280
	square_note 15, 14, 7, 1288
	square_note 8, 11, 4, 1152
	square_note 15, 10, 2, 1120
	sound_ret

cry_f20c9:
	duty_cycle_pattern 1, 0, 1, 0
	square_note 14, 13, 7, 1153
	square_note 14, 12, 7, 1161
	square_note 10, 11, 4, 1025
	square_note 15, 12, 2, 993
	sound_ret

cry_f20dc:
	noise_note 14, 15, 7, 124
	noise_note 12, 15, 6, 108
	noise_note 9, 14, 4, 124
	noise_note 15, 14, 2, 108
	sound_ret

cry_f20e9:
	duty_cycle_pattern 3, 3, 1, 1
	square_note 7, 13, 6, 2017
	square_note 6, 12, 6, 2018
	square_note 9, 13, 6, 2017
	square_note 7, 12, 6, 2016
	square_note 5, 11, 6, 2018
	square_note 7, 12, 6, 2017
	square_note 6, 11, 6, 2016
	square_note 8, 10, 1, 2015
	sound_ret

cry_f210c:
	duty_cycle_pattern 1, 0, 1, 0
	square_note 6, 12, 3, 1993
	square_note 6, 11, 3, 1991
	square_note 10, 12, 4, 1987
	square_note 8, 11, 4, 1991
	square_note 6, 12, 3, 1993
	square_note 15, 10, 2, 1989
	sound_ret

cry_f2127:
	noise_note 13, 1, -1, 124
	noise_note 13, 15, 7, 140
	noise_note 12, 13, 6, 124
	noise_note 8, 12, 4, 108
	noise_note 15, 11, 3, 92
	sound_ret

cry_f2137:
	duty_cycle_pattern 3, 3, 0, 0
	square_note 6, 15, 7, 1856
	square_note 12, 14, 6, 1860
	square_note 6, 13, 5, 1872
	square_note 4, 12, 3, 1888
	square_note 3, 12, 3, 1920
	square_note 8, 13, 1, 1952
	sound_ret

cry_f2152:
	duty_cycle_pattern 0, 0, 2, 2
	square_note 6, 12, 7, 1793
	square_note 11, 11, 6, 1794
	square_note 6, 10, 5, 1809
	square_note 4, 9, 3, 1825
	square_note 3, 10, 3, 1857
	square_note 8, 9, 1, 1890
	sound_ret

cry_f216d:
	noise_note 3, 14, 2, 60
	noise_note 8, 13, 6, 76
	noise_note 5, 13, 4, 60
	noise_note 12, 12, 7, 76
	noise_note 2, 14, 2, 60
	noise_note 8, 13, 1, 44
	sound_ret

cry_f2180:
	duty_cycle_pattern 3, 3, 1, 0
	square_note 15, 15, 0, 1797
	square_note 10, 14, 0, 1792
	square_note 6, 11, 4, 1808
	square_note 4, 13, 3, 1792
	square_note 6, 11, 2, 1568
	square_note 8, 10, 1, 1572
	sound_ret

cry_f219b:
	duty_cycle_pattern 0, 2, 0, 2
	square_note 15, 11, 0, 1731
	square_note 10, 10, 0, 1729
	square_note 6, 8, 4, 1746
	square_note 4, 9, 3, 1729
	square_note 6, 8, 2, 1505
	square_note 8, 6, 1, 1512
	sound_ret

cry_f21b6:
	noise_note 6, 14, 6, 76
	noise_note 15, 13, 6, 60
	noise_note 10, 12, 5, 74
	noise_note 1, 11, 2, 91
	noise_note 15, 12, 2, 76
	sound_ret

cry_f21c6:
	duty_cycle_pattern 1, 1, 0, 0
	square_note 10, 15, 5, 1664
	square_note 3, 14, 2, 1696
	square_note 3, 15, 2, 1728
	square_note 3, 14, 2, 1760
	square_note 3, 13, 2, 1792
	square_note 3, 12, 2, 1760
	square_note 3, 13, 2, 1728
	square_note 8, 12, 1, 1696
	sound_ret

cry_f21e9:
	duty_cycle_pattern 0, 0, 3, 3
	square_note 9, 13, 5, 1585
	square_note 3, 13, 2, 1618
	square_note 3, 14, 2, 1649
	square_note 3, 11, 2, 1681
	square_note 3, 12, 2, 1714
	square_note 3, 11, 2, 1681
	square_note 3, 12, 2, 1649
	square_note 8, 11, 1, 1617
	sound_ret

cry_f220c:
	noise_note 6, 14, 3, 76
	noise_note 4, 12, 3, 60
	noise_note 5, 13, 4, 60
	noise_note 4, 12, 4, 44
	noise_note 6, 11, 4, 60
	noise_note 8, 12, 1, 44
	sound_ret

cry_f221f:
	duty_cycle_pattern 2, 2, 1, 1
	square_note 3, 15, 4, 1601
	square_note 13, 13, 6, 1825
	square_note 8, 15, 4, 1817
	square_note 8, 12, 1, 1818
	sound_ret

cry_f2232:
	duty_cycle_pattern 3, 0, 3, 0
	square_note 4, 15, 4, 1408
	square_note 14, 14, 6, 1760
	square_note 8, 13, 5, 1752
	square_note 8, 13, 1, 1756
	sound_ret

cry_f2245:
	noise_note 5, 12, 4, 70
	noise_note 13, 10, 5, 68
	noise_note 8, 12, 4, 69
	noise_note 8, 11, 1, 68
	sound_ret

cry_f2252:
	duty_cycle_pattern 3, 3, 0, 0
	square_note 13, 15, 1, 1297
	square_note 13, 14, 1, 1301
	square_note 13, 14, 1, 1297
	square_note 8, 13, 1, 1297
	sound_ret

cry_f2265:
	duty_cycle_pattern 0, 1, 1, 1
	square_note 12, 14, 1, 1292
	square_note 12, 13, 1, 1296
	square_note 14, 12, 1, 1292
	square_note 8, 12, 1, 1290
	sound_ret

cry_f2278:
	noise_note 14, 15, 2, 101
	noise_note 13, 14, 2, 85
	noise_note 14, 13, 2, 86
	noise_note 8, 13, 1, 102
	sound_ret

cry_f2285:
	duty_cycle_pattern 0, 1, 2, 3
	square_note 3, 15, 3, 1380
	square_note 2, 14, 2, 1348
	square_note 5, 13, 1, 1314
	square_note 2, 11, 2, 1156
	square_note 8, 13, 1, 1186
	square_note 3, 15, 3, 1316
	square_note 4, 14, 4, 1252
	square_note 8, 13, 1, 1282
	sound_ret

cry_f22a8:
	duty_cycle_pattern 3, 0, 3, 0
	square_note 3, 13, 3, 1376
	square_note 2, 12, 2, 1344
	square_note 5, 12, 1, 1312
	square_note 2, 9, 2, 1152
	square_note 8, 12, 1, 1184
	square_note 3, 13, 3, 1312
	square_note 3, 12, 4, 1248
	square_note 8, 12, 1, 1280

cry_f22ca:
	sound_ret

cry_f22cb:
	duty_cycle_pattern 0, 1, 0, 1
	square_note 2, 3, -5, 897
	square_note 7, 15, 5, 1537
	square_note 1, 12, 2, 1153
	square_note 8, 9, 1, 897
	sound_ret

cry_f22de:
	duty_cycle_pattern 3, 2, 3, 2
	square_note 2, 3, -6, 1456
	square_note 7, 13, 5, 1885
	square_note 1, 11, 2, 1712
	square_note 8, 6, 1, 1456
	sound_ret

cry_f22f1:
	noise_note 2, 9, 2, 73
	noise_note 7, 11, 5, 41
	noise_note 1, 10, 2, 57
	noise_note 8, 9, 1, 73
	sound_ret

