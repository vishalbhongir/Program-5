; Main.asm
; Name:
; UTEid: 
; Continuously reads from x4600 making sure its not reading duplicate
; symbols. Processes the symbol based on the program description
; of mRNA processing.

               .ORIG x4000
; initialize the stack pointer
	
	LD R6, point

; set up the keyboard interrupt vector table entry
	LD R0, loc
	STI R0, dest

; enable keyboard interrupts
	LD R1, loca
	STI R1, destin



; start of actual program
				;start code (look for AUG)
loop	LDI R0, Buffer
	BRz loop
	TRAP x21
	AND R1, R1, #0
	STI R1, Buffer
	
	ADD R6, R6, #-1		;push
	STR R0, R6, #0
	
	
	LD R1, g
	ADD R1, R1, R0
	BRz checku
	BRnzp loop

checku
	LDR R4, R6, #1
	LD R1, u
	ADD R1, R1, R4
	BRz checka
	BRnzp loop

checka
	LDR R4, R6, #2
	LD R1, a
	ADD R1, R1, R4
	BRnp loop

	LD R0, line
	TRAP x21
	ADD R6, R6, #-3

				

loop2	LDI R0, Buffer
	BRz loop2
	TRAP x21
	AND R1, R1, #0			;stop code (look for UAG, UAA, UGA)
	STI R1, Buffer

	ADD R6, R6, #-1		;push
	STR R0, R6, #0
	
	LD R1, a
	ADD R1, R1, R0
	BRz stopcheckag		;first letter (a)
		

	LD R1, g
	ADD R1, R1, R0		;first letter (g)
	BRz stopchecka
	BRnzp loop2
	
stopchecka
	LDR R4, R6, #1
	LD R1, a		;second letter (a)
	ADD R1, R1, R4
	BRz stopchecku
	
	

	LDR R4, R6, #1
	LD R1, a
	ADD R1, R1, R4		;second letter (a)
	BRz stopchecku
	BRnzp loop2

stopcheckag
	LDR R4, R6, #1
	LD R1, a
	ADD R1, R1, R4		;second letter (a)
	BRz stopchecku
	
	LDR R4, R6, #1
	LD R1, g		;second letter (g)
	ADD R1, R1, R4
	BRz stopchecku	
	BRnzp loop2

stopchecku	
	LDR R4, R6, #2
	LD R1, u		;third letter (u)
	ADD R1, R1, R4
	BRz finish	
	BRnzp loop2

finish TRAP x25
	

point	.FILL x4000
loc	.Fill x2600
dest	.Fill x0180
loca	.Fill x4000
destin	.Fill xFE00
Buffer	.Fill x4600
a	.FILL x-41
c	.FILL x-43
g	.FILL x-47
u	.FILL x-55
line	.FILL x7C
		.END





