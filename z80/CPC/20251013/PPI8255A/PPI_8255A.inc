
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
  
  KEY_BUFFER       EQU #0040 
  KEY_ESC          EQU #FB48
  KEY_SPACE        EQU #7F45
  KEY_R            EQU #FB46
  