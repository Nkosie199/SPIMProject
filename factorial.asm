# 5 february 2017
# nkosie gumede
# program to print out the factorial of any number

.data
	iMsg: .asciiz "Please enter the number you want to get the factorial of: \n"	
	oMsg: .asciiz "The factorial is: \n"

.text

main:
	
# print prompt to get input
	li $v0, 4
	la $a0, iMsg
	syscall
	
# prompt user to enter a number
	li $v0, 5
	syscall	

# store the input variable into register t0
	move $t0, $v0

# initialize factorial value (in register t1) to the input value
	la $t1, ($t0)  

factorial:
	# if the contents of t0 = 0, branch to quit
	beq $t0, 1, print
	# else, set the value to factorial to n.(n-1)
	sub $t0, $t0, 1
	mult $t1, $t0
	mflo $t1

	j factorial

print:
	li $v0, 4
	la $a0, oMsg
	syscall
	
	li $v0, 1
	la $a0, ($t1)
	syscall

quit:
	# exit the program
	jr $ra

