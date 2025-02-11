.data
A:      .word -3, 4, -8, -7, 5, 1, -14, -15
n:      .word 8                                      

.text
main:
    la    a0, A          # a0 = address(A[0]) 
    lw    a1, n          # size of array
    jal   insertion_sort

    la    a0, A          # a0 = address(A[0]) 
    lw    a1, n          # reload size of array

exit:  
    li    a7, 10        
    ecall

# --------------------------------------------------------------
# Procedure insertion_sort
# register usage:
# a0: pointer to base of array A
# a1: number of elements in array (n)
# t0: loop index i
# t1: loop index j
# t2: key element to be inserted
# t3: address of A[j]
# t4: key value
# t5: temporary storage for A[j]
# --------------------------------------------------------------

insertion_sort:
    addi  t0, zero, 1      # i starts from 1 (second element)

outer_loop:
    bge   t0, a1, end_sort # if i >= n, end sorting
    slli  t1, t0, 2        # t1 = i * 4 (byte offset for A[i])
    add   t3, a0, t1       # address of A[i]
    lw    t4, 0(t3)        # key = A[i]

    addi  t1, t0, -1       # j = i - 1

inner_loop:
    blt   t1, zero, insert_key # if j < 0, insert the key
    slli  t5, t1, 2        # t5 = j * 4 (byte offset for A[j])
    add   t6, a0, t5       # address of A[j]
    
    lw    t2, 0(t6)        # load A[j] into t2 for comparison

    bgt   t2, t4, shift    # if A[j] > key, shift A[j] right

    j     insert_key

shift:
    sw    t2, 4(t6)        # A[j+1] = A[j]
    addi  t1, t1, -1       # j--

    j     inner_loop

insert_key:
    sw    t4, 0(t6)        # A[j+1] = key (insert the key)
    addi  t0, t0, 1        # i++
    j     outer_loop

end_sort:
    jr    ra               # return from insertion_sort