;---Ex_9.1a - bcd_c(dez,uni)-bin(1b)
		export 	__main
;---dir. area-dados-(sram)
		area 	dds1, data, readwrite
bcd 	space 	1
vbin 	space 	1
;---dir. area-progr. (flash)
		area 	m_prg, code, readonly
__main
pk0 	ldr 	r0,=bcd
rk0 	mov 	r1,#0
		movt 	r1,#0
		mov 	r3,r1 ;vbin
		ldrb 	r1,[r0] ;dez:uni
		and 	r2,r1,#&0f ;nibb_LSB
		add 	r3,r2 ;r3=unid
		and 	r2,r1,#&f0 ;nibb_MSB
		lsrs 	r2,r2,#4
		beq 	pk1 ;=0?
rk1 	add 	r3,#10
		subs 	r2,r2,#1
		bne 	rk1
pk1 	strb 	r3,[r0,#vbin-bcd];save vbin
		b 		rk0
		end