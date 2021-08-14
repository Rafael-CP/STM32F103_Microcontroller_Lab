		EXPORT 	__main
nf		EQU		4			
		AREA 	MDADOS, DATA, READWRITE
vt1		SPACE	nf
vmx		SPACE	1
		
		AREA 	MPROG, CODE,READONLY
__main	
START	LDR		R0,=vt1
		LDR		R1,=vmx
		MOV		R2,#nf
LOOP	BL		s_max
		CMP		R5,R3
		BHI		SUBST		; Se R5>R3 (R3 será zero no primeiro caso)
VOLTAR	SUBS	R2,#1
		BNE		LOOP
		STRB	R3,[R1]
		B		START

SUBST	MOV		R3,R5
		B		VOLTAR
		
;---SUB-ROTINA 
s_max
		PUSH 	{R1-R2}		
		LDRB	R1,[R0]
		LDRB	R2,[R0,#1]!
		CMP		R1,R2
		BHI		R1MAIOR		; Se R1>R2 segue branch	
		MOV		R5,R2		; Caso contrario, armazena R2 em R5	
		B		VOLTA		
		
R1MAIOR	
		MOV		R5,R1		; Armazena R1 em R5	
	
VOLTA   
		POP		{R1-R2}
		BX		R14
		END




