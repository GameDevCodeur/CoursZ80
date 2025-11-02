
  ;------------------------------------------------------------
  ; PPI
  ;------------------------------------------------------------
  
  PPI_PORTA        EQU #F400     ; PORTA  
  PSG_CLAVIER      EQU %1110
  
  PPI_PORTC        EQU #F600     ; PORTC Validation.
    
  PPI_DATA_WRITE   EQU %100000
  PPI_MOTOR_ON     EQU %10000  
  
  ;PPI_BUS_DIR     BIT  7
  ;PPI_BUS_CTRL1   Bit   6
  PSG_VALIDATION   EQU %00000000 
  PSG_READ_DATA    EQU %01000000
  PSG_WRITE_DATA   EQU %10000000 
  PSG_SELECT_REG   EQU %11000000
    
  PPI_CTRL         EQU #F700     ; Ctrl PORTC Modification bit a bit.
  PPI_PORTS_ASK    EQU %10000000 ; Selection  PORTS IN, OUT, MODE.    
  PPI_PORTA_IN     EQU %10010 
  PPI_PORTA_OUT    EQU %10 
    
  PPI_PORTB        EQU #F500     ; PORTB ISP
  
  PPI_TAPEDATAREAD EQU %10000000
  PPI_PRINTERBUSY  EQU %1000000
  PPI_SIGNALEXP    EQU %100000
  PPI_50HZ         EQU %10000 
    
  PPI_ISP          EQU %000 
  PPI_TRIUMPH      EQU %001 
  PPI_SAISHO       EQU %010
  PPI_SOLAVOX      EQU %011
  PPI_AWA          EQU %100
  PPI_SCHNEIDER    EQU %101
  PPI_ORION        EQU %110
  PPI_AMSTRAD      EQU %111
  
  KEY_BUFFER       EQU #0040        ; BUFFER 0040
  
  KEY_RIGHT        EQU #FD40        ; BUFFER 0040 MASK FD  
  KEY_RIGHT_OCT    EQU KEY_BUFFER   ; BUFFER 0040
  KEY_RIGHT_VAL    EQU #FD
  KEY_RIGHT_BIT    EQU 1
  KEY_RIGHT_AND    EQU %10
  
  KEY_LEFT         EQU #FE41        ; BUFFER 0041 MASK FE
  KEY_LEFT_OCT     EQU KEY_BUFFER+1 ; BUFFER 0041
  KEY_LEFT_VAL     EQU #FE
  KEY_LEFT_BIT     EQU 0
  KEY_LEFT_AND     EQU %1
  
  KEY_UP           EQU #FE40        ; BUFFER 0040 MASK FE
  KEY_UP_OCT       EQU KEY_BUFFER   ; BUFFER 0040
  KEY_UP_VAL       EQU #FE
  KEY_UP_BIT       EQU 0
  KEY_UP_AND       EQU %1
  
  KEY_DOWN         EQU #FB40        ; BUFFER 0040 MASK FB
  KEY_DOWN_OCT     EQU KEY_BUFFER   ; BUFFER 0040
  KEY_DOWN_VAL     EQU #FB
  KEY_DOWN_BIT     EQU 2
  KEY_DOWN_AND     EQU %100
   
  KEY_SPACE        EQU #7F45        ; BUFFER 0045 MASK 7F
  KEY_SPACE_OCT    EQU KEY_BUFFER+5 ; BUFFER 0045
  KEY_SPACE_VAL    EQU #7F
  KEY_SPACE_BIT    EQU 7
  KEY_SPACE_AND    EQU %10000000
  
  KEY_R            EQU #FB46        ; BUFFER 0046 MASK FB
  KEY_R_OCT        EQU KEY_BUFFER+6 ; BUFFER 0046
  KEY_R_VAL        EQU #FB
  KEY_R_BIT        EQU 2
  KEY_R_AND        EQU %100
  
  KEY_ESC          EQU #FB48        ; BUFFER 0048 MASK FB
  KEY_ESC_OCT      EQU KEY_BUFFER+8 ; BUFFER 0048
  KEY_ESC_VAL      EQU #FB
  KEY_ESC_BIT      EQU 2
  KEY_ESC_AND      EQU %100
  