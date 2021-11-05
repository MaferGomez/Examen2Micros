#include "p16F887.inc"   ; TODO INSERT CONFIG CODE HERE USING CONFIG BITS GENERATOR
 	__CONFIG	_CONFIG1,	_INTRC_OSC_NOCLKOUT & _WDT_OFF & _PWRTE_OFF & _MCLRE_ON & _CP_OFF & _CPD_OFF & _BOR_OFF & _IESO_ON & _FCMEN_ON & _LVP_OFF 
 	__CONFIG	_CONFIG2,	_BOR40V & _WRT_OFF

RES_VECT  CODE    0x0000            ; processor reset vector
    BCF PORTA,0		;reset
    MOVLW 0x01
    MOVWF PORTB
    
    BSF PORTA,1		;exec
    CALL time
    BCF PORTA,1
    CALL time
    
    GOTO    START                   ; go to beginning of program

MAIN_PROG CODE                      ; let linker place main program
i   EQU 0x20
j   EQU 0x21

l   equ 0x30
n   equ 0x31
k   equ 0x32
m   equ 0x33

P1  equ 0x42
P2  equ 0x43
P3  equ 0x44
P4  equ 0x45
P5  equ 0x46
P6  equ 0x47
P7  equ 0x48
P8  equ 0x49
  
V1  equ 0x34
V2  equ 0x35
V3  equ 0x36
V4  equ 0x37
V5  equ 0x38
V6  equ 0x39
V7  equ 0x40
V8  equ 0x41

bin equ 0x22
aux equ 0x23
carry equ 0x24
band equ 0x25
val equ 0x26
d   equ 0x27 
 
START

    BANKSEL PORTA ;
    CLRF PORTA ;Init PORTA
    BANKSEL ANSEL ;
    CLRF ANSEL ;digital I/O
    CLRF ANSELH
    BCF STATUS,RP1 ;0
    BSF STATUS,RP0 ;1
    BANKSEL TRISA ;
    CLRF TRISA
    BANKSEL TRISB ;
    CLRF TRISB
    BANKSEL TRISC
    CLRF TRISC
    BANKSEL TRISD
    MOVLW b'00001111'
    MOVWF TRISD
    BCF STATUS,RP0
    CLRF PORTA
    CLRF PORTB
    CLRF PORTC
    CLRF PORTD
    CLRF PORTE
    
    CLRF carry
      

INITLCD
    BCF PORTA,0		;reset
    MOVLW 0x01
    MOVWF PORTB
    
    
    BSF PORTA,1		;exec
    CALL time
    BCF PORTA,1
    CALL time
    
    MOVLW 0x0C		;first line
    MOVWF PORTB
    
    BSF PORTA,1		;exec
    CALL time
    BCF PORTA,1
    CALL time
         
    MOVLW 0x3C		;cursor mode
    MOVWF PORTB
    
    BSF PORTA,1		;exec
    CALL time
    BCF PORTA,1
    CALL time
   
    BCF val,0
    MOVLW 0xD4		;LCD
    MOVWF d
    
INICIO	 
    CALL Nombre
    CALL tiempo
    CALL Limpiar
    CALL LETRAS
    CALL REG
    CALL VALIDAR
    GOTO INICIO

Nombre
    BCF PORTA,0		;command mode
    CALL time
    
    MOVLW 0xC2		;LCD position
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		;data mode
    CALL time
    
    MOVLW 'M'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'a'
    MOVWF PORTB
    CALL exec
   
    MOVLW 'r'
    MOVWF PORTB
    CALL exec

    MOVLW 'i'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'a'
    MOVWF PORTB
    CALL exec

    MOVLW ' '
    MOVWF PORTB
    CALL exec
    
    MOVLW 'F'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'e'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'r'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'n'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'a'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'n'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'd'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'a'
    MOVWF PORTB
    CALL exec
    
    BCF PORTA,0		;command mode
    CALL time
    
    MOVLW 0x92		;LCD position
    MOVWF PORTB
    CALL exec
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    BSF PORTA,0		;data mode
    CALL time
    
    MOVLW 'G'
    MOVWF PORTB
    CALL exec 

    MOVLW 'o'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'm'
    MOVWF PORTB
    CALL exec

    MOVLW 'e'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'z'
    MOVWF PORTB
    CALL exec
    
    MOVLW ' '
    MOVWF PORTB
    CALL exec 

    MOVLW 'G'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'a'
    MOVWF PORTB
    CALL exec

    MOVLW 'r'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'c'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'i'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'a'
    MOVWF PORTB
    CALL exec
    RETURN
TECLADO:
    BCF band,0
    ;ENCENDER 1
    BSF PORTC,0
	;CHECAR A
    BTFSC PORTD,0
    CALL F1 
	;CHECAR B
    BTFSC PORTD,1
    CALL F4
	;CHECAR C
    BTFSC PORTD,2
    CALL F7
	;CHECAR D
    BTFSC PORTD,3
    CALL FAST
    BCF PORTC,0
    ;ENCENDER 2
    BSF PORTC,1
	;CHECAR A
    BTFSC PORTD,0
    CALL F2
	;CHECAR B
    BTFSC PORTD,1
    CALL F5
	;CHECAR C
    BTFSC PORTD,2
    CALL F8
	;CHECAR D
    BTFSC PORTD,3
    CALL F0
    BCF PORTC,1
    ;ENCENDER 3
    BSF PORTC,2
	;CHECAR A
    BTFSC PORTD,0
    CALL F3
	;CHECAR B
    BTFSC PORTD,1
    CALL F6
	;CHECAR C
    BTFSC PORTD,2
    CALL F9
    BCF PORTC,2
    RETURN
    
VALIDAR:
   
    MOVFW V1
    MOVFW P1 
    XORLW aux
    BTFSS aux,0
    BTFSC aux,0
    BSF val,0 ;Contraseñas diferentes
    
    MOVFW V2
    MOVFW P2
    XORLW aux
    BTFSS aux,0
    BTFSC aux,0
    BSF val,0 ;Contraseñas diferentes
   
    MOVFW V3
    MOVFW P3
    XORLW aux
    BTFSS aux,0
    BTFSC aux,0
    BSF val,0 ;Contraseñas diferentes
    
    MOVFW V4
    MOVFW P4
    XORLW aux
    BTFSS aux,0
    BTFSC aux,0
    BSF val,0 ;Contraseñas diferentes
    
    MOVFW V5
    MOVFW P5
    XORLW aux
    BTFSS aux,0
    BTFSC aux,0
    BSF val,0 ;Contraseñas diferentes
    
    MOVFW V6
    MOVFW P6
    XORLW aux
    BTFSS aux,0
    BTFSC aux,0
    BSF val,0 ;Contraseñas diferentes
    
    MOVFW V7
    MOVFW P7
    XORLW aux
    BTFSS aux,0
    BTFSC aux,0
    BSF val,0 ;Contraseñas diferentes
    
    MOVFW V8
    MOVFW P8
    XORLW aux
    BTFSS aux,0
    BTFSC aux,0
    BSF val,0 ;Contraseñas diferentes
    
    BTFSS val,0
    BTFSC val,0
    CALL LCDI ;Contraseñas diferentes
    BTFSS val,0
    CALL LCDC ;Contraseñas correctas
    return
    
LCDI:
    BCF PORTA,0		;reset
    MOVLW 0x01
    MOVWF PORTB
    
    
    BSF PORTA,1		;exec
    CALL time
    BCF PORTA,1
    CALL time
    
    MOVLW 0x0C		;first line
    MOVWF PORTB
    
    BSF PORTA,1		;exec
    CALL time
    BCF PORTA,1
    CALL time
         
    MOVLW 0x3C		;cursor mode
    MOVWF PORTB
    
    BSF PORTA,1		;exec
    CALL time
    BCF PORTA,1
    CALL time
    
    BCF PORTA,0		;command mode
    CALL time
    
    MOVLW 0xC3		;LCD position
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		;data mode
    CALL time
    
    MOVLW 'A'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'C'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'C'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'E'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'S'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'O'
    MOVWF PORTB
    CALL exec
      
    BCF PORTA,0		;command mode
    CALL time
    
    MOVLW 0x93		;LCD position
    MOVWF PORTB
    CALL exec
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    BSF PORTA,0		;data mode
    CALL time
    
    MOVLW 'D'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'E'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'N'
    MOVWF PORTB
    CALL exec
   
    MOVLW 'E'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'G'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'A'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'D'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'O'
    MOVWF PORTB
    CALL exec
      
    MOVLW ' '
    MOVWF PORTB
    CALL exec
    
    MOVLW 'X'
    MOVWF PORTB
    CALL exec
    
    MOVLW '('
    MOVWF PORTB
    CALL exec
    GOTO $

LCDC:
    BCF PORTA,0		;reset
    MOVLW 0x01
    MOVWF PORTB
    
    
    BSF PORTA,1		;exec
    CALL time
    BCF PORTA,1
    CALL time
    
    MOVLW 0x0C		;first line
    MOVWF PORTB
    
    BSF PORTA,1		;exec
    CALL time
    BCF PORTA,1
    CALL time
         
    MOVLW 0x3C		;cursor mode
    MOVWF PORTB
    
    BSF PORTA,1		;exec
    CALL time
    BCF PORTA,1
    CALL time
    
    BCF PORTA,0		;command mode
    CALL time
    
    MOVLW 0x82		;LCD position
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		;data mode
    CALL time
    
    MOVLW '*'
    MOVWF PORTB
    CALL exec
    
    MOVLW '*'
    MOVWF PORTB
    CALL exec
    
    MOVLW '*'
    MOVWF PORTB
    CALL exec
    
    MOVLW '*'
    MOVWF PORTB
    CALL exec
    
    MOVLW '*'
    MOVWF PORTB
    CALL exec
    
    MOVLW '*'
    MOVWF PORTB
    CALL exec
    
    MOVLW '*'
    MOVWF PORTB
    CALL exec
    
    MOVLW '*'
    MOVWF PORTB
    CALL exec
    
    MOVLW '*'
    MOVWF PORTB
    CALL exec
    
    MOVLW '*'
    MOVWF PORTB
    CALL exec
    
    MOVLW '*'
    MOVWF PORTB
    CALL exec
    
    MOVLW '*'
    MOVWF PORTB
    CALL exec
      
    ;;;;;;;;;;;;;;;;;;;;;;;
    BCF PORTA,0		;command mode
    CALL time
    
    MOVLW 0xC2		;LCD position
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		;data mode
    CALL time
    
    MOVLW '*'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'B'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'I'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'E'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'N'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'V'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'E'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'N'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'I'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'D'
    MOVWF PORTB
    CALL exec
    
    MOVLW '@'
    MOVWF PORTB
    CALL exec
    
    MOVLW '*'
    MOVWF PORTB
    CALL exec
      
    BCF PORTA,0		;command mode
    CALL time
    
    MOVLW 0x92		;LCD position
    MOVWF PORTB
    CALL exec
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    BSF PORTA,0		;data mode
    CALL time
    
    MOVLW '*'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'A'
    MOVWF PORTB
    CALL exec
   
    MOVLW 'L'
    MOVWF PORTB
    CALL exec
    
    MOVLW ' '
    MOVWF PORTB
    CALL exec
    
    MOVLW 'S'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'I'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'S'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'T'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'E'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'M'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'A'
    MOVWF PORTB
    CALL exec
    
    MOVLW '*'
    MOVWF PORTB
    CALL exec
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    BCF PORTA,0		;command mode
    CALL time
    
    MOVLW 0xD2		;LCD position
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		;data mode
    CALL time
    
    MOVLW '*'
    MOVWF PORTB
    CALL exec
    
    MOVLW '*'
    MOVWF PORTB
    CALL exec
    
    MOVLW '*'
    MOVWF PORTB
    CALL exec
    
    MOVLW '*'
    MOVWF PORTB
    CALL exec
    
    MOVLW '*'
    MOVWF PORTB
    CALL exec
    
    MOVLW '*'
    MOVWF PORTB
    CALL exec
    
    MOVLW '*'
    MOVWF PORTB
    CALL exec
    
    MOVLW '*'
    MOVWF PORTB
    CALL exec
    
    MOVLW '*'
    MOVWF PORTB
    CALL exec
    
    MOVLW '*'
    MOVWF PORTB
    CALL exec
    
    MOVLW '*'
    MOVWF PORTB
    CALL exec
    
    MOVLW '*'
    MOVWF PORTB
    CALL exec
      
    GOTO $

F1:
    MOVLW b'00000001'
    MOVWF aux
    
    MOVLW '1'
    MOVWF PORTB
    CALL exec
    
    BSF band, 0
    BTFSC PORTD, 0
    GOTO $-1
   
    RETURN  
    
F2:
   MOVLW b'00000010'
    MOVWF aux
    
    MOVLW '2'
    MOVWF PORTB
    CALL exec
    
    BSF band, 0
    
    BTFSC PORTD, 0
    GOTO $-1
    RETURN 

F3:
   MOVLW b'00000011'
    MOVWF aux
    
    MOVLW '3'
    MOVWF PORTB
    CALL exec
    
    BSF band, 0
    
    BTFSC PORTD, 0
    GOTO $-1
    RETURN 
    
F4:
   MOVLW b'00000100'
    MOVWF aux
    
    MOVLW '4'
    MOVWF PORTB
    CALL exec
    
    BSF band, 0
    
    BTFSC PORTD, 1
    GOTO $-1
    RETURN 
    
F5:
   MOVLW b'00000101'
    MOVWF aux
    
    MOVLW '5'
    MOVWF PORTB
    CALL exec
    
    BSF band, 0
    
    BTFSC PORTD, 1
    GOTO $-1
    RETURN 
    
F6:
   MOVLW b'00000110'
    MOVWF aux
    
    MOVLW '6'
    MOVWF PORTB
    CALL exec
    
    BSF band, 0
    
    BTFSC PORTD, 1
    GOTO $-1
    RETURN 
    
F7:
   MOVLW b'00000111'
    MOVWF aux
    
    MOVLW '7'
    MOVWF PORTB
    CALL exec
    
    BSF band, 0
    
    BTFSC PORTD, 2
    GOTO $-1
    RETURN 
    
F8:
   MOVLW b'00001000'
    MOVWF aux
    
    MOVLW '8'
    MOVWF PORTB
    CALL exec
    
    BSF band, 0
    
    BTFSC PORTD, 2
    GOTO $-1
    RETURN 
    
F9:
   MOVLW b'00001001'
    MOVWF aux
    
    MOVLW '9'
    MOVWF PORTB
    CALL exec
    
    BSF band, 0
    
    BTFSC PORTD, 2
    GOTO $-1
    RETURN 
    
F0:
    MOVLW b'00000000'
    MOVWF aux
    
    MOVLW '0'
    MOVWF PORTB
    CALL exec
    
    BSF band, 0
    
    BTFSC PORTD, 3
    GOTO $-1
    RETURN
    
FAST:
    BCF PORTA,0		;command mode
    CALL time
    
    
    MOVLW 0xD3		;LCD position
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		;data mode
    CALL time
    RETURN

       
REG:
    CALL TECLADO
    BTFSS band,0
    GOTO $-2
    MOVFW aux
    MOVWF V1
    CALL NB
    
    CALL TECLADO
    BTFSS band,0
    GOTO $-2
    MOVFW aux
    MOVWF V2
    CALL NB
    
    CALL TECLADO
    BTFSS band,0
    GOTO $-2
    MOVFW aux
    MOVWF V3
    CALL NB
    
    CALL TECLADO
    BTFSS band,0
    GOTO $-2
    MOVFW aux
    MOVWF V4
    CALL NB
    
    CALL TECLADO
    BTFSS band,0
    GOTO $-2
    MOVFW aux
    MOVWF V5
    CALL NB
    
    CALL TECLADO
    BTFSS band,0
    GOTO $-2
    MOVFW aux
    MOVWF V6
    CALL NB
    
    CALL TECLADO
    BTFSS band,0
    GOTO $-2
    MOVFW aux
    MOVWF V7
    CALL NB
    
    CALL TECLADO
    BTFSS band,0
    GOTO $-2
    MOVFW aux
    MOVWF V8
    CALL NB
    
    CALL TECLADO
    BTFSS band,0
    GOTO $-2
    MOVFW aux
    MOVWF P1
    BCF PORTA,0		;command mode
    CALL time
    DECF d,0
    MOVWF PORTB
    MOVWF d
    CALL exec
    BSF PORTA,0		;data mode
    CALL time
    CALL AST
    BCF PORTA,0		;command mode
    CALL time
    MOVLW 0xD4	;LCD position
    MOVWF PORTB
    MOVWF d
    CALL exec
    BSF PORTA,0		;data mode
    CALL NB
    
    CALL TECLADO
    BTFSS band,0
    GOTO $-2
    MOVFW aux
    MOVWF P2
    BCF PORTA,0		;command mode
    CALL time
    MOVLW 0xD4
    MOVWF PORTB
    CALL exec
    BSF PORTA,0		;data mode
    CALL time
    CALL AST
    BCF PORTA,0		;command mode
    CALL time
    MOVLW 0xD5	;LCD position
    MOVWF PORTB
    MOVWF d
    CALL exec
    BSF PORTA,0		;data mode
    CALL NB
    
    CALL TECLADO
    BTFSS band,0
    GOTO $-2
    MOVFW aux
    MOVWF P3
    BCF PORTA,0		;command mode
    CALL time
    MOVLW 0xD5
    MOVWF PORTB
    MOVWF d
    CALL exec
    BSF PORTA,0		;data mode
    CALL time
    CALL AST
    BCF PORTA,0		;command mode
    CALL time
    MOVLW 0xD6		;LCD position
    MOVWF PORTB
    MOVWF d
    CALL exec
    BSF PORTA,0		;data mode
    CALL NB
    
    CALL TECLADO
    BTFSS band,0
    GOTO $-2
    MOVFW aux
    MOVWF P4
    BCF PORTA,0		;command mode
    CALL time
    MOVLW 0xD6
    MOVWF PORTB
    MOVWF d
    CALL exec
    BSF PORTA,0		;data mode
    CALL time
    CALL AST
    BCF PORTA,0		;command mode
    CALL time
    MOVLW 0xD7		;LCD position
    MOVWF PORTB
    MOVWF d
    CALL exec
    BSF PORTA,0		;data mode
    CALL NB
    
    CALL TECLADO
    BTFSS band,0
    GOTO $-2
    MOVFW aux
    MOVWF P5
    BCF PORTA,0		;command mode
    CALL time
    MOVLW 0xD7
    MOVWF PORTB
    MOVWF d
    CALL exec
    BSF PORTA,0		;data mode
    CALL time
    CALL AST
    BCF PORTA,0		;command mode
    CALL time
    MOVLW 0xD8		;LCD position
    MOVWF PORTB
    MOVWF d
    CALL exec
    BSF PORTA,0		;data mode
    CALL NB
    
    CALL TECLADO
    BTFSS band,0
    GOTO $-2
    MOVFW aux
    MOVWF P6
     BCF PORTA,0		;command mode
    CALL time
    MOVLW 0xD8
    MOVWF PORTB
    MOVWF d
    CALL exec
    BSF PORTA,0		;data mode
    CALL time
    CALL AST
    BCF PORTA,0		;command mode
    CALL time
    MOVLW 0xD9		;LCD position
    MOVWF PORTB
    MOVWF d
    CALL exec
    BSF PORTA,0		;data mode
    CALL NB
    
    CALL TECLADO
    BTFSS band,0
    GOTO $-2
    MOVFW aux
    MOVWF P7
    BCF PORTA,0		;command mode
    CALL time
    MOVLW 0xD9
    MOVWF PORTB
    MOVWF d
    CALL exec
    BSF PORTA,0		;data mode
    CALL time
    CALL AST
    BCF PORTA,0		;command mode
    CALL time
    MOVLW 0xDA		;LCD position
    MOVWF PORTB
    MOVWF d
    CALL exec
    BSF PORTA,0		;data mode
    CALL NB
    
    CALL TECLADO
    BTFSS band,0
    GOTO $-2
    MOVFW aux
    MOVWF P8
    BCF PORTA,0		;command mode
    CALL time
    MOVLW 0xDA
    MOVWF PORTB
    MOVWF d
    CALL exec
    BSF PORTA,0		;data mode
    CALL time
    CALL AST
    BCF PORTA,0		;command mode
    CALL time
    MOVLW 0xDB		;LCD position
    MOVWF PORTB
    MOVWF d
    CALL exec
    BSF PORTA,0		;data mode
    CALL NB
    return
NB:
    BTFSS aux,0
    RLF bin,0
    RLF bin,1
    return
AST
    MOVLW '*'
     MOVWF PORTB
     CALL exec
    return
LETRAS 
    BCF PORTA,0		;command mode
    CALL time
    
    MOVLW 0x83		;LCD position
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		;data mode
    CALL time
    
    MOVLW '*'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'P'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'A'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'S'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'S'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'W'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'O'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'R'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'D'
    MOVWF PORTB
    CALL exec
    
    MOVLW '*'
    MOVWF PORTB
    CALL exec
  
    BCF PORTA,0		;command mode
    CALL time
    
    MOVLW 0x91		;LCD position
    MOVWF PORTB
    CALL exec
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    BSF PORTA,0		;data mode
    CALL time
    
    MOVLW 'V'
    MOVWF PORTB
    CALL exec
   
    MOVLW 'A'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'L'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'I'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'D'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'A'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'R'
    MOVWF PORTB
    CALL exec
    
    MOVLW ':'
    MOVWF PORTB
    CALL exec
    BCF PORTA,0		;command mode
    CALL time
    
    MOVLW 0xC3		;LCD position
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		;data mode
    CALL time
    return
    
			
exec

    BSF PORTA,1		;exec
    CALL time
    BCF PORTA,1
    CALL time
    RETURN
    
time
    CLRF i
    MOVLW d'10'
    MOVWF j
ciclo    
    MOVLW d'80'
    MOVWF i
    DECFSZ i
    GOTO $-1
    DECFSZ j
    GOTO ciclo
    RETURN
    
tiempo

    movlw d'142' ;establecer valor de la variable k
    movwf m
mloop:
    nop
    nop
    nop
    nop
    
    decfsz m,f
    goto mloop
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    movlw d'56' ;establecer valor de la variable i
    movwf i
iloop:
    nop
    nop
    nop
    movlw d'61' ;establecer valor de la variable j
    movwf j
jloop:
   nop
   nop 
   nop
   nop
   nop
   nop
   nop
   nop
   nop
    movlw d'58' ;establecer valor de la variable k
    movwf k
kloop:
    nop
    decfsz k,f
    goto kloop
    decfsz j,f
    goto jloop
    decfsz i,f
    goto iloop
    return
    
Limpiar
    BCF PORTA,0		;reset
    MOVLW 0x01
    MOVWF PORTB
    
    BSF PORTA,1		;exec
    CALL time
    BCF PORTA,1
    CALL time
    
    MOVLW 0x0C		;first line
    MOVWF PORTB
    
    BSF PORTA,1		;exec
    CALL time
    BCF PORTA,1
    CALL time
    
    MOVLW 0x3C		;cursor mode
    MOVWF PORTB
    
    BSF PORTA,1		;exec
    CALL time
    BCF PORTA,1
    CALL time
    
    RETURN
			
    END