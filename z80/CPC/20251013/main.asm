   
  ;------------------------------------------------------------
  ; DIRECTIVES RASM
  ;------------------------------------------------------------
  INCLUDE "RASM/rasm.asm"               ; Directives   RASM
    
  ;------------------------------------------------------------
  ; SYSTEMS
  ;------------------------------------------------------------  
  INCLUDE "GAHSG3170/GA_HSG3170.inc"    ; GATEARRAY
  INCLUDE "PPI8255A/PPI_8255A.inc"      ; PPI

  ;------------------------------------------------------------
  ; MACROS
  ;------------------------------------------------------------
  INCLUDE "MACROS/mSetGateArray.asm"    ; Set  Port    GateArray
  INCLUDE "MACROS/mSetPenColor.asm"     ; Set  Couleur Stylo
  INCLUDE "MACROS/mSetBGColor.asm"      ; Set  Couleur Background
  INCLUDE "MACROS/mSetBorderColor.asm"  ; Set  Couleur Border
  INCLUDE "MACROS/mScanKeyBoard.asm"    ; Lire Matrice Clavier
  INCLUDE "MACROS/mKeyPressed.asm"      ; Test Touche  Appuyer
    
  MACRO mMEMCPY_02x08 Src, Des
    LD    HL, {Src}
    LD    DE, {Des}
    CALL  RamToVram_02x08 
  MEND
  
  MACRO mDRAWCELL_02x08 Ink
    CALL  getScreenPtr 
    LD    C, {Ink}
    CALL  drawCell_02x08 
  MEND
   
  ;------------------------------------------------------------
  ; ENTREE PRINCIPALE
  ;------------------------------------------------------------     
  ORG   #100
  RUN   BEGINCODE
  
BEGINCODE 
  ;------------------------------------------------------------
  ; INITIALISATION
  ;------------------------------------------------------------  
  DI  ; OFF interruptions masquables
  
        LD   SP,  BEGINCODE             ; Set  Pile  
        CALL DisableFirmware            ; Im38 Off
        CALL InitialiseCPC              ; Initialise Jeu
       
  EI  ; ON interruptions masquables
  
  ;------------------------------------------------------------
  ; BOUCLE PRINCIPALE
  ;------------------------------------------------------------  
  MAINLOOP: 
        mSCANKEYBOARD (VOID)                ; Lire Matrice Clavier
        mKEYPRESSED KEY_SPACE, RENDER       ; Test Touche  Space
        mKEYPRESSED KEY_R,     RESET        ; Test Touche  R
        mKEYPRESSED KEY_ESC,   ENDMAINLOOP  ; Test Touche  Esc
  JR MAINLOOP
  
  ;------------------------------------------------------------
  ; FONCTIONS
  ;------------------------------------------------------------  
  INCLUDE "SRC/firmWare.asm"      ; Im38       On        Off
  INCLUDE "SRC/scanKeyBoard.asm"  ; Lecture    Matrice   Clavier  
  INCLUDE "SRC/getScreenPtr.asm"  ; Calcul     Adresse   VRAM
  INCLUDE "SRC/nextLine.asm"      ; Ligne      Suivante  VRAM
  INCLUDE "SRC/ramToVram.asm"     ; Copy       RamToVram 02x08
  INCLUDE "SRC/drawCell.asm"      ; Dessine    Cellule   VRAM
  INCLUDE "SRC/gameInit.asm"      ; Initialise Jeu
 
  RESET:        
        mSETGATEARRAY (VOID)            ; Set Port    GateArray  
        mSETBORDERCOLOR INK_BRIGHT_BLUE ; Set Couleur Background
        
        RET
        
  RENDER:  
        mMEMCPY_02x08 Sprite_02x08, #C000 + (00*2) + (00*80)
        
        LD   B, 24                      ; Y 0-24
        LD   C, 39                      ; X 0-39 
        mDRAWCELL_02x08 3               ; Dessine Cellule VRAM
                         
        RET

  ;------------------------------------------------------------
  ; SORTIE ENDMAINLOOP
  ;------------------------------------------------------------      
  ENDMAINLOOP:  
        CALL EnableFirmware             ; Im38 On
        
        RET
        
  ;------------------------------------------------------------
  ; DONNEES GFX / SFX
  ;------------------------------------------------------------
  INCLUDE "GFX/gfx.asm"                 ; Import Graphiques
  
ENDCODE
 
