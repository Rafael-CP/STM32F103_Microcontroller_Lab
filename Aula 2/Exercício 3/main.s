		EXPORT __main
		AREA PROGRAM, CODE, READONLY
vlr1	EQU	0
vlr2	EQU &AB
vlr3	EQU	&ECA
vlr4	EQU &FAE
		AREA PROGRAM, CODE, READONLY
__main
		MOVW R0, #0 	;reseta o registro r0 com end imediato 
		MOVW R1, #vlr2	;seta valores para r1
		ADD  R0, #vlr3 	;primeira soma imediata
		ADD	 R1, R0 	;segunda soma inerente
		ADD	 R1, #vlr4	;terceira soma imediata
		ADD	 R0, R1		;quarta soma inerente
LOOP	B	LOOP
		END