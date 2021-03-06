;---uso portas E/S
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
;---regs. portC - LED
gpioc_crl 	equ &40011000
gpioc_crh 	equ &40011004
gpioc_idr 	equ &40011008
gpioc_odr 	equ &4001100c

;---dir. area-progr. (flash)
			area m_prg, code, readonly
__main
pk0 		ldr r0,=rcc_apb2enr 	;en.clk ports B,C
			ldr r1,[r0] 			;l? apb2enr
			orr r1,r1,#&18 			;bits b4:b3=11
			str r1,[r0] 			;salva apb2enr
			
;---timer2 - en.clk TIM2
			ldr r1,[r0,#4]			;l? apb2enr = R0, que aponta para apb2, e sua distancia para apb1 ? de 4
			orr r1,r1,#&1 			;bits b0=1 = Agora o bit 0 precisa ter valor 1
			str r1,[r0,#4]			;salva apb1enr

;---cfg PB12 input
			ldr r0,=gpiob_crl		;cfg portc PB12
			ldr r1,[r0,#4] ;
			orr r1,#&40000 			;PB12 input floating
			str r1,[r0]
						
;---cfg PC13 output
			ldr r2,=gpioc_crl		;cfg portc PC13
			ldr r3,[r2,#4] ;
			orr r3,#&200000 		;PC13 output op-dr
			str r3,[r2,#4]
			
;---ci PC13=0(valor inicial) = Como PC13 foi definido como sa?da, ? necessario estabelecer um valor 
			mov r4,#&2000
			movt r4,#0
			str r4,[r2,#&c]			; = Coloca valor em gpioc_odr (Registro de saida de dados da porta C)
			mov r5,#cnt_x 			; cont.auxiliar
		
; timer2 cfg = Configuracao do sistema de temporizacao
; Regra de 3 => 1us = 1unidade (A cada clock de 1us, conta-se uma unidade) ; 0.05s = x => Encontra-se um valor de 50.000
; Portanto, para 0.05 segundos, o overflow de 5k deve acontecer 10 vezes (Por isso cont_x ? 10 e r3 ? 4999)
;---temporizacao
			ldr r0,=tim2_cr1 		; Ler endereco dos registros de Timer 2		
			mov r3,#4999		
			strh r3,[r0,#&2c] 		;tim2_arr=4999 => Coloca no registro de recarga o valor 4999 
			mov r3,#&7				;Divide a frequencia em 8, fazendo com que o clock opere com 1Mhz		
			strh r3,[r0,#&28] 		;tim_psc=&7 => Alteracao no registro de prescaler 
			
			ldrh r3,[r0] 			;l? tim2_cr1 = Controle do temporizador 
			orr r3,#1 				;b0=cen=1 => Coloca 1 no bit 0
			strh r3,[r0] 			;inicia(liga)timer!! = Coloca 1 em r0, iniciando contagem

;---ler sw1
pk1			ldr 	r0,=gpiob_crl
			ldr 	r1,[r0,#8]			; ler PB12
			ands 	r1,r1,#&1000 		; pres. PB12
			beq 	apaga				; apaga o led quando Z = 0 (Resultado do ands diferente de zero)	

;---acende PC13		
acende 		mov 	r3,#0			
			movt 	r3,#0
			str 	r3,[r2,#&c]
			b 		pk1

;---ler uif(timer overflow)-RECENSEAMENTO! = Calculamos quantos overflows serao necessarios para se atingir 0.05 segundos
apaga 		ldr 	r0,=tim2_cr1
			ldrh 	r3,[r0,#&10]		; ler [tim2_sr(uif)] = L? registro de status
			ands 	r3,r3,#&1 			; pres. uif = ? o bit que indica a presenca de overflow
			beq 	apaga 				; uif=0? = Enquanto 0, o contador ainda nao teve overflow (Recenseamento = monitora o bit uif)
			eor 	r3,#&1 				; Quando ocorre o overflow, bit que foi para 1 deve voltar a ser 0 
			strh 	r3,[r0,#&10]		; uif=0 = Retorna ao registro original
			subs 	r5,#1				; Contador ? subtraido por 1
			bne 	apaga				; 10 overflows para se ter 0.05 segundos
			mov		r5,#cnt_x 	 		; Reseta contador

;---apaga PC13			
			mov 	r3,#&2000
			movt 	r3,#0
			str 	r3,[r2,#&c]
			b		pk1		
			;---
			end
	