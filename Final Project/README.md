
<div dir="rtl">

# پروژه پایانی

## مقدمه
هدف از پروژه طراحی واحد کنترل پردازنده چند سیکل RISC-V با استفاده از ریزبرنامه است. به این معنی که هر دستورالعمل به به ریزعملیاتی بخش می‌شود و آن‌ها اجرا می‌شوند. مثلا یک دستور R-Type به ترتیب ریزعملیات‌های fetch, decode, ExecuteR,AluWB را طی میکند.


شکل ۷.۲۷ شکل کامل پردازنده چند سیکل:
![image](https://github.com/Amirhosseinbayat/ComputerArchitecture-Course/assets/77579794/af68b3a4-5dc4-450a-86bb-c08271573103)

شکل ۷.۲۸ واحد کنترل چند سیکل: 
![image](https://github.com/Amirhosseinbayat/ComputerArchitecture-Course/assets/77579794/e4f673ab-4351-4f8e-b452-59e4e0f9703e)


شکل ۷.۴۵ FSM واحد کنترل:

![image](https://github.com/Amirhosseinbayat/ComputerArchitecture-Course/assets/77579794/73fca2a6-e5c1-46c5-ad43-7a77ed286151)
![image](https://github.com/Amirhosseinbayat/ComputerArchitecture-Course/assets/77579794/4f895490-f93e-412c-acae-77abd7da332a)

شکل ۷.۶۳ مربوط به به پردازنده تک سیکل:
![image](https://github.com/Amirhosseinbayat/ComputerArchitecture-Course/assets/77579794/55f267a7-2a48-4516-a4e9-4495cea652b5)

شکل ۱۹.۱۵ کارکرد کنترل ریزبرنامه‌ای:
![image](https://github.com/Amirhosseinbayat/ComputerArchitecture-Course/assets/77579794/c426f468-eaa9-4b93-8641-28b97e7d6875)

جداول:
![image](https://github.com/Amirhosseinbayat/ComputerArchitecture-Course/assets/77579794/3461312f-a874-4e48-8e8c-febec3853a49)

شکل ۱۹.۱۲ استالینگز قالب ریزدستورالعمل‌های افقی:
![image](https://github.com/Amirhosseinbayat/ComputerArchitecture-Course/assets/77579794/961ef9dc-c469-4548-a58e-9b160e899ee3)


</div>

<div dir="ltr">  

| microinstruction name | alucontrol[2:0] | immsrc[1:0] | alusrcb[1:0]| alusrca[1:0] | resultsrc[1:0] | adrsrc | irwrite | memwrite | regwrite | pcwrite | partial CW |
| ---                   |            ---  |      ---    |     ---     |         ---  |           ---  |    --- |      ---| ---      |     ---  |    ---  |    ---     |
| 0 (Fetch)             |      000        |   00        |     10      |   00         |       10       |    0   |    1    |    0     |   0      |   1     |            | 
| 1 (Decode)            |      000        |   00        |     01      |   01         |       00       |    0   |    0    |    0     |   0      |   0     |            |
| 2 (MemAdr)            |      000        |   00        |01           |10            |       00       | 0      | 0       | 0        | 0        |   0     |            |
| 3 (MemRead)           |      000        |   00        |00           |            00| 00             | 1      | 0       | 0        | 0        |   0     |            |
| 4 (MemWB)             |      000        |   00        | 00          |00            | 01             | 0      | 0       | 0        | 1        |   0     |            |
| 5 (MemWrite)          |      000        |   00        | 00          |00            | 00             |1       | 0       | 1        | 0        |   0     |            |
| 6 (ExecuteR)          | 000/010/110/111 |   00        | 00          |10            | 00             |0       | 0       | 0        | 0        |   0     |            |
| 7 (ALUWB)             | 000             |   00        | 00          |00            |00              |0       |0        |0         |1         |  0      |            |
| 8 (ExecuteI)          | 000/010/110/111 |   00        | 01          |10            | 00             |0       |0        |0         |0         |  0      |            |
| 9 (JAL)               | 000             |   11        | 10          |01            | 00             | 0      |0        |0         |0         | 1       |            |
| 10 (BEQ)              |              |           |           |            |              |       |        |         |         |        |            |
  
</div>
