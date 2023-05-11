<div dir="rtl">


# تمرین ۶
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
  در همان ابتدا به دلیل عدم پیش‌ارسالی رجیستر t1 مقدار ۵ را میگیرد که اشتباه است و باقی هم به همین شکل ...

  
  شبیه‌سازی درست:
 ![image](https://github.com/Amirhosseinbayat/ComputerArchitecture-Course/assets/77579794/ab96b929-9ee1-426a-9c23-5d9871d01e39)

  
  
</div>
