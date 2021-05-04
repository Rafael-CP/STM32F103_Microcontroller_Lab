; --- DIRETIVAS uVision ---
		EXPORT __main ;definida no startup
;=============================================
;--- DIRETIVAS AREA (RAM) ---
		AREA	M_DADOS, DATA, READWRITE
;CTB1	DCB		0X88, &EE
;CTB2 	DCW		&88EE, 32000, &FFCC
;CTB3 	DCW		2_111010, 8_52
CTB4 	DCW		&C8, &88B8;, &101D0 ;200, 35k e 66k( nao é possível

;=============================================
;--- DIRETIVAS AREA (FLASH) ---
		AREA	M_PROG, CODE, READONLY
__main

		LDR		R2, =CTB4 	;R2 = (CTB2)		
AQUI 	B		AQUI	 	;LOOP INFINITO	
		END					;FECHAMENTO DO ARQUIVO

