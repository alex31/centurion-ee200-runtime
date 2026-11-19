; Low 32 bits of stacked lhs * (__hireg:B), for both signed and unsigned C.
	.setcpu 6
	.export __mull
	.export __mullu
	.code
__mull:
__mullu:
	stb (-s)		; rhs low, caller X, lhs high, lhs low
	lda 4(s)
	mul a,b
	stb (-s)		; low word of lhs.high * rhs.low
	lda (__hireg)
	ldb 8(s)
	mul a,b
	lda (s)
	aab
	stb (s)			; sum of cross products, modulo 65536
	lda 8(s)
	ldb 2(s)
	mul b,a			; A:B = lhs.low * rhs.low
	stb 6(s)
	ldb (s)
	aab
	stb (__hireg)
	ldb 6(s)
	lda 4(s)		; move saved caller X past the consumed lhs
	sta 8(s)
	inr s,8
	rsr
