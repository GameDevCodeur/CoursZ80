
  RELEASE_DSK   = 1      
  RELEASE_TAPE  = 0
  RELEASE_SNAP  = 0 
  
  IF RELEASE_SNAP
      SNASET CPC_TYPE, 2    ; Selection mode Amstrad CPC 6128
      BANKSET 0             ; Active la memoire centrale (64 Ko)
      BUILDSNA              ; Directive generer SNA
  ENDIF

  IF RELEASE_DSK
      SAVE 'game.bin', BEGINCODE, ENDCODE-BEGINCODE, DSK, 'DSK/gdc.dsk'
  ENDIF
  
  IF RELEASE_TAPE
       SAVE 'game.bin', BEGINCODE, ENDCODE-BEGINCODE, TAPE,'gdc.cdt'
  ENDIF
  