;=========EXERCICIO 2=======
		EXPORT __main
		AREA mdds1, data, readwrite
vr1		space 	1
vr2		space 	1
vr3		space 	1
		AREA mdds2, data, readwrite
sr1		space	2				
		AREA 	MPROG, CODE, READONLY
__main
		ldr		r0,=vr1
		ldr		r1,=sr1
		ldrb	r2,[r0]
		add		r0,#1
		ldrb	r3,[r0]
		add		r2,r3
		add		r0,#1
		ldrb	r3,[r0]
		add		r2,r3
		strh	r2,[r1]
LOOP	B		LOOP
		END