.include "inter.inc"
.text
	mov r0, #0b11010011
	msr cpsr_c, r0
	mov sp, #0x08000000
	ldr r4, =GPBASE
	mov r5, #0b00001000000000000000000000000000
	str r5, [r4, #GPFSEL0]
	mov r5, #0b00000000000000000000001000000000
	ldr r0, =STBASE
	ldr r1, =1000000
bucle:
	bl  espera
	str r5, [r4, #GPSET0]
	bl espera
	str r5, [r4, #GPCLR0]
	b bucle
espera:
	push {r4, r5}
	ldr r4, [r0, #STCLO]
	add r4, r1
ret1:
	ldr r5, [r0, #STCLO]
	cmp r5, r4
	blo ret1
	pop {r4, r5}
	bx lr