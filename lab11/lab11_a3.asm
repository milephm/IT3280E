.eqv IN_ADDRESS_HEXA_KEYBOARD       0xFFFF0012 
.eqv OUT_ADDRESS_HEXA_KEYBOARD      0xFFFF0014 
.data 
	message: .asciz "Key scan code: " 
# ----------------------------------------------------------------- 
# MAIN Procedure 
# ----------------------------------------------------------------- 
.text 
main: 
	# Load the interrupt service routine address to the UTVEC register 
	la      t0, handler 
	csrrs   zero, utvec, t0 
	   
	# Set the UEIE (User External Interrupt Enable) bit in UIE register 
	li      t1, 0x100 
	csrrs   zero, uie, t1       
	# Set the UIE (User Interrupt Enable) bit in USTATUS register 
	csrrsi  zero, ustatus, 0x1  
 
	# Enable the interrupt of keypad of Digital Lab Sim 
	li      t1, IN_ADDRESS_HEXA_KEYBOARD 
	li      t3, 0x80  # bit 7 = 1 to enable interrupt    
	sb      t3, 0(t1) 
 
    # --------------------------------------------------------- 
    # Loop to print a sequence numbers 
    # --------------------------------------------------------- 
	xor     s0, s0, s0      # count = s0 = 0 
loop:    
	addi    s0, s0, 1       # count = count + 1 
prn_seq: 
	addi    a7, zero, 1     
	mv      a0, s0          # Print auto sequence number  
	ecall 
	addi    a7, zero, 11 
	li      a0, '\n'        # Print EOL 
	ecall 
sleep:   
	addi    a7, zero, 32           
	li      a0, 300         # Sleep 300 ms 
	ecall 
	j       loop 
end_main: 
 
# ----------------------------------------------------------------- 
# Interrupt service routine 
# ----------------------------------------------------------------- 
handler: 
    # Save context 
	addi    sp, sp, -16 
	sw      a0, 0(sp) 
	sw      a7, 4(sp) 
	sw      t1, 8(sp) 
	sw      t2, 12(sp) 
     
prn_msg: 
	addi    a7, zero, 4      
	la      a0, message 
	ecall 

get_key_code: 
	li      t2, 0x01       		# start with row 1 
row_scan:
	li      t1, IN_ADDRESS_HEXA_KEYBOARD 
	sb      t2, 0(t1)       		# Activate row 
	li      t1, OUT_ADDRESS_HEXA_KEYBOARD 
	lb      a0, 0(t1)       		# read key scan code 
	bnez    a0, prn_key_code 		# if non-zero, key is detected

	slli    t2, t2, 1       		# move to the next row 
	li      t3, 0x10        		# 0x10 for 4 rows (0x01, 0x02, 0x04, 0x08)
	blt     t2, t3, row_scan
	li      t2, 0x01 

	j       clear_interrupt            	# no key detected

prn_key_code: 
	li      a7, 34           
	ecall 
	li      a7, 11 
	li      a0, '\n'        # Print EOL 
	ecall  
	    
wait_key_release: 
	li      t1, OUT_ADDRESS_HEXA_KEYBOARD 
	lb      a0, 0(t1)       		# Read the current state 
	bnez    a0, wait_key_release 		# Wait until key is released

clear_interrupt:
	li      t1, IN_ADDRESS_HEXA_KEYBOARD 
	li      t3, 0x80        		# Re-enable interrupt bit 
	sb      t3, 0(t1) 
	j       restore_context 
    
restore_context: 
    # Restore context 

	lw      t2, 12(sp) 
	lw      t1, 8(sp) 
	lw      a7, 4(sp) 
	lw      a0, 0(sp) 
	addi    sp, sp, 16 
 
    # Back to the main procedure 
	uret
