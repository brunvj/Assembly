

;Filename: MPLAB-X Template.asm															
;Function: Byte Complement Lab
; 									   									
; Author: Vincente Bruno													
; Date: 02/06/2017													
;************************************************************************
		#include <p16f84a.inc>
; ================	EQUATES  =========================================
;  You must put EQUATES at the top of
; program that defines all variable names that you use in your program which are not
; covered by the <p16f84a include file.
TEMP		EQU		0x40		;Just picked any GPR at between 0C hex to 4F hex.  
TEMP2		EQU		0x41		; They may or may not be correct for your program.
COUNT		EQU		0x42		;Feel free to define other variables needed by your program.
CLOCK		EQU		0x43
REG1		EQU		0x44		;First Register
REG2		EQU		0x45		;Second Register
;				
; =======================================================================				

		__CONFIG	0X3FF2		;This is the control bits for CONFIG register
		ORG			0X0000		;RESET or WDT reset vector
		GOTO		START
		
		ORG			0X0004		;Regular INT vector RESERVE THIS SPACE.  DON'T USE IT
		RETFIE

; initialize the Ports and any registers
START	clrw
	
	bsf		STATUS,RP0	;set Bank1 access
	movwf		TRISB		; set PORTB to outputs
	bcf		STATUS,RP0	; set bank0 access
	clrf		TEMP		; clear temp register
	clrf		REG1		; Clear REG1
	clrf		REG2		; Clear REG2
	clrf		PORTB
;Main Program

Main	nop				; main program area for your program
	MOVLW		0xAA		; Moves 0xAA to W
	MOVWF		REG1		; Moves 0xAA to REG1
	COMF		REG1,0		; Compliments value in REG1 and stores in W
	MOVWF		REG2		; Saves value of W to REG2
	MOVWF		PORTB		; Moves value of W to PORTB 
	END

Subroutine				; subroutine area				
	nop
	
	
	return				; return from subroutine
	
	
	END		
		