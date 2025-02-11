# Laboratory Exercise 3, Home Assignment 1 (Modified for i + j > m + n)
.text
start:
	li s1, 5  # i = 5
	li s2, 3  # j = 3
	li s3, 4  # m = 4
	li s4, 2  # n = 2

# Condition: i + j > m + n
	add t0, s1, s2 # t0 = i + j
	add t1, s3, s4 # t1 = m + n
	slt t2, t1, t0 # set t2 = 1 if i + j > m + n
	beq t2, zero, else # if i + j <= m + n, go to "else"
	j then # continue with "then"
then:
	addi t1, t1, 1 # then part: x = x + 1
	addi t3, zero, 1 # z = 1
	j endif # skip "else" part
else:
	addi t2, t2, -1 # else part: y = y - 1
	add t3, t3, t3 # z = 2 * z
endif:

