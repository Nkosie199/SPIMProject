# question1.asm, a program to enter a series of 5 arbitrary strings and print them out
# nkosi gumede
# 23/9/2015

.data
   str1: .space 100
   str2: .space 100
   str3: .space 100
   str4: .space 100
   str5: .space 100
   iMsg: .asciiz "Enter a series of 5 formulae:\n"
   oMsg: .asciiz "The values are:\n"

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
# get the string 2
   li $v0,8
   la $a0,str2
   syscall
# get the string 3
   li $v0,8
   la $a0,str3
   syscall
# get the string 4
   li $v0,8
   la $a0,str4
   syscall
# get the string 5
   li $v0,8
   la $a0,str5
   syscall

# output the string prefix text
   li $v0,4
   la $a0,oMsg
   syscall

# output the string 1
   li $v0,4
   la $a0,str1
   syscall
# output the string 2
   li $v0,4
   la $a0,str2
   syscall
# output the string 3
   li $v0,4
   la $a0,str3
   syscall
# output the string 4
   li $v0,4
   la $a0,str4
   syscall
# output the string 5
   li $v0,4
   la $a0,str5
   syscall

# exit
   jr $ra
