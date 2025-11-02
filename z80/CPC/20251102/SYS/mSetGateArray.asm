
;===========================================================
;  MACRO : mSETGATEARRAY
;-----------------------------------------------------------
;  Objectif :
;     Prépare le registre B avec l’octet haut du port Gate Array
;     (#7Fxx) afin de simplifier les instructions OUT (C),C
;     dans les macros suivantes.
;
;-----------------------------------------------------------
;  Syntaxe :
;     mSETGATEARRAY
;
;  Fonctionnement :
;     Charge le registre B avec la valeur haute du port
;     d’accès au Gate Array (HI(GA_PORT)), généralement #7F.
;
;     Cette initialisation est nécessaire avant toute écriture
;     sur le Gate Array, car les instructions OUT utilisent BC
;     pour spécifier le port :
;
;         OUT (C),C   → envoie la donnée C au port #7Fxx
;
;-----------------------------------------------------------
;  Registres affectés :
;     B : défini à HI(GA_PORT)
;     Autres registres : inchangés
;
;-----------------------------------------------------------
;  Flags :
;     Inchangés
;
;-----------------------------------------------------------
;  Exemples :
;     mSETGATEARRAY
;     mSETPENCOLOR 1, 6
;     mSETBGCOLOR 0
;
;-----------------------------------------------------------
;  Dépendances :
;     Constante suivante requise :
;         GA_PORT  EQU #7F00     ; Port principal du Gate Array
;
;-----------------------------------------------------------
;  Auteur :
;     MAES / ChatGPT (Z80 CPC Tools)
;===========================================================

MACRO mSETGATEARRAY
    LD  B, HI(GA_PORT)       ; B ← partie haute du port (#7F)
ENDM
