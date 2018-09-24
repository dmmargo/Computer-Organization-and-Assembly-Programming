
.data
	        open:  .asciiz "Enter 4 inputs to read on separate lines:\n"
	prompt1:  .asciiz "\na: Print each above integers\n"
	prompt2:  .asciiz "\nb: Add s2 and s3 and print the result\n"
	prompt3:  .asciiz "\nc: Perform logical OR on constant 4 and s3, and print the result\n"
	prompt4:  .asciiz "\nd: Shift s3 one bit left, and then print the result\n"
	       mark:  .asciiz ", "

.text

.globl main
main:
	#Start program
	li $v0, 4
	la $a0, open
	syscall


	li $v0, 5		#Reads $s0
	syscall
	move $s0, $v0
	li $v0, 5		#Reads $s1
	syscall
	move $s1, $v0
	li $v0, 5		#Reads $s2
	syscall
	move $s2, $v0
	li $v0, 5		#Reads $s3
	syscall
	move $s3, $v0


	##A
	#Declare first prompt
	li $v0, 4
	la $a0, prompt1	
	syscall

	#Print first number
	li $v0, 1
	move $a0, $s0
	syscall
	li $v0, 4
	la $a0, mark
	syscall

	#Print second number
	li $v0, 1
	move $a0, $s1
	syscall
	li $v0, 4
	la $a0, mark
	syscall

	#Print third number
	li $v0, 1
	move $a0, $s2
	syscall
	li $v0, 4
	la $a0, mark
	syscall

	#Print fourth number
	li $v0, 1
	move $a0, $s3
	syscall

	#Print second prompt
	li $v0, 4
	la $a0, prompt2
	syscall

	##B
	#Add s2 and s3
	add $t0, $s2, $s3
	li $v0, 1
	move $a0, $t0
	syscall

	#Print third prompt
	li $v0, 4
	la $a0, prompt3
	syscall

	##C
	#Or Immediate
	ori $t1, $s3, 4
	li $v0, 1
	move $a0, $t1
	syscall

	#Print fourth prompt
	li $v0, 4
	la $a0, prompt4
	syscall

	##D 
	#Shift left one bit
	sll $t2, $s3, 1
	li $v0, 1
	move $a0, $t2
	syscall

	li $v0, 10		#terminate the program
	syscall