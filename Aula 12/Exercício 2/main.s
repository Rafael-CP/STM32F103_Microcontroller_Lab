;Ex_12.2a uso timer2/pwm1
;per=0,5s;ton=0,25s
			export __main
;--- cfg rcc
rcc_apb2enr equ &40021018
rcc_apb1enr equ &4002101C
;---regs. timer2
tim2_cr1 	equ &40000000
tim2_sr 	equ &40000010
tim2_ccmr1 	equ &40000018
tim2_ccer1 	equ &40000020
tim2_psc 	equ &40000028
tim2_arr 	equ &4000002C
tim2_ccr1 	equ &40000034
;---regs. portA
gpioa_crl 	equ &40010800
gpioa_crh 	equ &40010801
gpioa_idr 	equ &40010808
gpioa_odr 	equ &4001080c
;---dir. area-progr. (flash)
			area m_prg, code, readonly
__main
pk0 		ldr r0,=rcc_apb2enr ;en.clk port A,C
			ldr r1,[r0] ;lê apb2enr
			orr r1,r1,#&14 ;bit b4=b2=1(C,A)
			str r1,[r0] ;salva apb2enr
;---timer2 enable clk
			ldr r1,[r0,#4];lê apb1enr
			orr r1,r1,#&1 ;bit b0=1
			str r1,[r0,#4];salva apb1enr

;---cfg PA0 e PA1
			ldr r0,=gpioa_crl ;cfg.portA,PA0 e PA1
			ldr r3,[r0] ;altenate function p-p
			eor r3,r3,#&ee ;OC (PA0 e PA1)
			str r3,[r0]
;timer2 cfg
; Frequencia de 100Hz => 
;	freq do clock 8MHz/80 = 100kHz
;	arr+1 = 10k
; 100k/10k = 100Hz
			ldr r0,=tim2_cr1
			mov r3,#9999
			strh r3,[r0,#&2c] ;arr=9999
;---
			mov r3,#79 ; 799 para melhor visualizacao!
			str r3,[r0,#&28] ;psc=79(fsys/80)
			
; Para um ciclo de 85%, temos que ccr1 deve ser 85% do valor de arr, portanto 10k*85% = 8.5k
			mov r3,#8500
			strh r3,[r0,#&34] ;ccr1=8500
;---
			ldrh r3,[r0,#&18] ;lê ccmr1
			orr r3,#&60 ;pwm1 para output compare 1
			strh r3,[r0,#&18] ;ccmr1=&60

; Para um ciclo de 15%, temos que ccr1 deve ser 15% do valor de arr, portanto 10k*15% = 1.5k
			mov r3,#1500
			strh r3,[r0,#&38] ;ccr2=1500
;---
			ldrh r3,[r0,#&18] ;lê ccmr1
			orr r3,#&6000 ;pwm1 para output compare 2
			strh r3,[r0,#&18] ;ccmr1=&6000
			
;--- Configura a saída do temporizador 1 
			ldrh r3,[r0,#&20] ;lê ccer
			orr r3,#&01 ;enable OC1
			strh r3,[r0,#&20] ;ccer=&1

;--- Configura a saída do temporizador 2 
			ldrh r3,[r0,#&20] ;lê ccer
			orr r3,#&10 ;enable OC2
			strh r3,[r0,#&20] ;ccer=&10
;---
			ldr r3,[r0]
			orr r3,#1 ;b0=cen=1
			strh r3,[r0] ;inicia(liga)timer!!
			end