		EXPORT 	__main
;===================================			
		AREA 	MEMORIA, DATA, READWRITE 
mem1	space	6
mem2	space	6
mem3	space	12
	
		AREA	PROGRAMA, CODE, READONLY
__main
		LDR		r0,=mem1
		LDRB	r1,[r0]
		LDR		r0,=mem2
		LDRSB	r2,[r0]
		SUB		r3,r1,r2
		LDR 	r4,=mem3
		STRH	r3,[r4] 
		
		LDR		r0,=mem1+1
		LDRB	r1,[r0]
		LDR		r0,=mem2+1
		LDRSB	r2,[r0]
		SUB		r3,r1,r2
		LDR 	r4,=mem3+2
		STRH	r3,[r4] 
		
		LDR		r0,=mem1+2
		LDRB	r1,[r0]
		LDR		r0,=mem2+2
		LDRSB	r2,[r0]
		SUB		r3,r1,r2
		LDR 	r4,=mem3+4
		STRH	r3,[r4] 
		
		LDR		r0,=mem1+3
		LDRB	r1,[r0]
		LDR		r0,=mem2+3
		LDRSB	r2,[r0]
		SUB		r3,r1,r2
		LDR 	r4,=mem3+6
		STRH	r3,[r4] 
		
		LDR		r0,=mem1+4
		LDRB	r1,[r0]
		LDR		r0,=mem2+4
		LDRSB	r2,[r0]
		SUB		r3,r1,r2
		LDR 	r4,=mem3+8
		STRH	r3,[r4] 
		
		LDR		r0,=mem1+5
		LDRB	r1,[r0]
		LDR		r0,=mem2+5
		LDRSB	r2,[r0]
		SUB		r3,r1,r2
		LDR 	r4,=mem3+10
		STRH	r3,[r4] 
		
LOOP	B	LOOP
		END
			