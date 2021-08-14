		EXPORT	__main
vt1		EQU		85
vt2		EQU		170
beta1	EQU		3280
beta2	EQU		11500
beta3	EQU		25120
	
		AREA	M_DADOS, DATA, READWRITE
vx1		SPACE	1
	
		AREA	M_PROGRAM, CODE, READONLY
__main	LDR		R0,=vx1	
		LDR		R1,[R0]		; Le valor de vx1
		CMP		R1,#0		; Checa se vx1 >= 0
		BCS		POS
		B		__main		; Se negativo, volta para o início do programa, se não, segue para POS	
		
POS		CMP		R1,vt1
		BLS		COND1		; Se menor ou igual à vt1, vai para condição 1, se não, segue comparando
		CMP		R1,vt2
		BCC		COND2		; Se for menor que vt2, vai para condição 2
		BCS		COND3		; Se maior ou igual a vt2, vai para condição 3
		B		__main		; Retorna ao inicio do programa

COND1	MOV		R2,#beta1	; 1 ciclo
LOOP1	SUBS	R2,#1
		BNE		LOOP1
		B		__main		; 3 ciclos
		
COND2	MOV		R2,#beta2	; 1 ciclo
LOOP2	SUBS	R2,#1
		BNE		LOOP2
		B		__main		; 3 ciclos

COND3	MOV		R2,#beta3	; 1 ciclo
LOOP3	SUBS	R2,#1
		BNE		LOOP3
		B		__main		; 3 ciclos
		END