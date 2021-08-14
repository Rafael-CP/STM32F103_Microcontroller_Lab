;;---uso portas E/S
			export __main	
cnt_x		equ	10
	
;---regs. timer2
tim2_cr1 	equ &40000000 
tim2_sr 	equ &40000010  
tim2_psc 	equ &40000028  
tim2_arr 	equ &4000002C  
tim2_ccr2 	equ &40000038 ; OUTPUT COMPARE 2
	
;--- cfg ports
rcc_apb2enr equ &40021018
	
;---regs. portA - LEDS
gpioa_crl 	equ &40010800
gpioa_crh 	equ &40010804
gpioa_idr 	equ &40010808
gpioa_odr 	equ &4001080C
	
;---dir. area-progr. (flash)
			area m_prg, code, readonly
__main
pk0 		ldr r0,=rcc_apb2enr 	;en.clk ports B,A
			ldr r1,[r0] 			;lê apb2enr
			orr r1,r1,#&c 			;bits b2:b3=11
			str r1,[r0] 			;salva apb2enr
			
;---timer2 - en.clk TIM2
			ldr r1,[r0,#4]			;lê apb2enr = R0, que aponta para apb2, e sua distancia para apb1 é de 4
			orr r1,r1,#&1 			;bits b0=1 = Agora o bit 0 precisa ter valor 1
			str r1,[r0,#4]			;salva apb1enr

;---cfg PA outputs
			ldr 	r2,=gpioa_crl	;cfg porta PA
			ldr 	r0,=0x0000333
			str 	r0,[r2]
			ldr		r2,=gpioa_odr	;estado inicial desligado
			and		r1,#0x0
			str 	r1,[r2]
;timer2 cfg
			; arr * T = 0.33
			; Escolhendo arbitrariamente um arr de 10k, encontra-se um T de 33us, logo f = 30.3kHz.
			; Queremos 0.33 segundos. Para isso, sera contado até 10.000 com periodos de 33us (10k*33u = 0.33s)
			ldr r0,=tim2_cr1
			mov r3,#9999
			strh r3,[r0,#&2c] 	;tim2_arr=9999
			mov r3,#263			;Prescaler agora sera 263, dividindo a frequencia de 8 MHz em 264
			str r3,[r0,#&28] 	;tim_psc=264(fsys/264) Agora possui uma frequencia de 30.3kHz e um periodo de 33us
			mov r3,#2000		;move valor 2000 para registro de comparacao 2
			strh r3,[r0,#&38] 	;tim2_ccr2=2000
			ldrh r3,[r0] 		;lê tim2_cr2
			orr r3,#1 			;b0=cen=1
			strh r3,[r0] 		;inicia(liga)timer!!
				
;---ler cc1if(compare=cnt)-RECENSEAMENTO!
			mov	r5,#0
pk1 				
			
			ldrh r3,[r0,#&10]	;ler [tim2_sr(cc1if)] = Lendo registro de status no bit que indica igualdade na contagem e no registro ccr
			ands r3,r3,#&2 		;pres.cc1if
			beq pk1 			;cc1if=0?
			
			cmp	r5,#0
			beq	desligado
			cmp	r5,#1
			beq	pisca1
			cmp	r5,#2
			beq	pisca2
			cmp	r5,#3
			beq	pisca3
			b	pk1
									
desligado	ldr	r2,= gpioa_odr  ;Leds desligados
			eor	r4,#0x0
			str r4,[r2]						
			eor r3,#&2 ;
			strh r3,[r0,#&10]	;cc1if=0
			add	r5,#1
			b	pk1			
				
pisca1		ldr	r4,[r2]		 	;r4=gpioa_odr
			eor	r4,#0x0001			
			str r4,[r2]		
			eor r3,#&2 ;
			strh r3,[r0,#&10]	;cc1if=0
			add	r5,#1
			b	pk1			
			
pisca2		ldr	r4,[r2]		 	;r4=gpioa_odr
			eor	r4,#0x0002			
			str r4,[r2]	
			eor r3,#&2 ;
			strh r3,[r0,#&10]	;cc1if=0
			add	r5,#1
			b	pk1	
			
pisca3		ldr	r4,[r2]		 	;r4=gpioa_odr
			eor	r4,#0x0004			
			str r4,[r2]	
			eor r3,#&2 ;
			strh r3,[r0,#&10]	;cc1if=0
			mov	r5,#0		
			b 		pk1
			end