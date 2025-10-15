
;===========================================================
; ROUTINE : ScanKeyboard
;-----------------------------------------------------------
; OBJET : Lecture matrice clavier (10 lignes × 8 colonnes)
;-----------------------------------------------------------
; ENTREE             : HL = adresse tampon de stockage
; SORTIE             : (HL..HL+9) etat des lignes clavier
; REGISTRES MODIFIES : A, B, C, D, E, HL
; DESTRUCTION        : Tous les registres sauf AF' et IX/IY
; CYCLES APPROX      : 540 cycles 10 lignes (135 us @ 4 MHz)
; TAILLE             : 37 octets
; COMPATIBILITE      : CPC 464 / 664 / 6128
;===========================================================

ScanKeyboard: 
      
;   1. Config PPI - Port A sortie
    ;   LD  BC, PPI_CTRL+PPI_PORTS_ASK+PPI_PORTA_OUT  ; #F782
    ;   OUT (C),C
        
;   2. Selection du registre 14 (clavier)
        LD  BC, PPI_PORTA + PSG_CLAVIER    : LD  E,B  ; #F40E
        OUT (C),C
        LD  BC, PPI_PORTC + PSG_SELECT_REG : LD  D,B  ; #F6C0
        OUT (C),C 
        
;   3. Validation PSG 
        OUT (C),0 
        
;   4. Port A entree
        LD  BC, PPI_CTRL+PPI_PORTS_ASK+PPI_PORTA_IN   ; #F792
        OUT (C),C
        
        ; Premiere ligne du clavier a lire (bit 6 a 1)
        LD  A, PSG_READ_DATA                          ; #40
        LD  C,D       ; C = #F6   
 
  ;-------------------------------------------
  ; BOUCLE DE LECTURE DES 10 LIGNES CLAVIER
  ;-------------------------------------------
   LOOPKEY:   
;   5. Boucle de 10 lectures (INI)     
        LD  B,D       ; B = #F6 (port PSG selection ligne)
        OUT (C),A     ; Selection ligne (ecriture dans PSG)     
        LD  B,E       ; B = #F4
        INI           ; Lecture clavier ? (HL) HL++, B--, C inchange
        INC A         ; Ligne suivante
        INC C         ; Incremente C (#F6 ? ... ? #00 ? boucle)
   
   JR NZ, LOOPKEY
        
;   6. Restauration PPI sortie
        LD  BC, PPI_CTRL+PPI_PORTS_ASK+PPI_PORTA_OUT  ; #F782
        OUT (C),C
        
        RET
        