		EXPORT 	__main
			
		AREA 	MDADOS, DATA, READWRITE
vr1		SPACE	2
vr2		SPACE	2
res		SPACE	3
		
		AREA 	MPROG, CODE,READONLY
__main	
START	LDR		R0,=vr1
		LDR		R1,=vr2
		LDR		R2,=res
		LDRH	R3,[R0]
		LDRH	R4,[R1]
		SUB		R5,R3,R4
		CMP		R5,#0		; Compara o resultado da subtracao com 0
		BEQ		COND1 		; Verifica se eh igual a 0 (se flag Z = 1)
		BMI		COND2		; Verifica se eh negativo (se flag N = 1)
		BL		sb_res		; Se nenhuma condicao satisfaz, valor eh positivo
		B		START

COND1	BL		sb_10		; Se for 0, executa trecho de 10ms
		B		START

COND2	MOV		R6,#-1
		MUL		R5,R6		; Se for negativo, calcula modulo de R5 e executa sub-rotina 
		BL		sb_res
		B		START
		
;---SUB-ROTINA (TEMPORIZADOR 10ms APROXIMADO)
sb_10	
		PUSH	{R1-R2}
		LDR		R2,=80000	; 10ms = 80000 ciclos
LOOP1	SUBS	R2,#1		; O loop irá durar 10ms
		BNE		LOOP1
		POP		{R1-R2}
		BX		R14
		
;---SUB-ROTINA (TEMPORIZADOR PROPORCIONAL)
sb_res	
		PUSH 	{R1-R5}
		MOV		R1,#200		; 8MHz => 0.125us por ciclo ===> 25us = 200 ciclos
		MUL 	R3,R5,R1	; Pega valor calculado
LOOP2	SUBS	R3,#1		; 1 unidade de res equivale a 25 us, que equivale 200 ciclos
		BNE		LOOP2
		BX		R14
		END




