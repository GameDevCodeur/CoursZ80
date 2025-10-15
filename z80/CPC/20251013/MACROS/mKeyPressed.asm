
;===========================================================
;  MACRO : mKeyPressed
;-----------------------------------------------------------
;  Objectif :
;     Vérifie l'état d'une touche à partir d'une table clavier
;     et appelle une routine si la touche correspond à la valeur
;     attendue (pression détectée).
;
;-----------------------------------------------------------
;  Syntaxe :
;     mKeyPressed Key, Ptr
;
;  Paramètres :
;     Key :  mot 16 bits combinant :
;            - octet bas  (LO(Key)) = adresse table clavier
;            - octet haut (HI(Key)) = valeur de comparaison
;     Ptr :  adresse de la routine à exécuter si la touche 
;			 correspond à la valeur attendue.
;
;-----------------------------------------------------------
;  Exemple :
;     Suppose une table clavier en RAM :
;        keyTable: DEFB 0,0,0,0,0,0,0,0
;
;     Appel :
;        mKeyPressed keyTable+1*256 + %11111110, Key_Left
;
;     Interprétation :
;        - Adresse testée : keyTable+1
;        - Valeur attendue : %11111110
;        - Si la valeur lue correspond → CALL Key_Left
;
;-----------------------------------------------------------
;  Registres affectés :
;     A, H, L
;-----------------------------------------------------------
;  Flags :
;     Z utilisé par CP et CALL Z,
;     autres flags non garantis.
;-----------------------------------------------------------
;  Auteur :
;     MAES / ChatGPT (Z80 CPC Tools)
;===========================================================

MACRO mKEYPRESSED Key, Ptr
    LD    L, LO({Key})      ; L ← octet bas → adresse à tester
    LD    H, 0              ; H ← 0 (on forme HL = 00xx)
    LD    A, (HL)           ; A ← contenu à l’adresse (HL) = état touche
    CP    HI({Key})         ; Compare A avec octet haut de Key (valeur attendue)
    CALL  Z, {Ptr}          ; Si égal → touche détectée → appel de la routine Ptr
ENDM
