.orig x1200
; Interupt routine
; R6 is SP
add r6 r6 #-2
stw r0 r6 #0
add r6 r6 #-2
stw r1 r6 #0
add r6 r6 #-2
stw r2 r6 #0
add r6 r6 #-2
stw r3 r6 #0
add r6 r6 #-2
stw r4 r6 #0
; done pushing


lea r0 pagetable
lea r1 ptlen
lea r2 mask
ldw r0 r0 #0	; Page Table Base
ldw r1 r1 #0	; Iterator
ldw r2 r2 #0	; Mask
and r3 r3 #0	; Operator register
and r4 r4 #0 	; Current address <- r0 + r1

loop	add r4 r0 r1
		ldw r3 r4 #0
		and r3 r3 r2
		stw r3 r4 #0
		add r1 r1 #-1
		brp loop


rti


; POPs

ldw r4 r6 #0
add r6 r6 #2
ldw r3 r6 #0
add r6 r6 #2
ldw r2 r6 #0
add r6 r6 #2
ldw r1 r6 #0
add r6 r6 #2
ldw r0 r6 #0
add r6 r6 #2

RTI
pagetable 	.fill x1000
ptlen 		.fill x0080
mask 		.fill xFFFE
.end
