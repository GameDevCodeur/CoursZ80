
; ============================================================================
; ROUTINE : DrawSprite_02x08
; ----------------------------------------------------------------------------
; But :
;   Affiche un sprite de 2x8 octets (16x8 pixels) sur l'Ecran CPC
;   par copie directe RAM -> VRAM.
;   Version minimaliste, ultra-rapide, style initial.
;
; Description :
;   - Chaque ligne du sprite = 2 octets
;   - 8 lignes verticales copiees
;   - Descente d'une ligne par ajout de 8 a D
;   - Boucle principale via DEC E / JR
;   - Ne gere pas le passage automatique entre blocs video (#C050)
;
; Entrees :
;   HL = adresse source du sprite (16 octets)
;   DE = adresse destination VRAM (debut du sprite)
;
; Sorties :
;   HL = pointe apres la fin du sprite (avance avec LDI)
;   DE = position VRAM apres la derniere ligne
;
; Registres modifies :
;   AF, DE, HL, BC
;   (E est decremente dans la boucle)
;
; Contraintes :
;   - Largeur fixe : 2 octets (16 pixels)
;   - Hauteur fixe : 8 lignes
;   - Pas de gestion des blocs video
;   - Pas de transparence
;
; Taille  : tres compacte (~10 octets)
; Vitesse : ultra rapide (LDI ×2 / ligne)
; Auteur  : MAES
; Date    : Octobre 2025
; ============================================================================
DrawSprite_02x08:
    LDI                     ; Copie 1er octet du sprite
    LDI                     ; Copie 2e octet du sprite

    LD  A,D
    ADD 8                   ; Descendre d'une ligne
    RET C                   ; Quitter si depassement de D (fin du bloc)    
    LD  D,A   

    DEC E                   ; Revenir au debut de ligne
    DEC E
    JR DrawSprite_02x08     ; Boucle sur la ligne suivante

