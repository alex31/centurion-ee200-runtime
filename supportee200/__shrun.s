; Shift stacked 16-bit operand by the count in B, preserving caller X.
	.setcpu 6
	.export __shru
	.code
__shru:
	stx (-s)
	xfr b,x
	ldb 4(s)
	ori x,x
	bz done
next:
	rl
	rrr b
	dcx
	bnz next
done:
	ldx (s+)
	lda (s)
	sta 2(s)
	inr s
	inr s
	rsr

