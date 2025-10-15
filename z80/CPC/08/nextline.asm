
;============================================================
; SOUS-ROUTINE : nLine
; -----------------------------------------------------------
; But :
;   Passe a la ligne suivante dans la memoire ecran (mode 0).
;
; Entrées :
;   DE = Adresse courante en VRAM
;
; Sorties :
;   DE mis a jour : D = D + 8
;   Carry = 1 si dapassement de bloc.
;
; Registres modifies :
;   AF, D
;
; Details :
;   Apres 8 lignes, le carry sera leve, changement de bloc.
;   5-25-6us
; ===========================================================
nLine:
    LD   A,D    ; 1-04
    ADD  8      ; 2-07
    LD   D,A    ; 1-04
    RET         ; 1-10           ; Carry eventuellement leve
; ===========================================================