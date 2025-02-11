.data
ascii_msg: .asciz "Enter a character: "   # Message prompting user input
output_msg: .asciz "\nLast two digits of ASCII code: "
buffer: .space 2                         # Space for input character

.text
main:
	# Prompt user for input
	la a0, ascii_msg                   
	li a7, 4                             
	ecall

	# Read a character from the keyboard
	li a7, 8                             
	la a0, buffer                       
	li a1, 2                            
	ecall

	# Extract ASCII value of input character
	la t0, buffer                       
	lb t4, 0(t0)                        
	
	# Calculate last two digits of ASCII code
	li t1, 100                         
	rem t0, t4, t1                   

	# Print output message
	la a0, output_msg                   
	li a7, 4                             
	ecall

	# Print last two digits of ASCII code
	li a7, 1                           
	mv a0, t0                           
	ecall

	# Exit program
	li a7, 10                           
	ecall