.include "inter.inc"
.text
	mov r0, #0b11010011
	msr cpsr_c, r0
	mov sp, #0x08000000
	ldr r0, =GPBASE
	mov r5, #0b00001000000000000000000000000000
	str r5, [r0, #GPFSEL0]
	mov r5, #0b00000000000000000000001000000000
	ldr r1, =STBASE
	ldr r3, =3000000
bucle:
	ldr r2, =1000000
	bl bucle1
	ldr r2, =500000
	bl bucle1
	ldr r2, =250000
	bl bucle1
	b bucle

bucle1:
	mov r5, #5
	mov r6, #0
	mov r7, #0b00000000000000000000001000000000
	bl espera
	str r7, [r0, #GPSET0]
	bl espera
	str r7, [r0, #GPCLR0]
	addi r6, r6, #1
	cmp r6, r5
	blo bucle1
	bx lr
espera:
	push {r4, r5}
	ldr r4, [r0, #STCLO]
	add r4, r2
ret1:
	ldr r5, [r0, #STCLO]
	cmp r5, r4
	blo ret1
	pop {r4, r5}
	bx lr