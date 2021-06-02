;========= EXERCICIO 1C ========= DO FINAL E ESPELHADO  (PRE INDEXADO)
		EXPORT 	__main
			
dist	EQU		vt2-vt1
	
		AREA 	M_DADOS, DATA,	READWRITE		
vt1		space	32		
vt2		space	32	
	
		AREA 	M_PROGRAMA, CODE, READONLY
__main	
		LDR		R0,=vt1+32		;recebe endereço de vt1 deslocado em 28 para pegar o ultimo elemento
		MOV		R8, #8			;contador
		LDR		R7,=vt2-4
		
LOOP	LDR		R1,[R0]			;carrega o conteudo de r0 em r1 (dados de vt1)
		STR		R1,[R7,#4]!		;armazena o conteudo de r1 em r0 deslocado de 16 espaços
		SUB		R0,#4			;caminha em r0 para pegar prox elemento de vt1
		SUBS	R8,#1			;subtrai para o contador
		BNE		LOOP
		B		__main
		END		