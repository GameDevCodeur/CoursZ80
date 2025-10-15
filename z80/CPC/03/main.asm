    
  ;------------------------------------------------------------
  ; Directives RASM
  ;------------------------------------------------------------
  
  SNASET  CPC_TYPE, 2   ; Selection du mode Amstrad CPC 6128
  BANKSET 0             ; Active la memoire centrale (64 Ko)
  BUILDSNA              ; Directive pour generer un.SNA
  
  RELEASE_DSK   = 0      
  RELEASE_TAPE  = 0
    
  ;------------------------------------------------------------
  ; Gate Array
  ;---------------------------------------------------------- 
  
  INCLUDE "ga.asm"
     
  ;------------------------------------------------------------
  ; Point d'entree principal - Adr #0100
  ;------------------------------------------------------------
  
  ORG   #100
  RUN   #100
  
  LD    BC,GA_PORT+(RMR_CTRL+ROM_OFF+MODE_0) : OUT (C),C ; M0+ROM_OFF
  LD     C,PENR_CTRL+PEN_1      : OUT (C),C
  LD     C,INKR_CTRL+INK_PINK   : OUT (C),C
  LD     C,PENR_CTRL+PEN_11     : OUT (C),C
  LD     C,INKR_CTRL+INK_PASTEL_YELLOW : OUT (C),C
  LD     C,PENR_CTRL+PEN_BG     : OUT (C),C
  LD     C,INKR_CTRL+INK_BLACK  : OUT (C),C
  LD     C,PENR_CTRL+PEN_BORDER : OUT (C),C
  LD     C,INKR_CTRL+INK_BLACK  : OUT (C),C
  
    
  LD     A,%11000010 ; Pixel 1537, 0426 - 1001(GREEN) - 0001(PINK)
  LD    (#C000), A   ;
  
  LD     A,%10001010 ; Pixel Gauche 1537 - 1011 - PASTEL_YELLOW
  LD    (#C800), A   ;  
      
  ;------------------------------------------------------------
  ; Point de sortie principal - retour au basic
  ;------------------------------------------------------------
  
  RET                ;
        
  ;------------------------------------------------------------
  ; Directives RASM creation des fichiers
  ;------------------------------------------------------------
  
  IF RELEASE_DSK
        SAVE 'two.bin', #100, $-#100, DSK, 'two.dsk'
  ENDIF
  
  IF RELEASE_TAPE
        SAVE 'two.bin', #100, $-#100, TAPE,'two.cdt'
  ENDIF
