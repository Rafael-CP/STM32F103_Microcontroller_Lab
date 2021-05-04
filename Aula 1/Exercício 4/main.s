; --- DIRETIVAS uVision ---
		EXPORT __main ;definida no startup
;=============================================
;--- DIRETIVA EQU (ATRIBUICAO) --- NAO USA ESPACO NA MEMORA
VLR1	EQU		&22
VLR2	EQU		10000
VLR3	EQU		2_1110011
;--- DIRETIVAS AREA (RAM) ---
		AREA	M_DADOS, DATA, READWRITE
CTB1	DCB		&99, VLR1*2, VLR1*3
;CTB2	DCW		VLR2*5
;CTB3	DCD		2, VLR3*3

;=============================================
;--- DIRETIVAS AREA (FLASH) ---
		AREA	M_PROG, CODE, READONLY
__main

		LDR		R3, =CTB1 	;R3 = (CTB1)		
AQUI 	B		AQUI	 	;LOOP INFINITO	
		END					;FECHAMENTO DO ARQUIVO

