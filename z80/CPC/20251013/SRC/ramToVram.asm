; ==========================================================
; RamToVram_02x08
; ----------------------------------------------------------
; Copy Block de 2x8 (largeur 2 octets, hauteur 8 octet)
; ----------------------------------------------------------
; Entrée :
;   HL = adresse source 
;   DE = adresse destination VRAM
; Sortie :
;   Carry = 1 si depasse (hauteur)
; Modifie : AF, BC, DE, HL
; ==========================================================
RamToVram_02x08:
    LDI: LDI                 ; Copie 2 octets 
    CALL nLine               ; Ligne suivante
    RET  C                   ; Quitte si depasse (hauteur) 
    DEC  E : DEC E           ; Retour au debut de la ligne
    JR   RamToVram_02x08     ; Continue ligne suivante


