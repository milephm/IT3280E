.text
.global main
main:
    # load 8 integers into registers a0 to a7
    li a0, 5   
    li a1, -2
    li a2, 7
    li a3, 9
    li a4, 1
    li a5, 3
    li a6, -3
    li a7, 4

    jal find_max_min

    # cxit program
    li a7, 10  
    ecall

# --------------------------------------------------------------------
# Syntax:
#   s0: largest value
#   s1: position of the largest value
#   s2: smallest value
#   s3: position of the smallest value
# --------------------------------------------------------------------

find_max_min:
    addi s0, a0, 0       # s0 = largest value
    li s1, 0        # s1 = largest value position (index 0)
    addi s2, a0, 0       # s2 = smallest value
    li s3, 0        # s3 = smallest value position (index 0)

    # compare each register from a1 to a7
    li t0, 1        # Index counter

    # compare a1
    bgt a1, s0, update_max_1
    blt a1, s2, update_min_1
    j compare_a2

update_max_1:
    addi s0, a1, 0
    addi s1, t0, 0
    j compare_a2

update_min_1:
    addi s2, a1, 0
    addi s3, t0, 0
    j compare_a2

compare_a2:
    addi t0, t0, 1
    bgt a2, s0, update_max_2
    blt a2, s2, update_min_2
    j compare_a3

update_max_2:
    addi s0, a2, 0
    addi s1, t0, 0
    j compare_a3

update_min_2:
    addi s2, a2, 0
    addi s3, t0, 0
    j compare_a3

compare_a3:
    addi t0, t0, 1
    bgt a3, s0, update_max_3
    blt a3, s2, update_min_3
    j compare_a4

update_max_3:
    addi s0, a3, 0
    addi s1, t0, 0
    j compare_a4

update_min_3:
    addi s2, a3, 0
    addi s3, t0, 0
    j compare_a4

compare_a4:
    addi t0, t0, 1
    bgt a4, s0, update_max_4
    blt a4, s2, update_min_4
    j compare_a5

update_max_4:
    addi s0, a4, 0
    addi s1, t0, 0
    j compare_a5

update_min_4:
    addi s2, a4, 0
    addi s3, t0, 0
    j compare_a5

compare_a5:
    addi t0, t0, 1
    bgt a5, s0, update_max_5
    blt a5, s2, update_min_5
    j compare_a6

update_max_5:
    addi s0, a5, 0
    addi s1, t0, 0
    j compare_a6

update_min_5:
    addi s2, a5, 0
    addi s3, t0, 0
    j compare_a6

compare_a6:
    addi t0, t0, 1
    bgt a6, s0, update_max_6
    blt a6, s2, update_min_6
    j compare_a7

update_max_6:
    addi s0, a6, 0
    addi s1, t0, 0
    j compare_a7

update_min_6:
    addi s2, a6, 0
    addi s3, t0, 0
    j compare_a7

compare_a7:
    addi t0, t0, 1
    bgt a7, s0, update_max_7
    blt a7, s2, update_min_7
    j ret_from_sub

update_max_7:
    addi s0, a7, 0
    addi s1, t0, 0
    j ret_from_sub

update_min_7:
    addi s2, a7, 0
    addi s3, t0, 0

ret_from_sub:
    ret        # Return from subroutine
