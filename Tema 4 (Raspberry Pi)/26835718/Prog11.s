.include "inter.inc"
.text
	mov r0, #0
	ADDEXC 0x18, irq_handler
	mov r0, #0b11010010
	msr cpsr_c, r0
	mov sp, #0x8000
	mov r0, #0b11010011
	msr cpsr_c, r0
	mov sp, #0x8000000
	
	ldr r0, =GPBASE
	mov r1, #0b00001000000000000000000000000000
	str r1, [r0, #GPFSEL0]
	ldr r1, =0b00000000001000000000000001000000
	str r1, [r0, #GPFSEL1]
	ldr r1, =0b00000000001000000000000001000000
	str r1, [r0, #GPFSEL2]
	
	ldr r0, =STBASE
	ldr r1, [r0, #STCLO]
	add r1, #3
	str r1, [r0, #SETC1]
	
	ldr r0, =INTBASE
	mov r1, #0b0010
	str r1, [r0, #INTENIRQ1]
	mov r0, #0b01010011
	msr cpser_c, r0
	
bucle: b bucle

irq_handler:
	push {r0, r1, r2, r3}
	ldr r0, =STBASE
	ldr r1, =GPBASE
	ldr r2, =cuenta
	
	ldr r3, =0b00001000010000100000111000000000
	str r3, [r1, #GPCLR0]
	ldr r3, [r2]
	subs r3, #1
	moveq r3, #6
	str r3, [r2]
	ldr r3, [r2+r3, LSL #2]
	str r3, [r1, #GPSET0]
	
	mov r3, #0b0010
	str r3, [r0, #STCS]
	
	ldr r3, [r0, #STCLO]
	ldr r2, =1000000
	add r3, r2
	str r3, [r0, #STC1]
	pop{r0, r1, r2, r3}
	subs pc, lr, #4

cuenta: .word 1
secuen: .word 0b10000000000000000000000000000000
		.word 0b00000100000000000000000000000000
		.word 0b00000000001000000000000000000000
		.word 0b00000000000000001000000000000000
		.word 0b00000000000000000100000000000000
		.word 0b00000000000000000010000000000000
	

	
	