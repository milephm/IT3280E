.data
student_id: .asciz "20235977"
ascii_msg: .asciz "\nInput: "
output_msg: .asciz "\nOutput: "

.eqv SEVENSEG_LEFT 0xFFFF0011 	# Address of the LED on the left
				# Bit 0 = segment a
				# Bit 1 = segment b
				# ...
				# Bit 7 = dot sign
.eqv SEVENSEG_RIGHT 0xFFFF0010 	# Address of the LED on the right

.text
main:
	# Display last 2 digits
	la t0, student_id
	li t1, 6
	add t0, t0, t1
	lb t2, 0(t0)
	lb t3, 1(t0)
	addi a0, t2, -48
	jal SHOW_7SEG_LEFT 	# Show the result
	addi a0, t3, -48
	jal SHOW_7SEG_RIGHT 	# Show the result
exit:
	li a7, 10
	ecall
end_main:
# ---------------------------------------------------------------
# Function SHOW_7SEG_LEFT : Turn on/off the 7seg
# param[in] a0 value to shown
# remark t0 changed
# ---------------------------------------------------------------
SHOW_7SEG_LEFT:
	li t0, SEVENSEG_LEFT 	# Assign port's address
	sb a0, 0(t0) 		# Assign new value
	jr ra
# ---------------------------------------------------------------
# Function SHOW_7SEG_RIGHT : Turn on/off the 7seg
# param[in] a0 value to shown
# remark t0 changed
# ---------------------------------------------------------------
SHOW_7SEG_RIGHT:
	li t0, SEVENSEG_RIGHT 	# Assign port's address
	sb a0, 0(t0) 		# Assign new value
	jr ra