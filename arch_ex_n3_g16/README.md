
# تمرین ۳


## سوال ۲
الف)
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


ب) تابع ورودی a0 را میگیرید و جمله a0 ام از دنباله فیبوناچی را برمیگرداند.

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
  for (i = 3; i <= n; ++i)
  {
    t1 = t2;
    t2 = nextTerm;
    nextTerm = t1 + t2;
  }

  return t2;
}
~~~
