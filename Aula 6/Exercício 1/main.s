		EXPORT  __main
tam		EQU		15			
		AREA	M_DADOS, DATA, READWRITE
vtb		SPACE	tam		
		AREA	M_PROGRAMA, CODE, READONLY
__main
		LDR		R0,=vtb
		LDR		R1,=vtb+tam-1
LOOP	LDRB	R3,[R0]
		LDRB	R4,[R1]
		STRB	R4,[R0], #1
		STRB	R3,[R1], #-1
		CMP		R1,R0
		BNE		LOOP
		B		__main
		END