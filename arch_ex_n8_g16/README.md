<div dir="rtl">


# تمرین ۸

### سوال ۱

رابطه مربوط به AMAT به صورت بازگشتی برای سیستمی که یک لایه cache, یک memory و یک virtual memory داشته باشد به صورت زیر محاسبه می‌شود.
  
  ![image](https://github.com/Amirhosseinbayat/ComputerArchitecture-Course/assets/77579794/571bdfcf-ecb0-435d-8655-073e41ff38e2)
  
  برای این سوال دو لایه cache داریم اما virtual memory نداریم, که در این صورت رابطه بازگشتی به شکل زیر تبدیل خواهد شد:

</div>

<div dir="ltr">  
  
  ~~~
  AMAT = Tcl1 + MRcl1 (Tcl2 + MRcl2.Tmm)
  => AMAT = 1ns + 0.05(5ns + 0.15.(100ns))
  => AMAT = 2ns
  ~~~
  
  </div>


<div dir="rtl">



### سوال ۲

ساختار cache:
  
  <div dir="ltr">  
    
    
  | V | Tag | Data | V | Tag | Data |
  | --- | --- | --- | --- | --- | --- |
  |  |  |  |  |  |  |
  |  |  |  |  |  |  |
  |  |  |  |  |  |  |
  |  |  |  |  |  |  |

- memory address:
    
    | Tag | Set | Byte Offset |
    | --- | --- | --- |
    | 28 bits | 2 bits | 2 bits(00) |

    | بیت‌های tag(ج) | بیت‌های index(ج) | بلوک‌ها در مجموعه(ب) | تعداد مجموعه‌ها(ب) |  تعداد کل بلاک‌ها در حافظه نهان(ا) | 
    | --- | --- | --- | --- | --- |
    | ۲۸ | ۲ | ۲ | ۴ | ۸ |
    
    
  </div>    
    
<div dir="rtl">

  د) بررسی تعداد و نرخ hit و miss:
  
   <div dir="ltr"> 
     
  ~~~
  int i,j,sum=0;

    for (i=0 ; i< SIZE ; i++)
        for (j=0 ; j < SIZE ; j++)
            array[i][j] = i+j+1;   
  ~~~
     
  | V | Tag | Data | V | Tag | Data |
  | --- | --- | --- | --- | --- | --- |
  | 1 | (Tag of i in stack) | 0-7 |  | (Tag of an array cell) |  |
  | 1 | (Tag of j in stack) | 0-7 |  | (Tag of an array cell) |  |
  | 1 | (Tag of sum in stack) | 0 |  | (Tag of an array cell) |  |
  |  | (Tag of an array cell) |  |  | (Tag of an array cell) |  |
  
  </div>
  
  
<div dir="rtl">
  
  
  در این قسمت از کد با هر write روی i و j مقادیر این دو متغییر قبل از فراخوانی بروز‌رسانی شده‌اند, بنابراین تعداد miss ها برابر صفر خواهد بود. همچنین خانه‌های آرایه هم به همین ترتیب با هر write روی cache نوشته میشوند اما در این قسمت از کد هیچ دستوری مقادیر درون آرایه را فراخوانی نمیکند. 
  
  به این ترتیب تعداد hit ها:
    </div>
  
 <div dir="ltr"> 
   
  ~~~
  first for loop: 
   8 times hit on loading variable i on i < SIZE
   
  second for loop:
   8 times hit on loading variable j on j < SIZE
   
  array[i][j] = i+j+1; :
   64 times hit each time for i,j * 8
  ~~~
  
   => 
   
 ~~~
hits= 8 + 8 + 64*8 = 528  
 ~~~
   
 ---
   
  ~~~
  for (i=0 ; i < SIZE ; i++)
        for (j=0 ; j < SIZE ; j++)
            sum+=  array[i][j];
  ~~~
     
  at the beginning: 
   
  | V | Tag | Data | V | Tag | Data |
  | --- | --- | --- | --- | --- | --- |
  | 1 | (Tag of i in stack) | 0 | 1 | (Tag of array cell[7][4]) | 12 |
  | 1 | (Tag of j in stack) | 0 | 1 | (Tag of array cell[7][5]) | 13 |
  | 1 | (Tag of array cell[7][2]) | 10 | 1 | (Tag of array cell[7][6]) | 14 |
  | 1 | (Tag of array cell[7][3]) | 11 | 1 | (Tag of array cell[7][7]) | 15 |
  </div>
   
  
<div dir="rtl">
  
  در این قسمت هیچکدام از خانه‌های آرایه hit نخواهند شد چرا که هر خانه فقط یکبار فراخوانی می‌شود و دیگر مورد استفاده قرار نخواهد گرفت. متغییر های i , j در سمت دیگر, در هر بار فراخوانی hit خواهند شد. حتی در اولین بار فراخوانی به دلیل sw که در i=0 , j=0 در اولین دستور حلقه انجام می‌شود مقادیر آنها درست خواهد بود. متغییر sum بار اول miss و در باقی فراخوانی‌ها hit می‌شود.
  
  به این ترتیب تعداد hit ها:
    </div>
  
 <div dir="ltr"> 
   
  ~~~
  first for loop: 
   8 times hit on loading variable i on i < SIZE
   
  second for loop:
   8 times hit on loading variable j on j < SIZE
   
  sum+=  array[i][j]; :
   1 miss and 63 hits for sum,
   64 misses on every array invocation
  ~~~
  
   => 
 ~~~
 hits= 8 + 8 + 63 = 79
 misses= 64
 ~~~ 
   
   **OVERALL RESULTS:** 
 ~~~
hits= 79+528 = 607
misses = 64
all = 671
hit rate = 607/671 = 90.46 %
miss rate = 9.53 %
 ~~~
  
  
  </div>
  
    
  
<div dir="rtl">



### سوال ۳

کد اسمبلی ( با استفاده از ابزار https://godbolt.org ) :
  
  
  </div>
  
  
  <div dir="ltr">
    
~~~
    
    
main:
        addi    sp,sp,-288
        sw      s0,284(sp)
        addi    s0,sp,288
        sw      zero,-28(s0)
        sw      zero,-20(s0)
        j       L2
L5:
        sw      zero,-24(s0)
        j       L3
L4:
        lw      a4,-20(s0)
        lw      a5,-24(s0)
        add     a5,a4,a5
        addi    a4,a5,1
        lw      a5,-20(s0)
        slli    a3,a5,3
        lw      a5,-24(s0)
        add     a5,a3,a5
        slli    a5,a5,2
        addi    a5,a5,-16
        add     a5,a5,s0
        sw      a4,-268(a5)
        lw      a5,-24(s0)
        addi    a5,a5,1
        sw      a5,-24(s0)
L3:
        lw      a4,-24(s0)
        li      a5,7
        ble     a4,a5,L4
        lw      a5,-20(s0)
        addi    a5,a5,1
        sw      a5,-20(s0)
L2:
        lw      a4,-20(s0)
        li      a5,7
        ble     a4,a5,L5
        sw      zero,-20(s0)
        j       L6
L9:
        sw      zero,-24(s0)
        j       L7
L8:
        lw      a5,-20(s0)
        slli    a4,a5,3
        lw      a5,-24(s0)
        add     a5,a4,a5
        slli    a5,a5,2
        addi    a5,a5,-16
        add     a5,a5,s0
        lw      a5,-268(a5)
        lw      a4,-28(s0)
        add     a5,a4,a5
        sw      a5,-28(s0)
        lw      a5,-24(s0)
        addi    a5,a5,1
        sw      a5,-24(s0)
L7:
        lw      a4,-24(s0)
        li      a5,7
        ble     a4,a5,L8
        lw      a5,-20(s0)
        addi    a5,a5,1
        sw      a5,-20(s0)
L6:
        lw      a4,-20(s0)
        li      a5,7
        ble     a4,a5,L9
        li      a5,0
        mv      a0,a5
        lw      s0,284(sp)
        addi    sp,sp,288
        #jr      ra
        
~~~
    
    
  </div>
  
    
<div dir="rtl">

الف)
  هر word = ۴ bytes
  
  اندازه بلاک 4 bytes:

![image](https://github.com/Amirhosseinbayat/ComputerArchitecture-Course/assets/77579794/ba7bfec6-a538-48a1-b83e-295ab8e6129f)
  
  
  اندازه بلاک 8 bytes:
  ![image](https://github.com/Amirhosseinbayat/ComputerArchitecture-Course/assets/77579794/8bd3022b-1caa-4b43-bd95-7b4a11008ce0)

  

  اندازه بلاک 16 bytes:
![image](https://github.com/Amirhosseinbayat/ComputerArchitecture-Course/assets/77579794/6ff8ba6e-1a7f-4ab4-9687-6664e09333c2)

  با افزایش اندازه بلاک‌ها نرخ miss تا حدی کاهش می‌یابد چرا که با این روش از **هم‌محلیت فضایی** بهتر استفاده میکنیم  چرا که پیمایش آرایه عمده کار این کد می‌باشد و بدین ترتیب موجب کاهش تعداد **Compulsory miss** ها میشویم. این مورد در افزایش اندازه بلاک از ۴ به ۸ قابل مشاهده است. 
  
  ![image](https://github.com/Amirhosseinbayat/ComputerArchitecture-Course/assets/77579794/d0baef42-a521-41f0-be91-46f7fc0302da)

  اما در نقطه مقابل در افزایش بعدی اندازه بلاک, همان طور که در نمودار بالا قابل مشاهده است, این افزایش موجب افزایش **Conflict miss** ها خواهد شد. در نتیجه بهره‌وری کمتری از فضای حافظه نهان در اندازه بلاک ۱۶ برده‌ایم.
  
  
 </div>
   
  
<div dir="ltr">
     
  | b | Hit rate |
  | --- | --- |
  | 4 | 84.43 % |
  | 8 | 87.49 % |
  | 16 | 87.13 % |
  
</div>
   
  
<div dir="rtl">
  
  
  ب) 
  
  ظرفیت: 16*4 bytes
 
  اندازه بلاک: 4
  </div>
  
  
  <div dir="ltr">
  
  2-way:
  
  ![image](https://github.com/Amirhosseinbayat/ComputerArchitecture-Course/assets/77579794/d2011aec-fb20-4226-a725-cd37181aeaa3)

  
  
  4-way:
  
  
  ![image](https://github.com/Amirhosseinbayat/ComputerArchitecture-Course/assets/77579794/9f1fee62-913c-4b56-a651-ff2286274021)
  

  
  8-way:
  
![image](https://github.com/Amirhosseinbayat/ComputerArchitecture-Course/assets/77579794/755f2776-f6ee-4ebf-a453-d2e5fa2a6737)
  
    
  </div>
  
  
  <div dir="rtl">
  
  
  با افزایش درجه associativity می‌توان miss هایی از جنس **conflict** را پوشش داد. اما ظاهرا در مورد این کد, افزایش این درجه تاثیری چندانی روی بهبود نرخ miss ندارد چرا که miss هایی که از جنس conflict بوده‌اند در مرحله اول مهاجرت از نگاشت مستقیم برطرف شده و سایز فعلی حافظه نهان با افزایش درجه associativity نمی‌تواند کمکی به اجرای سریع‌تر برنامه کند. 
  

 </div>
   
  
<div dir="ltr">
     
  | N | Hit rate |
  | --- | --- |
  | 2 | 87.94 % |
  | 4 | 87.94 % |
  | 8 | 87.94 % |
  
</div>
   
  
<div dir="rtl">    
    
    
  
### سوال ۴

  الف)

</div>

<div dir="ltr">  
  
  ~~~
  AMAT = ATc + MRc(ATtlb + MRtlb(ATmm) + ATmm + MRmm(AThd))
  => AMAT = 1 + 0.02( 1 + 0.0005(100) + 100 + 0.000003(1000000) )
  => AMAT = 3.081 cycles
  ~~~
  
  </div>


<div dir="rtl">

  
  ب)
  
حافظه مجازی توانایی آدرس دهی تا ۲ به توان ۳۲ را دارد این یعنی فضای آدرس حافظه مجازی در 32 بیت خلاصه میشود که از آدرس `0x0000_0000` شروع و به `0xFFFF_FFFF` ختم می‌شود.
  
  فضای آدرس حافظه فیزیکی هم در ۲۳ بیت قرار میگیرد.  
  
  اندازه هر page برابر با 4KB است در نتیجه ۱۲بیت مربوط به `Page offset` خواهد بود. ۳۲-۱۲=۲۰ بیت مربوط به VPN و ۲۳-۱۲=۱۱ بیت هم مربوط به PPN خواهد بود.
  
  ساختار هر سطر ورودی و بیت‌های مورد نیاز آن به این شکل ترسیم می‌شود:
  
  </div>

<div dir="ltr">  
  
| V | VPN | PPN |
| --- | --- | --- |
| 1 | 20 | 11 |

~~~
TLB_Size= 64*(1+20+11) = 2048 bits
~~~

  </div>


<div dir="rtl">
  
  ج) 
  
  
</div>
  
<div dir="ltr">  
  
  
| V /1 | VPN /20 | PPN /11|
| --- | --- | --- |
|  |  |  |
|  |  |  |
|  |  |  |
|  |  |  |
  
.
  
.
  

  64 
  
  
.
  
.  
  
  
  
</div>

  د)‌ برای ساخت این TLB نیاز به یک SRAM که فضای آدرس ۶۴ تایی داشته باشد داریم که در هر آدرس 4byte را در خود جای دهد. یعنی در نهایت 256B حافظه SRAM.

<div dir="rtl">
  
  </div>
