#n=10, s=3, t=2, Y={-1,3,-5,7,-9,2,-4,6,-8,10}, 
#and Z={1,2,3,4,5,6,7,8,9,10}

.data
X: .word 0:10						#For x value store
Y: .word -1 3 -5 7 -9 2 -4 6 -8 10	#Y values
Z: .word 1 2 3 4 5 6 7 8 9 10		#Z values
n: .word 10							#size of array
s: .word 3							#S value
t: .word 2							#t value

#prompting values
xVector:.asciiz "Print X Vector values:\n"
yVector:.asciiz "Print Y Vector values:\n"
zVector:.asciiz "Print Z Vector values:\n"
newline: .asciiz "\n"
space: .asciiz " "

########################################
.text
.globl main
main:
	#Stack initialization
	addi $sp,$sp,-24
	la $a0,X
	sw $a0,0($sp)
	la $a0,Y
	sw $a0,4($sp)
	la $a0,Z
	sw $a0,8($sp)
	la $a0,n
	sw $a0,12($sp)
	la $a0,s
	sw $a0,16($sp)
	la $a0,t
	sw $a0,20($sp)
	#print Y vector
	
	addi $t0,$0,0		#counter
	
	lw $a0,12($sp)		#n value in t1
	lw $t1,($a0) 
	
	la $a0,yVector
	li $v0,4
	syscall				#yVector prompt

lw $t2,4($sp)

yPrint:					#address of Y array
    bge $t0,$t1,next	#while $t0 >= $t1/check size
    
    lw $a0,0($t2)
    li $v0,1
    syscall				#print values
    
    la $a0,space
    li $v0,4
    syscall				#space
	
    addi $t0,$t0,1		#increment counter
    addi $t2,$t2,4		#increment array address
    j yPrint			#jump back to yPrint

next:					#Z values print
     
    la $a0,newline		
    li $v0,4
    syscall				#print new line
    
    la $a0,zVector		
    li $v0,4
    syscall				#zVector prompt
	
    lw $t2,8($sp)		#address of z array
    
    addi $t0,$0,0		#counter

zPrint:					#print z values
      bge $t0,$t1,funCall	#$t0 >=$t1
	  
      lw $a0,0($t2)
      li $v0,1
      syscall			#print values
	  
      la $a0,space
      li $v0,4
      syscall			#space
	  
      addi $t0,$t0,1	#increment counter
      addi $t2,$t2,4	#increment array address
      j zPrint			#jump back to zPrint

funCall:				#call function
    jal AVA
#Print x values
    
    la $a0,newline
    li $v0,4
    syscall				#new line

    
    la $a0,xVector
    li $v0,4
    syscall				#zVector prompt
	
    lw $t2,0($sp)		#address of x array
	
    addi $t0,$0,0		#counter
	
    #size of array
    lw $t1,12($sp)
    lw $t1,($t1)
	

xPrint:					#print z values
    bge $t0,$t1,exit	#$t0 >= $t1
    lw $a0,0($t2)
    li $v0,1
    syscall				#print values
	
    la $a0,space
    li $v0,4
    syscall				#space
	
    addi $t0,$t0,1		#increment counter
    addi $t2,$t2,4		#increment array address
    j xPrint

exit:					
    addi $sp,$sp,24		#Uninitialize stack

    li $v0,10
    syscall				#exit program

AVA:					#Func def
    #counter = n
    lw $t0,12($sp)
    lw $t0,($t0)
	
    #t1 = s
    lw $t1,16($sp)
    lw $t1,($t1)
	#t2=t
    lw $t2,20($sp)
    lw $t2,($t2)
    
    lw $t3,0($sp)		#starting address of x
    
    lw $t4,4($sp)		#starting address of y
    
    lw $t5,8($sp)		#starting address of z

loop:					#X val calculation loop
   #size check
   beqz $t0,ret
   #check positive or negative
   lw $t6,0($t4)
   blt $t6,0,ypositive
back1:
   lw $t7,0($t5)
   blt $t7,0,zpositive

back2:					#x val finding
    
    mul $v0,$t1,2		#2*s
    add $v0,$v0,$t2		#2*s+t
    add $v0,$v0,$t6		#y+2*s+t
    add $v0,$v0,$t7		#y+z+2*s+t
    sw $v0,0($t3)		#x=v0
	
    #Increment to get next values
    addi $t0,$t0,-1
    addi $t3,$t3,4
    addi $t4,$t4,4
    addi $t5,$t5,4
    j loop
    
ypositive:				#make y values positive
   mul $t6,$t6,-1
   j back1
   
zpositive:				#make z values positive
   mul $t7,$t7,-1
   j back2

ret:					#return to main
   jr $ra