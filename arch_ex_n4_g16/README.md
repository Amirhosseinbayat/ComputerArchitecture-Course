<div dir="rtl">


# تمرین ۴

## سوال ۱
</div>



<div dir="rtl">


آیا لازم است بلوک منطقی دیگری برای پیاده سازی به پردازنده اضافه شود؟
  
  بلی. با توجه به کارکرد این دستور نیاز به مسیری وجود دارد که 
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
