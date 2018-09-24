.data
	result: .asciiz 	"The result is: "
.text
Func1: 
	slti $t0, $a0, 1		#n < 1
	bne $t0, $zero, Then	#if false => Then
	
	#backup
	addi $sp, $sp, -8
	sw $a0, 0($sp)
	sw $ra, 4($sp)
	#-----
	
	addi $a0, $a0, -1		#decrement n - 1
	jal Func1				#go back to Func1
	
	#restore
	lw $a0, 0($sp)
	lw $ra, 4($sp)
	addi $sp, $sp, 8
	#-----
	#backup
	addi $sp, $sp, -12
	sw $a0, 0($sp)
	sw $ra, 4($sp)
	sw $v0, 8($sp)
	#-----
	
	addi $a0, $a0, -2		#decrement n - 2
	jal Func2				#go to Func2
	
	#restore
	lw $a0, 0($sp)
	lw $ra, 4($sp)
	lw $t0, 8($sp)
	addi $sp, $sp, 12
	#-----
	
	add $v0, $t0, $v0		#Func1(n-1)+Func2(n-2)
	jr $ra


Then:						
	li $v0, 1				
	jr $ra					#and return 1
	

	.text
Func2: 
	li $t2, 2
	mul $v0, $a0, $t2
	jr $ra
	

	.text
	.globl  main
main:
	li $v0, 4
	la $a0, result			#prints "The result is: "
	syscall
	
	la $a0, 4				#loading 4 to Func1 fucntion
	jal Func1				#jumps and links to Func1

	move $a0, $v0			#prints answer
	li $v0, 1
	syscall	
	
	
	li $v0, 10				#ends program
	syscall
