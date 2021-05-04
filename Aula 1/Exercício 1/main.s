;--- DIRETIVAS uVision ---
		EXPORT	__main ; definido no caminho Startup
;=======================================================
;--- DIRETIVA AREA - DADOS (RAM) ---
		AREA	MEUS_DADOS, DATA, READWRITE
;CTB1	DCB		0XAC, &EE		; reserva e valor HEXADECIMAL em programa 
;CTB1	DCB		4, 9			; reserva e valor DECIMAL em programa
CTB1	DCB		2_100, 2_110	; reserva e valor BINARIO em programa
CTB2	DCB		'A', "TESTE"	; reserva e valor LITERAL em programa

;=======================================================
;--- TRECHO DE PROGRAMA PARA EVITAR ERRO DE COMPILACAO ---

;--- INFORMACOES DO PROGRAMA SERAO ARMAZENADAS EM FLASH ---
		AREA	MEUPROGR, CODE, READONLY

__main
		LDR		R1, =CTB1 ;R1 = CTB1
		LDR		R2, =CTB2 ;R2 = CTB2
AQUI	B		AQUI 
		END
;=======================================================			
