    
  ;------------------------------------------------------------
  ; DIRECTIVES RASM
  ;------------------------------------------------------------
  INCLUDE "rasm.asm"
    
  ;------------------------------------------------------------
  ; GATE ARRAY
  ;------------------------------------------------------------  
  INCLUDE "GA_HSG3170.asm"
  INCLUDE "PPI8255A/PPI_8255A.asm"

  ;------------------------------------------------------------
  ; MACROS
  ;------------------------------------------------------------  
  MACRO mMEMCPY_02x08 Scr, Des
    LD    HL, {Scr}
    LD    DE, {Des}
    CALL  RAMCPY_02x08 
  MEND
       
  ;------------------------------------------------------------
  ; ENTREE PRINCIPALE
  ;------------------------------------------------------------
  ORG   #100
  RUN   #100
    
  ;------------------------------------------------------------
  ; INITIALISATION
  ;------------------------------------------------------------  
 
  DI                      ; desactive interruptions masquables
  
  CALL  DisableFirmware
  CALL  InitGame
     
  EI                      ; active interruptions masquables
  
  ;------------------------------------------------------------
  ; BOUCLE PRINCIPALE
  ;------------------------------------------------------------  
  
  MAINLOOP: 
        mSCANKEYBOARD (VOID)
        mGETKEY KEY_ESC, END
        mGETKEY KEY_SPACE, CellRender
        mGETKEY KEY_R, GameReset
  JR MAINLOOP
  
  ;------------------------------------------------------------
  ; FONCTIONS
  ;------------------------------------------------------------
  INCLUDE "firmware.asm"
  INCLUDE "init.asm"
  INCLUDE "MEMORY/ramcpy.asm"
  INCLUDE "nextline.asm"
  INCLUDE "PPI8255A/scankeyboard.asm" 
  
  GameReset:
        LD B, HI(GA_PORT)
        GA_mSETBORDERCOLOR INK_BRIGHT_BLUE        
        RET
        
  CellRender:  
        mMEMCPY_02x08 Sprite_02x08, #C000 + (00*2) + (00*80)
        mMEMCPY_02x08 Sprite_02x08, #C000 + (39*2) + (00*80)
        
        mMEMCPY_02x08 Sprite_02x08, #C000 + (00*2) + (24*80)
        mMEMCPY_02x08 Sprite_02x08, #C000 + (39*2) + (24*80)        
        RET
 
  ;------------------------------------------------------------
  ; DONNEES
  ;------------------------------------------------------------  
  INCLUDE "GFX/gfx.asm"

  ;------------------------------------------------------------
  ; SORTIE DU PROGRAMME
  ;------------------------------------------------------------      
  END: RET
