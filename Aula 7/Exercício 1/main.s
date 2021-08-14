;---Ex-1a - STACK
		EXPORT 	__main
i		EQU		3
SOMA	EQU		6
		AREA 	M_DADOS, DATA, READWRITE
P		SPACE	i
Q		SPACE	i
R		SPACE	i
S		SPACE	i
M 		SPACE	i*2
;---directive area-programa
		AREA 	M_PROG, CODE, READONLY
__main
		LDR		R0,=P
		LDR		R1,=Q
		LDR		R2,=R
		LDR		R3,=S
		LDR		R8,=i			;CONTADOR
		LDR		R9,=SOMA
		LDR		R10,=M
		LDR		R11,=0
CONT	LDRB	R4,[R0],#1		;P
		LDRB	R5,[R2],#1		;R
		MUL		R6,R0,R2		;P*R
		PUSH	{R6}
		LDRB	R4,[R1],#1		;Q
		LDRB	R5,[R3],#1		;S
		MUL		R7,R1,R3		;Q*S
		PUSH	{R7}
		ADD		R9,R6,R7
		ADD		R11,R9
		SUBS	R8,#1
		BNE		CONT	
		STRH	R11,[R10]
		B 		__main
		END
		