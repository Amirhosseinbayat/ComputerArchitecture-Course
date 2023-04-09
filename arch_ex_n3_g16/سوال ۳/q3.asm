

addi s0,zero,10		# arr_size
addi sp,sp,-40

addi t2,zero,1
sw t2,36(sp)
addi t2,zero,2
sw t2,32(sp)
addi t2,zero,3
sw t2,28(sp)
addi t2,zero,4
sw t2,24(sp)
addi t2,zero,5
sw t2,20(sp)
addi t2,zero,6
sw t2,16(sp)
addi t2,zero,7
sw t2,12(sp)
addi t2,zero,8
sw t2,8(sp)
addi t2,zero,9
sw t2,4(sp)
addi t2,zero,10
sw t2,0(sp)

add t1,zero,sp	# arr[]
addi s1,zero,1	# to check n with one

MAIN: 

	addi s2,zero,2 		# i = 2 
FOR:	
	bge s2,s0,DONE		# branch if i >= arr_size
	lw a0,8(sp)		# a0 = arr[i]
	jal ra,IS_EVEN
IF:	beq a0,zero,ELSE
	lw a0,8(sp)		# a0 = arr[i]
	lw a1,0(sp)		# a1 = arr[i-2]
	add t3,a0,a1		# t3 = arr[i] + arr [i-2]
	sw t3,8(sp)		# arr[i] += arr[i-2]
	j FI
ELSE:
	lw a1,4(sp)		# a1 = arr[i-1]
	add t4,zero,a1		# i = a1
	FOR_2:			# for (int i=a1 ; i > 0 ; i++ ) a0+=a0;
		ble t4,zero,ROF_2
		add a0,a0,a0
		addi t4,t4,-1
		j FOR_2
	ROF_2:
	sw a0,8(sp)		# arr[i]*arr[i-1] => arr[i]
FI:
	addi sp,sp,4		
	addi,s2,s2,1
	j FOR	
DONE:

j END


IS_EVEN:

	bne a0,zero,E_CHECK_ONE
	addi a0,zero,1
	jr ra

	E_CHECK_ONE:
	bne a0,s1,E_NONE
	addi a0,zero,0
	jr ra

	E_NONE:
	addi a0,a0,-1
	addi sp,sp,-4
	sw ra,0(sp)
	jal ra,IS_ODD
	lw ra,0(sp)
	addi sp,sp,4
	jr ra


IS_ODD:

	bne a0,zero,O_CHECK_ONE
	addi a0,zero,0
	jr ra

	O_CHECK_ONE:
	bne a0,s1,O_NONE
	addi a0,zero,1
	jr ra

	O_NONE:
	addi a0,a0,-1
	addi sp,sp,-4
	sw ra,0(sp)
	jal ra,IS_EVEN
	lw ra,0(sp)
	addi sp,sp,4
	jr ra

END:
