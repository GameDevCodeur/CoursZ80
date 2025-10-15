    
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
  
  include "ga.asm"
    
  ;------------------------------------------------------------
  ; Point d'entree principal - Adr #0100
  ;------------------------------------------------------------
  
  ORG   #100
  RUN   #100
  
  LD    BC, GA_PORT+RMR_CTR+ROM_OFF+MODE_0 : OUT (C),C ; M0+ROM_OFF
    
  LD    A,  %10101010 ;
  LD    (#C000), A    ;
  
  LD    A,  %01010101 ;
  LD    (#C800), A    ;  
      
  ;------------------------------------------------------------
  ; Point de sortie principal - retour au basic
  ;------------------------------------------------------------
  
  RET                 ;
        
  ;------------------------------------------------------------
  ; Directives RASM creation des fichiers
  ;------------------------------------------------------------
  
  IF RELEASE_DSK
        SAVE 'two.bin', #100, $-#100, DSK, 'two.dsk'
  ENDIF
  
  IF RELEASE_TAPE
        SAVE 'two.bin', #100, $-#100, TAPE,'two.cdt'
  ENDIF
