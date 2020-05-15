	.global main
	.func main
main:
	stmdb SP!, {LR}

	MOV R0, #3
	BL display_connect
	BL wl_display_connect

	BL display_disconnect
_exit:
	ldmia SP!, {PC}


