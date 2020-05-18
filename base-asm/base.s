	.global main
	.func main
main:
	stmdb 	SP!, {LR}
	MOV 	R0, #0

	MOV		R0,	#10
	MOV		R1,	#11
	MOV		R2,	#22
	MOV		R3,	#33
	
	STMIA SP,{R0,R1,R2,R3} @ A

	MOV		R0,	#110
	MOV		R1,	#111
	MOV		R2,	#122
	MOV		R3,	#133
	STMIA SP!,{R0,R1,R2,R3} @ B

	MOV		R0,	#4
	MOV		R1,	#5
	MOV		R2,	#6
	MOV		R3,	#7

	STMIA SP!,{R0,R1,R2,R3} @ C
	
	LDMIA	SP, {R0,R1,R2,R3}
	
	LDMIA 	SP!,{R0,R1,R2,R3}

	LDMIA	SP!,{R0,R1,R2,R3}


	MOV		R0,	#10
	MOV		R1,	#11
	MOV		R2,	#22
	MOV		R3,	#33
	
	STMDA SP,{R0,R1,R2,R3} @ A

	MOV		R0,	#110
	MOV		R1,	#111
	MOV		R2,	#122
	MOV		R3,	#133
	STMDA SP!,{R0,R1,R2,R3} @ B

	MOV		R0,	#4
	MOV		R1,	#5
	MOV		R2,	#6
	MOV		R3,	#7

	STMDA SP!,{R0,R1,R2,R3} @ C

	LDMDA SP, {R0,R1,R2,R3}
	
	LDMDA SP!,{R0,R1,R2,R3}

	LDMDA SP!,{R0,R1,R2,R3}

	MOV		R0,	#10
	MOV		R1,	#11
	MOV		R2,	#22
	MOV		R3,	#33
	
	STMDB SP,{R0,R1,R2,R3} @ A

	MOV		R0,	#110
	MOV		R1,	#111
	MOV		R2,	#122
	MOV		R3,	#133
	STMDB SP!,{R0,R1,R2,R3} @ B

	MOV		R0,	#4
	MOV		R1,	#5
	MOV		R2,	#6
	MOV		R3,	#7

	STMDB SP!,{R0,R1,R2,R3} @ C

	LDMDB SP, {R0,R1,R2,R3}
	
	LDMDB SP!,{R0,R1,R2,R3}

	LDMDB SP!,{R0,R1,R2,R3}
_exit:
	ldmia SP!, {PC}

