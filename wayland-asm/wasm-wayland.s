	.global display_connect

display_connect:
	STMDB SP!, {R1,R2,LR}

	MOV R0,	#0
	BL 	wl_display_connect	
	CMP R0, #0
	BEQ display_error
	LDR R2, =display
	STR R0, [R2]
	LDR R0, =msg_display_connected
	BL 	printf	
	MOV	R0,	#0

	LDMIA SP!, {R1,R2,PC}

display_error:
	LDR R0, =msg_display_error
	BL	printf
	MOV	R0,	#1	

	LDMIA SP!, {R1,R2,PC}

	.global display_disconnect
display_disconnect:
	STMDB SP!, {LR}

	LDR R2,	=display
	LDR R0,	[R2]
	BL wl_display_disconnect
	LDR R0,	=msg_display_disconnected
	BL printf

	LDMIA SP!, {PC}

	.data

/*************************************************
 * wayland display struct                        * 
 *************************************************/

display: 
	.word 0x0
compositor:
	.word 0x0
shell:
	.word 0x0
registry:
	.word 0x0
egl_window:
	.word 0x0
surface:
	.word 0x0
shell_surface:
	.word 0x0
# Messages
msg_display_connected:
	.asciz "Display connected \n"
msg_display_error:
	.asciz "Display error \n"
msg_display_disconnected:
	.asciz "Display disconnected \n"

