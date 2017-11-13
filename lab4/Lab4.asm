#Jose Luis Santiago CMPE-12 11/13/17

.text
	#load welcome message and user input
	la	$a0,Welcome
	li	$v0,4
	syscall
	
	#load and primpt prompt
	la	$a0,Prompt
	li	$v0,4
	syscall
	
	#get user input using syscall 5
	li	$v0,5
	syscall
	move 	$t0,$v0 #move user input into a temporary
	la	$s1,($t0) #put the user input into a save register
	
	#load and print end prompt
	la	$a0,End_Prompt
	li	$v0,4
	syscall
	li	$t2,3
	Outer_Loop:
	li	$t3,2
	bgt 	$t2,$s1,leave #if $t2 is greater than $t0, branch to leave 
	addi	$t2,$t2,1
	j	Loop
	
	#Loop that shifts and reads values in addresses
	Loop:
	rem	$t1,$t0,$t3 #divide $t0 by $t3 and put the remainder back in $t0
	beq	$t1,$zero,Outer_Loop #loop if the remainder is zero
	nop
	bgtz	$t1,print #print if remainder is greater than zero
	nop
	addi	$t3,$t3,1 #increment inner loop counter
	beq	$t3,$s1,leave #if my counter is equal to user input, leave
	j	Loop
	nop
	
	#once Loop determines a number is prime it is sent here to print then looped back to loop
	print:
	li	$v0,1 #load print command into v0
	move  	$a0,$t3 #load number in address at the time into a0
	syscall
	
	addi	$t3,$t3,1 #increment outer loop counter
	j	Loop
	
	#if the address value returns a null or zero, then we want to exit the program
	leave:
	li	$v0,10 #end program
	syscall


.data
	Welcome:	.asciiz "Jose Luis Santiago\n CMPE-12\n11/13/17\nWelcome to my Program\n"
	Prompt:	.asciiz "Please Input a Number:"
	End_Prompt:	.asciiz "Output:"