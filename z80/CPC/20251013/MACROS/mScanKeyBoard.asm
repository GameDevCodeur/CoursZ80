

;===========================================================
;  MACRO : mSCANKEYBOARD
;-----------------------------------------------------------
;  Objectif :
;     Lance la routine de lecture du clavier (ScanKeyboard)
;     et met à jour la table d’état des touches en mémoire.
;
;-----------------------------------------------------------
;  Syntaxe :
;     mSCANKEYBOARD
;
;  Fonctionnement :
;     - Initialise HL avec l adresse de la zone mémoire où
;       seront stockés les états des touches.
;     - Appelle la routine ScanKeyboard pour effectuer la
;       lecture complète de la matrice clavier du CPC via
;       le PPI (Programmable Peripheral Interface).
;
;-----------------------------------------------------------
;  Pré-requis :
;     Une zone mémoire `KEY_BUFFER` doit exister pour stocker
;     l’état de chaque ligne du clavier (1 octet par ligne).
;
;     Exemple :	10 octets = 10 lignes de 8 bits
;         KEY_BUFFER:
;             DEFS 10
;
;-----------------------------------------------------------
;  Registres affectés :
;     A, B, C, D, E, H, L
;
;  Flags :
;     Indéfinis (utilisés par la routine ScanKeyboard)
;
;-----------------------------------------------------------
;  Exemple d utilisation :
;     Met à jour KEY_BUFFER
;     mSCANKEYBOARD
;
;     Puis tester une touche :
;     LD   A,(KEY_BUFFER+2)
; Vérifie si une touche (colonne 3, ligne 2) est appuyée
;     BIT  3,A
;
;-----------------------------------------------------------
;  Auteur :
;     MAES / ChatGPT (Z80 CPC Tools)
;===========================================================
MACRO mSCANKEYBOARD
    LD    HL, KEY_BUFFER     ; HL → adresse du tampon clavier
    CALL  ScanKeyboard       ; Appel de la routine principale de scan
ENDM
