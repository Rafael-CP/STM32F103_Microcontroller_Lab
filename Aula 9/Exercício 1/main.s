;Ex_9.1a
		export 	__main
;---diret. area-dados (sram)sram
		area 	dds1, data, readwrite
vb1c 	space 	1
vb1d 	space 	1
vb1u 	space 	1
vb1bin 	space 	1

vb2c 	space 	1
vb2d 	space 	1
vb2u 	space 	1
vb2bin	space	1

vbsoma	space	1
	
vbsc 	space 	1
vbsd 	space 	1
vbsu 	space 	1
;---diret area-prog (flash)
		area mprg, code, readonly
__main
		ldr 	r0,=vb1c
		mov		r3,#2			; LOOP PARA 2 VALORES
								; CONVERSAO PARA BINARIO
pki		mov 	r1,#0 			;nbin=0
pk0		ldrb 	r2,[r0] 		;r2=cent
		ands 	r2,r2,#&0f 		;pres.nibbleLSB
		beq 	pk1
		sub 	r2,r2,#1
		strb 	r2,[r0]
		add 	r1,r1,#100
		b 		pk0
		
pk1 	ldrb 	r2,[r0,#1]
		ands 	r2,r2,#&0f
		beq 	pk2
		sub 	r2,r2,#1
		strb 	r2,[r0,#1]
		add 	r1,r1,#10
		b 		pk1
		
pk2 	ldrb 	r2,[r0,#2]
		and 	r2,r2,#&0f
		add 	r1,r2
		strb 	r1,[r0,#3]
		add		r0,#4
		subs	r3,#1
		bne		pki
								; SOMATORIA 		
		ldrb	r1,[r0,#-5]
		ldrb	r2,[r0,#-1]
		add		r3,r1,r2
		strb	r3,[r0]
								; CONVERSAO PARA BCD
pkis 	mov 	r1,#0 ;
		str 	r1,[r0,#1]		;cent=dez=unid=0
pk0s 	ldrb 	r2,[r0]
		subs 	r2,r2,#100
		bmi 	pk1s
		strb 	r2,[r0]
		ldrb 	r1,[r0,#1]
		add 	r1,#1
		strb 	r1,[r0,#1]
		b 		pk0s
pk1s 	ldrb 	r2,[r0]
		subs 	r2,#10
		bmi 	pk2s
		strb 	r2,[r0]
		ldrb 	r1,[r0,#2]
		add 	r1,#1
		strb 	r1,[r0,#2]
		b 		pk1s
pk2s 	ldrb 	r2,[r0]
		strb 	r2,[r0,#3]
		b 		pkis
		end
		
		
		end