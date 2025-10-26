
; ============================================================================
;  CPC Firmware Control Library
; ============================================================================
;  Description :
;    Fournit deux routines permettant de desactiver puis de reactiver
;    le firmware de l'Amstrad CPC, en sauvegardant et restaurant le
;    vecteur d'interruption #0038.
;
;  Auteur  : MAES Patrick (GAMEDEVCODEUR)
;  Version : 1.0
;  Date    : 2025-10-05
;  Licence : Libre d'tilisation pour code CPC
; ============================================================================

; ---------------------------------------------------------------------------
;  Fonction : DisableFirmware
; ---------------------------------------------------------------------------
;  Effet :
;    - Sauvegarde le vecteur firmware a l'adresse #0038.
;    - Remplace ce vecteur par "EI / RET" afin de neutraliser
;      les interruptions du firmware (plus d'appels ROM).
;
;  Entrees  : Aucune
;  Sorties  : Aucune
;
;  Registres modifies : HL
;  Flags : inchanges
; ---------------------------------------------------------------------------
DisableFirmware:
        LD HL,(#0038)              ; LIRE VECTEUR FIRMWARE
        LD (BACKUP_FW),HL          ; SAUVEGARDE
        LD HL,#C9FB                ; RET (C9), EI (FB)
        LD (#0038),HL              ; ECRIT FB A #0038, C9 A #0039
        RET

; ---------------------------------------------------------------------------
;  Fonction : EnableFirmware
; ---------------------------------------------------------------------------
;  Effet :
;    - Restaure le vecteur firmware precedemment sauvegarde.
;    - Permet de reactiver le firmware apres une desactivation.
;
;  Entrees  : Aucune
;  Sorties  : Aucune
;
;  Registres modifies : HL
;  Flags : inchanges
; ---------------------------------------------------------------------------
EnableFirmware:
        LD HL,(BACKUP_FW)          ; RECUPERER VECTEUR SAUVEGARDE
        LD (#0038),HL              ; RESTAURER VECTEUR FIRMWARE
        RET

; ---------------------------------------------------------------------------
;  Variable : backup_fw
; ---------------------------------------------------------------------------
;  Description :
;    Contient (2 octets) du vecteur firmware original (#0038/#0039)
;    pour permettre sa restauration ulterieure.
; ---------------------------------------------------------------------------
ALIGN 2
BACKUP_FW: DW 0
