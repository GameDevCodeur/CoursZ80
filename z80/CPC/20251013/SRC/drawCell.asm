
;==============================================================
; drawCell
;--------------------------------------------------------------
; But :
;   Dessine un bloc de 2 octets de large x 8 lignes
;   directement en memoire video (mode 0).
;
; Entrées :
;   HL = Adresse ecran du coin haut-gauche du bloc
;   A  = Couleur
;
; Sorties :
;   HL modifie (pointe apres le bloc)
;
; Registres modifies :
;   A, B
;
; Exemple :
;   LD   HL, #C000        ; debut ecran
;   LD    C, %11111111    ; plein
;   CALL drawCell
;
; Description memoire (mode 0) :
;   ecrit deux octets consecutifs sur 8 lignes,
;   soit un bloc de 16×8 pixels pleins.
;
;--------------------------------------------------------------
; Organisation VRAM (rappel) :
;   Chaque octet = 2 pixels (mode 0)
;   1 ligne ecran = 80 octets
;   Bloc vertical (8 lignes) = +#0800 sur le poids fort (H)
;
;==============================================================

drawCell_02x08:
    LD   B, 8             ; 8 lignes a tracer

.loop:
    LD   (HL), C          ; Octet 1
    INC   HL
    LD   (HL), C          ; Octet 2

    LD   A, H             ; Descendre d'une ligne
    ADD  8                ; (increment bloc 8 lignes)
    LD   H, A

    DEC  L                ; Revenir au debut de la ligne
    DJNZ .loop

    RET
;--------------------------------------------------------------
