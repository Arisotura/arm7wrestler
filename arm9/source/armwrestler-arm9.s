@ armwrestler.asm
@ mic, 2004-2006 | micol972@gmail.com

@ Runs ARM instructions and checks for valid results. Useful for people developing ARM emulators
@ Assemble with arm-elf-as

.global main
.global forever

.equ VARBASE,	0x2200000
.equ TESTNUM,	(VARBASE+8)
.equ CURSEL,	(VARBASE+16)

.equ MENU, 	10

.equ BAD_Rd,	0x10
.equ BAD_Rn,	0x20

.global main

main:

mov	r0, #0x04000000			@ IME = 0;
add	r0, r0, #0x208
strh	r0, [r0]

ldr 	r0,=0x11340
mov 	r1,#0x4000000
str 	r0,[r1]

@ Turn on both screens
ldr 	r0,=0x830F
ldr 	r1,=0x4000304
str 	r0,[r1]

@ Map vram banks A and B to LCDC
mov 	r0,#0x80
ldr 	r1,=0x4000240
strb 	r0,[r1],#1
strb 	r0,[r1],#1

mov 	r0,#0		
ldr 	r1,=(VARBASE+0x10)
str 	r0,[r1],#-4		@ Menu item selection
str 	r0,[r1],#-4		@ Used in CheckKeys
mov 	r0,#MENU
str 	r0,[r1],#-4		@ The test number
mov 	r0,#2
str 	r0,[r1]

mov 	r10,#0

@ Set VRAM display mode (bank A)
mov 	r0,#0x20000
mov 	r1,#0x4000000
str 	r0,[r1]	

forever:
	swi #0x50000

	ldr r0, =0x2700000
	ldr r1, =0x6800000
	ldr r2, =24576
	copyloop:
		ldr r3, [r0], #4
		str r3, [r1], #4
		subs r2, r2, #1
		bne copyloop
		
	b 	forever




.pool
.align
@.end
