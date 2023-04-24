<div dir="rtl">


# تمرین ۴

## سوال ۱
</div>



<div dir="rtl">


  
 با توجه به کارکرد این دستور نیاز به مسیری وجود دارد که 
  rs1+ sign extend(imm)
  محاسبه و نتیجه روی 
  PCNext
  قرار گیرد. همچنین مسیری باید وجود داشته باشد تا `PC+4` در `registr file` ذخیره شود ( که این مسیر از طریق result موجود است.)
  با اضافه کردن یک `mux` و با منشعب کردن خروجی `ALU` و اضافه کردن سیگنال کنترلی `PCResultSrc` مسیر داده تکمیل می‌شود.
  
</div>
  
  
~~~
jalr x0,x1,0    # PC = rs1 + sign extend(imm), rd=PC+4
~~~

**I-Type**
| hex      |      imm     | rs1  |funct3|   rd  |   op    | Assembly |
| ---      | ---          | ---   | --- | ---   | ---     | ---|
| 00008067 | 000000000000 | 00001 | 000 | 00000 | 1100111 | jalr zero,ra,0|

![image](https://user-images.githubusercontent.com/77579794/234019839-dedc8bfc-d53c-4ab4-aa5c-02d91d092188.png)


| ALUOp |‌funct3 |‌{op5, funct75} | ALUControl         |‌ Instruction |
| ---   | ---   | ---           | ---                | ---         |
| 00    |‌x      | x             | 000 (add)          |‌lw, sw, jalr |
| 01    |‌x      | x             | 001 (subtract)     |       beq   |
|‌ 10    |‌000    | 00, 01, 10    | 000 (add)          |       add   |‌
|       |000    |‌ 11            | 001 (subtract)     |       sub   |
|       |010    | x             | 101 (set less than)|       slt   |
|‌       |110    | x             | 011 (or)           |       or    |
|       |111    | x             | 010 (and)          |       and   |

