# Laboratory Exercise 5, Home Assignment 3
.data
x:     .space 32        #destination string x, empty
y:     .asciz "Hello hmp"  # source string y
msg:   .asciz "Copied string: "  # message for output

.text
.globl main
main:
    #copy y to x
    la a0, x             
    la a1, y            
    jal ra, strcpy    

    #print message
    li a7, 4            
    la a0, msg         
    ecall            

    #print the copied string
    li a7, 4            
    la a0, x           
    ecall               

    #exit
    li a7, 10           
    ecall               	

#strcpy function: copy string from a1 to a0
strcpy:
    add s0, zero, zero   #s0 = i0 = 0

strcpy_loop:
    add t1, a1, s0       #t1 = a1 + s0 = y[0] + i = address of y[i]
    lb  t2, 0(t1)        #t2 = value at t1 = y[1]
    add t3, a0, s0       #t3 = s0 + a0 = i + x[0] = address of x[i]
    sb  t2, 0(t3)        #x[i] = t2 = y[i]
    beq t2, zero, end_of_strcpy #if y[i] ==0, exit
    addi s0, s0, 1       #s0=s0 + 1 <-> i=i+1
    j strcpy_loop        #next characterp

end_of_strcpy:
    jr ra                #return to caller
