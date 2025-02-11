# Laboratory Exercise 3, Assignment 6
.data
array: .word -4, 7, -12, 5, 3, -8, 11, 2  # array
largest_abs: .word 0                    # store largest_abs

.text
main:
	la t0, array        # address of array
	li t1, 8            # array size
	li t2, 0            # i = 0
	li t3, 0            # largest_abs = 0

loop:
	bge t2, t1, endloop  # if i >= n, exit loop
	lw t4, 0(t0)         # load array[i] into t4
	blt t4, zero, neg     # if array[i] < 0, negate

neg:
	sub t4, zero, t4      # get absolute value
	bgt t4, t3, update    # if abs > largest_abs, update
	j continue

update:
	addi t3, t4, 0          # update largest_abs

continue:
	addi t0, t0, 4        # increment address
	addi t2, t2, 1        # increment index
	j loop                # go to the loop

endloop:
	la t5, largest_abs     # load address of largest_abs
	sw t3, 0(t5)          # store largest_abs in memory
