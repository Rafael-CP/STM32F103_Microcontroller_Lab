;Ex_13.1a - uso systick timer
;apg/acd led pc13, 0,5s 0,25s e 1s
			export 	__main
			export	__isrST
;---regs rcc
rcc_apb2enr equ 	&40021018
rcc_apb1enr equ 	&4002101C
;---regs. portA
gpioa_crl 	equ 	&40010800
gpioa_crh 	equ 	&40010804
gpioa_idr 	equ 	&40010808
gpioa_odr 	equ 	&4001080c
;---regs. portC
gpioc_crl 	equ 	&40011000
gpioc_crh 	equ 	&40011004
gpioc_idr 	equ 	&40011008
gpioc_odr 	equ 	&4001100c
;---regs. timer2
tim2_cr1 	equ 	&40000000
tim2_sr 	equ 	&40000010
tim2_ccmr1 	equ 	&40000018
tim2_ccer1 	equ 	&40000020
tim2_psc 	equ 	&40000028
tim2_arr 	equ 	&4000002C
tim2_ccr1 	equ 	&40000034
;---regs SysTick
stk_ctrl 	equ 	&e000e010
stk_load 	equ 	&e000e014
;---dir. area-progr. (flash)
			area m_prg, code, readonly
__main
pk0 		ldr r0,=rcc_apb2enr ;en.clk port C e A
			ldr r1,[r0] ;lê apb2enr
			orr r1,r1,#&14 ;bit b4=1(C) e b2 = 1(A)
			str r1,[r0] ;salva apb2enr
;---timer2 enable clk
			ldr r1,[r0,#4];lê apb1enr
			orr r1,r1,#&1 ;bit b0=1
			str r1,[r0,#4];salva apb1enr			
;---cfg PA0 e PA1 output
			ldr r0,=gpioa_crl
			ldr r3,[r0]
			eor r3,#&e6 ;PA0 general output p-p e PA1 alternate output pp 
			str r3,[r0]
;---cfg PA0 = 0 (valor inicial) => ja comeca em 0 devido ao reset value
;---cfg/ci PC13 output
			ldr r2,=gpioc_crl;cfg portc PC13
			ldr r3,[r2,#4] ;
			orr r3,#&200000 ;PC13 output op-dr
			str r3,[r2,#4]
;---ci PC13=0(valor inicial)
			mov r4,#&2000
			movt r4,#0
			str r4,[r2,#&c]
; timer2 cfg
; Fazendo t = nT = 2 segundos
; n = 40k
; Utilizando uma frequencia de 20kHz
; Encontraremos um x de 400, que é o valor do prescaler.
			ldr r0,=tim2_cr1
			mov r3,#39999
			strh r3,[r0,#&2c] ;Auto reload = 1999999
			
			mov r3,#399
			str r3,[r0,#&28] ;psc=400(fsys/400) ;freq de 20kHz
			
			mov r3,#3000
			strh r3,[r0,#&38] ;ccr2=3000
;---
			ldrh r3,[r0,#&18] ;lê ccmr1 
			orr r3,#&3000 ;toggle qdo igual ; &30 PARA OUTPUT COMPARE 1 E &3000 PARA 2
			strh r3,[r0,#&18] ;ccmr1=&3000
;---
			ldrh r3,[r0,#&20] ;lê ccer
			orr r3,#&10 ;enable OC2
			strh r3,[r0,#&20] ;ccer=&10
;---
			ldr r3,[r0]
			orr r3,#1 ;b0=cen=1
			strh r3,[r0] ;inicia(liga)timer!!

; LOAD/FREQ = T
; LOAD/1M = 0.5 => LOAD = 500k
;---cfg SysTick
			mov r1,#&a11f ;499999 (500k usando frequencia de 1mhz)
			movt r1,#&7
			ldr r0,=stk_ctrl ;
			str r1,[r0,#&04] ;stk_load=499999

;---iniciar contagem
			ldr r1,[r0]  ;lê stk_ctrl
			orr r1,#&3   ; CLKSOURCE = 0, OU SEJA, 8MHz/8 = 1MHz ; INT = 1, OU SEJA, CRIA INTERRUPCAO
			str r1,[r0]  ;stk_ctrl(b0)=1 (b1) = 1 (b2) = 0
			mov	r7,#2
			mov r8,#4
; loop principal 			
pkx 		b pkx		

__isrST 	ldr r2,=gpioc_crl
			ldr r4,[r2,#&c];ler gpioc_odr
			eor r4,#&2000
			str r4,[r2,#&c]	
			subs r7,#1
			beq	lg_pa0  ; se r7 = 0, segue branch e acende pa0
			bx lr ;importante!!
			
lg_pa0		ldr r2,=gpioa_crl
			ldr r4,[r2,#&c];ler gpioa_odr
			eor r4,#&1
			str r4,[r2,#&c]	
			mov	r7,#2	
			bx lr
			end				
			