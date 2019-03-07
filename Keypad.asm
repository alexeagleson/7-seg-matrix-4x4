	list p=18f4550, r=DEC
	#include <p18f4550.inc>

	CONFIG WDT = OFF
	CONFIG LVP = OFF
	CONFIG MCLRE = OFF
	CONFIG FOSC = INTOSCIO_EC
	; CONFIG PBADEN = OFF

	org 0
	cblock 0
	    Delay1:1
	    Delay2:1
	    SegOne:1
	    SegTwo:1
	    SegThree:1
	    SegFour:1
	    SegFive:1
	    SegSix:1
	    SegSeven:1
	    SegEight:1
	    SegNine:1
	    SegDecimal:1
	endc
Start:
	CLRF PORTD
	CLRF TRISD
	
	; Establish LED values for 7-seg display
	MOVLW 96
	MOVWF SegOne
	MOVLW 218
	MOVWF SegTwo
	MOVLW 11110010b
	MOVWF SegThree
	MOVLW 01100110b
	MOVWF SegFour
	MOVLW 10110110b
	MOVWF SegFive
	MOVLW 10111110b
	MOVWF SegSix
	MOVLW 11100000b
	MOVWF SegSeven
	MOVLW 11111110b
	MOVWF SegEight
	MOVLW 11110110b
	MOVWF SegNine
	MOVLW 00000001b
	MOVWF SegDecimal

	; Clear B & C pins
	CLRF TRISB
	CLRF LATB
	CLRF PORTB
	CLRF TRISC
	CLRF LATC
	CLRF PORTC

	; Set pins 0-3 on B to inputs
	BSF TRISB,0
	BSF TRISB,1
	BSF TRISB,2
	BSF TRISB,3
	
	; Set A/D to digital
	BSF ADCON1,0
	BSF ADCON1,1
	BSF ADCON1,2

	 ; Enable pullup resistors on PORTB
	BCF INTCON2,7,0
MainLoop:
    
	; Scan keypad first row
    	BCF LATB,4
	BSF LATB,5
	BSF LATC,6
	BSF LATC,7
    
	BTFSS PORTB,0
	MOVFF SegOne,PORTD
	BTFSS PORTB,1
	MOVFF SegFour,PORTD
	BTFSS PORTB,2
	MOVFF SegSeven,PORTD
	BTFSS PORTB,3
	MOVFF SegDecimal,PORTD
	
	; Scan keypad second row
	BSF LATB,4
	BCF LATB,5
	BSF LATC,6
	BSF LATC,7
    
	BTFSS PORTB,0
	MOVFF SegTwo,PORTD
	BTFSS PORTB,1
	MOVFF SegFive,PORTD
	BTFSS PORTB,2
	MOVFF SegEight,PORTD
	BTFSS PORTB,3
	MOVFF SegDecimal,PORTD
	
	; Scan keypad third row
	BSF LATB,4
	BSF LATB,5
	BCF LATC,6
	BSF LATC,7
    
	BTFSS PORTB,0
	MOVFF SegThree,PORTD
	BTFSS PORTB,1
	MOVFF SegSix,PORTD
	BTFSS PORTB,2
	MOVFF SegNine,PORTD
	BTFSS PORTB,3
	MOVFF SegDecimal,PORTD
		
	GOTO MainLoop
Delay:
	DECFSZ Delay1,1
	GOTO Delay
	DECFSZ Delay2,1
	GOTO Delay
	RETURN
	end
