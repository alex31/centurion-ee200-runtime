; Shift the pointed-to 32-bit value, returning __hireg:B.
	.setcpu 6
	.export __shrequl
	.code
__shrequl:
	stx (-s)
	xfr y,a
	sta (-s)
	ldx 6(s)
	lda 31
	nab
	xfr b,y
	lda (x)
	ldb 2(x)
	ori y,y
	bz done
next:
	rl
	rrr a
	rrr b
	dcr y
	bnz next
	sta (x)
	stb 2(x)
done:
	sta (__hireg)
	lda (s+)
	xay
	ldx (s+)
	lda (s)
	sta 2(s)
	inr s
	inr s
	rsr
