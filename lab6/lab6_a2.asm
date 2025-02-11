.data
A: .word -3, 4, -8, -7, 5, 1, -14, -15, 6, 10
Aend: .word


.text
main:
la a0, A # a0 = address(A[0])
la a1, Aend
addi a1, a1, -4 # a1 = address(A[n-1])
j sort # sort

after_sort:
li a7, 10
ecall

end_main:

sort:
beq a0, a1, done # single element list is sorted
j max # call the max procedure

after_max:
lw t0, 0(a1) # load last element into $t0
sw t0, 0(s0) # copy last element to max location
sw s1, 0(a1) # copy max value to last element
addi a1, a1, -4 # decrement pointer to last element
j sort # repeat sort for smaller list

done:
j after_sort

max:
addi s0, a0, 0 # init max pointer to first element
lw s1, 0(s0) # init max value to first value
addi t0, a0, 0 # init next pointer to first

loop:
beq t0, a1, ret # if next=last, return
addi t0, t0, 4 # advance to next element

lw t1, 0(t0) # load next element into $t1
blt t1, s1, loop # if (next)<(max), repeat
addi s0, t0, 0 # next element is new max element
addi s1, t1, 0 # next value is new max value
j loop

ret:
j after_max



print_array:
   addi  t0, a0, 0          # t0 = first element pointer
   addi  t1, a1, 0          # t1 = last element pointer

print_loop:
   bgt   t0, t1, print_done # if first > last, we're done
   lw    a0, 0(t0)          # load the current element into a0
   li    a7, 1              # syscall for print integer
   ecall                    # make syscall to print integer
   la    a0, newline        # load address of newline
   li    a7, 4              # syscall for print string
   ecall                    # print newline
   addi  t0, t0, 4          # move to next element
   j     print_loop         # repeat the loop

print_done:
   jr    ra                 # return from print_array