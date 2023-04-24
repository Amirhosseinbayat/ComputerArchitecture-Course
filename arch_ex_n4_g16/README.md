<div dir="rtl">


# تمرین ۴

## سوال ۱
</div>

~~~
jalr x0,x1,0    # PC = rs1 + sign extend(imm), rd=PC+4
~~~

**I-Type**
| hex      |      imm     | rs1  |funct3|   rd  |   op    | Assembly |
| ---      | ---          | ---   | --- | ---   | ---     | ---|
| 00008067 | 000000000000 | 00001 | 000 | 00000 | 1100111 | jalr zero,ra,0|
