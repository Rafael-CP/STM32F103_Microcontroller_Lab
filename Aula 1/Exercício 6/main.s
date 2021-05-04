; --- DIRETIVAS uVision ---
		EXPORT __main ;definida no startup
;=============================================
;--- DIRETIVAS AREA (RAM) ---
		AREA	M_DADOS, DATA, READWRITE
MEM1	FILL	3, &BB, 1 
CT1		DCD		100000
MEM2	FILL	5, &69, 1 
ESPAC1	SPACE	16
MEM3	FILL	3, 3, 1

;=============================================
;--- DIRETIVAS AREA (FLASH) ---
		AREA	M_PROG, CODE, READONLY
__main

		LDR		R1, =MEM1 	;R1 = (MEM1)		
AQUI 	B		AQUI	 	;LOOP INFINITO	
		END					;FECHAMENTO DO ARQUIVO

