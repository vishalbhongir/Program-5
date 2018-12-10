; ISR.asm
; Name:
; UTEid: 
; Keyboard ISR runs when a key is struck
; Checks for a valid RNA symbol and places it at x4600
.ORIG x2600

loop	LDI R0, KBSR		;start of the loop
	BRp loop
	LDI R0, KBDR
	
	LD R2, a
	ADD R2,R2,R0
	BRz valid

	LD R2, c
	ADD R2,R2,R0
	BRz valid

	LD R2, g
	ADD R2,R2,R0
	BRz valid

	LD R2, u
	ADD R2,R2,R0
	BRz valid
	BRnzp invalid
	
valid	LD R2, valids
	STR R0, R2,0 

invalid RTI		

KBSR	.FILL xFE00
KBDR	.FILL xFE02
valids	.FILL x4600
a	.FILL x-41
c	.FILL x-43
g	.FILL x-47
u	.FILL x-55
		.END
