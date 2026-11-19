; Compare stacked lhs with (__hireg:B), consuming the stacked operand.
; Signed comparison biases both high words by 0x8000, then uses unsigned
; comparisons of the high and low words.  Selectors are LT, GT, LE, GE
; in their low two bits, with bit 2 indicating unsigned comparison.
	.setcpu 6
	.export __ccltl
	.export __ccltul
	.export __ccgtl
	.export __ccgtul
	.export __cclteql
	.export __ccltequl
	.export __ccgteql
	.export __ccgtequl
	.code
__ccltl:
	cla
	bra compare
__ccgtl:
	lda 1
	bra compare
__cclteql:
	lda 2
	bra compare
__ccgteql:
	lda 3
	bra compare
__ccltul:
	lda 4
	bra compare
__ccgtul:
	lda 5
	bra compare
__ccltequl:
	lda 6
	bra compare
__ccgtequl:
	lda 7
compare:
	sta (-s)
	stx (-s)
	stb (-s)
	; 0 rhs low, 2 return, 4 selector, 6 caller X, 8/10 lhs.
	lda 4(s)
	ldb 4
	nab
	bnz unsigned_compare
	lda 32768
	ldb 8(s)
	ore a,b
	stb 8(s)
	ldb (__hireg)
	ore a,b
	stb (__hireg)
unsigned_compare:
	lda 8(s)
	ldb (__hireg)
	sab
	bz low_word
	bnl less
	bra greater
low_word:
	lda 10(s)
	ldb (s)
	sab
	bz equal
	bnl less
greater:
	lda 4(s)
	ldb 1
	nab
	bnz true
	bra false
less:
	lda 4(s)
	ldb 1
	nab
	bz true
	bra false
equal:
	lda 4(s)
	ldb 2
	nab
	bnz true
false:
	lda 6(s)
	sta 10(s)
	ldx 2(s)
	lda 10
	add a,s
	clr b
	rsr
true:
	lda 6(s)
	sta 10(s)
	ldx 2(s)
	lda 10
	add a,s
	ldb 1
	rsr
