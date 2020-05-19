.include "wasm-macro-utils.s"

/*************************************************
 * Public functions                              * 
 *												 *
 * init_display_client							 *
 * display_disconnect                            *
 * init_egl										 *
 *												 *
 * Callbacks									 *
 *												 *
 * global_object_available						 *
 * global_object_removed						 *
 *************************************************/

/*************************************************
 * init_display_client                           * 
 *                                               *
 * -Connect to wayland display server            *
 * -Create and register listener functions       *
 * -Dispath display                              *
 * -Create surface								 *
 * -Create shell surface						 *
 * -Set toplevel								 *
 *************************************************/

	.global init_display_client

init_display_client:
	STMDB 	SP!, {R1,R2,LR}

display_connect:
	MOV 	R0,	#0
	BL 		wl_display_connect	
	CMP 	R0, #0
	BEQ 	display_error
	LDR 	R2, =display
	STR 	R0, [R2]
	LDR 	R0, =msg_display_connected
	BL 		printf	
	MOV		R0,	#0

get_registry:
	LDR 	R2, =display
	LDR 	R0, [R2]
	BL 		wl_display_get_registry_wrapper 
	LDR 	R2, =registry
	STR 	R0, [R2]
	
create_listener:
	LDR 	R0, =listener
	LDR 	R1, =global_object_available
	LDR 	R2, =global_object_removed
	STR 	R1,	[R0], #4
	STR		R2, [R0]

add_listener:
	LDR 	R4,	=registry
	LDR 	R0,	[R4]
	LDR 	R1,	=listener
	LDR 	R4,	=display
	LDR 	R2, [R4]
	BL 		wl_registry_add_listener_wrapper
	
dispatch:
	LDR 	R2,	=display
	LDR		R0,	[R2]
	BL		wl_display_dispatch
	LDR 	R2,	=display
	LDR 	R0,	[R2]
	BL		wl_display_roundtrip

check_compositor:
	LDR		R2, =compositor
	LDR		R0,	[R2]
	CMP		R0,	#0
	BEQ		compositor_error

create_surface:
	LDR		R2,	=compositor
	LDR		R0,	[R2]	
	BL		wl_compositor_create_surface_wrapper

check_surface:
	CMP		R0,	#0
	BEQ		surface_error
	LDR		R2,	=surface
	STR		R0,	[R2]

create_shell_surface:
	MOV		R1,	R0
	LDR		R2,	=shell
	LDR		R0,	[R2]
	BL		wl_shell_get_shell_surface_wrapper

check_shell_surface:
	CMP		R0,	#0
	BEQ		shell_surface_error
	LDR		R2,	=shell_surface
	STR		R0,	[R2]

set_toplevel:
	ADD		R0,	#0
	BL		wl_shell_surface_set_toplevel_wrapper

init_display_client_normal_exit:
	MOV		R0,	#0						@ success
	LDMIA SP!, {R1,R2,PC}

display_error:
	LDR 	R0, =msg_display_error
	B		init_display_client_error_exit

compositor_error:
	LDR 	R0, =msg_compositor_error
	B		init_display_client_error_exit

surface_error:
	LDR		R0,	=msg_surface_error
	B		init_display_client_error_exit

shell_surface_error:
	LDR		R0,	=msg_shell_surface_error
	B		init_display_client_error_exit

init_display_client_error_exit:
	BL		printf
	MOV		R0,	#1	
	LDMIA 	SP!, {R1,R2,PC}

/*************************************************
 * display_disconnect                            * 
 *                                               *
 * -Disconnect from wayland display server       *
 *************************************************/
	.global display_disconnect
display_disconnect:
	STMDB 	SP!, {LR}

	LDR 	R2,	=display
	LDR 	R0,	[R2]
	BL 		wl_display_disconnect
	LDR 	R0,	=msg_display_disconnected
	BL 		printf

	LDMIA 	SP!, {PC}

/*************************************************
 * global_object_available                       * 
 * global_object_removed                         *
 *                                               *
 * -Wayland registry callback functions          *
 *************************************************/
global_object_available:
	STMDB SP!, {R0-R12,LR}

search_for_compositor:
	strcmp_reg_lab 	R3 id_wl_compositor

	CMP		R0,	#0
	BEQ		compositor_found
	B		search_for_shell

compositor_found:
	LDR 	R0,	=msg_compositor_found
	BL		printf
	LDR		R0,	[SP, #4]
	LDR		R1,	[SP, #8]	
	LDR		R2,=wl_compositor_interface
	LDR		R3, [sp, #56]

	BL		wl_registry_bind_wrapper	
	LDR		R2,	=compositor
	STR		R0,	[R2]
	B		global_object_available_exit	

search_for_shell:
	strcmp_reg_lab	R3 id_wl_shell
	CMP		R0,	#0
	BEQ		shell_found
	B		global_object_available_exit
	
shell_found:
	LDR		R0,	=msg_shell_found
	BL		printf
	LDR		R0,	[SP, #4]
	LDR		R1,	[SP, #8]	
	LDR		R2,=wl_shell_interface
	LDR		R3, [sp, #56]
	BL		wl_registry_bind_wrapper	
	LDR		R2,	=shell
	STR		R0,	[R2]

global_object_available_exit:
	LDMIA 	SP!, {R0-R12,PC}

global_object_removed:
	push	{r1, r2, r3, r4, r5, r6, r7, lr}
   	pop		{r1, r2, r3, r4, r5, r6, r7, lr}
	
/*************************************************
 * init_egl 		                             * 
 *                                               *
 * -Get egl display					             *
 * -Initialize egl display				         *
 * -Get egl configs					             *
 * -Choose an egl config						 *
 * -Create egl context							 * 
 * -Create window								 *
 * -Create egl surface							 *
 * -Make surface current						 *
 *************************************************/

	.global	init_egl
init_egl:
	STMDB	SP!, {R1-R12,LR}

get_egl_display:

init_egl_display:

get_egl_configs:

choose_egl_config:

create_egl_context:

create_egl_window:

create_egl_surface:

make_surface_current:

init_egl_normal_exit:
	MOV		R0,	#0
	LDMIA	SP!, {R1-R12,PC}

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
 * registry interface identifiers                * 
 *************************************************/
id_wl_compositor:
	.asciz "wl_compositor"
id_wl_shell:
	.asciz "wl_shell"

/*************************************************
 * Info Messages                                 * 
 *************************************************/
msg_display_connected:
	.asciz "  - Display connected \n"
msg_display_disconnected:
	.asciz "  - Display disconnected \n"
msg_avail:
	.asciz "  - Registry interface found: name=%i interface=%s version=%i \n"
msg_compositor_found:
	.asciz "  - Compositor found \n"
msg_shell_found:
	.asciz "  - Shell found \n"

/*************************************************
 * Error Messages                                * 
 *************************************************/
msg_display_error:
	.asciz "  * Display error \n"
msg_compositor_error:
	.asciz "  * No compositor found \n"
msg_surface_error:
	.asciz "  * Cannot create surface \n"
msg_shell_surface_error:
	.asciz "  * Cannot create shell surface \n"

