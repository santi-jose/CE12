#Jose Santiago CE 12

.text
	#print Key Message
	la	$a0, Keym
	li	$v0,4
	syscall	


	#print the user inputs seperately
	move	$s0,$a1	#move address into s0 register
	lw	$s0,($s0)	#dereference s0
	la	$a0,($s0)	#load address s0 into a0
	li	$v0,4	#print command
	syscall
	la	$t1,($s0)	#save key into t1
	subi	$s0,$s0,2	#decrement to check address for null

	#print text message
	la	$a0, Textm
	li	$v0,4
	syscall
	
	
	Loop:
	lb	$t0,($s0)	#load s0 into t0 
	beqz	$t0,exit	#if t0 is equal to zero go to exit
	nop		
	subi	$s0,$s0,1	#subtract key address by 1
	j	Loop
	nop

	exit:
	addi	$s0,$s0,1	#increment 
	la	$a0,($s0)	#load address of s0 to print
	li	$v0,4	#print command
	syscall


	#print Encrypt Message
	la	$a0,Encryptm
	li	$v0,4
	syscall
	
	la	$s2,array1	#declare array for storing encryption
	la	$s4,array2	#declare array for storing decription
	la	$s3,($t1)	#save t1 key into s3 for fixkey
	
	#call function encrypt
	jal	Encrypt
	nop
	la	$a0,array1	#Load array into a0
	li	$v0,4	#print encrypted text
	syscall
	
	#print Decrypt Message
	la	$a0, Decryptm
	li	$v0,4
	syscall
	
	la	$s2,array1
	move	$t1,$s3
	
	#print Decrypted encrypted message lol
	jal	Decrypt
	nop
	la	$a0,array2
	li	$v0,4
	syscall
	
	
	li	$v0,10
	syscall
	
	Encrypt:
	lb	$t2,($s0)	#load text into t2 for manipulation
	lb	$t3,($t1)	#load key into t3 for manipulation
	beqz	$t2,leave	#if we reach the end of our text, leave
	nop
	beqz	$t3,fixkey	#if my key hits a null, go fix the key
	nop		#null operation
	add	$s1,$t2,$t3	#add text and key for encryption
	remu	$s1,$s1,128	#modulus of sum of key and text
	sb	$s1,($s2)	#store rem into array 1(s2)
	add	$s0,$s0,1	#increment text string
	add	$t1,$t1,1	#increment key string
	add	$s2,$s2,1	#increment array string
	j	Encrypt
	nop
	
	fixkey:
	la	$t1,($s3)	#reset t1 to first bit
	j	Encrypt
	nop
	
	leave1:
	jr	$ra	#go back to decrypt function call
	nop
	
	leave:
	jr	$ra	#go back to where encrypt function was called
	nop	
	
	
	Decrypt:
	lb	$t2,($s2)	#load encription into t2 for manipulation
	lb	$t3,($t1)	#load key into t3 for manipulation
	beqz	$t2,leave1	#if we reach the end of our text, leave
	nop
	beqz	$t3,fixkeyd	#if my key hits a null, go fix the key
	nop		#null operation
	sub	$s1,$t2,$t3	#sub encritption from key
	remu	$s1,$s1,128	#modulus of sum of key and text
	sb	$s1,($s4)	#store rem into array 1(s4)
	add	$s4,$s4,1	#increment array2 string
	add	$t1,$t1,1	#increment key string
	add	$s2,$s2,1	#increment array1 string
	j	Decrypt
	nop

	fixkeyd:
	la	$t1,($s3)
	j	Decrypt
	nop	
	
.data
	array1:	.space	101 	#arrays
	array2:	.space	101
	Keym: 	.asciiz	"\nThe given key is:"
	Textm: 	.asciiz	"\nThe given text is:"
	Encryptm:	.asciiz	"\nThe encrypted text is:"
	Decryptm:	.asciiz	"\nThe decrypted text is:"