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

loop	BRnzp loop

; start of actual program

point	.FILL x4000
loc	.Fill x2600
dest	.Fill x0180
loca	.Fill x4000
destin	.Fill xFE00
		.END
