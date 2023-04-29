main: addi x2, x0, 5            #x2 = 5000500113
addi x3, x0, 12                 # x3 = 12400C00193
addi x7, x3, -9                 # x7 = (12 - 9) = 38FF718393
or x4, x7, x2                   # x4 = (3 OR 5) = 7C0023E233
and x5, x3, x4                  # x5 = (12 AND 7) = 4100041F2B3
add x5, x5, x4                  # x5 = 4 + 7 = 1114004282B3
beq x5, x7, end                 #shouldn't be taken1802728863
slt x4, x3, x4                  # x4 = (12 < 7) = 01C0041A233
beq x4, x0, around              # should be taken2000020463
addi x5, x0, 0                  #shouldn't execute2400000293
around: slt x4, x7, x2          # x4 = (3 < 5) = 1280023A233
add x7, x4, x5                  # x7 = (1 + 11) = 122C005203B3
sub x7, x7, x2                  # x7 = (12 - 5) = 730402383B3
sw x7, 84(x3)                   #[96] = 7340471AA23
lw x2, 96(x0)                   #x2 = [96] = 73806002103
add x9, x2, x5                  # x9 = (7 + 11) = 183C005104B3
jal x3, end                     # jump to end, x3 = 0x4440008001EF
addi x2, x0, 1                  #shouldn't execute4400100113
end: add x2, x2, x9             # x2 = (7 + 18) = 25484C00910133
sw x2, 0x20(x3)                 # [100] = 250221A023
done: beq x2, x2, done          # infinite loop5000210063
