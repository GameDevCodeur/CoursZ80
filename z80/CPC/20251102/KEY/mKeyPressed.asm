
;===========================================================
;  MACRO : mKeyPressed
;-----------------------------------------------------------
;  Objectif :
;     Vérifie l'etat d'une touche a partir d'une table clavier
;     et appelle une routine si la touche correspond a la valeur
;     attendue (pression detectee).
;
;-----------------------------------------------------------
;  Syntaxe :
;     mKeyPressed Key, Ptr
;
;  Paramètres :
;     Key :  mot 16 bits combinant :
;            - octet bas  (LO(Key)) = adresse table clavier
;            - octet haut (HI(Key)) = valeur de comparaison
;     Ptr :  adresse de la routine a executer si la touche 
;			       correspond a la valeur attendue.
;-----------------------------------------------------------
;  Registres affectés :
;     A, H, L
;-----------------------------------------------------------
;  Flags :
;     Z utilise par CP et CALL Z,
;-----------------------------------------------------------
; AUTEUR  : MAES / GameDevCodeur
; SYSTEME : Amstrad CPC 464 / 6128
; LANGAGE : Assembleur Z80 (compatible RASM)
;
; Total : 10 octets, 38 cycles
;===========================================================

MACRO mKEYPRESSED Key, Ptr
    LD L, LO({Key})      ; L ← octet bas → adresse a tester
    LD H, 0              ; H ← 0 (on forme HL = 00xx)
    LD A, (HL)           ; A ← contenu à l’adresse (HL) = etat touche
    CP HI({Key})         ; Compare A avec octet haut de Key (valeur attendue)
    JP Z, {Ptr}          ; Si egal → touche detectee → appel de la routine Ptr
ENDM

;----------------------------------------------------------
; MACRO: mKEYPRESSED_VAL
;----------------------------------------------------------
; Fonction :
;   Teste si la valeur memoire a une adresse donnee
;   correspond a une valeur specifiee.
;
; Parametres :
;   addr - adresse memoire complete (#xxxx)
;   val  - valeur attendue (8 bits)
;   Ptr  - etiquette de routine a appeler si valeur trouvee
;
; Exemple d utilisation :
;   mKEYPRESSED_ #39, #7F, handleSpace
;
; Code genere :
;   LD HL,addr       ; 3 octets, 10 cycles
;   LD A,(HL)        ; 1 octet,   7 cycles
;   CP val           ; 2 octets,  7 cycles
;   JP Z,Ptr         ; 3 octets, 10 cycles
;                    : 9 octets, 34 cycles
;
; Remarques :
;   - Peut tester n importe quelle adresse memoire
;   - Plus rapide et compact que mKEYPRESSED
;----------------------------------------------------------
MACRO mKEYPRESSED_VAL addr, val, Ptr
    LD HL, {addr}     ; HL ← adresse complete
    LD A, (HL)        ; A ← contenu memoire
    CP {val}          ; Compare avec valeur attendue
    JP Z, {Ptr}       ; Si egal → saut vers routine
ENDM

;----------------------------------------------------------
; MACRO: mKEYPRESSED_BIT
;----------------------------------------------------------
; Fonction :
;   Teste si un bit specifique d une adresse memoire est actif.
;
; Paramètres :
;   addr - adresse memoire (page 0)
;   bit  - numero du bit a tester (0..7)
;   Ptr  - etiquette de routine a appeler si bit = 1
;
; Exemple d’utilisation :
;   mKEYPRESSED_BIT #39, 7, handleSpace
;
; Code genere :
;   LD HL, addr      ; 3 octets, 10 cycles
;   BIT bit,(HL)     ; 2 octets, 12 cycles
;   JP Z, Ptr        ; 3 octets, 10 cycles
; Total              : 8 octets, 32 cycles
;----------------------------------------------------------
MACRO mKEYPRESSED_BIT addr, bit, Ptr
    LD  HL, {addr}       ; HL ← adresse memoire
    BIT {bit}, (HL)      ; teste le bit specifie
    JP  Z, {Ptr}         ; si bit = 0 → saut vers routine
ENDM

;----------------------------------------------------------
; MACRO: mKEYPRESSED_AND
;----------------------------------------------------------
; Fonction :
;   Teste si un bit specifique d une adresse memoire est actif
;   en utilisant l instruction AND.
;
; Parametres :
;   addr - adresse memoire (16 bits)
;   bit  - masque du bit a tester (ex : #80 pour bit 7)
;   Ptr  - etiquette de routine a appeler si bit = 1
;
; Exemple d utilisation :
;   mKEYPRESSED_AND #39, #80, handleSpace  ; test bit 7 de l adresse &39
;
; Code genere :
;   LD  HL, addr        ; 3 octets, 10 cycles
;   LD  A, (HL)         ; 1 octet,   7 cycles
;   AND bit             ; 2 octets,  4 cycles
;   JP  Z, Ptr          ; 3 octets, 10 cycles
; Total                 : 9 octets, 31 cycles
;
; Remarques :
;   - Le masque doit etre passe sous forme d octet (#01, #02, …, #80)
;   - L instruction AND modifie le registre A
;   - JP Z saute si le resultat de l AND est zero, donc logique inverse
;     par rapport a un test BIT classique
;----------------------------------------------------------
MACRO mKEYPRESSED_AND addr, bit, Ptr
    LD  HL, {addr}        ; HL ← adresse memoire
    LD  A, (HL)           ; A ← contenu memoire
    AND {bit}             ; applique le masque
    JP  Z, {Ptr}          ; si resultat = 0 → saut
ENDM
