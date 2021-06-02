		EXPORT __main
		AREA M_DADOS, DATA, READONLY ;FLASH
ct1		dcb 	&aa
ct2		dcb 	&bb
ct3		dcb 	&cc
ct4		dcb 	&dd
ct5		dcb 	&ee
ct6		dcb 	&ff
ct7		dcb 	&1a
ct8		dcb 	&2b

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
		LDR 	r0,= ct1
		LDRB	r1,[r0]
		LDR		r9,=mem1
		STRB	r1,[r9]
		
		LDR 	r0,= ct2
		LDRB	r2,[r0]
		LDR 	r9,=mem2
		STRB	r2,[r9]
		
		LDR 	r0,= ct3
		LDRB	r3,[r0]
		LDR		r9,=mem3
		STRB	r3,[r9]
		
		LDR 	r0,= ct4
		LDRB	r4,[r0]
		LDR		r9,=mem4
		STRB	r4,[r9]
		
		LDR 	r0,= ct5
		LDRB	r5,[r0]
		LDR 	r9,=mem5
		STRB	r5,[r9]
		
		LDR 	r0,= ct6
		LDRB	r6,[r0]
		LDR		r9,=mem6
		STRB	r6,[r9]
		
		LDR 	r0,= ct7
		LDRB	r7,[r0]
		LDR		r9,=mem7
		STRB	r7,[r9]
		
		LDR 	r0,= ct8
		LDRB	r8,[r0]
		LDR 	r9,=mem8
		STRB	r8,[r9]		
		
		NOP
LOOP	B		LOOP
		END