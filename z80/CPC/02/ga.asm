 
  ;------------------------------------------------------------
  ; Gate Array
  ;---------------------------------------------------------- 
  
  GA_PORT EQU #7F00     ; PORT du Gate Array
  
  RMR_CTR EQU %10000000 ; RMR Controle
  
  DINT_RS EQU %10000    ; Diviseur Interruption Reset
  
  ROM_OFF EQU %1100     ; Connecion ROMS OFF  
  CRS_OFF EQU %1000     ; Connexion ROM Superieur OFF
  CRI_OFF EQU %100      ; Connexion ROM Inferieur OFF
  
  MODE_0  EQU %00       ; Mode video 0
  MODE_1  EQU %01       ; Mode video 1
  MODE_2  EQU %10       ; Mode video 2
  MODE_3  EQU %11       ; Mode video 3