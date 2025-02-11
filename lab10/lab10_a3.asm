.eqv MONITOR_SCREEN 0x10010000  
.eqv RED            0x00FF0000  
.eqv GREEN          0x0000FF00 
.eqv BLUE           0x000000FF 
.eqv WHITE          0x00FFFFFF  
.eqv YELLOW         0x00FFFF00 

.text
	li  t1, 0x10010180
	li  a0, MONITOR_SCREEN 
	li  t0, WHITE
    
start:
	li t2, 4
	j cont1 

loop1:
	li t2, 4 
	addi a0,a0 4

cont1:
	sw  t0, 0(a0)
	addi a0,a0,8
	bgt a0,t1, exit
	addi t2,t2,-1 
	beqz t2,loop2 
    
j cont1
 
loop2:
	li t2,4
	addi a0,a0,4

cont2:
	sw  t0, 0(a0)
	bgt a0,t1, exit 
	addi t2,t2,-1 
	beqz t2,loop1 
	addi a0,a0,8 
	j cont2
    
exit:
	li a7,10
	ecall	