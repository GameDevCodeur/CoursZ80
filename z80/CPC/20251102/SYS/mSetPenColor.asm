
;===========================================================
;  MACRO : mSETPENCOLOR
;-----------------------------------------------------------
;  Objectif :
;     Définit la couleur d’un stylo (PEN) du Gate Array du CPC.
;
;-----------------------------------------------------------
;  Syntaxe :
;     mSETPENCOLOR PEN, INK
;
;  Paramètres :
;     PEN : Numéro du stylo (0 à 15)
;     INK : Numéro de l’encre (0 à 26)
;
;  Fonctionnement :
;     Cette macro envoie deux commandes successives au
;     Gate Array via le port #7Fxx :
;        - Sélection du stylo (PEN)
;        - Attribution de la couleur (INK)
;
;-----------------------------------------------------------
;  Registres affectés :
;     C  : modifié
;     Aucun autre registre n’est altéré.
;
;-----------------------------------------------------------
;  Flags :
;     Indéfinis
;
;-----------------------------------------------------------
;  Exemples :
; Stylo 1 = bleu clair
;     GA_mSETPENCOLOR 1, 6
; Stylo papier = blanc
;     GA_mSETPENCOLOR 0, 24
;
;-----------------------------------------------------------
;  Dépendances :
;     Les équates suivantes doivent être définies :
;
; Base pour sélection du stylo
;        PENR_CTRL  EQU #40
; Base pour sélection de l’encre
;        INKR_CTRL  EQU #40
;
;     Port de sortie :
;        Gate Array : OUT (C),C via adresse #7Fxx
;
;-----------------------------------------------------------
;  Auteur :
;     MAES / ChatGPT (Z80 CPC Tools)
;===========================================================
MACRO mSETPENCOLOR PEN,INK
    LD C, PENR_CTRL+{PEN}   ; Sélectionne le stylo (0–15)
    OUT (C),C               ; Envoie la commande au Gate Array
    LD C, INKR_CTRL+{INK}   ; Sélectionne l’encre associée
    OUT (C),C               ; Applique la couleur au stylo
ENDM
