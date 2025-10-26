   
  ;============================================================
  ;                      DIRECTIVES RASM
  ;------------------------------------------------------------
  INCLUDE "RASM/rasm.asm"               ; Directives   RASM
    
  ;============================================================
  ;                          SYSTEMS
  ;------------------------------------------------------------  
  INCLUDE "GAHSG3170/GA_HSG3170.inc"    ; GATEARRAY
  INCLUDE "PPI8255A/PPI_8255A.inc"      ; PPI

  ;============================================================
  ;                           MACROS
  ;------------------------------------------------------------
  INCLUDE "MACROS/mSetGateArray.asm"    ; Set  Port    GateArray
  INCLUDE "MACROS/mSetPenColor.asm"     ; Set  Couleur Stylo
  INCLUDE "MACROS/mSetBGColor.asm"      ; Set  Couleur Background
  INCLUDE "MACROS/mSetBorderColor.asm"  ; Set  Couleur Border
  INCLUDE "MACROS/mScanKeyBoard.asm"    ; Lire Matrice Clavier
  INCLUDE "MACROS/mKeyPressed.asm"      ; Test Touche  Appuyer
    
  MACRO mMEMCPY_02x08 SRC, DES
    LD    HL, {SRC}
    LD    DE, {DES}
    CALL  ramToVram_02x08 
  MEND
   
  ;============================================================
  ;                     ENTREE PRINCIPALE
  ;------------------------------------------------------------
  ORG   #100
  RUN   BEGINCODE

  ;============================================================
  ;                        CONSTANTES
  ;------------------------------------------------------------   
  POSX        EQU 39
  POSY        EQU 24
  COLORGREEN  EQU 03
  
BEGINCODE

  ;============================================================
  ;                      INITIALISATION
  ;------------------------------------------------------------
  DI  ; OFF interruptions masquables
  
        CALL disableFirmware                ; Im38 Off
        CALL initialiseCPC                  ; Initialise Jeu
       
  EI  ; ON  interruptions masquables
  
  ;============================================================
  ;                    BOUCLE PRINCIPALE
  ;------------------------------------------------------------  
  GAMELOOP: 
        mSCANKEYBOARD (VOID)                ; Lire Matrice Clavier
        mKEYPRESSED KEY_SPACE, RENDER       ; Test Touche  Space
        mKEYPRESSED KEY_R,     RESET        ; Test Touche  R
        mKEYPRESSED KEY_ESC,   ENDGAME      ; Test Touche  Esc
        JR GAMELOOP
  
  ;============================================================
  ; FONCTIONS
  ;------------------------------------------------------------  
  INCLUDE "SRC/firmWare.asm"      ; Im38       On        Off
  INCLUDE "SRC/scanKeyBoard.asm"  ; Lecture    Matrice   Clavier  
  INCLUDE "SRC/getScreenPtr.asm"  ; Calcul     Adresse   VRAM
  INCLUDE "SRC/nextVideoLine.asm" ; Ligne      Suivante  VRAM
  INCLUDE "SRC/ramToVram.asm"     ; Copy       RamToVram 02x08
  INCLUDE "SRC/drawCell.asm"      ; Dessine    Cellule   VRAM
  INCLUDE "SRC/gameInit.asm"      ; Initialise Jeu
        
  RENDER:  
        mMEMCPY_02x08 Sprite_02x08, #C000 + (0*80) + (0*2)
         
        LD   B, POSY                        ; Y 0-24
        LD   C, POSX                        ; X 0-39
        CALL getScreenPtr                   ; DE = adrVram      
        
        LD   C, COLORGREEN
        CALL drawCell_02x08                 ; Dessine Cellule VRAM
                         
        JP GAMELOOP

  RESET:        
        mSETGATEARRAY (VOID)                ; Set Port    GateArray  
        mSETBORDERCOLOR INK_BRIGHT_BLUE     ; Set Couleur Background
        
        JP GAMELOOP       
     
  ENDGAME:
         
        JP enableFirmware                   ; Im38 On
 
      
  ;============================================================
  ;                         DONNEES
  ;============================================================
  
  ;============================================================
  ; VARIABLES
  ;------------------------------------------------------------
  
  ;============================================================
  ; GRAPHIQUES
  ;------------------------------------------------------------
  INCLUDE "GFX/gfx.asm" 
  
ENDCODE
