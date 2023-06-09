<div dir="rtl">


# تمرین ۴

## سوال ۱
</div>



<div dir="rtl">


  
 با توجه به کارکرد این دستور نیاز به مسیری وجود دارد که 
  `rs1+ sign extend(imm)`
  محاسبه و نتیجه روی 
  `PCNext`
  قرار گیرد. همچنین مسیری باید وجود داشته باشد تا `PC+4` در `registr file` ذخیره شود ( که این مسیر از طریق `result` موجود است.)
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


**Table 7.3**
| ALUOp |‌funct3 |‌{op5, funct75} | ALUControl         |‌ Instruction |
| ---   | ---   | ---           | ---                | ---         |
| 00    |‌x      | x             | 000 (add)          |‌lw, sw, jalr |
| 01    |‌x      | x             | 001 (subtract)     |       beq   |
|‌ 10    |‌000    | 00, 01, 10    | 000 (add)          |       add   |‌
|       |000    |‌ 11            | 001 (subtract)     |       sub   |
|       |010    | x             | 101 (set less than)|       slt   |
|‌       |110    | x             | 011 (or)           |       or    |
|       |111    | x             | 010 (and)          |       and   |

**Table 7.6**
| Instruction | Opcode | RegWrite | ImmSrc | ALUSrc | MemWrite | ResultSrc | Branch | ALUOp | Jump | PCResultSrc |
|   ---       |  ---   | ---      |    --- |  ---   |   ---    |    ---    |  ---   | ---   | ---  | ---         |
|    lw       | 0000011|   1      |   00   |   1    |    0     |    01     |   0    |  00   |   0  |     x       |
|    sw       | 0100011|   0      |   01   |   1    |    1     |    xx     |   0    |  00   |   0  |     x       |
|    R-Type   | 0110011|   1      |   xx   |   0    |    0     |    00     |   0    |  10   |   0  |     x       |
|    beq      | 1100011|   0      |   10   |   0    |    0     |    xx     |   1    |  01   |   0  |     0       |
| I-type ALU  | 0010011|   1      |   00   |   1    |    0     |    00     |   0    |  10   |   0  |     x       |
|    jal      | 1101111|   1      |   11   |   x    |    0     |    10     |   0    |  xx   |   1  |     0       |
|    jalr     | 1100111|   1      |   00   |   1    |    0     |    10     |   0    |  00   |   1  |     1       |



<div dir="rtl">

## سوال ۲
با استفاده از تغییرات موجود در سوال یک روی data path
  کد را تغییر می‌دهیم تا بتوانیم از jalr پشتیبانی کنیم. این تغییرات با کامنت‌های ‍‍‍‍‍`// changed by me for jalr` قابل مشاهده هستند. به صورت کلی این تغییرات شامل اضافه کردن سیگنال کنترلی `PCResultSrc` و سیگنال میانی `PCResultTarget` و اضافه کردن `pcsrcmux` میباشد.
  
  همچنین با توجه به جدول ۷.۶ مقادیر مورد تحلیل تابع `maindec` دستخوش تغییر شده اند.
  
  شرح تغییرات در تصاویر زیر:
 

  ![image](https://user-images.githubusercontent.com/77579794/235314695-bfd847df-3531-4fdb-9537-2dea0fb87bb8.png)

  ![image](https://user-images.githubusercontent.com/77579794/235314686-a6aad5e7-b125-4fa6-81d6-1c7005595bea.png)

  ![image](https://user-images.githubusercontent.com/77579794/235314716-739bee4d-fec6-4f3a-8185-0f4b176435d3.png)

  ![image](https://user-images.githubusercontent.com/77579794/235314665-9e3727f4-edf3-4429-97b2-f684144fe200.png)

  باقی دستورات ذکر شده نظیر addi و jal در کد کتاب بدون ایجاد تغییرات پشتیبانی می‌شوند. برخی از این خطوط در کد با کامنت‌هایی مشخص شده است. 
  این دستورات در کد اسمبلی تست هم مورد بررسی قرار گرفته اند و کار میکنند.
  
  تغییر ما شامل یک jal تایید شده به یک 
  برچسب با نام dummy می‌باشد.
  سپس با استفاده از 
  
  فضای compile کد:
  ![image](https://user-images.githubusercontent.com/77579794/235314427-d992ae5e-4b32-4782-94b0-88312123f494.png)
  
  کد مربوط به testbench و کدهای اسمبلی به پیوست در q2 قابل مشاهده هستند.

</div>

~~~
jal dummy                       # ra=PC+4, jumps to dummy
addi t1,t1,-8                   # set t1 to ok
jalr zero,t1,0                  # PC=t1+0
ok: sw x2, 0x20(x3)             # [100] = 250221A023
done: beq x2, x2, done          # infinite loop5000210063
dummy: jalr t1,ra,0             # PC=ra+0,t1=PC+4
~~~

<div dir="rtl">

این تکه کد jalr را به خوبی تست میکند. 
به این شکل که هر دو عملیات تغییر PC 
و تغییر rd به 
PC+4 تست می‌شود.
در صورتی که هر یک از این عملیات موفق نشود مقدار نهایی در حافظه ذخیره نخواهد شد


</div>



simulation commands:
~~~
vlog -reportprogress 300 -work work //VBOXSVR/University/Architecture/arch_ex_n4_g16/q2/riscvsingle.sv
vlog -reportprogress 300 -work work //VBOXSVR/University/Architecture/arch_ex_n4_g16/q2/testBench.sv

vlog -reportprogress 300 -work work C:/Users/mohsen/Desktop/verilog/n4/riscvsingle.sv
vlog -reportprogress 300 -work work C:/Users/mohsen/Desktop/verilog/n4/testBench.sv
vsim -voptargs=+acc=lprn testbench
add wave -position insertpoint sim:/testbench/*
~~~

<div dir="rtl">

## سوال ۳

برطبق جدول ۷.۷ میدانیم که تاخیر واحد `ALU` برابر `120` پیکوثانیه است؛ اما اگر از جمع کننده `Prefix Adder` استفاده کنیم این مقدار به `90` پیکوثانیه کاهش می یابد.

برای بدست آوردن زمان چرخه ما ابتدا باید `Critical Path` را پیدا کنیم. در پردازنده `RISC-V` میدانیم که دستور `lw` طولانی ترین دستور است و `Critical Path` آن در شکل زیر نمایش داده شده است.

<img width="1339" alt="Screen Shot 1402-02-08 at 5 36 56 PM" src="https://user-images.githubusercontent.com/99789952/235170189-b6733925-91fb-4211-94c9-4ec99c7dcecf.png">

 که در اینجا ما تاخیر چندین واحد از جمله `Data Path` و `Control Unit` را داریم که معادله زیر نشان دهنده این تاخیر ها در اجرای دستور `lw` است.

<img width="1211" alt="Screen Shot 1402-02-08 at 5 48 48 PM" src="https://user-images.githubusercontent.com/99789952/235174982-61fcc794-f9c3-4e11-b621-285cb06d4230.png">

که با ساده سازی در نهایت به معادله زیر خواهیم رسید.

<img width="1219" alt="Screen Shot 1402-02-08 at 5 49 58 PM" src="https://user-images.githubusercontent.com/99789952/235175440-eefd2960-570b-41eb-b238-46b7fe2c7cd0.png">

حالا با داشتن معادله بالا و جدول ۷.۷ کتاب، زمان یک چرخه را محاسبه میکنیم.

`T = 40 + 2(200) + 100 + 90 + 30 + 60 = 720 ps`

همچنین قبل تر خواندیم که زمان اجرای یک برنامه، طبق فرمول زیر بدست می آید.

<img width="1193" alt="Screen Shot 1402-02-08 at 6 03 27 PM" src="https://user-images.githubusercontent.com/99789952/235176692-cba9fe22-9647-44ac-a985-dc884ef7047a.png">

با جایگذاری مقادیر، در معادله زمان اجرای برنامه با `10` میلیارد دستور را خواهیم داشت.

`Execution Time = (10 * 10^9 instruction) (1 cycle/instruction) (720 * 10^-12 s/cycle) = 7.2 seconds`


</div>



<div dir="rtl">

## سوال ۴

 میدانیم که سیگنال کنترلی `PCSrc`، ورودی `Istruction Memory` را انتخاب میکند که یا از `Extend` بیاید و یا از `PCPlus4`
که چسبیده به ۱ بودن این سیگنال باعث میشود که این سیگنال همواره از واحد `Extend` بیاید و درواقع و دو دستور `jal` و `beq` انجام شوند که این باعث تداخل در برنامه مورد نظر میشود.

  
  سیگنال کنترلی `ALUSrc`، تصمیم میگیرد که کدام ورودی مالتیپلکسر قبل `ALU`، روی یکی از ورودی های `ALU` قرار بگیرد؛ درواقع برای هر دستور ممکن است ورودی از قسمت `Extend` و یا `Register File` بیاید که به ترتیب سیگنال `ImmExt` و `RD2` میشوند.
  که اگر سیگنال کنترلی `ALUSrc` چسبیده به ۱ باشد، باعث میشود که برای دستورات `R-Type` و `lw` و `sw` مشکل بوجود بیاید؛ چون همه این دستورات، `ALUSrc` 
 برابر ۱ دارند و اختلال این سیگنال، باعث تداخل در برنامه و عدم اجرای درست آن میشود. جدای این دستورات، برای بقیه دستورات که سیگنال `ALUSrc` آنها برابر صفر است نیز مشکل بوجود میاید و تنها دستور `jal` به درستی اجرا میشود، چون که این سیگنال در این دستور فاقد اهمیت میباشد.

  
  سیگنال `ImmSrc` دارای ۲ بیت است که نحوه `extend` کردن واحد `Extend` را نشان میدهد که بر اساس هر دستور چگونه باید اینکار را انجام دهد (`Sign-Extend` و یا ... )؛ چسبیده به ۱ بودن بیت اول این سیگنال باعث میشود که دو دستور `jal` و `sw` که بیت اول سیگنال `ImmSrc` آنها ۱ است، دچار تداخل شوند و عمل `extend` به درستی انجام نشود. در ضمن برای بقیه دستورات بجز دستورات `R-Type` که درواقع این سیگنال `xx` است، نیز مشکل ایجاد میشود چون آن دستورات نیز نمیتوانند اجرا شوند چون بیت اول تمام آنها صفر است. 

  
  برای سیگنال `ResultSrc` میدانیم که اگر همان مجموعه کم دستور را داشته باشیم، اصلا بیت دومی برای این سیگنال نخواهیم داشت. درصورتی که دستورات `jal` و `I-Type` اضافه شوند، سیگنال `ResultSrc` تبدیل به سیگنال ۲ بیتی میشود؛ که در اینجا نیز تنها زمانی که دستور `jal` انجام میشود، بیت دوم این سیگنال یعنی سیگنال `ResultSrc` برابر ۱ میشود. پس درواقع نتیجه میگیریم که درهر صورت بیت دوم این سیگنال اگر برابر ۱ باشد، برای تمامی دستورات، بجز دستور `sw` و `beq` که این سیگنال مهم نیست و بصورت `xx` است، مشکل ایجاد میشود.
  
  در این سوال از جدول زیر و شکل مربوطه کمک گرفته شده است.
  </div>
  
  <img width="1462" alt="Screen Shot 1402-02-07 at 4 48 40 PM" src="https://user-images.githubusercontent.com/99789952/234897591-02a15a51-c8ae-4e41-9b98-dc25ed0b61c6.png">
  
  
  <img width="1511" alt="Screen Shot 1402-02-07 at 6 11 33 PM" src="https://user-images.githubusercontent.com/99789952/234898239-87528a2e-f3d4-4f42-ae92-bf62b0f31029.png">

