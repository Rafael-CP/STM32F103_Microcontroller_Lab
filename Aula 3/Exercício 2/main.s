		EXPORT __main
		AREA M_DADOS, DATA, READONLY; FLASH
ct1		dcb 	2_00
ct2		dcb 	2_01
ct3		dcb 	2_10
ct4		dcb 	2_11
ct5		dcb 	2_100
ct6		dcb 	2_101
ct7		dcb 	2_110
ct8		dcb 	2_111

		AREA MEMORIA, DATA, READWRITE
mem1	space	1
mem2	space	1
mem3	space	1
mem4	space	1
mem5	space	1
mem6	space	1
mem7	space	1
mem8	space	1
	
		AREA M_PROGRAM, CODE, READONLY
__main
		MOV		r10 , #2_10
		LDR 	r0,= ct1
		LDRB	r1,[r0]
		MUL		r1, r10
		LDR		r9,=mem1
		STRB	r1,[r9]
		
		LDR 	r0,= ct2
		LDRB	r2,[r0]
		MUL		r2, r10
		LDR 	r9,=mem2
		STRB	r2,[r9]
		
		LDR 	r0,= ct3
		LDRB	r3,[r0]
		MUL		r3, r10
		LDR		r9,=mem3
		STRB	r3,[r9]
		
		LDR 	r0,= ct4
		LDRB	r4,[r0]
		MUL		r4, r10
		LDR		r9,=mem4
		STRB	r4,[r9]
		
		LDR 	r0,= ct5
		LDRB	r5,[r0]
		MUL		r5, r10
		LDR 	r9,=mem5
		STRB	r5,[r9]
		
		LDR 	r0,= ct6
		LDRB	r6,[r0]
		MUL		r6, r10
		LDR		r9,=mem6
		STRB	r6,[r9]
		
		LDR 	r0,= ct7
		LDRB	r7,[r0]
		MUL		r7, r10
		LDR		r9,=mem7
		STRB	r7,[r9]
		
		LDR 	r0,= ct8
		LDRB	r8,[r0]
		MUL		r8, r10
		LDR 	r9,=mem8
		STRB	r8,[r9]		
		
		NOP
LOOP	B		LOOP
		END