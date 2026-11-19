; Signed 32-bit quotient and remainder using the unsigned divider.
; The magnitude conversion is modulo 2^32, including LONG_MIN.
	.setcpu 6
	.export __divl
	.export __reml
	.code

__divl:
	cla
	bra begin
__reml:
	lda 1
begin:
	sta (-s)
	stx (-s)
	cla
	sta (-s)	; remainder sign
	sta (-s)	; quotient sign
	; 0 quotient sign, 2 remainder sign, 4 return X, 6 selector,
	; 8 caller X, 10/12 dividend.  Divisor is __hireg:B.
	lda 10(s)
	bp dividend_positive
	iva
	sta 10(s)
	stb (-s)	; preserve divisor low word
	ldb 14(s)
	ivr b
	inr b
	stb 14(s)
	bnz dividend_no_carry
	lda 12(s)
	ina
	sta 12(s)
dividend_no_carry:
	ldb (s+)
	lda 1
	sta (s)
	sta 2(s)
dividend_positive:
	lda (__hireg)
	bp divisor_positive
	iva
	sta (__hireg)
	ivr b
	inr b
	bnz divisor_no_carry
	lda (__hireg)
	ina
	sta (__hireg)
divisor_no_carry:
	stb (-s)
	lda 1
	ldb 2(s)
	ore a,b
	stb 2(s)
	ldb (s+)
divisor_positive:
	stb (-s)	; preserve divisor low while copying dividend
	ldb 14(s)
	stb (-s)
	lda 14(s)
	sta (-s)
	ldb 4(s)
	lda 12(s)
	bz divide
	jsr __remul
	bra signed_result
divide:
	jsr __divul
signed_result:
	inr s
	inr s
	lda 6(s)
	bz quotient_sign
	lda 2(s)
	bra check_sign
quotient_sign:
	lda (s)
check_sign:
	bz finish
	ivr b
	inr b
	bnz negate_high
	lda (__hireg)
	iva
	ina
	sta (__hireg)
	bra finish
negate_high:
	lda (__hireg)
	iva
	sta (__hireg)
finish:
	ldx 4(s)
	lda 8(s)
	sta 12(s)
	lda 12
	add a,s
	rsr
