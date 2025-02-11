.data
A:      .word -3, 4, -8, -7, 5, 1, -14, -15
n:      .word 8                                      
newline: .asciz "\n"  # Use .asciiz instead of .ascii

.text
main:
    la    a0, A          # a0 = address(A[0]) 
    lw    a1, n          # size of array
    jal   bubble_sort

    la    a0, A          # a0 = address(A[0]) 
    lw    a1, n          # reload size of array
    jal   print_array   
exit:  
    li    a7, 10        
    ecall

# --------------------------------------------------------------
# Procedure bubble_sort
# register usage:
# a0: pointer to base of array A
# a1: number of elements in array (n)
# t0: loop index i
# t1: loop index j
# t2: temporary variable for array value swap
# t3: element at index j
# t4: element at index j+1
# --------------------------------------------------------------

bubble_sort:
    addi  t0, zero, 0      # i = 0

outer_loop:
    blt   t0, a1, inner_loop_init # while (i < n)
    j     end_sort

inner_loop_init:
    addi  t1, zero, 0      # j = 0

inner_loop:
    sub   t5, a1, t0       # n - i
    addi  t5, t5, -1       # n - i - 1
    blt   t1, t5, compare_swap # while (j < n - i - 1)
    addi  t0, t0, 1        # i++
    j     outer_loop

compare_swap:
    slli   t2, t1, 2        # t2 = j * 4 (byte offset for A[j])
    add   t3, a0, t2       # t3 = address of A[j]
    lw    t4, 0(t3)        # t4 = A[j]
    lw    t5, 4(t3)        # t5 = A[j+1]

    bgt   t4, t5, swap     # if A[j] > A[j+1], swap
    j     next

swap:
    sw    t5, 0(t3)        # A[j] = A[j+1]
    sw    t4, 4(t3)        # A[j+1] = A[j]

next:
    addi  t1, t1, 1        # j++
    j     inner_loop

end_sort:
    jr    ra               # return from bubble_sort
    