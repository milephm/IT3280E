.data
x1:     .word 0
y1:     .word 0
x2:     .word 0
y2:     .word 0

.text
.eqv MONITOR_SCREEN 0x10010000
.eqv RED            0x00FF0000
.eqv GREEN          0x0000FF00

.globl main

main:
    # Input x1, y1
    li a7, 5
    ecall
    sw a0, x1, 0
    li a7, 5
    ecall
    sw a0, y1, 0

    # Input x2, y2
    li a7, 5
    ecall
    sw a0, x2, 0
    li a7, 5
    ecall
    sw a0, y2, 0

    # Load x1, y1, x2, y2
    lw t0, x1, 0
    lw t1, y1, 0
    lw t2, x2, 0
    lw t3, y2, 0

    # Ensure x1 < x2 and y1 < y2
    blt t0, t2, skip_swap_x
    mv t4, t0
    mv t0, t2
    mv t2, t4
skip_swap_x:
    blt t1, t3, skip_swap_y
    mv t4, t1
    mv t1, t3
    mv t3, t4
skip_swap_y:

    # Draw rectangle
    mv t4, t0
draw_row:
    mv t5, t1
draw_pixel:
    li t6, 512             # Screen width in pixels
    mul t7, t5, t6         # Offset = y * screen_width
    add t7, t7, t4         # Offset += x
    slli t7, t7, 2         # Each pixel is 4 bytes
    add t7, t7, MONITOR_SCREEN

    # Determine pixel color
    beq t4, t0, border_color
    beq t4, t2, border_color
    beq t5, t1, border_color
    beq t5, t3, border_color
    li t8, GREEN
    sw t8, 0(t7)
    j next_pixel
border_color:
    li t8, RED
    sw t8, 0(t7)
next_pixel:
    addi t5, t5, 1
    bge t5, t3, end_row
    j draw_pixel
end_row:
    addi t4, t4, 1
    bge t4, t2, finish
    j draw_row

finish:
    li a7, 10
    ecall