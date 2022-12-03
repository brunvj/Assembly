

;Filename: MPLAB-X Template.asm															
; Function: Add Two Unsigned Binary Numbers
; 									   									
; Author: Vincente Bruno													
; Date: 02/27/2019													
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
NUM1		EQU		0x44		; NUM1 register
NUM2		EQU		0x45		; NUM2 register
SUM		EQU		0x46		; SUM register
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
	clrf		NUM1		; clear NUM1 register
	clrf		NUM2		; clear NUM2 register
	clrf		SUM		; clear SUM register
	clrf		PORTB		; clear PORTB register
;Main Program

Main	nop
	MOVLW	    d'128'		; Give W register a binary value
	MOVWF	    NUM2		; Move value of W register to NUM2
	MOVF	    PORTA,0		; Move value of PORTA to W
	MOVWF	    NUM1		; Move value of W to NUM1
	ADDWF	    NUM2,0		; Add value of W (NUM1) to NUM2 and store in W
	MOVWF	    SUM			; Move value of W to SUM register
	MOVWF	    PORTB		; Move value of W to PORTB register
	
goto Main				; Remove this line before you place your code

	END

Subroutine				; subroutine area				
	nop
	
	
	return				; return from subroutine
	
	
	END		
		