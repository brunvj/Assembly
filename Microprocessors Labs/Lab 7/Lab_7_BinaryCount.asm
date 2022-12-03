

;Filename: 1 Hz Binary Counter w/ Subroutine Delay.asm															
; Function: Generate an 8-bit binary counter with a delay of 1s between each count
; 									   									
; Author: Vincente Bruno													
; Date: 04/08/2019													
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
COUNT1		EQU		0x44
COUNT2		EQU		0x45
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
	clrf		PORTB

;Main Program

Main	nop
	INCF		PORTB,1		; (1) Increment PORTB until all 8 bits are on.
	CALL		DELAY		; (2) go to DELAY in Subroutine
	goto		Main		; (2) go to main
	
Subroutine				; subroutine area				
DELAY
	MOVLW		d'0'		; (1) Move value to WREG
	MOVWF		COUNT		; (1) Move value from WREG to COUNT
Loop1	
	MOVLW		d'0'		; (1) Move value to WREG
	MOVWF		TEMP		; (1) Move value from WREG to TEMP
Loop2
	nop
	DECFSZ		TEMP,1		; (1,2) Decrease TEMP until zero
	goto		Loop2		; (2) Go back to loop2
	DECFSZ		COUNT,1		; (1,2) Decrement COUNT until zero
	goto		Loop1		; (2) Go back to Loop1
	END
		