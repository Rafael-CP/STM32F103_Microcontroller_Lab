		export 	__main
tam		equ		5
;---diret. area-dados (sram)sram
		area 	dds1, data, readwrite
vbd		space	tam
vbin	space	tam	
vbsoma	space	2
vbsm	space	1
vbsc 	space 	1
vbsd 	space 	1
vbsu 	space 	1
;---diret area-prog (flash)
		area mprg, code, readonly
__main
start	ldr 	r0,=vbd-1
		mov		r3,#tam			; CONTADOR DE LOOP PARA 5 VALORES
loop1	ldrb	r1,[r0,#1]!
		cmp		r1,#100
		bhs		start
		bl		BCDBIN	
		subs	r3,#1
		bne		loop1
		
		ldr		r0,=vbin
		mov		r3,#tam
		mov		r5,#0
loop2	ldrb	r2,[r0], #1
		add		r5,r2
		subs	r3,#1
		bne		loop2
		strh	r5,[r0],#2		
		ldr 	r0,=vbsoma
		bl		BINBCD
		b		start

; ---------- CONVERSAO BCD PARA BINÁRIO ----------		
BCDBIN	push 	{r1-r3}						
		mov 	r1,#0 
		movt	r1,#0
		mov		r3,r1
		ldrb 	r1,[r0]
		and 	r2,r1,#&0f
		add 	r3,r2
		and		r2,r1,#&f0
		lsrs	r2,r2,#4
		beq		pk1
rk1		add		r3,#10
		subs	r2,r2,#1
		bne		rk1
pk1		strb	r3,[r0,#5]		
		pop		{r1-r3}
		bx		r14

; ---------- CONVERSAO BINÁRIO PARA BCD ----------
BINBCD	push	{r1-r2}
pki 	mov 	r1,#0 ;
		str 	r1,[r0,#1]		;cent=dez=unid=0
pk0 	ldrb 	r2,[r0]
		subs 	r2,r2,#100
		bmi 	pk12
		strb 	r2,[r0]
		ldrb 	r1,[r0,#1]
		add 	r1,#1
		strb 	r1,[r0,#1]
		b 		pk0
pk12 	ldrb 	r2,[r0]
		subs 	r2,#10
		bmi 	pk2
		strb 	r2,[r0]
		ldrb 	r1,[r0,#2]
		add 	r1,#1
		strb 	r1,[r0,#2]
		b 		pk12
pk2 	ldrb 	r2,[r0]
		strb 	r2,[r0,#3]
		pop		{r1-r2}
		bx		r14
		end	