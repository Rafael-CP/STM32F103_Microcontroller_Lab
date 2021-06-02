		EXPORT __main
			
		AREA	M_DATA, DATA, READWRITE ;2b
vlr1	EQU		&AA
vlr2	EQU		&BB
vlr3	EQU		&CC
vlr4	EQU		&DD
vlr5	EQU		&EE
vlr6	EQU		&FF
vlr7	EQU		&ABC
vlr8	EQU		&DEF
	
		AREA 	PROGRAM, CODE, READONLY ;2a e 2b
__main
		MOV R0, #0		;reseta valor do registro
		ADD R0, #vlr1
		ADD R0, #vlr2
		ADD R0, #vlr3
		ADD R0, #vlr4
		ADD R0, #vlr5
		ADD R0, #vlr6
		ADD R0, #vlr7
		ADD R0, #vlr8
LOOP	B	LOOP
		END