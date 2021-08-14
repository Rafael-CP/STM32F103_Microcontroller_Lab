;;---uso portas E/S
			export __main	
cnt_x		equ	10
	
;---regs. timer2
tim2_cr1 	equ &40000000 
tim2_sr 	equ &40000010  
tim2_psc 	equ &40000028  
tim2_arr 	equ &4000002C  
	
;--- cfg ports
rcc_apb2enr equ &40021018
	
;---regs. portB - SWITCH
gpiob_crl 	equ &40010c00
gpiob_crh 	equ &40010c04
gpiob_idr 	equ &40010c08
gpiob_odr 	equ &40010c0c
	
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

;---cfg inputs
			ldr r0,=gpiob_crl		;cfg portc PB12
			ldr r1,[r0,#4] ;
			orr r1,#&40000 			;PB12 input floating
			str r1,[r0]
				
			ldr r1,[r0,#4] 			;cfg portc PB13
			orr r1,#&400000 		;PB13 input floating
			str r1,[r0]
					
			ldr r1,[r0,#4] 			;cfg portc PB14
			orr r1,#&4000000 		;PB14 input floating
			str r1,[r0]
						
;---cfg PA outputs
			ldr 	r2,=gpioa_crl		;cfg porta PA
			ldr 	r0,=0x0000333
			str 	r0,[r2]
			
			ldr		r2,= gpioa_odr
			ldr		r0,= 0x0007
			
;---ler sw1,sw2 ou sw3
pk1			ldr 	r0,= gpiob_crl
			ldr 	r1,[r0,#8]			; gpiob_idr = >ler PB12
			ands 	r1,r1,#&1000 		; pres. PB12
			beq 	acende1				; acende o led quando Z = 1 (Resultado do ands igual a zero)
			
			ldr 	r1,[r0,#8]			; gpiob_idr = >ler PB13			
			ands 	r1,r1,#&2000 		; pres. PB13
			beq 	acende2				; acende o led quando Z = 1 
			
			ldr 	r1,[r0,#8]			; gpiob_idr = >ler PB14
			ands 	r1,r1,#&4000 		; pres. PB14
			beq 	acende3				; acende o led quando Z = 1 
			
apagados	ldr		r2,= gpioa_odr
			ldr		r0,= 0x0000
			str 	r0,[r2]
			b 		pk1
			
;---acende LED1		
acende1		ldr		r2,= gpioa_odr
			ldr		r0,= 0x0001
			str 	r0,[r2]
			b 		pk1
			
;---acende LED2		
acende2		ldr		r2,= gpioa_odr
			ldr		r0,= 0x0002
			str 	r0,[r2]
			b 		pk1

;---acende LED3		
acende3		ldr		r2,= gpioa_odr
			ldr		r0,= 0x0004
			str 	r0,[r2]
			b 		pk1

			end