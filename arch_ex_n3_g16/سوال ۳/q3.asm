

addi t0,zero,10
addi sp,sp,-10

add t1,zero,sp	# arr[]
addi s0,zero,1	# to check n with one

MAIN: 

jr ra


IS_EVEN:

	bne a0,zero,E_CHECK_ONE
	addi a0,zero,1
	jr ra

	E_CHECK_ONE:
	bne a0,s0,E_NONE
	addi a0,zero,0
	jr ra

	E_NONE:
	addi a0,a0,-1
	jal ra,IS_ODD
	jr ra


IS_ODD:

	bne a0,zero,O_CHECK_ONE
	addi a0,zero,0
	jr ra

	O_CHECK_ONE:
	bne a0,s0,O_NONE
	addi a0,zero,1
	jr ra

	O_NONE:
	addi a0,a0,-1
	jal ra,IS_EVEN
	jr ra


