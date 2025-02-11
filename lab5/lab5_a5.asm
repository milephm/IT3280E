# Laboratory Exercise 5, Assignment 5
.data
string:    .space 21           # buffer for up to 20 characters plus null terminator
message1:  .asciz "Enter a string (max 20 characters): "   # input prompt
newline:   .asciz "\n"         # newline for formatting
msg_reverse: .asciz "Reversed string: "   # reversed string message

.text
.globl main
main:
    # print input prompt
    li a7, 4                  
    la a0, message1           
    ecall                     

    # get input string
    jal ra, input_string       

    # reverse string
    jal ra, reverse_string     

    # print reversed string message
    li a7, 4                  
    la a0, msg_reverse        
    ecall                     

    # print reversed string
    li a7, 4                  
    la a0, string             
    ecall                     

    # print newline
    li a7, 4                  
    la a0, newline            
    ecall                     

    # exit program
    li a7, 10                 
    ecall                     

input_string:
    li t0, 0                  # initialize index

input_loop:
    li a7, 12                 # read character
    ecall                     
    mv t1, a0                 
    li t2, 10                 # enter key
    beq t1, t2, input_end     # stop if enter
    la t3, string             
    add t3, t3, t0            
    sb t1, 0(t3)              # store character
    addi t0, t0, 1            # increment index
    li t4, 20                 # max length check
    bge t0, t4, input_end     
    j input_loop              

input_end:
    la t3, string             
    add t3, t3, t0            
    sb zero, 0(t3)            # store null terminator
    jr ra                     

reverse_string:
    li t1, 0                  # start index
    la t5, string             
    li t0, 0                  # string length
    mv t2, t5                 

length_loop:
    lb t3, 0(t2)              
    beq t3, zero, length_done 
    addi t2, t2, 1            
    addi t0, t0, 1            
    j length_loop             

length_done:
    addi t4, t0, -1           

reverse_loop:
    bge t1, t4, reverse_end   
    add t2, t5, t1            
    add t6, t5, t4            
    lb t3, 0(t2)              
    lb a0, 0(t6)              
    sb a0, 0(t2)              
    sb t3, 0(t6)              
    addi t1, t1, 1            
    addi t4, t4, -1           
    j reverse_loop            

reverse_end:
    jr ra                     