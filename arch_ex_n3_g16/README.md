<div dir="rtl">

# تمرین ۳

## سوال ۱
الف)
</div>

| Code | Type | Addressing Method |
|---|---|---|
| L1 : addi t3, a2, 12 | I-Type | Immediate |
| xori s6, a0, 14 | I-Type | Immediate |
| jal L2 | U/J-Type | PC-Relative |
| sw s5, 4(a0) | S/B-Type | Base |
| j L1 | U/J-Type | PC-Relative |
| L2 : beq t3, a4, L3 | S/B-Type | PC-Relative |
| lui t4, 0xFF | U/J-Type | Immediate |
| L3 : lw s4, 8(t1) | I-Type | Base |
| sub t3, t2, t1 | R-Type | Register-Only |
| jr ra | I-Type | Base |

<hr>
<div dir="rtl">


ب)

</div>



**R-Type:**
| hex      | funct7  |  rs2  |  rs1  |funct3|  rd  |   op    | Assembly |
| --- | --- | --- | --- | ---| ---   | --- | ---   |
| 40638E33 | 0100000 | 00110 | 00111 | 000 | 11100 | 0110011 | sub t3, t2, t1  |

**I-Type:**
| hex      |      imm     | rs1  |funct3|   rd  |   op    | Assembly |
| ---      | ---          | ---   | --- | ---   | ---     | ---|
| 00C60E13 | 000000001100 | 01100 | 000 | 11100 | 0010011 | L1 : addi t3, a2, 12 |
| 00E54B13 | 000000001110 | 01010 | 100 | 10110 | 0010011 | xori s6, a0, 14 |
| 00832A03 | 000000001000 | 00110 | 010 | 10100 | 0000011 | lui t4, 0xFF |
| 00008067 | 000000000000 | 00001 | 000 | 00000 | 1100111 | jr ra |


**S/B-Type**
| hex      | imm     | rs2   | rs1   |funct3| imm  |    op   | Assembly |
| ---      | ---     | ---   | ---   | --- | ---   | ---     | ---|
| 01552223 | 0000000 | 10101 | 01010 | 010 | 00100 | 0100011 | sw s5, 4(a0) |
| 00EE0463 | 0000000 | 01110 | 11100 | 000 | 01000 | 1100011 | L2 : beq t3, a4, L3 |


**U/J-Type**
| hex | imm | rd | op | Assembly |
| --- | --- | --- | ---| ---|
| 00C000EF | 00000000110000000000 | 00001 | 1101111 | jal L2 |
| FF1FF06F | 11111111000111111111 | 00000 | 1101111 | j L1 |
| 000FFEB7 | 00000000000011111111 | 11101 | 0110111 | lui t4, 0xFF |


<div dir="rtl">

کد ماشین برنامه: 
	
</div>
	
	
~~~
0x00c60e1300e54b1300c000ef01552223ff1ff06f00ee0463000ffeb700832a0340638e3300008067
~~~
	
<div dir="rtl">
	

## سوال ۲
الف)

</div>

| machine code | OP code | Type | addressing mode | Assembly instruction | Label |
|---|---|---|---|---|---|
| 0x00100293 | 19 | I-Type | Immediate     | addi t0,zero,1 | L0 |
| 0x00a2c463 | 99 | S/B-Type | PC-Relative | blt t0,a0,L1 |
| 0x00008067 | 103 | I-Type | Base         | jalr zero,ra,0 |
| 0xff010113 | 19 | I-Type | Immediate     | addi sp,sp,-16 | L1 |
| 0x00a12623 | 35 | S/B-Type | Base        | sw a0,12(sp) |
| 0x00112423 | 35 | S/B-Type | Base        | sw ra,8(sp) |
| 0x00812223 | 35 | S/B-Type | Base        | sw s0,4(sp) |
| 0x00912023 | 35 | S/B-Type | Base        | sw s1,0(sp) |
| 0xfff50513 | 19 | I-Type | Immediate     | addi a0,a0,-1 |
| 0xfddff0ef | 111 | U/J-Type | PC-Relative| jal ra,L0 |
| 0x00a00433 | 51 | R-Type | Register-Only | add s0,zero,a0 |
| 0x00c12503 | 3 | I-Type | Base           | lw a0,12(sp) |
| 0xffe50513 | 19 | I-Type | Immediate     | addi a0,a0,-2 |
| 0xfcdff0ef | 111 | U/J-Type | PC-Relative| jal ra,L0 |
| 0x00a004b3 | 51 | R-Type | Register-Only | add s1,zero,a0 |
| 0x00848433 | 51 | R-Type | Register-Only | add s0,s1,s0 |
| 0x00040533 | 51 | R-Type | Register-Only | add a0,s0,zero |
| 0x00812083 | 3 | I-Type | Base           | lw ra,8(sp) |
| 0x00412403 | 3 | I-Type | Base           | lw s0,4(sp) |
| 0x00012483 | 3 | I-Type | Base           | lw s1,0(sp) |
| 0x01010113 | 19 | I-Type | Immediate     | addi sp,sp,16 |
| 0x00008067 | 103 | I-Type | Base         | jalr zero,ra,0 |


<div dir="rtl">

ب) تابع ورودی a0 را میگیرد و جمله a0 ام از دنباله فیبوناچی را برمیگرداند.

</div>

**R-Type**
| hex      | funct7  |  rs2  |  rs1  |funct3|  rd  |   op    | Assembly |
| --- | --- | --- | --- | ---| ---   | --- | ---   |
| 00A00433 | 0000000 | 01010 | 00000 | 000 | 01000 | 0110011 | add x8,x0,x10|
| 00A004B3 | 0000000 | 01010 | 00000 | 000 | 01001 | 0110011 | add x9,x0,x10|
| 00848433 | 0000000 | 01000 | 01001 | 000 | 01000 | 0110011 | add x8,x9,x8 |
| 00040533 | 0000000 | 00000 | 01000 | 000 | 01010 | 0110011 | add x10,x8,x0|


**I-Type**
| hex      |      imm     | rs1  |funct3|   rd  |   op    | Assembly |
| ---      | ---          | ---   | --- | ---   | ---     | ---|
| 00100293 | 000000000001 | 00000 | 000 | 00101 | 0010011 | addi x5,x0,1|
| 00008067 | 000000000000 | 00001 | 000 | 00000 | 1100111 | jalr zero,ra,0|
| FF010113 | 111111110000 | 00010 | 000 | 00010 | 0010011 | addi x2,x2,-16|
| FFF50513 | 111111111111 | 01010 | 000 | 01010 | 0010011 | addi x10,x10,-1|
| 00C12503 | 000000001100 | 00010 | 010 | 01010 | 0000011 | lw x10,12(x2)|
| FFE50513 | 111111111110 | 01010 | 000 | 01010 | 0010011 | addi x10,x10,-2|
| 00812083 | 000000001000 | 00010 | 010 | 00001 | 0000011 | lw x1,8(x2)|
| 00412403 | 000000000100 | 00010 | 010 | 01000 | 0000011 | lw x8,4(x2)|
| 00012483 | 000000000000 | 00010 | 010 | 01001 | 0000011 | lw x9,0(x2)|
| 01010113 | 000000010000 | 00010 | 000 | 00010 | 0010011 | addi x2,x2,16|
| 00008067 | 000000000000 | 00001 | 000 | 00000 | 1100111 | jalr zero,ra,0|


**S/B-Type**

| hex      | imm     | rs2   | rs1   |funct3| imm  |    op   | Assembly |
| ---      | ---     | ---   | ---   | --- | ---   | ---     | ---|
| 00A2C463 | 0000000 | 01010 | 00101 | 100 | 01000 | 1100011 | blt x5,x10,8 |
| 00A12623 | 0000000 | 01010 | 00010 | 010 | 01100 | 0100011 | sw x10,12(x2)|
| 00112423 | 0000000 | 00001 | 00010 | 010 | 01000 | 0100011 | sw x1,8(x2)|
| 00812223 | 0000000 | 01000 | 00010 | 010 | 00100 | 0100011 | sw x8,4(x2)|
| 00912023 | 0000000 | 01001 | 00010 | 010 | 00000 | 0100011 | sw x9,0(x2)|

**U/J-Type**
| hex | imm | rd | op | Assembly |
| --- | --- | --- | ---| ---|
| FDDFF0EF | 11111101110111111111 | 00001 | 1101111 | jal ra,-36 |
| FCDFF0EF | 11111100110111111111 | 00001 | 1101111 | jal ra,-52 |

**ASSEMBLY:**
~~~
addi a0,zero,4
L0: addi t0,zero,1
blt t0,a0,L1
jalr zero,ra,0
L1: addi sp,sp,-16
sw a0,12(sp)
sw ra,8(sp)
sw s0,4(sp)
sw s1,0(sp)
addi a0,a0,-1
jal ra,L0 
add s0,zero,a0
lw a0,12(sp)
addi a0,a0,-2
jal ra,L0
add s1,zero,a0
add s0,s1,s0
add a0,s0,zero
lw ra,8(sp)
lw s0,4(sp)
lw s1,0(sp)
addi sp,sp,16
jalr zero,ra,0
~~~

**C:**
~~~
int nth_fibo(int n)
{
  int t1 = 0, t2 = 1, nextTerm = 0, i;
  if(n == 0 || n == 1) 
    return n; 
  else
    nextTerm = t1 + t2;
  for (i = 2; i <= n; ++i)
  {
    t1 = t2;
    t2 = nextTerm;
    nextTerm = t1 + t2;
  }

  return t2;
}
~~~

<div dir="rtl">


## سوال ۳


کد اسمبلی:

</div>


~~~
addi s0,zero,10		# arr_size
addi sp,sp,-40

# array initiation: {10,9,8,7,6,5,4,3,2,1}

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

add s3,zero,sp	# to store the address of arr[]
addi s1,zero,1	# to check n with one

MAIN: 

	addi s2,zero,2 		# i = 2 
FOR:	
	bge s2,s0,DONE		# branch if i >= arr_size
	lw a0,8(s3)		# a0 = arr[i]
	jal ra,IS_EVEN
IF:	beq a0,zero,ELSE
	lw a0,8(s3)		# a0 = arr[i]
	lw a1,0(s3)		# a1 = arr[i-2]
	add t3,a0,a1		# t3 = arr[i] + arr [i-2]
	sw t3,8(s3)		# arr[i] += arr[i-2]
	j FI
ELSE:
	lw a0,8(s3)		# a0 = arr[i]
	add t5,zero,a0	
	lw a1,4(s3)		# a1 = arr[i-1]
	addi t4,a1,-1		# i = a1-1
	FOR_2:			# for (int i=a1-1 ; i > 0 ; i++ ) a0+=a0;
		ble t4,zero,ROF_2
		add a0,a0,t5
		addi t4,t4,-1
		j FOR_2
	ROF_2:
	sw a0,8(s3)		# arr[i]*arr[i-1] => arr[i]
FI:
	addi s3,s3,4		
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
~~~

<div dir="rtl">


خروجی نهایی: 
شروع ارایه از 0x7fffffec تا 0x7fffffc8

</div>


![image](https://user-images.githubusercontent.com/77579794/230790398-4809671d-3828-48e0-9078-fb8cba199f81.png)
