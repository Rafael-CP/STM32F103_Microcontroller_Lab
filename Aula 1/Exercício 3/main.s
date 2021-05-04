; --- DIRETIVAS uVision ---
		EXPORT __main ;definida no startup
;=============================================
;--- DIRETIVAS AREA (RAM) ---
		AREA	M_DADOS, DATA, READWRITE
CTE1	DCB		0X88, &EE, 12, 8_1 ; PULA 4 ESPACOS NA MEMORIA PARA O DCD E 1 PARA DCW
CTE2	DCW		32000, 0X540
CTE3	DCD		&11223344, &7788AACC
CTE4 	DCD		100000, 8_352300
;=============================================
;--- DIRETIVAS AREA (FLASH) ---
		AREA	M_PROG, CODE, READONLY
__main

		LDR		R2, =CTE2 	;R2 = (CTB2)		
AQUI 	B		AQUI	 	;LOOP INFINITO	
		END					;FECHAMENTO DO ARQUIVO

