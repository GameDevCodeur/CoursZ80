;===========================================================
;  MACRO : mSETBORDERCOLOR
;-----------------------------------------------------------
;  Objectif :
;     Définit la couleur du bord d’écran (border) du CPC
;     en configurant le stylo dédié du Gate Array.
;
;-----------------------------------------------------------
;  Syntaxe :
;     mSETBORDERCOLOR INK
;
;  Paramètre :
;     INK : Numéro d’encre (0 à 26)
;           Couleur à appliquer au cadre (border) de l’écran.
;
;-----------------------------------------------------------
;  Fonctionnement :
;     Le Gate Array possède un stylo spécial pour le bord
;     d’écran, nommé PEN_BORDER.  
;     Cette macro :
;        1️⃣ sélectionne le stylo border,
;        2️⃣ lui affecte la couleur spécifiée.
;
;-----------------------------------------------------------
;  Registres affectés :
;     C  : modifié
;     Autres registres : inchangés
;
;-----------------------------------------------------------
;  Flags :
;     Indéfinis
;
;-----------------------------------------------------------
;  Exemples :
;     mSETBORDERCOLOR 6       Bord bleu clair
;     mSETBORDERCOLOR 24      Bord blanc
;
;-----------------------------------------------------------
;  Dépendances :
;     Les constantes suivantes doivent être définies :
;
;         PENR_CTRL   EQU #40      Base commande Gate Array
;         INKR_CTRL   EQU #40      Base couleur
;         PEN_BORDER  EQU 17       Stylo du bord d’écran
;
;     Port utilisé :
;         OUT (C),C  → envoi des commandes au Gate Array (#7Fxx)
;
;-----------------------------------------------------------
;  Auteur :
;     MAES / ChatGPT (Z80 CPC Tools)
;===========================================================

MACRO mSETBORDERCOLOR INK
    LD C, PENR_CTRL+PEN_BORDER   ; Sélectionne le stylo du bord
    OUT (C),C                    ; Envoie la commande au Gate Array
    LD C, INKR_CTRL+{INK}        ; Sélectionne la couleur souhaitée
    OUT (C),C                    ; Applique la couleur au border
ENDM
