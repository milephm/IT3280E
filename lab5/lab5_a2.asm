# Laboratory Exercise 5, Home Assignment 2 
.data 
msg1: .asciz "The sum of "
msg2: .asciz " and "
msg3: .asciz " is "
newline: .asciz "\n"

prompt1: .asciz "The first number (s0) is: "
prompt2: .asciz "The second number (s1) is: "
.text 
	#input
	li a7, 4			#input first number
	la a0 prompt1 
	ecall
	li a7, 5
	ecall
	mv s0, a0
	
	li a7, 4 		#input second number
	la a0 prompt2 
	ecall
	li a7, 5
	ecall
	mv s1, a0
	
	#calculate
	add s2, s0, s1		#s2 = s0 + s1
	
	#output
	li a7,4			#print first part of the message "The sum of "
	la a0, msg1
	ecall
	li a7,1			#print the first number (s0)
	mv a0, s0
	ecall
	li a7, 4			#print the second part of the message " and "
	la a0, msg2
	ecall
	li a7, 1			#print the second number (s1)
	mv a0, s1
	ecall
	li a7, 4			#print the third part of the message " is "
	la a0, msg3
	ecall
	li a7, 1			#print the result (s2)
	mv a0, s2
	ecall
	li a7, 4			#print newline
	la a0, newline
	ecall
	
	#exit program
	li a7, 10
	ecall
	
	