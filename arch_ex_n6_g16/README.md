<div dir="rtl">


# تمرین ۶

  ### سوال ۲
  
  هر دستور در حالت عادی ۵ سیکل نیاز دارد تا به صورت کامل انجام شود.پیش‌بینی اولی ما با توجه به overlap سیکل ها با یکدیگر 12 سیکل می‌باشد. اما در صورتی که hazard detection فعال و مخاطرات مدیریت شوند نیاز به دو سیکل اضافه دیگر نیز می‌باشد که مربوط به stall شدن دستورات پنجم `(ori)` و هفتم `(xori)` می‌باشد. 
  پس در نهایت `۱۴‍` سیکل و `CPI` برابر با `14/8=1.75` می‌باشد.
</div>

<div dir="ltr">
  
  
  ~~~
addi s0, zero, 24‍‍‍    # 5
addi s1, zero, 16    # 6
sub t0, s0, s1       # 7
lw t1, 2(t0)         # 8
ori t2, t1, 63        
lw s2, 0(t2)
xori t1, s2, 27 
sw t1, 0(s1)
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
