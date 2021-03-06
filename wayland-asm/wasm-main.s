	.global main
	.func main

main:
	stmdb SP!, {LR}

	LDR		R0,	=msg_init_started
	BL		printf	
	BL 		init_display_client
	CMP		R0,	#0
	BEQ 	init_success

main_normal_exit:
	LDR		R0,	=msg_init_fail	
	BL		printf
	B		main_error_exit	

init_success:
	LDR		R0,	=msg_init_finished
	BL		printf
	
main_error_exit:
	BL display_disconnect
	ldmia SP!, {PC}

msg_init_started:
	.asciz "--- Display initialization started ---\n"
msg_init_finished:
	.asciz "--- Init succeeded ---\n\n"
msg_init_fail:
	.asciz "*** Init failed ***\n"

