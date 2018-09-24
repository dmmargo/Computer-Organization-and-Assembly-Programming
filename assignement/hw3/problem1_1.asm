#n=5,  s=2, t=1, Y = {1,2,3,4,5},  and  Z = {-5,-4,-3,-2,-1}

.data
X: .word 0:5			#For x value store
Y: .word 1 2 3 4 5		#Y values
Z: .word -5 -4 -3 -2 -1	#Z values
n: .word 5				#size of array
s: .word 2				#S value
t: .word 1				#t value

#prompting values
xVector:.asciiz "Print X Vector values:\n"
yVector:.asciiz "Print Y Vector values:\n"
zVector:.asciiz "Print Z Vector values:\n"
newline: .asciiz "\n"
space: .asciiz " "

############################################

.text
.globl main
main:

	#load address, store word to stack
	addi $sp, $sp, -24
	la $a0, X
	sw $a0, 0($sp)		
	la $a0, Y
	sw $a0, 4($sp)
	la $a0, Z
	sw $a0, 8($sp)
	la $a0, n
	sw $a0, 12($sp)
	la $a0, s
	sw $a0, 16($sp)
	la $a0, t
	sw $a0, 20($sp)
	
	#print Y vector
	addi $t0, $0, 0		#counter
	lw $a0, 12($sp)		#n value in t1
	lw $t1, ($a0)
	la $a0, yVector
	li $v0, 4
	syscall				#yVector prompt

	lw $t2, 4($sp)

.text					#address of Y array
yPrint:					#while loop yPrint / $t0 >= $t1/check size
    bge $t0,$t1,next	#check size/ $t0 > $t1 
    
    lw $a0,0($t2)
    li $v0,1
    syscall				#print values
    
    la $a0,space
    li $v0,4
	syscall				#print a space
	
    addi $t0,$t0,1		#increment counter
    
    addi $t2,$t2,4		#increment array address
    j yPrint			#jump back to while loop yPrint

.text
next:					#Z values print
    la $a0,newline
    li $v0,4
    syscall				#newline
    
    la $a0,zVector		
    li $v0,4
    syscall				#zVector prompt
    
    lw $t2,8($sp)		#address of z array
    
    addi $t0,$0,0		#counter

.text
zPrint:					#print z values
    bge $t0,$t1,funCall	#$t0 >= $t1
    lw $a0,0($t2)
    li $v0,1
    syscall
    la $a0,space
    li $v0,4
    syscall
    addi $t0,$t0,1
    addi $t2,$t2,4
    j zPrint
	  
.text
funCall:
    jal AVA
#Print x values
	#next line
    la $a0,newline
    li $v0,4
    syscall
    #zVector prompt
    la $a0,xVector
    li $v0,4
    syscall

    lw $t2,0($sp)		#address of x array
    addi $t0,$0,0 		#counter
    
    lw $t1,12($sp)		#size of array
    lw $t1,($t1)
	  
.text
xPrint:					#print z values
      bge $t0,$t1,exit	#$t0 >= $t1
      lw $a0,0($t2)
      li $v0,1
      syscall
	  
      la $a0,space
      li $v0,4
      syscall			#space
	  
      addi $t0,$t0,1	#$t0++
      addi $t2,$t2,4	#$t2+=4
      j xPrint			#junp back to xPrint
#End of the program

.text
exit:
    addi $sp,$sp,24		#Uninitialize stack

	li $v0,10			#exit program
    syscall
	
.text
AVA:					#Function definition
    #counter = n
    lw $t0, 12($sp)
    lw $t0, ($t0)
	
    #t1 = s
    lw $t1, 16($sp)
    lw $t1, ($t1)
	
	#t = t
    lw $t2, 20($sp)
    lw $t2, ($t2)
    
    lw $t3, 0($sp)		#starting address of x
    lw $t4, 4($sp)		#starting address of y
    lw $t5, 8($sp)		#starting address of z

.text
loop:					#X val calculation loop
    
    beqz $t0, ret		#size check	
    #check positive or negative
    lw $t6, 0($t4)
    blt $t6, 0, ypositive
back1:
    lw $t7,0($t5)
    blt $t7,0,zpositive
	
back2:					#x val finding
    mul $v0,$t1,2		#2*s
   
    add $v0,$v0,$t2		#2*s+t
	
    add $v0,$v0,$t6		#y+z+2*s+t
    
    add $v0,$v0,$t7		#y+z+2*s+t
    
    sw $v0,0($t3)		#x=v0
	
    #Increment to get next values
    addi $t0,$t0,-1
    addi $t3,$t3,4
    addi $t4,$t4,4
    addi $t5,$t5,4
    j loop				#jump to loop
    
ypositive:				#make y values positive
   mul $t6,$t6,-1
   j back1
   
zpositive:				#make z values positive
   mul $t7,$t7,-1
   j back2

ret:					#return to main
   jr $ra
