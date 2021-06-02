;========= EXERCICIO 1A ========= DO FINAL
		EXPORT 	__main
					
dist	EQU		vt2-vt1

		AREA 	M_DADOS, DATA,	READWRITE		
vt1		space	16		
vt2		space	16	

	
		AREA 	M_PROGRAMA, CODE, READONLY
__main	
		LDR		R0,=vt1+7	;recebe endereço de vt1 deslocado em 7 para pegar o ultimo elemento
		MOV		R8, #16		;contador
		
LOOP	LDRSB	R1,[R0]		;carrega o conteudo de r0 em r1 (dados de vt1)
		STRB	R1,[R0,#8] 	;armazena o conteudo de r1 em r0 deslocado de 16 espaços
		SUB		R0,#1		;caminha em r0 para pegar prox elemento de vt1
		SUBS	R8,#1		;subtrai para o contador
		BNE		LOOP
		B		__main
		END
