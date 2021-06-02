;========= EXERCICIO 3C ========= DO FINAL ESPELHADO
		EXPORT 	__main
					
dist	EQU		vt2-vt1

		AREA 	M_DADOS, DATA,	READWRITE		
vt1		space	32	; 8 elementos de 4 bytes ocupam 32 espaços
vt2		space	32		
	
		AREA 	M_PROGRAMA, CODE, READONLY
__main	
		LDR		R0,=vt1+28		;recebe endereço de vt1 deslocado em 28 para pegar o ultimo elemento
		MOV		R8, #8			;contador
		LDR		R7,=vt2
		
LOOP	LDR		R1,[R0], #-4	;carrega o conteudo de r0 em r1 (dados de vt1) e subtrai 4 em r0
		STR		R1,[R7], #4	;armazena o conteudo de r1 em r0 deslocado de 36 espaços, 
		
		;ADD	R0,#2			;[NÃO SERÁ MAIS NECESSÁRIO]
		SUBS	R8,#1			;subtrai para o contador
		BNE		LOOP
		B		__main
		END
