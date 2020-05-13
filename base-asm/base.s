	.global main
	.func main
main:
	stmdb SP, {LR}
	
	MOV R0, #0
exit:
	ldmdb SP!, {PC}

