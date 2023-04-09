

addi s0,zero,10		# arr_size
addi sp,sp,-40

addi t2,zero,3
sw t2,36(sp)
addi t2,zero,10
sw t2,32(sp)
addi t2,zero,2
sw t2,28(sp)
addi t2,zero,3
sw t2,24(sp)
addi t2,zero,13
sw t2,20(sp)
addi t2,zero,11
sw t2,16(sp)
addi t2,zero,9
sw t2,12(sp)
addi t2,zero,8
sw t2,8(sp)
addi t2,zero,5
sw t2,4(sp)
addi t2,zero,4
sw t2,0(sp)

add t1,zero,sp	# arr[]
addi s1,zero,1	# to check n with one

MAIN: 

	addi s2,zero,2 		# i = 2 
	blt s2,s0,
	
FOR:	

j END


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

END:
