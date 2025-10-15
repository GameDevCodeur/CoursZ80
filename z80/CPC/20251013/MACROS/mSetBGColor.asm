
;===========================================================
;  MACRO : mSETBGCOLOR
;-----------------------------------------------------------
;  Objectif :
;     Définit la couleur d'arriere-plan (Background / Papier)
;     en modifiant la couleur du stylo de fond (PEN_BG)
;     du Gate Array de l'Amstrad CPC.
;
;-----------------------------------------------------------
;  Syntaxe :
;     mSETBGCOLOR INK
;
;  Parametre :
;     INK : Numero d'encre (0 a 26) a assigner comme couleur
;           d'arriere-plan.
;
;-----------------------------------------------------------
;  Fonctionnement :
;     Le Gate Array du CPC gere 17 stylos :
;        PEN 0-15 : stylos normaux (texte, graphismes)
;        PEN_BG   : stylo de fond (background)
;
;     Cette macro selectionne d'abord le stylo de fond,
;     puis lui assigne la couleur souhaitee.
;
;-----------------------------------------------------------
;  Registres affectes :
;     C  : modifie
;     Autres registres : inchanges
;
;-----------------------------------------------------------
;  Flags :
;     Indefinis
;
;-----------------------------------------------------------
;  Exemples :
;     mSETBGCOLOR 0      Arriere-plan noir
;     mSETBGCOLOR 24     Arriere-plan blanc
;
;-----------------------------------------------------------
;  Dependances :
;     Doivent etre definis ailleurs :
;
;         PENR_CTRL  EQU #40       Base de commande Gate Array
;         INKR_CTRL  EQU #40       Base couleur
;         PEN_BG     EQU 16        Stylo d'arriere-plan (background)
;
;     Sortie via port #7Fxx :
;         OUT (C),C  → envoi au Gate Array
;
;-----------------------------------------------------------
;  Auteur :
;     MAES / ChatGPT (Z80 CPC Tools)
;===========================================================

MACRO mSETBGCOLOR INK
    LD   C, PENR_CTRL+PEN_BG ; Selectionne le stylo de fond (background)
    OUT (C),C                ; Envoie la commande au Gate Array
    LD   C, INKR_CTRL+{INK}  ; Determine la couleur a appliquer
    OUT (C),C                ; Applique l’encre au fond d’écran
ENDM
