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



### سوال ۳





### سوال ۴





  
  </div>
