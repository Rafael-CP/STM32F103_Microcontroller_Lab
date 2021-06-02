		EXPORT __main 
			
		AREA M_DATA, DATA, READWRITE	;Exercício 1b
valor1	EQU	&AA
valor2	EQU	2_11011
valor3	EQU	100
valor4	EQU	&DC
valor5	EQU	2_10101
valor6	EQU	8_35
valor7	EQU	50
valor8	EQU	8_17
	
		AREA PROGRAM, CODE, READONLY ; 1a & 1b
__main
		MOVW R0, #0
		ADD R0, #valor1
		ADD R0, #valor2
		ADD R0, #valor3
		ADD R0, #valor4
		ADD R0, #valor5
		ADD R0, #valor6
		ADD R0, #valor7
		ADD R0, #valor8
LOOP	B	LOOP	;LOOP INFINITO
		END			;ENCERRA O PROGRAMA