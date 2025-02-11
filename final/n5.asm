#operand
#a  b  c  d  e  f...
#10 11 12 13 14 15...

#register
#s  r  t  x  0  1  2  3  4...
#77 76 78 82 10 11 12 13 14...

.eqv KEY_CODE 0xFFFF0004
.eqv KEY_READY 0xFFFF0000
.eqv DISPLAY_CODE 0xFFFF000C
.eqv DISPLAY_READY 0xFFFF0008

.data
input_op: 	.asciz "opcode: "
valid_msg: 	.asciz ", valid\n"
invalid_msg: 	.asciz ", invalid\n"
valid_ope: 	.asciz "operands valid\n"
invalid_ope: 	.asciz "operands invalid\n"
instruction: 	.byte

#character
space:	.asciz " "
comma:	.asciz ","

#encrypted instruction (RV321 base integer only)
R: .word 101313 283011 332427 2427 102313 282121 282721 282710 282129 28212930
#         add    sub    xor    or   and    sll    srl    sra    slt    sltu
I: .word 10131318 33242718 242718 10231318 28212118 28272118 28271018 28212918 2821291830 19102127
#         addi     xori     ori    andi     slli     srli     srai     slti     sltiu      jalr
IS: .word 2111 2117 2132 211130 211730 2811 2817 2832 
#         lb   lh   lw   lbu    lhu    sb   sh   sw  
B: .word 111426 112314 112129 111614 11212930 11161430
#         beq    bne    blt    bge    bltu     bgeu
U: .word 213018 1030182512 
#      	  lui     auipc
J: .word 19  191021
#         j    jal
register_name: .word 84637673 7659 7774 6574 7874 7810 7811 7812 7813 7814 7815 7816 7710 7711 7712 7713 7714 7715 7716 7717 7718 7719 771110 771111 5910 5911 5912 5913 5914 5915 5916 5917 8210 8211 8212 8213 8214 8215 8216 8217 8218 8219 821110 821111 821112 821113 821114 821115 821116 821117 821118 821119 821210 821211 821212 821213 821214 821215 821216 821217 821218 821219 821310 821311
#     		     zero     ra   sp   gp   tp   t0   t1   t2   t3   t4   t5   t6   s0   s1   s2   s3   s4   s5   s6   s7   s8   s9   s10    s11    a0   a1   a2   a3   a4   a5   a6   a7   x0   x1   x2   x3   x4   x5   x6   x7   x8   x9   x10    x11    x12    x13    x14    x15    x16    x17    x18    x19    x20    x21    x22    x23    x24    x25    x26    x27    x28    x29    x30    x31

.text 
	li a7, 4
	la a0, input_op
	ecall
	
	li a0, KEY_CODE
	li a1, KEY_READY
	li s0, 0              	#instruction format type
	li s1, DISPLAY_READY
	
	la t0, instruction
	addi t0, t0, -1
	
	li t1, 0              	#store the current char of input
	li t2, 10             	#enter in ascii
	li t3, 0              	#the position of the first space
	li t4, ' '
	li t5, 100		#for updating t6
	li t6, 1              	#1, 100, 10000,...
	li s2, 0              	#opcode in encrypt form
	li s3, 0              	#max size of R, I, IS, B array
	li s4, 0              	#copy the value of t3
	li s5, ','
	li s6, '('
	li s7, ')'
	li a4 '_'
	#and also '_'
	li s8, 0              	#counter
	li s9, 0              	#encrypt form of register
	li s10, 0
	li s11, 0             	# = 1 if valid, = 0 otherwise
	
#check for input then store and print it
#------------------------------------------
#		input	
#continuously read value from memory store
#and handle condition to print or end input
#t0 = where the value is stored
#t1 = temp for load values
#t2 = enter (end of input)
#t3 = position of first space
#t4 =  ' '
#s4 = final position of first space
#------------------------------------------
input:
wait:
	lw t1, 0(a1)
	beq t1, zero, wait
    
read_key:
	lw t1, 0(a0)
	jal store		#if input found then jump right to store
	beq t1, t2, end_input
	beqz t3, print_opcode	
	
after_print:
	beq t1, t4, opcode
	j input

store:
	addi t0, t0, 1
	sb t1, 0(t0)
	jr ra			#return to polling

opcode:
	bne t3, zero, input
	addi t3, t0, 0		#t3 contains the position of the first space (after opcode)
	addi t3, t3, -1
	j input
    
print_opcode:
	li a7, 11
	addi a0, t1, 0
	ecall
	li a0, KEY_CODE
	j after_print
	
end_input:
	addi s4, t3, 0
	addi s4, s4, 1

find_opcode:
	la t0, instruction
    	addi t0, t0, -1
    	exp:
		lb t1, 0(t3)		#load from first space
        		addi t1, t1, -87		#convert ascii to decimal
        		mul t1, t1, t6
        		add s2, s2, t1		#s2 = opcode
        		mul t6, t6, t5
        		addi t3, t3, -1		#right to left (decrement)
        		bne t3, t0, exp 

#------------------------------------
#	format checking	
#loop through each array to find match
#s0 = type number
#t0 = address of opcode array
#t6 = counting iteration
#s3 = number of opcodes in array
#------------------------------------
if_R:
    	li s0, 1
    	la t0, R
    	li t6, 0
    	li s3, 10
    	loop_R:
    	    	lw t3, 0(t0)
        		beq s2, t3, valid_op
       		addi t0, t0, 4
        		addi t6, t6, 1
        		bne t6, s3, loop_R

if_I:
    	li s0, 2
    	la t0, I
    	li t6, 0
    	li s3, 10
    	loop_I:
        		lw t3, 0(t0)
        		beq s2, t3, valid_op
        		addi t0, t0, 4
        		addi t6, t6, 1
        		bne t6, s3, loop_I

if_IS:
    	li s0, 3
    	la t0, IS
    	li t6, 0
    	li s3, 8
    	loop_IS:
        		lw t3, 0(t0)
        		beq s2, t3, valid_op
        		addi t0, t0, 4
        		addi t6, t6, 1
        		bne t6, s3, loop_IS

if_B:
    	li s0, 4
    	la t0, B
    	li t6, 0
    	li s3, 6
    	loop_B:
        		lw t3, 0(t0)
        		beq s2, t3, valid_op
        		addi t0, t0, 4
        		addi t6, t6, 1
        		bne t6, s3, loop_B

if_J:
    	li s0, 5
    	la t0, J
    	li t6, 0
    	li s3, 2
    	loop_J:
        		lw t3, 0(t0)
        		beq s2, t3, valid_op
        		addi t0, t0, 4
        		addi t6, t6, 1
        		bne t6, s3, loop_J
if_U:
    	li s0, 6
    	la t0, U
    	li t6, 0
    	li s3, 2
    	loop_U:
        		lw t3, 0(t0)
        		beq s2, t3, valid_op
        		addi t0, t0, 4
        		addi t6, t6, 1
        		bne t6, s3, loop_U
        		
#print invalid
invalid_op:
    	li a7, 4
    	la a0, invalid_msg
    	ecall
    
    	li a7, 10
    	ecall

#print valid                 
valid_op:
    	li a7, 4
    	la a0, valid_msg
    	ecall
#-------------------------------------------------------
#		operand type sort	
#if opecode is valid then continue checking for operand
#s0 = type number (1-6)
#s11 = status (valid (1)/invalid (0))
#-------------------------------------------------------
    	addi s0, s0, -1
    	beq s0, zero, R_type
    	addi s0, s0, 1
    
    	addi s0, s0, -2
    	beq s0, zero, I_type
   	addi s0, s0, 2
    
    	addi s0, s0, -3
    	beq s0, zero, IS_type
    	addi s0, s0, 3
    
    	addi s0, s0, -4
    	beq s0, zero, B_type
    	addi s0, s0, 4
    
    	addi s0, s0, -5
    	beq s0, zero, J_type
    	addi s0, s0, 5
    
    	addi s0, s0, -6
    	beq s0, zero, U_type
    	addi s0, s0, 6

R_type: #rrr
    	jal check_register
    	beq s11, zero, invalid_operand
    	jal check_register
    	beq s11, zero, invalid_operand
    	jal check_register
    	beq s11, zero, invalid_operand
    	j valid_operand
    	
I_type: #rri
    	jal check_register
    	beq s11, zero, invalid_operand
    	jal check_register
    	beq s11, zero, invalid_operand
    	jal check_immediate
    	beq s11, zero, invalid_operand
    	j valid_operand
    
IS_type: #ror
    	jal check_register
    	beq s11, zero, invalid_operand
    	jal check_offset
   	beq s11, zero, invalid_operand
   	jal check_register
   	beq s11, zero, invalid_operand
    	j valid_operand
    
B_type: #rrl
    	jal check_register
    	beq s11, zero, invalid_operand
    	jal check_register
    	beq s11, zero, invalid_operand
    	jal check_label
    	beq s11, zero, invalid_operand
    	j valid_operand

J_type: #l
    	jal check_label
    	beq s11, zero, invalid_operand
    	j valid_operand
	
U_type: #ri
    	jal check_register
    	beq s11, zero, invalid_operand
    	jal check_immediate
    	beq s11, zero, invalid_operand

valid_operand:
    	li a7, 4
    	la a0, valid_ope
    	ecall
    	li a7, 10
    	ecall
    	
invalid_operand:
    	li a7, 4
    	la a0, invalid_ope
    	ecall
    	li a7, 10
    	ecall
#------------------------------------------------------------
#		operand type checking	
#if check for specific type of operand (reg/imm/offset/label)
#no float cause it's too long =)))
#s0 = type number (1-6)
#s11 = status (valid (1)/invalid (0))
#------------------------------------------------------------
check_register:
    	addi s4, s4, 1		#check next
    	lb t1, 0(s4)
    	
    	#skip these characters
    	beq t1, t2, invalid_register	#t2 = enter
    	beq t1, t4, check_register	#t4 = space
    	beq t1, s5, check_register	#s5 = comma
    	beq t1, s6, check_register	#s6 = left parentheses
    
    	addi s4, s4, -1		#if no, redo and continue checking
    	li s8, 0			#counter = 0
    	loop_check_register:
        		addi s4, s4, 1
        		lb t1, 0(s4)
        		beq t1, t2, end_check_register
        		beq t1, t4, end_check_register
        		beq t1, s5, end_check_register
        		beq t1, s7, end_check_register 	#s7 = right_parentheses
        		addi s8, s8, 1
        		addi t1, t1, -38		#conver from ascii to decimal
        		addi sp, sp, -4		#store back into stack
        		sb t1, 0(sp)
        		j loop_check_register
   	end_check_register:
   		li t6, 1
   		li s9, 0
   		li t5, 100
   	loop_change_into_number:		#convert value to number
        		addi s8, s8, -1
        		lb t1, 0(sp)
        		mul t1, t1, t6
        		add s9, s9, t1
        		mul t6, t6, t5
        		addi sp, sp, 4
        		bne s8, zero, loop_change_into_number
   	li s3, 64			#number of registers
   	li s8, 0
   	la s10, register_name
   	loop_check_valid:
        		addi s8, s8, 1
        		lw t1, 0(s10)
        		beq s9, t1, valid_register
        		addi s10, s10, 4
        		bne s8, s3, loop_check_valid
   	invalid_register:
       		li s11, 0
        		jr ra
   	valid_register:
       		li s11, 1
        		jr ra     

check_immediate:
	#signed/unsigned
    	li t5, '-'
    	li t6, '+'
    	addi s4, s4, 1		#check next
    	lb t1, 0(s4)
    	
    	#skip these characters
    	beq t1, t2, invalid_immediate
    	beq t1, t4, check_immediate
    	beq t1, s5, check_immediate
    	beq t1, s6, check_immediate
    	
    	#handle hexadecimal
    	li s0, 48		#ascii for 0(x__)
    	bne t1, s0, skip_0x	#skip hex check
    	li s0, 120		#ascii for x(___)
    	lb t1, 1(s4)
    	addi s4, s4, 2		#skip 0x
    	bne t1, s0, invalid_immediate
    	skip_0x:
	    	addi s4, s4, -1
	    	li t5, '0'
	    	li t6, '9'
    	loop_check_immediate:
       		addi s4, s4, 1
	        lb t1, 0(s4)
	        beq t1, t2, end_check_immediate
	        beq t1, t4, end_check_immediate
	        beq t1, s5, end_check_immediate
	        beq t1, s7, end_check_immediate 
	        blt t1, t5, invalid_immediate
	        blt t6, t1, invalid_immediate
        		j loop_check_immediate
   	end_check_immediate:
   
   	valid_immediate:
	        li s11, 1
	        jr ra
   	invalid_immediate:
	        li s11, 0
	        jr ra 
       
check_offset:
	#signed/unsigned
	li t5, '-'
    	li t6, '+'
    	addi s4, s4, 1		#check next
    	lb t1, 0(s4)
    	
    	#skip these characters
    	beq t1, t2, invalid_offset
    	beq t1, t4, check_offset
    	beq t1, s5, check_offset
    	beq t1, s6, check_offset

    	addi s4, s4, -1
    	li t5, '0'
    	li t6, '9'
    	loop_check_offset:
	        addi s4, s4, 1
	        lb t1, 0(s4)
	        beq t1, t2, invalid_offset
	        beq t1, t4, end_check_offset
	        beq t1, s5, end_check_offset
	        beq t1, s6, valid_offset		#x(_)
	        beq t1, s7, invalid_offset 
	        blt t1, t5, invalid_offset	#not number
	        blt t6, t1, invalid_offset
	        j loop_check_offset
   	end_check_offset:
   
   	valid_offset:
	        li s11, 1
	        jr ra
   	invalid_offset:
	        li s11, 0
	        jr ra 
	
check_label:
    	addi s4, s4, 1		#check next
    	lb t1, 0(s4)
    	
    	#skip these characters
    	beq t1, t2, invalid_label
    	beq t1, t4, check_label
    	beq t1, a4, check_label
    	beq t1, s6, invalid_label
    	beq t1, s7, invalid_label
  
    	addi s4, s4, -1
    	li t5, 'A'		#valid character range
    	li t6, 'Z'
    	addi t6, t6, 1
    	li a5, 'a'
    	addi a5, a5, -1
    	li a6, 'z'
    	li a7, '_'
    	loop_check_label:
	        addi s4, s4, 1
	        lb t1, 0(s4)
	        beq t1, t2, end_check_label
	        beq t1, t4, end_check_label
	        beq t1, s7, loop_check_label
	        beq t1, a4, loop_check_label
	        blt t1, t5, invalid_label
	        blt a6, t1, invalid_label
	        blt t1, t6, loop_check_label
	        blt a5, t1, loop_check_label
	        j invalid_label
   	end_check_label:
   
   	valid_label:
	        li s11, 1
	        jr ra
	invalid_label:
	        li s11, 0
	        jr ra 
