# Laboratory Exercise 5, Home Assignment 3 
.data 
string: .space 50 
message1: .asciz  "Nhap xau: " 
message2: .asciz  "Do dai xau la: "
newline:  .asciz "\n"                
 
.text 
main: 
    li a7, 4
    la a0, message1
    ecall
get_string: 
    li a7, 8
    la a0, string
    li a1, 50
    ecall
get_length:  
   la    a0, string           # a0 = address(string[0]) 
   li    t0, 0                # t0 = i = 0 
check_char:  
   add   t1, a0, t0           # t1 = a0 + t0 = address(string[0]+i)  
   lb    t2, 0(t1)            # t2 = string[i] 
   beq   t2, zero, end_of_str # Is null char?  
   addi  t0, t0, 1            # t0 = t0 + 1 -> i = i + 1 
   j  check_char 
end_of_str:   
print_length:  
    #print message before string length
    li a7, 4                          
    la a0, message2                   
    ecall

    #print the string length (t0 contains the length)
    mv a0, t0                         
    li a7, 1                          
    ecall

    #print newline character
    li a7, 4                          
    la a0, newline                    
    ecall

    #exit program
    li a7, 10                        
    ecall