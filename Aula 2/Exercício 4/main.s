		EXPORT __main
			
		AREA M_DATA, DATA, READWRITE
		
vr1		EQU &88 
vr2		EQU &DAC
vr3		EQU &88B8
vr4		EQU &2710	
vr5x	EQU &1F
vr5y	EQU	&ECAF
vr6		EQU &ABCD


		AREA PROGRAM, CODE, READONLY
__main						; soma = 0 // Declara primeiros dois valores
		MOV	 R0, #vr1		; declarando vr1 (&0 < vr1 < &ff) 
		MOVW R1, #vr2		; declarando vr2 (&0 < vr2 < &fff)	
		ADD	 R1, R0			; soma += vr1+vr2 (inerente)
		MOVW R0, #vr3		; declarando vr3 (&0 < vr3 < &ffff)
		ADD	 R1, R0			; soma += vr3 
		MOVW R0, #vr4		; declarando vr4 (&0 < vr4 < &ffff)
		ADD	 R1, R0			; soma += vr4 
		MOVT R0, #vr5x		; declarando vr5 (ficará no intervalo &0 < vr5 < &ffffff com o MOVT)
		ADD	 R1, R0			; soma += vr5 
		MOVT R0, #vr6		; declarando vr6 (ficará no intervalo &0 < vr6 < &cfffffff com MOVT)
		ADD  R1, R0			; soma += vr6

LOOP	B	LOOP
		END
			