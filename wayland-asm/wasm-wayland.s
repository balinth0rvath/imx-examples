	.global display_connect
	.global global_object_available

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

get_registry:
	LDR R2, =display
	LDR R0, [R2]
	BL wl_display_get_registry_wrapper
	LDR R2, =registry
	STR R0, [R2]
	
create_listener:
	LDR R0, =listener
	LDR R1, =global_object_available
	LDR R2, =global_object_removed
	STR R1,	[R0], #4
	STR	R2, [R0]

add_listener:
	LDR R4,	=registry
	LDR R0,	[R4]
	LDR R4,	=listener
	LDR R1, [R4]
	LDR R4,	=display
	LDR R2, [R4]
	BL wl_registry_add_listener_wrapper
	
dispatch:
	LDR R2,	=display
	LDR	R0,	[R2]
	BL	wl_display_dispatch
	LDR R2,	=display
	LDR R0,	[R2]
	BL	wl_display_roundtrip

	LDMIA SP!, {R1,R2,PC}

display_error:
	LDR R0, =msg_display_error
	BL	printf
	MOV	R0,	#1	

	LDMIA SP!, {R1,R2,PC}

	.global display_disconnect
display_disconnect:
	STMDB 	SP!, {LR}

	LDR 	R2,	=display
	LDR 	R0,	[R2]
	BL 		wl_display_disconnect
	LDR 	R0,	=msg_display_disconnected
	BL 		printf

	LDMIA 	SP!, {PC}

global_object_available:
	push	{r7, lr}
	sub		sp, #16
	add		r7, sp, #0
	str		r0, [r7, #12]
	str		r1, [r7, #8]
	str		r2, [r7, #4]
	str		r3, [r7, #0]
	ldr		r0, =msg_avail 
	blx		printf
	nop
	adds	r7, #16
	mov		sp, r7
	pop		{r7, pc}

	STMDB SP!, {R1-R7,LR}
	
	LDMIA SP!, {R1-R7,LR}

global_object_removed:
	push	{r1, r2, r3, r4, r5, r6, r7, lr}
   	pop		{r1, r2, r3, r4, r5, r6, r7, lr}
	
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
listener:
	.word 0x0,0x0
egl_window:
	.word 0x0
surface:
	.word 0x0
shell_surface:
	.word 0x0

/*************************************************
 * Messages                                      * 
 *************************************************/
msg_display_connected:
	.asciz "Display connected \n"
msg_display_error:
	.asciz "Display error \n"
msg_display_disconnected:
	.asciz "Display disconnected \n"
msg_avail:
	.asciz "Avail \n"


