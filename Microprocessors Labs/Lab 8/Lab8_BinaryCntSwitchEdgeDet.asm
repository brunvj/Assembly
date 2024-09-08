

;Filename: Lab8_BinaryCntSwitchEdgeDet.asm															
; Function: Binary Counter using Switch Edge Detection.
; 									   									
; Author: Vincente Bruno													
; Date: 04/15/2019													
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
	movlw		d'1'		; move literal 1 to WREG
	movwf		TRISA		; set PORTA to inputs
	bcf		STATUS,RP0	; set bank0 access
	clrf		PORTB		; clear PORTB register
	clrf		TEMP		; clear temp register	

;Main Program

Main	nop
Loop	
	BTFSS		PORTA,0		; (1,2) Check if PA0 is set, if so skip increment
	goto		Loop		; (2) loop around
	INCF		PORTB,1		; (1) Increment PORTB
	
	call		DELAY		; (2) Delay 50ms

Loop0	
	BTFSC		PORTA,0		; (1,2) Check if PA0 is clear, if so skip increment
	goto		Loop0		; (2) loop around
	INCF		PORTB,1		; (1) Increment PORTB
	goto		Main		; (2) go back to main

Subroutine				; subroutine area
DELAY	
	MOVLW		d'0'		; (1) Move value to WREG
	MOVWF		TEMP		; (1) Move value to TEMP
Loop1					; Loop for 250,000 cycles or 5ms 62,500 cycles
	MOVLW		d'0'		; (1) Move value to WREG
	MOVWF		COUNT		; (1) Move value to COUNT
Loop2	DECF		COUNT,1		; (1) Decrement COUNT
	BTFSS		STATUS,Z	; (1,2) Test Z bit in STATUS
	goto		Loop2		; (2) go back to loop2
	DECF		TEMP,1		; (1) Decrement TEMP
	BTFSS		STATUS,Z	; (1,2) Test Z bit in STATUS
	goto		Loop1		; (2) go back to loop1
	RETURN				; (2) Return from Subroutine
	
	END		
		