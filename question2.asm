# question2.asm, a program to convert a string into an integer and add to that integer
# nkosi gumede
# 23/9/2015

.data
   str1: .space 100
   iMsg: .asciiz "Enter a string:\n"
   oMsg: .asciiz "The value +5 is:\n"

.text

   main:

# ouput the prompt
   li $v0,4
   la $a0,iMsg
   syscall
# get the string 1
   li $v0,8
   la $a0,str1
   syscall

# split the string from string to integer
   addi $a0, $a0, 1
   # increments ascii character of string by 1, ie. '1'
   move $s0, $a0
   li $t0, 10
   li $t1, 5
   j parseInt  

parseInt:
   lb $t2, ($s0)
   beq $t2, $t0, quit
   # if '/n', go to quit method, or else continue
# convert the integer component
   addi $t2, $t2, -48
   mul $t3, $t3, $t0
   add $t3, $t3, $t2
   addi $s0, $s0, 1
   j parseInt
   

quit:
   add $t3, $t1, $t3
# output the string prefix text
   li $v0, 4
   la $a0, oMsg
   syscall
   li $v0, 1
   move $a0, $t3
   syscall
# exits the program
   li $v0, 10
   syscall



   
