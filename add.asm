.orig x3000
;.fill xabcd ; Unkown Opcode

lea r0 data
ldw r0 r0 #0
lea r1 tostore
ldw r1 r1 #0
and r2 r2 x0
add r2 r2 #10;
add r2 r2 #10; r2 = loop count
;and r3 r3 x0 ; r3 = data load offset
and r4 r4 x0 ; r4 = current data
and r5 r5 x0 ; r5 = sum

loop ldb r4 r0 #0 	
	add r5 r5 r4
	
	add r0 r0 #1
	add r2 r2 #-1
	brp loop

stw r5 r1 #0

halt
data .fill xC000
tostore .fill xC014 ; Working Code
;tostore .fill x0000 ; Protected Access Violation
;tostore .fill xC017 ; Unaligned Access
.end
