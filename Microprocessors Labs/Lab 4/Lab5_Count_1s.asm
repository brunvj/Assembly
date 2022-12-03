

;Filename: MPLAB-X Template.asm															
; Function: 
; 									   									
; Author: Vincente Bruno													
; Date: 03/03/2019													
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
Input		EQU		0x44		; Input register
OneCount	EQU		0x46		; Register that counts number of ones in a byte
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
	movwf		TRISA		; set PORTA to outputs
	bcf		STATUS,RP0	; set bank0 access
	clrf		Input		; clear input register
	clrf		COUNT		; clear count register
	clrf		OneCount	; clear OneCount register

;Main Program

Main	nop				
	MOVLW		d'8'		; Move the decimal value 8 to W register
	MOVWF		COUNT		; Move contents of W to COUNT register
	MOVF		PORTB,0		; Move value of PORT B to W register
	MOVWF		Input		; Move value of W register to input register
Loop					; Loop Label
	RLF		Input,1		; Rotate Left thru carry bit and store in Input register
	BTFSC		STATUS,C	; If Carry bit in Status register is 1, go to next operation.
					; Skip next operation if clear.
	INCF		OneCount,1	; Increment OneCount by 1 and store in W register
	DECFSZ		COUNT,1		; Decrement COUNT by 1 and store back in COUNT 
	goto		Loop		; Go to Line 47:Loop
	clrw
	MOVF		OneCount,0	; Move value of OneCount to W register
	MOVWF		PORTA		; Move value of W to PORTA register
	END
Subroutine				; subroutine area				
	nop
	
	
	return				; return from subroutine
	
	
	END		
		