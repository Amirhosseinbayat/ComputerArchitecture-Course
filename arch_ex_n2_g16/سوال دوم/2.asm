# a0 = n , t0 = i , t1 = result
addi a0,zero,9	# initilization for a0 can be changed
addi t1,zero,1	# initilization for t1
addi t0,zero,1	# initilization for t0

FOR:
bgt t0,a0,end	# branch if t0 is greater than a0
mul t1,t1,t0	# store the product results in t1
addi t0,t0,1	# increment t0
j FOR			# go back in for loop

end:
# put result into a0
add a0,t1,zero
