# Student: Diane Margo   		Date: November 5, 2017
# Description: hw2-4.asm - create an array of size 20.  
#							number of array entered by user but given by assignment 
#							sums two largest and two smallest in array
.data
	#prompt1: .asciiz "\nSum of 2 largest integers\n"
	Raw: .word 2, 17, 28, 20, 6, 51, 20, 48, 12, 54, 3, 31, 15, 22, 46, 72, 41, 39, 30, 55
	Fresh: .space 20
	start: .asciiz "Solving through Raw\n"
	startFresh: .asciiz "\n\nSolving through Fresh\n"
	rawnum: .asciiz "Initialized 'Raw' array with values: 2, 17, 28, 20, 6, 51, 20, 48, 12, 54, 3, 31, 15, 22, 46, 72, 41, 39, 30, 55"
	prompt1: .asciiz "\nSum of 2 largest integers\n"
	prompt2: .asciiz "Enter 20 numbers to enter into Fresh array, separated by new lines\n"
	minSum: .asciiz "\nSum of 2 smallest integers\n"
	remaining: .asciiz " numbers left to store: "


.text
#-------------------------load array address into $t7 to use Sum
#-------------------------sum of bigger numbers w/ loop
maxSum: 
	addi $t0, $zero, 0	#Used as Index
	addi $t2, $zero, 20			#Store ARRAY_SIZE(20)
	addi $t4, $zero, 0			#Used to store largest
	addi $t5, $zero, 0			#Used to store 2nd large

Loop: blez $t2, ExitMax			 #while ARRAY_SIZE  != 0
	sll $t3, $t0, 2				#4*i
	add $t3, $t7, $t3
	lw $t6, 0($t3)			#$s7 = Array[$t0]
	slt $t1, $t4, $t6			#$t0 = 1 if largest < Array[$t3]
	beqz $t1, Elif
	move $t5, $t4				#redefine 2nd largest
	move $t4, $t6				#set new largest
	j Else
	
Elif: slt $t1, $t5, $t6			#1 if 2ndlarge<curr<largest
	beqz $t1, Else
	move $t5, $t6

Else: addi $t2, $t2, -1			#i--
	addi $t0, $t0, 1
	j Loop

ExitMax: add $t6, $t4, $t5
	jr $ra
#-------------------------sum of smaller numbers w/ loop
SumSmall: 
	addi $t0, $zero, 0			#index stored in
	addi $t2, $zero, 20			#where ARRAY_SIZE(20) is stored in
	addi $t4, $zero, 9999		#smallest num stored
	addi $t5, $zero, 9999		#2nd small stored in

Loop2: blez $t2, ExitSmall		#while statement: ARRAY_SIZE  != 0
	sll $t3, $t0, 2				#i*4
	add $t3, $t7, $t3			
	lw $t6, 0($t3)				#$t6 = Array[$t0]
	slt $t1, $t6, $t4			#$t0 = 1 if Array[$t3] < smallest
	beqz $t1, Elif2				#jump if NO new SMALLEST
	move $t5, $t4				#redefine 2nd small
	move $t4, $t6				#set new smallest
	j Else2						#jumps to Else2
	
Elif2: slt $t1, $t6, $t5		#if smallest<curr<2nd small return 1
	beqz $t1, Else2
	move $t5, $t6

Else2: addi $t2, $t2, -1		#i--
	addi $t0, $t0, 1
	j Loop2						#jumps to Loop2

ExitSmall: add $t6, $t4, $t5
	jr $ra
#----------------------------adding the numbers
addNumbers: 
	addi $t0, $zero, 0			#t0 is index to store
	addi $t1, $zero, 20			#t1 counts Loop iterations
ADD:blez $t1, END
	li $v0, 1
	move $a0, $t1
	syscall
	li $v0, 4
	la $a0, remaining
	syscall

	li $v0, 5					#Reads integer
	syscall
	move $t2, $v0				#move input to t2
	sw $t2, Fresh($t0)			#Fresh[i] = t2

	addi $t0, $t0, 4
	addi $t1, $t1, -1
	j ADD
END: jr $ra

#-----------------------------------------------------------#


.globl main
main:						#start main

#----------------------------Raw 
	li $v0, 4
	la $a0, start			#Problem 1 prompt
	syscall
	li $v0, 4
	la $a0, rawnum			#Declaration of initialization
	syscall
	li $v0, 4
	la $a0, prompt1			#prompt1 prompt
	syscall

	la $t7, Raw				#load array address into $t7 for sum function
	jal maxSum				#gets max 
	li $v0, 1
	move $a0, $t6
	syscall					#Prints sum of 2 largest

	li $v0, 4
	la $a0, minSum			#minSum prompt
	syscall
	
	la $t7, Raw				#loading array address for sum function
	jal SumSmall			#gets min 
	li $v0, 1
	move $a0, $t6
	syscall					#Prints sum of 2 smallest

	
#--------------------------Fresh 
	li $v0, 4
	la $a0, startFresh		#start Fresh
	syscall
	
	li $v0, 4
	la $a0, prompt2	#Second prompt
	syscall

	jal addNumbers			#Loop runs to enter numbers for Fresh array

	la $t7, Fresh
	jal maxSum

	li $v0, 4
	la $a0, prompt1			#Prints: Sum of 2 largest integers
	syscall
	li $v0, 1
	move $a0, $t6			#t6 = sum of 2 largest
	syscall
	add $t1, $t0, $t7		#maintain $t0
	sw $t6, 0($t1)			#Store in $t6 

	jal SumSmall
	li $v0, 4
	la $a0, minSum			#Prints: Sum of 2 smallest integers
	syscall
	li $v0, 1
	move $a0, $t6			#t6 = sum of 2 smallest
	syscall
	addi $t0, $t0, 4		#t0 + 4 is Sum of 2 largest
	add $t1, $t0, $t7		#therefore + 4
	sw $t6, 0($t1)			#Stores t6 in next memory block

	li $v0, 10				#ends program
	syscall