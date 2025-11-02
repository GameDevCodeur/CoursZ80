

;===========================================================
;  MACRO : mKeyScanClavier
;-----------------------------------------------------------
;  Objectif :
;     Lance la routine de lecture du clavier (ScanKeyboard)
;     et met a jour la table d'etat des touches en memoire.
;
;-----------------------------------------------------------
;  Syntaxe :
;     mKeyScanClavier
;
;  Fonctionnement :
;     - Initialise HL avec l adresse de la zone memoire où
;       seront stockes les etats des touches.
;     - Appelle la routine ScanKeyboard pour effectuer la
;       lecture complete de la matrice clavier du CPC via
;       le PPI (Programmable Peripheral Interface).
;
;-----------------------------------------------------------
;  Pre-requis :
;     Une zone memoire `KEY_BUFFER` doit exister pour stocker
;     l'etat de chaque ligne du clavier (1 octet par ligne).
;
;     Exemple :	10 octets = 10 lignes de 8 bits
;         KEY_BUFFER:
;             DEFS 10
;
;-----------------------------------------------------------
;  Registres affectes :
;     A, B, C, D, E, H, L
;
;  Flags :
;     Indefinis (utilises par la routine KeyscanBoard)
;
;-----------------------------------------------------------
;  Exemple d utilisation :
;     Met a jour KEY_BUFFER
;     mKEYSCANCLAVIER
;
;     Puis tester une touche :
;     LD   A,(KEY_BUFFER+2)
; Verifie si une touche (colonne 3, ligne 2) est appuyee
;     BIT  3,A
;
;-----------------------------------------------------------
;  Auteur :
;     MAES / ChatGPT (Z80 CPC Tools)
;===========================================================
MACRO mKEYSCANCLAVIER
    LD    HL, KEY_BUFFER     ; HL → adresse du tampon clavier
    CALL  KeyscanBoard       ; Appel de la routine principale de scan
ENDM
