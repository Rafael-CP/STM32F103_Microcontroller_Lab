		EXPORT __main

		AREA M_PROGRAM, CODE, READONLY
__main
pk0    	mov     r0, #&FF1
		ldrb    r1,[r0]
		b       pk3
pk1 	add     r2,r0,r1
		b       pk0
pk3    	ldrh    r2,[r0]
		add     r3,r1,r2
		nop
		b       pk1
LOOP   	B		LOOP
		END