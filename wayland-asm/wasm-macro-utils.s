/*************************************************
 * Macro utils 	                                 * 
 *												 *
 * strcmp_reg_lab								 *
 *************************************************/

/*************************************************
 * strcmp_reg_lab								 *
 *												 *
 * Calls strcmp with the two comparable strings  *
 * address. First must be in a register, second  *
 * from a string stored in text signed by label  *
 * Max length of comparable strings must be 16   *
 * Chars beyond that are ignored                 *
 *************************************************/

	.macro strcmp_reg_lab comp_reg comp_label

	STMDB	SP!, {R1-R7}
	SUB		SP, SP, #32
	LDMIA	\comp_reg, {R1-R4}
	STMIA	SP,	{R1-R4}
	ADD		R7, SP, #16
	LDR		R0, =\comp_label
	LDMIA	R0,	{R1-R4}
	STMIA	R7,	{R1-R4}
	MOV		R0,	SP
	MOV		R1,	R7
	BLX		strcmp
	ADD		SP,	SP, #32
	LDMIA	SP!, {R1-R7} 
	.endm

