<div dir="rtl">


# تمرین ۶

  
  ### سوال ۱
  ![image](https://github.com/Amirhosseinbayat/ComputerArchitecture-Course/assets/77579794/ccfa1bab-b468-4786-a4ab-5b5b065affd5)

  ![image](https://github.com/Amirhosseinbayat/ComputerArchitecture-Course/assets/77579794/0b84ce5b-137d-48e5-8ab2-72a35b567fe5)

  
  بر اساس صفحه `454` رفرنس هریس، زمان دوره کلاک بر اساس ماکسیمم میزان پنج استیج `Fetch` ، `Decode` ، `Execute` ، `Memory` ، `Writeback` است.
  
  حالا برای استیج `Execute` ، زمان اجرا را محاسبه میکنیم چون تاخیر واحد `ALU` فقط و فقط در همین استیج تاثیرگذار است و بقیه تاخیر ها را بر اساس مرجع هریس داریم.
  
  میدانیم تاخیر واحد استیج `Execute` برابر:
  
  
  </div>

  
  <div dir="ltr">
  
  ~~~
  t_execute = t_pcq + 4t_mux + t_ALU + t_AND_OR + t_setup
  ~~~
  
  
  
  </div>



<div dir="rtl">
  
  
  است؛ میدانیم بر اساس جدول `7.7` تاخیر واحد `ALU` برابر `120ps` است و اگر به میزان `20%` کاهش بیابد ، به مقدار `96ps` میرسد. 
  
  بنابراین بر این اساس داریم : 
  </div>

<div dir="ltr">
  
~~~  
t_execute = 40 + 4(30) + 96 + 20 + 50 = 326ps
~~~
  
</div>

<div dir="rtl">

   
  که در مقایسه با واحد های دیگر، باز هم ماکسیمم مقدار است که `cycle time = 326 ps` میباشد.
  
  
  با روال بالا حالا برای افزایش مقدار تاخیر `ALU` محاسبات را انجام میدهیم؛ میدانیم `120 * 1.2 = 144` میباشد.
  </div>

  <div dir="ltr">
  
  ~~~  
  t_execute = 40 + 4(30) + 144 + 20 + 50 = 374ps
  ~~~

</div>



<div dir="rtl">


  
  که باز هم در اینجا با مقایسه با دیگر استیج ها، این مقدار ماکسیمم است، بنابراین `cycle time = 374ps` خواهد بود.
  
  در نهایت متوجه شدیم که تاخیر `ALU` در خط لوله بر روی زمان و تاخیر فقط استیج `Execute` تاثیر میگذارد و با این حال با اغزایش و یا کاهش تاخیر این واحد، باز هم این استیج بیشترین زمان را از ما میبرد و باعث بالا رفتن زمان دوره کلاک میشود.
  
  ---
  
  
  ### سوال ۲
  
  هر دستور در حالت عادی ۵ سیکل نیاز دارد تا به صورت کامل انجام شود.پیش‌بینی اولی ما با توجه به overlap سیکل ها با یکدیگر 12 سیکل می‌باشد. اما در صورتی که hazard detection فعال و مخاطرات مدیریت شوند نیاز به دو سیکل اضافه دیگر نیز می‌باشد که مربوط به stall شدن دستورات پنجم `(ori)` و هفتم `(xori)` می‌باشد. 
  پس در نهایت `۱۴‍` سیکل و `CPI` برابر با `14/8=1.75` می‌باشد.
</div>

<div dir="ltr">
  
  
  ~~~
                     # instruction ends in this cycle
addi s0, zero, 24‍‍‍    # 5
addi s1, zero, 16    # 6
sub t0, s0, s1       # 7
lw t1, 2(t0)         # 8
ori t2, t1, 63       # 10
lw s2, 0(t2)         # 11
xori t1, s2, 27      # 13
sw t1, 0(s1)         # 14
~~~
  
  
</div>         

<div dir="rtl">
  
  ---
  ### سوال  ۳
  وقفه‌ها و پیش‌ارسالی‌های مورد نیاز:
  
  ![image](https://github.com/Amirhosseinbayat/ComputerArchitecture-Course/assets/77579794/acd5cc5c-ee72-4415-bc46-532892867764)

 

  کاری که کد باید انجام دهد:

  
</div>

<div dir="ltr">
  
~~~
addi t0, zero, 2      # t0=2
xori t1, t0, 5        # t1=7
lw s0, 24(t1)         # s0 <= [31] 
lw s1, 0(s0)          # s1 <= [s0] 
sub t2, s1, t0        # t2 = s1 - 2
or t3, s1, t2         # t3 = s1 | (s1 - 2)
sw t3, 4(t1)          # [11] <= t3
~~~

</div>
                                 
                                 
<div dir="rtl">
  
  شبیه‌سازی نادرست و بدون رفع مخاطره:
  
 ![image](https://github.com/Amirhosseinbayat/ComputerArchitecture-Course/assets/77579794/54c51fd2-0437-403c-a86d-50a9ae0bfaf8)
  در همان ابتدا به دلیل عدم پیش‌ارسالی رجیستر t1 مقدار ۵ را میگیرد که اشتباه است و باقی هم به همین شکل  که در نهایت در آدرس ۹ sw انجام میشود به جای ادرس ۱۱ یا `0x0000000B`

  
  شبیه‌سازی درست:
 ![image](https://github.com/Amirhosseinbayat/ComputerArchitecture-Course/assets/77579794/ab96b929-9ee1-426a-9c23-5d9871d01e39)

  
  
</div>
