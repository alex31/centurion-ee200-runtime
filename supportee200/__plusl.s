	.setcpu 4
	.export __plusl

	.code

__plusl:
	; top of stack plus hireg:b
	lda	4(s)	; 0 is saved X, 2 is high, 4 is low
	aab
	stb	4(s)	; use as a save for the low word
	bnl	nocarry
	lda	2(s)
	ina
	bra	addhigh
nocarry:
	lda	2(s)
addhigh:
	ldb	(__hireg)
	aab
	stb	(__hireg)
	ldb	4(s)	; get the low half back
	; Move saved X over the discarded operand for RSR.
	lda	(s)
	sta	4(s)
	lda	4
	add	a,s
	rsr

