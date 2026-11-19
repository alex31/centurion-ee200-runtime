; Signed 16-bit quotient/remainder via sign-extended 32-bit helpers.
	.setcpu 6
	.export __div
	.export __rem
	.code
__div:
	cla
	bra begin
__rem:
	lda 1
begin:
	stx (-s)
	sta (-s)
	stb (-s)	; 0 divisor, 2 selector, 4 return, 6 old X, 8 dividend
	ori b,b
	bp positive_divisor
	lda 65535
	bra store_divisor_high
positive_divisor:
	cla
store_divisor_high:
	sta (__hireg)
	ldb 8(s)
	stb (-s)
	ori b,b
	bp positive_dividend
	lda 65535
	bra push_dividend_high
positive_dividend:
	cla
push_dividend_high:
	sta (-s)
	ldb 4(s)
	lda 6(s)
	bz divide
	jsr __reml
	bra finish
divide:
	jsr __divl
finish:
	ldx 4(s)
	lda 6(s)
	sta 8(s)
	lda 8
	add a,s
	rsr
