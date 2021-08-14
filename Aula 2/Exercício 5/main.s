		EXPORT __main		
			
		AREA M_DATA, DATA, READWRITE
			
vr1		EQU &9A 
vr2		EQU &ECA
vr3		EQU &98AD
vr4		EQU &FC71
vr5		EQU &D1
vr6		EQU &CCAA
	
		AREA PROGRAM, CODE, READONLY
__main						
		MOV	 R1, #vr1		; declarando vr1 (&0 < vr1 < &ff) 
		MOVW 	 R2, #vr2		; declarando vr2 (&0 < vr2 < &fff)	
		SUB	 R2, R1			; sub1 = vr2-vr1 (inerente)
		
		MOVW 	R3, #vr3		; declarando vr3 (&0 < vr3 < &ffff)
		MOVW 	R4, #vr4		; declarando vr4 (&0 < vr4 < &ffff)
		SUB	R4, R3			; sub2 = vr4 - vr3 
		
		MOVT 	R5, #vr5		; declarando vr5 (ficará no intervalo &0 < vr5 < &ffffff com o MOVT)
		MOVT 	R6, #vr6		; declarando vr6 (ficará no intervalo &0 < vr6 < &cfffffff com MOVT)
		SUB  	R6, R5			; sub3 = vr6-vr5

LOOP	B	LOOP
		END
			