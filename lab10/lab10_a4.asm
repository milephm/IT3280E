.eqv KEY_CODE   0xFFFF0004	# ASCII code from keyboard, 1 byte 
.eqv KEY_READY  0xFFFF0000	# =1 if has a new keycode ? 
				# Auto clear after lw 
				
.eqv DISPLAY_CODE   0xFFFF000C	# ASCII code to show, 1 byte 
.eqv DISPLAY_READY  0xFFFF0008	# =1 if the display has already to do 
				# Auto clear after sw 
.eqv LOWERCASE_MIN, 0x61  	# ASCII 'a'
.eqv LOWERCASE_MAX, 0x7A   	# ASCII 'z'
.eqv UPPERCASE_MIN, 0x41   	# ASCII 'A'
.eqv UPPERCASE_MAX, 0x5A   	# ASCII 'Z'

.eqv DIGIT_MIN, 0x30
.eqv DIGIT_MAX, 0x39

.data
exit: .asciz "exit" 
asterisk: .byte 0x2A # ASCII code for '*'

.text 
	la  s2, exit
	li  t4, 0		# counter matching
	li  a0, KEY_CODE 
	li  a1, KEY_READY 
	li  s0, DISPLAY_CODE 
	li  s1, DISPLAY_READY 

loop:       
WaitForKey:   
	lw      t1, 0(a1)               # t1 = [a1] = KEY_READY 
	beq     t1, zero, WaitForKey    # if t1 == 0 then Polling 
	
ReadKey:      
	lw      t0, 0(a0)               # t0 = [a0] = KEY_CODE 
	
WaitForDis:   
	lw      t2, 0(s1)               # t2 = [s1] = DISPLAY_READY 
	beq     t2, zero, WaitForDis    # if t2 == 0 then polling  
	
check_exit:
	lb      t3, 0(s2)              
	beq     t3, zero, ShowKey      
	bne     t0, t3, reset          
	addi    t4, t4, 1              
	addi    s2, s2, 1              
	li      t3, 4                  
	beq     t4, t3, program_exit   
	j       loop                   

reset:
	la      s2, exit
	li      t4, 0
	j       check
	   
check:
	li      t1, LOWERCASE_MIN    # t1 = 'a'
	li      t2, LOWERCASE_MAX    # t2 = 'z'
	blt     t0, t1, check_upper  # If t0 < 'a', check if it's a digit
	ble     t0, t2, uppercase    # If t0 between 'a' and 'z', it's lowercase

check_upper:
	li      t1, UPPERCASE_MIN    # t1 = 'A'
	li      t2, UPPERCASE_MAX    # t2 = 'Z'
	blt     t0, t1, check_digit  # If t0 < 'A', check if it's a digit
	ble     t0, t2, lowercase    # If t0 between 'A' and 'Z', it's uppercase
   
check_digit:
	li      t1, DIGIT_MIN 	# t1 = 0
	li      t2, DIGIT_MAX 	# t2 = 9
	blt     t0, t1, display_asterisk
	ble     t0, t2, ShowKey   

display_asterisk:
	la      t0, asterisk
	lb      t0, 0(t0)
	j       ShowKey

uppercase:      
	addi    t0, t0, -32               # change input key 
	j ShowKey

lowercase:
	addi	t0, t0, 32		 # change input key 
	j ShowKey
	
ShowKey: 
	sw      t0, 0(s0)               # show key                
	j       loop

program_exit:
	li a7, 10
	ecall