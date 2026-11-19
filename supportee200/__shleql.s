; Shift the pointed-to 32-bit value, returning __hireg:B.
	.setcpu 6
	.export __shleql
	.code
__shleql:
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
	slr b
	rlr a
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
