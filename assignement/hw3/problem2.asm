.data
	prompt1: .asciiz "Problem 2:\n"
	arrayA: .word 5, 2, -9, 10, -23, 43, 2, 1, 3, 5, 10
	prompt: .asciiz "find the smallest value in array through func 'Min'...\nOutput: "

.text
.globl main
main:						#start

	li $v0, 4
	la $a0, prompt1 		#prompt1 prompt
	syscall					#print "Problem2: "

	la $a1, arrayA			# a1 = base address of A
	li $a2, 0				# a2 = lo
	li $a3, 10				# a3 = hi

	la $a0, prompt
	li $v0, 4
	syscall					#finding value in min prompt

	jal Min 				#jump and link value from $v1

	move $a0, $v1
	li $v0, 1
	syscall					#move the value to print

	li $v0, 10				#exit program
	syscall
	
	
	
.text
Min:
	addi $sp, $sp, -20		#allocate 4 spaces in stack
	bne $a2, $a3, notEqual
	sll $t0, $a2, 2
	add $t0, $a1, $t0
	lw $v1, 0($t0)

	j Exit
notEqual:
	add $t2, $a2, $a3		# t2 = lo + hi
	srl $t2, $t2, 1			# t2 = t0/2 = mid

	sw $a2, 16($sp)			# store word lo
	sw $a3, 12($sp)			# store word hi
	sw $t2, 8($sp)			# t2 in stack (mid)
	sw $ra, 4($sp)			# store word $ra

	move $a3, $t2			# hi = mid
	jal Min 				#output is now in $v1
	sw $v1, 0($sp)

	lw $a2, 16($sp)
	lw $a3, 12($sp)
	lw $t2, 8($sp)

	addi $t2, $t2, 1		# t0 = mid++
	move $a2, $t2			# move lo = t2
	jal Min

	lw $ra, 4($sp)
	lw $t3, 0($sp)			# load word proper $ra and min1

	move $t4, $v1			# t4 = min2
	bgt $v1, $t3, Else
	j Exit

Else:
	move $v1, $t3			



Exit:
	addi $sp, $sp, 20		#empty stack
	jr $ra