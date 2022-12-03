;

;Filename: Lab2_BitManip_Mask.asm															
; Function: Bit Manipulation and Masking
; 									   									
; Author: Vincente Bruno													
; Date: 02/20/2019													
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
NUM1		EQU		0x44		; NUM1 Register
NUM2		EQU		0x45		; NUM2 Register
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
	clrf		NUM1		; Clear NUM1 register
	clrf		NUM2		; Clear NUM2 register
	clrf		PORTB		; Clear PORTB register

;Main Program

Main	nop				; main program area for your program
	MOVLW		0xB2		; Move hex value 0xB2 to W
	MOVWF		NUM1		; Move value in W to register NUM1
	COMF		NUM1,1		; Compliment NUM1 and keep value
	BCF		NUM1,7		; Clear bit D7 in NUM1
	BCF		NUM1,6		; Clear bit D6 in NUM1
	BSF		NUM1,0		; Set bit D0 to 1 in NUM1
	BSF		NUM1,1		; Set bit D1 to 1 in NUM1
	BSF		NUM1,2		; Set bit D2 to 1 in NUM1
	MOVF		NUM1,0		; Move value of NUM1 to W
	MOVWF		NUM2		; Move value of W to NUM2 register
	MOVF		NUM2,0		; Move value of NUM2 to W
	MOVWF		PORTB		; Move value of W to PORTB
	END

Subroutine				; subroutine area				
	nop
	
	
	return				; return from subroutine
	
	
	END		
		