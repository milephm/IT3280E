# Laboratory Exercise 3, Home Assignment 2  (Modified for A[i] != 0)
.data
A: .word 1, 3, 0, 5, 4, 7, 8, 9, 6
.text
    li s1, 0        # i = 0 
    li s5, 0        # sum = 0
    la s2, A        # s2 stores the address of A (array)
    li s3, 9        # n = size of array
    li s4, 1        # step = 1 (can change for different test cases)
loop:
    add t1, s1, s1 # t1 = 2 * s1
    add t1, t1, t1 # t1 = 4 * s1 => t1 = 4 * i
    add t1, t1, A # t1 store the address of A[i]
    lw t0, 0(t1) # load value of A[i] into t0
    beq t0, zero, endloop # if A[i] == 0, end loop

    add s5, s5, t0 # sum = sum + A[i]
    add s1, s1, 1 # i = i + 1

    j loop # go to loop
endloop:


