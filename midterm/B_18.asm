# Pham Hien Minh - 20235977 - Type B 
# Description: Enter an array of integers from the keyboard.
# Print out the smallest odd number that is greater than all the even numbers in the array. 
# -3 -6 -1 -2 -5 -4
.data
	msg1: .asciz "Input (number of elements): "
	msg2: .asciz "Output:  "
	msg3: .asciz "None"
	newline: .asciz "\n"

.text
# Registers:
# t1 = smallest odd number
# t2 = largest even number
# t3 = number of elements
# t4 = current element
# t5 = check if number is odd or even
main:
	# prompt input number of elements
	li a7, 4
	la a0, msg1
	ecall
	
	# read the number of elements
	li a7, 5
	ecall
	mv t0, a0            
	
	# initialize t1 to a large value and t2 to a small value
	li t1, 2147483647     # initialized to max int
	li t2, -2147483647    # initialized to min int
	
	# initialize loop counter
	li t3, 0             
	li t6, 2              # for modulus operation

loop:
	bge t3, t0, res       # if index >= number of elements, go to result check
	
	# read the next array element
	li a7, 5              # read_int 
	ecall
	mv t4, a0            
	
	# check if the element is odd or even
	rem t5, t4, t6        # t5 = t4 % 2
	beq t5, zero, even    # if t4 is even, go to even
	
	# check if odd is < t1
	blt t4, zero, odd_neg
	blt t4, t1, odd_pos
	j even                # skip to even check if no update

odd_neg:
	mv t1, t4
	j even
odd_pos:
	mv t1, t4             # update smallest odd to t4
	j even                # go to even check

even:
	# check if larger
	beq t5, zero, check_even
	j next                # if not even, skip

check_even:
	ble t4, t2, next      # if t4 <= largest even, skip update
	mv t2, t4             # update t4

next: 
	addi t3, t3, 1        # increment index
	j loop                # repeat the loop

res:
	# check if t1 > t2
	ble t1, t2, none      # if no, go to none

	# print the smallest odd number
	li a7, 4
	la a0, msg2
	ecall
	mv a0, t1
	
	li a7, 1              # print_int
	ecall
	j end                

none:
	li a7, 4
	la a0, msg3
	ecall

end:
	li a7, 10            
	ecall
