
  RELEASE_SNAP  = 1
  RELEASE_DSK   = 1      
  RELEASE_TAPE  = 0  
  
  SNASET CPC_TYPE, 2    ; Selection du mode Amstrad CPC 6128
  
  IF RELEASE_SNAP
      BANKSET 0         ; Active la memoire centrale (64 Ko)
      BUILDSNA          ; Directive pour generer un.SNA
  ENDIF

  IF RELEASE_DSK
        SAVE 'game.bin', #100, END-#100, DSK, 'game.dsk'
  ENDIF
  
  IF RELEASE_TAPE
        SAVE 'game.bin', #100, END-#100, TAPE,'game.cdt'
  ENDIF
  