    
  ;------------------------------------------------------------
  ; Directives RASM
  ;------------------------------------------------------------
  
  RELEASE_SNAP  = 1
  RELEASE_DSK   = 0      
  RELEASE_TAPE  = 0  
  
  SNASET  CPC_TYPE, 2   ; Selection du mode Amstrad CPC 6128
  
  IF RELEASE_SNAP
      BANKSET 0         ; Active la memoire centrale (64 Ko)
      BUILDSNA          ; Directive pour generer un.SNA
  ENDIF
    
  ;------------------------------------------------------------
  ; Gate Array
  ;------------------------------------------------------------  
  INCLUDE "ga.asm"
   
  ;------------------------------------------------------------
  ; Point d'entree principal - Adr #0100
  ;------------------------------------------------------------
  ORG   #100
  RUN   #100
  
  ;------------------------------------------------------------
  ; Initialisation
  ;------------------------------------------------------------ 
  CALL  INIT_GAME
  
  ; TESTS
    
  LD     A,%11000010 ; Px 1537, 0426 - 1001(GREEN) - 0001(PINK)
  LD    (#C000), A   ;
  
  LD     A,%10001010 ; Px Gauche 1537 - 1011 - PASTEL_YELLOW
  LD    (#C800), A   ;  
        
  ;------------------------------------------------------------
  ; Boucle Principale
  ;------------------------------------------------------------  
  LOOP: JR  LOOP
  
  ;------------------------------------------------------------
  ; Point de sortie principal - retour au basic
  ;------------------------------------------------------------
  
  RET
  
  ;------------------------------------------------------------
  ; FONCTIONS
  ;------------------------------------------------------------
  INCLUDE "init_game.asm"
    
  ;------------------------------------------------------------
  ; Directives RASM creation des fichiers
  ;------------------------------------------------------------  
  IF RELEASE_DSK
        SAVE 'game.bin', #100, $-#100, DSK, 'game.dsk'
  ENDIF
  
  IF RELEASE_TAPE
        SAVE 'game.bin', #100, $-#100, TAPE,'game.cdt'
  ENDIF
