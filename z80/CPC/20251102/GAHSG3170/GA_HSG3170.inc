 
  ;------------------------------------------------------------
  ; Gate Array
  ;------------------------------------------------------------
  
  GA_PORT    EQU #7F00     ; PORT du Gate Array
  
  PENR_CTRL  EQU %00000000 ; PENR Controle
  INKR_CTRL  EQU %01000000 ; INKR Controle  
  RMR_CTRL   EQU %10000000 ; RMR  Controle
  
  DINT_RS    EQU %10000    ; Diviseur Interruption Reset
    
  ROM_OFF    EQU %1100     ; Connexion ROMS OFF  
  CRS_OFF    EQU %1000     ; Connexion ROM Superieur OFF
  CRI_OFF    EQU %100      ; Connexion ROM Inferieur OFF
  
  MODE_0     EQU %00       ; Mode video 0
  MODE_1     EQU %01       ; Mode video 1
  MODE_2     EQU %10       ; Mode video 2
  MODE_3     EQU %11       ; Mode video 3

  PEN_BG     EQU 0         ; Selection Stylo BackGround
  PEN_1      EQU 1
  PEN_2      EQU 2
  PEN_3      EQU 3
  PEN_4      EQU 4
  PEN_5      EQU 5
  PEN_6      EQU 6
  PEN_7      EQU 7
  PEN_8      EQU 8
  PEN_9      EQU 9
  PEN_10     EQU 10
  PEN_11     EQU 11
  PEN_12     EQU 12
  PEN_13     EQU 13
  PEN_14     EQU 14
  PEN_15     EQU 15
  PEN_BORDER EQU 16        ; Selection Stylo Border 
  
  INK_BLACK           EQU 20 ; 0
  INK_BLEU            EQU 04 ; 1
  INK_BRIGHT_BLUE     EQU 21 ; 2
  INK_RED             EQU 28 ; 3
  INK_MAGENTA         EQU 24 ; 4
  INK_MAUVE           EQU 29 ; 5
  INK_BRIGHT_RED      EQU 12 ; 6
  INK_PURPLE          EQU 05 ; 7
  INK_BRIGHT_MAGENTA  EQU 13 ; 8
  INK_GREEN           EQU 18 ; 9 
  INK_CYAN            EQU 06 ;10
  INK_SKY_BLUE        EQU 23 ;11
  INK_YELLOW          EQU 30 ;12
  INK_WHITE           EQU 00 ;13 
  INK_PASTEL_BLUE     EQU 31 ;14
  INK_ORANGE          EQU 14 ;15
  INK_PINK            EQU 07 ;16
  INK_PASTEL_MAGENTA  EQU 15 ;17 
  INK_BRIGHT_GREEN    EQU 18 ;18
  INK_SEA_GREEN       EQU 02 ;19
  INK_BRIGHT_CYAN     EQU 19 ;20
  INK_LIME_GREEN      EQU 26 ;21
  INK_PASTEL_GREEN    EQU 25 ;22
  INK_PASTEL_CYAN     EQU 27 ;23  
  INK_BRIGHT_YELLOW   EQU 10 ;24
  INK_PASTEL_YELLOW   EQU 03 ;25  
  INK_BRIGHT_WHITE    EQU 11 ;26
  