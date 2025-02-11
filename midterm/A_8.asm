# Pham Hien Minh - 20235977 - Type A
# Description: Enter a positive integer N (with at least 3 digits) from the keyboard.
# print out the largest digit of N.

.data
	msg: .asciz "N: "
	newline: .asciz "Output: "
.text
# Registers
# t0 = integer
# t1 = current largest digit
# t2 = last digit
main:
	# prompt input
	li a7, 4
	la a0, msg
	ecall
	
	# read integer input
	li a7, 5
	ecall
	mv t0, a0
	
	# initialize
	li t1, 2147483647
	li t3, 10              # for modulus operation
	
find:
	beqz t0, res
	
	# extract the last digit
	rem t2, t0, t3
	div t0, t0, t3
	
	# compare and update largest digit
	ble t2, t1, small
	j find                 # skip if current is larger
	
small:
	addi t1, t2, 0         # update 
	j find
	
res:
	# print result
	li a7, 4
	la a0, newline
	ecall
	
	addi a0, t1, 48
	li a7, 11              # print_char
	ecall
	
	li a7, 10
	ecall