.include "inter.inc"
.text
	mov r0, #0b11010011
	msr cpsr_c, r0
	mov sp, #0x08000000
	ldr r4, =GPBASE
/* guia bits xx999888777666555444333222111000 */
	mov r1, #0b00000000000000000001000000000000
	str r1, [r0, #GPFSEL0]
	mov r1, #0b00000000000000000000000000010000
	ldr r0, =STBASE
	ldr r2, =1908
	ldr r3, =1279
	mov r6, #0b00000000000000000000000000000100
	mov r7, #0b00000000000000000000000000001000
sonda1:
	ldr r8, [r4, #GPLEV0]
	tst r8, r6
	bne sonda2
	b sonido1
sonda2:
	ldr r9, [r4, #GPLEV0]
	tst r9, r7
	bne sonda1
	b sonido2

espera1:
	push {r4, r5}
	ldr r4, [r0, #STCLO]
	add r4, r2
ret1:
	ldr r5, [r0, #STCLO]
	cmp r5, r4
	blo ret1
	pop {r4, r5}
	bx lr
	
espera2:
	push{r4, r5}
	ldr r4, [r0, #STCLO]
	add r4, r3
ret2:
	ldr r5, [r0, #STCLO]
	cmp r5, r4
	blo ret2
	pop {r4, r5}
	bx lr

sonido1:
	bl espera1
	str r1, [r4, #GPSET0]
	bl espera1
	str r1, [r4, #GPSET0]
	b sonda2
	
sonido2:
	bl espera2
	str r1, [r4, #GPSET0]
	bl espera2
	str r1, [r4, #GPCLR0]
	b sonda1
	
	
	