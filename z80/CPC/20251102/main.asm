   
  ;============================================================
  ;                      DIRECTIVES RASM
  ;------------------------------------------------------------
  INCLUDE "RASM/rasm.inc"               ; Directives   RASM
    
  ;============================================================
  ;                          SYSTEMS
  ;------------------------------------------------------------  
  INCLUDE "GAHSG3170/GA_HSG3170.inc"    ; Directives   GateArray
  INCLUDE "PPI8255A/PPI_8255A.inc"      ; Directives   PPI

  ;============================================================
  ;                           MACROS
  ;------------------------------------------------------------
  INCLUDE "SYS/mSetGateArray.asm"       ; Set  Port    GateArray
  INCLUDE "SYS/mSetPenColor.asm"        ; Set  Couleur Stylo
  INCLUDE "SYS/mSetBGColor.asm"         ; Set  Couleur BackGround
  INCLUDE "SYS/mSetBorderColor.asm"     ; Set  Couleur Border
  INCLUDE "KEY/mKeyScanClavier.asm"     ; Lire Matrice Clavier
  INCLUDE "KEY/mKeyPressed.asm"         ; Test Touche  Appuyer
  
  ;============================================================
  ; Copie un sprite 2x8 depuis RAM vers VRAM
  ;------------------------------------------------------------
  ; Entrees :
  ;   BC  = coordonnees (B=Y, C=X)
  ;   SPR = adresse du sprite source
  ;------------------------------------------------------------
  MACRO mSPRTOVRAM_02x08 SPR
    CALL  getScreenPtr                  ; HL = adrVram
    EX    HL, DE                        ; DE = adrVram
    LD    HL, {SPR}
    CALL  ramToVram_02x08 
  MEND
  
  ;============================================================
  ; Dessine cellule 2x8 octets en COLOR
  ;------------------------------------------------------------
  MACRO mCELLTOVRAM_02x08 COLOR
    CALL getScreenPtr                   ; HL = adrVram 
    LD   C, {COLOR}                     ; Couleur
    CALL drawCell_02x08                 ; Dessine cellule VRAM
  MEND
 
  ;============================================================
  ; Efface la memoire du CPC  
 ;------------------------------------------------------------
  MACRO  mMEMSET RAM, SIZE, OCTET
    LD   HL,{RAM}                       ; Debut de la memoire
    LD   DE,{RAM}+1                     ; DE = HL + 1
    LD   BC,{SIZE}-1                    ; Nombre octets a copier - 1
    LD   (HL),{OCTET}                   ; Ecrire le premier octet
    LDIR                                ; Copier ce meme octet
  MEND  
  
  ;-------------------------------------------
  ; Macro MOVE_DEC_CELLULE
  ; (pour deplacements vers la gauche ou le haut)
  ;-------------------------------------------
  MACRO mMOVE_DEC_CELLULE name, var
  {name}:
      LD   A, ({var})
      DEC  A
      JP   M, .skip_{name}              ; si negatif, on ignore
      LD   ({var}), A
  .skip_{name}:
      JR   AFFICHAGE_CELLULE
  MEND

  ;-------------------------------------------
  ; Macro MOVE_INC_CELLULE
  ; (pour deplacements vers la droite ou le bas)
  ;-------------------------------------------
  MACRO mMOVE_INC_CELLULE name, var, limite
  {name}:
      LD   A, ({var})
      INC  A
      CP   {limite}
      JR   NC, .skip_{name}             ; si depasse limite, on ignore
      LD   ({var}), A
  .skip_{name}:
      JR   AFFICHAGE_CELLULE
  MEND

  ;============================================================
  ;                     ENTREE PRINCIPALE
  ;============================================================  
  ORG   #100
  RUN   BEGINCODE + 2 + 16
  
  ;============================================================
  ;                       DEBUT DU CODE
  ;============================================================
  BEGINCODE
  
  ;============================================================
  ;                        CONSTANTES
  ;------------------------------------------------------------   
  
  ; Couleurs
  COLORGREEN_CELLULE EQU 03                  ; CELLULE VERTE
  COLORBLEU_CELLULE  EQU 00                  ; CELLULE BLEU
  
  ; Limites
  LIMITEX_SCREEN     EQU 40                  ; LIMITE ECRAN X 
  LIMITEY_SCREEN     EQU 25                  ; LIMITE ECRAN Y
  
  ;============================================================
  ;                         VARIABLES
  ;------------------------------------------------------------
  POSXY_CELLULE:
  POSX_CELLULE       DB 0                    ; 01 OCTET X (0-39)
  POSY_CELLULE       DB 0                    ; 01 OCTET Y (0-24)
  
  ;============================================================
  ;                      DATA GRAPHIQUES
  ;------------------------------------------------------------
  INCLUDE "GFX/gfx.asm"                      ; 16 OCTETS (02x08)
   
  ;============================================================
  ;                      INITIALISATION
  ;------------------------------------------------------------
  DI  ; OFF interruptions masquables
  
        CALL DISABLEFIRMWARE                ; IM38 Off
        CALL INITIALISECPC                  ; Initialise CPC
  
  EI  ; ON  interruptions masquables
  
  INITIALISATION:
       
        ; EFFACE ECRAN
        mMEMSET #C000, #4000, #00           ; Set VRAM  00                    ;         
        ; BORDURE ECRAN EN NOIR     
        mSETGATEARRAY (VOID)                ; Set Port   GateArray  
        mSETBORDERCOLOR INK_BLACK           ; Set Border Noire
       
        ; SET POSIRION CELLULE
        LD   HL, #0B13                      ; H:X=19     L:Y=11
        LD   (POSXY_CELLULE), HL  
        
        ; AFFICHE CELLULE
        JP   AFFICHAGE_CELLULE              ; Affiche    CELLULE
  
  ;============================================================
  ;                    BOUCLE PRINCIPALE
  ;------------------------------------------------------------  
  GAMELOOP:
        
        ; Pause
        LD   B, 65 : .WAIT HALT : DJNZ .WAIT
        
        ; Lire Matrice Clavier             
        mKEYSCANCLAVIER (VOID)
                
        mKEYPRESSED_AND KEY_SPACE_OCT, KEY_SPACE_AND, BORDER_SCREEN
        mKEYPRESSED_AND KEY_R_OCT,     KEY_R_AND,     INITIALISATION
       
        mKEYPRESSED_AND KEY_LEFT_OCT,  KEY_LEFT_AND,  MOVELEFT_CELLULE
        mKEYPRESSED_AND KEY_UP_OCT,    KEY_UP_AND,    MOVEUP_CELLULE
        mKEYPRESSED_AND KEY_RIGHT_OCT, KEY_RIGHT_AND, MOVERIGHT_CELLULE        
        mKEYPRESSED_AND KEY_DOWN_OCT,  KEY_DOWN_AND,  MOVEDOWN_CELLULE
        
        JR   GAMELOOP
  
  ;============================================================
  ;                      FIN DU PROGRAMME
  ;------------------------------------------------------------
  ENDGAME:
           
        JP enableFirmware                   ; IM38 On
          
  ;============================================================
  ;                        FONCTIONS
  ;============================================================
  INCLUDE "SYS/firmWare.asm"      ; IM38     On         Off
  INCLUDE "KEY/KeyscanBoard.asm"  ; Lecture  Matrice    Clavier
  INCLUDE "MEM/ramToVram.asm"     ; Copy     RamToVram  02x08
  
  INCLUDE "SRC/getScreenPtr.asm"  ; Calcul   Adresse    VRAM
  INCLUDE "SRC/nextVideoLine.asm" ; Ligne    Suivante   VRAM
  INCLUDE "SRC/drawCell.asm"      ; Dessine  Cellule    VRAM
  INCLUDE "SRC/initialiseCPC.asm" ; CPC      Initialise

  ;============================================================
  ;                     AFFICHAGE CELLULE
  ;------------------------------------------------------------         
  AFFICHAGE_CELLULE:
  
        ;LD   BC, #1827                      ; B-Y (0-#18) : C-X (0-#27)
        ;mSPRTOVRAM_02x08 Sprite_02x08       ; Dessine le sprite      
        
        LD   BC, (POSXY_CELLULE)
        mCELLTOVRAM_02x08 COLORGREEN_CELLULE ; Ecrit cellule VRAM       
        JP   GAMELOOP
  
  ;============================================================
  ;                 DEPLACEMENTS DIRECTIONNELS
  ;------------------------------------------------------------
  
        mMOVE_DEC_CELLULE MOVEUP_CELLULE,    POSY_CELLULE
        mMOVE_DEC_CELLULE MOVELEFT_CELLULE,  POSX_CELLULE    
        mMOVE_INC_CELLULE MOVEDOWN_CELLULE,  POSY_CELLULE, LIMITEY_SCREEN
        mMOVE_INC_CELLULE MOVERIGHT_CELLULE, POSX_CELLULE, LIMITEX_SCREEN
  
  ;============================================================
  ;                  CHANGE COULEUR BORDURE
  ;------------------------------------------------------------
  BORDER_SCREEN:     
     
        mSETGATEARRAY (VOID)                ; Set Port   GateArray  
        mSETBORDERCOLOR INK_BRIGHT_BLUE     ; Set Border Bleue        
        JP GAMELOOP
   
  ;============================================================
  ;                       FIN DU CODE
  ;============================================================
  ENDCODE
