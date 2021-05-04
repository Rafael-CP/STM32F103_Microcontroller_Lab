; --- DIRETIVAS uVision ---
		EXPORT __main ;definida no startup
;=============================================
;--- DIRETIVAS EQU ---
VLR1	EQU		10
;--- DIRETIVAS AREA (RAM) ---
		AREA	M_DADOS, DATA, READWRITE
CTB1	DCB		0XBB
MEM1	SPACE	7
CTB2	DCB		0XEB
MEM2	SPACE	VLR1
CTB3	DCB		0X99
;=============================================
;--- DIRETIVAS AREA (FLASH) ---
		AREA	M_PROG, CODE, READONLY
__main

		LDR		R1, =CTB1 	;R1 = (CTB1)		
AQUI 	B		AQUI	 	;LOOP INFINITO	
		END					;FECHAMENTO DO ARQUIVO

