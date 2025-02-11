# Pham Hien Minh - 20235977 - Type C 
# Description: . Enter two strings A and B, print out the uppercase letters that appear in both A and B.

.data
	inputA: .space 80
	inputB: .space 80
	msg1: .asciz "String A: "
	msg2: .asciz "String B: "
	msg3: .asciz "Output: "
	msg4: .asciz "None\n"  

.text
main:
	# prompt input for string A
	li a7, 4
	la a0, msg1
	ecall
	
	# read string A
	li a7, 8
	la a0, inputA
	li a1, 80
	ecall
    
	# prompt input for string B
	li a7, 4
	la a0, msg2
	ecall

	# read string B
	li a7, 8
	la a0, inputB
	li a1, 80
	ecall
    
	# print result message
	li a7, 4
	la a0, msg3
	ecall
    
	# initialize A and Z
	la t0, inputA
	li t2, 'a'
	li t3, 'z'
	    
	# track match found
	li t6, 0		# no match
    
uppercase_A:
	lb t1, 0(t0)        # load byte from inputA
	beq t1, zero, check_none  # if null check if no match found
	  
	blt t1, t2, next    # if t1 < 'a', go to next    
	bgt t1, t3, next    # if t1 > 'z', go to next
	   
	la t4, inputB	# start of inputB
    
uppercase_B:
	lb t5, 0(t4)        # load byte from inputB
	beq t5, zero, next  # move next if null
	    
	# compare t1 and t5 (A and B)
	bne t1, t5, skip     # if not equal, skip
	    
	# match found -> print
	li a7, 11            # print_char
	add a0, t1, zero     # load character
	ecall 
	li t6, 1             # set match found flag
	j next             # move to next character in inputA
	
skip:
	addi t4, t4, 1       # move to next character in inputB
	j uppercase_B        # continue searching

next:
	addi t0, t0, 1       # move to next character in inputA
	j uppercase_A        # continue searching

check_none:
	# if no match found, print "None"
	beq t6, zero, none
	j end
	    
none:
	li a7, 4
	la a0, msg4      # print "None"
	ecall

end:
	li a7, 10
	ecall