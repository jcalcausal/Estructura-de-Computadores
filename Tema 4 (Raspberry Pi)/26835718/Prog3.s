.include "inter.inc"
.text
	ldr r0, =GPBASE
/* guia bits xx999888777666555444333222111000 */
	mov r1, #0b00001000000000000000000000000000
	str r1, [r0, #GPFSEL0]
/*guia bits 10987654321098765432109876543210 */
	mov r1, #0b00000000000000000000001000000000
bucle:
	str r1, [r0, #GPSET0]
	str r1, [r0, #GPCLR0]
	b bucle
*/No funciona ya que no podemos percibir el parpadeo por ser muy rapido*/