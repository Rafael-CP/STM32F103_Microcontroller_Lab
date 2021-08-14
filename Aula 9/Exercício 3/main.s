;---Ex_9.1b - bin(1b<100)->bcd_c(dez,uni)
		export 	__main
;---dir. area-dados-(sram)
		area 	dds1, data, readwrite
vbin 	space	1
bcd 	space	1 ;(cent:dez:uni)
;---dir. area-progr. (flash)
		area m_prg, code, readonly
__main
;		INICIALIZAÇÃO
pk0 	ldr 	r0,=vbin
rk0 	mov 	r1,#0
		movt 	r1,#0
		mov 	r3,r1 	;bcd(dez:uni)
		mov		r4,r1	;bcd(cent)
		ldrb 	r1,[r0] ;vbin
		mov 	r2,r1

;		CENTENAS
rk1 	cmp 	r2,#100
		blo 	rk2
		subs 	r2,#100 ;nib_LSB
		add 	r4,#1 	;r4=r4+1
		b 		rk1
		
;		DEZENAS E UNIDADES
rk2 	cmp 	r2,#10
		blo 	pk1
		subs 	r2,#10 	;nib_LSB
		add 	r3,#1 	;r3=r3+1
		b 		rk2
		
pk1 	lsl 	r3,#4
		add 	r3,r2
		strb	r3,[r0,#bcd-vbin];save bcd
		strb	r4,[r0,#bcd-vbin+1]
		b 		rk0
		end
