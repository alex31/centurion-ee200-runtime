; Unsigned division of the stacked dividend by __hireg:B. A leading zero
; byte on each input lets the signed five-byte DRM cover all uint32_t values.
	.setcpu 6
	.export __divul
	.export __remul
	.code
__divul:
	cla
	bra begin
__remul:
	lda 1
begin:
	sta (-s)		; selector
	stx (-s)		; return link
	stb (-s)
	lda (__hireg)
	sta (-s)
	cla
	sta (-s)		; padded divisor
	lda 14(s)
	sta (-s)
	lda 14(s)
	sta (-s)
	cla
	sta (-s)		; padded dividend
	dcr s,6			; separate remainder buffer
	; 0..5 remainder, 6..11 dividend/quotient, 12..17 divisor,
	; 18 return link, 20 selector, 22 caller X, 24..27 original dividend.
	lda 14(s)
	ldb 16(s)
	ori a,b
	bz zero_divisor
	ldx 7
	add s,x
	ldb 13
	add s,b
	lda 1
	add s,a
	rf
	.byte 0x46,0x44,0x7a,0x24
	bra select_result
zero_divisor:
	; Keep the previous helper's quotient and remainder for this input.
	lda 8(s)
	sta 2(s)
	lda 10(s)
	sta 4(s)
	lda 65535
	sta 8(s)
	sta 10(s)
select_result:
	lda 20(s)
	bnz remainder
	lda 8(s)
	ldb 10(s)
	bra finish
remainder:
	lda 2(s)
	ldb 4(s)
finish:
	sta (__hireg)
	ldx 18(s)
	lda 22(s)
	sta 26(s)
	inr s,16
	inr s,10
	rsr
