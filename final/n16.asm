#b16 g?c
#NOTE: this is NOT complete since the problem requires you to parse string of parameters not array as in this code soooo...
.eqv IN_ADDRESS_HEXA_KEYBOARD       0xFFFF0012 
.eqv OUT_ADDRESS_HEXA_KEYBOARD      0xFFFF0014 

#song data for each song script: [Pitch, Duration, Instrument Type, Volume].
#seperated by line break for easier view
#customize song of your choice by getting the sheet music/notes then run it through some AI chatbot to generate song script
.data
song1:	
	.word 67, 250, 80, 60
	 67, 250, 80, 60
	 67, 250, 80, 60
	 69, 250, 80, 60
	 69, 250, 80, 60
	 69, 250, 80, 60
	 70, 500, 80, 60
	 67, 250, 80, 60
	 67, 250, 80, 60
	 67, 250, 80, 60
	 69, 250, 80, 60
	 69, 250, 80, 60
	 69, 250, 80, 60
	 70, 500, 80, 60
	 67, 250, 80, 60
	 67, 250, 80, 60
	 67, 250, 80, 60
	 69, 250, 80, 60
	 69, 250, 80, 60
	 69, 250, 80, 60
	 70, 500, 80, 60
	 67, 250, 80, 60
	 67, 250, 80, 60
	 67, 250, 80, 60
	 69, 250, 80, 60
	 69, 250, 80, 60
	 69, 250, 80, 60
	 70, 500, 80, 60
	 93, 250, 80, 60
	 91, 250, 80, 60
	 89, 250, 80, 60
	 88, 250, 80, 60
	 86, 250, 80, 60
	 88, 500, 80, 60
	 93, 250, 80, 60
	 91, 250, 80, 60
	 89, 250, 80, 60
	 88, 250, 80, 60
	 86, 250, 80, 60
	 88, 500, 80, 60
	 93, 250, 80, 60
	 91, 250, 80, 60
	 89, 250, 80, 60
	 88, 250, 80, 60
	 86, 250, 80, 60
	 88, 500, 80, 60
	 93, 250, 80, 60
	 91, 250, 80, 60
	 89, 250, 80, 60
	 88, 250, 80, 60
	 86, 250, 80, 60
	 88, 500, 80, 60
	 0
song2:	
	.word 60, 500, 7, 100
	 60, 500, 7, 100
	 62, 500, 7, 100
	 64, 500, 7, 100
	 65, 500, 7, 100
	 64, 500, 7, 100
	 62, 500, 7, 100
	 60, 500, 7, 100
	 60, 500, 7, 100
	 60, 500, 7, 100
	 62, 500, 7, 100
	 64, 500, 7, 100
	 65, 500, 7, 100
	 64, 500, 7, 100
	 62, 500, 7, 100
	 60, 500, 7, 100
	 60, 500, 7, 100
	 62, 500, 7, 100
	 64, 500, 7, 100
	 65, 500, 7, 100
	 64, 500, 7, 100
	 62, 500, 7, 100
	 60, 500, 7, 100
	 0
song3:	
	 60, 250, 80, 60	# C
	 55, 250, 80, 60	# G(4)
	 60, 250, 80, 60	# C
	 67, 250, 80, 60	# G
	 65, 250, 80, 60	# F
	 64, 250, 80, 60	# E
	 62, 250, 80, 60	# D
	 59, 250, 80, 60	# B
	 59, 250, 80, 60	# B(4)
	 55, 250, 80, 60	# G(4)
	 59, 250, 80, 60	# B(4)
	 64, 250, 80, 60	# E
	 62, 250, 80, 60	# D
	 59, 250, 80, 60	# B
	 60, 250, 80, 60	# C
	 64, 250, 80, 60	# C
	 60, 250, 80, 60	# C
	 55, 250, 80, 60	# G(4)
	 60, 250, 80, 60	# C
	 67, 250, 80, 60	# G
	 65, 250, 80, 60	# F
	 64, 250, 80, 60	# E
	 62, 250, 80, 60	# D
	 59, 250, 80, 60	# B
	 59, 250, 80, 60	# B(4)
	 55, 250, 80, 60	# G(4)
	 59, 250, 80, 60	# B(4)
	 64, 250, 80, 60	# E
	 62, 250, 80, 60	# D
	 59, 250, 80, 60	# B
	 60, 250, 80, 60	# C
	 64, 250, 80, 60	# C
	 0       
song4:	
	 62, 250, 80, 60	# D
	 62, 250, 80, 60	# D
	 63, 250, 80, 60	# Eb
	 65, 300, 80, 60	# F
	 62, 250, 80, 60	# D
	 62, 250, 80, 60	# D
	 62, 250, 80, 60	# D
	 60, 250, 80, 60	# C
	 62, 250, 80, 60	# D
	 60, 250, 80, 60	# C
	 62, 300, 80, 60	# D
	 60, 250, 80, 60	# C
	 60, 500, 80, 60	# C (long)
	 62, 250, 80, 60	# D
	 60, 250, 80, 60	# C
	 62, 250, 80, 60	# D
	 60, 250, 80, 60	# C
	 62, 250, 80, 60	# D
	 60, 250, 80, 60	# C
	 62, 250, 80, 60	# D
	 60, 300, 80, 60	# C
	 60, 500, 80, 60	# C (long)
	 62, 250, 80, 60	# D
	 63, 250, 80, 60	# Eb
	 62, 250, 80, 60	# D
	 63, 250, 80, 60	# Eb
	 65, 300, 80, 60	# F
	 58, 250, 80, 60	# Bb
	 62, 250, 80, 60	# D
	 60, 300, 80, 60	# C
	 60, 300, 80, 60	# C
	 0
no_song: 

#key mappings for selecting songs (1-4) or pausing (0)
mapping:
	.word 0x21, song1	#1 -> song1
	.word 0x41, song2	#2 -> song2
	.word 0x81, song3	#3 -> song3
	.word 0x12, song4	#4 -> song4
	.word 0x11, no_song	#0 -> pause music
	.word 0			#end

playing: .asciz "Playing song...\n"
paused: .asciz "Music paused.\n"

.text
.globl main
main:
	li	s1, IN_ADDRESS_HEXA_KEYBOARD 
	li	s2, OUT_ADDRESS_HEXA_KEYBOARD 
	li	t3, 0x01        	# check row
	
polling:          
	sb	t3, 0(s1)       	#must reassign expected row 
	lbu	a0, 0(s2)       	#read scan code of key button 
	beqz	a0, no_key_pressed 	#check if key is pressed
	
	li	t1, 17			#define 0 = pause
	beq	a0, t1, pause
	
	mv	a0, a0			#store key value in a0
	call	find
	beqz	a0, polling
	call	play_song
	
	li	a0, 300			#delay
	li	a7, 32
	ecall

no_key_pressed:
	slli t3, t3, 1		#shift left to get the next row
	li t4, 0x10		#maximum value for row is 0x04 (row 2)
	bne t3, t4, polling	#if not reached row, continue polling
	li t3, 0x01		#reset to start
	
pause:
	li	a7, 33		#syscall to pause the music
	ecall
	li	a7, 4
	la	a0, paused	#load "Music paused." message
	ecall
	j polling   
	 
#function to find which song corresponds to the pressed key
find:
	la	t0, mapping	#load address of key map
	
loop_f:
	lw	t1, 0(t0)	#load key value from key value
	beqz	t1, none
	bne	a0, t1, next
	lw	a0, 4(t0)	#if found match, load corresponding data
	ret			#return

next:
	addi	t0, t0, 8	#move to next key
	j	loop_f

none:
	li	a0, 0
	ret 

#function to play the selected song
play_song:
	mv	t0, a0		#load song data address
	li	a7, 4
	la	a0, playing
	ecall
loop_p:
	lbu	t1, 0(s2)	#check if the key is still pressed (if not, stop)
	li	t2, 0x00
	beq	t1, t2, return	#if no key is pressed, exit
		
	lw	t1, 0(t0)	#get the pitch of the current note
	beqz	t1, return	#if pitch is 0, end of song
		
	lw	a0, 0(t0)	#pitch
	lw	a1, 4(t0)	#duration
	lw	a2, 8(t0)	#instrument type
	lw	a3, 12(t0)	#volume
		
	li	a7, 33		#syscall play sound
	ecall
		
	addi	t0, t0, 16	#move to the next note
	j	loop_p

return:
	ret
