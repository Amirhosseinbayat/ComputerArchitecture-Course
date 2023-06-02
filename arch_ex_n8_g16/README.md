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

    | تعداد کل بلاک‌ها در حافظه نهان(ا) | تعداد مجموعه‌ها(ب) | بلوک‌ها در مجموعه(ب) | بیت‌های index(ج) | بیت‌های tag(ج) |
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
  | 1 | (Tag of i in stack) | 0-7 |  | array cell |  |
  | 1 | (Tag of j in stack) | 0-7 |  | array cell |  |
  | 1 | (Tag of sum in stack) | 0 |  | array cell |  |
  |  | array cell |  |  | array cell |  |
  
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
  | 1 | (Tag of i in stack) | 0 | 1 | array cell[7][4] | 12 |
  | 1 | (Tag of j in stack) | 0 | 1 | array cell[7][5] | 13 |
  | 1 | array cell[7][2] | 10 | 1 | array cell[7][6] | 14 |
  | 1 | array cell[7][3] | 11 | 1 | array cell[7][7] | 15 |
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



### سوال ۳





### سوال ۴





  
  </div>
