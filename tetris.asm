
;Tetris Dissassembly, 8-Jun-96
;
; Known cheats:
;  Down + [Start] at intro screen  -->  Expert Mode
;
; Ram Locations:
;  ffcc = Set to 1 on serial transfer completion
        jp      l020c           ; 0000 c3 0c 02   C..

        .db     0,0,0,0,0       ; 0003 00 00 00 00 00   .....

        jp      l020c           ; 0008 c3 0c 02   C..

        .db     0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh     ; 000b ff ff ff ff ff ff ff ff ff ff ff ff   ............
        .db     0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh     ; 0017 ff ff ff ff ff ff ff ff ff ff ff ff   ............
        .db     0ffh,0ffh,0ffh,0ffh,0ffh        ; 0023 ff ff ff ff ff   .....

        add     a,a             ; 0028 87   .
        pop     hl              ; 0029 e1   a
        ld      e,a             ; 002a 5f   _
        ld      d,0             ; 002b 16 00   ..
        add     hl,de           ; 002d 19   .
        ld      e,(hl)          ; 002e 5e   ^
        inc     hl              ; 002f 23   #
        ld      d,(hl)          ; 0030 56   V
        push    de              ; 0031 d5   U
        pop     hl              ; 0032 e1   a
        jp      (hl)            ; 0033 e9   i

        .db     0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh     ; 0034 ff ff ff ff ff ff ff ff ff ff ff ff   ............

;VBlank IRQ
        jp      l017e           ; 0040 c3 7e 01   C..

        .db     0ffh,0ffh,0ffh,0ffh,0ffh        ; 0043 ff ff ff ff ff   .....

;LCDC Status IRQ (Not Used)
        jp      l26be           ; 0048 c3 be 26   C>&

        .db     0ffh,0ffh,0ffh,0ffh,0ffh        ; 004b ff ff ff ff ff   .....

;Timer Overflow IRQ (Not Used)
        jp      l26be           ; 0050 c3 be 26   C>&

        .db     0ffh,0ffh,0ffh,0ffh,0ffh        ; 0053 ff ff ff ff ff   .....

;Serial Transfer Completion IRQ
        jp      l005b           ; 0058 c3 5b 00   C[.

l005b:  push    af              ; 005b f5   u
        push    hl              ; 005c e5   e
        push    de              ; 005d d5   U
        push    bc              ; 005e c5   E
        call    l006b           ; 005f cd 6b 00   Mk.
        ld      a,1             ; 0062 3e 01   >.
        ldh     (0cch),a        ; 0064 e0 cc   `L
        pop     bc              ; 0066 c1   A
        pop     de              ; 0067 d1   Q
        pop     hl              ; 0068 e1   a
        pop     af              ; 0069 f1   q
        reti                    ; 006a d9   Y

l006b:  ldh     a,(0cdh)        ; 006b f0 cd   pM
        rst     28h             ; 006d ef   o
        .dw     l0078           ; 006e 78 00   x.
        .dw     l009f           ; 0070 9f 00   ..
        .dw     l00a4           ; 0072 a4 00   $.
        .dw     l00ba           ; 0074 ba 00   :.
        .dw     l27ea           ; 0076 ea 27   j'

l0078:  ldh     a,(0e1h)        ; 0078 f0 e1   pa
        cp      7               ; 007a fe 07   ..
        jr      z,l0086         ; 007c 28 08   (.
        cp      6               ; 007e fe 06   ..
        ret     z               ; 0080 c8   H
        ld      a,6             ; 0081 3e 06   >.
        ldh     (0e1h),a        ; 0083 e0 e1   `a
        ret                     ; 0085 c9   I

l0086:  ldh     a,(1)           ; 0086 f0 01   p.
        cp      55h             ; 0088 fe 55   .U
        jr      nz,l0094        ; 008a 20 08    .
        ld      a,29h           ; 008c 3e 29   >)
        ldh     (0cbh),a        ; 008e e0 cb   `K
        ld      a,1             ; 0090 3e 01   >.
        jr      l009c           ; 0092 18 08   ..

l0094:  cp      29h             ; 0094 fe 29   .)
        ret     nz              ; 0096 c0   @
        ld      a,55h           ; 0097 3e 55   >U
        ldh     (0cbh),a        ; 0099 e0 cb   `K
        xor     a               ; 009b af   /
l009c:  ldh     (2),a           ; 009c e0 02   `.
        ret                     ; 009e c9   I

l009f:  ldh     a,(1)           ; 009f f0 01   p.
        ldh     (0d0h),a        ; 00a1 e0 d0   `P
        ret                     ; 00a3 c9   I

l00a4:  ldh     a,(1)           ; 00a4 f0 01   p.
        ldh     (0d0h),a        ; 00a6 e0 d0   `P
        ldh     a,(0cbh)        ; 00a8 f0 cb   pK
        cp      29h             ; 00aa fe 29   .)
        ret     z               ; 00ac c8   H
        ldh     a,(0cfh)        ; 00ad f0 cf   pO
        ldh     (1),a           ; 00af e0 01   `.
        ld      a,0ffh          ; 00b1 3e ff   >.
        ldh     (0cfh),a        ; 00b3 e0 cf   `O
        ld      a,80h           ; 00b5 3e 80   >.
        ldh     (2),a           ; 00b7 e0 02   `.
        ret                     ; 00b9 c9   I

l00ba:  ldh     a,(1)           ; 00ba f0 01   p.
        ldh     (0d0h),a        ; 00bc e0 d0   `P
        ldh     a,(0cbh)        ; 00be f0 cb   pK
        cp      29h             ; 00c0 fe 29   .)
        ret     z               ; 00c2 c8   H
        ldh     a,(0cfh)        ; 00c3 f0 cf   pO
        ldh     (1),a           ; 00c5 e0 01   `.
        ei                      ; 00c7 fb   {
        call    l0a98           ; 00c8 cd 98 0a   M..
        ld      a,80h           ; 00cb 3e 80   >.
        ldh     (2),a           ; 00cd e0 02   `.
        ret                     ; 00cf c9   I

; This routine is not used.
        ldh     a,(0cdh)        ; 00d0 f0 cd   pM
        cp      2               ; 00d2 fe 02   ..
        ret     nz              ; 00d4 c0   @
        xor     a               ; 00d5 af   /
        ldh     (0fh),a         ; 00d6 e0 0f   `.
        ei                      ; 00d8 fb   {
        ret                     ; 00d9 c9   I

        .db     0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh     ; 00da ff ff ff ff ff ff ff ff ff ff ff ff   ............
        .db     0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh     ; 00e6 ff ff ff ff ff ff ff ff ff ff ff ff   ............
        .db     0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh     ; 00f2 ff ff ff ff ff ff ff ff ff ff ff ff   ............
        .db     0ffh,0ffh       ; 00fe ff ff   ..

; Code Begin
        nop                     ; 0100 00   .
        jp      l0150           ; 0101 c3 50 01   CP.

; Nintendo Title Character Area
        .db     0ceh,0edh,66h,66h,0cch,0dh,0,0bh,3,73h,0,83h,0,0ch,0,0dh        ; 0104 ce ed 66 66 cc 0d 00 0b 03 73 00 83 00 0c 00 0d   NmffL....s......
        .db     0,8,11h,1fh,88h,89h,0,0eh,0dch,0cch,6eh,0e6h,0ddh,0ddh,0d9h     ; 0114 00 08 11 1f 88 89 00 0e dc cc 6e e6 dd dd d9   ........\Lnf]]Y
        .db     99h,0bbh,0bbh,67h,63h,6eh,0eh,0ech,0cch,0ddh,0dch,99h,9fh       ; 0123 99 bb bb 67 63 6e 0e ec cc dd dc 99 9f   .;;gcn.lL]\..
        .db     0bbh,0b9h,33h,3eh,54h,45h,54h,52h       ; 0130 bb b9 33 3e 54 45 54 52   ;93>TETR
l0138:  .db     49h,53h,0,0,0,0,0,0,0,0,0,0,0,0,0       ; 0138 49 53 00 00 00 00 00 00 00 00 00 00 00 00 00   IS.............
; Cartridge type
        .db     0               ; 0147 00   .
; Rom Size
        .db     0               ; 0148 00   .
; Ram Size
        .db     0               ; 0149 00   .
; Manufacturer Code
        .dw     100h            ; 014a 00 01   ..
; Version Number
        .db     1               ; 014c 01   .
; Complement Check
        .db     0ah             ; 014d 0a   .
; Checksum
        .dw     0bf16h          ; 014e 16 bf   .?

l0150:  jp      l020c           ; 0150 c3 0c 02   C..

; This routine is not used.
        call    l29e3           ; 0153 cd e3 29   Mc)
l0156:  ldh     a,(41h)         ; 0156 f0 41   pA
        and     3               ; 0158 e6 03   f.
        jr      nz,l0156        ; 015a 20 fa    z
        ld      b,(hl)          ; 015c 46   F
l015d:  ldh     a,(41h)         ; 015d f0 41   pA
        and     3               ; 015f e6 03   f.
        jr      nz,l015d        ; 0161 20 fa    z
        ld      a,(hl)          ; 0163 7e   .
        and     b               ; 0164 a0    
        ret                     ; 0165 c9   I

; Add number in DE to score at (hl).
; Stop counting if score reaches 999999.
l0166:  ld      a,e             ; 0166 7b   {
        add     a,(hl)          ; 0167 86   .
        daa                     ; 0168 27   '
        ldi     (hl),a          ; 0169 22   "
        ld      a,d             ; 016a 7a   z
        adc     a,(hl)          ; 016b 8e   .
        daa                     ; 016c 27   '
        ldi     (hl),a          ; 016d 22   "
        ld      a,0             ; 016e 3e 00   >.
        adc     a,(hl)          ; 0170 8e   .
        daa                     ; 0171 27   '
        ld      (hl),a          ; 0172 77   w
        ld      a,1             ; 0173 3e 01   >.
        ldh     (0e0h),a        ; 0175 e0 e0   ``
        ret     nc              ; 0177 d0   P
        ld      a,99h           ; 0178 3e 99   >.
        ldd     (hl),a          ; 017a 32   2
        ldd     (hl),a          ; 017b 32   2
        ld      (hl),a          ; 017c 77   w
        ret                     ; 017d c9   I

; VBlank Interrupt Routine
l017e:  push    af              ; 017e f5   u
        push    bc              ; 017f c5   E
        push    de              ; 0180 d5   U
        push    hl              ; 0181 e5   e
        ldh     a,(0ceh)        ; 0182 f0 ce   pN
        and     a               ; 0184 a7   '
        jr      z,l0199         ; 0185 28 12   (.
        ldh     a,(0cbh)        ; 0187 f0 cb   pK
        cp      29h             ; 0189 fe 29   .)
        jr      nz,l0199        ; 018b 20 0c    .
        xor     a               ; 018d af   /
        ldh     (0ceh),a        ; 018e e0 ce   `N
; Send byte at ffcf out serial port using internal clock
        ldh     a,(0cfh)        ; 0190 f0 cf   pO
        ldh     (1),a           ; 0192 e0 01   `.
        ld      hl,0ff02h       ; 0194 21 02 ff   !..
        ld      (hl),81h        ; 0197 36 81   6.

l0199:  call    l21e0           ; 0199 cd e0 21   M`!
        call    l23cc           ; 019c cd cc 23   ML#
        call    l23b7           ; 019f cd b7 23   M7#
        call    l239e           ; 01a2 cd 9e 23   M.#
        call    l238c           ; 01a5 cd 8c 23   M.#
        call    l237d           ; 01a8 cd 7d 23   M}#
        call    l236e           ; 01ab cd 6e 23   Mn#
        call    l235f           ; 01ae cd 5f 23   M_#
        call    l2350           ; 01b1 cd 50 23   MP#
        call    l2341           ; 01b4 cd 41 23   MA#
        call    l2332           ; 01b7 cd 32 23   M2#
        call    l2323           ; 01ba cd 23 23   M##
        call    l22f8           ; 01bd cd f8 22   Mx"
        call    l22e9           ; 01c0 cd e9 22   Mi"
        call    l22da           ; 01c3 cd da 22   MZ"
        call    l22cb           ; 01c6 cd cb 22   MK"
        call    l22bc           ; 01c9 cd bc 22   M<"
        call    l22ad           ; 01cc cd ad 22   M-"
        call    l229e           ; 01cf cd 9e 22   M."
        call    l1ed7           ; 01d2 cd d7 1e   MW.
; Initiate DMA transfer
        call    0ffb6h          ; 01d5 cd b6 ff   M6.
        call    l18ca           ; 01d8 cd ca 18   MJ.
        ld      a,(0c0ceh)      ; 01db fa ce c0   zN@
        and     a               ; 01de a7   '
        jr      z,l01fb         ; 01df 28 1a   (.
        ldh     a,(98h)         ; 01e1 f0 98   p.
        cp      3               ; 01e3 fe 03   ..
        jr      nz,l01fb        ; 01e5 20 14    .
        ld      hl,986dh        ; 01e7 21 6d 98   !m.
        call    l243b           ; 01ea cd 3b 24   M;$
        ld      a,1             ; 01ed 3e 01   >.
        ldh     (0e0h),a        ; 01ef e0 e0   ``
        ld      hl,9c6dh        ; 01f1 21 6d 9c   !m.
        call    l243b           ; 01f4 cd 3b 24   M;$
        xor     a               ; 01f7 af   /
        ld      (0c0ceh),a      ; 01f8 ea ce c0   jN@
l01fb:  ld      hl,0ffe2h       ; 01fb 21 e2 ff   !b.
        inc     (hl)            ; 01fe 34   4
        xor     a               ; 01ff af   /
        ldh     (43h),a         ; 0200 e0 43   `C
        ldh     (42h),a         ; 0202 e0 42   `B
        inc     a               ; 0204 3c   <
        ldh     (85h),a         ; 0205 e0 85   `.
        pop     hl              ; 0207 e1   a
        pop     de              ; 0208 d1   Q
        pop     bc              ; 0209 c1   A
        pop     af              ; 020a f1   q
        reti                    ; 020b d9   Y

; Set ram from d000 to dfff to 0
l020c:  xor     a               ; 020c af   /
        ld      hl,0dfffh       ; 020d 21 ff df   !._
        ld      c,10h           ; 0210 0e 10   ..
        ld      b,0             ; 0212 06 00   ..
l0214:  ldd     (hl),a          ; 0214 32   2
        dec     b               ; 0215 05   .
        jr      nz,l0214        ; 0216 20 fc    |
        dec     c               ; 0218 0d   .
        jr      nz,l0214        ; 0219 20 f9    y
; Clear Interrupt Flag & Enable Registers
l021b:  ld      a,1             ; 021b 3e 01   >.
        di                      ; 021d f3   s
        ldh     (0fh),a         ; 021e e0 0f   `.
        ldh     (0ffh),a        ; 0220 e0 ff   `.
; Set scroll regs, LCDC Status, & Serial port to 0
        xor     a               ; 0222 af   /
        ldh     (42h),a         ; 0223 e0 42   `B
        ldh     (43h),a         ; 0225 e0 43   `C
        ldh     (0a4h),a        ; 0227 e0 a4   `$
        ldh     (41h),a         ; 0229 e0 41   `A
        ldh     (1),a           ; 022b e0 01   `.
        ldh     (2),a           ; 022d e0 02   `.
; Set LCD control to Operation
        ld      a,80h           ; 022f 3e 80   >.
        ldh     (40h),a         ; 0231 e0 40   `@
; Loop until LCDC Y-Coord = 148
l0233:  ldh     a,(44h)         ; 0233 f0 44   pD
        cp      94h             ; 0235 fe 94   ..
        jr      nz,l0233        ; 0237 20 fa    z
; Set LCD control to Stop completely
        ld      a,3             ; 0239 3e 03   >.
        ldh     (40h),a         ; 023b e0 40   `@
; Setup colors for Background & Sprites
        ld      a,0e4h          ; 023d 3e e4   >d
        ldh     (47h),a         ; 023f e0 47   `G
        ldh     (48h),a         ; 0241 e0 48   `H
        ld      a,0c4h          ; 0243 3e c4   >D
        ldh     (49h),a         ; 0245 e0 49   `I
; Setup sound channel outputs
        ld      hl,0ff26h       ; 0247 21 26 ff   !&.
        ld      a,80h           ; 024a 3e 80   >.
        ldd     (hl),a          ; 024c 32   2
        ld      a,0ffh          ; 024d 3e ff   >.
        ldd     (hl),a          ; 024f 32   2
        ld      (hl),77h        ; 0250 36 77   6w
; Set Rom bank to zero
; (Not needed since the original has no MBC.)
        ld      a,1             ; 0252 3e 01   >.
        ld      (2000h),a       ; 0254 ea 00 20   j. 
; Initialize stack pointer
        ld      sp,0cfffh       ; 0257 31 ff cf   1.O
; Set ram from df00 to dfff to 0
        xor     a               ; 025a af   /
        ld      hl,0dfffh       ; 025b 21 ff df   !._
        ld      b,0             ; 025e 06 00   ..
l0260:  ldd     (hl),a          ; 0260 32   2
        dec     b               ; 0261 05   .
        jr      nz,l0260        ; 0262 20 fc    |
; Set ram from c000 to cfff to 0
        ld      hl,0cfffh       ; 0264 21 ff cf   !.O
        ld      c,10h           ; 0267 0e 10   ..
        ld      b,0             ; 0269 06 00   ..
l026b:  ldd     (hl),a          ; 026b 32   2
        dec     b               ; 026c 05   .
        jr      nz,l026b        ; 026d 20 fc    |
        dec     c               ; 026f 0d   .
        jr      nz,l026b        ; 0270 20 f9    y
; Set ram from 8000 to 9fff to 0
        ld      hl,9fffh        ; 0272 21 ff 9f   !..
        ld      c,20h           ; 0275 0e 20   . 
        xor     a               ; 0277 af   /
        ld      b,0             ; 0278 06 00   ..
l027a:  ldd     (hl),a          ; 027a 32   2
        dec     b               ; 027b 05   .
        jr      nz,l027a        ; 027c 20 fc    |
        dec     c               ; 027e 0d   .
        jr      nz,l027a        ; 027f 20 f9    y
; Set ram from fe00 to feff to 0
        ld      hl,0feffh       ; 0281 21 ff fe   !..
        ld      b,0             ; 0284 06 00   ..
l0286:  ldd     (hl),a          ; 0286 32   2
        dec     b               ; 0287 05   .
        jr      nz,l0286        ; 0288 20 fc    |
; Set ram from ff7f to fffe to 0
        ld      hl,0fffeh       ; 028a 21 fe ff   !..
        ld      b,80h           ; 028d 06 80   ..
l028f:  ldd     (hl),a          ; 028f 32   2
        dec     b               ; 0290 05   .
        jr      nz,l028f        ; 0291 20 fc    |
; Copy DMA transfer routine to ffb6
        ld      c,0b6h          ; 0293 0e b6   .6
        ld      b,0ch           ; 0295 06 0c   ..
        ld      hl,l2a7f        ; 0297 21 7f 2a   !.*
l029a:  ldi     a,(hl)          ; 029a 2a   *
        ldh     (c),a           ; 029b e2   b
        inc     c               ; 029c 0c   .
        dec     b               ; 029d 05   .
        jr      nz,l029a        ; 029e 20 fa    z
; Fill screen with 2f
        call    l2795           ; 02a0 cd 95 27   M.'
; Reset sound registers
        call    l7ff3           ; 02a3 cd f3 7f   Ms.
; Enable serial i/o & v blank interrupts
        ld      a,9             ; 02a6 3e 09   >.
        ldh     (0ffh),a        ; 02a8 e0 ff   `.

        ld      a,37h           ; 02aa 3e 37   >7
        ldh     (0c0h),a        ; 02ac e0 c0   `@
        ld      a,1ch           ; 02ae 3e 1c   >.
        ldh     (0c1h),a        ; 02b0 e0 c1   `A
; Setup branch point for routine at 2f8
        ld      a,24h           ; 02b2 3e 24   >$
        ldh     (0e1h),a        ; 02b4 e0 e1   `a
; Set LCD control to Operation
        ld      a,80h           ; 02b6 3e 80   >.
        ldh     (40h),a         ; 02b8 e0 40   `@
        ei                      ; 02ba fb   {
        xor     a               ; 02bb af   /
; Clear all interrupt flags
        ldh     (0fh),a         ; 02bc e0 0f   `.
; Set window x & y position to 0
        ldh     (4ah),a         ; 02be e0 4a   `J
        ldh     (4bh),a         ; 02c0 e0 4b   `K
; Set timer modulo to 0
        ldh     (6),a           ; 02c2 e0 06   `.

; Read buttons & return values
l02c4:  call    l29a6           ; 02c4 cd a6 29   M&)
        call    l02f8           ; 02c7 cd f8 02   Mx.
        call    l7ff0           ; 02ca cd f0 7f   Mp.
; If all arrow keys are down at the
; same time, then jump to 21b
        ldh     a,(80h)         ; 02cd f0 80   p.
        and     0fh             ; 02cf e6 0f   f.
        cp      0fh             ; 02d1 fe 0f   ..
        jp      z,l021b         ; 02d3 ca 1b 02   J..

        ld      hl,0ffa6h       ; 02d6 21 a6 ff   !&.
        ld      b,2             ; 02d9 06 02   ..
l02db:  ld      a,(hl)          ; 02db 7e   .
        and     a               ; 02dc a7   '
        jr      z,l02e0         ; 02dd 28 01   (.
        dec     (hl)            ; 02df 35   5
l02e0:  inc     l               ; 02e0 2c   ,
        dec     b               ; 02e1 05   .
        jr      nz,l02db        ; 02e2 20 f7    w

        ldh     a,(0c5h)        ; 02e4 f0 c5   pE
        and     a               ; 02e6 a7   '
        jr      z,l02ed         ; 02e7 28 04   (.
        ld      a,9             ; 02e9 3e 09   >.
        ldh     (0ffh),a        ; 02eb e0 ff   `.

; Wait for a VBlank interrupt to occur
l02ed:  ldh     a,(85h)         ; 02ed f0 85   p.
        and     a               ; 02ef a7   '
        jr      z,l02ed         ; 02f0 28 fb   ({

        xor     a               ; 02f2 af   /
        ldh     (85h),a         ; 02f3 e0 85   `.
        jp      l02c4           ; 02f5 c3 c4 02   CD.

l02f8:  ldh     a,(0e1h)        ; 02f8 f0 e1   pa
        rst     28h             ; 02fa ef   o
        .dw     l1bce           ; 02fb ce 1b   N.
        .dw     l1ce2           ; 02fd e2 1c   b.
        .dw     l1244           ; 02ff 44 12   D.
        .dw     l127b           ; 0301 7b 12   {.
        .dw     l1d06           ; 0303 06 1d   ..
        .dw     l1d26           ; 0305 26 1d   &.
        .dw     l03ae           ; 0307 ae 03   ..
        .dw     l0479           ; 0309 79 04   y.
        .dw     l1444           ; 030b 44 14   D.
        .dw     l148c           ; 030d 8c 14   ..
        .dw     l1a07           ; 030f 07 1a   ..
        .dw     l1dc0           ; 0311 c0 1d   @.
        .dw     l1f16           ; 0313 16 1f   ..
        .dw     l1f1f           ; 0315 1f 1f   ..
        .dw     l1525           ; 0317 25 15   %.
        .dw     l14b0           ; 0319 b0 14   0.
        .dw     l157b           ; 031b 7b 15   {.
        .dw     l15bf           ; 031d bf 15   ?.
        .dw     l1629           ; 031f 29 16   ).
        .dw     l167a           ; 0321 7a 16   z.
        .dw     l16eb           ; 0323 eb 16   k.
        .dw     l1913           ; 0325 13 19   ..
        .dw     l0677           ; 0327 77 06   w.
        .dw     l072c           ; 0329 2c 07   ,.
        .dw     l0825           ; 032b 25 08   %.
        .dw     l08e4           ; 032d e4 08   d.
        .dw     l0b31           ; 032f 31 0b   1.
        .dw     l0ceb           ; 0331 eb 0c   k.
        .dw     l0ad2           ; 0333 d2 0a   R.
        .dw     l0d32           ; 0335 32 0d   2.
        .dw     l0e23           ; 0337 23 0e   #.
        .dw     l1112           ; 0339 12 11   ..
        .dw     l0d99           ; 033b 99 0d   ..
        .dw     l0e8a           ; 033d 8a 0e   ..
        .dw     l1dce           ; 033f ce 1d   N.
        .dw     l1e41           ; 0341 41 1e   A.
        .dw     l0369           ; 0343 69 03   i.
        .dw     l0393           ; 0345 93 03   ..
        .dw     l1167           ; 0347 67 11   g.
        .dw     l11e6           ; 0349 e6 11   f.
        .dw     l11fc           ; 034b fc 11   |.
        .dw     l121c           ; 034d 1c 12   ..
        .dw     l05c7           ; 034f c7 05   G.
        .dw     l05f7           ; 0351 f7 05   w.
        .dw     l12b3           ; 0353 b3 12   3.
        .dw     l1305           ; 0355 05 13   ..
        .dw     l1324           ; 0357 24 13   $.
        .dw     l1351           ; 0359 51 13   Q.
        .dw     l1367           ; 035b 67 13   g.
        .dw     l137e           ; 035d 7e 13   ..
        .dw     l13b5           ; 035f b5 13   5.
        .dw     l13e5           ; 0361 e5 13   e.
        .dw     l131b           ; 0363 1b 13   ..
        .dw     l03a0           ; 0365 a0 03    .
        .dw     l27ea           ; 0367 ea 27   j'

; Display credits screen
l0369:  call    l2820           ; 0369 cd 20 28   M (
        call    l27d7           ; 036c cd d7 27   MW'
        ld      de,l4a07        ; 036f 11 07 4a   ..J
        call    l27eb           ; 0372 cd eb 27   Mk'
        call    l178a           ; 0375 cd 8a 17   M..
        ld      hl,0c300h       ; 0378 21 00 c3   !.C
        ld      de,l6450        ; 037b 11 50 64   .Pd
l037e:  ld      a,(de)          ; 037e 1a   .
        ldi     (hl),a          ; 037f 22   "
        inc     de              ; 0380 13   .
        ld      a,h             ; 0381 7c   |
        cp      0c4h            ; 0382 fe c4   .D
        jr      nz,l037e        ; 0384 20 f8    x
        ld      a,0d3h          ; 0386 3e d3   >S
        ldh     (40h),a         ; 0388 e0 40   `@
; This is responsible for the credit screen ignoring the start
; button for so long. Lower this value to make it respond sooner.
        ld      a,0fah          ; 038a 3e fa   >z
        ldh     (0a6h),a        ; 038c e0 a6   `&
        ld      a,25h           ; 038e 3e 25   >%
        ldh     (0e1h),a        ; 0390 e0 e1   `a
        ret                     ; 0392 c9   I

; Wait for initial credit screen timer to run out.
l0393:  ldh     a,(0a6h)        ; 0393 f0 a6   p&
        and     a               ; 0395 a7   '
        ret     nz              ; 0396 c0   @
        ld      a,0fah          ; 0397 3e fa   >z
        ldh     (0a6h),a        ; 0399 e0 a6   `&
        ld      a,35h           ; 039b 3e 35   >5
        ldh     (0e1h),a        ; 039d e0 e1   `a
        ret                     ; 039f c9   I

; Look for user pressing a button. If not found, continue credit
; screen for another delay period.
l03a0:  ldh     a,(81h)         ; 03a0 f0 81   p.
        and     a               ; 03a2 a7   '
        jr      nz,l03a9        ; 03a3 20 04    .
        ldh     a,(0a6h)        ; 03a5 f0 a6   p&
        and     a               ; 03a7 a7   '
        ret     nz              ; 03a8 c0   @
l03a9:  ld      a,6             ; 03a9 3e 06   >.
        ldh     (0e1h),a        ; 03ab e0 e1   `a
        ret                     ; 03ad c9   I

; Display Intro Select Players Screen
l03ae:  call    l2820           ; 03ae cd 20 28   M (
        xor     a               ; 03b1 af   /
        ldh     (0e9h),a        ; 03b2 e0 e9   `i
        ldh     (98h),a         ; 03b4 e0 98   `.
        ldh     (9ch),a         ; 03b6 e0 9c   `.
        ldh     (9bh),a         ; 03b8 e0 9b   `.
        ldh     (0fbh),a        ; 03ba e0 fb   `{
        ldh     (9fh),a         ; 03bc e0 9f   `.
        ldh     (0e3h),a        ; 03be e0 e3   `c
        ldh     (0c7h),a        ; 03c0 e0 c7   `G
        call    l2293           ; 03c2 cd 93 22   M."
        call    l2651           ; 03c5 cd 51 26   MQ&
        call    l27d7           ; 03c8 cd d7 27   MW'
        ld      hl,0c800h       ; 03cb 21 00 c8   !.H
l03ce:  ld      a,2fh           ; 03ce 3e 2f   >/
        ldi     (hl),a          ; 03d0 22   "
        ld      a,h             ; 03d1 7c   |
        cp      0cch            ; 03d2 fe cc   .L
        jr      nz,l03ce        ; 03d4 20 f8    x

        ld      hl,0c801h       ; 03d6 21 01 c8   !.H
        call    l26a9           ; 03d9 cd a9 26   M)&
        ld      hl,0c80ch       ; 03dc 21 0c c8   !.H
        call    l26a9           ; 03df cd a9 26   M)&
        ld      hl,0ca41h       ; 03e2 21 41 ca   !AJ
        ld      b,0ch           ; 03e5 06 0c   ..
        ld      a,8eh           ; 03e7 3e 8e   >.
l03e9:  ldi     (hl),a          ; 03e9 22   "
        dec     b               ; 03ea 05   .
        jr      nz,l03e9        ; 03eb 20 fc    |
        ld      de,l4b6f        ; 03ed 11 6f 4b   .oK
        call    l27eb           ; 03f0 cd eb 27   Mk'
        call    l178a           ; 03f3 cd 8a 17   M..
        ld      hl,0c000h       ; 03f6 21 00 c0   !.@
        ld      (hl),80h        ; 03f9 36 80   6.
        inc     l               ; 03fb 2c   ,
        ld      (hl),10h        ; 03fc 36 10   6.
        inc     l               ; 03fe 2c   ,
        ld      (hl),58h        ; 03ff 36 58   6X
        ld      a,3             ; 0401 3e 03   >.
        ld      (0dfe8h),a      ; 0403 ea e8 df   jh_
        ld      a,0d3h          ; 0406 3e d3   >S
        ldh     (40h),a         ; 0408 e0 40   `@
        ld      a,7             ; 040a 3e 07   >.
        ldh     (0e1h),a        ; 040c e0 e1   `a
        ld      a,7dh           ; 040e 3e 7d   >}
        ldh     (0a6h),a        ; 0410 e0 a6   `&
        ld      a,4             ; 0412 3e 04   >.
        ldh     (0c6h),a        ; 0414 e0 c6   `F
        ldh     a,(0e4h)        ; 0416 f0 e4   pd
        and     a               ; 0418 a7   '
        ret     nz              ; 0419 c0   @
        ld      a,13h           ; 041a 3e 13   >.
        ldh     (0c6h),a        ; 041c e0 c6   `F
        ret                     ; 041e c9   I

; Start demo mode
l041f:  ld      a,37h           ; 041f 3e 37   >7
        ldh     (0c0h),a        ; 0421 e0 c0   `@
        ld      a,9             ; 0423 3e 09   >.
        ldh     (0c2h),a        ; 0425 e0 c2   `B
        xor     a               ; 0427 af   /
        ldh     (0c5h),a        ; 0428 e0 c5   `E
        ldh     (0b0h),a        ; 042a e0 b0   `0
        ldh     (0edh),a        ; 042c e0 ed   `m
        ldh     (0eah),a        ; 042e e0 ea   `j
        ld      a,62h           ; 0430 3e 62   >b
        ldh     (0ebh),a        ; 0432 e0 eb   `k
        ld      a,0b0h          ; 0434 3e b0   >0
        ldh     (0ech),a        ; 0436 e0 ec   `l
        ldh     a,(0e4h)        ; 0438 f0 e4   pd
        cp      2               ; 043a fe 02   ..
        ld      a,2             ; 043c 3e 02   >.
        jr      nz,l045a        ; 043e 20 1a    .
        ld      a,77h           ; 0440 3e 77   >w
        ldh     (0c0h),a        ; 0442 e0 c0   `@
        ld      a,9             ; 0444 3e 09   >.
        ldh     (0c3h),a        ; 0446 e0 c3   `C
        ld      a,2             ; 0448 3e 02   >.
        ldh     (0c4h),a        ; 044a e0 c4   `D
        ld      a,63h           ; 044c 3e 63   >c
        ldh     (0ebh),a        ; 044e e0 eb   `k
        ld      a,0b0h          ; 0450 3e b0   >0
        ldh     (0ech),a        ; 0452 e0 ec   `l
        ld      a,11h           ; 0454 3e 11   >.
        ldh     (0b0h),a        ; 0456 e0 b0   `0
        ld      a,1             ; 0458 3e 01   >.
l045a:  ldh     (0e4h),a        ; 045a e0 e4   `d
        ld      a,0ah           ; 045c 3e 0a   >.
        ldh     (0e1h),a        ; 045e e0 e1   `a
        call    l2820           ; 0460 cd 20 28   M (
        call    l27ad           ; 0463 cd ad 27   M-'
        ld      de,l4cd7        ; 0466 11 d7 4c   .WL
        call    l27eb           ; 0469 cd eb 27   Mk'
        call    l178a           ; 046c cd 8a 17   M..
        ld      a,0d3h          ; 046f 3e d3   >S
        ldh     (40h),a         ; 0471 e0 40   `@
        ret                     ; 0473 c9   I

; This routine is not used.
        ld      a,0ffh          ; 0474 3e ff   >.
        ldh     (0e9h),a        ; 0476 e0 e9   `i
        ret                     ; 0478 c9   I

l0479:  ldh     a,(0a6h)        ; 0479 f0 a6   p&
        and     a               ; 047b a7   '
        jr      nz,l0488        ; 047c 20 0a    .
        ld      hl,0ffc6h       ; 047e 21 c6 ff   !F.
        dec     (hl)            ; 0481 35   5
        jr      z,l041f         ; 0482 28 9b   (.
        ld      a,7dh           ; 0484 3e 7d   >}
        ldh     (0a6h),a        ; 0486 e0 a6   `&
l0488:  call    l0a98           ; 0488 cd 98 0a   M..
; Send 55h out serial port using external clock.
        ld      a,55h           ; 048b 3e 55   >U
        ldh     (1),a           ; 048d e0 01   `.
        ld      a,80h           ; 048f 3e 80   >.
        ldh     (2),a           ; 0491 e0 02   `.

        ldh     a,(0cch)        ; 0493 f0 cc   pL
        and     a               ; 0495 a7   '
        jr      z,l04a2         ; 0496 28 0a   (.
; Serial Transfer is complete
        ldh     a,(0cbh)        ; 0498 f0 cb   pK
        and     a               ; 049a a7   '
        jr      nz,l04d7        ; 049b 20 3a    :
        xor     a               ; 049d af   /
        ldh     (0cch),a        ; 049e e0 cc   `L
        jr      l0509           ; 04a0 18 67   .g

l04a2:  ldh     a,(81h)         ; 04a2 f0 81   p.
        ld      b,a             ; 04a4 47   G
        ldh     a,(0c5h)        ; 04a5 f0 c5   pE
; Test for Up button
        bit     2,b             ; 04a7 cb 50   KP
        jr      nz,l04f3        ; 04a9 20 48    H
; Test for A button
        bit     4,b             ; 04ab cb 60   K`
        jr      nz,l0502        ; 04ad 20 53    S
; Test for B button
        bit     5,b             ; 04af cb 68   Kh
        jr      nz,l0507        ; 04b1 20 54    T
; Test for Down button
        bit     3,b             ; 04b3 cb 58   KX
        ret     z               ; 04b5 c8   H
        and     a               ; 04b6 a7   '
        ld      a,8             ; 04b7 3e 08   >.
        jr      z,l04e7         ; 04b9 28 2c   (,
        ld      a,b             ; 04bb 78   x
        cp      8               ; 04bc fe 08   ..
        ret     nz              ; 04be c0   @
        ldh     a,(0cbh)        ; 04bf f0 cb   pK
        cp      29h             ; 04c1 fe 29   .)
        jr      z,l04d7         ; 04c3 28 12   (.
; Send 29h out serial port using internal clock.
        ld      a,29h           ; 04c5 3e 29   >)
        ldh     (1),a           ; 04c7 e0 01   `.
        ld      a,81h           ; 04c9 3e 81   >.
        ldh     (2),a           ; 04cb e0 02   `.
l04cd:  ldh     a,(0cch)        ; 04cd f0 cc   pL
        and     a               ; 04cf a7   '
        jr      z,l04cd         ; 04d0 28 fb   ({
        ldh     a,(0cbh)        ; 04d2 f0 cb   pK
        and     a               ; 04d4 a7   '
        jr      z,l0509         ; 04d5 28 32   (2
l04d7:  ld      a,2ah           ; 04d7 3e 2a   >*
l04d9:  ldh     (0e1h),a        ; 04d9 e0 e1   `a
        xor     a               ; 04db af   /
        ldh     (0a6h),a        ; 04dc e0 a6   `&
        ldh     (0c2h),a        ; 04de e0 c2   `B
        ldh     (0c3h),a        ; 04e0 e0 c3   `C
        ldh     (0c4h),a        ; 04e2 e0 c4   `D
        ldh     (0e4h),a        ; 04e4 e0 e4   `d
        ret                     ; 04e6 c9   I

l04e7:  push    af              ; 04e7 f5   u
        ldh     a,(80h)         ; 04e8 f0 80   p.
        bit     7,a             ; 04ea cb 7f   K.
        jr      z,l04f0         ; 04ec 28 02   (.
        ldh     (0f4h),a        ; 04ee e0 f4   `t
l04f0:  pop     af              ; 04f0 f1   q
        jr      l04d9           ; 04f1 18 e6   .f

l04f3:  xor     1               ; 04f3 ee 01   n.
l04f5:  ldh     (0c5h),a        ; 04f5 e0 c5   `E
        and     a               ; 04f7 a7   '
        ld      a,10h           ; 04f8 3e 10   >.
        jr      z,l04fe         ; 04fa 28 02   (.
        ld      a,60h           ; 04fc 3e 60   >`
l04fe:  ld      (0c001h),a      ; 04fe ea 01 c0   j.@
        ret                     ; 0501 c9   I

l0502:  and     a               ; 0502 a7   '
        ret     nz              ; 0503 c0   @
        xor     a               ; 0504 af   /
        jr      l04f3           ; 0505 18 ec   .l

l0507:  and     a               ; 0507 a7   '
        ret     z               ; 0508 c8   H
l0509:  xor     a               ; 0509 af   /
        jr      l04f5           ; 050a 18 e9   .i

l050c:  ldh     a,(0e4h)        ; 050c f0 e4   pd
        and     a               ; 050e a7   '
        ret     z               ; 050f c8   H
        call    l0a98           ; 0510 cd 98 0a   M..
        xor     a               ; 0513 af   /
        ldh     (1),a           ; 0514 e0 01   `.
        ld      a,80h           ; 0516 3e 80   >.
        ldh     (2),a           ; 0518 e0 02   `.
        ldh     a,(81h)         ; 051a f0 81   p.
        bit     3,a             ; 051c cb 5f   K_
        jr      z,l052d         ; 051e 28 0d   (.
        ld      a,33h           ; 0520 3e 33   >3
        ldh     (1),a           ; 0522 e0 01   `.
        ld      a,81h           ; 0524 3e 81   >.
        ldh     (2),a           ; 0526 e0 02   `.
        ld      a,6             ; 0528 3e 06   >.
        ldh     (0e1h),a        ; 052a e0 e1   `a
        ret                     ; 052c c9   I

l052d:  ld      hl,0ffb0h       ; 052d 21 b0 ff   !0.
        ldh     a,(0e4h)        ; 0530 f0 e4   pd
        cp      2               ; 0532 fe 02   ..
        ld      b,10h           ; 0534 06 10   ..
        jr      z,l053a         ; 0536 28 02   (.
        ld      b,1dh           ; 0538 06 1d   ..
l053a:  ld      a,(hl)          ; 053a 7e   .
        cp      b               ; 053b b8   8
        ret     nz              ; 053c c0   @
        ld      a,6             ; 053d 3e 06   >.
        ldh     (0e1h),a        ; 053f e0 e1   `a
        ret                     ; 0541 c9   I

l0542:  ldh     a,(0e4h)        ; 0542 f0 e4   pd
        and     a               ; 0544 a7   '
        ret     z               ; 0545 c8   H
        ldh     a,(0e9h)        ; 0546 f0 e9   pi
        cp      0ffh            ; 0548 fe ff   ..
        ret     z               ; 054a c8   H
        ldh     a,(0eah)        ; 054b f0 ea   pj
        and     a               ; 054d a7   '
        jr      z,l0555         ; 054e 28 05   (.
        dec     a               ; 0550 3d   =
        ldh     (0eah),a        ; 0551 e0 ea   `j
        jr      l0571           ; 0553 18 1c   ..

l0555:  ldh     a,(0ebh)        ; 0555 f0 eb   pk
        ld      h,a             ; 0557 67   g
        ldh     a,(0ech)        ; 0558 f0 ec   pl
        ld      l,a             ; 055a 6f   o
        ldi     a,(hl)          ; 055b 2a   *
        ld      b,a             ; 055c 47   G
        ldh     a,(0edh)        ; 055d f0 ed   pm
        xor     b               ; 055f a8   (
        and     b               ; 0560 a0    
        ldh     (81h),a         ; 0561 e0 81   `.
        ld      a,b             ; 0563 78   x
        ldh     (0edh),a        ; 0564 e0 ed   `m
        ldi     a,(hl)          ; 0566 2a   *
        ldh     (0eah),a        ; 0567 e0 ea   `j
        ld      a,h             ; 0569 7c   |
        ldh     (0ebh),a        ; 056a e0 eb   `k
        ld      a,l             ; 056c 7d   }
        ldh     (0ech),a        ; 056d e0 ec   `l
        jr      l0574           ; 056f 18 03   ..

l0571:  xor     a               ; 0571 af   /
        ldh     (81h),a         ; 0572 e0 81   `.
l0574:  ldh     a,(80h)         ; 0574 f0 80   p.
        ldh     (0eeh),a        ; 0576 e0 ee   `n
        ldh     a,(0edh)        ; 0578 f0 ed   pm
        ldh     (80h),a         ; 057a e0 80   `.
        ret                     ; 057c c9   I

; This routine is not used.
        xor     a               ; 057d af   /
        ldh     (0edh),a        ; 057e e0 ed   `m
        jr      l0571           ; 0580 18 ef   .o

; This instruction is not used.
        ret                     ; 0582 c9   I

l0583:  ldh     a,(0e4h)        ; 0583 f0 e4   pd
        and     a               ; 0585 a7   '
        ret     z               ; 0586 c8   H
        ldh     a,(0e9h)        ; 0587 f0 e9   pi
        cp      0ffh            ; 0589 fe ff   ..
        ret     nz              ; 058b c0   @
        ldh     a,(80h)         ; 058c f0 80   p.
        ld      b,a             ; 058e 47   G
        ldh     a,(0edh)        ; 058f f0 ed   pm
        cp      b               ; 0591 b8   8
        jr      z,l05ad         ; 0592 28 19   (.
        ldh     a,(0ebh)        ; 0594 f0 eb   pk
        ld      h,a             ; 0596 67   g
        ldh     a,(0ech)        ; 0597 f0 ec   pl
        ld      l,a             ; 0599 6f   o
        ldh     a,(0edh)        ; 059a f0 ed   pm
        ldi     (hl),a          ; 059c 22   "
        ldh     a,(0eah)        ; 059d f0 ea   pj
        ldi     (hl),a          ; 059f 22   "
        ld      a,h             ; 05a0 7c   |
        ldh     (0ebh),a        ; 05a1 e0 eb   `k
        ld      a,l             ; 05a3 7d   }
        ldh     (0ech),a        ; 05a4 e0 ec   `l
        ld      a,b             ; 05a6 78   x
        ldh     (0edh),a        ; 05a7 e0 ed   `m
        xor     a               ; 05a9 af   /
        ldh     (0eah),a        ; 05aa e0 ea   `j
        ret                     ; 05ac c9   I

l05ad:  ldh     a,(0eah)        ; 05ad f0 ea   pj
        inc     a               ; 05af 3c   <
        ldh     (0eah),a        ; 05b0 e0 ea   `j
        ret                     ; 05b2 c9   I

l05b3:  ldh     a,(0e4h)        ; 05b3 f0 e4   pd
        and     a               ; 05b5 a7   '
        ret     z               ; 05b6 c8   H
        ldh     a,(0e9h)        ; 05b7 f0 e9   pi
        and     a               ; 05b9 a7   '
        ret     nz              ; 05ba c0   @
        ldh     a,(0eeh)        ; 05bb f0 ee   pn
        ldh     (80h),a         ; 05bd e0 80   `.
        ret                     ; 05bf c9   I

l05c0:  ld      hl,0ff02h       ; 05c0 21 02 ff   !..
        set     7,(hl)          ; 05c3 cb fe   K.
        jr      l05d1           ; 05c5 18 0a   ..

l05c7:  ld      a,3             ; 05c7 3e 03   >.
        ldh     (0cdh),a        ; 05c9 e0 cd   `M
        ldh     a,(0cbh)        ; 05cb f0 cb   pK
        cp      29h             ; 05cd fe 29   .)
        jr      nz,l05c0        ; 05cf 20 ef    o
l05d1:  call    l144f           ; 05d1 cd 4f 14   MO.
        ld      a,80h           ; 05d4 3e 80   >.
        ld      (0c210h),a      ; 05d6 ea 10 c2   j.B
        call    l2671           ; 05d9 cd 71 26   Mq&
        ldh     (0ceh),a        ; 05dc e0 ce   `N
        xor     a               ; 05de af   /
        ldh     (1),a           ; 05df e0 01   `.
        ldh     (0cfh),a        ; 05e1 e0 cf   `O
        ldh     (0dch),a        ; 05e3 e0 dc   `\
        ldh     (0d2h),a        ; 05e5 e0 d2   `R
        ldh     (0d3h),a        ; 05e7 e0 d3   `S
        ldh     (0d4h),a        ; 05e9 e0 d4   `T
        ldh     (0d5h),a        ; 05eb e0 d5   `U
        ldh     (0e3h),a        ; 05ed e0 e3   `c
        call    l7ff3           ; 05ef cd f3 7f   Ms.
        ld      a,2bh           ; 05f2 3e 2b   >+
        ldh     (0e1h),a        ; 05f4 e0 e1   `a
        ret                     ; 05f6 c9   I

l05f7:  ldh     a,(0cbh)        ; 05f7 f0 cb   pK
        cp      29h             ; 05f9 fe 29   .)
        jr      z,l0613         ; 05fb 28 16   (.
        ldh     a,(0f0h)        ; 05fd f0 f0   pp
        and     a               ; 05ff a7   '
        jr      z,l0620         ; 0600 28 1e   (.
        xor     a               ; 0602 af   /
        ldh     (0f0h),a        ; 0603 e0 f0   `p
        ld      de,0c201h       ; 0605 11 01 c2   ..B
        call    l1492           ; 0608 cd 92 14   M..
        call    l1517           ; 060b cd 17 15   M..
        call    l2671           ; 060e cd 71 26   Mq&
        jr      l0620           ; 0611 18 0d   ..

l0613:  ldh     a,(81h)         ; 0613 f0 81   p.
        bit     0,a             ; 0615 cb 47   KG
        jr      nz,l0620        ; 0617 20 07    .
        bit     3,a             ; 0619 cb 5f   K_
        jr      nz,l0620        ; 061b 20 03    .
        call    l14b0           ; 061d cd b0 14   M0.
l0620:  ldh     a,(0cbh)        ; 0620 f0 cb   pK
        cp      29h             ; 0622 fe 29   .)
        jr      z,l0644         ; 0624 28 1e   (.
        ldh     a,(0cch)        ; 0626 f0 cc   pL
        and     a               ; 0628 a7   '
        ret     z               ; 0629 c8   H
        xor     a               ; 062a af   /
        ldh     (0cch),a        ; 062b e0 cc   `L
        ld      a,39h           ; 062d 3e 39   >9
        ldh     (0cfh),a        ; 062f e0 cf   `O
        ldh     a,(0d0h)        ; 0631 f0 d0   pP
        cp      50h             ; 0633 fe 50   .P
        jr      z,l0664         ; 0635 28 2d   (-
        ld      b,a             ; 0637 47   G
        ldh     a,(0c1h)        ; 0638 f0 c1   pA
        cp      b               ; 063a b8   8
        ret     z               ; 063b c8   H
        ld      a,b             ; 063c 78   x
        ldh     (0c1h),a        ; 063d e0 c1   `A
        ld      a,1             ; 063f 3e 01   >.
        ldh     (0f0h),a        ; 0641 e0 f0   `p
        ret                     ; 0643 c9   I

l0644:  ldh     a,(81h)         ; 0644 f0 81   p.
        bit     3,a             ; 0646 cb 5f   K_
        jr      nz,l066c        ; 0648 20 22    "
        bit     0,a             ; 064a cb 47   KG
        jr      nz,l066c        ; 064c 20 1e    .
        ldh     a,(0cch)        ; 064e f0 cc   pL
        and     a               ; 0650 a7   '
        ret     z               ; 0651 c8   H
        xor     a               ; 0652 af   /
        ldh     (0cch),a        ; 0653 e0 cc   `L
        ldh     a,(0cfh)        ; 0655 f0 cf   pO
        cp      50h             ; 0657 fe 50   .P
        jr      z,l0664         ; 0659 28 09   (.
        ldh     a,(0c1h)        ; 065b f0 c1   pA
l065d:  ldh     (0cfh),a        ; 065d e0 cf   `O
        ld      a,1             ; 065f 3e 01   >.
        ldh     (0ceh),a        ; 0661 e0 ce   `N
        ret                     ; 0663 c9   I

l0664:  call    l178a           ; 0664 cd 8a 17   M..
        ld      a,16h           ; 0667 3e 16   >.
        ldh     (0e1h),a        ; 0669 e0 e1   `a
        ret                     ; 066b c9   I

l066c:  ld      a,50h           ; 066c 3e 50   >P
        jr      l065d           ; 066e 18 ed   .m

l0670:  ld      hl,0ff02h       ; 0670 21 02 ff   !..
        set     7,(hl)          ; 0673 cb fe   K.
        jr      l0696           ; 0675 18 1f   ..

; Display Mario VS Luigi screen
l0677:  ld      a,3             ; 0677 3e 03   >.
        ldh     (0cdh),a        ; 0679 e0 cd   `M
        ldh     a,(0cbh)        ; 067b f0 cb   pK
        cp      29h             ; 067d fe 29   .)
        jr      nz,l0670        ; 067f 20 ef    o
        call    l0aa1           ; 0681 cd a1 0a   M!.
        call    l0aa1           ; 0684 cd a1 0a   M!.
        call    l0aa1           ; 0687 cd a1 0a   M!.
        ld      b,0             ; 068a 06 00   ..
        ld      hl,0c300h       ; 068c 21 00 c3   !.C
l068f:  call    l0aa1           ; 068f cd a1 0a   M!.
        ldi     (hl),a          ; 0692 22   "
        dec     b               ; 0693 05   .
        jr      nz,l068f        ; 0694 20 f9    y
l0696:  call    l2820           ; 0696 cd 20 28   M (
        call    l27ad           ; 0699 cd ad 27   M-'
        ld      de,l5214        ; 069c 11 14 52   ..R
        call    l27eb           ; 069f cd eb 27   Mk'
        call    l178a           ; 06a2 cd 8a 17   M..
        ld      a,2fh           ; 06a5 3e 2f   >/
        call    l1fdd           ; 06a7 cd dd 1f   M].
        ld      a,3             ; 06aa 3e 03   >.
        ldh     (0ceh),a        ; 06ac e0 ce   `N
        xor     a               ; 06ae af   /
        ldh     (1),a           ; 06af e0 01   `.
        ldh     (0cfh),a        ; 06b1 e0 cf   `O
        ldh     (0dch),a        ; 06b3 e0 dc   `\
        ldh     (0d2h),a        ; 06b5 e0 d2   `R
        ldh     (0d3h),a        ; 06b7 e0 d3   `S
        ldh     (0d4h),a        ; 06b9 e0 d4   `T
        ldh     (0d5h),a        ; 06bb e0 d5   `U
        ldh     (0e3h),a        ; 06bd e0 e3   `c
        ldh     (0cch),a        ; 06bf e0 cc   `L
        ld      hl,0c400h       ; 06c1 21 00 c4   !.D
        ld      b,0ah           ; 06c4 06 0a   ..
        ld      a,28h           ; 06c6 3e 28   >(
l06c8:  ldi     (hl),a          ; 06c8 22   "
        dec     b               ; 06c9 05   .
        jr      nz,l06c8        ; 06ca 20 fc    |
        ldh     a,(0d6h)        ; 06cc f0 d6   pV
        and     a               ; 06ce a7   '
        jp      nz,l076d        ; 06cf c2 6d 07   Bm.
        call    l1517           ; 06d2 cd 17 15   M..
        ld      a,0d3h          ; 06d5 3e d3   >S
        ldh     (40h),a         ; 06d7 e0 40   `@
        ld      hl,0c080h       ; 06d9 21 80 c0   !.@
        ld      de,l0705        ; 06dc 11 05 07   ...
        ld      b,20h           ; 06df 06 20   . 
        call    l0725           ; 06e1 cd 25 07   M%.
        ld      hl,0c200h       ; 06e4 21 00 c2   !.B
        ld      de,l26ed        ; 06e7 11 ed 26   .m&
        ld      c,2             ; 06ea 0e 02   ..
        call    l1776           ; 06ec cd 76 17   Mv.
        call    l080e           ; 06ef cd 0e 08   M..
        call    l2671           ; 06f2 cd 71 26   Mq&
        xor     a               ; 06f5 af   /
        ldh     (0d7h),a        ; 06f6 e0 d7   `W
        ldh     (0d8h),a        ; 06f8 e0 d8   `X
        ldh     (0d9h),a        ; 06fa e0 d9   `Y
        ldh     (0dah),a        ; 06fc e0 da   `Z
        ldh     (0dbh),a        ; 06fe e0 db   `[
        ld      a,17h           ; 0700 3e 17   >.
        ldh     (0e1h),a        ; 0702 e0 e1   `a
        ret                     ; 0704 c9   I

l0705:  .db     40h,28h,0aeh,0,40h,30h,0aeh,20h,48h,28h,0afh,0,48h      ; 0705 40 28 ae 00 40 30 ae 20 48 28 af 00 48   @(..@0. H(/.H
        .db     30h,0afh,20h,78h,28h,0c0h,0,78h,30h,0c0h,20h,80h,28h,0c1h       ; 0712 30 af 20 78 28 c0 00 78 30 c0 20 80 28 c1   0/ x(@.x0@ .(A
        .db     0,80h,30h,0c1h,20h      ; 0720 00 80 30 c1 20   ..0A 

; Move a block of memory
;  HL = Start Addr
;  DE = End Addr
;  B = Length of data
l0725:  ld      a,(de)          ; 0725 1a   .
        ldi     (hl),a          ; 0726 22   "
        inc     de              ; 0727 13   .
        dec     b               ; 0728 05   .
        jr      nz,l0725        ; 0729 20 fa    z
        ret                     ; 072b c9   I

l072c:  ldh     a,(0cbh)        ; 072c f0 cb   pK
        cp      29h             ; 072e fe 29   .)
        jr      z,l0755         ; 0730 28 23   (#
        ldh     a,(0cch)        ; 0732 f0 cc   pL
        and     a               ; 0734 a7   '
        jr      z,l074a         ; 0735 28 13   (.
        ldh     a,(0d0h)        ; 0737 f0 d0   pP
        cp      60h             ; 0739 fe 60   .`
        jr      z,l076a         ; 073b 28 2d   (-
        cp      6               ; 073d fe 06   ..
        jr      nc,l0743        ; 073f 30 02   0.
        ldh     (0ach),a        ; 0741 e0 ac   `,
l0743:  ldh     a,(0adh)        ; 0743 f0 ad   p-
        ldh     (0cfh),a        ; 0745 e0 cf   `O
        xor     a               ; 0747 af   /
        ldh     (0cch),a        ; 0748 e0 cc   `L
l074a:  ld      de,0c210h       ; 074a 11 10 c2   ..B
        call    l1766           ; 074d cd 66 17   Mf.
        ld      hl,0ffadh       ; 0750 21 ad ff   !-.
        jr      l07bd           ; 0753 18 68   .h

l0755:  ldh     a,(81h)         ; 0755 f0 81   p.
        bit     3,a             ; 0757 cb 5f   K_
        jr      z,l075f         ; 0759 28 04   (.
        ld      a,60h           ; 075b 3e 60   >`
        jr      l07ac           ; 075d 18 4d   .M

l075f:  ldh     a,(0cch)        ; 075f f0 cc   pL
        and     a               ; 0761 a7   '
        jr      z,l07b4         ; 0762 28 50   (P
        ldh     a,(0cfh)        ; 0764 f0 cf   pO
        cp      60h             ; 0766 fe 60   .`
        jr      nz,l07a2        ; 0768 20 38    8
l076a:  call    l178a           ; 076a cd 8a 17   M..
l076d:  ldh     a,(0d6h)        ; 076d f0 d6   pV
        and     a               ; 076f a7   '
        jr      nz,l078a        ; 0770 20 18    .
        ld      a,18h           ; 0772 3e 18   >.
        ldh     (0e1h),a        ; 0774 e0 e1   `a
        ldh     a,(0cbh)        ; 0776 f0 cb   pK
        cp      29h             ; 0778 fe 29   .)
        ret     nz              ; 077a c0   @
        xor     a               ; 077b af   /
        ldh     (0a0h),a        ; 077c e0 a0   ` 
        ld      a,6             ; 077e 3e 06   >.
        ld      de,0ffe0h       ; 0780 11 e0 ff   .`.
        ld      hl,0c9a2h       ; 0783 21 a2 c9   !"I
        call    l1b68           ; 0786 cd 68 1b   Mh.
        ret                     ; 0789 c9   I

l078a:  ldh     a,(0cbh)        ; 078a f0 cb   pK
        cp      29h             ; 078c fe 29   .)
        jp      nz,l0828        ; 078e c2 28 08   B(.
        xor     a               ; 0791 af   /
        ldh     (0a0h),a        ; 0792 e0 a0   ` 
        ld      a,6             ; 0794 3e 06   >.
        ld      de,0ffe0h       ; 0796 11 e0 ff   .`.
        ld      hl,0c9a2h       ; 0799 21 a2 c9   !"I
        call    l1b68           ; 079c cd 68 1b   Mh.
        jp      l0828           ; 079f c3 28 08   C(.

l07a2:  ldh     a,(0d0h)        ; 07a2 f0 d0   pP
        cp      6               ; 07a4 fe 06   ..
        jr      nc,l07aa        ; 07a6 30 02   0.
        ldh     (0adh),a        ; 07a8 e0 ad   `-
l07aa:  ldh     a,(0ach)        ; 07aa f0 ac   p,
l07ac:  ldh     (0cfh),a        ; 07ac e0 cf   `O
        xor     a               ; 07ae af   /
        ldh     (0cch),a        ; 07af e0 cc   `L
        inc     a               ; 07b1 3c   <
        ldh     (0ceh),a        ; 07b2 e0 ce   `N
l07b4:  ld      de,0c200h       ; 07b4 11 00 c2   ..B
        call    l1766           ; 07b7 cd 66 17   Mf.
        ld      hl,0ffach       ; 07ba 21 ac ff   !,.
l07bd:  ld      a,(hl)          ; 07bd 7e   .
        bit     4,b             ; 07be cb 60   K`
        jr      nz,l07d6        ; 07c0 20 14    .
        bit     5,b             ; 07c2 cb 68   Kh
        jr      nz,l07e8        ; 07c4 20 22    "
        bit     6,b             ; 07c6 cb 70   Kp
        jr      nz,l07ee        ; 07c8 20 24    $
        bit     7,b             ; 07ca cb 78   Kx
        jr      z,l07e1         ; 07cc 28 13   (.
        cp      3               ; 07ce fe 03   ..
        jr      nc,l07e1        ; 07d0 30 0f   0.
        add     a,3             ; 07d2 c6 03   F.
        jr      l07db           ; 07d4 18 05   ..

l07d6:  cp      5               ; 07d6 fe 05   ..
        jr      z,l07e1         ; 07d8 28 07   (.
        inc     a               ; 07da 3c   <
l07db:  ld      (hl),a          ; 07db 77   w
        ld      a,1             ; 07dc 3e 01   >.
        ld      (0dfe0h),a      ; 07de ea e0 df   j`_
l07e1:  call    l080e           ; 07e1 cd 0e 08   M..
        call    l2671           ; 07e4 cd 71 26   Mq&
        ret                     ; 07e7 c9   I

l07e8:  and     a               ; 07e8 a7   '
        jr      z,l07e1         ; 07e9 28 f6   (v
        dec     a               ; 07eb 3d   =
        jr      l07db           ; 07ec 18 ed   .m

l07ee:  cp      3               ; 07ee fe 03   ..
        jr      c,l07e1         ; 07f0 38 ef   8o
        sub     3               ; 07f2 d6 03   V.
        jr      l07db           ; 07f4 18 e5   .e

l07f6:  .db     40h,60h,40h,70h,40h,80h,50h,60h,50h,70h,50h,80h ; 07f6 40 60 40 70 40 80 50 60 50 70 50 80   @`@p@.P`PpP.
l0802:  .db     78h,60h,78h,70h,78h,80h,88h,60h,88h,70h,88h,80h ; 0802 78 60 78 70 78 80 88 60 88 70 88 80   x`xpx..`.p..

l080e:  ldh     a,(0ach)        ; 080e f0 ac   p,
        ld      de,0c201h       ; 0810 11 01 c2   ..B
        ld      hl,l07f6        ; 0813 21 f6 07   !v.
        call    l1755           ; 0816 cd 55 17   MU.
        ldh     a,(0adh)        ; 0819 f0 ad   p-
        ld      de,0c211h       ; 081b 11 11 c2   ..B
        ld      hl,l0802        ; 081e 21 02 08   !..
        call    l1755           ; 0821 cd 55 17   MU.
        ret                     ; 0824 c9   I

l0825:  call    l2820           ; 0825 cd 20 28   M (
l0828:  xor     a               ; 0828 af   /
        ld      (0c210h),a      ; 0829 ea 10 c2   j.B
        ldh     (98h),a         ; 082c e0 98   `.
        ldh     (9ch),a         ; 082e e0 9c   `.
        ldh     (9bh),a         ; 0830 e0 9b   `.
        ldh     (0fbh),a        ; 0832 e0 fb   `{
        ldh     (9fh),a         ; 0834 e0 9f   `.
        ldh     (0cch),a        ; 0836 e0 cc   `L
        ldh     (1),a           ; 0838 e0 01   `.
        ldh     (0ceh),a        ; 083a e0 ce   `N
        ldh     (0d0h),a        ; 083c e0 d0   `P
        ldh     (0cfh),a        ; 083e e0 cf   `O
        ldh     (0d1h),a        ; 0840 e0 d1   `Q
        call    l2651           ; 0842 cd 51 26   MQ&
        call    l2293           ; 0845 cd 93 22   M."
        call    l1ff2           ; 0848 cd f2 1f   Mr.
        xor     a               ; 084b af   /
        ldh     (0e3h),a        ; 084c e0 e3   `c
        call    l178a           ; 084e cd 8a 17   M..
        ld      de,l537c        ; 0851 11 7c 53   .|S
        push    de              ; 0854 d5   U
        ld      a,1             ; 0855 3e 01   >.
        ldh     (0a9h),a        ; 0857 e0 a9   `)
        ldh     (0c5h),a        ; 0859 e0 c5   `E
        call    l27eb           ; 085b cd eb 27   Mk'
        pop     de              ; 085e d1   Q
        ld      hl,9c00h        ; 085f 21 00 9c   !..
        call    l27ee           ; 0862 cd ee 27   Mn'
        ld      de,l2839        ; 0865 11 39 28   .9(
        ld      hl,9c63h        ; 0868 21 63 9c   !c.
        ld      c,0ah           ; 086b 0e 0a   ..
        call    l1f7d           ; 086d cd 7d 1f   M}.
        ld      hl,0c200h       ; 0870 21 00 c2   !.B
        ld      de,l26bf        ; 0873 11 bf 26   .?&
        call    l26b6           ; 0876 cd b6 26   M6&
        ld      hl,0c210h       ; 0879 21 10 c2   !.B
        ld      de,l26c7        ; 087c 11 c7 26   .G&
        call    l26b6           ; 087f cd b6 26   M6&
        ld      hl,9951h        ; 0882 21 51 99   !Q.
        ld      a,30h           ; 0885 3e 30   >0
        ldh     (9eh),a         ; 0887 e0 9e   `.
        ld      (hl),0          ; 0889 36 00   6.
        dec     l               ; 088b 2d   -
        ld      (hl),3          ; 088c 36 03   6.
        call    l1ae8           ; 088e cd e8 1a   Mh.
        xor     a               ; 0891 af   /
        ldh     (0a0h),a        ; 0892 e0 a0   ` 
        ldh     a,(0cbh)        ; 0894 f0 cb   pK
        cp      29h             ; 0896 fe 29   .)
        ld      de,l08d4        ; 0898 11 d4 08   .T.
        ldh     a,(0ach)        ; 089b f0 ac   p,
        jr      z,l08a4         ; 089d 28 05   (.
        ld      de,l08c4        ; 089f 11 c4 08   .D.
        ldh     a,(0adh)        ; 08a2 f0 ad   p-
l08a4:  ld      hl,98b0h        ; 08a4 21 b0 98   !0.
        ld      (hl),a          ; 08a7 77   w
        ld      h,9ch           ; 08a8 26 9c   &.
        ld      (hl),a          ; 08aa 77   w
        ld      hl,0c080h       ; 08ab 21 80 c0   !.@
        ld      b,10h           ; 08ae 06 10   ..
        call    l0725           ; 08b0 cd 25 07   M%.
        ld      a,77h           ; 08b3 3e 77   >w
        ldh     (0c0h),a        ; 08b5 e0 c0   `@
        ld      a,0d3h          ; 08b7 3e d3   >S
        ldh     (40h),a         ; 08b9 e0 40   `@
        ld      a,19h           ; 08bb 3e 19   >.
        ldh     (0e1h),a        ; 08bd e0 e1   `a
        ld      a,1             ; 08bf 3e 01   >.
        ldh     (0cdh),a        ; 08c1 e0 cd   `M
        ret                     ; 08c3 c9   I

l08c4:  .db     18h,84h,0c0h,0,18h,8ch,0c0h,20h,20h,84h,0c1h,0,20h      ; 08c4 18 84 c0 00 18 8c c0 20 20 84 c1 00 20   ..@...@  .A. 
        .db     8ch,0c1h,20h    ; 08d1 8c c1 20   .A 
l08d4:  .db     18h,84h,0aeh,0,18h,8ch,0aeh,20h,20h,84h,0afh,0,20h      ; 08d4 18 84 ae 00 18 8c ae 20 20 84 af 00 20   .......  ./. 
        .db     8ch,0afh,20h    ; 08e1 8c af 20   ./ 

l08e4:  ld      a,8             ; 08e4 3e 08   >.
        ldh     (0ffh),a        ; 08e6 e0 ff   `.
        xor     a               ; 08e8 af   /
        ldh     (0fh),a         ; 08e9 e0 0f   `.
        ldh     a,(0cbh)        ; 08eb f0 cb   pK
        cp      29h             ; 08ed fe 29   .)
        jp      nz,l09f6        ; 08ef c2 f6 09   Bv.
l08f2:  call    l0a98           ; 08f2 cd 98 0a   M..
        call    l0a98           ; 08f5 cd 98 0a   M..
        xor     a               ; 08f8 af   /
        ldh     (0cch),a        ; 08f9 e0 cc   `L
        ld      a,29h           ; 08fb 3e 29   >)
        ldh     (1),a           ; 08fd e0 01   `.
        ld      a,81h           ; 08ff 3e 81   >.
        ldh     (2),a           ; 0901 e0 02   `.
l0903:  ldh     a,(0cch)        ; 0903 f0 cc   pL
        and     a               ; 0905 a7   '
        jr      z,l0903         ; 0906 28 fb   ({
        ldh     a,(1)           ; 0908 f0 01   p.
        cp      55h             ; 090a fe 55   .U
        jr      nz,l08f2        ; 090c 20 e4    d
        ld      de,16h          ; 090e 11 16 00   ...
        ld      c,0ah           ; 0911 0e 0a   ..
        ld      hl,0c902h       ; 0913 21 02 c9   !.I
l0916:  ld      b,0ah           ; 0916 06 0a   ..
l0918:  xor     a               ; 0918 af   /
        ldh     (0cch),a        ; 0919 e0 cc   `L
        call    l0a98           ; 091b cd 98 0a   M..
        ldi     a,(hl)          ; 091e 2a   *
        ldh     (1),a           ; 091f e0 01   `.
        ld      a,81h           ; 0921 3e 81   >.
        ldh     (2),a           ; 0923 e0 02   `.
l0925:  ldh     a,(0cch)        ; 0925 f0 cc   pL
        and     a               ; 0927 a7   '
        jr      z,l0925         ; 0928 28 fb   ({
        dec     b               ; 092a 05   .
        jr      nz,l0918        ; 092b 20 eb    k
        add     hl,de           ; 092d 19   .
        dec     c               ; 092e 0d   .
        jr      nz,l0916        ; 092f 20 e5    e
        ldh     a,(0ach)        ; 0931 f0 ac   p,
        cp      5               ; 0933 fe 05   ..
        jr      z,l0974         ; 0935 28 3d   (=
        ld      hl,0ca22h       ; 0937 21 22 ca   !"J
        ld      de,40h          ; 093a 11 40 00   .@.
l093d:  add     hl,de           ; 093d 19   .
        inc     a               ; 093e 3c   <
        cp      5               ; 093f fe 05   ..
        jr      nz,l093d        ; 0941 20 fa    z
        ld      de,0ca22h       ; 0943 11 22 ca   ."J
        ld      c,0ah           ; 0946 0e 0a   ..
l0948:  ld      b,0ah           ; 0948 06 0a   ..
l094a:  ld      a,(de)          ; 094a 1a   .
        ldi     (hl),a          ; 094b 22   "
        inc     e               ; 094c 1c   .
        dec     b               ; 094d 05   .
        jr      nz,l094a        ; 094e 20 fa    z
        push    de              ; 0950 d5   U
        ld      de,0ffd6h       ; 0951 11 d6 ff   .V.
        add     hl,de           ; 0954 19   .
        pop     de              ; 0955 d1   Q
        push    hl              ; 0956 e5   e
        ld      hl,0ffd6h       ; 0957 21 d6 ff   !V.
        add     hl,de           ; 095a 19   .
        push    hl              ; 095b e5   e
        pop     de              ; 095c d1   Q
        pop     hl              ; 095d e1   a
        dec     c               ; 095e 0d   .
        jr      nz,l0948        ; 095f 20 e7    g
        ld      de,0ffd6h       ; 0961 11 d6 ff   .V.
l0964:  ld      b,0ah           ; 0964 06 0a   ..
        ld      a,h             ; 0966 7c   |
        cp      0c8h            ; 0967 fe c8   .H
        jr      z,l0974         ; 0969 28 09   (.
        ld      a,2fh           ; 096b 3e 2f   >/
l096d:  ldi     (hl),a          ; 096d 22   "
        dec     b               ; 096e 05   .
        jr      nz,l096d        ; 096f 20 fc    |
        add     hl,de           ; 0971 19   .
        jr      l0964           ; 0972 18 f0   .p

l0974:  call    l0a98           ; 0974 cd 98 0a   M..
        call    l0a98           ; 0977 cd 98 0a   M..
        xor     a               ; 097a af   /
        ldh     (0cch),a        ; 097b e0 cc   `L
        ld      a,29h           ; 097d 3e 29   >)
        ldh     (1),a           ; 097f e0 01   `.
        ld      a,81h           ; 0981 3e 81   >.
        ldh     (2),a           ; 0983 e0 02   `.
l0985:  ldh     a,(0cch)        ; 0985 f0 cc   pL
        and     a               ; 0987 a7   '
        jr      z,l0985         ; 0988 28 fb   ({
        ldh     a,(1)           ; 098a f0 01   p.
        cp      55h             ; 098c fe 55   .U
        jr      nz,l0974        ; 098e 20 e4    d
        ld      hl,0c300h       ; 0990 21 00 c3   !.C
        ld      b,0             ; 0993 06 00   ..
l0995:  xor     a               ; 0995 af   /
        ldh     (0cch),a        ; 0996 e0 cc   `L
        ldi     a,(hl)          ; 0998 2a   *
        call    l0a98           ; 0999 cd 98 0a   M..
        ldh     (1),a           ; 099c e0 01   `.
        ld      a,81h           ; 099e 3e 81   >.
        ldh     (2),a           ; 09a0 e0 02   `.
l09a2:  ldh     a,(0cch)        ; 09a2 f0 cc   pL
        and     a               ; 09a4 a7   '
        jr      z,l09a2         ; 09a5 28 fb   ({
        inc     b               ; 09a7 04   .
        jr      nz,l0995        ; 09a8 20 eb    k
l09aa:  call    l0a98           ; 09aa cd 98 0a   M..
        call    l0a98           ; 09ad cd 98 0a   M..
        xor     a               ; 09b0 af   /
        ldh     (0cch),a        ; 09b1 e0 cc   `L
        ld      a,30h           ; 09b3 3e 30   >0
        ldh     (1),a           ; 09b5 e0 01   `.
        ld      a,81h           ; 09b7 3e 81   >.
        ldh     (2),a           ; 09b9 e0 02   `.
l09bb:  ldh     a,(0cch)        ; 09bb f0 cc   pL
        and     a               ; 09bd a7   '
        jr      z,l09bb         ; 09be 28 fb   ({
        ldh     a,(1)           ; 09c0 f0 01   p.
        cp      56h             ; 09c2 fe 56   .V
        jr      nz,l09aa        ; 09c4 20 e4    d
l09c6:  call    l0a8c           ; 09c6 cd 8c 0a   M..
        ld      a,9             ; 09c9 3e 09   >.
        ldh     (0ffh),a        ; 09cb e0 ff   `.
        ld      a,1ch           ; 09cd 3e 1c   >.
        ldh     (0e1h),a        ; 09cf e0 e1   `a
        ld      a,2             ; 09d1 3e 02   >.
        ldh     (0e3h),a        ; 09d3 e0 e3   `c
        ld      a,3             ; 09d5 3e 03   >.
        ldh     (0cdh),a        ; 09d7 e0 cd   `M
        ldh     a,(0cbh)        ; 09d9 f0 cb   pK
        cp      29h             ; 09db fe 29   .)
        jr      z,l09e4         ; 09dd 28 05   (.
        ld      hl,0ff02h       ; 09df 21 02 ff   !..
        set     7,(hl)          ; 09e2 cb fe   K.
l09e4:  ld      hl,0c300h       ; 09e4 21 00 c3   !.C
        ldi     a,(hl)          ; 09e7 2a   *
        ld      (0c203h),a      ; 09e8 ea 03 c2   j.B
        ldi     a,(hl)          ; 09eb 2a   *
        ld      (0c213h),a      ; 09ec ea 13 c2   j.B
        ld      a,h             ; 09ef 7c   |
        ldh     (0afh),a        ; 09f0 e0 af   `/
        ld      a,l             ; 09f2 7d   }
        ldh     (0b0h),a        ; 09f3 e0 b0   `0
        ret                     ; 09f5 c9   I

l09f6:  ldh     a,(0adh)        ; 09f6 f0 ad   p-
        inc     a               ; 09f8 3c   <
        ld      b,a             ; 09f9 47   G
        ld      hl,0ca42h       ; 09fa 21 42 ca   !BJ
        ld      de,0ffc0h       ; 09fd 11 c0 ff   .@.
l0a00:  dec     b               ; 0a00 05   .
        jr      z,l0a06         ; 0a01 28 03   (.
        add     hl,de           ; 0a03 19   .
        jr      l0a00           ; 0a04 18 fa   .z

l0a06:  call    l0a98           ; 0a06 cd 98 0a   M..
        xor     a               ; 0a09 af   /
        ldh     (0cch),a        ; 0a0a e0 cc   `L
        ld      a,55h           ; 0a0c 3e 55   >U
        ldh     (1),a           ; 0a0e e0 01   `.
        ld      a,80h           ; 0a10 3e 80   >.
        ldh     (2),a           ; 0a12 e0 02   `.
l0a14:  ldh     a,(0cch)        ; 0a14 f0 cc   pL
        and     a               ; 0a16 a7   '
        jr      z,l0a14         ; 0a17 28 fb   ({
        ldh     a,(1)           ; 0a19 f0 01   p.
        cp      29h             ; 0a1b fe 29   .)
        jr      nz,l0a06        ; 0a1d 20 e7    g
        ld      de,16h          ; 0a1f 11 16 00   ...
        ld      c,0ah           ; 0a22 0e 0a   ..
l0a24:  ld      b,0ah           ; 0a24 06 0a   ..
l0a26:  xor     a               ; 0a26 af   /
        ldh     (0cch),a        ; 0a27 e0 cc   `L
        ldh     (1),a           ; 0a29 e0 01   `.
        ld      a,80h           ; 0a2b 3e 80   >.
        ldh     (2),a           ; 0a2d e0 02   `.
l0a2f:  ldh     a,(0cch)        ; 0a2f f0 cc   pL
        and     a               ; 0a31 a7   '
        jr      z,l0a2f         ; 0a32 28 fb   ({
        ldh     a,(1)           ; 0a34 f0 01   p.
        ldi     (hl),a          ; 0a36 22   "
        dec     b               ; 0a37 05   .
        jr      nz,l0a26        ; 0a38 20 ec    l
        add     hl,de           ; 0a3a 19   .
        dec     c               ; 0a3b 0d   .
        jr      nz,l0a24        ; 0a3c 20 e6    f
l0a3e:  call    l0a98           ; 0a3e cd 98 0a   M..
        xor     a               ; 0a41 af   /
        ldh     (0cch),a        ; 0a42 e0 cc   `L
        ld      a,55h           ; 0a44 3e 55   >U
        ldh     (1),a           ; 0a46 e0 01   `.
        ld      a,80h           ; 0a48 3e 80   >.
        ldh     (2),a           ; 0a4a e0 02   `.
l0a4c:  ldh     a,(0cch)        ; 0a4c f0 cc   pL
        and     a               ; 0a4e a7   '
        jr      z,l0a4c         ; 0a4f 28 fb   ({
        ldh     a,(1)           ; 0a51 f0 01   p.
        cp      29h             ; 0a53 fe 29   .)
        jr      nz,l0a3e        ; 0a55 20 e7    g
        ld      b,0             ; 0a57 06 00   ..
        ld      hl,0c300h       ; 0a59 21 00 c3   !.C
l0a5c:  xor     a               ; 0a5c af   /
        ldh     (0cch),a        ; 0a5d e0 cc   `L
        ldh     (1),a           ; 0a5f e0 01   `.
        ld      a,80h           ; 0a61 3e 80   >.
        ldh     (2),a           ; 0a63 e0 02   `.
l0a65:  ldh     a,(0cch)        ; 0a65 f0 cc   pL
        and     a               ; 0a67 a7   '
        jr      z,l0a65         ; 0a68 28 fb   ({
        ldh     a,(1)           ; 0a6a f0 01   p.
        ldi     (hl),a          ; 0a6c 22   "
        inc     b               ; 0a6d 04   .
        jr      nz,l0a5c        ; 0a6e 20 ec    l
l0a70:  call    l0a98           ; 0a70 cd 98 0a   M..
        xor     a               ; 0a73 af   /
        ldh     (0cch),a        ; 0a74 e0 cc   `L
        ld      a,56h           ; 0a76 3e 56   >V
        ldh     (1),a           ; 0a78 e0 01   `.
        ld      a,80h           ; 0a7a 3e 80   >.
        ldh     (2),a           ; 0a7c e0 02   `.
l0a7e:  ldh     a,(0cch)        ; 0a7e f0 cc   pL
        and     a               ; 0a80 a7   '
        jr      z,l0a7e         ; 0a81 28 fb   ({
        ldh     a,(1)           ; 0a83 f0 01   p.
        cp      30h             ; 0a85 fe 30   .0
        jr      nz,l0a70        ; 0a87 20 e7    g
        jp      l09c6           ; 0a89 c3 c6 09   CF.

l0a8c:  ld      hl,0ca42h       ; 0a8c 21 42 ca   !BJ
        ld      a,80h           ; 0a8f 3e 80   >.
        ld      b,0ah           ; 0a91 06 0a   ..
l0a93:  ldi     (hl),a          ; 0a93 22   "
        dec     b               ; 0a94 05   .
        jr      nz,l0a93        ; 0a95 20 fc    |
        ret                     ; 0a97 c9   I

; Delay routine ?
l0a98:  push    bc              ; 0a98 c5   E
        ld      b,0fah          ; 0a99 06 fa   .z
l0a9b:  ld      b,b             ; 0a9b 40   @
        dec     b               ; 0a9c 05   .
        jr      nz,l0a9b        ; 0a9d 20 fc    |
        pop     bc              ; 0a9f c1   A
        ret                     ; 0aa0 c9   I

l0aa1:  push    hl              ; 0aa1 e5   e
        push    bc              ; 0aa2 c5   E
        ldh     a,(0fch)        ; 0aa3 f0 fc   p|
        and     0fch            ; 0aa5 e6 fc   f|
        ld      c,a             ; 0aa7 4f   O
        ld      h,3             ; 0aa8 26 03   &.
l0aaa:  ldh     a,(4)           ; 0aaa f0 04   p.
        ld      b,a             ; 0aac 47   G
l0aad:  xor     a               ; 0aad af   /
l0aae:  dec     b               ; 0aae 05   .
        jr      z,l0abb         ; 0aaf 28 0a   (.
        inc     a               ; 0ab1 3c   <
        inc     a               ; 0ab2 3c   <
        inc     a               ; 0ab3 3c   <
        inc     a               ; 0ab4 3c   <
        cp      1ch             ; 0ab5 fe 1c   ..
        jr      z,l0aad         ; 0ab7 28 f4   (t
        jr      l0aae           ; 0ab9 18 f3   .s

l0abb:  ld      d,a             ; 0abb 57   W
        ldh     a,(0aeh)        ; 0abc f0 ae   p.
        ld      e,a             ; 0abe 5f   _
        dec     h               ; 0abf 25   %
        jr      z,l0ac9         ; 0ac0 28 07   (.
        or      d               ; 0ac2 b2   2
        or      c               ; 0ac3 b1   1
        and     0fch            ; 0ac4 e6 fc   f|
        cp      c               ; 0ac6 b9   9
        jr      z,l0aaa         ; 0ac7 28 e1   (a
l0ac9:  ld      a,d             ; 0ac9 7a   z
        ldh     (0aeh),a        ; 0aca e0 ae   `.
        ld      a,e             ; 0acc 7b   {
        ldh     (0fch),a        ; 0acd e0 fc   `|
        pop     bc              ; 0acf c1   A
        pop     hl              ; 0ad0 e1   a
        ret                     ; 0ad1 c9   I

l0ad2:  ld      a,1             ; 0ad2 3e 01   >.
        ldh     (0ffh),a        ; 0ad4 e0 ff   `.
        ldh     a,(0e3h)        ; 0ad6 f0 e3   pc
        and     a               ; 0ad8 a7   '
        jr      nz,l0b02        ; 0ad9 20 27    '
        ld      b,44h           ; 0adb 06 44   .D
        ld      c,20h           ; 0add 0e 20   . 
        call    l113f           ; 0adf cd 3f 11   M?.
        ld      a,2             ; 0ae2 3e 02   >.
        ldh     (0cdh),a        ; 0ae4 e0 cd   `M
        ld      a,(0c0deh)      ; 0ae6 fa de c0   z^@
        and     a               ; 0ae9 a7   '
        jr      z,l0af1         ; 0aea 28 05   (.
        ld      a,80h           ; 0aec 3e 80   >.
        ld      (0c210h),a      ; 0aee ea 10 c2   j.B
l0af1:  call    l2683           ; 0af1 cd 83 26   M.&
        call    l2696           ; 0af4 cd 96 26   M.&
        call    l1517           ; 0af7 cd 17 15   M..
        xor     a               ; 0afa af   /
        ldh     (0d6h),a        ; 0afb e0 d6   `V
        ld      a,1ah           ; 0afd 3e 1a   >.
        ldh     (0e1h),a        ; 0aff e0 e1   `a
        ret                     ; 0b01 c9   I

l0b02:  cp      5               ; 0b02 fe 05   ..
        ret     nz              ; 0b04 c0   @
        ld      hl,0c030h       ; 0b05 21 30 c0   !0@
        ld      b,12h           ; 0b08 06 12   ..
l0b0a:  ld      (hl),0f0h       ; 0b0a 36 f0   6p
        inc     hl              ; 0b0c 23   #
        ld      (hl),10h        ; 0b0d 36 10   6.
        inc     hl              ; 0b0f 23   #
        ld      (hl),0b6h       ; 0b10 36 b6   66
        inc     hl              ; 0b12 23   #
        ld      (hl),80h        ; 0b13 36 80   6.
        inc     hl              ; 0b15 23   #
        dec     b               ; 0b16 05   .
        jr      nz,l0b0a        ; 0b17 20 f1    q
        ld      a,(0c3ffh)      ; 0b19 fa ff c3   z.C
l0b1c:  ld      b,0ah           ; 0b1c 06 0a   ..
        ld      hl,0c400h       ; 0b1e 21 00 c4   !.D
l0b21:  dec     a               ; 0b21 3d   =
        jr      z,l0b2a         ; 0b22 28 06   (.
        inc     l               ; 0b24 2c   ,
        dec     b               ; 0b25 05   .
        jr      nz,l0b21        ; 0b26 20 f9    y
        jr      l0b1c           ; 0b28 18 f2   .r

l0b2a:  ld      (hl),2fh        ; 0b2a 36 2f   6/
        ld      a,3             ; 0b2c 3e 03   >.
        ldh     (0ceh),a        ; 0b2e e0 ce   `N
        ret                     ; 0b30 c9   I

l0b31:  ld      a,1             ; 0b31 3e 01   >.
        ldh     (0ffh),a        ; 0b33 e0 ff   `.
        ld      hl,0c09ch       ; 0b35 21 9c c0   !.@
        xor     a               ; 0b38 af   /
        ldi     (hl),a          ; 0b39 22   "
        ld      (hl),50h        ; 0b3a 36 50   6P
        inc     l               ; 0b3c 2c   ,
        ld      (hl),27h        ; 0b3d 36 27   6'
        inc     l               ; 0b3f 2c   ,
        ld      (hl),0          ; 0b40 36 00   6.
        call    l1c0d           ; 0b42 cd 0d 1c   M..
        call    l1c88           ; 0b45 cd 88 1c   M..
        call    l24bb           ; 0b48 cd bb 24   M;$
        call    l209c           ; 0b4b cd 9c 20   M. 
        call    l213e           ; 0b4e cd 3e 21   M>!
        call    l25a1           ; 0b51 cd a1 25   M!%
        call    l224d           ; 0b54 cd 4d 22   MM"
        call    l0b9b           ; 0b57 cd 9b 0b   M..
        ldh     a,(0d5h)        ; 0b5a f0 d5   pU
        and     a               ; 0b5c a7   '
        jr      z,l0b73         ; 0b5d 28 14   (.
        ld      a,77h           ; 0b5f 3e 77   >w
        ldh     (0cfh),a        ; 0b61 e0 cf   `O
        ldh     (0b1h),a        ; 0b63 e0 b1   `1
        ld      a,0aah          ; 0b65 3e aa   >*
        ldh     (0d1h),a        ; 0b67 e0 d1   `Q
        ld      a,1bh           ; 0b69 3e 1b   >.
        ldh     (0e1h),a        ; 0b6b e0 e1   `a
        ld      a,5             ; 0b6d 3e 05   >.
        ldh     (0a7h),a        ; 0b6f e0 a7   `'
        jr      l0b83           ; 0b71 18 10   ..

l0b73:  ldh     a,(0e1h)        ; 0b73 f0 e1   pa
        cp      1               ; 0b75 fe 01   ..
        jr      nz,l0b94        ; 0b77 20 1b    .
        ld      a,0aah          ; 0b79 3e aa   >*
        ldh     (0cfh),a        ; 0b7b e0 cf   `O
        ldh     (0b1h),a        ; 0b7d e0 b1   `1
        ld      a,77h           ; 0b7f 3e 77   >w
        ldh     (0d1h),a        ; 0b81 e0 d1   `Q
l0b83:  xor     a               ; 0b83 af   /
        ldh     (0dch),a        ; 0b84 e0 dc   `\
        ldh     (0d2h),a        ; 0b86 e0 d2   `R
        ldh     (0d3h),a        ; 0b88 e0 d3   `S
        ldh     (0d4h),a        ; 0b8a e0 d4   `T
        ldh     a,(0cbh)        ; 0b8c f0 cb   pK
        cp      29h             ; 0b8e fe 29   .)
        jr      nz,l0b94        ; 0b90 20 02    .
        ldh     (0ceh),a        ; 0b92 e0 ce   `N
l0b94:  call    l0bf0           ; 0b94 cd f0 0b   Mp.
        call    l0c8c           ; 0b97 cd 8c 0c   M..
        ret                     ; 0b9a c9   I

l0b9b:  ld      de,20h          ; 0b9b 11 20 00   . .
        ld      hl,0c802h       ; 0b9e 21 02 c8   !.H
        ld      a,2fh           ; 0ba1 3e 2f   >/
        ld      c,12h           ; 0ba3 0e 12   ..
l0ba5:  ld      b,0ah           ; 0ba5 06 0a   ..
        push    hl              ; 0ba7 e5   e
l0ba8:  cp      (hl)            ; 0ba8 be   >
        jr      nz,l0bb5        ; 0ba9 20 0a    .
        inc     hl              ; 0bab 23   #
        dec     b               ; 0bac 05   .
        jr      nz,l0ba8        ; 0bad 20 f9    y
        pop     hl              ; 0baf e1   a
        add     hl,de           ; 0bb0 19   .
        dec     c               ; 0bb1 0d   .
        jr      nz,l0ba5        ; 0bb2 20 f1    q
        push    hl              ; 0bb4 e5   e
l0bb5:  pop     hl              ; 0bb5 e1   a
        ld      a,c             ; 0bb6 79   y
        ldh     (0b1h),a        ; 0bb7 e0 b1   `1
        cp      0ch             ; 0bb9 fe 0c   ..
        ld      a,(0dfe9h)      ; 0bbb fa e9 df   zi_
        jr      nc,l0bc7        ; 0bbe 30 07   0.
        cp      8               ; 0bc0 fe 08   ..
        ret     nz              ; 0bc2 c0   @
        call    l1517           ; 0bc3 cd 17 15   M..
        ret                     ; 0bc6 c9   I

l0bc7:  cp      8               ; 0bc7 fe 08   ..
        ret     z               ; 0bc9 c8   H
        ld      a,(0dff0h)      ; 0bca fa f0 df   zp_
        cp      2               ; 0bcd fe 02   ..
        ret     z               ; 0bcf c8   H
        ld      a,8             ; 0bd0 3e 08   >.
        ld      (0dfe8h),a      ; 0bd2 ea e8 df   jh_
        ret                     ; 0bd5 c9   I

l0bd6:  ldh     a,(0cbh)        ; 0bd6 f0 cb   pK
        cp      29h             ; 0bd8 fe 29   .)
        jr      z,l0c2e         ; 0bda 28 52   (R
        ld      a,1             ; 0bdc 3e 01   >.
        ld      (0df7fh),a      ; 0bde ea 7f df   j._
        ldh     (0abh),a        ; 0be1 e0 ab   `+
        ldh     a,(0cfh)        ; 0be3 f0 cf   pO
        ldh     (0f1h),a        ; 0be5 e0 f1   `q
        xor     a               ; 0be7 af   /
        ldh     (0f2h),a        ; 0be8 e0 f2   `r
        ldh     (0cfh),a        ; 0bea e0 cf   `O
        call    l1ccb           ; 0bec cd cb 1c   MK.
        ret                     ; 0bef c9   I

l0bf0:  ldh     a,(0cch)        ; 0bf0 f0 cc   pL
        and     a               ; 0bf2 a7   '
        ret     z               ; 0bf3 c8   H
        ld      hl,0c030h       ; 0bf4 21 30 c0   !0@
        ld      de,4            ; 0bf7 11 04 00   ...
        xor     a               ; 0bfa af   /
        ldh     (0cch),a        ; 0bfb e0 cc   `L
        ldh     a,(0d0h)        ; 0bfd f0 d0   pP
        cp      0aah            ; 0bff fe aa   .*
        jr      z,l0c64         ; 0c01 28 61   (a
        cp      77h             ; 0c03 fe 77   .w
        jr      z,l0c50         ; 0c05 28 49   (I
        cp      94h             ; 0c07 fe 94   ..
        jr      z,l0bd6         ; 0c09 28 cb   (K
        ld      b,a             ; 0c0b 47   G
        and     a               ; 0c0c a7   '
        jr      z,l0c60         ; 0c0d 28 51   (Q
        bit     7,a             ; 0c0f cb 7f   K.
        jr      nz,l0c82        ; 0c11 20 6f    o
        cp      13h             ; 0c13 fe 13   ..
        jr      nc,l0c2e        ; 0c15 30 17   0.
        ld      a,12h           ; 0c17 3e 12   >.
        sub     b               ; 0c19 90   .
        ld      c,a             ; 0c1a 4f   O
        inc     c               ; 0c1b 0c   .
l0c1c:  ld      a,98h           ; 0c1c 3e 98   >.
l0c1e:  ld      (hl),a          ; 0c1e 77   w
        add     hl,de           ; 0c1f 19   .
        sub     8               ; 0c20 d6 08   V.
        dec     b               ; 0c22 05   .
        jr      nz,l0c1e        ; 0c23 20 f9    y
l0c25:  ld      a,0f0h          ; 0c25 3e f0   >p
l0c27:  dec     c               ; 0c27 0d   .
        jr      z,l0c2e         ; 0c28 28 04   (.
        ld      (hl),a          ; 0c2a 77   w
        add     hl,de           ; 0c2b 19   .
        jr      l0c27           ; 0c2c 18 f9   .y

l0c2e:  ldh     a,(0dch)        ; 0c2e f0 dc   p\
        and     a               ; 0c30 a7   '
        jr      z,l0c3a         ; 0c31 28 07   (.
        or      80h             ; 0c33 f6 80   v.
        ldh     (0b1h),a        ; 0c35 e0 b1   `1
        xor     a               ; 0c37 af   /
        ldh     (0dch),a        ; 0c38 e0 dc   `\
l0c3a:  ld      a,0ffh          ; 0c3a 3e ff   >.
        ldh     (0d0h),a        ; 0c3c e0 d0   `P
        ldh     a,(0cbh)        ; 0c3e f0 cb   pK
        cp      29h             ; 0c40 fe 29   .)
        ldh     a,(0b1h)        ; 0c42 f0 b1   p1
        jr      nz,l0c4d        ; 0c44 20 07    .
        ldh     (0cfh),a        ; 0c46 e0 cf   `O
        ld      a,1             ; 0c48 3e 01   >.
        ldh     (0ceh),a        ; 0c4a e0 ce   `N
        ret                     ; 0c4c c9   I

l0c4d:  ldh     (0cfh),a        ; 0c4d e0 cf   `O
        ret                     ; 0c4f c9   I

l0c50:  ldh     a,(0d1h)        ; 0c50 f0 d1   pQ
        cp      0aah            ; 0c52 fe aa   .*
        jr      z,l0c7c         ; 0c54 28 26   (&
        ld      a,77h           ; 0c56 3e 77   >w
        ldh     (0d1h),a        ; 0c58 e0 d1   `Q
        ld      a,1             ; 0c5a 3e 01   >.
        ldh     (0e1h),a        ; 0c5c e0 e1   `a
        jr      l0c2e           ; 0c5e 18 ce   .N

l0c60:  ld      c,13h           ; 0c60 0e 13   ..
        jr      l0c25           ; 0c62 18 c1   .A

l0c64:  ldh     a,(0d1h)        ; 0c64 f0 d1   pQ
        cp      77h             ; 0c66 fe 77   .w
        jr      z,l0c7c         ; 0c68 28 12   (.
        ld      a,0aah          ; 0c6a 3e aa   >*
        ldh     (0d1h),a        ; 0c6c e0 d1   `Q
        ld      a,1bh           ; 0c6e 3e 1b   >.
        ldh     (0e1h),a        ; 0c70 e0 e1   `a
        ld      a,5             ; 0c72 3e 05   >.
        ldh     (0a7h),a        ; 0c74 e0 a7   `'
        ld      c,1             ; 0c76 0e 01   ..
        ld      b,12h           ; 0c78 06 12   ..
        jr      l0c1c           ; 0c7a 18 a0   . 

l0c7c:  ld      a,1             ; 0c7c 3e 01   >.
        ldh     (0efh),a        ; 0c7e e0 ef   `o
        jr      l0c2e           ; 0c80 18 ac   .,

l0c82:  and     7fh             ; 0c82 e6 7f   f.
        cp      5               ; 0c84 fe 05   ..
        jr      nc,l0c2e        ; 0c86 30 a6   0&
        ldh     (0d2h),a        ; 0c88 e0 d2   `R
        jr      l0c3a           ; 0c8a 18 ae   ..

l0c8c:  ldh     a,(0d3h)        ; 0c8c f0 d3   pS
        and     a               ; 0c8e a7   '
        jr      z,l0c98         ; 0c8f 28 07   (.
        bit     7,a             ; 0c91 cb 7f   K.
        ret     z               ; 0c93 c8   H
        and     7               ; 0c94 e6 07   f.
        jr      l0ca2           ; 0c96 18 0a   ..

l0c98:  ldh     a,(0d2h)        ; 0c98 f0 d2   pR
        and     a               ; 0c9a a7   '
        ret     z               ; 0c9b c8   H
        ldh     (0d3h),a        ; 0c9c e0 d3   `S
        xor     a               ; 0c9e af   /
        ldh     (0d2h),a        ; 0c9f e0 d2   `R
        ret                     ; 0ca1 c9   I

l0ca2:  ld      c,a             ; 0ca2 4f   O
        push    bc              ; 0ca3 c5   E
        ld      hl,0c822h       ; 0ca4 21 22 c8   !"H
        ld      de,0ffe0h       ; 0ca7 11 e0 ff   .`.
l0caa:  add     hl,de           ; 0caa 19   .
        dec     c               ; 0cab 0d   .
        jr      nz,l0caa        ; 0cac 20 fc    |
        ld      de,0c822h       ; 0cae 11 22 c8   ."H
        ld      c,11h           ; 0cb1 0e 11   ..
l0cb3:  ld      b,0ah           ; 0cb3 06 0a   ..
l0cb5:  ld      a,(de)          ; 0cb5 1a   .
        ldi     (hl),a          ; 0cb6 22   "
        inc     e               ; 0cb7 1c   .
        dec     b               ; 0cb8 05   .
        jr      nz,l0cb5        ; 0cb9 20 fa    z
        push    de              ; 0cbb d5   U
        ld      de,16h          ; 0cbc 11 16 00   ...
        add     hl,de           ; 0cbf 19   .
        pop     de              ; 0cc0 d1   Q
        push    hl              ; 0cc1 e5   e
        ld      hl,16h          ; 0cc2 21 16 00   !..
        add     hl,de           ; 0cc5 19   .
        push    hl              ; 0cc6 e5   e
        pop     de              ; 0cc7 d1   Q
        pop     hl              ; 0cc8 e1   a
        dec     c               ; 0cc9 0d   .
        jr      nz,l0cb3        ; 0cca 20 e7    g
        pop     bc              ; 0ccc c1   A
l0ccd:  ld      de,0c400h       ; 0ccd 11 00 c4   ..D
        ld      b,0ah           ; 0cd0 06 0a   ..
l0cd2:  ld      a,(de)          ; 0cd2 1a   .
        ldi     (hl),a          ; 0cd3 22   "
        inc     de              ; 0cd4 13   .
        dec     b               ; 0cd5 05   .
        jr      nz,l0cd2        ; 0cd6 20 fa    z
        push    de              ; 0cd8 d5   U
        ld      de,16h          ; 0cd9 11 16 00   ...
        add     hl,de           ; 0cdc 19   .
        pop     de              ; 0cdd d1   Q
        dec     c               ; 0cde 0d   .
        jr      nz,l0ccd        ; 0cdf 20 ec    l
        ld      a,2             ; 0ce1 3e 02   >.
        ldh     (0e3h),a        ; 0ce3 e0 e3   `c
        ldh     (0d4h),a        ; 0ce5 e0 d4   `T
        xor     a               ; 0ce7 af   /
        ldh     (0d3h),a        ; 0ce8 e0 d3   `S
        ret                     ; 0cea c9   I

l0ceb:  ldh     a,(0a6h)        ; 0ceb f0 a6   p&
        and     a               ; 0ced a7   '
        ret     nz              ; 0cee c0   @
        ld      a,1             ; 0cef 3e 01   >.
        ldh     (0ffh),a        ; 0cf1 e0 ff   `.
        ld      a,3             ; 0cf3 3e 03   >.
        ldh     (0cdh),a        ; 0cf5 e0 cd   `M
        ldh     a,(0d1h)        ; 0cf7 f0 d1   pQ
        cp      77h             ; 0cf9 fe 77   .w
        jr      nz,l0d09        ; 0cfb 20 0c    .
        ldh     a,(0d0h)        ; 0cfd f0 d0   pP
        cp      0aah            ; 0cff fe aa   .*
        jr      nz,l0d13        ; 0d01 20 10    .
l0d03:  ld      a,1             ; 0d03 3e 01   >.
        ldh     (0efh),a        ; 0d05 e0 ef   `o
        jr      l0d13           ; 0d07 18 0a   ..

l0d09:  cp      0aah            ; 0d09 fe aa   .*
        jr      nz,l0d13        ; 0d0b 20 06    .
        ldh     a,(0d0h)        ; 0d0d f0 d0   pP
        cp      77h             ; 0d0f fe 77   .w
        jr      z,l0d03         ; 0d11 28 f0   (p
l0d13:  ld      b,34h           ; 0d13 06 34   .4
        ld      c,43h           ; 0d15 0e 43   .C
        call    l113f           ; 0d17 cd 3f 11   M?.
        xor     a               ; 0d1a af   /
        ldh     (0e3h),a        ; 0d1b e0 e3   `c
        ldh     a,(0d1h)        ; 0d1d f0 d1   pQ
        cp      0aah            ; 0d1f fe aa   .*
        ld      a,1eh           ; 0d21 3e 1e   >.
        jr      nz,l0d27        ; 0d23 20 02    .
        ld      a,1dh           ; 0d25 3e 1d   >.
l0d27:  ldh     (0e1h),a        ; 0d27 e0 e1   `a
        ld      a,28h           ; 0d29 3e 28   >(
        ldh     (0a6h),a        ; 0d2b e0 a6   `&
        ld      a,1dh           ; 0d2d 3e 1d   >.
        ldh     (0c6h),a        ; 0d2f e0 c6   `F
        ret                     ; 0d31 c9   I

l0d32:  ldh     a,(0a6h)        ; 0d32 f0 a6   p&
        and     a               ; 0d34 a7   '
        ret     nz              ; 0d35 c0   @
        ldh     a,(0efh)        ; 0d36 f0 ef   po
        and     a               ; 0d38 a7   '
        jr      nz,l0d40        ; 0d39 20 05    .
        ldh     a,(0d7h)        ; 0d3b f0 d7   pW
        inc     a               ; 0d3d 3c   <
        ldh     (0d7h),a        ; 0d3e e0 d7   `W
l0d40:  call    l0f6f           ; 0d40 cd 6f 0f   Mo.
        ld      de,l26f9        ; 0d43 11 f9 26   .y&
        ldh     a,(0cbh)        ; 0d46 f0 cb   pK
        cp      29h             ; 0d48 fe 29   .)
        jr      z,l0d4f         ; 0d4a 28 03   (.
        ld      de,l270b        ; 0d4c 11 0b 27   ..'
l0d4f:  ld      hl,0c200h       ; 0d4f 21 00 c2   !.B
        ld      c,3             ; 0d52 0e 03   ..
        call    l1776           ; 0d54 cd 76 17   Mv.
        ld      a,19h           ; 0d57 3e 19   >.
        ldh     (0a6h),a        ; 0d59 e0 a6   `&
        ldh     a,(0efh)        ; 0d5b f0 ef   po
        and     a               ; 0d5d a7   '
        jr      z,l0d65         ; 0d5e 28 05   (.
        ld      hl,0c220h       ; 0d60 21 20 c2   ! B
        ld      (hl),80h        ; 0d63 36 80   6.
l0d65:  ld      a,3             ; 0d65 3e 03   >.
        call    l2673           ; 0d67 cd 73 26   Ms&
        ld      a,20h           ; 0d6a 3e 20   > 
        ldh     (0e1h),a        ; 0d6c e0 e1   `a
        ld      a,9             ; 0d6e 3e 09   >.
        ld      (0dfe8h),a      ; 0d70 ea e8 df   jh_
        ldh     a,(0d7h)        ; 0d73 f0 d7   pW
        cp      5               ; 0d75 fe 05   ..
        ret     nz              ; 0d77 c0   @
        ld      a,11h           ; 0d78 3e 11   >.
        ld      (0dfe8h),a      ; 0d7a ea e8 df   jh_
        ret                     ; 0d7d c9   I

l0d7e:  ldh     a,(0d7h)        ; 0d7e f0 d7   pW
        cp      5               ; 0d80 fe 05   ..
        jr      nz,l0d8b        ; 0d82 20 07    .
        ldh     a,(0c6h)        ; 0d84 f0 c6   pF
        and     a               ; 0d86 a7   '
        jr      z,l0d91         ; 0d87 28 08   (.
        jr      l0dad           ; 0d89 18 22   ."

l0d8b:  ldh     a,(81h)         ; 0d8b f0 81   p.
        bit     3,a             ; 0d8d cb 5f   K_
        jr      z,l0dad         ; 0d8f 28 1c   (.
l0d91:  ld      a,60h           ; 0d91 3e 60   >`
        ldh     (0cfh),a        ; 0d93 e0 cf   `O
        ldh     (0ceh),a        ; 0d95 e0 ce   `N
        jr      l0db6           ; 0d97 18 1d   ..

l0d99:  ld      a,1             ; 0d99 3e 01   >.
        ldh     (0ffh),a        ; 0d9b e0 ff   `.
        ldh     a,(0cch)        ; 0d9d f0 cc   pL
        jr      z,l0dad         ; 0d9f 28 0c   (.
        ldh     a,(0cbh)        ; 0da1 f0 cb   pK
        cp      29h             ; 0da3 fe 29   .)
        jr      z,l0d7e         ; 0da5 28 d7   (W
        ldh     a,(0d0h)        ; 0da7 f0 d0   pP
        cp      60h             ; 0da9 fe 60   .`
        jr      z,l0db6         ; 0dab 28 09   (.
l0dad:  call    l0dbd           ; 0dad cd bd 0d   M=.
        ld      a,3             ; 0db0 3e 03   >.
        call    l2673           ; 0db2 cd 73 26   Ms&
        ret                     ; 0db5 c9   I

l0db6:  ld      a,1fh           ; 0db6 3e 1f   >.
        ldh     (0e1h),a        ; 0db8 e0 e1   `a
        ldh     (0cch),a        ; 0dba e0 cc   `L
        ret                     ; 0dbc c9   I

l0dbd:  ldh     a,(0a6h)        ; 0dbd f0 a6   p&
        and     a               ; 0dbf a7   '
        jr      nz,l0de5        ; 0dc0 20 23    #
        ld      hl,0ffc6h       ; 0dc2 21 c6 ff   !F.
        dec     (hl)            ; 0dc5 35   5
        ld      a,19h           ; 0dc6 3e 19   >.
        ldh     (0a6h),a        ; 0dc8 e0 a6   `&
        call    l0f60           ; 0dca cd 60 0f   M`.
        ld      hl,0c201h       ; 0dcd 21 01 c2   !.B
        ld      a,(hl)          ; 0dd0 7e   .
        xor     30h             ; 0dd1 ee 30   n0
        ldi     (hl),a          ; 0dd3 22   "
        cp      60h             ; 0dd4 fe 60   .`
        call    z,l0f17         ; 0dd6 cc 17 0f   L..
        inc     l               ; 0dd9 2c   ,
        push    af              ; 0dda f5   u
        ld      a,(hl)          ; 0ddb 7e   .
        xor     1               ; 0ddc ee 01   n.
        ld      (hl),a          ; 0dde 77   w
        ld      l,13h           ; 0ddf 2e 13   ..
        ldd     (hl),a          ; 0de1 32   2
        pop     af              ; 0de2 f1   q
        dec     l               ; 0de3 2d   -
        ld      (hl),a          ; 0de4 77   w
l0de5:  ldh     a,(0d7h)        ; 0de5 f0 d7   pW
        cp      5               ; 0de7 fe 05   ..
        jr      nz,l0e13        ; 0de9 20 28    (
        ldh     a,(0c6h)        ; 0deb f0 c6   pF
        ld      hl,0c221h       ; 0ded 21 21 c2   !!B
        cp      6               ; 0df0 fe 06   ..
        jr      z,l0e0f         ; 0df2 28 1b   (.
        cp      8               ; 0df4 fe 08   ..
        jr      nc,l0e13        ; 0df6 30 1b   0.
        ld      a,(hl)          ; 0df8 7e   .
        cp      72h             ; 0df9 fe 72   .r
        jr      nc,l0e03        ; 0dfb 30 06   0.
        cp      69h             ; 0dfd fe 69   .i
        ret     z               ; 0dff c8   H
        inc     (hl)            ; 0e00 34   4
        inc     (hl)            ; 0e01 34   4
        ret                     ; 0e02 c9   I

l0e03:  ld      (hl),69h        ; 0e03 36 69   6i
        inc     l               ; 0e05 2c   ,
        inc     l               ; 0e06 2c   ,
        ld      (hl),57h        ; 0e07 36 57   6W
        ld      a,6             ; 0e09 3e 06   >.
        ld      (0dfe0h),a      ; 0e0b ea e0 df   j`_
        ret                     ; 0e0e c9   I

l0e0f:  dec     l               ; 0e0f 2d   -
        ld      (hl),80h        ; 0e10 36 80   6.
        ret                     ; 0e12 c9   I

l0e13:  ldh     a,(0a7h)        ; 0e13 f0 a7   p'
        and     a               ; 0e15 a7   '
        ret     nz              ; 0e16 c0   @
        ld      a,0fh           ; 0e17 3e 0f   >.
        ldh     (0a7h),a        ; 0e19 e0 a7   `'
        ld      hl,0c223h       ; 0e1b 21 23 c2   !#B
        ld      a,(hl)          ; 0e1e 7e   .
        xor     1               ; 0e1f ee 01   n.
        ld      (hl),a          ; 0e21 77   w
        ret                     ; 0e22 c9   I

l0e23:  ldh     a,(0a6h)        ; 0e23 f0 a6   p&
        and     a               ; 0e25 a7   '
        ret     nz              ; 0e26 c0   @
        ldh     a,(0efh)        ; 0e27 f0 ef   po
        and     a               ; 0e29 a7   '
        jr      nz,l0e31        ; 0e2a 20 05    .
        ldh     a,(0d8h)        ; 0e2c f0 d8   pX
        inc     a               ; 0e2e 3c   <
        ldh     (0d8h),a        ; 0e2f e0 d8   `X
l0e31:  call    l0f6f           ; 0e31 cd 6f 0f   Mo.
        ld      de,l271d        ; 0e34 11 1d 27   ..'
        ldh     a,(0cbh)        ; 0e37 f0 cb   pK
        cp      29h             ; 0e39 fe 29   .)
        jr      z,l0e40         ; 0e3b 28 03   (.
        ld      de,l2729        ; 0e3d 11 29 27   .)'
l0e40:  ld      hl,0c200h       ; 0e40 21 00 c2   !.B
        ld      c,2             ; 0e43 0e 02   ..
        call    l1776           ; 0e45 cd 76 17   Mv.
        ld      a,19h           ; 0e48 3e 19   >.
        ldh     (0a6h),a        ; 0e4a e0 a6   `&
        ldh     a,(0efh)        ; 0e4c f0 ef   po
        and     a               ; 0e4e a7   '
        jr      z,l0e56         ; 0e4f 28 05   (.
        ld      hl,0c210h       ; 0e51 21 10 c2   !.B
        ld      (hl),80h        ; 0e54 36 80   6.
l0e56:  ld      a,2             ; 0e56 3e 02   >.
        call    l2673           ; 0e58 cd 73 26   Ms&
        ld      a,21h           ; 0e5b 3e 21   >!
        ldh     (0e1h),a        ; 0e5d e0 e1   `a
        ld      a,9             ; 0e5f 3e 09   >.
        ld      (0dfe8h),a      ; 0e61 ea e8 df   jh_
        ldh     a,(0d8h)        ; 0e64 f0 d8   pX
        cp      5               ; 0e66 fe 05   ..
        ret     nz              ; 0e68 c0   @
        ld      a,11h           ; 0e69 3e 11   >.
        ld      (0dfe8h),a      ; 0e6b ea e8 df   jh_
        ret                     ; 0e6e c9   I

l0e6f:  ldh     a,(0d8h)        ; 0e6f f0 d8   pX
        cp      5               ; 0e71 fe 05   ..
        jr      nz,l0e7c        ; 0e73 20 07    .
        ldh     a,(0c6h)        ; 0e75 f0 c6   pF
        and     a               ; 0e77 a7   '
        jr      z,l0e82         ; 0e78 28 08   (.
        jr      l0e9e           ; 0e7a 18 22   ."

l0e7c:  ldh     a,(81h)         ; 0e7c f0 81   p.
        bit     3,a             ; 0e7e cb 5f   K_
        jr      z,l0e9e         ; 0e80 28 1c   (.
l0e82:  ld      a,60h           ; 0e82 3e 60   >`
        ldh     (0cfh),a        ; 0e84 e0 cf   `O
        ldh     (0ceh),a        ; 0e86 e0 ce   `N
        jr      l0ea7           ; 0e88 18 1d   ..

l0e8a:  ld      a,1             ; 0e8a 3e 01   >.
        ldh     (0ffh),a        ; 0e8c e0 ff   `.
        ldh     a,(0cch)        ; 0e8e f0 cc   pL
        jr      z,l0e9e         ; 0e90 28 0c   (.
        ldh     a,(0cbh)        ; 0e92 f0 cb   pK
        cp      29h             ; 0e94 fe 29   .)
        jr      z,l0e6f         ; 0e96 28 d7   (W
        ldh     a,(0d0h)        ; 0e98 f0 d0   pP
        cp      60h             ; 0e9a fe 60   .`
        jr      z,l0ea7         ; 0e9c 28 09   (.
l0e9e:  call    l0eae           ; 0e9e cd ae 0e   M..
        ld      a,2             ; 0ea1 3e 02   >.
        call    l2673           ; 0ea3 cd 73 26   Ms&
        ret                     ; 0ea6 c9   I

l0ea7:  ld      a,1fh           ; 0ea7 3e 1f   >.
        ldh     (0e1h),a        ; 0ea9 e0 e1   `a
        ldh     (0cch),a        ; 0eab e0 cc   `L
        ret                     ; 0ead c9   I

l0eae:  ldh     a,(0a6h)        ; 0eae f0 a6   p&
        and     a               ; 0eb0 a7   '
        jr      nz,l0ecf        ; 0eb1 20 1c    .
        ld      hl,0ffc6h       ; 0eb3 21 c6 ff   !F.
        dec     (hl)            ; 0eb6 35   5
        ld      a,19h           ; 0eb7 3e 19   >.
        ldh     (0a6h),a        ; 0eb9 e0 a6   `&
        call    l0f60           ; 0ebb cd 60 0f   M`.
        ld      hl,0c211h       ; 0ebe 21 11 c2   !.B
        ld      a,(hl)          ; 0ec1 7e   .
        xor     8               ; 0ec2 ee 08   n.
        ldi     (hl),a          ; 0ec4 22   "
        cp      68h             ; 0ec5 fe 68   .h
        call    z,l0f17         ; 0ec7 cc 17 0f   L..
        inc     l               ; 0eca 2c   ,
        ld      a,(hl)          ; 0ecb 7e   .
        xor     1               ; 0ecc ee 01   n.
        ld      (hl),a          ; 0ece 77   w
l0ecf:  ldh     a,(0d8h)        ; 0ecf f0 d8   pX
        cp      5               ; 0ed1 fe 05   ..
        jr      nz,l0f07        ; 0ed3 20 32    2
        ldh     a,(0c6h)        ; 0ed5 f0 c6   pF
        ld      hl,0c201h       ; 0ed7 21 01 c2   !.B
        cp      5               ; 0eda fe 05   ..
        jr      z,l0f03         ; 0edc 28 25   (%
        cp      6               ; 0ede fe 06   ..
        jr      z,l0ef3         ; 0ee0 28 11   (.
        cp      8               ; 0ee2 fe 08   ..
        jr      nc,l0f07        ; 0ee4 30 21   0!
        ld      a,(hl)          ; 0ee6 7e   .
        cp      72h             ; 0ee7 fe 72   .r
        jr      nc,l0f03        ; 0ee9 30 18   0.
        cp      61h             ; 0eeb fe 61   .a
        ret     z               ; 0eed c8   H
        inc     (hl)            ; 0eee 34   4
        inc     (hl)            ; 0eef 34   4
        inc     (hl)            ; 0ef0 34   4
        inc     (hl)            ; 0ef1 34   4
        ret                     ; 0ef2 c9   I

l0ef3:  dec     l               ; 0ef3 2d   -
        ld      (hl),0          ; 0ef4 36 00   6.
        inc     l               ; 0ef6 2c   ,
        ld      (hl),61h        ; 0ef7 36 61   6a
        inc     l               ; 0ef9 2c   ,
        inc     l               ; 0efa 2c   ,
        ld      (hl),56h        ; 0efb 36 56   6V
        ld      a,6             ; 0efd 3e 06   >.
        ld      (0dfe0h),a      ; 0eff ea e0 df   j`_
        ret                     ; 0f02 c9   I

l0f03:  dec     l               ; 0f03 2d   -
        ld      (hl),80h        ; 0f04 36 80   6.
        ret                     ; 0f06 c9   I

l0f07:  ldh     a,(0a7h)        ; 0f07 f0 a7   p'
        and     a               ; 0f09 a7   '
        ret     nz              ; 0f0a c0   @
        ld      a,0fh           ; 0f0b 3e 0f   >.
        ldh     (0a7h),a        ; 0f0d e0 a7   `'
        ld      hl,0c203h       ; 0f0f 21 03 c2   !.B
        ld      a,(hl)          ; 0f12 7e   .
        xor     1               ; 0f13 ee 01   n.
        ld      (hl),a          ; 0f15 77   w
        ret                     ; 0f16 c9   I

l0f17:  push    af              ; 0f17 f5   u
        push    hl              ; 0f18 e5   e
        ldh     a,(0d7h)        ; 0f19 f0 d7   pW
        cp      5               ; 0f1b fe 05   ..
        jr      z,l0f39         ; 0f1d 28 1a   (.
        ldh     a,(0d8h)        ; 0f1f f0 d8   pX
        cp      5               ; 0f21 fe 05   ..
        jr      z,l0f39         ; 0f23 28 14   (.
        ldh     a,(0cbh)        ; 0f25 f0 cb   pK
        cp      29h             ; 0f27 fe 29   .)
        jr      nz,l0f39        ; 0f29 20 0e    .
        ld      hl,0c060h       ; 0f2b 21 60 c0   !`@
        ld      b,24h           ; 0f2e 06 24   .$
        ld      de,l0f3c        ; 0f30 11 3c 0f   .<.
l0f33:  ld      a,(de)          ; 0f33 1a   .
        ldi     (hl),a          ; 0f34 22   "
        inc     de              ; 0f35 13   .
        dec     b               ; 0f36 05   .
        jr      nz,l0f33        ; 0f37 20 fa    z
l0f39:  pop     hl              ; 0f39 e1   a
        pop     af              ; 0f3a f1   q
        ret                     ; 0f3b c9   I

l0f3c:  .db     42h,30h,0dh,0,42h,38h,0b2h,0,42h,40h,0eh,0,42h,48h      ; 0f3c 42 30 0d 00 42 38 b2 00 42 40 0e 00 42 48   B0..B82.B@..BH
        .db     1ch,0,42h,58h,0eh,0,42h,60h,1dh,0,42h,68h,0b5h,0,42h,70h        ; 0f4a 1c 00 42 58 0e 00 42 60 1d 00 42 68 b5 00 42 70   ..BX..B`..Bh5.Bp
        .db     0bbh,0,42h,78h,1dh,0    ; 0f5a bb 00 42 78 1d 00   ;.Bx..

l0f60:  ld      hl,0c060h       ; 0f60 21 60 c0   !`@
        ld      de,4            ; 0f63 11 04 00   ...
        ld      b,9             ; 0f66 06 09   ..
        xor     a               ; 0f68 af   /
l0f69:  ld      (hl),a          ; 0f69 77   w
        add     hl,de           ; 0f6a 19   .
        dec     b               ; 0f6b 05   .
        jr      nz,l0f69        ; 0f6c 20 fb    {
        ret                     ; 0f6e c9   I

l0f6f:  call    l2820           ; 0f6f cd 20 28   M (
        ld      hl,l55ac        ; 0f72 21 ac 55   !,U
        ld      bc,1000h        ; 0f75 01 00 10   ...
        call    l27e4           ; 0f78 cd e4 27   Md'
        call    l2795           ; 0f7b cd 95 27   M.'
        ld      hl,9800h        ; 0f7e 21 00 98   !..
        ld      de,l54e4        ; 0f81 11 e4 54   .dT
        ld      b,4             ; 0f84 06 04   ..
        call    l27f0           ; 0f86 cd f0 27   Mp'
        ld      hl,9980h        ; 0f89 21 80 99   !..
        ld      b,6             ; 0f8c 06 06   ..
        call    l27f0           ; 0f8e cd f0 27   Mp'
        ldh     a,(0cbh)        ; 0f91 f0 cb   pK
        cp      29h             ; 0f93 fe 29   .)
        jr      nz,l0fb9        ; 0f95 20 22    "
        ld      hl,9841h        ; 0f97 21 41 98   !A.
        ld      (hl),0bdh       ; 0f9a 36 bd   6=
        inc     l               ; 0f9c 2c   ,
        ld      (hl),0b2h       ; 0f9d 36 b2   62
        inc     l               ; 0f9f 2c   ,
        ld      (hl),2eh        ; 0fa0 36 2e   6.
        inc     l               ; 0fa2 2c   ,
        ld      (hl),0beh       ; 0fa3 36 be   6>
        inc     l               ; 0fa5 2c   ,
        ld      (hl),2eh        ; 0fa6 36 2e   6.
        ld      hl,9a01h        ; 0fa8 21 01 9a   !..
        ld      (hl),0b4h       ; 0fab 36 b4   64
        inc     l               ; 0fad 2c   ,
        ld      (hl),0b5h       ; 0fae 36 b5   65
        inc     l               ; 0fb0 2c   ,
        ld      (hl),0bbh       ; 0fb1 36 bb   6;
        inc     l               ; 0fb3 2c   ,
        ld      (hl),2eh        ; 0fb4 36 2e   6.
        inc     l               ; 0fb6 2c   ,
        ld      (hl),0bch       ; 0fb7 36 bc   6<
l0fb9:  ldh     a,(0efh)        ; 0fb9 f0 ef   po
        and     a               ; 0fbb a7   '
        jr      nz,l0fc1        ; 0fbc 20 03    .
        call    l1085           ; 0fbe cd 85 10   M..
l0fc1:  ldh     a,(0d7h)        ; 0fc1 f0 d7   pW
        and     a               ; 0fc3 a7   '
        jr      z,l100f         ; 0fc4 28 49   (I
        cp      5               ; 0fc6 fe 05   ..
        jr      nz,l0fe0        ; 0fc8 20 16    .
        ld      hl,98a5h        ; 0fca 21 a5 98   !%.
        ld      b,0bh           ; 0fcd 06 0b   ..
        ldh     a,(0cbh)        ; 0fcf f0 cb   pK
        cp      29h             ; 0fd1 fe 29   .)
        ld      de,l10f3        ; 0fd3 11 f3 10   .s.
        jr      z,l0fdb         ; 0fd6 28 03   (.
        ld      de,l10fe        ; 0fd8 11 fe 10   ...
l0fdb:  call    l10d8           ; 0fdb cd d8 10   MX.
        ld      a,4             ; 0fde 3e 04   >.
l0fe0:  ld      c,a             ; 0fe0 4f   O
        ldh     a,(0cbh)        ; 0fe1 f0 cb   pK
        cp      29h             ; 0fe3 fe 29   .)
        ld      a,93h           ; 0fe5 3e 93   >.
        jr      nz,l0feb        ; 0fe7 20 02    .
        ld      a,8fh           ; 0fe9 3e 8f   >.
l0feb:  ldh     (0a0h),a        ; 0feb e0 a0   ` 
        ld      hl,99e7h        ; 0fed 21 e7 99   !g.
        call    l106a           ; 0ff0 cd 6a 10   Mj.
        ldh     a,(0d9h)        ; 0ff3 f0 d9   pY
        and     a               ; 0ff5 a7   '
        jr      z,l100f         ; 0ff6 28 17   (.
        ld      a,0ach          ; 0ff8 3e ac   >,
        ldh     (0a0h),a        ; 0ffa e0 a0   ` 
        ld      hl,99f0h        ; 0ffc 21 f0 99   !p.
        ld      c,1             ; 0fff 0e 01   ..
        call    l106a           ; 1001 cd 6a 10   Mj.
        ld      hl,98a6h        ; 1004 21 a6 98   !&.
        ld      de,l1109        ; 1007 11 09 11   ...
        ld      b,9             ; 100a 06 09   ..
        call    l10d8           ; 100c cd d8 10   MX.
l100f:  ldh     a,(0d8h)        ; 100f f0 d8   pX
        and     a               ; 1011 a7   '
        jr      z,l1052         ; 1012 28 3e   (>
        cp      5               ; 1014 fe 05   ..
        jr      nz,l102e        ; 1016 20 16    .
        ld      hl,98a5h        ; 1018 21 a5 98   !%.
        ld      b,0bh           ; 101b 06 0b   ..
        ldh     a,(0cbh)        ; 101d f0 cb   pK
        cp      29h             ; 101f fe 29   .)
        ld      de,l10fe        ; 1021 11 fe 10   ...
        jr      z,l1029         ; 1024 28 03   (.
        ld      de,l10f3        ; 1026 11 f3 10   .s.
l1029:  call    l10d8           ; 1029 cd d8 10   MX.
        ld      a,4             ; 102c 3e 04   >.
l102e:  ld      c,a             ; 102e 4f   O
        ldh     a,(0cbh)        ; 102f f0 cb   pK
        cp      29h             ; 1031 fe 29   .)
        ld      a,8fh           ; 1033 3e 8f   >.
        jr      nz,l1039        ; 1035 20 02    .
        ld      a,93h           ; 1037 3e 93   >.
l1039:  ldh     (0a0h),a        ; 1039 e0 a0   ` 
        ld      hl,9827h        ; 103b 21 27 98   !'.
        call    l106a           ; 103e cd 6a 10   Mj.
        ldh     a,(0dah)        ; 1041 f0 da   pZ
        and     a               ; 1043 a7   '
        jr      z,l1052         ; 1044 28 0c   (.
        ld      a,0ach          ; 1046 3e ac   >,
        ldh     (0a0h),a        ; 1048 e0 a0   ` 
        ld      hl,9830h        ; 104a 21 30 98   !0.
        ld      c,1             ; 104d 0e 01   ..
        call    l106a           ; 104f cd 6a 10   Mj.
l1052:  ldh     a,(0dbh)        ; 1052 f0 db   p[
        and     a               ; 1054 a7   '
        jr      z,l1062         ; 1055 28 0b   (.
        ld      hl,98a7h        ; 1057 21 a7 98   !'.
        ld      de,l10ed        ; 105a 11 ed 10   .m.
        ld      b,6             ; 105d 06 06   ..
        call    l10d8           ; 105f cd d8 10   MX.
l1062:  ld      a,0d3h          ; 1062 3e d3   >S
        ldh     (40h),a         ; 1064 e0 40   `@
        call    l178a           ; 1066 cd 8a 17   M..
        ret                     ; 1069 c9   I

l106a:  ldh     a,(0a0h)        ; 106a f0 a0   p 
        push    hl              ; 106c e5   e
        ld      de,20h          ; 106d 11 20 00   . .
        ld      b,2             ; 1070 06 02   ..
l1072:  push    hl              ; 1072 e5   e
        ldi     (hl),a          ; 1073 22   "
        inc     a               ; 1074 3c   <
        ld      (hl),a          ; 1075 77   w
        inc     a               ; 1076 3c   <
        pop     hl              ; 1077 e1   a
        add     hl,de           ; 1078 19   .
        dec     b               ; 1079 05   .
        jr      nz,l1072        ; 107a 20 f6    v
        pop     hl              ; 107c e1   a
        ld      de,3            ; 107d 11 03 00   ...
        add     hl,de           ; 1080 19   .
        dec     c               ; 1081 0d   .
        jr      nz,l106a        ; 1082 20 e6    f
        ret                     ; 1084 c9   I

l1085:  ld      hl,0ffd7h       ; 1085 21 d7 ff   !W.
        ld      de,0ffd8h       ; 1088 11 d8 ff   .X.
        ldh     a,(0d9h)        ; 108b f0 d9   pY
        and     a               ; 108d a7   '
        jr      nz,l10ca        ; 108e 20 3a    :
        ldh     a,(0dah)        ; 1090 f0 da   pZ
        and     a               ; 1092 a7   '
        jr      nz,l10d1        ; 1093 20 3c    <
        ldh     a,(0dbh)        ; 1095 f0 db   p[
        and     a               ; 1097 a7   '
        jr      nz,l10bb        ; 1098 20 21    !
        ld      a,(hl)          ; 109a 7e   .
        cp      4               ; 109b fe 04   ..
        jr      z,l10b0         ; 109d 28 11   (.
        ld      a,(de)          ; 109f 1a   .
        cp      4               ; 10a0 fe 04   ..
        ret     nz              ; 10a2 c0   @
l10a3:  ld      a,5             ; 10a3 3e 05   >.
        ld      (de),a          ; 10a5 12   .
        jr      l10b2           ; 10a6 18 0a   ..

; The next 3 instructions are not used.
        ld      a,(de)          ; 10a8 1a   .
        cp      3               ; 10a9 fe 03   ..
        ret     nz              ; 10ab c0   @
l10ac:  ld      a,3             ; 10ac 3e 03   >.
        jr      l10b5           ; 10ae 18 05   ..

l10b0:  ld      (hl),5          ; 10b0 36 05   6.
l10b2:  xor     a               ; 10b2 af   /
        ldh     (0dbh),a        ; 10b3 e0 db   `[
l10b5:  xor     a               ; 10b5 af   /
        ldh     (0d9h),a        ; 10b6 e0 d9   `Y
        ldh     (0dah),a        ; 10b8 e0 da   `Z
        ret                     ; 10ba c9   I

l10bb:  ld      a,(hl)          ; 10bb 7e   .
        cp      4               ; 10bc fe 04   ..
        jr      nz,l10c6        ; 10be 20 06    .
        ldh     (0d9h),a        ; 10c0 e0 d9   `Y
l10c2:  xor     a               ; 10c2 af   /
        ldh     (0dbh),a        ; 10c3 e0 db   `[
        ret                     ; 10c5 c9   I

l10c6:  ldh     (0dah),a        ; 10c6 e0 da   `Z
        jr      l10c2           ; 10c8 18 f8   .x

l10ca:  ld      a,(hl)          ; 10ca 7e   .
        cp      5               ; 10cb fe 05   ..
        jr      z,l10b0         ; 10cd 28 e1   (a
        jr      l10ac           ; 10cf 18 db   .[

l10d1:  ld      a,(de)          ; 10d1 1a   .
        cp      5               ; 10d2 fe 05   ..
        jr      z,l10a3         ; 10d4 28 cd   (M
        jr      l10ac           ; 10d6 18 d4   .T

l10d8:  push    bc              ; 10d8 c5   E
        push    hl              ; 10d9 e5   e
l10da:  ld      a,(de)          ; 10da 1a   .
        ldi     (hl),a          ; 10db 22   "
        inc     de              ; 10dc 13   .
        dec     b               ; 10dd 05   .
        jr      nz,l10da        ; 10de 20 fa    z
        pop     hl              ; 10e0 e1   a
        ld      de,20h          ; 10e1 11 20 00   . .
        add     hl,de           ; 10e4 19   .
        pop     bc              ; 10e5 c1   A
        ld      a,0b6h          ; 10e6 3e b6   >6
l10e8:  ldi     (hl),a          ; 10e8 22   "
        dec     b               ; 10e9 05   .
        jr      nz,l10e8        ; 10ea 20 fc    |
        ret                     ; 10ec c9   I

l10ed:  .db     0b0h,0b1h,0b2h,0b3h,0b1h,3eh    ; 10ed b0 b1 b2 b3 b1 3e   01231>
l10f3:  .db     0b4h,0b5h,0bbh,2eh,0bch,2fh,2dh,2eh,3dh,0eh,3eh ; 10f3 b4 b5 bb 2e bc 2f 2d 2e 3d 0e 3e   45;.</-.=.>
l10fe:  .db     0bdh,0b2h,2eh,0beh,2eh,2fh,2dh,2eh,3dh,0eh,3eh  ; 10fe bd b2 2e be 2e 2f 2d 2e 3d 0e 3e   =2.>./-.=.>
l1109:  .db     0b5h,0b0h,41h,0b5h,3dh,1dh,0b5h,0beh,0b1h       ; 1109 b5 b0 41 b5 3d 1d b5 be b1   50A5=.5>1

l1112:  ld      a,1             ; 1112 3e 01   >.
        ldh     (0ffh),a        ; 1114 e0 ff   `.
        ldh     a,(0a6h)        ; 1116 f0 a6   p&
        and     a               ; 1118 a7   '
        ret     nz              ; 1119 c0   @
        call    l178a           ; 111a cd 8a 17   M..
        xor     a               ; 111d af   /
        ldh     (0efh),a        ; 111e e0 ef   `o
        ld      b,27h           ; 1120 06 27   .'
        ld      c,79h           ; 1122 0e 79   .y
        call    l113f           ; 1124 cd 3f 11   M?.
        call    l7ff3           ; 1127 cd f3 7f   Ms.
        ldh     a,(0d7h)        ; 112a f0 d7   pW
        cp      5               ; 112c fe 05   ..
        jr      z,l113a         ; 112e 28 0a   (.
        ldh     a,(0d8h)        ; 1130 f0 d8   pX
        cp      5               ; 1132 fe 05   ..
        jr      z,l113a         ; 1134 28 04   (.
        ld      a,1             ; 1136 3e 01   >.
        ldh     (0d6h),a        ; 1138 e0 d6   `V
l113a:  ld      a,16h           ; 113a 3e 16   >.
        ldh     (0e1h),a        ; 113c e0 e1   `a
        ret                     ; 113e c9   I

l113f:  ldh     a,(0cch)        ; 113f f0 cc   pL
        and     a               ; 1141 a7   '
        jr      z,l1158         ; 1142 28 14   (.
        xor     a               ; 1144 af   /
        ldh     (0cch),a        ; 1145 e0 cc   `L
        ldh     a,(0cbh)        ; 1147 f0 cb   pK
        cp      29h             ; 1149 fe 29   .)
        ldh     a,(0d0h)        ; 114b f0 d0   pP
        jr      nz,l1160        ; 114d 20 11    .
        cp      b               ; 114f b8   8
        jr      z,l115a         ; 1150 28 08   (.
        ld      a,2             ; 1152 3e 02   >.
        ldh     (0cfh),a        ; 1154 e0 cf   `O
        ldh     (0ceh),a        ; 1156 e0 ce   `N
l1158:  pop     hl              ; 1158 e1   a
        ret                     ; 1159 c9   I

l115a:  ld      a,c             ; 115a 79   y
        ldh     (0cfh),a        ; 115b e0 cf   `O
        ldh     (0ceh),a        ; 115d e0 ce   `N
        ret                     ; 115f c9   I

l1160:  cp      c               ; 1160 b9   9
        ret     z               ; 1161 c8   H
        ld      a,b             ; 1162 78   x
        ldh     (0cfh),a        ; 1163 e0 cf   `O
        pop     hl              ; 1165 e1   a
        ret                     ; 1166 c9   I

l1167:  call    l11b2           ; 1167 cd b2 11   M2.
        ld      hl,9ce6h        ; 116a 21 e6 9c   !f.
        ld      de,l141b        ; 116d 11 1b 14   ...
        ld      b,7             ; 1170 06 07   ..
        call    l1437           ; 1172 cd 37 14   M7.
        ld      hl,9ce7h        ; 1175 21 e7 9c   !g.
        ld      de,l1422        ; 1178 11 22 14   .".
        ld      b,7             ; 117b 06 07   ..
        call    l1437           ; 117d cd 37 14   M7.
        ld      hl,9d08h        ; 1180 21 08 9d   !..
        ld      (hl),72h        ; 1183 36 72   6r
        inc     l               ; 1185 2c   ,
        ld      (hl),0c4h       ; 1186 36 c4   6D
        ld      hl,9d28h        ; 1188 21 28 9d   !(.
        ld      (hl),0b7h       ; 118b 36 b7   67
        inc     l               ; 118d 2c   ,
        ld      (hl),0b8h       ; 118e 36 b8   68
        ld      de,l2771        ; 1190 11 71 27   .q'
        ld      hl,0c200h       ; 1193 21 00 c2   !.B
        ld      c,3             ; 1196 0e 03   ..
        call    l1776           ; 1198 cd 76 17   Mv.
        ld      a,3             ; 119b 3e 03   >.
        call    l2673           ; 119d cd 73 26   Ms&
        ld      a,0dbh          ; 11a0 3e db   >[
        ldh     (40h),a         ; 11a2 e0 40   `@
        ld      a,0bbh          ; 11a4 3e bb   >;
        ldh     (0a6h),a        ; 11a6 e0 a6   `&
        ld      a,27h           ; 11a8 3e 27   >'
        ldh     (0e1h),a        ; 11aa e0 e1   `a
        ld      a,10h           ; 11ac 3e 10   >.
        ld      (0dfe8h),a      ; 11ae ea e8 df   jh_
        ret                     ; 11b1 c9   I

l11b2:  call    l2820           ; 11b2 cd 20 28   M (
        ld      hl,l55ac        ; 11b5 21 ac 55   !,U
        ld      bc,1000h        ; 11b8 01 00 10   ...
        call    l27e4           ; 11bb cd e4 27   Md'
        ld      hl,9fffh        ; 11be 21 ff 9f   !..
        call    l2798           ; 11c1 cd 98 27   M.'
        ld      hl,9dc0h        ; 11c4 21 c0 9d   !@.
        ld      de,l51c4        ; 11c7 11 c4 51   .DQ
        ld      b,4             ; 11ca 06 04   ..
        call    l27f0           ; 11cc cd f0 27   Mp'
        ld      hl,9cech        ; 11cf 21 ec 9c   !l.
        ld      de,l1429        ; 11d2 11 29 14   .).
        ld      b,7             ; 11d5 06 07   ..
        call    l1437           ; 11d7 cd 37 14   M7.
        ld      hl,9cedh        ; 11da 21 ed 9c   !m.
        ld      de,l1430        ; 11dd 11 30 14   .0.
        ld      b,7             ; 11e0 06 07   ..
        call    l1437           ; 11e2 cd 37 14   M7.
        ret                     ; 11e5 c9   I

l11e6:  ldh     a,(0a6h)        ; 11e6 f0 a6   p&
        and     a               ; 11e8 a7   '
        ret     nz              ; 11e9 c0   @
        ld      hl,0c210h       ; 11ea 21 10 c2   !.B
        ld      (hl),0          ; 11ed 36 00   6.
        ld      l,20h           ; 11ef 2e 20   . 
        ld      (hl),0          ; 11f1 36 00   6.
        ld      a,0ffh          ; 11f3 3e ff   >.
        ldh     (0a6h),a        ; 11f5 e0 a6   `&
        ld      a,28h           ; 11f7 3e 28   >(
        ldh     (0e1h),a        ; 11f9 e0 e1   `a
        ret                     ; 11fb c9   I

l11fc:  ldh     a,(0a6h)        ; 11fc f0 a6   p&
        and     a               ; 11fe a7   '
        jr      z,l1205         ; 11ff 28 04   (.
        call    l13fa           ; 1201 cd fa 13   Mz.
        ret                     ; 1204 c9   I

l1205:  ld      a,29h           ; 1205 3e 29   >)
        ldh     (0e1h),a        ; 1207 e0 e1   `a
        ld      hl,0c213h       ; 1209 21 13 c2   !.B
        ld      (hl),35h        ; 120c 36 35   65
        ld      l,23h           ; 120e 2e 23   .#
        ld      (hl),35h        ; 1210 36 35   65
        ld      a,0ffh          ; 1212 3e ff   >.
        ldh     (0a6h),a        ; 1214 e0 a6   `&
        ld      a,2fh           ; 1216 3e 2f   >/
        call    l1fd7           ; 1218 cd d7 1f   MW.
        ret                     ; 121b c9   I

l121c:  ldh     a,(0a6h)        ; 121c f0 a6   p&
        and     a               ; 121e a7   '
        jr      z,l1225         ; 121f 28 04   (.
        call    l13fa           ; 1221 cd fa 13   Mz.
        ret                     ; 1224 c9   I

l1225:  ld      a,2             ; 1225 3e 02   >.
        ldh     (0e1h),a        ; 1227 e0 e1   `a
        ld      hl,9d08h        ; 1229 21 08 9d   !..
        ld      b,2fh           ; 122c 06 2f   ./
        call    l19ff           ; 122e cd ff 19   M..
        ld      hl,9d09h        ; 1231 21 09 9d   !..
        call    l19ff           ; 1234 cd ff 19   M..
        ld      hl,9d28h        ; 1237 21 28 9d   !(.
        call    l19ff           ; 123a cd ff 19   M..
        ld      hl,9d29h        ; 123d 21 29 9d   !).
        call    l19ff           ; 1240 cd ff 19   M..
        ret                     ; 1243 c9   I

l1244:  ldh     a,(0a6h)        ; 1244 f0 a6   p&
        and     a               ; 1246 a7   '
        jr      nz,l1277        ; 1247 20 2e    .
        ld      a,0ah           ; 1249 3e 0a   >.
        ldh     (0a6h),a        ; 124b e0 a6   `&
        ld      hl,0c201h       ; 124d 21 01 c2   !.B
        dec     (hl)            ; 1250 35   5
        ld      a,(hl)          ; 1251 7e   .
        cp      58h             ; 1252 fe 58   .X
        jr      nz,l1277        ; 1254 20 21    !
        ld      hl,0c210h       ; 1256 21 10 c2   !.B
        ld      (hl),0          ; 1259 36 00   6.
        inc     l               ; 125b 2c   ,
        add     a,20h           ; 125c c6 20   F 
        ldi     (hl),a          ; 125e 22   "
        ld      (hl),4ch        ; 125f 36 4c   6L
        inc     l               ; 1261 2c   ,
        ld      (hl),40h        ; 1262 36 40   6@
        ld      l,20h           ; 1264 2e 20   . 
        ld      (hl),80h        ; 1266 36 80   6.
        ld      a,3             ; 1268 3e 03   >.
        call    l2673           ; 126a cd 73 26   Ms&
        ld      a,3             ; 126d 3e 03   >.
        ldh     (0e1h),a        ; 126f e0 e1   `a
        ld      a,4             ; 1271 3e 04   >.
        ld      (0dff8h),a      ; 1273 ea f8 df   jx_
        ret                     ; 1276 c9   I

l1277:  call    l13fa           ; 1277 cd fa 13   Mz.
        ret                     ; 127a c9   I

l127b:  ldh     a,(0a6h)        ; 127b f0 a6   p&
        and     a               ; 127d a7   '
        jr      nz,l129d        ; 127e 20 1d    .
        ld      a,0ah           ; 1280 3e 0a   >.
        ldh     (0a6h),a        ; 1282 e0 a6   `&
        ld      hl,0c211h       ; 1284 21 11 c2   !.B
        dec     (hl)            ; 1287 35   5
        ld      l,1             ; 1288 2e 01   ..
        dec     (hl)            ; 128a 35   5
        ld      a,(hl)          ; 128b 7e   .
        cp      0d0h            ; 128c fe d0   .P
        jr      nz,l129d        ; 128e 20 0d    .
        ld      a,9ch           ; 1290 3e 9c   >.
        ldh     (0c9h),a        ; 1292 e0 c9   `I
        ld      a,82h           ; 1294 3e 82   >.
        ldh     (0cah),a        ; 1296 e0 ca   `J
        ld      a,2ch           ; 1298 3e 2c   >,
        ldh     (0e1h),a        ; 129a e0 e1   `a
        ret                     ; 129c c9   I

l129d:  ldh     a,(0a7h)        ; 129d f0 a7   p'
        and     a               ; 129f a7   '
        jr      nz,l12ad        ; 12a0 20 0b    .
        ld      a,6             ; 12a2 3e 06   >.
        ldh     (0a7h),a        ; 12a4 e0 a7   `'
        ld      hl,0c213h       ; 12a6 21 13 c2   !.B
        ld      a,(hl)          ; 12a9 7e   .
        xor     1               ; 12aa ee 01   n.
        ld      (hl),a          ; 12ac 77   w
l12ad:  ld      a,3             ; 12ad 3e 03   >.
        call    l2673           ; 12af cd 73 26   Ms&
        ret                     ; 12b2 c9   I

l12b3:  ldh     a,(0a6h)        ; 12b3 f0 a6   p&
        and     a               ; 12b5 a7   '
        ret     nz              ; 12b6 c0   @
        ld      a,6             ; 12b7 3e 06   >.
        ldh     (0a6h),a        ; 12b9 e0 a6   `&
        ldh     a,(0cah)        ; 12bb f0 ca   pJ
        sub     82h             ; 12bd d6 82   V.
        ld      e,a             ; 12bf 5f   _
        ld      d,0             ; 12c0 16 00   ..
        ld      hl,l12f5        ; 12c2 21 f5 12   !u.
        add     hl,de           ; 12c5 19   .
        push    hl              ; 12c6 e5   e
        pop     de              ; 12c7 d1   Q
        ldh     a,(0c9h)        ; 12c8 f0 c9   pI
        ld      h,a             ; 12ca 67   g
        ldh     a,(0cah)        ; 12cb f0 ca   pJ
        ld      l,a             ; 12cd 6f   o
        ld      a,(de)          ; 12ce 1a   .
        call    l19fe           ; 12cf cd fe 19   M..
        push    hl              ; 12d2 e5   e
        ld      de,20h          ; 12d3 11 20 00   . .
        add     hl,de           ; 12d6 19   .
        ld      b,0b6h          ; 12d7 06 b6   .6
        call    l19ff           ; 12d9 cd ff 19   M..
        pop     hl              ; 12dc e1   a
        inc     hl              ; 12dd 23   #
        ld      a,2             ; 12de 3e 02   >.
        ld      (0dfe0h),a      ; 12e0 ea e0 df   j`_
        ld      a,h             ; 12e3 7c   |
        ldh     (0c9h),a        ; 12e4 e0 c9   `I
        ld      a,l             ; 12e6 7d   }
        ldh     (0cah),a        ; 12e7 e0 ca   `J
        cp      92h             ; 12e9 fe 92   ..
        ret     nz              ; 12eb c0   @
        ld      a,0ffh          ; 12ec 3e ff   >.
        ldh     (0a6h),a        ; 12ee e0 a6   `&
        ld      a,2dh           ; 12f0 3e 2d   >-
        ldh     (0e1h),a        ; 12f2 e0 e1   `a
        ret                     ; 12f4 c9   I

l12f5:  .db     0b3h,0bch,3dh,0beh,0bbh,0b5h,1dh,0b2h,0bdh,0b5h,1dh     ; 12f5 b3 bc 3d be bb b5 1d b2 bd b5 1d   3<=>;5.2=5.
        .db     2eh,0bch,3dh,0eh,3eh    ; 1300 2e bc 3d 0e 3e   .<=.>

l1305:  ldh     a,(0a6h)        ; 1305 f0 a6   p&
        and     a               ; 1307 a7   '
        ret     nz              ; 1308 c0   @
        call    l2820           ; 1309 cd 20 28   M (
        call    l27ad           ; 130c cd ad 27   M-'
        call    l2293           ; 130f cd 93 22   M."
        ld      a,93h           ; 1312 3e 93   >.
        ldh     (40h),a         ; 1314 e0 40   `@
        ld      a,5             ; 1316 3e 05   >.
        ldh     (0e1h),a        ; 1318 e0 e1   `a
        ret                     ; 131a c9   I

l131b:  ldh     a,(0a6h)        ; 131b f0 a6   p&
        and     a               ; 131d a7   '
        ret     nz              ; 131e c0   @
        ld      a,2eh           ; 131f 3e 2e   >.
        ldh     (0e1h),a        ; 1321 e0 e1   `a
        ret                     ; 1323 c9   I

l1324:  call    l11b2           ; 1324 cd b2 11   M2.
        ld      de,l2783        ; 1327 11 83 27   ..'
        ld      hl,0c200h       ; 132a 21 00 c2   !.B
        ld      c,3             ; 132d 0e 03   ..
        call    l1776           ; 132f cd 76 17   Mv.
        ldh     a,(0f3h)        ; 1332 f0 f3   ps
        ld      (0c203h),a      ; 1334 ea 03 c2   j.B
        ld      a,3             ; 1337 3e 03   >.
        call    l2673           ; 1339 cd 73 26   Ms&
        xor     a               ; 133c af   /
        ldh     (0f3h),a        ; 133d e0 f3   `s
        ld      a,0dbh          ; 133f 3e db   >[
        ldh     (40h),a         ; 1341 e0 40   `@
        ld      a,0bbh          ; 1343 3e bb   >;
        ldh     (0a6h),a        ; 1345 e0 a6   `&
        ld      a,2fh           ; 1347 3e 2f   >/
        ldh     (0e1h),a        ; 1349 e0 e1   `a
        ld      a,10h           ; 134b 3e 10   >.
        ld      (0dfe8h),a      ; 134d ea e8 df   jh_
        ret                     ; 1350 c9   I

l1351:  ldh     a,(0a6h)        ; 1351 f0 a6   p&
        and     a               ; 1353 a7   '
        ret     nz              ; 1354 c0   @
        ld      hl,0c210h       ; 1355 21 10 c2   !.B
        ld      (hl),0          ; 1358 36 00   6.
        ld      l,20h           ; 135a 2e 20   . 
        ld      (hl),0          ; 135c 36 00   6.
        ld      a,0a0h          ; 135e 3e a0   > 
        ldh     (0a6h),a        ; 1360 e0 a6   `&
        ld      a,30h           ; 1362 3e 30   >0
        ldh     (0e1h),a        ; 1364 e0 e1   `a
        ret                     ; 1366 c9   I

l1367:  ldh     a,(0a6h)        ; 1367 f0 a6   p&
        and     a               ; 1369 a7   '
        jr      z,l1370         ; 136a 28 04   (.
        call    l13fa           ; 136c cd fa 13   Mz.
        ret                     ; 136f c9   I

l1370:  ld      a,31h           ; 1370 3e 31   >1
        ldh     (0e1h),a        ; 1372 e0 e1   `a
        ld      a,80h           ; 1374 3e 80   >.
        ldh     (0a6h),a        ; 1376 e0 a6   `&
        ld      a,2fh           ; 1378 3e 2f   >/
        call    l1fd7           ; 137a cd d7 1f   MW.
        ret                     ; 137d c9   I

l137e:  ldh     a,(0a6h)        ; 137e f0 a6   p&
        and     a               ; 1380 a7   '
        jr      nz,l13b1        ; 1381 20 2e    .
        ld      a,0ah           ; 1383 3e 0a   >.
        ldh     (0a6h),a        ; 1385 e0 a6   `&
        ld      hl,0c201h       ; 1387 21 01 c2   !.B
        dec     (hl)            ; 138a 35   5
        ld      a,(hl)          ; 138b 7e   .
        cp      6ah             ; 138c fe 6a   .j
        jr      nz,l13b1        ; 138e 20 21    !
        ld      hl,0c210h       ; 1390 21 10 c2   !.B
        ld      (hl),0          ; 1393 36 00   6.
        inc     l               ; 1395 2c   ,
        add     a,10h           ; 1396 c6 10   F.
        ldi     (hl),a          ; 1398 22   "
        ld      (hl),54h        ; 1399 36 54   6T
        inc     l               ; 139b 2c   ,
        ld      (hl),5ch        ; 139c 36 5c   6\
        ld      l,20h           ; 139e 2e 20   . 
        ld      (hl),80h        ; 13a0 36 80   6.
        ld      a,3             ; 13a2 3e 03   >.
        call    l2673           ; 13a4 cd 73 26   Ms&
        ld      a,32h           ; 13a7 3e 32   >2
        ldh     (0e1h),a        ; 13a9 e0 e1   `a
        ld      a,4             ; 13ab 3e 04   >.
        ld      (0dff8h),a      ; 13ad ea f8 df   jx_
        ret                     ; 13b0 c9   I

l13b1:  call    l13fa           ; 13b1 cd fa 13   Mz.
        ret                     ; 13b4 c9   I

l13b5:  ldh     a,(0a6h)        ; 13b5 f0 a6   p&
        and     a               ; 13b7 a7   '
        jr      nz,l13cf        ; 13b8 20 15    .
        ld      a,0ah           ; 13ba 3e 0a   >.
        ldh     (0a6h),a        ; 13bc e0 a6   `&
        ld      hl,0c211h       ; 13be 21 11 c2   !.B
        dec     (hl)            ; 13c1 35   5
        ld      l,1             ; 13c2 2e 01   ..
        dec     (hl)            ; 13c4 35   5
        ld      a,(hl)          ; 13c5 7e   .
        cp      0e0h            ; 13c6 fe e0   .`
        jr      nz,l13cf        ; 13c8 20 05    .
        ld      a,33h           ; 13ca 3e 33   >3
        ldh     (0e1h),a        ; 13cc e0 e1   `a
        ret                     ; 13ce c9   I

l13cf:  ldh     a,(0a7h)        ; 13cf f0 a7   p'
        and     a               ; 13d1 a7   '
        jr      nz,l13df        ; 13d2 20 0b    .
        ld      a,6             ; 13d4 3e 06   >.
        ldh     (0a7h),a        ; 13d6 e0 a7   `'
        ld      hl,0c213h       ; 13d8 21 13 c2   !.B
        ld      a,(hl)          ; 13db 7e   .
        xor     1               ; 13dc ee 01   n.
        ld      (hl),a          ; 13de 77   w
l13df:  ld      a,3             ; 13df 3e 03   >.
        call    l2673           ; 13e1 cd 73 26   Ms&
        ret                     ; 13e4 c9   I

l13e5:  call    l2820           ; 13e5 cd 20 28   M (
        call    l27ad           ; 13e8 cd ad 27   M-'
        call    l7ff3           ; 13eb cd f3 7f   Ms.
        call    l2293           ; 13ee cd 93 22   M."
        ld      a,93h           ; 13f1 3e 93   >.
        ldh     (40h),a         ; 13f3 e0 40   `@
        ld      a,10h           ; 13f5 3e 10   >.
        ldh     (0e1h),a        ; 13f7 e0 e1   `a
        ret                     ; 13f9 c9   I

l13fa:  ldh     a,(0a7h)        ; 13fa f0 a7   p'
        and     a               ; 13fc a7   '
        ret     nz              ; 13fd c0   @
        ld      a,0ah           ; 13fe 3e 0a   >.
        ldh     (0a7h),a        ; 1400 e0 a7   `'
        ld      a,3             ; 1402 3e 03   >.
        ld      (0dff8h),a      ; 1404 ea f8 df   jx_
        ld      b,2             ; 1407 06 02   ..
        ld      hl,0c210h       ; 1409 21 10 c2   !.B
l140c:  ld      a,(hl)          ; 140c 7e   .
        xor     80h             ; 140d ee 80   n.
        ld      (hl),a          ; 140f 77   w
        ld      l,20h           ; 1410 2e 20   . 
        dec     b               ; 1412 05   .
        jr      nz,l140c        ; 1413 20 f7    w
        ld      a,3             ; 1415 3e 03   >.
        call    l2673           ; 1417 cd 73 26   Ms&
        ret                     ; 141a c9   I

l141b:  .db     0c2h,0cah,0cah,0cah,0cah,0cah,0cah      ; 141b c2 ca ca ca ca ca ca   BJJJJJJ
l1422:  .db     0c3h,0cbh,58h,48h,48h,48h,48h   ; 1422 c3 cb 58 48 48 48 48   CKXHHHH
l1429:  .db     0c8h,73h,73h,73h,73h,73h,73h    ; 1429 c8 73 73 73 73 73 73   Hssssss
l1430:  .db     0c9h,74h,74h,74h,74h,74h,74h    ; 1430 c9 74 74 74 74 74 74   Itttttt

l1437:  ld      a,(de)          ; 1437 1a   .
        ld      (hl),a          ; 1438 77   w
        inc     de              ; 1439 13   .
        push    de              ; 143a d5   U
        ld      de,20h          ; 143b 11 20 00   . .
        add     hl,de           ; 143e 19   .
        pop     de              ; 143f d1   Q
        dec     b               ; 1440 05   .
        jr      nz,l1437        ; 1441 20 f4    t
        ret                     ; 1443 c9   I

; Select Game & Music Type screen
l1444:  ld      a,1             ; 1444 3e 01   >.
        ldh     (0ffh),a        ; 1446 e0 ff   `.
        xor     a               ; 1448 af   /
        ldh     (1),a           ; 1449 e0 01   `.
        ldh     (2),a           ; 144b e0 02   `.
        ldh     (0fh),a         ; 144d e0 0f   `.
l144f:  call    l2820           ; 144f cd 20 28   M (
        call    l27ad           ; 1452 cd ad 27   M-'
        ld      de,l4cd7        ; 1455 11 d7 4c   .WL
        call    l27eb           ; 1458 cd eb 27   Mk'
        call    l178a           ; 145b cd 8a 17   M..
        ld      hl,0c200h       ; 145e 21 00 c2   !.B
        ld      de,l26cf        ; 1461 11 cf 26   .O&
        ld      c,2             ; 1464 0e 02   ..
        call    l1776           ; 1466 cd 76 17   Mv.
        ld      de,0c201h       ; 1469 11 01 c2   ..B
        call    l148d           ; 146c cd 8d 14   M..
        ldh     a,(0c0h)        ; 146f f0 c0   p@
        ld      e,12h           ; 1471 1e 12   ..
        ld      (de),a          ; 1473 12   .
        inc     de              ; 1474 13   .
        cp      37h             ; 1475 fe 37   .7
        ld      a,1ch           ; 1477 3e 1c   >.
        jr      z,l147d         ; 1479 28 02   (.
        ld      a,1dh           ; 147b 3e 1d   >.
l147d:  ld      (de),a          ; 147d 12   .
        call    l2671           ; 147e cd 71 26   Mq&
        call    l1517           ; 1481 cd 17 15   M..
        ld      a,0d3h          ; 1484 3e d3   >S
        ldh     (40h),a         ; 1486 e0 40   `@
        ld      a,0eh           ; 1488 3e 0e   >.
        ldh     (0e1h),a        ; 148a e0 e1   `a
l148c:  ret                     ; 148c c9   I

l148d:  ld      a,1             ; 148d 3e 01   >.
        ld      (0dfe0h),a      ; 148f ea e0 df   j`_
l1492:  ldh     a,(0c1h)        ; 1492 f0 c1   pA
        push    af              ; 1494 f5   u
        sub     1ch             ; 1495 d6 1c   V.
        add     a,a             ; 1497 87   .
        ld      c,a             ; 1498 4f   O
        ld      b,0             ; 1499 06 00   ..
        ld      hl,l14a8        ; 149b 21 a8 14   !(.
        add     hl,bc           ; 149e 09   .
        ldi     a,(hl)          ; 149f 2a   *
        ld      (de),a          ; 14a0 12   .
        inc     de              ; 14a1 13   .
        ld      a,(hl)          ; 14a2 7e   .
        ld      (de),a          ; 14a3 12   .
        inc     de              ; 14a4 13   .
        pop     af              ; 14a5 f1   q
        ld      (de),a          ; 14a6 12   .
        ret                     ; 14a7 c9   I

l14a8:  .db     70h,37h,70h,77h,80h,37h,80h,77h ; 14a8 70 37 70 77 80 37 80 77   p7pw.7.w

l14b0:  ld      de,0c200h       ; 14b0 11 00 c2   ..B
        call    l1766           ; 14b3 cd 66 17   Mf.
        ld      hl,0ffc1h       ; 14b6 21 c1 ff   !A.
        ld      a,(hl)          ; 14b9 7e   .
        bit     3,b             ; 14ba cb 58   KX
        jp      nz,l1563        ; 14bc c2 63 15   Bc.
        bit     0,b             ; 14bf cb 40   K@
        jp      nz,l1563        ; 14c1 c2 63 15   Bc.
        bit     1,b             ; 14c4 cb 48   KH
        jr      nz,l1509        ; 14c6 20 41    A
l14c8:  inc     e               ; 14c8 1c   .
        bit     4,b             ; 14c9 cb 60   K`
        jr      nz,l14f3        ; 14cb 20 26    &
        bit     5,b             ; 14cd cb 68   Kh
        jr      nz,l14fe        ; 14cf 20 2d    -
        bit     6,b             ; 14d1 cb 70   Kp
        jr      nz,l14eb        ; 14d3 20 16    .
        bit     7,b             ; 14d5 cb 78   Kx
        jp      z,l155f         ; 14d7 ca 5f 15   J_.
        cp      1eh             ; 14da fe 1e   ..
        jr      nc,l14e7        ; 14dc 30 09   0.
        add     a,2             ; 14de c6 02   F.
l14e0:  ld      (hl),a          ; 14e0 77   w
        call    l148d           ; 14e1 cd 8d 14   M..
        call    l1517           ; 14e4 cd 17 15   M..
l14e7:  call    l2671           ; 14e7 cd 71 26   Mq&
        ret                     ; 14ea c9   I

l14eb:  cp      1eh             ; 14eb fe 1e   ..
        jr      c,l14e7         ; 14ed 38 f8   8x
        sub     2               ; 14ef d6 02   V.
        jr      l14e0           ; 14f1 18 ed   .m

l14f3:  cp      1dh             ; 14f3 fe 1d   ..
        jr      z,l14e7         ; 14f5 28 f0   (p
        cp      1fh             ; 14f7 fe 1f   ..
        jr      z,l14e7         ; 14f9 28 ec   (l
        inc     a               ; 14fb 3c   <
        jr      l14e0           ; 14fc 18 e2   .b

l14fe:  cp      1ch             ; 14fe fe 1c   ..
        jr      z,l14e7         ; 1500 28 e5   (e
        cp      1eh             ; 1502 fe 1e   ..
        jr      z,l14e7         ; 1504 28 e1   (a
        dec     a               ; 1506 3d   =
        jr      l14e0           ; 1507 18 d7   .W

l1509:  push    af              ; 1509 f5   u
        ldh     a,(0c5h)        ; 150a f0 c5   pE
        and     a               ; 150c a7   '
        jr      z,l1512         ; 150d 28 03   (.
        pop     af              ; 150f f1   q
        jr      l14c8           ; 1510 18 b6   .6

l1512:  pop     af              ; 1512 f1   q
        ld      a,0eh           ; 1513 3e 0e   >.
        jr      l1572           ; 1515 18 5b   .[

l1517:  ldh     a,(0c1h)        ; 1517 f0 c1   pA
        sub     17h             ; 1519 d6 17   V.
        cp      8               ; 151b fe 08   ..
        jr      nz,l1521        ; 151d 20 02    .
        ld      a,0ffh          ; 151f 3e ff   >.
l1521:  ld      (0dfe8h),a      ; 1521 ea e8 df   jh_
        ret                     ; 1524 c9   I

l1525:  ld      de,0c210h       ; 1525 11 10 c2   ..B
        call    l1766           ; 1528 cd 66 17   Mf.
        ld      hl,0ffc0h       ; 152b 21 c0 ff   !@.
        ld      a,(hl)          ; 152e 7e   .
        bit     3,b             ; 152f cb 58   KX
        jr      nz,l1563        ; 1531 20 30    0
        bit     0,b             ; 1533 cb 40   K@
        jr      nz,l1577        ; 1535 20 40    @
        inc     e               ; 1537 1c   .
        inc     e               ; 1538 1c   .
        bit     4,b             ; 1539 cb 60   K`
        jr      nz,l154b        ; 153b 20 0e    .
        bit     5,b             ; 153d cb 68   Kh
        jr      z,l155f         ; 153f 28 1e   (.
        cp      37h             ; 1541 fe 37   .7
        jr      z,l155f         ; 1543 28 1a   (.
        ld      a,37h           ; 1545 3e 37   >7
        ld      b,1ch           ; 1547 06 1c   ..
        jr      l1553           ; 1549 18 08   ..

l154b:  cp      77h             ; 154b fe 77   .w
        jr      z,l155f         ; 154d 28 10   (.
        ld      a,77h           ; 154f 3e 77   >w
        ld      b,1dh           ; 1551 06 1d   ..
l1553:  ld      (hl),a          ; 1553 77   w
        push    af              ; 1554 f5   u
        ld      a,1             ; 1555 3e 01   >.
        ld      (0dfe0h),a      ; 1557 ea e0 df   j`_
        pop     af              ; 155a f1   q
        ld      (de),a          ; 155b 12   .
        inc     de              ; 155c 13   .
        ld      a,b             ; 155d 78   x
l155e:  ld      (de),a          ; 155e 12   .
l155f:  call    l2671           ; 155f cd 71 26   Mq&
        ret                     ; 1562 c9   I

l1563:  ld      a,2             ; 1563 3e 02   >.
        ld      (0dfe0h),a      ; 1565 ea e0 df   j`_
        ldh     a,(0c0h)        ; 1568 f0 c0   p@
        cp      37h             ; 156a fe 37   .7
        ld      a,10h           ; 156c 3e 10   >.
        jr      z,l1572         ; 156e 28 02   (.
        ld      a,12h           ; 1570 3e 12   >.
l1572:  ldh     (0e1h),a        ; 1572 e0 e1   `a
        xor     a               ; 1574 af   /
        jr      l155e           ; 1575 18 e7   .g

l1577:  ld      a,0fh           ; 1577 3e 0f   >.
        jr      l1572           ; 1579 18 f7   .w

; Display Type-A Level Select / Top Score screen
l157b:  call    l2820           ; 157b cd 20 28   M (
        ld      de,l4e3f        ; 157e 11 3f 4e   .?N
        call    l27eb           ; 1581 cd eb 27   Mk'
        call    l18fc           ; 1584 cd fc 18   M|.
        call    l178a           ; 1587 cd 8a 17   M..
        ld      hl,0c200h       ; 158a 21 00 c2   !.B
        ld      de,l26db        ; 158d 11 db 26   .[&
        ld      c,1             ; 1590 0e 01   ..
        call    l1776           ; 1592 cd 76 17   Mv.
        ld      de,0c201h       ; 1595 11 01 c2   ..B
        ldh     a,(0c2h)        ; 1598 f0 c2   pB
        ld      hl,l1615        ; 159a 21 15 16   !..
        call    l174e           ; 159d cd 4e 17   MN.
        call    l2671           ; 15a0 cd 71 26   Mq&
        call    l1795           ; 15a3 cd 95 17   M..
        call    l18ca           ; 15a6 cd ca 18   MJ.
        ld      a,0d3h          ; 15a9 3e d3   >S
        ldh     (40h),a         ; 15ab e0 40   `@
        ld      a,11h           ; 15ad 3e 11   >.
        ldh     (0e1h),a        ; 15af e0 e1   `a
        ldh     a,(0c7h)        ; 15b1 f0 c7   pG
        and     a               ; 15b3 a7   '
        jr      nz,l15ba        ; 15b4 20 04    .
        call    l1517           ; 15b6 cd 17 15   M..
        ret                     ; 15b9 c9   I

l15ba:  ld      a,15h           ; 15ba 3e 15   >.
l15bc:  ldh     (0e1h),a        ; 15bc e0 e1   `a
        ret                     ; 15be c9   I

l15bf:  ld      de,0c200h       ; 15bf 11 00 c2   ..B
        call    l1766           ; 15c2 cd 66 17   Mf.
        ld      hl,0ffc2h       ; 15c5 21 c2 ff   !B.
        ld      a,0ah           ; 15c8 3e 0a   >.
        bit     3,b             ; 15ca cb 58   KX
        jr      nz,l15bc        ; 15cc 20 ee    n
        bit     0,b             ; 15ce cb 40   K@
        jr      nz,l15bc        ; 15d0 20 ea    j
        ld      a,8             ; 15d2 3e 08   >.
        bit     1,b             ; 15d4 cb 48   KH
        jr      nz,l15bc        ; 15d6 20 e4    d
        ld      a,(hl)          ; 15d8 7e   .
        bit     4,b             ; 15d9 cb 60   K`
        jr      nz,l15f1        ; 15db 20 14    .
        bit     5,b             ; 15dd cb 68   Kh
        jr      nz,l1607        ; 15df 20 26    &
        bit     6,b             ; 15e1 cb 70   Kp
        jr      nz,l160d        ; 15e3 20 28    (
        bit     7,b             ; 15e5 cb 78   Kx
        jr      z,l1603         ; 15e7 28 1a   (.
        cp      5               ; 15e9 fe 05   ..
        jr      nc,l1603        ; 15eb 30 16   0.
        add     a,5             ; 15ed c6 05   F.
        jr      l15f6           ; 15ef 18 05   ..

l15f1:  cp      9               ; 15f1 fe 09   ..
        jr      z,l1603         ; 15f3 28 0e   (.
        inc     a               ; 15f5 3c   <
l15f6:  ld      (hl),a          ; 15f6 77   w
        ld      de,0c201h       ; 15f7 11 01 c2   ..B
        ld      hl,l1615        ; 15fa 21 15 16   !..
        call    l174e           ; 15fd cd 4e 17   MN.
        call    l1795           ; 1600 cd 95 17   M..
l1603:  call    l2671           ; 1603 cd 71 26   Mq&
        ret                     ; 1606 c9   I

l1607:  and     a               ; 1607 a7   '
        jr      z,l1603         ; 1608 28 f9   (y
        dec     a               ; 160a 3d   =
        jr      l15f6           ; 160b 18 e9   .i

l160d:  cp      5               ; 160d fe 05   ..
        jr      c,l1603         ; 160f 38 f2   8r
        sub     5               ; 1611 d6 05   V.
        jr      l15f6           ; 1613 18 e1   .a

l1615:  .db     40h,30h,40h,40h,40h,50h,40h,60h,40h,70h,50h,30h,50h     ; 1615 40 30 40 40 40 50 40 60 40 70 50 30 50   @0@@@P@`@pP0P
        .db     40h,50h,50h,50h,60h,50h,70h     ; 1622 40 50 50 50 60 50 70   @PPP`Pp

; Display Type-B Level Select / High / Top Score screen
l1629:  call    l2820           ; 1629 cd 20 28   M (
        ld      de,l4fa7        ; 162c 11 a7 4f   .'O
        call    l27eb           ; 162f cd eb 27   Mk'
        call    l178a           ; 1632 cd 8a 17   M..
        ld      hl,0c200h       ; 1635 21 00 c2   !.B
        ld      de,l26e1        ; 1638 11 e1 26   .a&
        ld      c,2             ; 163b 0e 02   ..
        call    l1776           ; 163d cd 76 17   Mv.
        ld      de,0c201h       ; 1640 11 01 c2   ..B
        ldh     a,(0c3h)        ; 1643 f0 c3   pC
        ld      hl,l16d2        ; 1645 21 d2 16   !R.
        call    l174e           ; 1648 cd 4e 17   MN.
        ld      de,0c211h       ; 164b 11 11 c2   ..B
        ldh     a,(0c4h)        ; 164e f0 c4   pD
        ld      hl,l1741        ; 1650 21 41 17   !A.
        call    l174e           ; 1653 cd 4e 17   MN.
        call    l2671           ; 1656 cd 71 26   Mq&
        call    l17af           ; 1659 cd af 17   M/.
        call    l18ca           ; 165c cd ca 18   MJ.
        ld      a,0d3h          ; 165f 3e d3   >S
        ldh     (40h),a         ; 1661 e0 40   `@
        ld      a,13h           ; 1663 3e 13   >.
        ldh     (0e1h),a        ; 1665 e0 e1   `a
        ldh     a,(0c7h)        ; 1667 f0 c7   pG
        and     a               ; 1669 a7   '
        jr      nz,l1670        ; 166a 20 04    .
        call    l1517           ; 166c cd 17 15   M..
        ret                     ; 166f c9   I

l1670:  ld      a,15h           ; 1670 3e 15   >.
        ldh     (0e1h),a        ; 1672 e0 e1   `a
        ret                     ; 1674 c9   I

l1675:  ldh     (0e1h),a        ; 1675 e0 e1   `a
        xor     a               ; 1677 af   /
        ld      (de),a          ; 1678 12   .
        ret                     ; 1679 c9   I

l167a:  ld      de,0c200h       ; 167a 11 00 c2   ..B
        call    l1766           ; 167d cd 66 17   Mf.
        ld      hl,0ffc3h       ; 1680 21 c3 ff   !C.
        ld      a,0ah           ; 1683 3e 0a   >.
        bit     3,b             ; 1685 cb 58   KX
        jr      nz,l1675        ; 1687 20 ec    l
        ld      a,14h           ; 1689 3e 14   >.
        bit     0,b             ; 168b cb 40   K@
        jr      nz,l1675        ; 168d 20 e6    f
        ld      a,8             ; 168f 3e 08   >.
        bit     1,b             ; 1691 cb 48   KH
        jr      nz,l1675        ; 1693 20 e0    `
        ld      a,(hl)          ; 1695 7e   .
        bit     4,b             ; 1696 cb 60   K`
        jr      nz,l16ae        ; 1698 20 14    .
        bit     5,b             ; 169a cb 68   Kh
        jr      nz,l16c4        ; 169c 20 26    &
        bit     6,b             ; 169e cb 70   Kp
        jr      nz,l16ca        ; 16a0 20 28    (
        bit     7,b             ; 16a2 cb 78   Kx
        jr      z,l16c0         ; 16a4 28 1a   (.
        cp      5               ; 16a6 fe 05   ..
        jr      nc,l16c0        ; 16a8 30 16   0.
        add     a,5             ; 16aa c6 05   F.
        jr      l16b3           ; 16ac 18 05   ..

l16ae:  cp      9               ; 16ae fe 09   ..
        jr      z,l16c0         ; 16b0 28 0e   (.
        inc     a               ; 16b2 3c   <
l16b3:  ld      (hl),a          ; 16b3 77   w
        ld      de,0c201h       ; 16b4 11 01 c2   ..B
        ld      hl,l16d2        ; 16b7 21 d2 16   !R.
        call    l174e           ; 16ba cd 4e 17   MN.
        call    l17af           ; 16bd cd af 17   M/.
l16c0:  call    l2671           ; 16c0 cd 71 26   Mq&
        ret                     ; 16c3 c9   I

l16c4:  and     a               ; 16c4 a7   '
        jr      z,l16c0         ; 16c5 28 f9   (y
        dec     a               ; 16c7 3d   =
        jr      l16b3           ; 16c8 18 e9   .i

l16ca:  cp      5               ; 16ca fe 05   ..
        jr      c,l16c0         ; 16cc 38 f2   8r
        sub     5               ; 16ce d6 05   V.
        jr      l16b3           ; 16d0 18 e1   .a

l16d2:  .db     40h,18h,40h,28h,40h,38h,40h,48h,40h,58h,50h,18h,50h     ; 16d2 40 18 40 28 40 38 40 48 40 58 50 18 50   @.@(@8@H@XP.P
        .db     28h,50h,38h,50h,48h,50h,58h     ; 16df 28 50 38 50 48 50 58   (P8PHPX

l16e6:  ldh     (0e1h),a        ; 16e6 e0 e1   `a
        xor     a               ; 16e8 af   /
        ld      (de),a          ; 16e9 12   .
        ret                     ; 16ea c9   I

l16eb:  ld      de,0c210h       ; 16eb 11 10 c2   ..B
        call    l1766           ; 16ee cd 66 17   Mf.
        ld      hl,0ffc4h       ; 16f1 21 c4 ff   !D.
        ld      a,0ah           ; 16f4 3e 0a   >.
        bit     3,b             ; 16f6 cb 58   KX
        jr      nz,l16e6        ; 16f8 20 ec    l
        bit     0,b             ; 16fa cb 40   K@
        jr      nz,l16e6        ; 16fc 20 e8    h
        ld      a,13h           ; 16fe 3e 13   >.
        bit     1,b             ; 1700 cb 48   KH
        jr      nz,l16e6        ; 1702 20 e2    b
        ld      a,(hl)          ; 1704 7e   .
        bit     4,b             ; 1705 cb 60   K`
        jr      nz,l171d        ; 1707 20 14    .
        bit     5,b             ; 1709 cb 68   Kh
        jr      nz,l1733        ; 170b 20 26    &
        bit     6,b             ; 170d cb 70   Kp
        jr      nz,l1739        ; 170f 20 28    (
        bit     7,b             ; 1711 cb 78   Kx
        jr      z,l172f         ; 1713 28 1a   (.
        cp      3               ; 1715 fe 03   ..
        jr      nc,l172f        ; 1717 30 16   0.
        add     a,3             ; 1719 c6 03   F.
        jr      l1722           ; 171b 18 05   ..

l171d:  cp      5               ; 171d fe 05   ..
        jr      z,l172f         ; 171f 28 0e   (.
        inc     a               ; 1721 3c   <
l1722:  ld      (hl),a          ; 1722 77   w
        ld      de,0c211h       ; 1723 11 11 c2   ..B
        ld      hl,l1741        ; 1726 21 41 17   !A.
        call    l174e           ; 1729 cd 4e 17   MN.
        call    l17af           ; 172c cd af 17   M/.
l172f:  call    l2671           ; 172f cd 71 26   Mq&
        ret                     ; 1732 c9   I

l1733:  and     a               ; 1733 a7   '
        jr      z,l172f         ; 1734 28 f9   (y
        dec     a               ; 1736 3d   =
        jr      l1722           ; 1737 18 e9   .i

l1739:  cp      3               ; 1739 fe 03   ..
        jr      c,l172f         ; 173b 38 f2   8r
        sub     3               ; 173d d6 03   V.
        jr      l1722           ; 173f 18 e1   .a

l1741:  .db     40h,70h,40h,80h,40h,90h,50h,70h,50h,80h,50h,90h,0       ; 1741 40 70 40 80 40 90 50 70 50 80 50 90 00   @p@.@.PpP.P..

l174e:  push    af              ; 174e f5   u
        ld      a,1             ; 174f 3e 01   >.
        ld      (0dfe0h),a      ; 1751 ea e0 df   j`_
        pop     af              ; 1754 f1   q
l1755:  push    af              ; 1755 f5   u
        add     a,a             ; 1756 87   .
        ld      c,a             ; 1757 4f   O
        ld      b,0             ; 1758 06 00   ..
        add     hl,bc           ; 175a 09   .
        ldi     a,(hl)          ; 175b 2a   *
        ld      (de),a          ; 175c 12   .
        inc     de              ; 175d 13   .
        ld      a,(hl)          ; 175e 7e   .
        ld      (de),a          ; 175f 12   .
        inc     de              ; 1760 13   .
        pop     af              ; 1761 f1   q
        add     a,20h           ; 1762 c6 20   F 
        ld      (de),a          ; 1764 12   .
        ret                     ; 1765 c9   I

l1766:  ldh     a,(81h)         ; 1766 f0 81   p.
        ld      b,a             ; 1768 47   G
        ldh     a,(0a6h)        ; 1769 f0 a6   p&
        and     a               ; 176b a7   '
        ret     nz              ; 176c c0   @
        ld      a,10h           ; 176d 3e 10   >.
        ldh     (0a6h),a        ; 176f e0 a6   `&
        ld      a,(de)          ; 1771 1a   .
        xor     80h             ; 1772 ee 80   n.
        ld      (de),a          ; 1774 12   .
        ret                     ; 1775 c9   I

l1776:  push    hl              ; 1776 e5   e
        ld      b,6             ; 1777 06 06   ..
l1779:  ld      a,(de)          ; 1779 1a   .
        ldi     (hl),a          ; 177a 22   "
        inc     de              ; 177b 13   .
        dec     b               ; 177c 05   .
        jr      nz,l1779        ; 177d 20 fa    z
        pop     hl              ; 177f e1   a
        ld      a,10h           ; 1780 3e 10   >.
        add     a,l             ; 1782 85   .
        ld      l,a             ; 1783 6f   o
        dec     c               ; 1784 0d   .
        jr      nz,l1776        ; 1785 20 ef    o
        ld      (hl),80h        ; 1787 36 80   6.
        ret                     ; 1789 c9   I

; Fill c000 to c09f with 0
l178a:  xor     a               ; 178a af   /
        ld      hl,0c000h       ; 178b 21 00 c0   !.@
        ld      b,0a0h          ; 178e 06 a0   . 
l1790:  ldi     (hl),a          ; 1790 22   "
        dec     b               ; 1791 05   .
        jr      nz,l1790        ; 1792 20 fc    |
        ret                     ; 1794 c9   I

l1795:  call    l18fc           ; 1795 cd fc 18   M|.
        ldh     a,(0c2h)        ; 1798 f0 c2   pB
        ld      hl,0d654h       ; 179a 21 54 d6   !TV
        ld      de,1bh          ; 179d 11 1b 00   ...
l17a0:  and     a               ; 17a0 a7   '
        jr      z,l17a7         ; 17a1 28 04   (.
        dec     a               ; 17a3 3d   =
        add     hl,de           ; 17a4 19   .
        jr      l17a0           ; 17a5 18 f9   .y

l17a7:  inc     hl              ; 17a7 23   #
        inc     hl              ; 17a8 23   #
        push    hl              ; 17a9 e5   e
        pop     de              ; 17aa d1   Q
        call    l1800           ; 17ab cd 00 18   M..
        ret                     ; 17ae c9   I

l17af:  call    l18fc           ; 17af cd fc 18   M|.
        ldh     a,(0c3h)        ; 17b2 f0 c3   pC
        ld      hl,0d000h       ; 17b4 21 00 d0   !.P
        ld      de,0a2h         ; 17b7 11 a2 00   .".
l17ba:  and     a               ; 17ba a7   '
        jr      z,l17c1         ; 17bb 28 04   (.
        dec     a               ; 17bd 3d   =
        add     hl,de           ; 17be 19   .
        jr      l17ba           ; 17bf 18 f9   .y

l17c1:  ldh     a,(0c4h)        ; 17c1 f0 c4   pD
        ld      de,1bh          ; 17c3 11 1b 00   ...
l17c6:  and     a               ; 17c6 a7   '
        jr      z,l17cd         ; 17c7 28 04   (.
        dec     a               ; 17c9 3d   =
        add     hl,de           ; 17ca 19   .
        jr      l17c6           ; 17cb 18 f9   .y

l17cd:  inc     hl              ; 17cd 23   #
        inc     hl              ; 17ce 23   #
        push    hl              ; 17cf e5   e
        pop     de              ; 17d0 d1   Q
        call    l1800           ; 17d1 cd 00 18   M..
        ret                     ; 17d4 c9   I

l17d5:  ld      b,3             ; 17d5 06 03   ..
l17d7:  ld      a,(hl)          ; 17d7 7e   .
        and     0f0h            ; 17d8 e6 f0   fp
        jr      nz,l17e7        ; 17da 20 0b    .
        inc     e               ; 17dc 1c   .
        ldd     a,(hl)          ; 17dd 3a   :
        and     0fh             ; 17de e6 0f   f.
        jr      nz,l17f1        ; 17e0 20 0f    .
        inc     e               ; 17e2 1c   .
        dec     b               ; 17e3 05   .
        jr      nz,l17d7        ; 17e4 20 f1    q
        ret                     ; 17e6 c9   I

l17e7:  ld      a,(hl)          ; 17e7 7e   .
        and     0f0h            ; 17e8 e6 f0   fp
        swap    a               ; 17ea cb 37   K7
        ld      (de),a          ; 17ec 12   .
        inc     e               ; 17ed 1c   .
        ldd     a,(hl)          ; 17ee 3a   :
        and     0fh             ; 17ef e6 0f   f.
l17f1:  ld      (de),a          ; 17f1 12   .
        inc     e               ; 17f2 1c   .
        dec     b               ; 17f3 05   .
        jr      nz,l17e7        ; 17f4 20 f1    q
        ret                     ; 17f6 c9   I

l17f7:  ld      b,3             ; 17f7 06 03   ..
l17f9:  ldd     a,(hl)          ; 17f9 3a   :
        ld      (de),a          ; 17fa 12   .
        dec     de              ; 17fb 1b   .
        dec     b               ; 17fc 05   .
        jr      nz,l17f9        ; 17fd 20 fa    z
        ret                     ; 17ff c9   I

l1800:  ld      a,d             ; 1800 7a   z
        ldh     (0fbh),a        ; 1801 e0 fb   `{
        ld      a,e             ; 1803 7b   {
        ldh     (0fch),a        ; 1804 e0 fc   `|
        ld      c,3             ; 1806 0e 03   ..
l1808:  ld      hl,0c0a2h       ; 1808 21 a2 c0   !"@
        push    de              ; 180b d5   U
        ld      b,3             ; 180c 06 03   ..
l180e:  ld      a,(de)          ; 180e 1a   .
        sub     (hl)            ; 180f 96   .
        jr      c,l1822         ; 1810 38 10   8.
        jr      nz,l1819        ; 1812 20 05    .
        dec     l               ; 1814 2d   -
        dec     de              ; 1815 1b   .
        dec     b               ; 1816 05   .
        jr      nz,l180e        ; 1817 20 f5    u
l1819:  pop     de              ; 1819 d1   Q
        inc     de              ; 181a 13   .
        inc     de              ; 181b 13   .
        inc     de              ; 181c 13   .
        dec     c               ; 181d 0d   .
        jr      nz,l1808        ; 181e 20 e8    h
        jr      l1880           ; 1820 18 5e   .^

l1822:  pop     de              ; 1822 d1   Q
        ldh     a,(0fbh)        ; 1823 f0 fb   p{
        ld      d,a             ; 1825 57   W
        ldh     a,(0fch)        ; 1826 f0 fc   p|
        ld      e,a             ; 1828 5f   _
        push    de              ; 1829 d5   U
        push    bc              ; 182a c5   E
        ld      hl,6            ; 182b 21 06 00   !..
        add     hl,de           ; 182e 19   .
        push    hl              ; 182f e5   e
        pop     de              ; 1830 d1   Q
        dec     hl              ; 1831 2b   +
        dec     hl              ; 1832 2b   +
        dec     hl              ; 1833 2b   +
l1834:  dec     c               ; 1834 0d   .
        jr      z,l183c         ; 1835 28 05   (.
        call    l17f7           ; 1837 cd f7 17   Mw.
        jr      l1834           ; 183a 18 f8   .x

l183c:  ld      hl,0c0a2h       ; 183c 21 a2 c0   !"@
        ld      b,3             ; 183f 06 03   ..
l1841:  ldd     a,(hl)          ; 1841 3a   :
        ld      (de),a          ; 1842 12   .
        dec     e               ; 1843 1d   .
        dec     b               ; 1844 05   .
        jr      nz,l1841        ; 1845 20 fa    z
        pop     bc              ; 1847 c1   A
        pop     de              ; 1848 d1   Q
        ld      a,c             ; 1849 79   y
        ldh     (0c8h),a        ; 184a e0 c8   `H
        ld      hl,12h          ; 184c 21 12 00   !..
        add     hl,de           ; 184f 19   .
        push    hl              ; 1850 e5   e
        ld      de,6            ; 1851 11 06 00   ...
        add     hl,de           ; 1854 19   .
        push    hl              ; 1855 e5   e
        pop     de              ; 1856 d1   Q
        pop     hl              ; 1857 e1   a
l1858:  dec     c               ; 1858 0d   .
        jr      z,l1862         ; 1859 28 07   (.
        ld      b,6             ; 185b 06 06   ..
        call    l17f9           ; 185d cd f9 17   My.
        jr      l1858           ; 1860 18 f6   .v

l1862:  ld      a,60h           ; 1862 3e 60   >`
        ld      b,5             ; 1864 06 05   ..
l1866:  ld      (de),a          ; 1866 12   .
        dec     de              ; 1867 1b   .
        dec     b               ; 1868 05   .
        jr      nz,l1866        ; 1869 20 fb    {
        ld      a,0ah           ; 186b 3e 0a   >.
        ld      (de),a          ; 186d 12   .
        ld      a,d             ; 186e 7a   z
        ldh     (0c9h),a        ; 186f e0 c9   `I
        ld      a,e             ; 1871 7b   {
        ldh     (0cah),a        ; 1872 e0 ca   `J
        xor     a               ; 1874 af   /
        ldh     (9ch),a         ; 1875 e0 9c   `.
        ldh     (0c6h),a        ; 1877 e0 c6   `F
        ld      a,1             ; 1879 3e 01   >.
        ld      (0dfe8h),a      ; 187b ea e8 df   jh_
        ldh     (0c7h),a        ; 187e e0 c7   `G
l1880:  ld      de,0c9ach       ; 1880 11 ac c9   .,I
        ldh     a,(0fbh)        ; 1883 f0 fb   p{
        ld      h,a             ; 1885 67   g
        ldh     a,(0fch)        ; 1886 f0 fc   p|
        ld      l,a             ; 1888 6f   o
        ld      b,3             ; 1889 06 03   ..
l188b:  push    hl              ; 188b e5   e
        push    de              ; 188c d5   U
        push    bc              ; 188d c5   E
        call    l17d5           ; 188e cd d5 17   MU.
        pop     bc              ; 1891 c1   A
        pop     de              ; 1892 d1   Q
        ld      hl,20h          ; 1893 21 20 00   ! .
        add     hl,de           ; 1896 19   .
        push    hl              ; 1897 e5   e
        pop     de              ; 1898 d1   Q
        pop     hl              ; 1899 e1   a
        push    de              ; 189a d5   U
        ld      de,3            ; 189b 11 03 00   ...
        add     hl,de           ; 189e 19   .
        pop     de              ; 189f d1   Q
        dec     b               ; 18a0 05   .
        jr      nz,l188b        ; 18a1 20 e8    h
        dec     hl              ; 18a3 2b   +
        dec     hl              ; 18a4 2b   +
        ld      b,3             ; 18a5 06 03   ..
        ld      de,0c9a4h       ; 18a7 11 a4 c9   .$I
l18aa:  push    de              ; 18aa d5   U
        ld      c,6             ; 18ab 0e 06   ..
l18ad:  ldi     a,(hl)          ; 18ad 2a   *
        and     a               ; 18ae a7   '
        jr      z,l18b6         ; 18af 28 05   (.
        ld      (de),a          ; 18b1 12   .
        inc     de              ; 18b2 13   .
        dec     c               ; 18b3 0d   .
        jr      nz,l18ad        ; 18b4 20 f7    w
l18b6:  pop     de              ; 18b6 d1   Q
        push    hl              ; 18b7 e5   e
        ld      hl,20h          ; 18b8 21 20 00   ! .
        add     hl,de           ; 18bb 19   .
        push    hl              ; 18bc e5   e
        pop     de              ; 18bd d1   Q
        pop     hl              ; 18be e1   a
        dec     b               ; 18bf 05   .
        jr      nz,l18aa        ; 18c0 20 e8    h
        call    l2651           ; 18c2 cd 51 26   MQ&
        ld      a,1             ; 18c5 3e 01   >.
        ldh     (0e8h),a        ; 18c7 e0 e8   `h
        ret                     ; 18c9 c9   I

l18ca:  ldh     a,(0e8h)        ; 18ca f0 e8   ph
        and     a               ; 18cc a7   '
        ret     z               ; 18cd c8   H
        ld      hl,99a4h        ; 18ce 21 a4 99   !$.
        ld      de,0c9a4h       ; 18d1 11 a4 c9   .$I
        ld      c,6             ; 18d4 0e 06   ..
l18d6:  push    hl              ; 18d6 e5   e
l18d7:  ld      b,6             ; 18d7 06 06   ..
l18d9:  ld      a,(de)          ; 18d9 1a   .
        ldi     (hl),a          ; 18da 22   "
        inc     e               ; 18db 1c   .
        dec     b               ; 18dc 05   .
        jr      nz,l18d9        ; 18dd 20 fa    z
        inc     e               ; 18df 1c   .
        inc     l               ; 18e0 2c   ,
        inc     e               ; 18e1 1c   .
        inc     l               ; 18e2 2c   ,
        dec     c               ; 18e3 0d   .
        jr      z,l18f7         ; 18e4 28 11   (.
        bit     0,c             ; 18e6 cb 41   KA
        jr      nz,l18d7        ; 18e8 20 ed    m
        pop     hl              ; 18ea e1   a
        ld      de,20h          ; 18eb 11 20 00   . .
        add     hl,de           ; 18ee 19   .
        push    hl              ; 18ef e5   e
        pop     de              ; 18f0 d1   Q
        ld      a,30h           ; 18f1 3e 30   >0
        add     a,d             ; 18f3 82   .
        ld      d,a             ; 18f4 57   W
        jr      l18d6           ; 18f5 18 df   ._

l18f7:  pop     hl              ; 18f7 e1   a
        xor     a               ; 18f8 af   /
        ldh     (0e8h),a        ; 18f9 e0 e8   `h
        ret                     ; 18fb c9   I

l18fc:  ld      hl,0c9a4h       ; 18fc 21 a4 c9   !$I
        ld      de,20h          ; 18ff 11 20 00   . .
        ld      a,60h           ; 1902 3e 60   >`
        ld      c,3             ; 1904 0e 03   ..
l1906:  ld      b,0eh           ; 1906 06 0e   ..
        push    hl              ; 1908 e5   e
l1909:  ldi     (hl),a          ; 1909 22   "
        dec     b               ; 190a 05   .
        jr      nz,l1909        ; 190b 20 fc    |
        pop     hl              ; 190d e1   a
        add     hl,de           ; 190e 19   .
        dec     c               ; 190f 0d   .
        jr      nz,l1906        ; 1910 20 f4    t
        ret                     ; 1912 c9   I

l1913:  ldh     a,(0c8h)        ; 1913 f0 c8   pH
        ld      hl,99e4h        ; 1915 21 e4 99   !d.
        ld      de,0ffe0h       ; 1918 11 e0 ff   .`.
l191b:  dec     a               ; 191b 3d   =
        jr      z,l1921         ; 191c 28 03   (.
        add     hl,de           ; 191e 19   .
        jr      l191b           ; 191f 18 fa   .z

l1921:  ldh     a,(0c6h)        ; 1921 f0 c6   pF
        ld      e,a             ; 1923 5f   _
        ld      d,0             ; 1924 16 00   ..
        add     hl,de           ; 1926 19   .
        ldh     a,(0c9h)        ; 1927 f0 c9   pI
        ld      d,a             ; 1929 57   W
        ldh     a,(0cah)        ; 192a f0 ca   pJ
        ld      e,a             ; 192c 5f   _
        ldh     a,(0a6h)        ; 192d f0 a6   p&
        and     a               ; 192f a7   '
        jr      nz,l1944        ; 1930 20 12    .
        ld      a,7             ; 1932 3e 07   >.
        ldh     (0a6h),a        ; 1934 e0 a6   `&
        ldh     a,(9ch)         ; 1936 f0 9c   p.
        xor     1               ; 1938 ee 01   n.
        ldh     (9ch),a         ; 193a e0 9c   `.
        ld      a,(de)          ; 193c 1a   .
        jr      z,l1941         ; 193d 28 02   (.
        ld      a,2fh           ; 193f 3e 2f   >/
l1941:  call    l19fe           ; 1941 cd fe 19   M..
l1944:  ldh     a,(81h)         ; 1944 f0 81   p.
        ld      b,a             ; 1946 47   G
        ldh     a,(80h)         ; 1947 f0 80   p.
        ld      c,a             ; 1949 4f   O
        ld      a,17h           ; 194a 3e 17   >.
        bit     6,b             ; 194c cb 70   Kp
        jr      nz,l1987        ; 194e 20 37    7
        bit     6,c             ; 1950 cb 71   Kq
        jr      nz,l197f        ; 1952 20 2b    +
        bit     7,b             ; 1954 cb 78   Kx
        jr      nz,l19b0        ; 1956 20 58    X
        bit     7,c             ; 1958 cb 79   Ky
        jr      nz,l19a8        ; 195a 20 4c    L
        bit     0,b             ; 195c cb 40   K@
        jr      nz,l19cc        ; 195e 20 6c    l
        bit     1,b             ; 1960 cb 48   KH
        jp      nz,l19ee        ; 1962 c2 ee 19   Bn.
        bit     3,b             ; 1965 cb 58   KX
        ret     z               ; 1967 c8   H
l1968:  ld      a,(de)          ; 1968 1a   .
        call    l19fe           ; 1969 cd fe 19   M..
        call    l1517           ; 196c cd 17 15   M..
        xor     a               ; 196f af   /
        ldh     (0c7h),a        ; 1970 e0 c7   `G
        ldh     a,(0c0h)        ; 1972 f0 c0   p@
        cp      37h             ; 1974 fe 37   .7
        ld      a,11h           ; 1976 3e 11   >.
        jr      z,l197c         ; 1978 28 02   (.
        ld      a,13h           ; 197a 3e 13   >.
l197c:  ldh     (0e1h),a        ; 197c e0 e1   `a
        ret                     ; 197e c9   I

l197f:  ldh     a,(0aah)        ; 197f f0 aa   p*
        dec     a               ; 1981 3d   =
        ldh     (0aah),a        ; 1982 e0 aa   `*
        ret     nz              ; 1984 c0   @
        ld      a,9             ; 1985 3e 09   >.
l1987:  ldh     (0aah),a        ; 1987 e0 aa   `*
        ld      b,26h           ; 1989 06 26   .&
        ldh     a,(0f4h)        ; 198b f0 f4   pt
        and     a               ; 198d a7   '
        jr      z,l1992         ; 198e 28 02   (.
        ld      b,27h           ; 1990 06 27   .'
l1992:  ld      a,(de)          ; 1992 1a   .
        cp      b               ; 1993 b8   8
        jr      nz,l19a0        ; 1994 20 0a    .
        ld      a,2eh           ; 1996 3e 2e   >.
l1998:  inc     a               ; 1998 3c   <
l1999:  ld      (de),a          ; 1999 12   .
        ld      a,1             ; 199a 3e 01   >.
        ld      (0dfe0h),a      ; 199c ea e0 df   j`_
        ret                     ; 199f c9   I

l19a0:  cp      2fh             ; 19a0 fe 2f   ./
        jr      nz,l1998        ; 19a2 20 f4    t
        ld      a,0ah           ; 19a4 3e 0a   >.
        jr      l1999           ; 19a6 18 f1   .q

l19a8:  ldh     a,(0aah)        ; 19a8 f0 aa   p*
        dec     a               ; 19aa 3d   =
        ldh     (0aah),a        ; 19ab e0 aa   `*
        ret     nz              ; 19ad c0   @
        ld      a,9             ; 19ae 3e 09   >.
l19b0:  ldh     (0aah),a        ; 19b0 e0 aa   `*
        ld      b,26h           ; 19b2 06 26   .&
        ldh     a,(0f4h)        ; 19b4 f0 f4   pt
        and     a               ; 19b6 a7   '
        jr      z,l19bb         ; 19b7 28 02   (.
        ld      b,27h           ; 19b9 06 27   .'
l19bb:  ld      a,(de)          ; 19bb 1a   .
        cp      0ah             ; 19bc fe 0a   ..
        jr      nz,l19c5        ; 19be 20 05    .
        ld      a,30h           ; 19c0 3e 30   >0
l19c2:  dec     a               ; 19c2 3d   =
        jr      l1999           ; 19c3 18 d4   .T

l19c5:  cp      2fh             ; 19c5 fe 2f   ./
        jr      nz,l19c2        ; 19c7 20 f9    y
        ld      a,b             ; 19c9 78   x
        jr      l1999           ; 19ca 18 cd   .M

l19cc:  ld      a,(de)          ; 19cc 1a   .
        call    l19fe           ; 19cd cd fe 19   M..
        ld      a,2             ; 19d0 3e 02   >.
        ld      (0dfe0h),a      ; 19d2 ea e0 df   j`_
        ldh     a,(0c6h)        ; 19d5 f0 c6   pF
        inc     a               ; 19d7 3c   <
        cp      6               ; 19d8 fe 06   ..
        jr      z,l1968         ; 19da 28 8c   (.
        ldh     (0c6h),a        ; 19dc e0 c6   `F
        inc     de              ; 19de 13   .
        ld      a,(de)          ; 19df 1a   .
        cp      60h             ; 19e0 fe 60   .`
        jr      nz,l19e7        ; 19e2 20 03    .
        ld      a,0ah           ; 19e4 3e 0a   >.
        ld      (de),a          ; 19e6 12   .
l19e7:  ld      a,d             ; 19e7 7a   z
        ldh     (0c9h),a        ; 19e8 e0 c9   `I
        ld      a,e             ; 19ea 7b   {
        ldh     (0cah),a        ; 19eb e0 ca   `J
        ret                     ; 19ed c9   I

l19ee:  ldh     a,(0c6h)        ; 19ee f0 c6   pF
        and     a               ; 19f0 a7   '
        ret     z               ; 19f1 c8   H
        ld      a,(de)          ; 19f2 1a   .
        call    l19fe           ; 19f3 cd fe 19   M..
        ldh     a,(0c6h)        ; 19f6 f0 c6   pF
        dec     a               ; 19f8 3d   =
        ldh     (0c6h),a        ; 19f9 e0 c6   `F
        dec     de              ; 19fb 1b   .
        jr      l19e7           ; 19fc 18 e9   .i

l19fe:  ld      b,a             ; 19fe 47   G
l19ff:  ldh     a,(41h)         ; 19ff f0 41   pA
        and     3               ; 1a01 e6 03   f.
        jr      nz,l19ff        ; 1a03 20 fa    z
        ld      (hl),b          ; 1a05 70   p
        ret                     ; 1a06 c9   I

; Display Falling Blocks screen
l1a07:  call    l2820           ; 1a07 cd 20 28   M (
        xor     a               ; 1a0a af   /
        ld      (0c210h),a      ; 1a0b ea 10 c2   j.B
        ldh     (98h),a         ; 1a0e e0 98   `.
        ldh     (9ch),a         ; 1a10 e0 9c   `.
        ldh     (9bh),a         ; 1a12 e0 9b   `.
        ldh     (0fbh),a        ; 1a14 e0 fb   `{
        ldh     (9fh),a         ; 1a16 e0 9f   `.
        ld      a,2fh           ; 1a18 3e 2f   >/
        call    l1fd7           ; 1a1a cd d7 1f   MW.
        call    l1ff2           ; 1a1d cd f2 1f   Mr.
        call    l2651           ; 1a20 cd 51 26   MQ&
        xor     a               ; 1a23 af   /
        ldh     (0e3h),a        ; 1a24 e0 e3   `c
        call    l178a           ; 1a26 cd 8a 17   M..
        ldh     a,(0c0h)        ; 1a29 f0 c0   p@
        ld      de,l3ff7        ; 1a2b 11 f7 3f   .w?
        ld      hl,0ffc3h       ; 1a2e 21 c3 ff   !C.
        cp      77h             ; 1a31 fe 77   .w
        ld      a,50h           ; 1a33 3e 50   >P
        jr      z,l1a3f         ; 1a35 28 08   (.
        ld      a,0f1h          ; 1a37 3e f1   >q
        ld      hl,0ffc2h       ; 1a39 21 c2 ff   !B.
        ld      de,l3e8f        ; 1a3c 11 8f 3e   ..>
l1a3f:  push    de              ; 1a3f d5   U
        ldh     (0e6h),a        ; 1a40 e0 e6   `f
        ld      a,(hl)          ; 1a42 7e   .
        ldh     (0a9h),a        ; 1a43 e0 a9   `)
        call    l27eb           ; 1a45 cd eb 27   Mk'
        pop     de              ; 1a48 d1   Q
        ld      hl,9c00h        ; 1a49 21 00 9c   !..
        call    l27ee           ; 1a4c cd ee 27   Mn'
        ld      de,l2839        ; 1a4f 11 39 28   .9(
        ld      hl,9c63h        ; 1a52 21 63 9c   !c.
        ld      c,0ah           ; 1a55 0e 0a   ..
        call    l1f7d           ; 1a57 cd 7d 1f   M}.
        ld      h,98h           ; 1a5a 26 98   &.
        ldh     a,(0e6h)        ; 1a5c f0 e6   pf
        ld      l,a             ; 1a5e 6f   o
        ldh     a,(0a9h)        ; 1a5f f0 a9   p)
        ld      (hl),a          ; 1a61 77   w
        ld      h,9ch           ; 1a62 26 9c   &.
        ld      (hl),a          ; 1a64 77   w
        ldh     a,(0f4h)        ; 1a65 f0 f4   pt
        and     a               ; 1a67 a7   '
        jr      z,l1a71         ; 1a68 28 07   (.
        inc     hl              ; 1a6a 23   #
        ld      (hl),27h        ; 1a6b 36 27   6'
        ld      h,98h           ; 1a6d 26 98   &.
        ld      (hl),27h        ; 1a6f 36 27   6'
l1a71:  ld      hl,0c200h       ; 1a71 21 00 c2   !.B
        ld      de,l26bf        ; 1a74 11 bf 26   .?&
        call    l26b6           ; 1a77 cd b6 26   M6&
        ld      hl,0c210h       ; 1a7a 21 10 c2   !.B
        ld      de,l26c7        ; 1a7d 11 c7 26   .G&
        call    l26b6           ; 1a80 cd b6 26   M6&
        ld      hl,9951h        ; 1a83 21 51 99   !Q.
        ldh     a,(0c0h)        ; 1a86 f0 c0   p@
        cp      77h             ; 1a88 fe 77   .w
        ld      a,25h           ; 1a8a 3e 25   >%
        jr      z,l1a8f         ; 1a8c 28 01   (.
        xor     a               ; 1a8e af   /
l1a8f:  ldh     (9eh),a         ; 1a8f e0 9e   `.
        and     0fh             ; 1a91 e6 0f   f.
        ldd     (hl),a          ; 1a93 32   2
        jr      z,l1a98         ; 1a94 28 02   (.
        ld      (hl),2          ; 1a96 36 02   6.
l1a98:  call    l1ae8           ; 1a98 cd e8 1a   Mh.
        ld      a,(0c0deh)      ; 1a9b fa de c0   z^@
        and     a               ; 1a9e a7   '
        jr      z,l1aa6         ; 1a9f 28 05   (.
        ld      a,80h           ; 1aa1 3e 80   >.
        ld      (0c210h),a      ; 1aa3 ea 10 c2   j.B
l1aa6:  call    l2007           ; 1aa6 cd 07 20   M. 
        call    l2007           ; 1aa9 cd 07 20   M. 
        call    l2007           ; 1aac cd 07 20   M. 
        call    l2683           ; 1aaf cd 83 26   M.&
        xor     a               ; 1ab2 af   /
        ldh     (0a0h),a        ; 1ab3 e0 a0   ` 
        ldh     a,(0c0h)        ; 1ab5 f0 c0   p@
        cp      77h             ; 1ab7 fe 77   .w
        jr      nz,l1ae0        ; 1ab9 20 25    %
        ld      a,34h           ; 1abb 3e 34   >4
        ldh     (99h),a         ; 1abd e0 99   `.
        ldh     a,(0c4h)        ; 1abf f0 c4   pD
        ld      hl,98b0h        ; 1ac1 21 b0 98   !0.
        ld      (hl),a          ; 1ac4 77   w
        ld      h,9ch           ; 1ac5 26 9c   &.
        ld      (hl),a          ; 1ac7 77   w
        and     a               ; 1ac8 a7   '
        jr      z,l1ae0         ; 1ac9 28 15   (.
        ld      b,a             ; 1acb 47   G
        ldh     a,(0e4h)        ; 1acc f0 e4   pd
        and     a               ; 1ace a7   '
        jr      z,l1ad6         ; 1acf 28 05   (.
        call    l1b1b           ; 1ad1 cd 1b 1b   M..
        jr      l1ae0           ; 1ad4 18 0a   ..

l1ad6:  ld      a,b             ; 1ad6 78   x
        ld      de,0ffc0h       ; 1ad7 11 c0 ff   .@.
        ld      hl,9a02h        ; 1ada 21 02 9a   !..
        call    l1b68           ; 1add cd 68 1b   Mh.
l1ae0:  ld      a,0d3h          ; 1ae0 3e d3   >S
        ldh     (40h),a         ; 1ae2 e0 40   `@
        xor     a               ; 1ae4 af   /
        ldh     (0e1h),a        ; 1ae5 e0 e1   `a
        ret                     ; 1ae7 c9   I

l1ae8:  ldh     a,(0a9h)        ; 1ae8 f0 a9   p)
        ld      e,a             ; 1aea 5f   _
        ldh     a,(0f4h)        ; 1aeb f0 f4   pt
        and     a               ; 1aed a7   '
        jr      z,l1afa         ; 1aee 28 0a   (.
        ld      a,0ah           ; 1af0 3e 0a   >.
        add     a,e             ; 1af2 83   .
        cp      15h             ; 1af3 fe 15   ..
        jr      c,l1af9         ; 1af5 38 02   8.
        ld      a,14h           ; 1af7 3e 14   >.
l1af9:  ld      e,a             ; 1af9 5f   _
l1afa:  ld      hl,l1b06        ; 1afa 21 06 1b   !..
        ld      d,0             ; 1afd 16 00   ..
        add     hl,de           ; 1aff 19   .
        ld      a,(hl)          ; 1b00 7e   .
        ldh     (99h),a         ; 1b01 e0 99   `.
        ldh     (9ah),a         ; 1b03 e0 9a   `.
        ret                     ; 1b05 c9   I

l1b06:  .db     34h,30h,2ch,28h,24h,20h,1bh,15h,10h,0ah,9,8,7,6,5       ; 1b06 34 30 2c 28 24 20 1b 15 10 0a 09 08 07 06 05   40,($ .........
        .db     5,4,4,3,3,2     ; 1b15 05 04 04 03 03 02   ......

l1b1b:  ld      hl,99c2h        ; 1b1b 21 c2 99   !B.
        ld      de,l1b40        ; 1b1e 11 40 1b   .@.
        ld      c,4             ; 1b21 0e 04   ..
l1b23:  ld      b,0ah           ; 1b23 06 0a   ..
        push    hl              ; 1b25 e5   e
l1b26:  ld      a,(de)          ; 1b26 1a   .
        ld      (hl),a          ; 1b27 77   w
        push    hl              ; 1b28 e5   e
        ld      a,h             ; 1b29 7c   |
        add     a,30h           ; 1b2a c6 30   F0
        ld      h,a             ; 1b2c 67   g
        ld      a,(de)          ; 1b2d 1a   .
        ld      (hl),a          ; 1b2e 77   w
        pop     hl              ; 1b2f e1   a
        inc     l               ; 1b30 2c   ,
        inc     de              ; 1b31 13   .
        dec     b               ; 1b32 05   .
        jr      nz,l1b26        ; 1b33 20 f1    q
        pop     hl              ; 1b35 e1   a
        push    de              ; 1b36 d5   U
        ld      de,20h          ; 1b37 11 20 00   . .
        add     hl,de           ; 1b3a 19   .
        pop     de              ; 1b3b d1   Q
        dec     c               ; 1b3c 0d   .
        jr      nz,l1b23        ; 1b3d 20 e4    d
        ret                     ; 1b3f c9   I

l1b40:  .db     85h,2fh,82h,86h,83h,2fh,2fh,80h,82h,85h,2fh,82h,84h     ; 1b40 85 2f 82 86 83 2f 2f 80 82 85 2f 82 84   ./...//.../..
        .db     82h,83h,2fh,83h,2fh,87h,2fh,2fh,85h,2fh,83h,2fh,86h,82h ; 1b4d 82 83 2f 83 2f 87 2f 2f 85 2f 83 2f 86 82   ../././/././..
        .db     80h,81h,2fh,83h,2fh,86h,83h,2fh,85h,2fh,85h,2fh,2fh     ; 1b5b 80 81 2f 83 2f 86 83 2f 85 2f 85 2f 2f   .././../././/

l1b68:  ld      b,a             ; 1b68 47   G
l1b69:  dec     b               ; 1b69 05   .
        jr      z,l1b6f         ; 1b6a 28 03   (.
        add     hl,de           ; 1b6c 19   .
        jr      l1b69           ; 1b6d 18 fa   .z

l1b6f:  ldh     a,(4)           ; 1b6f f0 04   p.
        ld      b,a             ; 1b71 47   G
l1b72:  ld      a,80h           ; 1b72 3e 80   >.
l1b74:  dec     b               ; 1b74 05   .
        jr      z,l1b7f         ; 1b75 28 08   (.
        cp      80h             ; 1b77 fe 80   ..
        jr      nz,l1b72        ; 1b79 20 f7    w
        ld      a,2fh           ; 1b7b 3e 2f   >/
        jr      l1b74           ; 1b7d 18 f5   .u

l1b7f:  cp      2fh             ; 1b7f fe 2f   ./
        jr      z,l1b8b         ; 1b81 28 08   (.
        ldh     a,(4)           ; 1b83 f0 04   p.
        and     7               ; 1b85 e6 07   f.
        or      80h             ; 1b87 f6 80   v.
        jr      l1b8d           ; 1b89 18 02   ..

l1b8b:  ldh     (0a0h),a        ; 1b8b e0 a0   ` 
l1b8d:  push    af              ; 1b8d f5   u
        ld      a,l             ; 1b8e 7d   }
        and     0fh             ; 1b8f e6 0f   f.
        cp      0bh             ; 1b91 fe 0b   ..
        jr      nz,l1ba0        ; 1b93 20 0b    .
        ldh     a,(0a0h)        ; 1b95 f0 a0   p 
        cp      2fh             ; 1b97 fe 2f   ./
        jr      z,l1ba0         ; 1b99 28 05   (.
        pop     af              ; 1b9b f1   q
        ld      a,2fh           ; 1b9c 3e 2f   >/
        jr      l1ba1           ; 1b9e 18 01   ..

l1ba0:  pop     af              ; 1ba0 f1   q
l1ba1:  ld      (hl),a          ; 1ba1 77   w
        push    hl              ; 1ba2 e5   e
        push    af              ; 1ba3 f5   u
        ldh     a,(0c5h)        ; 1ba4 f0 c5   pE
        and     a               ; 1ba6 a7   '
        jr      nz,l1bad        ; 1ba7 20 04    .
        ld      de,3000h        ; 1ba9 11 00 30   ..0
        add     hl,de           ; 1bac 19   .
l1bad:  pop     af              ; 1bad f1   q
        ld      (hl),a          ; 1bae 77   w
        pop     hl              ; 1baf e1   a
        inc     hl              ; 1bb0 23   #
        ld      a,l             ; 1bb1 7d   }
        and     0fh             ; 1bb2 e6 0f   f.
        cp      0ch             ; 1bb4 fe 0c   ..
        jr      nz,l1b6f        ; 1bb6 20 b7    7
        xor     a               ; 1bb8 af   /
        ldh     (0a0h),a        ; 1bb9 e0 a0   ` 
        ld      a,h             ; 1bbb 7c   |
        and     0fh             ; 1bbc e6 0f   f.
        cp      0ah             ; 1bbe fe 0a   ..
        jr      z,l1bc8         ; 1bc0 28 06   (.
l1bc2:  ld      de,16h          ; 1bc2 11 16 00   ...
        add     hl,de           ; 1bc5 19   .
        jr      l1b6f           ; 1bc6 18 a7   .'

l1bc8:  ld      a,l             ; 1bc8 7d   }
        cp      2ch             ; 1bc9 fe 2c   .,
        jr      nz,l1bc2        ; 1bcb 20 f5    u
        ret                     ; 1bcd c9   I

l1bce:  call    l1c0d           ; 1bce cd 0d 1c   M..
        ldh     a,(0abh)        ; 1bd1 f0 ab   p+
        and     a               ; 1bd3 a7   '
        ret     nz              ; 1bd4 c0   @
        call    l050c           ; 1bd5 cd 0c 05   M..
        call    l0542           ; 1bd8 cd 42 05   MB.
        call    l0583           ; 1bdb cd 83 05   M..
        call    l24bb           ; 1bde cd bb 24   M;$
        call    l209c           ; 1be1 cd 9c 20   M. 
        call    l213e           ; 1be4 cd 3e 21   M>!
        call    l25a1           ; 1be7 cd a1 25   M!%
        call    l224d           ; 1bea cd 4d 22   MM"
        call    l1f91           ; 1bed cd 91 1f   M..
        call    l05b3           ; 1bf0 cd b3 05   M3.
        ret                     ; 1bf3 c9   I

l1bf4:  bit     2,a             ; 1bf4 cb 57   KW
        ret     z               ; 1bf6 c8   H
        ld      a,(0c0deh)      ; 1bf7 fa de c0   z^@
        xor     1               ; 1bfa ee 01   n.
        ld      (0c0deh),a      ; 1bfc ea de c0   j^@
        jr      z,l1c0a         ; 1bff 28 09   (.
        ld      a,80h           ; 1c01 3e 80   >.
l1c03:  ld      (0c210h),a      ; 1c03 ea 10 c2   j.B
        call    l2696           ; 1c06 cd 96 26   M.&
        ret                     ; 1c09 c9   I

l1c0a:  xor     a               ; 1c0a af   /
        jr      l1c03           ; 1c0b 18 f6   .v

l1c0d:  ldh     a,(80h)         ; 1c0d f0 80   p.
        and     0fh             ; 1c0f e6 0f   f.
        cp      0fh             ; 1c11 fe 0f   ..
        jp      z,l021b         ; 1c13 ca 1b 02   J..
        ldh     a,(0e4h)        ; 1c16 f0 e4   pd
        and     a               ; 1c18 a7   '
        ret     nz              ; 1c19 c0   @
        ldh     a,(81h)         ; 1c1a f0 81   p.
        bit     3,a             ; 1c1c cb 5f   K_
        jr      z,l1bf4         ; 1c1e 28 d4   (T
        ldh     a,(0c5h)        ; 1c20 f0 c5   pE
        and     a               ; 1c22 a7   '
        jr      nz,l1c6a        ; 1c23 20 45    E
        ld      hl,0ff40h       ; 1c25 21 40 ff   !@.
        ldh     a,(0abh)        ; 1c28 f0 ab   p+
        xor     1               ; 1c2a ee 01   n.
        ldh     (0abh),a        ; 1c2c e0 ab   `+
        jr      z,l1c5a         ; 1c2e 28 2a   (*
        set     3,(hl)          ; 1c30 cb de   K^
        ld      a,1             ; 1c32 3e 01   >.
        ld      (0df7fh),a      ; 1c34 ea 7f df   j._
        ld      hl,994eh        ; 1c37 21 4e 99   !N.
        ld      de,9d4eh        ; 1c3a 11 4e 9d   .N.
        ld      b,4             ; 1c3d 06 04   ..
l1c3f:  ldh     a,(41h)         ; 1c3f f0 41   pA
        and     3               ; 1c41 e6 03   f.
        jr      nz,l1c3f        ; 1c43 20 fa    z
        ldi     a,(hl)          ; 1c45 2a   *
        ld      (de),a          ; 1c46 12   .
        inc     de              ; 1c47 13   .
        dec     b               ; 1c48 05   .
        jr      nz,l1c3f        ; 1c49 20 f4    t
        ld      a,80h           ; 1c4b 3e 80   >.
l1c4d:  ld      (0c210h),a      ; 1c4d ea 10 c2   j.B
l1c50:  ld      (0c200h),a      ; 1c50 ea 00 c2   j.B
        call    l2683           ; 1c53 cd 83 26   M.&
        call    l2696           ; 1c56 cd 96 26   M.&
        ret                     ; 1c59 c9   I

l1c5a:  res     3,(hl)          ; 1c5a cb 9e   K.
        ld      a,2             ; 1c5c 3e 02   >.
        ld      (0df7fh),a      ; 1c5e ea 7f df   j._
        ld      a,(0c0deh)      ; 1c61 fa de c0   z^@
        and     a               ; 1c64 a7   '
        jr      z,l1c4d         ; 1c65 28 e6   (f
        xor     a               ; 1c67 af   /
        jr      l1c50           ; 1c68 18 e6   .f

l1c6a:  ldh     a,(0cbh)        ; 1c6a f0 cb   pK
        cp      29h             ; 1c6c fe 29   .)
        ret     nz              ; 1c6e c0   @
        ldh     a,(0abh)        ; 1c6f f0 ab   p+
        xor     1               ; 1c71 ee 01   n.
        ldh     (0abh),a        ; 1c73 e0 ab   `+
        jr      z,l1caa         ; 1c75 28 33   (3
        ld      a,1             ; 1c77 3e 01   >.
        ld      (0df7fh),a      ; 1c79 ea 7f df   j._
        ldh     a,(0d0h)        ; 1c7c f0 d0   pP
        ldh     (0f2h),a        ; 1c7e e0 f2   `r
        ldh     a,(0cfh)        ; 1c80 f0 cf   pO
        ldh     (0f1h),a        ; 1c82 e0 f1   `q
        call    l1ccb           ; 1c84 cd cb 1c   MK.
        ret                     ; 1c87 c9   I

l1c88:  ldh     a,(0abh)        ; 1c88 f0 ab   p+
        and     a               ; 1c8a a7   '
        ret     z               ; 1c8b c8   H
        ldh     a,(0cch)        ; 1c8c f0 cc   pL
        jr      z,l1cc9         ; 1c8e 28 39   (9
        xor     a               ; 1c90 af   /
        ldh     (0cch),a        ; 1c91 e0 cc   `L
        ldh     a,(0cbh)        ; 1c93 f0 cb   pK
        cp      29h             ; 1c95 fe 29   .)
        jr      nz,l1ca1        ; 1c97 20 08    .
        ld      a,94h           ; 1c99 3e 94   >.
        ldh     (0cfh),a        ; 1c9b e0 cf   `O
        ldh     (0ceh),a        ; 1c9d e0 ce   `N
        pop     hl              ; 1c9f e1   a
        ret                     ; 1ca0 c9   I

l1ca1:  xor     a               ; 1ca1 af   /
        ldh     (0cfh),a        ; 1ca2 e0 cf   `O
        ldh     a,(0d0h)        ; 1ca4 f0 d0   pP
        cp      94h             ; 1ca6 fe 94   ..
        jr      z,l1cc9         ; 1ca8 28 1f   (.
l1caa:  ldh     a,(0f2h)        ; 1caa f0 f2   pr
        ldh     (0d0h),a        ; 1cac e0 d0   `P
        ldh     a,(0f1h)        ; 1cae f0 f1   pq
        ldh     (0cfh),a        ; 1cb0 e0 cf   `O
        ld      a,2             ; 1cb2 3e 02   >.
        ld      (0df7fh),a      ; 1cb4 ea 7f df   j._
        xor     a               ; 1cb7 af   /
        ldh     (0abh),a        ; 1cb8 e0 ab   `+
        ld      hl,98eeh        ; 1cba 21 ee 98   !n.
        ld      b,8eh           ; 1cbd 06 8e   ..
        ld      c,5             ; 1cbf 0e 05   ..
l1cc1:  call    l19ff           ; 1cc1 cd ff 19   M..
        inc     l               ; 1cc4 2c   ,
        dec     c               ; 1cc5 0d   .
        jr      nz,l1cc1        ; 1cc6 20 f9    y
        ret                     ; 1cc8 c9   I

l1cc9:  pop     hl              ; 1cc9 e1   a
        ret                     ; 1cca c9   I

l1ccb:  ld      hl,98eeh        ; 1ccb 21 ee 98   !n.
        ld      c,5             ; 1cce 0e 05   ..
        ld      de,l1cdd        ; 1cd0 11 dd 1c   .].
l1cd3:  ld      a,(de)          ; 1cd3 1a   .
        call    l19fe           ; 1cd4 cd fe 19   M..
        inc     de              ; 1cd7 13   .
        inc     l               ; 1cd8 2c   ,
        dec     c               ; 1cd9 0d   .
        jr      nz,l1cd3        ; 1cda 20 f7    w
        ret                     ; 1cdc c9   I

l1cdd:  .db     19h,0ah,1eh,1ch,0eh     ; 1cdd 19 0a 1e 1c 0e   .....

l1ce2:  ld      a,80h           ; 1ce2 3e 80   >.
        ld      (0c200h),a      ; 1ce4 ea 00 c2   j.B
        ld      (0c210h),a      ; 1ce7 ea 10 c2   j.B
        call    l2683           ; 1cea cd 83 26   M.&
        call    l2696           ; 1ced cd 96 26   M.&
        xor     a               ; 1cf0 af   /
        ldh     (98h),a         ; 1cf1 e0 98   `.
        ldh     (9ch),a         ; 1cf3 e0 9c   `.
        call    l2293           ; 1cf5 cd 93 22   M."
        ld      a,87h           ; 1cf8 3e 87   >.
        call    l1fd7           ; 1cfa cd d7 1f   MW.
        ld      a,46h           ; 1cfd 3e 46   >F
        ldh     (0a6h),a        ; 1cff e0 a6   `&
        ld      a,0dh           ; 1d01 3e 0d   >.
        ldh     (0e1h),a        ; 1d03 e0 e1   `a
        ret                     ; 1d05 c9   I

l1d06:  ldh     a,(81h)         ; 1d06 f0 81   p.
        bit     0,a             ; 1d08 cb 47   KG
        jr      nz,l1d0f        ; 1d0a 20 03    .
        bit     3,a             ; 1d0c cb 5f   K_
        ret     z               ; 1d0e c8   H
l1d0f:  xor     a               ; 1d0f af   /
        ldh     (0e3h),a        ; 1d10 e0 e3   `c
        ldh     a,(0c5h)        ; 1d12 f0 c5   pE
        and     a               ; 1d14 a7   '
        ld      a,16h           ; 1d15 3e 16   >.
        jr      nz,l1d23        ; 1d17 20 0a    .
        ldh     a,(0c0h)        ; 1d19 f0 c0   p@
        cp      37h             ; 1d1b fe 37   .7
        ld      a,10h           ; 1d1d 3e 10   >.
        jr      z,l1d23         ; 1d1f 28 02   (.
        ld      a,12h           ; 1d21 3e 12   >.
l1d23:  ldh     (0e1h),a        ; 1d23 e0 e1   `a
        ret                     ; 1d25 c9   I

l1d26:  ldh     a,(0a6h)        ; 1d26 f0 a6   p&
        and     a               ; 1d28 a7   '
        ret     nz              ; 1d29 c0   @
        ld      hl,0c802h       ; 1d2a 21 02 c8   !.H
        ld      de,l2889        ; 1d2d 11 89 28   ..(
        call    l2804           ; 1d30 cd 04 28   M.(
        ldh     a,(0c3h)        ; 1d33 f0 c3   pC
        and     a               ; 1d35 a7   '
        jr      z,l1d66         ; 1d36 28 2e   (.
        ld      de,40h          ; 1d38 11 40 00   .@.
        ld      hl,0c827h       ; 1d3b 21 27 c8   !'H
        call    l1d84           ; 1d3e cd 84 1d   M..
        ld      de,100h         ; 1d41 11 00 01   ...
        ld      hl,0c887h       ; 1d44 21 87 c8   !.H
        call    l1d84           ; 1d47 cd 84 1d   M..
        ld      de,300h         ; 1d4a 11 00 03   ...
        ld      hl,0c8e7h       ; 1d4d 21 e7 c8   !gH
        call    l1d84           ; 1d50 cd 84 1d   M..
        ld      de,1200h        ; 1d53 11 00 12   ...
        ld      hl,0c947h       ; 1d56 21 47 c9   !GI
        call    l1d84           ; 1d59 cd 84 1d   M..
        ld      hl,0c0a0h       ; 1d5c 21 a0 c0   ! @
        ld      b,3             ; 1d5f 06 03   ..
        xor     a               ; 1d61 af   /
l1d62:  ldi     (hl),a          ; 1d62 22   "
        dec     b               ; 1d63 05   .
        jr      nz,l1d62        ; 1d64 20 fc    |
l1d66:  ld      a,80h           ; 1d66 3e 80   >.
        ldh     (0a6h),a        ; 1d68 e0 a6   `&
        ld      a,80h           ; 1d6a 3e 80   >.
        ld      (0c200h),a      ; 1d6c ea 00 c2   j.B
        ld      (0c210h),a      ; 1d6f ea 10 c2   j.B
        call    l2683           ; 1d72 cd 83 26   M.&
        call    l2696           ; 1d75 cd 96 26   M.&
        call    l7ff3           ; 1d78 cd f3 7f   Ms.
        ld      a,25h           ; 1d7b 3e 25   >%
        ldh     (9eh),a         ; 1d7d e0 9e   `.
        ld      a,0bh           ; 1d7f 3e 0b   >.
        ldh     (0e1h),a        ; 1d81 e0 e1   `a
        ret                     ; 1d83 c9   I

l1d84:  push    hl              ; 1d84 e5   e
        ld      hl,0c0a0h       ; 1d85 21 a0 c0   ! @
        ld      b,3             ; 1d88 06 03   ..
        xor     a               ; 1d8a af   /
l1d8b:  ldi     (hl),a          ; 1d8b 22   "
        dec     b               ; 1d8c 05   .
        jr      nz,l1d8b        ; 1d8d 20 fc    |
        ldh     a,(0c3h)        ; 1d8f f0 c3   pC
        ld      b,a             ; 1d91 47   G
        inc     b               ; 1d92 04   .
l1d93:  ld      hl,0c0a0h       ; 1d93 21 a0 c0   ! @
        call    l0166           ; 1d96 cd 66 01   Mf.
        dec     b               ; 1d99 05   .
        jr      nz,l1d93        ; 1d9a 20 f7    w
        pop     hl              ; 1d9c e1   a
        ld      b,3             ; 1d9d 06 03   ..
        ld      de,0c0a2h       ; 1d9f 11 a2 c0   ."@
l1da2:  ld      a,(de)          ; 1da2 1a   .
        and     0f0h            ; 1da3 e6 f0   fp
        jr      nz,l1db1        ; 1da5 20 0a    .
        ld      a,(de)          ; 1da7 1a   .
        and     0fh             ; 1da8 e6 0f   f.
        jr      nz,l1db7        ; 1daa 20 0b    .
        dec     e               ; 1dac 1d   .
        dec     b               ; 1dad 05   .
        jr      nz,l1da2        ; 1dae 20 f2    r
        ret                     ; 1db0 c9   I

l1db1:  ld      a,(de)          ; 1db1 1a   .
        and     0f0h            ; 1db2 e6 f0   fp
        swap    a               ; 1db4 cb 37   K7
        ldi     (hl),a          ; 1db6 22   "
l1db7:  ld      a,(de)          ; 1db7 1a   .
        and     0fh             ; 1db8 e6 0f   f.
        ldi     (hl),a          ; 1dba 22   "
        dec     e               ; 1dbb 1d   .
        dec     b               ; 1dbc 05   .
        jr      nz,l1db1        ; 1dbd 20 f2    r
        ret                     ; 1dbf c9   I

l1dc0:  ldh     a,(0a6h)        ; 1dc0 f0 a6   p&
        and     a               ; 1dc2 a7   '
        ret     nz              ; 1dc3 c0   @
        ld      a,1             ; 1dc4 3e 01   >.
        ld      (0c0c6h),a      ; 1dc6 ea c6 c0   jF@
        ld      a,5             ; 1dc9 3e 05   >.
        ldh     (0a6h),a        ; 1dcb e0 a6   `&
        ret                     ; 1dcd c9   I

l1dce:  ldh     a,(0a6h)        ; 1dce f0 a6   p&
        and     a               ; 1dd0 a7   '
        ret     nz              ; 1dd1 c0   @
        ld      hl,0c802h       ; 1dd2 21 02 c8   !.H
        ld      de,l510f        ; 1dd5 11 0f 51   ..Q
        call    l2804           ; 1dd8 cd 04 28   M.(
        call    l178a           ; 1ddb cd 8a 17   M..
        ld      hl,0c200h       ; 1dde 21 00 c2   !.B
        ld      de,l2735        ; 1de1 11 35 27   .5'
        ld      c,0ah           ; 1de4 0e 0a   ..
        call    l1776           ; 1de6 cd 76 17   Mv.
        ld      a,10h           ; 1de9 3e 10   >.
        ld      hl,0c266h       ; 1deb 21 66 c2   !fB
        ld      (hl),a          ; 1dee 77   w
        ld      l,76h           ; 1def 2e 76   .v
        ld      (hl),a          ; 1df1 77   w
        ld      hl,0c20eh       ; 1df2 21 0e c2   !.B
        ld      de,l1e31        ; 1df5 11 31 1e   .1.
        ld      b,0ah           ; 1df8 06 0a   ..
l1dfa:  ld      a,(de)          ; 1dfa 1a   .
        ldi     (hl),a          ; 1dfb 22   "
        ldi     (hl),a          ; 1dfc 22   "
        inc     de              ; 1dfd 13   .
        push    de              ; 1dfe d5   U
        ld      de,0eh          ; 1dff 11 0e 00   ...
        add     hl,de           ; 1e02 19   .
        pop     de              ; 1e03 d1   Q
        dec     b               ; 1e04 05   .
        jr      nz,l1dfa        ; 1e05 20 f3    s
        ldh     a,(0c4h)        ; 1e07 f0 c4   pD
        cp      5               ; 1e09 fe 05   ..
        jr      nz,l1e0f        ; 1e0b 20 02    .
        ld      a,9             ; 1e0d 3e 09   >.
l1e0f:  inc     a               ; 1e0f 3c   <
        ld      b,a             ; 1e10 47   G
        ld      hl,0c200h       ; 1e11 21 00 c2   !.B
        ld      de,10h          ; 1e14 11 10 00   ...
        xor     a               ; 1e17 af   /
l1e18:  ld      (hl),a          ; 1e18 77   w
        add     hl,de           ; 1e19 19   .
        dec     b               ; 1e1a 05   .
        jr      nz,l1e18        ; 1e1b 20 fb    {
        ldh     a,(0c4h)        ; 1e1d f0 c4   pD
        add     a,0ah           ; 1e1f c6 0a   F.
        ld      (0dfe8h),a      ; 1e21 ea e8 df   jh_
        ld      a,25h           ; 1e24 3e 25   >%
        ldh     (9eh),a         ; 1e26 e0 9e   `.
        ld      a,1bh           ; 1e28 3e 1b   >.
        ldh     (0a6h),a        ; 1e2a e0 a6   `&
        ld      a,23h           ; 1e2c 3e 23   >#
        ldh     (0e1h),a        ; 1e2e e0 e1   `a
        ret                     ; 1e30 c9   I

l1e31:  inc     e               ; 1e31 1c   .
        rrca                    ; 1e32 0f   .
        ld      e,32h           ; 1e33 1e 32   .2
        jr      nz,l1e4f        ; 1e35 20 18    .
        ld      h,1dh           ; 1e37 26 1d   &.
        jr      z,l1e66         ; 1e39 28 2b   (+
l1e3b:  ld      a,0ah           ; 1e3b 3e 0a   >.
        call    l2673           ; 1e3d cd 73 26   Ms&
        ret                     ; 1e40 c9   I

l1e41:  ldh     a,(0a6h)        ; 1e41 f0 a6   p&
        cp      14h             ; 1e43 fe 14   ..
        jr      z,l1e3b         ; 1e45 28 f4   (t
        and     a               ; 1e47 a7   '
        ret     nz              ; 1e48 c0   @
        ld      hl,0c20eh       ; 1e49 21 0e c2   !.B
        ld      de,10h          ; 1e4c 11 10 00   ...
l1e4f:  ld      b,0ah           ; 1e4f 06 0a   ..
l1e51:  push    hl              ; 1e51 e5   e
        dec     (hl)            ; 1e52 35   5
        jr      nz,l1e6a        ; 1e53 20 15    .
        inc     l               ; 1e55 2c   ,
        ldd     a,(hl)          ; 1e56 3a   :
        ld      (hl),a          ; 1e57 77   w
        ld      a,l             ; 1e58 7d   }
        and     0f0h            ; 1e59 e6 f0   fp
        or      3               ; 1e5b f6 03   v.
        ld      l,a             ; 1e5d 6f   o
        ld      a,(hl)          ; 1e5e 7e   .
        xor     1               ; 1e5f ee 01   n.
        ld      (hl),a          ; 1e61 77   w
        cp      50h             ; 1e62 fe 50   .P
        jr      z,l1e89         ; 1e64 28 23   (#
l1e66:  cp      51h             ; 1e66 fe 51   .Q
        jr      z,l1e8f         ; 1e68 28 25   (%
l1e6a:  pop     hl              ; 1e6a e1   a
        add     hl,de           ; 1e6b 19   .
        dec     b               ; 1e6c 05   .
        jr      nz,l1e51        ; 1e6d 20 e2    b
        ld      a,0ah           ; 1e6f 3e 0a   >.
        call    l2673           ; 1e71 cd 73 26   Ms&
        ld      a,(0dfe9h)      ; 1e74 fa e9 df   zi_
        and     a               ; 1e77 a7   '
        ret     nz              ; 1e78 c0   @
        call    l178a           ; 1e79 cd 8a 17   M..
        ldh     a,(0c4h)        ; 1e7c f0 c4   pD
        cp      5               ; 1e7e fe 05   ..
        ld      a,26h           ; 1e80 3e 26   >&
        jr      z,l1e86         ; 1e82 28 02   (.
        ld      a,5             ; 1e84 3e 05   >.
l1e86:  ldh     (0e1h),a        ; 1e86 e0 e1   `a
        ret                     ; 1e88 c9   I

l1e89:  dec     l               ; 1e89 2d   -
        dec     l               ; 1e8a 2d   -
        ld      (hl),67h        ; 1e8b 36 67   6g
        jr      l1e6a           ; 1e8d 18 db   .[

l1e8f:  dec     l               ; 1e8f 2d   -
        dec     l               ; 1e90 2d   -
        ld      (hl),5dh        ; 1e91 36 5d   6]
        jr      l1e6a           ; 1e93 18 d5   .U

l1e95:  xor     a               ; 1e95 af   /
        ld      (0c0c6h),a      ; 1e96 ea c6 c0   jF@
        ld      de,0c0c0h       ; 1e99 11 c0 c0   .@@
        ld      a,(de)          ; 1e9c 1a   .
        ld      l,a             ; 1e9d 6f   o
        inc     de              ; 1e9e 13   .
        ld      a,(de)          ; 1e9f 1a   .
        ld      h,a             ; 1ea0 67   g
        or      l               ; 1ea1 b5   5
        jp      z,l263a         ; 1ea2 ca 3a 26   J:&
        dec     hl              ; 1ea5 2b   +
        ld      a,h             ; 1ea6 7c   |
        ld      (de),a          ; 1ea7 12   .
        dec     de              ; 1ea8 1b   .
        ld      a,l             ; 1ea9 7d   }
        ld      (de),a          ; 1eaa 12   .
        ld      de,1            ; 1eab 11 01 00   ...
        ld      hl,0c0c2h       ; 1eae 21 c2 c0   !B@
        push    de              ; 1eb1 d5   U
        call    l0166           ; 1eb2 cd 66 01   Mf.
        ld      de,0c0c4h       ; 1eb5 11 c4 c0   .D@
        ld      hl,99a5h        ; 1eb8 21 a5 99   !%.
        call    l2a36           ; 1ebb cd 36 2a   M6*
        xor     a               ; 1ebe af   /
        ldh     (0a6h),a        ; 1ebf e0 a6   `&
        pop     de              ; 1ec1 d1   Q
        ld      hl,0c0a0h       ; 1ec2 21 a0 c0   ! @
        call    l0166           ; 1ec5 cd 66 01   Mf.
        ld      de,0c0a2h       ; 1ec8 11 a2 c0   ."@
        ld      hl,9a25h        ; 1ecb 21 25 9a   !%.
        call    l2a3a           ; 1ece cd 3a 2a   M:*
        ld      a,2             ; 1ed1 3e 02   >.
        ld      (0dfe0h),a      ; 1ed3 ea e0 df   j`_
        ret                     ; 1ed6 c9   I

l1ed7:  ld      a,(0c0c6h)      ; 1ed7 fa c6 c0   zF@
        and     a               ; 1eda a7   '
        ret     z               ; 1edb c8   H
        ld      a,(0c0c5h)      ; 1edc fa c5 c0   zE@
        cp      4               ; 1edf fe 04   ..
        jr      z,l1e95         ; 1ee1 28 b2   (2
        ld      de,40h          ; 1ee3 11 40 00   .@.
        ld      bc,9823h        ; 1ee6 01 23 98   .#.
        ld      hl,0c0ach       ; 1ee9 21 ac c0   !,@
        and     a               ; 1eec a7   '
        jr      z,l1f12         ; 1eed 28 23   (#
        ld      de,100h         ; 1eef 11 00 01   ...
        ld      bc,9883h        ; 1ef2 01 83 98   ...
        ld      hl,0c0b1h       ; 1ef5 21 b1 c0   !1@
        cp      1               ; 1ef8 fe 01   ..
        jr      z,l1f12         ; 1efa 28 16   (.
        ld      de,300h         ; 1efc 11 00 03   ...
        ld      bc,98e3h        ; 1eff 01 e3 98   .c.
        ld      hl,0c0b6h       ; 1f02 21 b6 c0   !6@
        cp      2               ; 1f05 fe 02   ..
        jr      z,l1f12         ; 1f07 28 09   (.
        ld      de,1200h        ; 1f09 11 00 12   ...
        ld      bc,9943h        ; 1f0c 01 43 99   .C.
        ld      hl,0c0bbh       ; 1f0f 21 bb c0   !;@
l1f12:  call    l25d9           ; 1f12 cd d9 25   MY%
        ret                     ; 1f15 c9   I

l1f16:  ldh     a,(81h)         ; 1f16 f0 81   p.
        and     a               ; 1f18 a7   '
        ret     z               ; 1f19 c8   H
        ld      a,2             ; 1f1a 3e 02   >.
        ldh     (0e1h),a        ; 1f1c e0 e1   `a
        ret                     ; 1f1e c9   I

l1f1f:  ldh     a,(0a6h)        ; 1f1f f0 a6   p&
        and     a               ; 1f21 a7   '
        ret     nz              ; 1f22 c0   @
        ld      a,4             ; 1f23 3e 04   >.
        ld      (0dfe8h),a      ; 1f25 ea e8 df   jh_
        ldh     a,(0c5h)        ; 1f28 f0 c5   pE
        and     a               ; 1f2a a7   '
        jr      z,l1f37         ; 1f2b 28 0a   (.
        ld      a,3fh           ; 1f2d 3e 3f   >?
        ldh     (0a6h),a        ; 1f2f e0 a6   `&
        ld      a,1bh           ; 1f31 3e 1b   >.
        ldh     (0cch),a        ; 1f33 e0 cc   `L
        jr      l1f6e           ; 1f35 18 37   .7

l1f37:  ld      a,2fh           ; 1f37 3e 2f   >/
        call    l1fd7           ; 1f39 cd d7 1f   MW.
        ld      hl,0c843h       ; 1f3c 21 43 c8   !CH
        ld      de,l293e        ; 1f3f 11 3e 29   .>)
        ld      c,7             ; 1f42 0e 07   ..
        call    l1f7d           ; 1f44 cd 7d 1f   M}.
        ld      hl,0c983h       ; 1f47 21 83 c9   !.I
        ld      de,l2976        ; 1f4a 11 76 29   .v)
        ld      c,6             ; 1f4d 0e 06   ..
        call    l1f7d           ; 1f4f cd 7d 1f   M}.
        ldh     a,(0c0h)        ; 1f52 f0 c0   p@
        cp      37h             ; 1f54 fe 37   .7
        jr      nz,l1f6c        ; 1f56 20 14    .
        ld      hl,0c0a2h       ; 1f58 21 a2 c0   !"@
        ld      a,(hl)          ; 1f5b 7e   .
        ld      b,58h           ; 1f5c 06 58   .X
        cp      20h             ; 1f5e fe 20   . 
        jr      nc,l1f71        ; 1f60 30 0f   0.
        inc     b               ; 1f62 04   .
        cp      15h             ; 1f63 fe 15   ..
        jr      nc,l1f71        ; 1f65 30 0a   0.
        inc     b               ; 1f67 04   .
        cp      10h             ; 1f68 fe 10   ..
        jr      nc,l1f71        ; 1f6a 30 05   0.
l1f6c:  ld      a,4             ; 1f6c 3e 04   >.
l1f6e:  ldh     (0e1h),a        ; 1f6e e0 e1   `a
        ret                     ; 1f70 c9   I

l1f71:  ld      a,b             ; 1f71 78   x
        ldh     (0f3h),a        ; 1f72 e0 f3   `s
        ld      a,90h           ; 1f74 3e 90   >.
        ldh     (0a6h),a        ; 1f76 e0 a6   `&
        ld      a,34h           ; 1f78 3e 34   >4
        ldh     (0e1h),a        ; 1f7a e0 e1   `a
        ret                     ; 1f7c c9   I

l1f7d:  ld      b,8             ; 1f7d 06 08   ..
        push    hl              ; 1f7f e5   e
l1f80:  ld      a,(de)          ; 1f80 1a   .
        ldi     (hl),a          ; 1f81 22   "
        inc     de              ; 1f82 13   .
        dec     b               ; 1f83 05   .
        jr      nz,l1f80        ; 1f84 20 fa    z
        pop     hl              ; 1f86 e1   a
        push    de              ; 1f87 d5   U
        ld      de,20h          ; 1f88 11 20 00   . .
        add     hl,de           ; 1f8b 19   .
        pop     de              ; 1f8c d1   Q
        dec     c               ; 1f8d 0d   .
        jr      nz,l1f7d        ; 1f8e 20 ed    m
        ret                     ; 1f90 c9   I

l1f91:  ldh     a,(0c0h)        ; 1f91 f0 c0   p@
        cp      37h             ; 1f93 fe 37   .7
        ret     nz              ; 1f95 c0   @
        ldh     a,(0e1h)        ; 1f96 f0 e1   pa
        and     a               ; 1f98 a7   '
        ret     nz              ; 1f99 c0   @
        ldh     a,(0e3h)        ; 1f9a f0 e3   pc
        cp      5               ; 1f9c fe 05   ..
        ret     nz              ; 1f9e c0   @
        ld      hl,0c0ach       ; 1f9f 21 ac c0   !,@
        ld      bc,5            ; 1fa2 01 05 00   ...
        ld      a,(hl)          ; 1fa5 7e   .
        ld      de,40h          ; 1fa6 11 40 00   .@.
        and     a               ; 1fa9 a7   '
        jr      nz,l1fc3        ; 1faa 20 17    .
        add     hl,bc           ; 1fac 09   .
        ld      a,(hl)          ; 1fad 7e   .
        ld      de,100h         ; 1fae 11 00 01   ...
        and     a               ; 1fb1 a7   '
        jr      nz,l1fc3        ; 1fb2 20 0f    .
        add     hl,bc           ; 1fb4 09   .
        ld      a,(hl)          ; 1fb5 7e   .
        ld      de,300h         ; 1fb6 11 00 03   ...
        and     a               ; 1fb9 a7   '
        jr      nz,l1fc3        ; 1fba 20 07    .
        add     hl,bc           ; 1fbc 09   .
        ld      de,1200h        ; 1fbd 11 00 12   ...
        ld      a,(hl)          ; 1fc0 7e   .
        and     a               ; 1fc1 a7   '
        ret     z               ; 1fc2 c8   H
l1fc3:  ld      (hl),0          ; 1fc3 36 00   6.
        ldh     a,(0a9h)        ; 1fc5 f0 a9   p)
        ld      b,a             ; 1fc7 47   G
        inc     b               ; 1fc8 04   .
l1fc9:  push    bc              ; 1fc9 c5   E
        push    de              ; 1fca d5   U
        ld      hl,0c0a0h       ; 1fcb 21 a0 c0   ! @
        call    l0166           ; 1fce cd 66 01   Mf.
        pop     de              ; 1fd1 d1   Q
        pop     bc              ; 1fd2 c1   A
        dec     b               ; 1fd3 05   .
        jr      nz,l1fc9        ; 1fd4 20 f3    s
        ret                     ; 1fd6 c9   I

l1fd7:  push    af              ; 1fd7 f5   u
        ld      a,2             ; 1fd8 3e 02   >.
        ldh     (0e3h),a        ; 1fda e0 e3   `c
        pop     af              ; 1fdc f1   q
l1fdd:  ld      hl,0c802h       ; 1fdd 21 02 c8   !.H
        ld      c,12h           ; 1fe0 0e 12   ..
        ld      de,20h          ; 1fe2 11 20 00   . .
l1fe5:  push    hl              ; 1fe5 e5   e
        ld      b,0ah           ; 1fe6 06 0a   ..
l1fe8:  ldi     (hl),a          ; 1fe8 22   "
        dec     b               ; 1fe9 05   .
        jr      nz,l1fe8        ; 1fea 20 fc    |
        pop     hl              ; 1fec e1   a
        add     hl,de           ; 1fed 19   .
        dec     c               ; 1fee 0d   .
        jr      nz,l1fe5        ; 1fef 20 f4    t
        ret                     ; 1ff1 c9   I

l1ff2:  ld      hl,0cbc2h       ; 1ff2 21 c2 cb   !BK
        ld      de,16h          ; 1ff5 11 16 00   ...
        ld      c,2             ; 1ff8 0e 02   ..
        ld      a,2fh           ; 1ffa 3e 2f   >/
l1ffc:  ld      b,0ah           ; 1ffc 06 0a   ..
l1ffe:  ldi     (hl),a          ; 1ffe 22   "
        dec     b               ; 1fff 05   .
        jr      nz,l1ffe        ; 2000 20 fc    |
        add     hl,de           ; 2002 19   .
        dec     c               ; 2003 0d   .
        jr      nz,l1ffc        ; 2004 20 f6    v
        ret                     ; 2006 c9   I

l2007:  ld      hl,0c200h       ; 2007 21 00 c2   !.B
        ld      (hl),0          ; 200a 36 00   6.
        inc     l               ; 200c 2c   ,
        ld      (hl),18h        ; 200d 36 18   6.
        inc     l               ; 200f 2c   ,
        ld      (hl),3fh        ; 2010 36 3f   6?
        inc     l               ; 2012 2c   ,
        ld      a,(0c213h)      ; 2013 fa 13 c2   z.B
        ld      (hl),a          ; 2016 77   w
        and     0fch            ; 2017 e6 fc   f|
        ld      c,a             ; 2019 4f   O
        ldh     a,(0e4h)        ; 201a f0 e4   pd
        and     a               ; 201c a7   '
        jr      nz,l2024        ; 201d 20 05    .
        ldh     a,(0c5h)        ; 201f f0 c5   pE
        and     a               ; 2021 a7   '
        jr      z,l2041         ; 2022 28 1d   (.
l2024:  ld      h,0c3h          ; 2024 26 c3   &C
        ldh     a,(0b0h)        ; 2026 f0 b0   p0
        ld      l,a             ; 2028 6f   o
        ld      e,(hl)          ; 2029 5e   ^
        inc     hl              ; 202a 23   #
        ld      a,h             ; 202b 7c   |
        cp      0c4h            ; 202c fe c4   .D
        jr      nz,l2033        ; 202e 20 03    .
        ld      hl,0c300h       ; 2030 21 00 c3   !.C
l2033:  ld      a,l             ; 2033 7d   }
        ldh     (0b0h),a        ; 2034 e0 b0   `0
        ldh     a,(0d3h)        ; 2036 f0 d3   pS
        and     a               ; 2038 a7   '
        jr      z,l2065         ; 2039 28 2a   (*
        or      80h             ; 203b f6 80   v.
        ldh     (0d3h),a        ; 203d e0 d3   `S
        jr      l2065           ; 203f 18 24   .$

l2041:  ld      h,3             ; 2041 26 03   &.
l2043:  ldh     a,(4)           ; 2043 f0 04   p.
        ld      b,a             ; 2045 47   G
l2046:  xor     a               ; 2046 af   /
l2047:  dec     b               ; 2047 05   .
        jr      z,l2054         ; 2048 28 0a   (.
        inc     a               ; 204a 3c   <
        inc     a               ; 204b 3c   <
        inc     a               ; 204c 3c   <
        inc     a               ; 204d 3c   <
        cp      1ch             ; 204e fe 1c   ..
        jr      z,l2046         ; 2050 28 f4   (t
        jr      l2047           ; 2052 18 f3   .s

l2054:  ld      d,a             ; 2054 57   W
        ldh     a,(0aeh)        ; 2055 f0 ae   p.
        ld      e,a             ; 2057 5f   _
        dec     h               ; 2058 25   %
        jr      z,l2062         ; 2059 28 07   (.
        or      d               ; 205b b2   2
        or      c               ; 205c b1   1
        and     0fch            ; 205d e6 fc   f|
        cp      c               ; 205f b9   9
        jr      z,l2043         ; 2060 28 e1   (a
l2062:  ld      a,d             ; 2062 7a   z
        ldh     (0aeh),a        ; 2063 e0 ae   `.
l2065:  ld      a,e             ; 2065 7b   {
        ld      (0c213h),a      ; 2066 ea 13 c2   j.B
        call    l2696           ; 2069 cd 96 26   M.&
        ldh     a,(9ah)         ; 206c f0 9a   p.
        ldh     (99h),a         ; 206e e0 99   `.
        ret                     ; 2070 c9   I

l2071:  ld      a,(0c0c7h)      ; 2071 fa c7 c0   zG@
        and     a               ; 2074 a7   '
        jr      z,l2083         ; 2075 28 0c   (.
        ldh     a,(81h)         ; 2077 f0 81   p.
        and     0b0h            ; 2079 e6 b0   f0
        cp      80h             ; 207b fe 80   ..
        jr      nz,l20a4        ; 207d 20 25    %
        xor     a               ; 207f af   /
        ld      (0c0c7h),a      ; 2080 ea c7 c0   jG@
l2083:  ldh     a,(0a7h)        ; 2083 f0 a7   p'
        and     a               ; 2085 a7   '
        jr      nz,l20b1        ; 2086 20 29    )
        ldh     a,(98h)         ; 2088 f0 98   p.
        and     a               ; 208a a7   '
        jr      nz,l20b1        ; 208b 20 24    $
        ldh     a,(0e3h)        ; 208d f0 e3   pc
        and     a               ; 208f a7   '
        jr      nz,l20b1        ; 2090 20 1f    .
        ld      a,3             ; 2092 3e 03   >.
        ldh     (0a7h),a        ; 2094 e0 a7   `'
        ld      hl,0ffe5h       ; 2096 21 e5 ff   !e.
        inc     (hl)            ; 2099 34   4
        jr      l20c2           ; 209a 18 26   .&

l209c:  ldh     a,(80h)         ; 209c f0 80   p.
        and     0b0h            ; 209e e6 b0   f0
        cp      80h             ; 20a0 fe 80   ..
        jr      z,l2071         ; 20a2 28 cd   (M
l20a4:  ld      hl,0ffe5h       ; 20a4 21 e5 ff   !e.
        ld      (hl),0          ; 20a7 36 00   6.
        ldh     a,(99h)         ; 20a9 f0 99   p.
        and     a               ; 20ab a7   '
        jr      z,l20b5         ; 20ac 28 07   (.
        dec     a               ; 20ae 3d   =
        ldh     (99h),a         ; 20af e0 99   `.
l20b1:  call    l2683           ; 20b1 cd 83 26   M.&
        ret                     ; 20b4 c9   I

l20b5:  ldh     a,(98h)         ; 20b5 f0 98   p.
        cp      3               ; 20b7 fe 03   ..
        ret     z               ; 20b9 c8   H
        ldh     a,(0e3h)        ; 20ba f0 e3   pc
        and     a               ; 20bc a7   '
        ret     nz              ; 20bd c0   @
        ldh     a,(9ah)         ; 20be f0 9a   p.
        ldh     (99h),a         ; 20c0 e0 99   `.
l20c2:  ld      hl,0c201h       ; 20c2 21 01 c2   !.B
        ld      a,(hl)          ; 20c5 7e   .
        ldh     (0a0h),a        ; 20c6 e0 a0   ` 
        add     a,8             ; 20c8 c6 08   F.
        ld      (hl),a          ; 20ca 77   w
        call    l2683           ; 20cb cd 83 26   M.&
        call    l2573           ; 20ce cd 73 25   Ms%
        and     a               ; 20d1 a7   '
        ret     z               ; 20d2 c8   H
        ldh     a,(0a0h)        ; 20d3 f0 a0   p 
        ld      hl,0c201h       ; 20d5 21 01 c2   !.B
        ld      (hl),a          ; 20d8 77   w
        call    l2683           ; 20d9 cd 83 26   M.&
        ld      a,1             ; 20dc 3e 01   >.
        ldh     (98h),a         ; 20de e0 98   `.
        ld      (0c0c7h),a      ; 20e0 ea c7 c0   jG@
        ldh     a,(0e5h)        ; 20e3 f0 e5   pe
        and     a               ; 20e5 a7   '
        jr      z,l2103         ; 20e6 28 1b   (.
        ld      c,a             ; 20e8 4f   O
        ldh     a,(0c0h)        ; 20e9 f0 c0   p@
        cp      37h             ; 20eb fe 37   .7
        jr      z,l2126         ; 20ed 28 37   (7
        ld      de,0c0c0h       ; 20ef 11 c0 c0   .@@
        ld      a,(de)          ; 20f2 1a   .
        ld      l,a             ; 20f3 6f   o
        inc     de              ; 20f4 13   .
        ld      a,(de)          ; 20f5 1a   .
        ld      h,a             ; 20f6 67   g
        ld      b,0             ; 20f7 06 00   ..
        dec     c               ; 20f9 0d   .
        add     hl,bc           ; 20fa 09   .
        ld      a,h             ; 20fb 7c   |
        ld      (de),a          ; 20fc 12   .
        ld      a,l             ; 20fd 7d   }
        dec     de              ; 20fe 1b   .
        ld      (de),a          ; 20ff 12   .
l2100:  xor     a               ; 2100 af   /
        ldh     (0e5h),a        ; 2101 e0 e5   `e
l2103:  ld      a,(0c201h)      ; 2103 fa 01 c2   z.B
        cp      18h             ; 2106 fe 18   ..
        ret     nz              ; 2108 c0   @
        ld      a,(0c202h)      ; 2109 fa 02 c2   z.B
        cp      3fh             ; 210c fe 3f   .?
        ret     nz              ; 210e c0   @
        ld      hl,0fffbh       ; 210f 21 fb ff   !{.
        ld      a,(hl)          ; 2112 7e   .
        cp      1               ; 2113 fe 01   ..
        jr      nz,l2124        ; 2115 20 0d    .
        call    l7ff3           ; 2117 cd f3 7f   Ms.
        ld      a,1             ; 211a 3e 01   >.
        ldh     (0e1h),a        ; 211c e0 e1   `a
        ld      a,2             ; 211e 3e 02   >.
        ld      (0dff0h),a      ; 2120 ea f0 df   jp_
        ret                     ; 2123 c9   I

l2124:  inc     (hl)            ; 2124 34   4
        ret                     ; 2125 c9   I

l2126:  xor     a               ; 2126 af   /
l2127:  dec     c               ; 2127 0d   .
        jr      z,l212e         ; 2128 28 04   (.
        inc     a               ; 212a 3c   <
        daa                     ; 212b 27   '
        jr      l2127           ; 212c 18 f9   .y

l212e:  ld      e,a             ; 212e 5f   _
        ld      d,0             ; 212f 16 00   ..
        ld      hl,0c0a0h       ; 2131 21 a0 c0   ! @
        call    l0166           ; 2134 cd 66 01   Mf.
        ld      a,1             ; 2137 3e 01   >.
        ld      (0c0ceh),a      ; 2139 ea ce c0   jN@
        jr      l2100           ; 213c 18 c2   .B

l213e:  ldh     a,(98h)         ; 213e f0 98   p.
        cp      2               ; 2140 fe 02   ..
        ret     nz              ; 2142 c0   @
        ld      a,2             ; 2143 3e 02   >.
        ld      (0dff8h),a      ; 2145 ea f8 df   jx_
        xor     a               ; 2148 af   /
        ldh     (0a0h),a        ; 2149 e0 a0   ` 
        ld      de,0c0a3h       ; 214b 11 a3 c0   .#@
        ld      hl,0c842h       ; 214e 21 42 c8   !BH
        ld      b,10h           ; 2151 06 10   ..
l2153:  ld      c,0ah           ; 2153 0e 0a   ..
        push    hl              ; 2155 e5   e
l2156:  ldi     a,(hl)          ; 2156 2a   *
        cp      2fh             ; 2157 fe 2f   ./
        jp      z,l21d8         ; 2159 ca d8 21   JX!
        dec     c               ; 215c 0d   .
        jr      nz,l2156        ; 215d 20 f7    w
        pop     hl              ; 215f e1   a
        ld      a,h             ; 2160 7c   |
        ld      (de),a          ; 2161 12   .
        inc     de              ; 2162 13   .
        ld      a,l             ; 2163 7d   }
        ld      (de),a          ; 2164 12   .
        inc     de              ; 2165 13   .
        ldh     a,(0a0h)        ; 2166 f0 a0   p 
        inc     a               ; 2168 3c   <
        ldh     (0a0h),a        ; 2169 e0 a0   ` 
l216b:  push    de              ; 216b d5   U
        ld      de,20h          ; 216c 11 20 00   . .
        add     hl,de           ; 216f 19   .
        pop     de              ; 2170 d1   Q
        dec     b               ; 2171 05   .
        jr      nz,l2153        ; 2172 20 df    _
        ld      a,3             ; 2174 3e 03   >.
        ldh     (98h),a         ; 2176 e0 98   `.
        dec     a               ; 2178 3d   =
        ldh     (0a6h),a        ; 2179 e0 a6   `&
        ldh     a,(0a0h)        ; 217b f0 a0   p 
        and     a               ; 217d a7   '
        ret     z               ; 217e c8   H
        ld      b,a             ; 217f 47   G
        ld      hl,0ff9eh       ; 2180 21 9e ff   !..
        ldh     a,(0c0h)        ; 2183 f0 c0   p@
        cp      77h             ; 2185 fe 77   .w
        jr      z,l219b         ; 2187 28 12   (.
        ld      a,b             ; 2189 78   x
        add     a,(hl)          ; 218a 86   .
        daa                     ; 218b 27   '
        ldi     (hl),a          ; 218c 22   "
        ld      a,0             ; 218d 3e 00   >.
        adc     a,(hl)          ; 218f 8e   .
        daa                     ; 2190 27   '
        ld      (hl),a          ; 2191 77   w
        jr      nc,l21aa        ; 2192 30 16   0.
        ld      (hl),99h        ; 2194 36 99   6.
        dec     hl              ; 2196 2b   +
        ld      (hl),99h        ; 2197 36 99   6.
        jr      l21aa           ; 2199 18 0f   ..

l219b:  ld      a,(hl)          ; 219b 7e   .
        or      a               ; 219c b7   7
        sub     b               ; 219d 90   .
        jr      z,l21db         ; 219e 28 3b   (;
        jr      c,l21db         ; 21a0 38 39   89
        daa                     ; 21a2 27   '
        ld      (hl),a          ; 21a3 77   w
        and     0f0h            ; 21a4 e6 f0   fp
        cp      90h             ; 21a6 fe 90   ..
        jr      z,l21db         ; 21a8 28 31   (1
l21aa:  ld      a,b             ; 21aa 78   x
        ld      c,6             ; 21ab 0e 06   ..
        ld      hl,0c0ach       ; 21ad 21 ac c0   !,@
        ld      b,0             ; 21b0 06 00   ..
        cp      1               ; 21b2 fe 01   ..
        jr      z,l21cf         ; 21b4 28 19   (.
        ld      hl,0c0b1h       ; 21b6 21 b1 c0   !1@
        ld      b,1             ; 21b9 06 01   ..
        cp      2               ; 21bb fe 02   ..
        jr      z,l21cf         ; 21bd 28 10   (.
        ld      hl,0c0b6h       ; 21bf 21 b6 c0   !6@
        ld      b,2             ; 21c2 06 02   ..
        cp      3               ; 21c4 fe 03   ..
        jr      z,l21cf         ; 21c6 28 07   (.
        ld      hl,0c0bbh       ; 21c8 21 bb c0   !;@
        ld      b,4             ; 21cb 06 04   ..
        ld      c,7             ; 21cd 0e 07   ..
l21cf:  inc     (hl)            ; 21cf 34   4
        ld      a,b             ; 21d0 78   x
        ldh     (0dch),a        ; 21d1 e0 dc   `\
        ld      a,c             ; 21d3 79   y
        ld      (0dfe0h),a      ; 21d4 ea e0 df   j`_
        ret                     ; 21d7 c9   I

l21d8:  pop     hl              ; 21d8 e1   a
        jr      l216b           ; 21d9 18 90   ..

l21db:  xor     a               ; 21db af   /
        ldh     (9eh),a         ; 21dc e0 9e   `.
        jr      l21aa           ; 21de 18 ca   .J

l21e0:  ldh     a,(98h)         ; 21e0 f0 98   p.
        cp      3               ; 21e2 fe 03   ..
        ret     nz              ; 21e4 c0   @
        ldh     a,(0a6h)        ; 21e5 f0 a6   p&
        and     a               ; 21e7 a7   '
        ret     nz              ; 21e8 c0   @
        ld      de,0c0a3h       ; 21e9 11 a3 c0   .#@
        ldh     a,(9ch)         ; 21ec f0 9c   p.
        bit     0,a             ; 21ee cb 47   KG
        jr      nz,l222e        ; 21f0 20 3c    <
        ld      a,(de)          ; 21f2 1a   .
        and     a               ; 21f3 a7   '
        jr      z,l2248         ; 21f4 28 52   (R
l21f6:  sub     30h             ; 21f6 d6 30   V0
        ld      h,a             ; 21f8 67   g
        inc     de              ; 21f9 13   .
        ld      a,(de)          ; 21fa 1a   .
        ld      l,a             ; 21fb 6f   o
        ldh     a,(9ch)         ; 21fc f0 9c   p.
        cp      6               ; 21fe fe 06   ..
        ld      a,8ch           ; 2200 3e 8c   >.
        jr      nz,l2206        ; 2202 20 02    .
        ld      a,2fh           ; 2204 3e 2f   >/
l2206:  ld      c,0ah           ; 2206 0e 0a   ..
l2208:  ldi     (hl),a          ; 2208 22   "
        dec     c               ; 2209 0d   .
        jr      nz,l2208        ; 220a 20 fc    |
        inc     de              ; 220c 13   .
        ld      a,(de)          ; 220d 1a   .
        and     a               ; 220e a7   '
        jr      nz,l21f6        ; 220f 20 e5    e
l2211:  ldh     a,(9ch)         ; 2211 f0 9c   p.
        inc     a               ; 2213 3c   <
        ldh     (9ch),a         ; 2214 e0 9c   `.
        cp      7               ; 2216 fe 07   ..
        jr      z,l221f         ; 2218 28 05   (.
        ld      a,0ah           ; 221a 3e 0a   >.
        ldh     (0a6h),a        ; 221c e0 a6   `&
        ret                     ; 221e c9   I

l221f:  xor     a               ; 221f af   /
        ldh     (9ch),a         ; 2220 e0 9c   `.
        ld      a,0dh           ; 2222 3e 0d   >.
        ldh     (0a6h),a        ; 2224 e0 a6   `&
        ld      a,1             ; 2226 3e 01   >.
        ldh     (0e3h),a        ; 2228 e0 e3   `c
l222a:  xor     a               ; 222a af   /
        ldh     (98h),a         ; 222b e0 98   `.
        ret                     ; 222d c9   I

l222e:  ld      a,(de)          ; 222e 1a   .
        ld      h,a             ; 222f 67   g
        sub     30h             ; 2230 d6 30   V0
        ld      c,a             ; 2232 4f   O
        inc     de              ; 2233 13   .
        ld      a,(de)          ; 2234 1a   .
        ld      l,a             ; 2235 6f   o
        ld      b,0ah           ; 2236 06 0a   ..
l2238:  ld      a,(hl)          ; 2238 7e   .
        push    hl              ; 2239 e5   e
        ld      h,c             ; 223a 61   a
        ld      (hl),a          ; 223b 77   w
        pop     hl              ; 223c e1   a
        inc     hl              ; 223d 23   #
        dec     b               ; 223e 05   .
        jr      nz,l2238        ; 223f 20 f7    w
        inc     de              ; 2241 13   .
        ld      a,(de)          ; 2242 1a   .
        and     a               ; 2243 a7   '
        jr      nz,l222e        ; 2244 20 e8    h
        jr      l2211           ; 2246 18 c9   .I

l2248:  call    l2007           ; 2248 cd 07 20   M. 
        jr      l222a           ; 224b 18 dd   .]

l224d:  ldh     a,(0a6h)        ; 224d f0 a6   p&
        and     a               ; 224f a7   '
        ret     nz              ; 2250 c0   @
        ldh     a,(0e3h)        ; 2251 f0 e3   pc
        cp      1               ; 2253 fe 01   ..
        ret     nz              ; 2255 c0   @
        ld      de,0c0a3h       ; 2256 11 a3 c0   .#@
        ld      a,(de)          ; 2259 1a   .
l225a:  ld      h,a             ; 225a 67   g
        inc     de              ; 225b 13   .
        ld      a,(de)          ; 225c 1a   .
        ld      l,a             ; 225d 6f   o
        push    de              ; 225e d5   U
        push    hl              ; 225f e5   e
        ld      bc,0ffe0h       ; 2260 01 e0 ff   .`.
        add     hl,bc           ; 2263 09   .
        pop     de              ; 2264 d1   Q
l2265:  push    hl              ; 2265 e5   e
        ld      b,0ah           ; 2266 06 0a   ..
l2268:  ldi     a,(hl)          ; 2268 2a   *
        ld      (de),a          ; 2269 12   .
        inc     de              ; 226a 13   .
        dec     b               ; 226b 05   .
        jr      nz,l2268        ; 226c 20 fa    z
        pop     hl              ; 226e e1   a
        push    hl              ; 226f e5   e
        pop     de              ; 2270 d1   Q
        ld      bc,0ffe0h       ; 2271 01 e0 ff   .`.
        add     hl,bc           ; 2274 09   .
        ld      a,h             ; 2275 7c   |
        cp      0c7h            ; 2276 fe c7   .G
        jr      nz,l2265        ; 2278 20 eb    k
        pop     de              ; 227a d1   Q
        inc     de              ; 227b 13   .
        ld      a,(de)          ; 227c 1a   .
        and     a               ; 227d a7   '
        jr      nz,l225a        ; 227e 20 da    Z
        ld      hl,0c802h       ; 2280 21 02 c8   !.H
        ld      a,2fh           ; 2283 3e 2f   >/
        ld      b,0ah           ; 2285 06 0a   ..
l2287:  ldi     (hl),a          ; 2287 22   "
        dec     b               ; 2288 05   .
        jr      nz,l2287        ; 2289 20 fc    |
        call    l2293           ; 228b cd 93 22   M."
        ld      a,2             ; 228e 3e 02   >.
        ldh     (0e3h),a        ; 2290 e0 e3   `c
        ret                     ; 2292 c9   I

l2293:  ld      hl,0c0a3h       ; 2293 21 a3 c0   !#@
        xor     a               ; 2296 af   /
        ld      b,9             ; 2297 06 09   ..
l2299:  ldi     (hl),a          ; 2299 22   "
        dec     b               ; 229a 05   .
        jr      nz,l2299        ; 229b 20 fc    |
        ret                     ; 229d c9   I

l229e:  ldh     a,(0e3h)        ; 229e f0 e3   pc
        cp      2               ; 22a0 fe 02   ..
        ret     nz              ; 22a2 c0   @
        ld      hl,9a22h        ; 22a3 21 22 9a   !".
        ld      de,0ca22h       ; 22a6 11 22 ca   ."J
        call    l24ac           ; 22a9 cd ac 24   M,$
        ret                     ; 22ac c9   I

l22ad:  ldh     a,(0e3h)        ; 22ad f0 e3   pc
        cp      3               ; 22af fe 03   ..
        ret     nz              ; 22b1 c0   @
        ld      hl,9a02h        ; 22b2 21 02 9a   !..
        ld      de,0ca02h       ; 22b5 11 02 ca   ..J
        call    l24ac           ; 22b8 cd ac 24   M,$
        ret                     ; 22bb c9   I

l22bc:  ldh     a,(0e3h)        ; 22bc f0 e3   pc
        cp      4               ; 22be fe 04   ..
        ret     nz              ; 22c0 c0   @
        ld      hl,99e2h        ; 22c1 21 e2 99   !b.
        ld      de,0c9e2h       ; 22c4 11 e2 c9   .bI
        call    l24ac           ; 22c7 cd ac 24   M,$
        ret                     ; 22ca c9   I

l22cb:  ldh     a,(0e3h)        ; 22cb f0 e3   pc
        cp      5               ; 22cd fe 05   ..
        ret     nz              ; 22cf c0   @
        ld      hl,99c2h        ; 22d0 21 c2 99   !B.
        ld      de,0c9c2h       ; 22d3 11 c2 c9   .BI
        call    l24ac           ; 22d6 cd ac 24   M,$
        ret                     ; 22d9 c9   I

l22da:  ldh     a,(0e3h)        ; 22da f0 e3   pc
        cp      6               ; 22dc fe 06   ..
        ret     nz              ; 22de c0   @
        ld      hl,99a2h        ; 22df 21 a2 99   !".
        ld      de,0c9a2h       ; 22e2 11 a2 c9   ."I
        call    l24ac           ; 22e5 cd ac 24   M,$
        ret                     ; 22e8 c9   I

l22e9:  ldh     a,(0e3h)        ; 22e9 f0 e3   pc
        cp      7               ; 22eb fe 07   ..
        ret     nz              ; 22ed c0   @
        ld      hl,9982h        ; 22ee 21 82 99   !..
        ld      de,0c982h       ; 22f1 11 82 c9   ..I
        call    l24ac           ; 22f4 cd ac 24   M,$
        ret                     ; 22f7 c9   I

l22f8:  ldh     a,(0e3h)        ; 22f8 f0 e3   pc
        cp      8               ; 22fa fe 08   ..
        ret     nz              ; 22fc c0   @
        ld      hl,9962h        ; 22fd 21 62 99   !b.
        ld      de,0c962h       ; 2300 11 62 c9   .bI
        call    l24ac           ; 2303 cd ac 24   M,$
        ldh     a,(0c5h)        ; 2306 f0 c5   pE
        and     a               ; 2308 a7   '
        ldh     a,(0e1h)        ; 2309 f0 e1   pa
        jr      nz,l2315        ; 230b 20 08    .
        and     a               ; 230d a7   '
        ret     nz              ; 230e c0   @
l230f:  ld      a,1             ; 230f 3e 01   >.
        ld      (0dff8h),a      ; 2311 ea f8 df   jx_
        ret                     ; 2314 c9   I

l2315:  cp      1ah             ; 2315 fe 1a   ..
        ret     nz              ; 2317 c0   @
        ldh     a,(0d4h)        ; 2318 f0 d4   pT
        and     a               ; 231a a7   '
        jr      z,l230f         ; 231b 28 f2   (r
        ld      a,5             ; 231d 3e 05   >.
        ld      (0dfe0h),a      ; 231f ea e0 df   j`_
        ret                     ; 2322 c9   I

l2323:  ldh     a,(0e3h)        ; 2323 f0 e3   pc
        cp      9               ; 2325 fe 09   ..
        ret     nz              ; 2327 c0   @
        ld      hl,9942h        ; 2328 21 42 99   !B.
        ld      de,0c942h       ; 232b 11 42 c9   .BI
        call    l24ac           ; 232e cd ac 24   M,$
        ret                     ; 2331 c9   I

l2332:  ldh     a,(0e3h)        ; 2332 f0 e3   pc
        cp      0ah             ; 2334 fe 0a   ..
        ret     nz              ; 2336 c0   @
        ld      hl,9922h        ; 2337 21 22 99   !".
        ld      de,0c922h       ; 233a 11 22 c9   ."I
        call    l24ac           ; 233d cd ac 24   M,$
        ret                     ; 2340 c9   I

l2341:  ldh     a,(0e3h)        ; 2341 f0 e3   pc
        cp      0bh             ; 2343 fe 0b   ..
        ret     nz              ; 2345 c0   @
        ld      hl,9902h        ; 2346 21 02 99   !..
        ld      de,0c902h       ; 2349 11 02 c9   ..I
        call    l24ac           ; 234c cd ac 24   M,$
        ret                     ; 234f c9   I

l2350:  ldh     a,(0e3h)        ; 2350 f0 e3   pc
        cp      0ch             ; 2352 fe 0c   ..
        ret     nz              ; 2354 c0   @
        ld      hl,98e2h        ; 2355 21 e2 98   !b.
        ld      de,0c8e2h       ; 2358 11 e2 c8   .bH
        call    l24ac           ; 235b cd ac 24   M,$
        ret                     ; 235e c9   I

l235f:  ldh     a,(0e3h)        ; 235f f0 e3   pc
        cp      0dh             ; 2361 fe 0d   ..
        ret     nz              ; 2363 c0   @
        ld      hl,98c2h        ; 2364 21 c2 98   !B.
        ld      de,0c8c2h       ; 2367 11 c2 c8   .BH
        call    l24ac           ; 236a cd ac 24   M,$
        ret                     ; 236d c9   I

l236e:  ldh     a,(0e3h)        ; 236e f0 e3   pc
        cp      0eh             ; 2370 fe 0e   ..
        ret     nz              ; 2372 c0   @
        ld      hl,98a2h        ; 2373 21 a2 98   !".
        ld      de,0c8a2h       ; 2376 11 a2 c8   ."H
        call    l24ac           ; 2379 cd ac 24   M,$
        ret                     ; 237c c9   I

l237d:  ldh     a,(0e3h)        ; 237d f0 e3   pc
        cp      0fh             ; 237f fe 0f   ..
        ret     nz              ; 2381 c0   @
        ld      hl,9882h        ; 2382 21 82 98   !..
        ld      de,0c882h       ; 2385 11 82 c8   ..H
        call    l24ac           ; 2388 cd ac 24   M,$
        ret                     ; 238b c9   I

l238c:  ldh     a,(0e3h)        ; 238c f0 e3   pc
        cp      10h             ; 238e fe 10   ..
        ret     nz              ; 2390 c0   @
        ld      hl,9862h        ; 2391 21 62 98   !b.
        ld      de,0c862h       ; 2394 11 62 c8   .bH
        call    l24ac           ; 2397 cd ac 24   M,$
        call    l244b           ; 239a cd 4b 24   MK$
        ret                     ; 239d c9   I

l239e:  ldh     a,(0e3h)        ; 239e f0 e3   pc
        cp      11h             ; 23a0 fe 11   ..
        ret     nz              ; 23a2 c0   @
        ld      hl,9842h        ; 23a3 21 42 98   !B.
        ld      de,0c842h       ; 23a6 11 42 c8   .BH
        call    l24ac           ; 23a9 cd ac 24   M,$
        ld      hl,9c6dh        ; 23ac 21 6d 9c   !m.
        call    l243b           ; 23af cd 3b 24   M;$
        ld      a,1             ; 23b2 3e 01   >.
        ldh     (0e0h),a        ; 23b4 e0 e0   ``
        ret                     ; 23b6 c9   I

l23b7:  ldh     a,(0e3h)        ; 23b7 f0 e3   pc
        cp      12h             ; 23b9 fe 12   ..
        ret     nz              ; 23bb c0   @
        ld      hl,9822h        ; 23bc 21 22 98   !".
        ld      de,0c822h       ; 23bf 11 22 c8   ."H
        call    l24ac           ; 23c2 cd ac 24   M,$
        ld      hl,986dh        ; 23c5 21 6d 98   !m.
        call    l243b           ; 23c8 cd 3b 24   M;$
        ret                     ; 23cb c9   I

l23cc:  ldh     a,(0e3h)        ; 23cc f0 e3   pc
        cp      13h             ; 23ce fe 13   ..
        ret     nz              ; 23d0 c0   @
        ld      (0c0c7h),a      ; 23d1 ea c7 c0   jG@
        ld      hl,9802h        ; 23d4 21 02 98   !..
        ld      de,0c802h       ; 23d7 11 02 c8   ..H
        call    l24ac           ; 23da cd ac 24   M,$
        xor     a               ; 23dd af   /
        ldh     (0e3h),a        ; 23de e0 e3   `c
        ldh     a,(0c5h)        ; 23e0 f0 c5   pE
        and     a               ; 23e2 a7   '
        ldh     a,(0e1h)        ; 23e3 f0 e1   pa
        jr      nz,l242f        ; 23e5 20 48    H
        and     a               ; 23e7 a7   '
        ret     nz              ; 23e8 c0   @
l23e9:  ld      hl,994eh        ; 23e9 21 4e 99   !N.
        ld      de,0ff9fh       ; 23ec 11 9f ff   ...
        ld      c,2             ; 23ef 0e 02   ..
        ldh     a,(0c0h)        ; 23f1 f0 c0   p@
        cp      37h             ; 23f3 fe 37   .7
        jr      z,l23ff         ; 23f5 28 08   (.
        ld      hl,9950h        ; 23f7 21 50 99   !P.
        ld      de,0ff9eh       ; 23fa 11 9e ff   ...
        ld      c,1             ; 23fd 0e 01   ..
l23ff:  call    l2a3c           ; 23ff cd 3c 2a   M<*
        ldh     a,(0c0h)        ; 2402 f0 c0   p@
        cp      37h             ; 2404 fe 37   .7
        jr      z,l242b         ; 2406 28 23   (#
        ldh     a,(9eh)         ; 2408 f0 9e   p.
        and     a               ; 240a a7   '
        jr      nz,l242b        ; 240b 20 1e    .
        ld      a,64h           ; 240d 3e 64   >d
        ldh     (0a6h),a        ; 240f e0 a6   `&
        ld      a,2             ; 2411 3e 02   >.
        ld      (0dfe8h),a      ; 2413 ea e8 df   jh_
        ldh     a,(0c5h)        ; 2416 f0 c5   pE
        and     a               ; 2418 a7   '
        jr      z,l241e         ; 2419 28 03   (.
        ldh     (0d5h),a        ; 241b e0 d5   `U
        ret                     ; 241d c9   I

l241e:  ldh     a,(0c3h)        ; 241e f0 c3   pC
        cp      9               ; 2420 fe 09   ..
        ld      a,5             ; 2422 3e 05   >.
        jr      nz,l2428        ; 2424 20 02    .
        ld      a,22h           ; 2426 3e 22   >"
l2428:  ldh     (0e1h),a        ; 2428 e0 e1   `a
        ret                     ; 242a c9   I

l242b:  call    l2007           ; 242b cd 07 20   M. 
        ret                     ; 242e c9   I

l242f:  cp      1ah             ; 242f fe 1a   ..
        ret     nz              ; 2431 c0   @
        ldh     a,(0d4h)        ; 2432 f0 d4   pT
        and     a               ; 2434 a7   '
        jr      z,l23e9         ; 2435 28 b2   (2
        xor     a               ; 2437 af   /
        ldh     (0d4h),a        ; 2438 e0 d4   `T
        ret                     ; 243a c9   I

l243b:  ldh     a,(0e1h)        ; 243b f0 e1   pa
        and     a               ; 243d a7   '
        ret     nz              ; 243e c0   @
        ldh     a,(0c0h)        ; 243f f0 c0   p@
        cp      37h             ; 2441 fe 37   .7
        ret     nz              ; 2443 c0   @
        ld      de,0c0a2h       ; 2444 11 a2 c0   ."@
        call    l2a36           ; 2447 cd 36 2a   M6*
        ret                     ; 244a c9   I

l244b:  ldh     a,(0e1h)        ; 244b f0 e1   pa
        and     a               ; 244d a7   '
        ret     nz              ; 244e c0   @
        ldh     a,(0c0h)        ; 244f f0 c0   p@
        cp      37h             ; 2451 fe 37   .7
        ret     nz              ; 2453 c0   @
        ld      hl,0ffa9h       ; 2454 21 a9 ff   !).
        ld      a,(hl)          ; 2457 7e   .
        cp      14h             ; 2458 fe 14   ..
        ret     z               ; 245a c8   H
        call    l249d           ; 245b cd 9d 24   M.$
        ldh     a,(9fh)         ; 245e f0 9f   p.
        ld      d,a             ; 2460 57   W
        and     0f0h            ; 2461 e6 f0   fp
        ret     nz              ; 2463 c0   @
        ld      a,d             ; 2464 7a   z
        and     0fh             ; 2465 e6 0f   f.
        swap    a               ; 2467 cb 37   K7
        ld      d,a             ; 2469 57   W
        ldh     a,(9eh)         ; 246a f0 9e   p.
        and     0f0h            ; 246c e6 f0   fp
        swap    a               ; 246e cb 37   K7
        or      d               ; 2470 b2   2
        cp      b               ; 2471 b8   8
        ret     c               ; 2472 d8   X
        ret     z               ; 2473 c8   H
        inc     (hl)            ; 2474 34   4
        call    l249d           ; 2475 cd 9d 24   M.$
        and     0fh             ; 2478 e6 0f   f.
        ld      c,a             ; 247a 4f   O
        ld      hl,98f1h        ; 247b 21 f1 98   !q.
l247e:  ld      (hl),c          ; 247e 71   q
        ld      h,9ch           ; 247f 26 9c   &.
        ld      (hl),c          ; 2481 71   q
        ld      a,b             ; 2482 78   x
        and     0f0h            ; 2483 e6 f0   fp
        jr      z,l2494         ; 2485 28 0d   (.
        swap    a               ; 2487 cb 37   K7
        ld      c,a             ; 2489 4f   O
        ld      a,l             ; 248a 7d   }
        cp      0f0h            ; 248b fe f0   .p
        jr      z,l2494         ; 248d 28 05   (.
        ld      hl,98f0h        ; 248f 21 f0 98   !p.
        jr      l247e           ; 2492 18 ea   .j

l2494:  ld      a,8             ; 2494 3e 08   >.
        ld      (0dfe0h),a      ; 2496 ea e0 df   j`_
        call    l1ae8           ; 2499 cd e8 1a   Mh.
        ret                     ; 249c c9   I

l249d:  ld      a,(hl)          ; 249d 7e   .
        ld      b,a             ; 249e 47   G
        and     a               ; 249f a7   '
        ret     z               ; 24a0 c8   H
        xor     a               ; 24a1 af   /
l24a2:  or      a               ; 24a2 b7   7
        inc     a               ; 24a3 3c   <
        daa                     ; 24a4 27   '
        dec     b               ; 24a5 05   .
        jr      z,l24aa         ; 24a6 28 02   (.
        jr      l24a2           ; 24a8 18 f8   .x

l24aa:  ld      b,a             ; 24aa 47   G
        ret                     ; 24ab c9   I

l24ac:  ld      b,0ah           ; 24ac 06 0a   ..
l24ae:  ld      a,(de)          ; 24ae 1a   .
        ld      (hl),a          ; 24af 77   w
        inc     l               ; 24b0 2c   ,
        inc     e               ; 24b1 1c   .
        dec     b               ; 24b2 05   .
        jr      nz,l24ae        ; 24b3 20 f9    y
        ldh     a,(0e3h)        ; 24b5 f0 e3   pc
        inc     a               ; 24b7 3c   <
        ldh     (0e3h),a        ; 24b8 e0 e3   `c
        ret                     ; 24ba c9   I

l24bb:  ld      hl,0c200h       ; 24bb 21 00 c2   !.B
        ld      a,(hl)          ; 24be 7e   .
        cp      80h             ; 24bf fe 80   ..
        ret     z               ; 24c1 c8   H
        ld      l,3             ; 24c2 2e 03   ..
        ld      a,(hl)          ; 24c4 7e   .
        ldh     (0a0h),a        ; 24c5 e0 a0   ` 
        ldh     a,(81h)         ; 24c7 f0 81   p.
        ld      b,a             ; 24c9 47   G
        bit     1,b             ; 24ca cb 48   KH
        jr      nz,l24e0        ; 24cc 20 12    .
        bit     0,b             ; 24ce cb 40   K@
        jr      z,l2509         ; 24d0 28 37   (7
        ld      a,(hl)          ; 24d2 7e   .
        and     3               ; 24d3 e6 03   f.
        jr      z,l24da         ; 24d5 28 03   (.
        dec     (hl)            ; 24d7 35   5
        jr      l24ee           ; 24d8 18 14   ..

l24da:  ld      a,(hl)          ; 24da 7e   .
        or      3               ; 24db f6 03   v.
        ld      (hl),a          ; 24dd 77   w
        jr      l24ee           ; 24de 18 0e   ..

l24e0:  ld      a,(hl)          ; 24e0 7e   .
        and     3               ; 24e1 e6 03   f.
        cp      3               ; 24e3 fe 03   ..
        jr      z,l24ea         ; 24e5 28 03   (.
        inc     (hl)            ; 24e7 34   4
        jr      l24ee           ; 24e8 18 04   ..

l24ea:  ld      a,(hl)          ; 24ea 7e   .
        and     0fch            ; 24eb e6 fc   f|
        ld      (hl),a          ; 24ed 77   w
l24ee:  ld      a,3             ; 24ee 3e 03   >.
        ld      (0dfe0h),a      ; 24f0 ea e0 df   j`_
        call    l2683           ; 24f3 cd 83 26   M.&
        call    l2573           ; 24f6 cd 73 25   Ms%
        and     a               ; 24f9 a7   '
        jr      z,l2509         ; 24fa 28 0d   (.
        xor     a               ; 24fc af   /
        ld      (0dfe0h),a      ; 24fd ea e0 df   j`_
        ld      hl,0c203h       ; 2500 21 03 c2   !.B
        ldh     a,(0a0h)        ; 2503 f0 a0   p 
        ld      (hl),a          ; 2505 77   w
        call    l2683           ; 2506 cd 83 26   M.&
l2509:  ld      hl,0c202h       ; 2509 21 02 c2   !.B
        ldh     a,(81h)         ; 250c f0 81   p.
        ld      b,a             ; 250e 47   G
        ldh     a,(80h)         ; 250f f0 80   p.
        ld      c,a             ; 2511 4f   O
        ld      a,(hl)          ; 2512 7e   .
        ldh     (0a0h),a        ; 2513 e0 a0   ` 
        bit     4,b             ; 2515 cb 60   K`
        ld      a,17h           ; 2517 3e 17   >.
        jr      nz,l2527        ; 2519 20 0c    .
        bit     4,c             ; 251b cb 61   Ka
        jr      z,l254c         ; 251d 28 2d   (-
        ldh     a,(0aah)        ; 251f f0 aa   p*
        dec     a               ; 2521 3d   =
        ldh     (0aah),a        ; 2522 e0 aa   `*
        ret     nz              ; 2524 c0   @
        ld      a,9             ; 2525 3e 09   >.
l2527:  ldh     (0aah),a        ; 2527 e0 aa   `*
        ld      a,(hl)          ; 2529 7e   .
        add     a,8             ; 252a c6 08   F.
        ld      (hl),a          ; 252c 77   w
        call    l2683           ; 252d cd 83 26   M.&
        ld      a,4             ; 2530 3e 04   >.
        ld      (0dfe0h),a      ; 2532 ea e0 df   j`_
        call    l2573           ; 2535 cd 73 25   Ms%
        and     a               ; 2538 a7   '
        ret     z               ; 2539 c8   H
l253a:  ld      hl,0c202h       ; 253a 21 02 c2   !.B
        xor     a               ; 253d af   /
        ld      (0dfe0h),a      ; 253e ea e0 df   j`_
        ldh     a,(0a0h)        ; 2541 f0 a0   p 
        ld      (hl),a          ; 2543 77   w
        call    l2683           ; 2544 cd 83 26   M.&
        ld      a,1             ; 2547 3e 01   >.
l2549:  ldh     (0aah),a        ; 2549 e0 aa   `*
        ret                     ; 254b c9   I

l254c:  bit     5,b             ; 254c cb 68   Kh
        ld      a,17h           ; 254e 3e 17   >.
        jr      nz,l255e        ; 2550 20 0c    .
        bit     5,c             ; 2552 cb 69   Ki
        jr      z,l2549         ; 2554 28 f3   (s
        ldh     a,(0aah)        ; 2556 f0 aa   p*
        dec     a               ; 2558 3d   =
        ldh     (0aah),a        ; 2559 e0 aa   `*
        ret     nz              ; 255b c0   @
        ld      a,9             ; 255c 3e 09   >.
l255e:  ldh     (0aah),a        ; 255e e0 aa   `*
        ld      a,(hl)          ; 2560 7e   .
        sub     8               ; 2561 d6 08   V.
        ld      (hl),a          ; 2563 77   w
        ld      a,4             ; 2564 3e 04   >.
        ld      (0dfe0h),a      ; 2566 ea e0 df   j`_
        call    l2683           ; 2569 cd 83 26   M.&
        call    l2573           ; 256c cd 73 25   Ms%
        and     a               ; 256f a7   '
        ret     z               ; 2570 c8   H
        jr      l253a           ; 2571 18 c7   .G

l2573:  ld      hl,0c010h       ; 2573 21 10 c0   !.@
        ld      b,4             ; 2576 06 04   ..
l2578:  ldi     a,(hl)          ; 2578 2a   *
        ldh     (0b2h),a        ; 2579 e0 b2   `2
        ldi     a,(hl)          ; 257b 2a   *
        and     a               ; 257c a7   '
        jr      z,l2596         ; 257d 28 17   (.
        ldh     (0b3h),a        ; 257f e0 b3   `3
        push    hl              ; 2581 e5   e
        push    bc              ; 2582 c5   E
        call    l29e3           ; 2583 cd e3 29   Mc)
        ld      a,h             ; 2586 7c   |
        add     a,30h           ; 2587 c6 30   F0
        ld      h,a             ; 2589 67   g
        ld      a,(hl)          ; 258a 7e   .
        cp      2fh             ; 258b fe 2f   ./
        jr      nz,l259a        ; 258d 20 0b    .
        pop     bc              ; 258f c1   A
        pop     hl              ; 2590 e1   a
        inc     l               ; 2591 2c   ,
        inc     l               ; 2592 2c   ,
        dec     b               ; 2593 05   .
        jr      nz,l2578        ; 2594 20 e2    b
l2596:  xor     a               ; 2596 af   /
        ldh     (9bh),a         ; 2597 e0 9b   `.
        ret                     ; 2599 c9   I

l259a:  pop     bc              ; 259a c1   A
        pop     hl              ; 259b e1   a
        ld      a,1             ; 259c 3e 01   >.
        ldh     (9bh),a         ; 259e e0 9b   `.
        ret                     ; 25a0 c9   I

l25a1:  ldh     a,(98h)         ; 25a1 f0 98   p.
        cp      1               ; 25a3 fe 01   ..
        ret     nz              ; 25a5 c0   @
        ld      hl,0c010h       ; 25a6 21 10 c0   !.@
        ld      b,4             ; 25a9 06 04   ..
l25ab:  ldi     a,(hl)          ; 25ab 2a   *
        ldh     (0b2h),a        ; 25ac e0 b2   `2
        ldi     a,(hl)          ; 25ae 2a   *
        and     a               ; 25af a7   '
        jr      z,l25cf         ; 25b0 28 1d   (.
        ldh     (0b3h),a        ; 25b2 e0 b3   `3
        push    hl              ; 25b4 e5   e
        push    bc              ; 25b5 c5   E
        call    l29e3           ; 25b6 cd e3 29   Mc)
        push    hl              ; 25b9 e5   e
        pop     de              ; 25ba d1   Q
        pop     bc              ; 25bb c1   A
        pop     hl              ; 25bc e1   a
l25bd:  ldh     a,(41h)         ; 25bd f0 41   pA
        and     3               ; 25bf e6 03   f.
        jr      nz,l25bd        ; 25c1 20 fa    z
        ld      a,(hl)          ; 25c3 7e   .
        ld      (de),a          ; 25c4 12   .
        ld      a,d             ; 25c5 7a   z
        add     a,30h           ; 25c6 c6 30   F0
        ld      d,a             ; 25c8 57   W
        ldi     a,(hl)          ; 25c9 2a   *
        ld      (de),a          ; 25ca 12   .
        inc     l               ; 25cb 2c   ,
        dec     b               ; 25cc 05   .
        jr      nz,l25ab        ; 25cd 20 dc    \
l25cf:  ld      a,2             ; 25cf 3e 02   >.
        ldh     (98h),a         ; 25d1 e0 98   `.
        ld      hl,0c200h       ; 25d3 21 00 c2   !.B
        ld      (hl),80h        ; 25d6 36 80   6.
        ret                     ; 25d8 c9   I

l25d9:  ld      a,(0c0c6h)      ; 25d9 fa c6 c0   zF@
        cp      2               ; 25dc fe 02   ..
        jr      z,l2626         ; 25de 28 46   (F
        push    de              ; 25e0 d5   U
        ld      a,(hl)          ; 25e1 7e   .
        or      a               ; 25e2 b7   7
        jr      z,l2639         ; 25e3 28 54   (T
        dec     a               ; 25e5 3d   =
        ldi     (hl),a          ; 25e6 22   "
        ld      a,(hl)          ; 25e7 7e   .
        inc     a               ; 25e8 3c   <
        daa                     ; 25e9 27   '
        ld      (hl),a          ; 25ea 77   w
        and     0fh             ; 25eb e6 0f   f.
        ld      (bc),a          ; 25ed 02   .
        dec     c               ; 25ee 0d   .
        ldi     a,(hl)          ; 25ef 2a   *
        swap    a               ; 25f0 cb 37   K7
        and     0fh             ; 25f2 e6 0f   f.
        jr      z,l25f7         ; 25f4 28 01   (.
        ld      (bc),a          ; 25f6 02   .
l25f7:  push    bc              ; 25f7 c5   E
        ldh     a,(0c3h)        ; 25f8 f0 c3   pC
        ld      b,a             ; 25fa 47   G
        inc     b               ; 25fb 04   .
l25fc:  push    hl              ; 25fc e5   e
        call    l0166           ; 25fd cd 66 01   Mf.
        pop     hl              ; 2600 e1   a
        dec     b               ; 2601 05   .
        jr      nz,l25fc        ; 2602 20 f8    x
        pop     bc              ; 2604 c1   A
        inc     hl              ; 2605 23   #
        inc     hl              ; 2606 23   #
        push    hl              ; 2607 e5   e
        ld      hl,23h          ; 2608 21 23 00   !#.
        add     hl,bc           ; 260b 09   .
        pop     de              ; 260c d1   Q
        call    l2a3a           ; 260d cd 3a 2a   M:*
        pop     de              ; 2610 d1   Q
        ldh     a,(0c3h)        ; 2611 f0 c3   pC
        ld      b,a             ; 2613 47   G
        inc     b               ; 2614 04   .
        ld      hl,0c0a0h       ; 2615 21 a0 c0   ! @
l2618:  push    hl              ; 2618 e5   e
        call    l0166           ; 2619 cd 66 01   Mf.
        pop     hl              ; 261c e1   a
        dec     b               ; 261d 05   .
        jr      nz,l2618        ; 261e 20 f8    x
        ld      a,2             ; 2620 3e 02   >.
        ld      (0c0c6h),a      ; 2622 ea c6 c0   jF@
        ret                     ; 2625 c9   I

l2626:  ld      de,0c0a2h       ; 2626 11 a2 c0   ."@
        ld      hl,9a25h        ; 2629 21 25 9a   !%.
        call    l2a3a           ; 262c cd 3a 2a   M:*
        ld      a,2             ; 262f 3e 02   >.
        ld      (0dfe0h),a      ; 2631 ea e0 df   j`_
        xor     a               ; 2634 af   /
        ld      (0c0c6h),a      ; 2635 ea c6 c0   jF@
        ret                     ; 2638 c9   I

l2639:  pop     de              ; 2639 d1   Q
l263a:  ld      a,21h           ; 263a 3e 21   >!
        ldh     (0a6h),a        ; 263c e0 a6   `&
        xor     a               ; 263e af   /
        ld      (0c0c6h),a      ; 263f ea c6 c0   jF@
        ld      a,(0c0c5h)      ; 2642 fa c5 c0   zE@
        inc     a               ; 2645 3c   <
        ld      (0c0c5h),a      ; 2646 ea c5 c0   jE@
        cp      5               ; 2649 fe 05   ..
        ret     nz              ; 264b c0   @
        ld      a,4             ; 264c 3e 04   >.
        ldh     (0e1h),a        ; 264e e0 e1   `a
        ret                     ; 2650 c9   I

l2651:  ld      hl,0c0ach       ; 2651 21 ac c0   !,@
        ld      b,1bh           ; 2654 06 1b   ..
        xor     a               ; 2656 af   /
l2657:  ldi     (hl),a          ; 2657 22   "
        dec     b               ; 2658 05   .
        jr      nz,l2657        ; 2659 20 fc    |
        ld      hl,0c0a0h       ; 265b 21 a0 c0   ! @
        ld      b,3             ; 265e 06 03   ..
l2660:  ldi     (hl),a          ; 2660 22   "
        dec     b               ; 2661 05   .
        jr      nz,l2660        ; 2662 20 fc    |
        ret                     ; 2664 c9   I

; This routine is not used.
        ld      a,(hl)          ; 2665 7e   .
        and     0f0h            ; 2666 e6 f0   fp
        swap    a               ; 2668 cb 37   K7
        ld      (de),a          ; 266a 12   .
        ld      a,(hl)          ; 266b 7e   .
        and     0fh             ; 266c e6 0f   f.
        inc     e               ; 266e 1c   .
        ld      (de),a          ; 266f 12   .
        ret                     ; 2670 c9   I

l2671:  ld      a,2             ; 2671 3e 02   >.
l2673:  ldh     (8fh),a         ; 2673 e0 8f   `.
        xor     a               ; 2675 af   /
        ldh     (8eh),a         ; 2676 e0 8e   `.
        ld      a,0c0h          ; 2678 3e c0   >@
        ldh     (8dh),a         ; 267a e0 8d   `.
        ld      hl,0c200h       ; 267c 21 00 c2   !.B
        call    l2a89           ; 267f cd 89 2a   M.*
        ret                     ; 2682 c9   I

l2683:  ld      a,1             ; 2683 3e 01   >.
        ldh     (8fh),a         ; 2685 e0 8f   `.
        ld      a,10h           ; 2687 3e 10   >.
        ldh     (8eh),a         ; 2689 e0 8e   `.
        ld      a,0c0h          ; 268b 3e c0   >@
        ldh     (8dh),a         ; 268d e0 8d   `.
        ld      hl,0c200h       ; 268f 21 00 c2   !.B
        call    l2a89           ; 2692 cd 89 2a   M.*
        ret                     ; 2695 c9   I

l2696:  ld      a,1             ; 2696 3e 01   >.
        ldh     (8fh),a         ; 2698 e0 8f   `.
        ld      a,20h           ; 269a 3e 20   > 
        ldh     (8eh),a         ; 269c e0 8e   `.
        ld      a,0c0h          ; 269e 3e c0   >@
        ldh     (8dh),a         ; 26a0 e0 8d   `.
        ld      hl,0c210h       ; 26a2 21 10 c2   !.B
        call    l2a89           ; 26a5 cd 89 2a   M.*
        ret                     ; 26a8 c9   I

l26a9:  ld      b,20h           ; 26a9 06 20   . 
        ld      a,8eh           ; 26ab 3e 8e   >.
        ld      de,20h          ; 26ad 11 20 00   . .
l26b0:  ld      (hl),a          ; 26b0 77   w
        add     hl,de           ; 26b1 19   .
        dec     b               ; 26b2 05   .
        jr      nz,l26b0        ; 26b3 20 fb    {
        ret                     ; 26b5 c9   I

l26b6:  ld      a,(de)          ; 26b6 1a   .
        cp      0ffh            ; 26b7 fe ff   ..
        ret     z               ; 26b9 c8   H
        ldi     (hl),a          ; 26ba 22   "
        inc     de              ; 26bb 13   .
        jr      l26b6           ; 26bc 18 f8   .x

l26be:  reti                    ; 26be d9   Y

l26bf:  .db     0,18h,3fh,0,80h,0,0,0ffh        ; 26bf 00 18 3f 00 80 00 00 ff   ..?.....
l26c7:  .db     0,80h,8fh,0,80h,0,0,0ffh        ; 26c7 00 80 8f 00 80 00 00 ff   ........
l26cf:  .db     0,70h,37h,1ch,0,0,0,38h,37h,1ch,0,0     ; 26cf 00 70 37 1c 00 00 00 38 37 1c 00 00   .p7....87...
l26db:  .db     0,40h,34h,20h,0,0       ; 26db 00 40 34 20 00 00   .@4 ..
l26e1:  .db     0,40h,1ch,20h,0,0,0,40h,74h,20h,0,0     ; 26e1 00 40 1c 20 00 00 00 40 74 20 00 00   .@. ...@t ..
l26ed:  .db     0,40h,68h,21h,0,0,0,78h,68h,21h,0,0     ; 26ed 00 40 68 21 00 00 00 78 68 21 00 00   .@h!...xh!..
l26f9:  .db     0,60h,60h,2ah,80h,0,0,60h,72h,2ah,80h,20h,0,68h,38h     ; 26f9 00 60 60 2a 80 00 00 60 72 2a 80 20 00 68 38   .``*...`r*. .h8
        .db     3eh,80h,0       ; 2708 3e 80 00   >..
l270b:  .db     0,60h,60h,36h,80h,0,0,60h,72h,36h,80h,20h,0,68h,38h     ; 270b 00 60 60 36 80 00 00 60 72 36 80 20 00 68 38   .``6...`r6. .h8
        .db     32h,80h,0       ; 271a 32 80 00   2..
l271d:  .db     0,60h,60h,2eh,80h,0,0,68h,38h,3ch,80h,0 ; 271d 00 60 60 2e 80 00 00 68 38 3c 80 00   .``....h8<..
l2729:  .db     0,60h,60h,3ah,80h,0,0,68h,38h,30h,80h,0 ; 2729 00 60 60 3a 80 00 00 68 38 30 80 00   .``:...h80..
l2735:  .db     80h,3fh,40h,44h,0,0,80h,3fh,20h,4ah,0,0,80h,3fh,30h     ; 2735 80 3f 40 44 00 00 80 3f 20 4a 00 00 80 3f 30   .?@D...? J...?0
        .db     46h,0,0,80h,77h,20h,48h,0,0,80h,87h,48h,4ch,0,0,80h,87h ; 2744 46 00 00 80 77 20 48 00 00 80 87 48 4c 00 00 80 87   F...w H....HL....
        .db     58h,4eh,0,0,80h,67h,4dh,50h,0,0,80h,67h,5dh,52h,0,0,80h ; 2755 58 4e 00 00 80 67 4d 50 00 00 80 67 5d 52 00 00 80   XN...gMP...g]R...
        .db     8fh,88h,54h,0,0,80h,8fh,98h,55h,0,0     ; 2766 8f 88 54 00 00 80 8f 98 55 00 00   ..T.....U..
l2771:  .db     0,5fh,57h,2ch,0,0,80h,80h,50h,34h,0,0,80h,80h,60h       ; 2771 00 5f 57 2c 00 00 80 80 50 34 00 00 80 80 60   ._W,....P4....`
        .db     34h,0,20h       ; 2780 34 00 20   4. 
l2783:  .db     0,6fh,57h,58h,0,0,80h,80h,55h,34h,0,0,80h,80h,5bh       ; 2783 00 6f 57 58 00 00 80 80 55 34 00 00 80 80 5b   .oWX....U4....[
        .db     34h,0,20h       ; 2792 34 00 20   4. 

; Fill 9800 to 9bff with 2f
l2795:  ld      hl,9bffh        ; 2795 21 ff 9b   !..
l2798:  ld      bc,400h         ; 2798 01 00 04   ...
l279b:  ld      a,2fh           ; 279b 3e 2f   >/
        ldd     (hl),a          ; 279d 32   2
        dec     bc              ; 279e 0b   .
        ld      a,b             ; 279f 78   x
        or      c               ; 27a0 b1   1
        jr      nz,l279b        ; 27a1 20 f8    x
        ret                     ; 27a3 c9   I

; Move a block of memory (Same as z80 LDIR)
;  HL = Start Addr
;  DE = End Addr
;  BC = Length of data
l27a4:  ldi     a,(hl)          ; 27a4 2a   *
        ld      (de),a          ; 27a5 12   .
        inc     de              ; 27a6 13   .
        dec     bc              ; 27a7 0b   .
        ld      a,b             ; 27a8 78   x
        or      c               ; 27a9 b1   1
        jr      nz,l27a4        ; 27aa 20 f8    x
        ret                     ; 27ac c9   I

l27ad:  call    l27c3           ; 27ad cd c3 27   MC'
        ld      bc,0a0h         ; 27b0 01 a0 00   . .
        call    l27a4           ; 27b3 cd a4 27   M$'
        ld      hl,l323f        ; 27b6 21 3f 32   !?2
        ld      de,8300h        ; 27b9 11 00 83   ...
        ld      bc,0d00h        ; 27bc 01 00 0d   ...
        call    l27a4           ; 27bf cd a4 27   M$'
        ret                     ; 27c2 c9   I

; Copy characters with only two colors
l27c3:  ld      hl,l415f        ; 27c3 21 5f 41   !_A
        ld      bc,l0138        ; 27c6 01 38 01   .8.
        ld      de,8000h        ; 27c9 11 00 80   ...
l27cc:  ldi     a,(hl)          ; 27cc 2a   *
        ld      (de),a          ; 27cd 12   .
        inc     de              ; 27ce 13   .
        ld      (de),a          ; 27cf 12   .
        inc     de              ; 27d0 13   .
        dec     bc              ; 27d1 0b   .
        ld      a,b             ; 27d2 78   x
        or      c               ; 27d3 b1   1
        jr      nz,l27cc        ; 27d4 20 f6    v
        ret                     ; 27d6 c9   I

; Copy character set to character ram
l27d7:  call    27c3h           ; 27d7 cd c3 27   MC'
        ld      bc,0da0h        ; 27da 01 a0 0d   . .
        call    l27a4           ; 27dd cd a4 27   M$'
        ret                     ; 27e0 c9   I

; This instruction is not used.
        ld      bc,1000h        ; 27e1 01 00 10   ...
l27e4:  ld      de,8000h        ; 27e4 11 00 80   ...
        call    l27a4           ; 27e7 cd a4 27   M$'
l27ea:  ret                     ; 27ea c9   I

; Copy a screen from DE to screen ram
l27eb:  ld      hl,9800h        ; 27eb 21 00 98   !..
l27ee:  ld      b,12h           ; 27ee 06 12   ..
l27f0:  push    hl              ; 27f0 e5   e
        ld      c,14h           ; 27f1 0e 14   ..
l27f3:  ld      a,(de)          ; 27f3 1a   .
        ldi     (hl),a          ; 27f4 22   "
        inc     de              ; 27f5 13   .
        dec     c               ; 27f6 0d   .
        jr      nz,l27f3        ; 27f7 20 fa    z
        pop     hl              ; 27f9 e1   a
        push    de              ; 27fa d5   U
        ld      de,20h          ; 27fb 11 20 00   . .
        add     hl,de           ; 27fe 19   .
        pop     de              ; 27ff d1   Q
        dec     b               ; 2800 05   .
        jr      nz,l27f0        ; 2801 20 ed    m
        ret                     ; 2803 c9   I

l2804:  ld      b,0ah           ; 2804 06 0a   ..
        push    hl              ; 2806 e5   e
l2807:  ld      a,(de)          ; 2807 1a   .
        cp      0ffh            ; 2808 fe ff   ..
        jr      z,l281a         ; 280a 28 0e   (.
        ldi     (hl),a          ; 280c 22   "
        inc     de              ; 280d 13   .
        dec     b               ; 280e 05   .
        jr      nz,l2807        ; 280f 20 f6    v
        pop     hl              ; 2811 e1   a
        push    de              ; 2812 d5   U
        ld      de,20h          ; 2813 11 20 00   . .
        add     hl,de           ; 2816 19   .
        pop     de              ; 2817 d1   Q
        jr      l2804           ; 2818 18 ea   .j

l281a:  pop     hl              ; 281a e1   a
        ld      a,2             ; 281b 3e 02   >.
        ldh     (0e3h),a        ; 281d e0 e3   `c
        ret                     ; 281f c9   I

; Prepare for screen memory update by halting LCD controller
l2820:  ldh     a,(0ffh)        ; 2820 f0 ff   p.
        ldh     (0a1h),a        ; 2822 e0 a1   `!
        res     0,a             ; 2824 cb 87   K.
        ldh     (0ffh),a        ; 2826 e0 ff   `.
l2828:  ldh     a,(44h)         ; 2828 f0 44   pD
        cp      91h             ; 282a fe 91   ..
        jr      nz,l2828        ; 282c 20 fa    z
        ldh     a,(40h)         ; 282e f0 40   p@
        and     7fh             ; 2830 e6 7f   f.
        ldh     (40h),a         ; 2832 e0 40   `@
        ldh     a,(0a1h)        ; 2834 f0 a1   p!
        ldh     (0ffh),a        ; 2836 e0 ff   `.
        ret                     ; 2838 c9   I

l2839:  .db     2fh,2fh,11h,12h,1dh,2fh,2fh,2fh,2fh,2fh,29h,29h,29h     ; 2839 2f 2f 11 12 1d 2f 2f 2f 2f 2f 29 29 29   //.../////)))
        .db     2fh,2fh,2fh,2fh,1ch,1dh,0ah,1bh,1dh,2fh,2fh,2fh,29h,29h ; 2846 2f 2f 2f 2f 1c 1d 0a 1b 1d 2f 2f 2f 29 29   ////.....///))
        .db     29h,29h,29h,2fh,2fh,2fh,2fh,2fh,1dh,18h,2fh,2fh,2fh,2fh ; 2854 29 29 29 2f 2f 2f 2f 2f 1d 18 2f 2f 2f 2f   )))/////..////
        .db     2fh,2fh,29h,29h,2fh,2fh,2fh,0ch,18h,17h,1dh,12h,17h,1eh ; 2862 2f 2f 29 29 2f 2f 2f 0c 18 17 1d 12 17 1e   //))///.......
        .db     0eh,29h,29h,29h,29h,29h,29h,29h,29h,2fh,2fh,10h,0ah,16h ; 2870 0e 29 29 29 29 29 29 29 29 2f 2f 10 0a 16   .))))))))//...
        .db     0eh,2fh,2fh,2fh,2fh,29h,29h,29h,29h,2fh,2fh     ; 287e 0e 2f 2f 2f 2f 29 29 29 29 2f 2f   .////))))//
l2889:  .db     1ch,12h,17h,10h,15h,0eh,2fh,2fh,2fh,2fh,2fh,0,2fh       ; 2889 1c 12 17 10 15 0e 2f 2f 2f 2f 2f 00 2f   ....../////./
        .db     26h,2fh,4,0,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh ; 2896 26 2f 04 00 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f   &/..///////////
        .db     0,2fh,0dh,18h,1eh,0bh,15h,0eh,2fh,2fh,2fh,2fh,2fh,0,2fh ; 28a5 00 2f 0d 18 1e 0b 15 0e 2f 2f 2f 2f 2f 00 2f   ./....../////./
        .db     26h,2fh,1,0,0,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,0 ; 28b4 26 2f 01 00 00 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 00   &/...//////////.
        .db     2fh,1dh,1bh,12h,19h,15h,0eh,2fh,2fh,2fh,2fh,2fh,0,2fh,26h       ; 28c4 2f 1d 1b 12 19 15 0e 2f 2f 2f 2f 2f 00 2f 26   /....../////./&
        .db     2fh,3,0,0,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,0,2fh ; 28d3 2f 03 00 00 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 00 2f   /...//////////./
        .db     1dh,0eh,1dh,1bh,12h,1ch,2fh,2fh,2fh,2fh,2fh,0,2fh,26h,2fh       ; 28e3 1d 0e 1d 1b 12 1c 2f 2f 2f 2f 2f 00 2f 26 2f   ....../////./&/
        .db     1,2,0,0,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,0,2fh,0dh,1bh       ; 28f2 01 02 00 00 2f 2f 2f 2f 2f 2f 2f 2f 2f 00 2f 0d 1b   ..../////////./..
        .db     18h,19h,1ch,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh ; 2903 18 19 1c 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f   ...///////////
        .db     2fh,2fh,0,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,29h       ; 2911 2f 2f 00 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 29   //.///////////)
        .db     29h,29h,29h,29h,29h,29h,29h,29h,29h,1dh,11h,12h,1ch,2fh ; 2920 29 29 29 29 29 29 29 29 29 1d 11 12 1c 2f   )))))))))..../
        .db     1ch,1dh,0ah,10h,0eh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,0,2fh       ; 292e 1c 1d 0a 10 0e 2f 2f 2f 2f 2f 2f 2f 2f 00 2f   .....////////./
        .db     0ffh            ; 293d ff   .
l293e:  .db     61h,62h,62h,62h,62h,62h,62h,63h,64h,2fh,2fh,2fh,2fh     ; 293e 61 62 62 62 62 62 62 63 64 2f 2f 2f 2f   abbbbbbcd////
        .db     2fh,2fh,65h,64h,2fh,10h,0ah,16h,0eh,2fh,65h,64h,2fh,0adh        ; 294b 2f 2f 65 64 2f 10 0a 16 0e 2f 65 64 2f ad   //ed/..../ed/-
        .db     0adh,0adh,0adh,2fh,65h,64h,2fh,18h,1fh,0eh,1bh,2fh,65h,64h      ; 2959 ad ad ad 2f 65 64 2f 18 1f 0e 1b 2f 65 64   ---/ed/..../ed
        .db     2fh,0adh,0adh,0adh,0adh,2fh,65h,66h,69h,69h,69h,69h,69h ; 2967 2f ad ad ad ad 2f 65 66 69 69 69 69 69   /----/efiiiii
        .db     69h,6ah         ; 2974 69 6a   ij
l2976:  .db     19h,15h,0eh,0ah,1ch,0eh,2fh,2fh,29h,29h,29h,29h,29h     ; 2976 19 15 0e 0a 1c 0e 2f 2f 29 29 29 29 29   ......//)))))
        .db     29h,2fh,2fh,2fh,1dh,1bh,22h,2fh,2fh,2fh,2fh,2fh,29h,29h ; 2983 29 2f 2f 2f 1d 1b 22 2f 2f 2f 2f 2f 29 29   )///.."/////))
        .db     29h,2fh,2fh,2fh,2fh,2fh,2fh,0ah,10h,0ah,12h,17h,27h,2fh ; 2991 29 2f 2f 2f 2f 2f 2f 0a 10 0a 12 17 27 2f   )//////.....'/
        .db     2fh,29h,29h,29h,29h,29h,2fh     ; 299f 2f 29 29 29 29 29 2f   /)))))/

; Read buttons & return value at ff81
;  $80 - Start   $8 - Down
;  $40 - Select  $4 - Up
;  $20 - B       $2 - Left
;  $10 - A       $1 - Right
l29a6:  ld      a,20h           ; 29a6 3e 20   > 
        ldh     (0),a           ; 29a8 e0 00   `.
        ldh     a,(0)           ; 29aa f0 00   p.
        ldh     a,(0)           ; 29ac f0 00   p.
        ldh     a,(0)           ; 29ae f0 00   p.
        ldh     a,(0)           ; 29b0 f0 00   p.
        cpl                     ; 29b2 2f   /
        and     0fh             ; 29b3 e6 0f   f.
        swap    a               ; 29b5 cb 37   K7
        ld      b,a             ; 29b7 47   G
        ld      a,10h           ; 29b8 3e 10   >.
        ldh     (0),a           ; 29ba e0 00   `.
        ldh     a,(0)           ; 29bc f0 00   p.
        ldh     a,(0)           ; 29be f0 00   p.
        ldh     a,(0)           ; 29c0 f0 00   p.
        ldh     a,(0)           ; 29c2 f0 00   p.
        ldh     a,(0)           ; 29c4 f0 00   p.
        ldh     a,(0)           ; 29c6 f0 00   p.
        ldh     a,(0)           ; 29c8 f0 00   p.
        ldh     a,(0)           ; 29ca f0 00   p.
        ldh     a,(0)           ; 29cc f0 00   p.
        ldh     a,(0)           ; 29ce f0 00   p.
        cpl                     ; 29d0 2f   /
        and     0fh             ; 29d1 e6 0f   f.
        or      b               ; 29d3 b0   0
; debounce keys to minimize errors
        ld      c,a             ; 29d4 4f   O
        ldh     a,(80h)         ; 29d5 f0 80   p.
        xor     c               ; 29d7 a9   )
        and     c               ; 29d8 a1   !
        ldh     (81h),a         ; 29d9 e0 81   `.
        ld      a,c             ; 29db 79   y
        ldh     (80h),a         ; 29dc e0 80   `.
        ld      a,30h           ; 29de 3e 30   >0
        ldh     (0),a           ; 29e0 e0 00   `.
        ret                     ; 29e2 c9   I

l29e3:  ldh     a,(0b2h)        ; 29e3 f0 b2   p2
        sub     10h             ; 29e5 d6 10   V.
        srl     a               ; 29e7 cb 3f   K?
        srl     a               ; 29e9 cb 3f   K?
        srl     a               ; 29eb cb 3f   K?
        ld      de,0            ; 29ed 11 00 00   ...
        ld      e,a             ; 29f0 5f   _
        ld      hl,9800h        ; 29f1 21 00 98   !..
        ld      b,20h           ; 29f4 06 20   . 
l29f6:  add     hl,de           ; 29f6 19   .
        dec     b               ; 29f7 05   .
        jr      nz,l29f6        ; 29f8 20 fc    |
        ldh     a,(0b3h)        ; 29fa f0 b3   p3
        sub     8               ; 29fc d6 08   V.
        srl     a               ; 29fe cb 3f   K?
        srl     a               ; 2a00 cb 3f   K?
        srl     a               ; 2a02 cb 3f   K?
        ld      de,0            ; 2a04 11 00 00   ...
        ld      e,a             ; 2a07 5f   _
        add     hl,de           ; 2a08 19   .
        ld      a,h             ; 2a09 7c   |
        ldh     (0b5h),a        ; 2a0a e0 b5   `5
        ld      a,l             ; 2a0c 7d   }
        ldh     (0b4h),a        ; 2a0d e0 b4   `4
        ret                     ; 2a0f c9   I

; This routine is not used.
        ldh     a,(0b5h)        ; 2a10 f0 b5   p5
        ld      d,a             ; 2a12 57   W
        ldh     a,(0b4h)        ; 2a13 f0 b4   p4
        ld      e,a             ; 2a15 5f   _
        ld      b,4             ; 2a16 06 04   ..
l2a18:  rr      d               ; 2a18 cb 1a   K.
        rr      e               ; 2a1a cb 1b   K.
        dec     b               ; 2a1c 05   .
        jr      nz,l2a18        ; 2a1d 20 f9    y
        ld      a,e             ; 2a1f 7b   {
        sub     84h             ; 2a20 d6 84   V.
        and     0feh            ; 2a22 e6 fe   f.
        rlca                    ; 2a24 07   .
        rlca                    ; 2a25 07   .
        add     a,8             ; 2a26 c6 08   F.
        ldh     (0b2h),a        ; 2a28 e0 b2   `2
        ldh     a,(0b4h)        ; 2a2a f0 b4   p4
        and     1fh             ; 2a2c e6 1f   f.
        rla                     ; 2a2e 17   .
        rla                     ; 2a2f 17   .
        rla                     ; 2a30 17   .
        add     a,8             ; 2a31 c6 08   F.
        ldh     (0b3h),a        ; 2a33 e0 b3   `3
        ret                     ; 2a35 c9   I

l2a36:  ldh     a,(0e0h)        ; 2a36 f0 e0   p`
        and     a               ; 2a38 a7   '
        ret     z               ; 2a39 c8   H
l2a3a:  ld      c,3             ; 2a3a 0e 03   ..
l2a3c:  xor     a               ; 2a3c af   /
        ldh     (0e0h),a        ; 2a3d e0 e0   ``
l2a3f:  ld      a,(de)          ; 2a3f 1a   .
        ld      b,a             ; 2a40 47   G
        swap    a               ; 2a41 cb 37   K7
        and     0fh             ; 2a43 e6 0f   f.
        jr      nz,l2a6f        ; 2a45 20 28    (
        ldh     a,(0e0h)        ; 2a47 f0 e0   p`
        and     a               ; 2a49 a7   '
        ld      a,0             ; 2a4a 3e 00   >.
        jr      nz,l2a50        ; 2a4c 20 02    .
        ld      a,2fh           ; 2a4e 3e 2f   >/
l2a50:  ldi     (hl),a          ; 2a50 22   "
        ld      a,b             ; 2a51 78   x
        and     0fh             ; 2a52 e6 0f   f.
        jr      nz,l2a77        ; 2a54 20 21    !
        ldh     a,(0e0h)        ; 2a56 f0 e0   p`
        and     a               ; 2a58 a7   '
        ld      a,0             ; 2a59 3e 00   >.
        jr      nz,l2a66        ; 2a5b 20 09    .
        ld      a,1             ; 2a5d 3e 01   >.
        cp      c               ; 2a5f b9   9
        ld      a,0             ; 2a60 3e 00   >.
        jr      z,l2a66         ; 2a62 28 02   (.
        ld      a,2fh           ; 2a64 3e 2f   >/
l2a66:  ldi     (hl),a          ; 2a66 22   "
        dec     e               ; 2a67 1d   .
        dec     c               ; 2a68 0d   .
        jr      nz,l2a3f        ; 2a69 20 d4    T
        xor     a               ; 2a6b af   /
        ldh     (0e0h),a        ; 2a6c e0 e0   ``
        ret                     ; 2a6e c9   I

l2a6f:  push    af              ; 2a6f f5   u
        ld      a,1             ; 2a70 3e 01   >.
        ldh     (0e0h),a        ; 2a72 e0 e0   ``
        pop     af              ; 2a74 f1   q
        jr      l2a50           ; 2a75 18 d9   .Y

l2a77:  push    af              ; 2a77 f5   u
        ld      a,1             ; 2a78 3e 01   >.
        ldh     (0e0h),a        ; 2a7a e0 e0   ``
        pop     af              ; 2a7c f1   q
        jr      l2a66           ; 2a7d 18 e7   .g

; Initiate DMA transfer from c000 to fe00
l2a7f:  ld      a,0c0h          ; 2a7f 3e c0   >@
        ldh     (46h),a         ; 2a81 e0 46   `F
        ld      a,28h           ; 2a83 3e 28   >(
l2a85:  dec     a               ; 2a85 3d   =
        jr      nz,l2a85        ; 2a86 20 fd    }
        ret                     ; 2a88 c9   I

l2a89:  ld      a,h             ; 2a89 7c   |
        ldh     (96h),a         ; 2a8a e0 96   `.
        ld      a,l             ; 2a8c 7d   }
        ldh     (97h),a         ; 2a8d e0 97   `.
        ld      a,(hl)          ; 2a8f 7e   .
        and     a               ; 2a90 a7   '
        jr      z,l2ab0         ; 2a91 28 1d   (.
        cp      80h             ; 2a93 fe 80   ..
        jr      z,l2aae         ; 2a95 28 17   (.
l2a97:  ldh     a,(96h)         ; 2a97 f0 96   p.
        ld      h,a             ; 2a99 67   g
        ldh     a,(97h)         ; 2a9a f0 97   p.
        ld      l,a             ; 2a9c 6f   o
        ld      de,10h          ; 2a9d 11 10 00   ...
        add     hl,de           ; 2aa0 19   .
        ldh     a,(8fh)         ; 2aa1 f0 8f   p.
        dec     a               ; 2aa3 3d   =
        ldh     (8fh),a         ; 2aa4 e0 8f   `.
        ret     z               ; 2aa6 c8   H
        jr      l2a89           ; 2aa7 18 e0   .`

l2aa9:  xor     a               ; 2aa9 af   /
        ldh     (95h),a         ; 2aaa e0 95   `.
        jr      l2a97           ; 2aac 18 e9   .i

l2aae:  ldh     (95h),a         ; 2aae e0 95   `.
l2ab0:  ld      b,7             ; 2ab0 06 07   ..
        ld      de,0ff86h       ; 2ab2 11 86 ff   ...
l2ab5:  ldi     a,(hl)          ; 2ab5 2a   *
        ld      (de),a          ; 2ab6 12   .
        inc     de              ; 2ab7 13   .
        dec     b               ; 2ab8 05   .
        jr      nz,l2ab5        ; 2ab9 20 fa    z
        ldh     a,(89h)         ; 2abb f0 89   p.
        ld      hl,l2b64        ; 2abd 21 64 2b   !d+
        rlca                    ; 2ac0 07   .
        ld      e,a             ; 2ac1 5f   _
        ld      d,0             ; 2ac2 16 00   ..
        add     hl,de           ; 2ac4 19   .
        ld      e,(hl)          ; 2ac5 5e   ^
        inc     hl              ; 2ac6 23   #
        ld      d,(hl)          ; 2ac7 56   V
        ld      a,(de)          ; 2ac8 1a   .
        ld      l,a             ; 2ac9 6f   o
        inc     de              ; 2aca 13   .
        ld      a,(de)          ; 2acb 1a   .
        ld      h,a             ; 2acc 67   g
        inc     de              ; 2acd 13   .
        ld      a,(de)          ; 2ace 1a   .
        ldh     (90h),a         ; 2acf e0 90   `.
        inc     de              ; 2ad1 13   .
        ld      a,(de)          ; 2ad2 1a   .
        ldh     (91h),a         ; 2ad3 e0 91   `.
        ld      e,(hl)          ; 2ad5 5e   ^
        inc     hl              ; 2ad6 23   #
        ld      d,(hl)          ; 2ad7 56   V
l2ad8:  inc     hl              ; 2ad8 23   #
        ldh     a,(8ch)         ; 2ad9 f0 8c   p.
        ldh     (94h),a         ; 2adb e0 94   `.
        ld      a,(hl)          ; 2add 7e   .
        cp      0ffh            ; 2ade fe ff   ..
        jr      z,l2aa9         ; 2ae0 28 c7   (G
        cp      0fdh            ; 2ae2 fe fd   .}
        jr      nz,l2af4        ; 2ae4 20 0e    .
        ldh     a,(8ch)         ; 2ae6 f0 8c   p.
        xor     20h             ; 2ae8 ee 20   n 
        ldh     (94h),a         ; 2aea e0 94   `.
        inc     hl              ; 2aec 23   #
        ld      a,(hl)          ; 2aed 7e   .
        jr      l2af8           ; 2aee 18 08   ..

l2af0:  inc     de              ; 2af0 13   .
        inc     de              ; 2af1 13   .
        jr      l2ad8           ; 2af2 18 e4   .d

l2af4:  cp      0feh            ; 2af4 fe fe   ..
        jr      z,l2af0         ; 2af6 28 f8   (x
l2af8:  ldh     (89h),a         ; 2af8 e0 89   `.
        ldh     a,(87h)         ; 2afa f0 87   p.
        ld      b,a             ; 2afc 47   G
        ld      a,(de)          ; 2afd 1a   .
        ld      c,a             ; 2afe 4f   O
        ldh     a,(8bh)         ; 2aff f0 8b   p.
        bit     6,a             ; 2b01 cb 77   Kw
        jr      nz,l2b0b        ; 2b03 20 06    .
        ldh     a,(90h)         ; 2b05 f0 90   p.
        add     a,b             ; 2b07 80   .
        adc     a,c             ; 2b08 89   .
        jr      l2b15           ; 2b09 18 0a   ..

l2b0b:  ld      a,b             ; 2b0b 78   x
        push    af              ; 2b0c f5   u
        ldh     a,(90h)         ; 2b0d f0 90   p.
        ld      b,a             ; 2b0f 47   G
        pop     af              ; 2b10 f1   q
        sub     b               ; 2b11 90   .
        sbc     a,c             ; 2b12 99   .
        sbc     a,8             ; 2b13 de 08   ^.
l2b15:  ldh     (93h),a         ; 2b15 e0 93   `.
        ldh     a,(88h)         ; 2b17 f0 88   p.
        ld      b,a             ; 2b19 47   G
        inc     de              ; 2b1a 13   .
        ld      a,(de)          ; 2b1b 1a   .
        inc     de              ; 2b1c 13   .
        ld      c,a             ; 2b1d 4f   O
        ldh     a,(8bh)         ; 2b1e f0 8b   p.
        bit     5,a             ; 2b20 cb 6f   Ko
        jr      nz,l2b2a        ; 2b22 20 06    .
        ldh     a,(91h)         ; 2b24 f0 91   p.
        add     a,b             ; 2b26 80   .
        adc     a,c             ; 2b27 89   .
        jr      l2b34           ; 2b28 18 0a   ..

l2b2a:  ld      a,b             ; 2b2a 78   x
        push    af              ; 2b2b f5   u
        ldh     a,(91h)         ; 2b2c f0 91   p.
        ld      b,a             ; 2b2e 47   G
        pop     af              ; 2b2f f1   q
        sub     b               ; 2b30 90   .
        sbc     a,c             ; 2b31 99   .
        sbc     a,8             ; 2b32 de 08   ^.
l2b34:  ldh     (92h),a         ; 2b34 e0 92   `.
        push    hl              ; 2b36 e5   e
        ldh     a,(8dh)         ; 2b37 f0 8d   p.
        ld      h,a             ; 2b39 67   g
        ldh     a,(8eh)         ; 2b3a f0 8e   p.
        ld      l,a             ; 2b3c 6f   o
        ldh     a,(95h)         ; 2b3d f0 95   p.
        and     a               ; 2b3f a7   '
        jr      z,l2b46         ; 2b40 28 04   (.
        ld      a,0ffh          ; 2b42 3e ff   >.
        jr      l2b48           ; 2b44 18 02   ..

l2b46:  ldh     a,(93h)         ; 2b46 f0 93   p.
l2b48:  ldi     (hl),a          ; 2b48 22   "
        ldh     a,(92h)         ; 2b49 f0 92   p.
        ldi     (hl),a          ; 2b4b 22   "
        ldh     a,(89h)         ; 2b4c f0 89   p.
        ldi     (hl),a          ; 2b4e 22   "
        ldh     a,(94h)         ; 2b4f f0 94   p.
        ld      b,a             ; 2b51 47   G
        ldh     a,(8bh)         ; 2b52 f0 8b   p.
        or      b               ; 2b54 b0   0
        ld      b,a             ; 2b55 47   G
        ldh     a,(8ah)         ; 2b56 f0 8a   p.
        or      b               ; 2b58 b0   0
        ldi     (hl),a          ; 2b59 22   "
        ld      a,h             ; 2b5a 7c   |
        ldh     (8dh),a         ; 2b5b e0 8d   `.
        ld      a,l             ; 2b5d 7d   }
        ldh     (8eh),a         ; 2b5e e0 8e   `.
        pop     hl              ; 2b60 e1   a
        jp      l2ad8           ; 2b61 c3 d8 2a   CX*

l2b64:  .dw     l2c20,l2c24,l2c28,l2c2c,l2c30,l2c34,l2c38,l2c3c,l2c40   ; 2b64 20 2c 24 2c 28 2c 2c 2c 30 2c 34 2c 38 2c 3c 2c 40 2c    ,$,(,,,0,4,8,<,@,
        .dw     l2c44,l2c48,l2c4c,l2c50,l2c54,l2c58,l2c5c,l2c60,l2c64,l2c68     ; 2b76 44 2c 48 2c 4c 2c 50 2c 54 2c 58 2c 5c 2c 60 2c 64 2c 68 2c   D,H,L,P,T,X,\,`,d,h,
        .dw     l2c6c,l2c70,l2c74,l2c78,l2c7c,l2c80,l2c84,l2c88,l2c8c,l2c90     ; 2b8a 6c 2c 70 2c 74 2c 78 2c 7c 2c 80 2c 84 2c 88 2c 8c 2c 90 2c   l,p,t,x,|,.,.,.,.,.,
        .dw     l2c94,l2c98,l2c9c,l2ca0,l2ca4,l2ca8,l2cac,l2cb0,l2cb4,l2cb8     ; 2b9e 94 2c 98 2c 9c 2c a0 2c a4 2c a8 2c ac 2c b0 2c b4 2c b8 2c   .,.,., ,$,(,,,0,4,8,
        .dw     l2cbc,l2cc0,l2cc4,l2cc8,l2ccc,l30c7,l2ccc,l2cd0,l2cd4,l2cd8     ; 2bb2 bc 2c c0 2c c4 2c c8 2c cc 2c c7 30 cc 2c d0 2c d4 2c d8 2c   <,@,D,H,L,G0L,P,T,X,
        .dw     l2cdc,l2ce0,l2ce4,l30ea,l30ee,l2ce8,l2cec,l30f2,l30f6,l2cf0     ; 2bc6 dc 2c e0 2c e4 2c ea 30 ee 30 e8 2c ec 2c f2 30 f6 30 f0 2c   \,`,d,j0n0h,l,r0v0p,
        .dw     l2cf4,l2cf8,l2cfc,l2d00,l2d04,l30fa,l30fe,l2d04,l2d08,l2d08     ; 2bda f4 2c f8 2c fc 2c 00 2d 04 2d fa 30 fe 30 04 2d 08 2d 08 2d   t,x,|,.-.-z0.0.-.-.-
        .dw     l2d0c,l2d10,l2d14,l2d18,l2d1c,l2d20,l2d24,l2d28,l2d2c,l2d30     ; 2bee 0c 2d 10 2d 14 2d 18 2d 1c 2d 20 2d 24 2d 28 2d 2c 2d 30 2d   .-.-.-.-.- -$-(-,-0-
        .dw     l2d34,l2d38,l2d3c,l2d40,l2d44,l2d48,l2d4c,l2d50,l2d54,l310a     ; 2c02 34 2d 38 2d 3c 2d 40 2d 44 2d 48 2d 4c 2d 50 2d 54 2d 0a 31   4-8-<-@-D-H-L-P-T-.1
        .dw     l310e,l3112,l3112,l3102,l3106   ; 2c16 0e 31 12 31 12 31 02 31 06 31   .1.1.1.1.1
l2c20:  .dw     l2d58,0f0efh    ; 2c20 58 2d ef f0   X-op
l2c24:  .dw     l2d68,0f0efh    ; 2c24 68 2d ef f0   h-op
l2c28:  .dw     l2d7a,0f0efh    ; 2c28 7a 2d ef f0   z-op
l2c2c:  .dw     l2d89,0f0efh    ; 2c2c 89 2d ef f0   .-op
l2c30:  .dw     l2d9a,0f0efh    ; 2c30 9a 2d ef f0   .-op
l2c34:  .dw     l2dac,0f0efh    ; 2c34 ac 2d ef f0   ,-op
l2c38:  .dw     l2dbd,0f0efh    ; 2c38 bd 2d ef f0   =-op
l2c3c:  .dw     l2dcb,0f0efh    ; 2c3c cb 2d ef f0   K-op
l2c40:  .dw     l2ddc,0f0efh    ; 2c40 dc 2d ef f0   \-op
l2c44:  .dw     l2deb,0f0efh    ; 2c44 eb 2d ef f0   k-op
l2c48:  .dw     l2dfc,0f0efh    ; 2c48 fc 2d ef f0   |-op
l2c4c:  .dw     l2e0b,0f0efh    ; 2c4c 0b 2e ef f0   ..op
l2c50:  .dw     l2e1c,0f0efh    ; 2c50 1c 2e ef f0   ..op
l2c54:  .dw     l2e2e,0f0efh    ; 2c54 2e 2e ef f0   ..op
l2c58:  .dw     l2e40,0f0efh    ; 2c58 40 2e ef f0   @.op
l2c5c:  .dw     l2e52,0f0efh    ; 2c5c 52 2e ef f0   R.op
l2c60:  .dw     l2e64,0f0efh    ; 2c60 64 2e ef f0   d.op
l2c64:  .dw     l2e76,0f0efh    ; 2c64 76 2e ef f0   v.op
l2c68:  .dw     l2e86,0f0efh    ; 2c68 86 2e ef f0   ..op
l2c6c:  .dw     l2e98,0f0efh    ; 2c6c 98 2e ef f0   ..op
l2c70:  .dw     l2ea8,0f0efh    ; 2c70 a8 2e ef f0   (.op
l2c74:  .dw     l2eb9,0f0efh    ; 2c74 b9 2e ef f0   9.op
l2c78:  .dw     l2eca,0f0efh    ; 2c78 ca 2e ef f0   J.op
l2c7c:  .dw     l2edb,0f0efh    ; 2c7c db 2e ef f0   [.op
l2c80:  .dw     l2f0b,0f0efh    ; 2c80 0b 2f ef f0   ./op
l2c84:  .dw     l2f1c,0f0efh    ; 2c84 1c 2f ef f0   ./op
l2c88:  .dw     l2eec,0f0efh    ; 2c88 ec 2e ef f0   l.op
l2c8c:  .dw     l2efa,0f0efh    ; 2c8c fa 2e ef f0   z.op
l2c90:  .dw     l2f2d,0e800h    ; 2c90 2d 2f 00 e8   -/.h
l2c94:  .dw     l2f36,0e800h    ; 2c94 36 2f 00 e8   6/.h
l2c98:  .dw     l2f3f,0e800h    ; 2c98 3f 2f 00 e8   ?/.h
l2c9c:  .dw     l2f48,0e800h    ; 2c9c 48 2f 00 e8   H/.h
l2ca0:  .dw     l2f51,0         ; 2ca0 51 2f 00 00   Q/..
l2ca4:  .dw     l2f55,0         ; 2ca4 55 2f 00 00   U/..
l2ca8:  .dw     l2f59,0         ; 2ca8 59 2f 00 00   Y/..
l2cac:  .dw     l2f5d,0         ; 2cac 5d 2f 00 00   ]/..
l2cb0:  .dw     l2f61,0         ; 2cb0 61 2f 00 00   a/..
l2cb4:  .dw     l2f65,0         ; 2cb4 65 2f 00 00   e/..
l2cb8:  .dw     l2f69,0         ; 2cb8 69 2f 00 00   i/..
l2cbc:  .dw     l2f6d,0         ; 2cbc 6d 2f 00 00   m/..
l2cc0:  .dw     l2f71,0         ; 2cc0 71 2f 00 00   q/..
l2cc4:  .dw     l2f75,0         ; 2cc4 75 2f 00 00   u/..
l2cc8:  .dw     l2f79,0f8f0h    ; 2cc8 79 2f f0 f8   y/px
l2ccc:  .dw     l2f84,0f8f0h    ; 2ccc 84 2f f0 f8   ./px
l2cd0:  .dw     l2f8f,0f0f0h    ; 2cd0 8f 2f f0 f0   ./pp
l2cd4:  .dw     l2fa3,0f0f0h    ; 2cd4 a3 2f f0 f0   #/pp
l2cd8:  .dw     l2fb8,0f8f8h    ; 2cd8 b8 2f f8 f8   8/xx
l2cdc:  .dw     l2fc1,0f8f8h    ; 2cdc c1 2f f8 f8   A/xx
l2ce0:  .dw     l2fca,0f8f8h    ; 2ce0 ca 2f f8 f8   J/xx
l2ce4:  .dw     l2fd1,0f8f8h    ; 2ce4 d1 2f f8 f8   Q/xx
l2ce8:  .dw     l2fd8,0f8f0h    ; 2ce8 d8 2f f0 f8   X/px
l2cec:  .dw     l2fe3,0f8f0h    ; 2cec e3 2f f0 f8   c/px
l2cf0:  .dw     l2fee,0f0f0h    ; 2cf0 ee 2f f0 f0   n/pp
l2cf4:  .dw     l3003,0f0f0h    ; 2cf4 03 30 f0 f0   .0pp
l2cf8:  .dw     l3019,0f8f8h    ; 2cf8 19 30 f8 f8   .0xx
l2cfc:  .dw     l3022,0f8f8h    ; 2cfc 22 30 f8 f8   "0xx
l2d00:  .dw     l302b,0f8f8h    ; 2d00 2b 30 f8 f8   +0xx
l2d04:  .dw     l3032,0f8f8h    ; 2d04 32 30 f8 f8   20xx
l2d08:  .dw     l3039,0f8f8h    ; 2d08 39 30 f8 f8   90xx
l2d0c:  .dw     l3040,0f8f8h    ; 2d0c 40 30 f8 f8   @0xx
l2d10:  .dw     l3047,0f8f8h    ; 2d10 47 30 f8 f8   G0xx
l2d14:  .dw     l304e,0f8f8h    ; 2d14 4e 30 f8 f8   N0xx
l2d18:  .dw     l3055,0f8f8h    ; 2d18 55 30 f8 f8   U0xx
l2d1c:  .dw     l305c,0f8f8h    ; 2d1c 5c 30 f8 f8   \0xx
l2d20:  .dw     l3067,0f8f8h    ; 2d20 67 30 f8 f8   g0xx
l2d24:  .dw     l306e,0f8f8h    ; 2d24 6e 30 f8 f8   n0xx
l2d28:  .dw     l3075,0f8f8h    ; 2d28 75 30 f8 f8   u0xx
l2d2c:  .dw     l307c,0f8f8h    ; 2d2c 7c 30 f8 f8   |0xx
l2d30:  .dw     l3083,0f8f8h    ; 2d30 83 30 f8 f8   .0xx
l2d34:  .dw     l308c,0f8f8h    ; 2d34 8c 30 f8 f8   .0xx
l2d38:  .dw     l3095,0f8f8h    ; 2d38 95 30 f8 f8   .0xx
l2d3c:  .dw     l309e,0f8f8h    ; 2d3c 9e 30 f8 f8   .0xx
l2d40:  .dw     l30a7,0f8f8h    ; 2d40 a7 30 f8 f8   '0xx
l2d44:  .dw     l30b0,0f8f8h    ; 2d44 b0 30 f8 f8   00xx
l2d48:  .dw     l30b9,0f8f8h    ; 2d48 b9 30 f8 f8   90xx
l2d4c:  .dw     l30c0,0f8f8h    ; 2d4c c0 30 f8 f8   @0xx
l2d50:  .dw     l3146,0f0f0h    ; 2d50 46 31 f0 f0   F1pp
l2d54:  .dw     l315d,0f8f8h    ; 2d54 5d 31 f8 f8   ]1xx
l2d58:  .dw     l31a9           ; 2d58 a9 31   )1
        .db     0feh,0feh,0feh,0feh,0feh,0feh,0feh,0feh,84h,84h,84h,0feh        ; 2d5a fe fe fe fe fe fe fe fe 84 84 84 fe   ............
        .db     84h,0ffh        ; 2d66 84 ff   ..
l2d68:  .dw     l31a9           ; 2d68 a9 31   )1
        .db     0feh,0feh,0feh,0feh,0feh,84h,0feh,0feh,0feh,84h,0feh,0feh       ; 2d6a fe fe fe fe fe 84 fe fe fe 84 fe fe   ............
        .db     0feh,84h,84h,0ffh       ; 2d76 fe 84 84 ff   ....
l2d7a:  .dw     l31a9           ; 2d7a a9 31   )1
        .db     0feh,0feh,0feh,0feh,0feh,0feh,84h,0feh,84h,84h,84h,0feh ; 2d7c fe fe fe fe fe fe 84 fe 84 84 84 fe   ............
        .db     0ffh            ; 2d88 ff   .
l2d89:  .dw     l31a9           ; 2d89 a9 31   )1
        .db     0feh,0feh,0feh,0feh,84h,84h,0feh,0feh,0feh,84h,0feh,0feh        ; 2d8b fe fe fe fe 84 84 fe fe fe 84 fe fe   ............
        .db     0feh,84h,0ffh   ; 2d97 fe 84 ff   ...
l2d9a:  .dw     l31a9           ; 2d9a a9 31   )1
        .db     0feh,0feh,0feh,0feh,0feh,0feh,0feh,0feh,81h,81h,81h,0feh        ; 2d9c fe fe fe fe fe fe fe fe 81 81 81 fe   ............
        .db     0feh,0feh,81h,0ffh      ; 2da8 fe fe 81 ff   ....
l2dac:  .dw     l31a9           ; 2dac a9 31   )1
        .db     0feh,0feh,0feh,0feh,0feh,81h,81h,0feh,0feh,81h,0feh,0feh        ; 2dae fe fe fe fe fe 81 81 fe fe 81 fe fe   ............
        .db     0feh,81h,0ffh   ; 2dba fe 81 ff   ...
l2dbd:  .dw     l31a9           ; 2dbd a9 31   )1
        .db     0feh,0feh,0feh,0feh,81h,0feh,0feh,0feh,81h,81h,81h,0ffh ; 2dbf fe fe fe fe 81 fe fe fe 81 81 81 ff   ............
l2dcb:  .dw     l31a9           ; 2dcb a9 31   )1
        .db     0feh,0feh,0feh,0feh,0feh,81h,0feh,0feh,0feh,81h,0feh,0feh       ; 2dcd fe fe fe fe fe 81 fe fe fe 81 fe fe   ............
        .db     81h,81h,0ffh    ; 2dd9 81 81 ff   ...
l2ddc:  .dw     l31a9           ; 2ddc a9 31   )1
        .db     0feh,0feh,0feh,0feh,0feh,0feh,0feh,0feh,8ah,8bh,8bh,8fh ; 2dde fe fe fe fe fe fe fe fe 8a 8b 8b 8f   ............
        .db     0ffh            ; 2dea ff   .
l2deb:  .dw     l31a9           ; 2deb a9 31   )1
        .db     0feh,80h,0feh,0feh,0feh,88h,0feh,0feh,0feh,88h,0feh,0feh        ; 2ded fe 80 fe fe fe 88 fe fe fe 88 fe fe   ............
        .db     0feh,89h,0ffh   ; 2df9 fe 89 ff   ...
l2dfc:  .dw     l31a9           ; 2dfc a9 31   )1
        .db     0feh,0feh,0feh,0feh,0feh,0feh,0feh,0feh,8ah,8bh,8bh,8fh ; 2dfe fe fe fe fe fe fe fe fe 8a 8b 8b 8f   ............
        .db     0ffh            ; 2e0a ff   .
l2e0b:  .dw     l31a9           ; 2e0b a9 31   )1
        .db     0feh,80h,0feh,0feh,0feh,88h,0feh,0feh,0feh,88h,0feh,0feh        ; 2e0d fe 80 fe fe fe 88 fe fe fe 88 fe fe   ............
        .db     0feh,89h,0ffh   ; 2e19 fe 89 ff   ...
l2e1c:  .dw     l31a9           ; 2e1c a9 31   )1
        .db     0feh,0feh,0feh,0feh,0feh,0feh,0feh,0feh,0feh,83h,83h,0feh       ; 2e1e fe fe fe fe fe fe fe fe fe 83 83 fe   ............
        .db     0feh,83h,83h,0ffh       ; 2e2a fe 83 83 ff   ....
l2e2e:  .dw     l31a9           ; 2e2e a9 31   )1
        .db     0feh,0feh,0feh,0feh,0feh,0feh,0feh,0feh,0feh,83h,83h,0feh       ; 2e30 fe fe fe fe fe fe fe fe fe 83 83 fe   ............
        .db     0feh,83h,83h,0ffh       ; 2e3c fe 83 83 ff   ....
l2e40:  .dw     l31a9           ; 2e40 a9 31   )1
        .db     0feh,0feh,0feh,0feh,0feh,0feh,0feh,0feh,0feh,83h,83h,0feh       ; 2e42 fe fe fe fe fe fe fe fe fe 83 83 fe   ............
        .db     0feh,83h,83h,0ffh       ; 2e4e fe 83 83 ff   ....
l2e52:  .dw     l31a9           ; 2e52 a9 31   )1
        .db     0feh,0feh,0feh,0feh,0feh,0feh,0feh,0feh,0feh,83h,83h,0feh       ; 2e54 fe fe fe fe fe fe fe fe fe 83 83 fe   ............
        .db     0feh,83h,83h,0ffh       ; 2e60 fe 83 83 ff   ....
l2e64:  .dw     l31a9           ; 2e64 a9 31   )1
        .db     0feh,0feh,0feh,0feh,0feh,0feh,0feh,0feh,82h,82h,0feh,0feh       ; 2e66 fe fe fe fe fe fe fe fe 82 82 fe fe   ............
        .db     0feh,82h,82h,0ffh       ; 2e72 fe 82 82 ff   ....
l2e76:  .dw     l31a9           ; 2e76 a9 31   )1
        .db     0feh,0feh,0feh,0feh,0feh,82h,0feh,0feh,82h,82h,0feh,0feh        ; 2e78 fe fe fe fe fe 82 fe fe 82 82 fe fe   ............
        .db     82h,0ffh        ; 2e84 82 ff   ..
l2e86:  .dw     l31a9           ; 2e86 a9 31   )1
        .db     0feh,0feh,0feh,0feh,0feh,0feh,0feh,0feh,82h,82h,0feh,0feh       ; 2e88 fe fe fe fe fe fe fe fe 82 82 fe fe   ............
        .db     0feh,82h,82h,0ffh       ; 2e94 fe 82 82 ff   ....
l2e98:  .dw     l31a9           ; 2e98 a9 31   )1
        .db     0feh,0feh,0feh,0feh,0feh,82h,0feh,0feh,82h,82h,0feh,0feh        ; 2e9a fe fe fe fe fe 82 fe fe 82 82 fe fe   ............
        .db     82h,0ffh        ; 2ea6 82 ff   ..
l2ea8:  .dw     l31a9           ; 2ea8 a9 31   )1
        .db     0feh,0feh,0feh,0feh,0feh,0feh,0feh,0feh,0feh,86h,86h,0feh       ; 2eaa fe fe fe fe fe fe fe fe fe 86 86 fe   ............
        .db     86h,86h,0ffh    ; 2eb6 86 86 ff   ...
l2eb9:  .dw     l31a9           ; 2eb9 a9 31   )1
        .db     0feh,0feh,0feh,0feh,86h,0feh,0feh,0feh,86h,86h,0feh,0feh        ; 2ebb fe fe fe fe 86 fe fe fe 86 86 fe fe   ............
        .db     0feh,86h,0ffh   ; 2ec7 fe 86 ff   ...
l2eca:  .dw     l31a9           ; 2eca a9 31   )1
        .db     0feh,0feh,0feh,0feh,0feh,0feh,0feh,0feh,0feh,86h,86h,0feh       ; 2ecc fe fe fe fe fe fe fe fe fe 86 86 fe   ............
        .db     86h,86h,0ffh    ; 2ed8 86 86 ff   ...
l2edb:  .dw     l31a9           ; 2edb a9 31   )1
        .db     0feh,0feh,0feh,0feh,86h,0feh,0feh,0feh,86h,86h,0feh,0feh        ; 2edd fe fe fe fe 86 fe fe fe 86 86 fe fe   ............
        .db     0feh,86h,0ffh   ; 2ee9 fe 86 ff   ...
l2eec:  .dw     l31a9           ; 2eec a9 31   )1
        .db     0feh,0feh,0feh,0feh,0feh,85h,0feh,0feh,85h,85h,85h,0ffh ; 2eee fe fe fe fe fe 85 fe fe 85 85 85 ff   ............
l2efa:  .dw     l31a9           ; 2efa a9 31   )1
        .db     0feh,0feh,0feh,0feh,0feh,85h,0feh,0feh,85h,85h,0feh,0feh        ; 2efc fe fe fe fe fe 85 fe fe 85 85 fe fe   ............
        .db     0feh,85h,0ffh   ; 2f08 fe 85 ff   ...
l2f0b:  .dw     l31a9           ; 2f0b a9 31   )1
        .db     0feh,0feh,0feh,0feh,0feh,0feh,0feh,0feh,85h,85h,85h,0feh        ; 2f0d fe fe fe fe fe fe fe fe 85 85 85 fe   ............
        .db     0feh,85h,0ffh   ; 2f19 fe 85 ff   ...
l2f1c:  .dw     l31a9           ; 2f1c a9 31   )1
        .db     0feh,0feh,0feh,0feh,0feh,85h,0feh,0feh,0feh,85h,85h,0feh        ; 2f1e fe fe fe fe fe 85 fe fe fe 85 85 fe   ............
        .db     0feh,85h,0ffh   ; 2f2a fe 85 ff   ...
l2f2d:  .dw     l31c9           ; 2f2d c9 31   I1
        .db     0ah,25h,1dh,22h,19h,0eh,0ffh    ; 2f2f 0a 25 1d 22 19 0e ff   .%."...
l2f36:  .dw     l31c9           ; 2f36 c9 31   I1
        .db     0bh,25h,1dh,22h,19h,0eh,0ffh    ; 2f38 0b 25 1d 22 19 0e ff   .%."...
l2f3f:  .dw     l31c9           ; 2f3f c9 31   I1
        .db     0ch,25h,1dh,22h,19h,0eh,0ffh    ; 2f41 0c 25 1d 22 19 0e ff   .%."...
l2f48:  .dw     l31c9           ; 2f48 c9 31   I1
        .db     2fh,18h,0fh,0fh,2fh,2fh,0ffh    ; 2f4a 2f 18 0f 0f 2f 2f ff   /...//.
l2f51:  .dw     l31c9           ; 2f51 c9 31   I1
        .db     0,0ffh          ; 2f53 00 ff   ..
l2f55:  .dw     l31c9           ; 2f55 c9 31   I1
        .db     1,0ffh          ; 2f57 01 ff   ..
l2f59:  .dw     l31c9           ; 2f59 c9 31   I1
        .db     2,0ffh          ; 2f5b 02 ff   ..
l2f5d:  .dw     l31c9           ; 2f5d c9 31   I1
        .db     3,0ffh          ; 2f5f 03 ff   ..
l2f61:  .dw     l31c9           ; 2f61 c9 31   I1
        .db     4,0ffh          ; 2f63 04 ff   ..
l2f65:  .dw     l31c9           ; 2f65 c9 31   I1
        .db     5,0ffh          ; 2f67 05 ff   ..
l2f69:  .dw     l31c9           ; 2f69 c9 31   I1
        .db     6,0ffh          ; 2f6b 06 ff   ..
l2f6d:  .dw     l31c9           ; 2f6d c9 31   I1
        .db     7,0ffh          ; 2f6f 07 ff   ..
l2f71:  .dw     l31c9           ; 2f71 c9 31   I1
        .db     8,0ffh          ; 2f73 08 ff   ..
l2f75:  .dw     l31c9           ; 2f75 c9 31   I1
        .db     9,0ffh          ; 2f77 09 ff   ..
l2f79:  .dw     l31d9           ; 2f79 d9 31   Y1
        .db     2fh,1,2fh,11h,20h,21h,30h,31h,0ffh      ; 2f7b 2f 01 2f 11 20 21 30 31 ff   /./. !01.
l2f84:  .dw     l31d9           ; 2f84 d9 31   Y1
        .db     2fh,3,12h,13h,22h,23h,32h,33h,0ffh      ; 2f86 2f 03 12 13 22 23 32 33 ff   /..."#23.
l2f8f:  .dw     l31a9           ; 2f8f a9 31   )1
        .db     2fh,5,0fdh,5,2fh,2fh,15h,4,17h,24h,25h,26h,27h,34h,35h,36h      ; 2f91 2f 05 fd 05 2f 2f 15 04 17 24 25 26 27 34 35 36   /.}.//...$%&'456
        .db     2fh,0ffh        ; 2fa1 2f ff   /.
l2fa3:  .dw     l31a9           ; 2fa3 a9 31   )1
        .db     8,37h,0fdh,37h,0fdh,8,18h,19h,14h,1bh,28h,29h,2ah,2bh,60h       ; 2fa5 08 37 fd 37 fd 08 18 19 14 1b 28 29 2a 2b 60   .7}7}.....()*+`
        .db     70h,36h,2fh,0ffh        ; 2fb4 70 36 2f ff   p6/.
l2fb8:  .dw     l31d9           ; 2fb8 d9 31   Y1
        .db     0b9h,0fdh,0b9h,0bah,0fdh,0bah,0ffh      ; 2fba b9 fd b9 ba fd ba ff   9}9:}:.
l2fc1:  .dw     l31d9           ; 2fc1 d9 31   Y1
        .db     82h,0fdh,82h,83h,0fdh,83h,0ffh  ; 2fc3 82 fd 82 83 fd 83 ff   .}..}..
l2fca:  .dw     l31d9           ; 2fca d9 31   Y1
        .db     9,0ah,3ah,3bh,0ffh      ; 2fcc 09 0a 3a 3b ff   ..:;.
l2fd1:  .dw     l31d9           ; 2fd1 d9 31   Y1
        .db     0bh,40h,7ch,6fh,0ffh    ; 2fd3 0b 40 7c 6f ff   .@|o.
l2fd8:  .dw     l31d9           ; 2fd8 d9 31   Y1
        .db     2fh,0fh,2fh,1fh,5fh,2ch,2fh,3fh,0ffh    ; 2fda 2f 0f 2f 1f 5f 2c 2f 3f ff   /./._,/?.
l2fe3:  .dw     l31d9           ; 2fe3 d9 31   Y1
        .db     6ch,3ch,4bh,4ch,5bh,5ch,6bh,2fh,0ffh    ; 2fe5 6c 3c 4b 4c 5b 5c 6b 2f ff   l<KL[\k/.
l2fee:  .dw     l31a9           ; 2fee a9 31   )1
        .db     2fh,4dh,0fdh,4dh,2fh,2fh,5dh,5eh,4eh,5fh,6dh,6eh,2fh,2fh        ; 2ff0 2f 4d fd 4d 2f 2f 5d 5e 4e 5f 6d 6e 2f 2f   /M}M//]^N_mn//
        .db     7dh,0fdh,7dh,2fh,0ffh   ; 2ffe 7d fd 7d 2f ff   }}}/.
l3003:  .dw     l31a9           ; 3003 a9 31   )1
        .db     8,77h,0fdh,77h,0fdh,8,18h,78h,43h,53h,7ah,7bh,50h,2fh,2fh       ; 3005 08 77 fd 77 fd 08 18 78 43 53 7a 7b 50 2f 2f   .w}w}..xCSz{P//
        .db     2,0fdh,7dh,2fh,0ffh     ; 3014 02 fd 7d 2f ff   .}}/.
l3019:  .dw     l31d9           ; 3019 d9 31   Y1
        .db     0b9h,0fdh,0b9h,0bah,0fdh,0bah,0ffh      ; 301b b9 fd b9 ba fd ba ff   9}9:}:.
l3022:  .dw     l31d9           ; 3022 d9 31   Y1
        .db     82h,0fdh,82h,83h,0fdh,83h,0ffh  ; 3024 82 fd 82 83 fd 83 ff   .}..}..
l302b:  .dw     l31d9           ; 302b d9 31   Y1
        .db     9,0ah,3ah,3bh,0ffh      ; 302d 09 0a 3a 3b ff   ..:;.
l3032:  .dw     l31d9           ; 3032 d9 31   Y1
        .db     0bh,40h,7ch,6fh,0ffh    ; 3034 0b 40 7c 6f ff   .@|o.
l3039:  .dw     l31d9           ; 3039 d9 31   Y1
        .db     0dch,0ddh,0e0h,0e1h,0ffh        ; 303b dc dd e0 e1 ff   \]`a.
l3040:  .dw     l31d9           ; 3040 d9 31   Y1
        .db     0deh,0dfh,0e0h,0e1h,0ffh        ; 3042 de df e0 e1 ff   ^_`a.
l3047:  .dw     l31d9           ; 3047 d9 31   Y1
        .db     0deh,0e2h,0e0h,0e4h,0ffh        ; 3049 de e2 e0 e4 ff   ^b`d.
l304e:  .dw     l31d9           ; 304e d9 31   Y1
        .db     0dch,0eeh,0e0h,0e3h,0ffh        ; 3050 dc ee e0 e3 ff   \n`c.
l3055:  .dw     l31d9           ; 3055 d9 31   Y1
        .db     0e5h,0e6h,0e7h,0e8h,0ffh        ; 3057 e5 e6 e7 e8 ff   efgh.
l305c:  .dw     l31d9           ; 305c d9 31   Y1
        .db     0fdh,0e6h,0fdh,0e5h,0fdh,0e8h,0fdh,0e7h,0ffh    ; 305e fd e6 fd e5 fd e8 fd e7 ff   }f}e}h}g.
l3067:  .dw     l31d9           ; 3067 d9 31   Y1
        .db     0e9h,0eah,0ebh,0ech,0ffh        ; 3069 e9 ea eb ec ff   ijkl.
l306e:  .dw     l31d9           ; 306e d9 31   Y1
        .db     0edh,0eah,0ebh,0ech,0ffh        ; 3070 ed ea eb ec ff   mjkl.
l3075:  .dw     l31d9           ; 3075 d9 31   Y1
        .db     0f2h,0f4h,0f3h,0bfh,0ffh        ; 3077 f2 f4 f3 bf ff   rts?.
l307c:  .dw     l31d9           ; 307c d9 31   Y1
        .db     0f4h,0f2h,0bfh,0f3h,0ffh        ; 307e f4 f2 bf f3 ff   tr?s.
l3083:  .dw     l31d9           ; 3083 d9 31   Y1
        .db     0c2h,0fdh,0c2h,0c3h,0fdh,0c3h,0ffh      ; 3085 c2 fd c2 c3 fd c3 ff   B}BC}C.
l308c:  .dw     l31d9           ; 308c d9 31   Y1
        .db     0c4h,0fdh,0c4h,0c5h,0fdh,0c5h,0ffh      ; 308e c4 fd c4 c5 fd c5 ff   D}DE}E.
l3095:  .dw     l31d9           ; 3095 d9 31   Y1
        .db     0dch,0fdh,0dch,0efh,0fdh,0efh,0ffh      ; 3097 dc fd dc ef fd ef ff   \}\o}o.
l309e:  .dw     l31d9           ; 309e d9 31   Y1
        .db     0f0h,0fdh,0f0h,0f1h,0fdh,0f1h,0ffh      ; 30a0 f0 fd f0 f1 fd f1 ff   p}pq}q.
l30a7:  .dw     l31d9           ; 30a7 d9 31   Y1
        .db     0dch,0fdh,0f0h,0f1h,0fdh,0efh,0ffh      ; 30a9 dc fd f0 f1 fd ef ff   \}pq}o.
l30b0:  .dw     l31d9           ; 30b0 d9 31   Y1
        .db     0f0h,0fdh,0dch,0efh,0fdh,0f1h,0ffh      ; 30b2 f0 fd dc ef fd f1 ff   p}\o}q.
l30b9:  .dw     l31d9           ; 30b9 d9 31   Y1
        .db     0bdh,0beh,0bbh,0bch,0ffh        ; 30bb bd be bb bc ff   =>;<.
l30c0:  .dw     l31d9           ; 30c0 d9 31   Y1
        .db     0b9h,0bah,0dah,0dbh,0ffh        ; 30c2 b9 ba da db ff   9:Z[.
l30c7:  .dw     l30cb           ; 30c7 cb 30   K0
        .db     0e0h,0f0h       ; 30c9 e0 f0   `p
l30cb:  .dw     l31f5           ; 30cb f5 31   u1
        .db     0c0h,0c1h,0c5h,0c6h,0cch,0cdh,75h,76h,0a4h,0a5h,0a6h,0a7h       ; 30cd c0 c1 c5 c6 cc cd 75 76 a4 a5 a6 a7   @AEFLMuv$%&'
        .db     54h,55h,56h,57h,44h,45h,46h,47h,0a0h,0a1h,0a2h,0a3h,9ch ; 30d9 54 55 56 57 44 45 46 47 a0 a1 a2 a3 9c   TUVWDEFG !"#.
        .db     9dh,9eh,9fh,0ffh        ; 30e6 9d 9e 9f ff   ....
l30ea:  .dw     l3116           ; 30ea 16 31   .1
        .db     0f8h,0e8h       ; 30ec f8 e8   xh
l30ee:  .dw     l311c           ; 30ee 1c 31   .1
        .db     0f0h,0e8h       ; 30f0 f0 e8   ph
l30f2:  .dw     l3125           ; 30f2 25 31   %1
        .db     0,0             ; 30f4 00 00   ..
l30f6:  .dw     l312b           ; 30f6 2b 31   +1
        .db     0,0             ; 30f8 00 00   ..
l30fa:  .dw     l3131           ; 30fa 31 31   11
        .db     0,0             ; 30fc 00 00   ..
l30fe:  .dw     l313a           ; 30fe 3a 31   :1
        .db     0,0             ; 3100 00 00   ..
l3102:  .dw     l319d           ; 3102 9d 31   .1
        .db     0,0             ; 3104 00 00   ..
l3106:  .dw     l31a3           ; 3106 a3 31   #1
        .db     0,0             ; 3108 00 00   ..
l310a:  .dw     l3164           ; 310a 64 31   d1
        .db     0d8h,0f8h       ; 310c d8 f8   Xx
l310e:  .dw     l317c           ; 310e 7c 31   |1
        .db     0e8h,0f8h       ; 3110 e8 f8   hx
l3112:  .dw     l318e           ; 3112 8e 31   .1
        .db     0f0h,0f8h       ; 3114 f0 f8   px
l3116:  .dw     l322d           ; 3116 2d 32   -2
        .db     63h,64h,65h,0ffh        ; 3118 63 64 65 ff   cde.
l311c:  .dw     l322d           ; 311c 2d 32   -2
        .db     63h,64h,65h,66h,67h,68h,0ffh    ; 311e 63 64 65 66 67 68 ff   cdefgh.
l3125:  .dw     l322d           ; 3125 2d 32   -2
        .db     41h,41h,41h,0ffh        ; 3127 41 41 41 ff   AAA.
l312b:  .dw     l322d           ; 312b 2d 32   -2
        .db     42h,42h,42h,0ffh        ; 312d 42 42 42 ff   BBB.
l3131:  .dw     l322d           ; 3131 2d 32   -2
        .db     52h,52h,52h,62h,62h,62h,0ffh    ; 3133 52 52 52 62 62 62 ff   RRRbbb.
l313a:  .dw     l322d           ; 313a 2d 32   -2
        .db     51h,51h,51h,61h,61h,61h,71h,71h,71h,0ffh        ; 313c 51 51 51 61 61 61 71 71 71 ff   QQQaaaqqq.
l3146:  .dw     l31a9           ; 3146 a9 31   )1
        .db     2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,63h,64h,0fdh,64h,0fdh,63h       ; 3148 2f 2f 2f 2f 2f 2f 2f 2f 63 64 fd 64 fd 63   ////////cd}d}c
        .db     66h,67h,0fdh,67h,0fdh,66h,0ffh  ; 3156 66 67 fd 67 fd 66 ff   fg}g}f.
l315d:  .dw     l31d9           ; 315d d9 31   Y1
        .db     2fh,2fh,63h,64h,0ffh    ; 315f 2f 2f 63 64 ff   //cd.
l3164:  .dw     l31d9           ; 3164 d9 31   Y1
        .db     0,0fdh,0,10h,0fdh,10h,4fh,0fdh,4fh,80h,0fdh,80h,80h,0fdh        ; 3166 00 fd 00 10 fd 10 4f fd 4f 80 fd 80 80 fd   .}..}.O}O.}..}
        .db     80h,81h,0fdh,81h,97h,0fdh,97h,0ffh      ; 3174 80 81 fd 81 97 fd 97 ff   ..}..}..
l317c:  .dw     l31d9           ; 317c d9 31   Y1
        .db     98h,0fdh,98h,99h,0fdh,99h,80h,0fdh,80h,9ah,0fdh,9ah,9bh ; 317e 98 fd 98 99 fd 99 80 fd 80 9a fd 9a 9b   .}..}..}..}..
        .db     0fdh,9bh,0ffh   ; 318b fd 9b ff   }..
l318e:  .dw     l31d9           ; 318e d9 31   Y1
        .db     0a8h,0fdh,0a8h,0a9h,0fdh,0a9h,0aah,0fdh,0aah,0abh,0fdh,0abh     ; 3190 a8 fd a8 a9 fd a9 aa fd aa ab fd ab   (}()})*}*+}+
        .db     0ffh            ; 319c ff   .
l319d:  .dw     l31d9           ; 319d d9 31   Y1
        .db     41h,2fh,2fh,0ffh        ; 319f 41 2f 2f ff   A//.
l31a3:  .dw     l31d9           ; 31a3 d9 31   Y1
        .db     52h,2fh,62h,0ffh        ; 31a5 52 2f 62 ff   R/b.
l31a9:  .db     0,0,0,8,0,10h,0,18h,8,0,8,8,8,10h,8,18h,10h,0,10h       ; 31a9 00 00 00 08 00 10 00 18 08 00 08 08 08 10 08 18 10 00 10   ...................
        .db     8,10h,10h,10h,18h,18h,0,18h,8,18h,10h,18h,18h   ; 31bc 08 10 10 10 18 18 00 18 08 18 10 18 18   .............
l31c9:  .db     0,0,0,8,0,10h,0,18h,0,20h,0,28h,0,30h,0,38h     ; 31c9 00 00 00 08 00 10 00 18 00 20 00 28 00 30 00 38   ......... .(.0.8
l31d9:  .db     0,0,0,8,8,0,8,8,10h,0,10h,8,18h,0,18h,8,20h,0,20h       ; 31d9 00 00 00 08 08 00 08 08 10 00 10 08 18 00 18 08 20 00 20   ................ . 
        .db     8,28h,0,28h,8,30h,0,30h,8       ; 31ec 08 28 00 28 08 30 00 30 08   .(.(.0.0.
l31f5:  .db     0,8,0,10h,8,8,8,10h,10h,0,10h,8,10h,10h,10h,18h,18h     ; 31f5 00 08 00 10 08 08 08 10 10 00 10 08 10 10 10 18 18   .................
        .db     0,18h,8,18h,10h,18h,18h,20h,0,20h,8,20h,10h,20h,18h,28h ; 3206 00 18 08 18 10 18 18 20 00 20 08 20 10 20 18 28   ....... . . . .(
        .db     0,28h,8,28h,10h,28h,18h,30h,0,30h,8,30h,10h,30h,18h,38h ; 3216 00 28 08 28 10 28 18 30 00 30 08 30 10 30 18 38   .(.(.(.0.0.0.0.8
        .db     0,38h,8,38h,10h,38h,18h ; 3226 00 38 08 38 10 38 18   .8.8.8.
l322d:  .db     0,0,0,8,0,10h,8,0,8,8,8,10h,10h,0,10h,8,10h,10h ; 322d 00 00 00 08 00 10 08 00 08 08 08 10 10 00 10 08 10 10   ..................
l323f:  .db     7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7ch,7ch,78h     ; 323f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7c 7c 78   ..........||x
        .db     79h,78h,7bh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh        ; 324c 79 78 7b ff ff ff ff ff ff ff ff ff   yx{.........
        .db     0ffh,0,0,0,0ffh,0,0,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh     ; 3258 ff 00 00 00 ff 00 00 ff ff ff ff ff ff ff ff   ...............
        .db     0ffh,0ffh,3fh,3fh,1fh,9fh,1fh,0dfh,78h,7bh,78h,79h,7ch,7ch      ; 3267 ff ff 3f 3f 1f 9f 1f df 78 7b 78 79 7c 7c   ..??..._x{xy||
        .db     7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,0,0,0,0ffh,0,0,0ffh     ; 3275 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 00 00 00 ff 00 00 ff   .................
        .db     0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,1fh,0dfh,1fh       ; 3286 ff ff ff ff ff ff ff ff ff 1f df 1f   .........._.
        .db     9fh,3fh,3fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh        ; 3292 9f 3f 3f ff ff ff ff ff ff ff ff ff   .??.........
        .db     0ffh,78h,7ah,78h,7ah,78h,7ah,78h,7ah,78h,7ah,78h,7ah,78h        ; 329e ff 78 7a 78 7a 78 7a 78 7a 78 7a 78 7a 78   .xzxzxzxzxzxzx
        .db     7ah,78h,7ah,1fh,5fh,1fh,5fh,1fh,5fh,1fh,5fh,1fh,5fh,1fh ; 32ac 7a 78 7a 1f 5f 1f 5f 1f 5f 1f 5f 1f 5f 1f   zxz._._._._._.
        .db     5fh,1fh,5fh,1fh,5fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0f8h     ; 32ba 5f 1f 5f 1f 5f ff ff ff ff ff ff ff f8   _._._.......x
        .db     0f8h,0f0h,0f2h,0e1h,0f5h,0e3h,0f2h,0e6h,0ffh,0ffh,0ffh,0ffh     ; 32c7 f8 f0 f2 e1 f5 e3 f2 e6 ff ff ff ff   xpraucrf....
        .db     0ffh,0ffh,0ffh,0,0,0,0,0ffh,0ffh,0ffh,0,0,0ffh,0ffh,0ffh        ; 32d3 ff ff ff 00 00 00 00 ff ff ff 00 00 ff ff ff   ...............
        .db     0ffh,0ffh,0ffh,0ffh,1fh,1fh,0fh,4fh,87h,0afh,0c7h,4fh,67h       ; 32e2 ff ff ff ff 1f 1f 0f 4f 87 af c7 4f 67   .......O./GOg
        .db     0f2h,0e6h,0f2h,0e6h,0f2h,0e6h,0f2h,0e6h,0f2h,0e6h,0f2h,0e6h     ; 32ef f2 e6 f2 e6 f2 e6 f2 e6 f2 e6 f2 e6   rfrfrfrfrfrf
        .db     0f2h,0e6h,0f2h,0e6h,4fh,67h,4fh,67h,4fh,67h,4fh,67h,4fh ; 32fb f2 e6 f2 e6 4f 67 4f 67 4f 67 4f 67 4f   rfrfOgOgOgOgO
        .db     67h,4fh,67h,4fh,67h,4fh,67h,0f2h,0e6h,0f5h,0e3h,0f2h,0e1h       ; 3308 67 4f 67 4f 67 4f 67 f2 e6 f5 e3 f2 e1   gOgOgOgrfucra
        .db     0f8h,0f0h,0ffh,0f8h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0,0,0ffh      ; 3315 f8 f0 ff f8 ff ff ff ff ff ff 00 00 ff   xp.x.........
        .db     0ffh,0,0ffh,0,0,0ffh,0,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,4fh        ; 3322 ff 00 ff 00 00 ff 00 ff ff ff ff ff ff 4f   .............O
        .db     67h,0afh,0c7h,4fh,87h,1fh,0fh,0ffh,1fh,0ffh,0ffh,0ffh,0ffh      ; 3330 67 af c7 4f 87 1f 0f ff 1f ff ff ff ff   g/GO.........
        .db     0ffh,0ffh,78h,7bh,78h,79h,7ch,7ch,7fh,7fh,7fh,7fh,7ch,7ch       ; 333d ff ff 78 7b 78 79 7c 7c 7f 7f 7f 7f 7c 7c   ..x{xy||....||
        .db     78h,79h,78h,7bh,1fh,0dfh,1fh,9fh,3fh,3fh,0ffh,0ffh,0ffh ; 334b 78 79 78 7b 1f df 1f 9f 3f 3f ff ff ff   xyx{._..??...
        .db     0ffh,3fh,3fh,1fh,9fh,1fh,0dfh,0,0,0,0ffh,0,0,0ffh,0ffh,0ffh     ; 3358 ff 3f 3f 1f 9f 1f df 00 00 00 ff 00 00 ff ff ff   .??..._.........
        .db     0ffh,0,0,0,0ffh,0,0,0,0,0,7fh,0,0,7fh,7fh,7fh,7fh,7fh,7fh       ; 3368 ff 00 00 00 ff 00 00 00 00 00 7f 00 00 7f 7f 7f 7f 7f 7f   ...................
        .db     7fh,7fh,7fh,7fh,78h,7ah,78h,7ah,78h,7ah,78h,7ah,78h,7ah ; 337b 7f 7f 7f 7f 78 7a 78 7a 78 7a 78 7a 78 7a   ....xzxzxzxzxz
        .db     0,2,0,7ah,0,7ah,1fh,5fh,1fh,5fh,1fh,5fh,1fh,5fh,1fh,5fh ; 3389 00 02 00 7a 00 7a 1f 5f 1f 5f 1f 5f 1f 5f 1f 5f   ...z.z._._._._._
        .db     0,40h,0,5fh,0,5fh,0,0,0,0ffh,0,0,0,0ffh,0,0ffh,0,0,0,0ffh       ; 3399 00 40 00 5f 00 5f 00 00 00 ff 00 00 00 ff 00 ff 00 00 00 ff   .@._._..............
        .db     0,0,0,0,0,0,3fh,3fh,3fh,3fh,30h,30h,30h,30h,33h,32h,33h ; 33ad 00 00 00 00 00 00 3f 3f 3f 3f 30 30 30 30 33 32 33   ......????0000323
        .db     30h,0,0,0,0,0ffh,0ffh,0ffh,0ffh,0,0,0,0,0ffh,2,0ffh,20h ; 33be 30 00 00 00 00 ff ff ff ff 00 00 00 00 ff 02 ff 20   0............... 
        .db     0,0,0,0,0fch,0fch,0fch,0fch,0ch,0ch,0ch,0ch,0cch,0ch,0cch       ; 33cf 00 00 00 00 fc fc fc fc 0c 0c 0c 0c cc 0c cc   ....||||....L.L
        .db     0ch,33h,30h,33h,30h,33h,30h,33h,30h,33h,30h,33h,30h,33h ; 33de 0c 33 30 33 30 33 30 33 30 33 30 33 30 33   .3030303030303
        .db     32h,33h,30h,0cch,0ch,0cch,4ch,0cch,0ch,0cch,0ch,0cch,0ch        ; 33ec 32 33 30 cc 0c cc 4c cc 0c cc 0c cc 0c   230L.LLL.L.L.
        .db     0cch,8ch,0cch,0ch,0cch,0ch,33h,30h,33h,30h,30h,30h,30h,30h      ; 33f9 cc 8c cc 0c cc 0c 33 30 33 30 30 30 30 30   L.L.L.30300000
        .db     3fh,3fh,3fh,3fh,0,0,0,0,0ffh,4,0ffh,40h,0,0,0,0,0ffh,0ffh       ; 3407 3f 3f 3f 3f 00 00 00 00 ff 04 ff 40 00 00 00 00 ff ff   ????.......@......
        .db     0ffh,0ffh,0,0,0,0,0cch,0ch,0cch,4ch,0ch,0ch,0ch,0ch,0fch        ; 3419 ff ff 00 00 00 00 cc 0c cc 4c 0c 0c 0c 0c fc   ......L.LL....|
        .db     0fch,0fch,0fch,0,0,0,0,0,0,0ffh,0ffh,0ffh,0,0ffh,2,0ffh ; 3428 fc fc fc 00 00 00 00 00 00 ff ff ff 00 ff 02 ff   |||.............
        .db     20h,0ffh,0,0ffh,4,0ffh,0,0ffh,0,0ffh,2,0ffh,40h,0ffh,0,0ffh     ; 3438 20 ff 00 ff 04 ff 00 ff 00 ff 02 ff 40 ff 00 ff    ...........@...
        .db     8,0ffh,1,0ffh,43h,0ffh,7,0ffh,4,0ffh,40h,0ffh,2,0ffh,0,0ffh     ; 3448 08 ff 01 ff 43 ff 07 ff 04 ff 40 ff 02 ff 00 ff   ....C.....@.....
        .db     0,0ffh,0ffh,0ffh,0ffh,0,0,0ffh,0,0ffh,40h,0ffh,2,0ffh,0 ; 3458 00 ff ff ff ff 00 00 ff 00 ff 40 ff 02 ff 00   ..........@....
        .db     0ffh,10h,0ffh,80h,0ffh,0c2h,0ffh,0e0h,0feh,6,0feh,46h,0feh      ; 3467 ff 10 ff 80 ff c2 ff e0 fe 06 fe 46 fe   .....B.`...F.
        .db     6,0feh,6,0feh,16h,0feh,86h,0feh,6,0feh,6,7fh,64h,7fh,60h        ; 3474 06 fe 06 fe 16 fe 86 fe 06 fe 06 7f 64 7f 60   ............d.`
        .db     7fh,62h,7fh,60h,7fh,60h,7fh,68h,7fh,62h,7fh,60h,0ffh,2,0ffh     ; 3483 7f 62 7f 60 7f 60 7f 68 7f 62 7f 60 ff 02 ff   .b.`.`.h.b.`...
        .db     40h,0ffh,0,0ffh,0,0ffh,8,0ffh,80h,0ffh,1fh,0f0h,10h,0ffh        ; 3492 40 ff 00 ff 00 ff 08 ff 80 ff 1f f0 10 ff   @..........p..
        .db     2,0ffh,20h,0ffh,0,0ffh,0,0ffh,4,0ffh,0,0ffh,0ffh,0,0,0ffh       ; 34a0 02 ff 20 ff 00 ff 00 ff 04 ff 00 ff ff 00 00 ff   .. .............
        .db     7,0ffh,13h,0ffh,1,0ffh,0,0ffh,40h,0ffh,0,0ffh,0ffh,8,8,0        ; 34b0 07 ff 13 ff 01 ff 00 ff 40 ff 00 ff ff 08 08 00   ........@.......
        .db     0,0ffh,0ffh,0ffh,0ffh,0ffh,0,0ffh,2,0ffh,20h,0ffh,0ffh,0        ; 34c0 00 ff ff ff ff ff 00 ff 02 ff 20 ff ff 00   .......... ...
        .db     0,0ffh,0e0h,0ffh,0c8h,0ffh,80h,0ffh,0,0ffh,2,0ffh,0,0ffh        ; 34ce 00 ff e0 ff c8 ff 80 ff 00 ff 02 ff 00 ff   ..`.H.........
        .db     0ffh,8,8,0ffh,0,0ffh,2,0ffh,40h,0ffh,0,0ffh,2,0ffh,0,0ffh       ; 34dc ff 08 08 ff 00 ff 02 ff 40 ff 00 ff 02 ff 00 ff   ........@.......
        .db     0f8h,0fh,8,0f0h,10h,0f0h,10h,0f0h,10h,0f0h,50h,0f0h,10h ; 34ec f8 0f 08 f0 10 f0 10 f0 10 f0 50 f0 10   x..p.p.p.pPp.
        .db     0f0h,10h,0f0h,10h,0f0h,10h,0fh,8,0fh,0ah,0fh,8,0fh,8,0fh        ; 34f9 f0 10 f0 10 f0 10 0f 08 0f 0a 0f 08 0f 08 0f   p.p.p..........
        .db     8,0fh,8,0fh,9,0fh,8,0,0,0,7fh,0,0,7fh,7fh,7fh,7fh,7ch,7ch       ; 3508 08 0f 08 0f 09 0f 08 00 00 00 7f 00 00 7f 7f 7f 7f 7c 7c   .................||
        .db     78h,79h,78h,7bh,0,0,0,0ffh,0,0,0ffh,0ffh,0ffh,0ffh,3fh,3fh      ; 351b 78 79 78 7b 00 00 00 ff 00 00 ff ff ff ff 3f 3f   xyx{..........??
        .db     1fh,9fh,1fh,0dfh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh        ; 352b 1f 9f 1f df 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f   ..._..........
        .db     0,0,0,7fh,0,0,0,0,0,0,0,0,0aah,0aah,0,0,0,0,0,0,0,0,0,0 ; 3539 00 00 00 7f 00 00 00 00 00 00 00 00 aa aa 00 00 00 00 00 00 00 00 00 00   ............**..........
        .db     0,0,0fh,0fh,1fh,1fh,38h,38h,33h,30h,36h,30h,34h,30h,0,0 ; 3551 00 00 0f 0f 1f 1f 38 38 33 30 36 30 34 30 00 00   ......88306040..
        .db     0,0,0ffh,0ffh,0ffh,0ffh,0,0,0ffh,0,0,0,0,0,0,0,0,0,0f0h ; 3561 00 00 ff ff ff ff 00 00 ff 00 00 00 00 00 00 00 00 00 f0   ..................p
        .db     0f0h,0f8h,0f8h,1ch,1ch,0cch,0ch,6ch,0ch,2ch,0ch,34h,30h ; 3574 f0 f8 f8 1c 1c cc 0c 6c 0c 2c 0c 34 30   pxx..L.l.,.40
        .db     34h,30h,34h,30h,34h,30h,34h,30h,34h,30h,34h,30h,34h,30h ; 3581 34 30 34 30 34 30 34 30 34 30 34 30 34 30   40404040404040
        .db     2ch,0ch,2ch,0ch,2ch,0ch,2ch,0ch,2ch,0ch,2ch,0ch,2ch,0ch ; 358f 2c 0c 2c 0c 2c 0c 2c 0c 2c 0c 2c 0c 2c 0c   ,.,.,.,.,.,.,.
        .db     2ch,0ch,34h,30h,36h,30h,33h,30h,38h,38h,1fh,1fh,0fh,0fh ; 359d 2c 0c 34 30 36 30 33 30 38 38 1f 1f 0f 0f   ,.40603088....
        .db     0,0,0,0,0,7bh,0,79h,0,7ch,0,7fh,0,7fh,0,0,0,7fh,0,0,0,0dfh      ; 35ab 00 00 00 00 00 7b 00 79 00 7c 00 7f 00 7f 00 00 00 7f 00 00 00 df   .....{.y.|..........._
        .db     0,9fh,0,3fh,0,0ffh,0,0ffh,0,0,0,0ffh,0,0,0,0,0,0,0ffh,0 ; 35c1 00 9f 00 3f 00 ff 00 ff 00 00 00 ff 00 00 00 00 00 00 ff 00   ...?................
        .db     0,0,0ffh,0ffh,0ffh,0ffh,0,0,0,0,2ch,0ch,6ch,0ch,0cch,0ch        ; 35d5 00 00 ff ff ff ff 00 00 00 00 2c 0c 6c 0c cc 0c   ..........,.l.L.
        .db     1ch,1ch,0f8h,0f8h,0f0h,0f0h,0,0,0,0,8,8,0ffh,0ffh,0ffh,2        ; 35e5 1c 1c f8 f8 f0 f0 00 00 00 00 08 08 ff ff ff 02   ..xxpp..........
        .db     0ffh,0,0ffh,20h,0ffh,0,0ffh,2,0ffh,0,0,0,0ffh,0ffh,0ffh ; 35f5 ff 00 ff 20 ff 00 ff 02 ff 00 00 00 ff ff ff   ... ...........
        .db     0ffh,0ffh,0,0ffh,2,0ffh,20h,0ffh,0ffh,8,8,0ffh,7,0ffh,13h       ; 3604 ff ff 00 ff 02 ff 20 ff ff 08 08 ff 07 ff 13   ...... ........
        .db     0ffh,1,0ffh,0,0ffh,40h,0ffh,0,0ffh,0ffh,0,0,0ffh,0e0h,0ffh      ; 3613 ff 01 ff 00 ff 40 ff 00 ff ff 00 00 ff e0 ff   .....@.......`.
        .db     0c8h,0ffh,80h,0ffh,0,0ffh,2,0ffh,0,0ffh,0ffh,0,0,8,8,8,8        ; 3622 c8 ff 80 ff 00 ff 02 ff 00 ff ff 00 00 08 08 08 08   H................
        .db     8,8,8,8,8,8,8,8,8,8,8,8,0ffh,0,0ffh,2,0ffh,0,0ffh,20h,0ffh      ; 3633 08 08 08 08 08 08 08 08 08 08 08 08 ff 00 ff 02 ff 00 ff 20 ff   ................... .
        .db     2,0ffh,0,0ffh,0ffh,8,8,0f0h,10h,0ffh,1fh,0f0h,1fh,0f0h,1fh      ; 3648 02 ff 00 ff ff 08 08 f0 10 ff 1f f0 1f f0 1f   .......p...p.p.
        .db     0f0h,1fh,0f0h,1fh,0ffh,5fh,0f0h,10h,0,0,0ffh,0ffh,0,0ffh        ; 3657 f0 1f f0 1f ff 5f f0 10 00 00 ff ff 00 ff   p.p.._p.......
        .db     0,0ffh,0,0ffh,0,0ffh,0ffh,0ffh,0,0,8,8,0ffh,0ffh,0,0ffh ; 3665 00 ff 00 ff 00 ff ff ff 00 00 08 08 ff ff 00 ff   ................
        .db     0,0ffh,0,0ffh,0,0ffh,0ffh,0ffh,8,8,0fh,8,0ffh,0f8h,0fh,0f8h     ; 3675 00 ff 00 ff 00 ff ff ff 08 08 0f 08 ff f8 0f f8   .............x.x
        .db     0fh,0f8h,0fh,0f8h,0fh,0f8h,0ffh,0fah,0fh,8,0ffh,7,0ffh,43h      ; 3685 0f f8 0f f8 0f f8 ff fa 0f 08 ff 07 ff 43   .x.x.x.z.....C
        .db     0ffh,1,0ffh,0,0ffh,0,0ffh,80h,0ffh,1fh,0f0h,10h,0ffh,0e0h       ; 3693 ff 01 ff 00 ff 00 ff 80 ff 1f f0 10 ff e0   ..........p..`
        .db     0ffh,0c2h,0ffh,80h,0ffh,0,0ffh,22h,0ffh,0,0ffh,0f8h,0fh ; 36a1 ff c2 ff 80 ff 00 ff 22 ff 00 ff f8 0f   .B....."...x.
        .db     8,0,0,0,0,0,0,3ch,0,3ch,0,0,0,0,0,0,0,0,0,3ch,0,4eh,0,4eh       ; 36ae 08 00 00 00 00 00 00 3c 00 3c 00 00 00 00 00 00 00 00 00 3c 00 4e 00 4e   .......<.<.........<.N.N
        .db     0,7eh,0,4eh,0,4eh,0,0,0,0,0,7ch,0,66h,0,7ch,0,66h,0,66h ; 36c6 00 7e 00 4e 00 4e 00 00 00 00 00 7c 00 66 00 7c 00 66 00 66   ...N.N.....|.f.|.f.f
        .db     0,7ch,0,0,0,0,0,3ch,0,66h,0,60h,0,60h,0,66h,0,3ch,0,0,0 ; 36da 00 7c 00 00 00 00 00 3c 00 66 00 60 00 60 00 66 00 3c 00 00 00   .|.....<.f.`.`.f.<...
        .db     0ddh,44h,0ffh,44h,0ffh,0ffh,77h,11h,0ffh,11h,0ffh,0ffh,0ddh     ; 36ef dd 44 ff 44 ff ff 77 11 ff 11 ff ff dd   ]D.D..w.....]
        .db     44h,0ffh,44h,0ffh,0ffh,77h,11h,0ffh,11h,0ffh,0ffh,0ddh,44h      ; 36fc 44 ff 44 ff ff 77 11 ff 11 ff ff dd 44   D.D..w.....]D
        .db     0ffh,44h,0ffh,0ffh,77h,11h,0ffh,11h,0ffh,0ffh,0ddh,44h,0ffh     ; 3709 ff 44 ff ff 77 11 ff 11 ff ff dd 44 ff   .D..w.....]D.
        .db     44h,0ffh,0ffh,77h,11h,0ffh,11h,0ffh,0ffh,0,0,7eh,0,18h,0        ; 3716 44 ff ff 77 11 ff 11 ff ff 00 00 7e 00 18 00   D..w...........
        .db     18h,0,18h,0,18h,0,18h,0,0,0,0,0,66h,0,66h,0,3ch,0,18h,0 ; 3725 18 00 18 00 18 00 18 00 00 00 00 00 66 00 66 00 3c 00 18 00   ............f.f.<...
        .db     18h,0,18h,0,0,0,0ffh,0ffh,0f7h,89h,0ddh,0a3h,0ffh,81h,0b7h      ; 3739 18 00 18 00 00 00 ff ff f7 89 dd a3 ff 81 b7   ........w.]#..7
        .db     0c9h,0fdh,83h,0d7h,0a9h,0ffh,81h,0ffh,0ffh,0ffh,81h,0ffh        ; 3748 c9 fd 83 d7 a9 ff 81 ff ff ff 81 ff   I}.W).......
        .db     0bdh,0e7h,0a5h,0e7h,0a5h,0ffh,0bdh,0ffh,81h,0ffh,0ffh,0ffh      ; 3754 bd e7 a5 e7 a5 ff bd ff 81 ff ff ff   =g%g%.=.....
        .db     0ffh,0ffh,81h,0ffh,81h,0ffh,99h,0ffh,99h,0ffh,81h,0ffh,81h      ; 3760 ff ff 81 ff 81 ff 99 ff 99 ff 81 ff 81   .............
        .db     0ffh,0ffh,0ffh,0ffh,81h,81h,0bdh,0bdh,0bdh,0bdh,0bdh,0bdh       ; 376d ff ff ff ff 81 81 bd bd bd bd bd bd   ......======
        .db     0bdh,0bdh,81h,81h,0ffh,0ffh,0ffh,0ffh,81h,0ffh,81h,0ffh ; 3779 bd bd 81 81 ff ff ff ff 81 ff 81 ff   ==..........
        .db     81h,0ffh,81h,0ffh,81h,0ffh,81h,0ffh,0ffh,0ffh,0ffh,0ffh ; 3785 81 ff 81 ff 81 ff 81 ff ff ff ff ff   ............
        .db     0ffh,81h,0c3h,81h,0dfh,85h,0dfh,85h,0ffh,0bdh,0ffh,81h,0ffh     ; 3791 ff 81 c3 81 df 85 df 85 ff bd ff 81 ff   ..C._._..=...
        .db     0ffh,0ffh,0ffh,81h,0ffh,0bdh,0ffh,0a5h,0e7h,0a5h,0e7h,0bdh      ; 379e ff ff ff 81 ff bd ff a5 e7 a5 e7 bd   .....=.%g%g=
        .db     0ffh,81h,0ffh,0ffh,0ffh,0ffh,0ffh,81h,81h,0bdh,83h,0bdh ; 37aa ff 81 ff ff ff ff ff 81 81 bd 83 bd   .........=.=
        .db     83h,0bdh,83h,0bdh,83h,81h,0ffh,0ffh,0ffh,0edh,93h,0bfh,0c1h     ; 37b6 83 bd 83 bd 83 81 ff ff ff ed 93 bf c1   .=.=.....m.?A
        .db     0f5h,8bh,0dfh,0a1h,0fdh,83h,0afh,0d1h,0fbh,85h,0dfh,0a1h        ; 37c3 f5 8b df a1 fd 83 af d1 fb 85 df a1   u._!}./Q{._!
        .db     0fdh,83h,0efh,91h,0bbh,0c5h,0efh,91h,0bdh,0c3h,0f7h,89h ; 37cf fd 83 ef 91 bb c5 ef 91 bd c3 f7 89   }.o.;Eo.=Cw.
        .db     0dfh,0a1h,0ffh,0ffh,0ffh,0ffh,0dbh,0a4h,0ffh,80h,0b5h,0cah      ; 37db df a1 ff ff ff ff db a4 ff 80 b5 ca   _!....[$..5J
        .db     0ffh,80h,0ddh,0a2h,0f7h,88h,0ffh,0ffh,0ffh,0ffh,57h,0a8h        ; 37e7 ff 80 dd a2 f7 88 ff ff ff ff 57 a8   ..]"w.....W(
        .db     0fdh,2,0dfh,20h,7bh,84h,0eeh,11h,0bbh,44h,0ffh,0ffh,0ffh        ; 37f3 fd 02 df 20 7b 84 ee 11 bb 44 ff ff ff   }._ {.n.;D...
        .db     0,0ffh,0,0ffh,0,0ffh,0,0ffh,0,0ffh,0,0ffh,0,0ffh,0,0,0ffh       ; 3800 00 ff 00 ff 00 ff 00 ff 00 ff 00 ff 00 ff 00 00 ff   .................
        .db     0,0ffh,0,0ffh,0,0ffh,0,0ffh,0,0ffh,0,0ffh,0,0ffh,0ffh,0ffh      ; 3811 00 ff 00 ff 00 ff 00 ff 00 ff 00 ff 00 ff ff ff   ................
        .db     0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh     ; 3821 ff ff ff ff ff ff ff ff ff ff ff ff   ............
        .db     0ffh,0ffh,0ffh,0ffh,77h,89h,0dfh,21h,0fbh,5,0afh,51h,0fdh       ; 382d ff ff ff ff 77 89 df 21 fb 05 af 51 fd   ....w._!{./Q}
        .db     3,0d7h,29h,0ffh,0ffh,0,0,3ch,0,66h,0,66h,0,66h,0,66h,0,3ch      ; 383a 03 d7 29 ff ff 00 00 3c 00 66 00 66 00 66 00 66 00 3c   .W)....<.f.f.f.f.<
        .db     0,0,0,0,0,18h,0,38h,0,18h,0,18h,0,18h,0,3ch,0,0,0,0,0,3ch       ; 384c 00 00 00 00 00 18 00 38 00 18 00 18 00 18 00 3c 00 00 00 00 00 3c   .......8.......<.....<
        .db     0,4eh,0,0eh,0,3ch,0,70h,0,7eh,0,0,0,0,0,7ch,0,0eh,0,3ch ; 3862 00 4e 00 0e 00 3c 00 70 00 7e 00 00 00 00 00 7c 00 0e 00 3c   .N...<.p.......|...<
        .db     0,0eh,0,0eh,0,7ch,0,0,0,0,0,3ch,0,6ch,0,4ch,0,4eh,0,7eh ; 3876 00 0e 00 0e 00 7c 00 00 00 00 00 3c 00 6c 00 4c 00 4e 00 7e   .....|.....<.l.L.N..
        .db     0,0ch,0,0,0,0,0,7ch,0,60h,0,7ch,0,0eh,0,4eh,0,3ch,0,0,0 ; 388a 00 0c 00 00 00 00 00 7c 00 60 00 7c 00 0e 00 4e 00 3c 00 00 00   .......|.`.|...N.<...
        .db     0,0,3ch,0,60h,0,7ch,0,66h,0,66h,0,3ch,0,0,0,0,0,7eh,0,6 ; 389f 00 00 3c 00 60 00 7c 00 66 00 66 00 3c 00 00 00 00 00 7e 00 06   ..<.`.|.f.f.<........
        .db     0,0ch,0,18h,0,38h,0,38h,0,0,0,0,0,3ch,0,4eh,0,3ch,0,4eh ; 38b4 00 0c 00 18 00 38 00 38 00 00 00 00 00 3c 00 4e 00 3c 00 4e   .....8.8.....<.N.<.N
        .db     0,4eh,0,3ch,0,0,0,0,0,3ch,0,4eh,0,4eh,0,3eh,0,0eh,0,3ch ; 38c8 00 4e 00 3c 00 00 00 00 00 3c 00 4e 00 4e 00 3e 00 0e 00 3c   .N.<.....<.N.N.>...<
        .db     0,0,0,0,0,7ch,0,66h,0,66h,0,7ch,0,60h,0,60h,0,0,0,0,0,7eh       ; 38dc 00 00 00 00 00 7c 00 66 00 66 00 7c 00 60 00 60 00 00 00 00 00 7e   .....|.f.f.|.`.`......
        .db     0,60h,0,7ch,0,60h,0,60h,0,7eh,0,0,0,0,0,7eh,0,60h,0,60h ; 38f2 00 60 00 7c 00 60 00 60 00 7e 00 00 00 00 00 7e 00 60 00 60   .`.|.`.`.........`.`
        .db     0,7ch,0,60h,0,60h,0,0,0,0,0,3ch,0,66h,0,66h,0,66h,0,66h ; 3906 00 7c 00 60 00 60 00 00 00 00 00 3c 00 66 00 66 00 66 00 66   .|.`.`.....<.f.f.f.f
        .db     0,3ch,0,0,0,0,0,3ch,0,66h,0,60h,0,6eh,0,66h,0,3eh,0,0,0 ; 391a 00 3c 00 00 00 00 00 3c 00 66 00 60 00 6e 00 66 00 3e 00 00 00   .<.....<.f.`.n.f.>...
        .db     0,0,46h,0,6eh,0,7eh,0,56h,0,46h,0,46h,0,0,0,0,0,46h,0,46h       ; 392f 00 00 46 00 6e 00 7e 00 56 00 46 00 46 00 00 00 00 00 46 00 46   ..F.n...V.F.F.....F.F
        .db     0,46h,0,46h,0,4eh,0,3ch,0,0,0,0,0,3ch,0,60h,0,3ch,0,0eh ; 3944 00 46 00 46 00 4e 00 3c 00 00 00 00 00 3c 00 60 00 3c 00 0e   .F.F.N.<.....<.`.<..
        .db     0,4eh,0,3ch,0,0,0,0,0,3ch,0,18h,0,18h,0,18h,0,18h,0,3ch ; 3958 00 4e 00 3c 00 00 00 00 00 3c 00 18 00 18 00 18 00 18 00 3c   .N.<.....<.........<
        .db     0,0,0,0,0,60h,0,60h,0,60h,0,60h,0,60h,0,7eh,0,0,0,0,0,46h       ; 396c 00 00 00 00 00 60 00 60 00 60 00 60 00 60 00 7e 00 00 00 00 00 46   .....`.`.`.`.`.......F
        .db     0,46h,0,46h,0,46h,0,2ch,0,18h,0,0,0,0,0,7ch,0,66h,0,66h ; 3982 00 46 00 46 00 46 00 2c 00 18 00 00 00 00 00 7c 00 66 00 66   .F.F.F.,.......|.f.f
        .db     0,7ch,0,68h,0,66h,0,0,0,0,0,46h,0,66h,0,76h,0,5eh,0,4eh ; 3996 00 7c 00 68 00 66 00 00 00 00 00 46 00 66 00 76 00 5e 00 4e   .|.h.f.....F.f.v.^.N
        .db     0,46h,0,0,0,0,0,7ch,0,4eh,0,4eh,0,4eh,0,4eh,0,7ch,0,0,0 ; 39aa 00 46 00 00 00 00 00 7c 00 4e 00 4e 00 4e 00 4e 00 7c 00 00 00   .F.....|.N.N.N.N.|...
        .db     0ffh,0ffh,0ffh,0,0ffh,0,0ffh,0,0ffh,10h,0ffh,80h,0ffh,2 ; 39bf ff ff ff 00 ff 00 ff 00 ff 10 ff 80 ff 02   ..............
        .db     0ffh,0,0,0,0ffh,0ffh,0ffh,0ffh,0ffh,0,0ffh,2,0ffh,20h,0ffh      ; 39cd ff 00 00 00 ff ff ff ff ff 00 ff 02 ff 20 ff   ............. .
        .db     0ffh,80h,80h,80h,80h,80h,80h,80h,80h,80h,80h,80h,80h,80h        ; 39dc ff 80 80 80 80 80 80 80 80 80 80 80 80 80   ..............
        .db     80h,80h,80h,80h,80h,80h,80h,0ffh,0ffh,0,0ffh,0,0ffh,0,0ffh      ; 39ea 80 80 80 80 80 80 80 ff ff 00 ff 00 ff 00 ff   ...............
        .db     0,0ffh,0ffh,0ffh,80h,80h,80h,80h,0ffh,0ffh,0ffh,0,0ffh,2        ; 39f9 00 ff ff ff 80 80 80 80 ff ff ff 00 ff 02   ..............
        .db     0ffh,20h,0ffh,0,0ffh,0,0ffh,0,0ffh,0,0,0,0,0,0,0,0,0,0,0        ; 3a07 ff 20 ff 00 ff 00 ff 00 ff 00 00 00 00 00 00 00 00 00 00 00   . ..................
        .db     0,0,0,0,7,7,18h,1fh,21h,3eh,47h,7fh,5fh,7fh,39h,30h,7bh ; 3a1b 00 00 00 00 07 07 18 1f 21 3e 47 7f 5f 7f 39 30 7b   ........!>G._.90{
        .db     62h,0fbh,0b2h,0ffh,0a0h,0ffh,0c2h,7fh,54h,7fh,5ch,3fh,2eh       ; 3a2c 62 fb b2 ff a0 ff c2 7f 54 7f 5c 3f 2e   b{2. .B.T.\?.
        .db     7fh,63h,0bfh,0f8h,37h,0ffh,1,1,1,1,1,1,1,1,1,1,1,1,1,1,83h      ; 3a39 7f 63 bf f8 37 ff 01 01 01 01 01 01 01 01 01 01 01 01 01 01 83   .c?x7................
        .db     83h,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0ffh,0ffh,0ffh,0ffh,1,1 ; 3a4e 83 01 01 01 01 01 01 01 01 01 01 01 01 01 01 ff ff ff ff 01 01   .....................
        .db     1,1,1,1,1,1,1,1,1,1,83h,83h,0ffh,0ffh,0d9h,87h,0d9h,87h ; 3a63 01 01 01 01 01 01 01 01 01 01 83 83 ff ff d9 87 d9 87   ..............Y.Y.
        .db     0d9h,87h,0d9h,87h,0d9h,87h,0d9h,87h,0d9h,87h,0d9h,87h,0d9h      ; 3a75 d9 87 d9 87 d9 87 d9 87 d9 87 d9 87 d9   Y.Y.Y.Y.Y.Y.Y
        .db     87h,0d9h,87h,0d9h,87h,0d9h,87h,0d9h,87h,0d9h,87h,0ffh,0ffh      ; 3a82 87 d9 87 d9 87 d9 87 d9 87 d9 87 ff ff   .Y.Y.Y.Y.Y...
        .db     0d9h,87h,0d9h,87h,0d9h,87h,0d9h,87h,0d9h,87h,0d9h,87h,0d9h      ; 3a8f d9 87 d9 87 d9 87 d9 87 d9 87 d9 87 d9   Y.Y.Y.Y.Y.Y.Y
        .db     87h,0d9h,87h,0,38h,0,38h,0,38h,0,38h,0,38h,0,38h,0,38h,0        ; 3a9c 87 d9 87 00 38 00 38 00 38 00 38 00 38 00 38 00 38 00   .Y..8.8.8.8.8.8.8.
        .db     38h,7ch,0,7ch,0,7ch,0,7ch,0,7ch,0,7ch,0,7fh,0,0ffh,0,0,0        ; 3aae 38 7c 00 7c 00 7c 00 7c 00 7c 00 7c 00 7f 00 ff 00 00 00   8|.|.|.|.|.|.......
        .db     0,0,8,0,8,0,8,0,8,0,1ch,0,1ch,0,0,0,0,0eh,1,1dh,1eh,6,2ah       ; 3ac1 00 00 08 00 08 00 08 00 08 00 1c 00 1c 00 00 00 00 0e 01 1d 1e 06 2a   ......................*
        .db     2ah,27h,27h,10h,13h,0ch,0dh,0,0,0c0h,0c0h,20h,20h,10h,0d0h      ; 3ad8 2a 27 27 10 13 0c 0d 00 00 c0 c0 20 20 10 d0   *''......@@  .P
        .db     0d0h,10h,0f0h,30h,0c8h,0e8h,8,0e8h,4,7,3,3,0ch,0ch,10h,10h      ; 3ae7 d0 10 f0 30 c8 e8 08 e8 04 07 03 03 0c 0c 10 10   P.p0Hh.h........
        .db     35h,20h,2ah,20h,3fh,3fh,0ch,0ch,28h,0e8h,0d8h,0c0h,40h,40h      ; 3af7 35 20 2a 20 3f 3f 0c 0c 28 e8 d8 c0 40 40   5 * ??..(hX@@@
        .db     20h,20h,50h,10h,0b0h,10h,0f0h,0f0h,0c0h,0c0h,0,0e0h,1,71h       ; 3b05 20 20 50 10 b0 10 f0 f0 c0 c0 00 e0 01 71     P.0.pp@@.`.q
        .db     32h,42h,34h,35h,55h,54h,4fh,4eh,21h,27h,18h,1bh,0,0,80h ; 3b13 32 42 34 35 55 54 4f 4e 21 27 18 1b 00 00 80   2B45UTON!'.....
        .db     80h,40h,40h,20h,0a0h,0a0h,20h,0e0h,60h,90h,0f0h,8,0c8h,0b8h     ; 3b22 80 40 40 20 a0 a0 20 e0 60 90 f0 08 c8 b8   .@@    ``.p.H8
        .db     0b8h,84h,84h,84h,84h,0fch,0fch,92h,92h,92h,92h,6ch,6ch,0eeh     ; 3b30 b8 84 84 84 84 fc fc 92 92 92 92 6c 6c ee   8....||....lln
        .db     0eeh,7,7,1fh,18h,3eh,20h,7fh,4fh,7fh,5fh,70h,70h,0a2h,0a2h      ; 3b3e ee 07 07 1f 18 3e 20 7f 4f 7f 5f 70 70 a2 a2   n....> .O._pp""
        .db     0b0h,0b0h,0b4h,0b4h,64h,64h,3ch,3ch,2eh,2eh,27h,27h,10h ; 3b4d b0 b0 b4 b4 64 64 3c 3c 2e 2e 27 27 10   0044dd<<..''.
        .db     10h,6ch,7ch,0cfh,0b3h,3,3,3,3,3,2,7,6,9,9,16h,17h,12h,11h       ; 3b5a 10 6c 7c cf b3 03 03 03 03 03 02 07 06 09 09 16 17 12 11   .l|O3..............
        .db     0eh,0fh,8,9,8,8,0fh,0fh,8,8,9,9,0ah,0ah,6,6,0eh,0eh,3,3 ; 3b6d 0e 0f 08 09 08 08 0f 0f 08 08 09 09 0a 0a 06 06 0e 0e 03 03   ....................
        .db     3,3,3,2,1fh,1eh,21h,21h,4ah,55h,4ah,75h,0ah,35h,0ah,15h ; 3b81 03 03 03 02 1f 1e 21 21 4a 55 4a 75 0a 35 0a 15   ......!!JUJu.5..
        .db     8,8,0fh,0fh,8,8,9,9,0ah,0ah,6,6,0eh,0eh,0,0,66h,0,6ch,0 ; 3b91 08 08 0f 0f 08 08 09 09 0a 0a 06 06 0e 0e 00 00 66 00 6c 00   ................f.l.
        .db     78h,0,78h,0,6ch,0,66h,0,0,0,0,0,46h,0,2ch,0,18h,0,38h,0 ; 3ba5 78 00 78 00 6c 00 66 00 00 00 00 00 46 00 2c 00 18 00 38 00   x.x.l.f.....F.,...8.
        .db     64h,0,42h,0,0,0,0fdh,0fdh,0fdh,0fdh,0fdh,0fdh,0fdh,0fdh ; 3bb9 64 00 42 00 00 00 fd fd fd fd fd fd fd fd   d.B...}}}}}}}}
        .db     0fdh,0fdh,0fdh,0fdh,0fdh,0fdh,0fdh,0fdh,0f8h,0,0e0h,0,0c0h      ; 3bc7 fd fd fd fd fd fd fd fd f8 00 e0 00 c0   }}}}}}}}x.`.@
        .db     0,80h,0,80h,0,0,0,0,0,0,0,7fh,0,1fh,0,0fh,0,7,0,7,0,3,0 ; 3bd4 00 80 00 80 00 00 00 00 00 00 00 7f 00 1f 00 0f 00 07 00 07 00 03 00   .......................
        .db     3,0,3,0,0,0,80h,0,80h,0,0c0h,0,0e0h,0,0f8h,0,0ffh,0,0ffh        ; 3beb 03 00 03 00 00 00 80 00 80 00 c0 00 e0 00 f8 00 ff 00 ff   ..........@.`.x....
        .db     0,3,0,7,0,7,0,0fh,0,1fh,0,7fh,0,0ffh,0,0ffh,0,0ffh,0ffh ; 3bfe 00 03 00 07 00 07 00 0f 00 1f 00 7f 00 ff 00 ff 00 ff ff   ...................
        .db     0ffh,0ffh,0,0ffh,0ffh,0ffh,0,0ffh,0ffh,0,0,0ffh,0ffh,0,0ffh     ; 3c11 ff ff 00 ff ff ff 00 ff ff 00 00 ff ff 00 ff   ...............
        .db     0,0ffh,0,0ffh,1,0feh,2,0feh,2,0fch,4,0fch,4,0fch,4,0ffh ; 3c20 00 ff 00 ff 01 fe 02 fe 02 fc 04 fc 04 fc 04 ff   .........|.|.|..
        .db     2,0ffh,1,0ffh,1,1,1,0ffh,1,1,1,0ffh,1,1,1,2,2,2,2,3,3,4 ; 3c30 02 ff 01 ff 01 01 01 ff 01 01 01 ff 01 01 01 02 02 02 02 03 03 04   ......................
        .db     5,8,9,11h,12h,21h,26h,43h,4ch,0,0,1,1,2,2,4,4,8,9,10h,13h       ; 3c46 05 08 09 11 12 21 26 43 4c 00 00 01 01 02 02 04 04 08 09 10 13   .....!&CL............
        .db     20h,27h,20h,2fh,87h,98h,6,39h,0eh,71h,1eh,0e1h,3ch,0c3h ; 3c5b 20 27 20 2f 87 98 06 39 0e 71 1e e1 3c c3    ' /...9.q.a<C
        .db     3ch,0c3h,78h,87h,78h,87h,40h,4fh,40h,4fh,80h,9fh,80h,9fh        ; 3c69 3c c3 78 87 78 87 40 4f 40 4f 80 9f 80 9f   <Cx.x.@O@O....
        .db     80h,9fh,80h,9fh,80h,9fh,80h,9fh,0f8h,7,0f0h,0fh,0f0h,0fh        ; 3c77 80 9f 80 9f 80 9f 80 9f f8 07 f0 0f f0 0f   ........x.p.p.
        .db     0f0h,0fh,0f0h,0fh,0f0h,0fh,0f0h,0fh,0f8h,7,40h,5fh,40h,4fh      ; 3c85 f0 0f f0 0f f0 0f f0 0f f8 07 40 5f 40 4f   p.p.p.p.x.@_@O
        .db     20h,2fh,20h,27h,10h,11h,0fh,0fh,4,4,7,7,78h,87h,7ch,83h ; 3c93 20 2f 20 27 10 11 0f 0f 04 04 07 07 78 87 7c 83    / '........x.|.
        .db     3ch,0c3h,1eh,0e1h,0fh,0f0h,0ffh,0ffh,0ffh,0,0ffh,0ffh,0ffh      ; 3ca3 3c c3 1e e1 0f f0 ff ff ff 00 ff ff ff   <C.a.p.......
        .db     0,0ffh,0,0ffh,0,0,0,0ffh,0,0,0,0ffh,0,0,0,2,0,2,0,2,0,2 ; 3cb0 00 ff 00 ff 00 00 00 ff 00 00 00 ff 00 00 00 02 00 02 00 02 00 02   ......................
        .db     0,2,0,2,0,2,0,2,0,10h,0,38h,0,7ch,0,0feh,0,0feh,0,0feh,0        ; 3cc6 00 02 00 02 00 02 00 02 00 10 00 38 00 7c 00 fe 00 fe 00 fe 00   ...........8.|.......
        .db     7ch,0,0,0,2,3,1,1,2,2,4,4,0dh,8,0ah,8,0fh,0fh,3,3,28h,0e8h      ; 3cdb 7c 00 00 00 02 03 01 01 02 02 04 04 0d 08 0a 08 0f 0f 03 03 28 e8   |...................(h
        .db     0f0h,0d0h,30h,30h,8,8,54h,4,0ach,4,0fch,0fch,30h,30h,0,0        ; 3cf1 f0 d0 30 30 08 08 54 04 ac 04 fc fc 30 30 00 00   pP00..T.,.||00..
        .db     3,3,3,3,3,2,7,6,9,9,8,8,0bh,0bh,0,0,0c0h,0c0h,0c4h,0c4h ; 3d01 03 03 03 03 03 02 07 06 09 09 08 08 0b 0b 00 00 c0 c0 c4 c4   ................@@DD
        .db     0e8h,68h,90h,0f0h,0a8h,0f8h,48h,78h,0f8h,0b8h,0,0,7,7,7 ; 3d15 e8 68 90 f0 a8 f8 48 78 f8 b8 00 00 07 07 07   hh.p(xHxx8.....
        .db     7,7,4,7,4,0bh,0bh,10h,10h,17h,17h,0,0,80h,80h,80h,80h,0e0h      ; 3d24 07 07 04 07 04 0b 0b 10 10 17 17 00 00 80 80 80 80 e0   .................`
        .db     0e0h,90h,0f0h,0a8h,0f8h,48h,78h,0b8h,0b8h,8,8,0fh,0fh,8 ; 3d36 e0 90 f0 a8 f8 48 78 b8 b8 08 08 0f 0f 08   `.p(xHx88.....
        .db     8,0fh,0fh,9,9,9,9,6,6,0eh,0eh,0e4h,0e4h,22h,22h,20h,20h ; 3d44 08 0f 0f 09 09 09 09 06 06 0e 0e e4 e4 22 22 20 20   ...........dd""  
        .db     0e0h,0e0h,20h,20h,20h,20h,0c0h,0c0h,0e0h,0e0h,18h,18h,98h       ; 3d55 e0 e0 20 20 20 20 c0 c0 e0 e0 18 18 98   ``    @@``...
        .db     98h,98h,98h,0f8h,0f8h,9ch,98h,3ch,3ch,3ch,3ch,7eh,7eh,7fh       ; 3d62 98 98 98 f8 f8 9c 98 3c 3c 3c 3c 7e 7e 7f   ...xx..<<<<...
        .db     0,0feh,0feh,7eh,7eh,0feh,0dah,7eh,5ah,7eh,7eh,0fch,0fch ; 3d70 00 fe fe 7e 7e fe da 7e 5a 7e 7e fc fc   ......Z.Z..||
        .db     0f8h,0f8h,0feh,0eh,0feh,0feh,7eh,7eh,0feh,0dah,7eh,5ah,7eh      ; 3d7d f8 f8 fe 0e fe fe 7e 7e fe da 7e 5a 7e   xx.......Z.Z.
        .db     7eh,0fch,0fch,0f8h,0f8h,80h,80h,83h,83h,83h,83h,0c3h,2,0efh     ; 3d8a 7e fc fc f8 f8 80 80 83 83 83 83 c3 02 ef   .||xx......C.o
        .db     2eh,97h,97h,47h,44h,24h,24h,0,0,0c0h,0c0h,0c0h,0c0h,0c0h        ; 3d98 2e 97 97 47 44 24 24 00 00 c0 c0 c0 c0 c0   ...GD$$..@@@@@
        .db     40h,0e0h,60h,0f8h,0f8h,0e4h,24h,34h,34h,17h,14h,17h,14h ; 3da6 40 e0 60 f8 f8 e4 24 34 34 17 14 17 14   @``xxd$44....
        .db     17h,14h,1ch,1fh,17h,17h,0fh,0fh,1eh,1eh,0,0,0f4h,24h,0f8h       ; 3db3 17 14 1c 1f 17 17 0f 0f 1e 1e 00 00 f4 24 f8   ............t$x
        .db     28h,0e8h,28h,38h,0f8h,0e8h,0e8h,90h,90h,70h,70h,78h,78h ; 3dc2 28 e8 28 38 f8 e8 e8 90 90 70 70 78 78   (h(8xhh..ppxx
        .db     3,3,3,3,3,2,0fh,0eh,11h,11h,37h,37h,71h,52h,7dh,4eh,0c0h        ; 3dcf 03 03 03 03 03 02 0f 0e 11 11 37 37 71 52 7d 4e c0   ..........77qR}N@
        .db     0c0h,0c0h,0c0h,0c0h,40h,0c0h,40h,0a0h,0a0h,10h,10h,0ffh ; 3de0 c0 c0 c0 c0 40 c0 40 a0 a0 10 10 ff   @@@@@@@  ...
        .db     0ffh,0cfh,33h,7fh,40h,3fh,3fh,8,8,0fh,0fh,9,9,9,9,6,6,0eh       ; 3dec ff cf 33 7f 40 3f 3f 08 08 0f 0f 09 09 09 09 06 06 0e   .O3.@??...........
        .db     0eh,0fch,0fch,20h,20h,20h,20h,0e0h,0e0h,20h,20h,20h,20h ; 3dfe 0e fc fc 20 20 20 20 e0 e0 20 20 20 20   .||    ``    
        .db     0c0h,0c0h,0e0h,0e0h,3,3,3,3,3,2,7,6,9,9,33h,33h,77h,54h ; 3e0b c0 c0 e0 e0 03 03 03 03 03 02 07 06 09 09 33 33 77 54   @@``..........33wT
        .db     73h,4ch,18h,18h,0d8h,0d8h,0d8h,0d8h,0f8h,78h,0dch,58h,0bch      ; 3e1d 73 4c 18 18 d8 d8 d8 d8 f8 78 dc 58 bc   sL..XXXXxx\X<
        .db     0bch,3ch,3ch,7eh,7eh,9,0eh,7,7,8,0fh,8,0fh,9,0fh,0ah,0eh        ; 3e2a bc 3c 3c 7e 7e 09 0e 07 07 08 0f 08 0f 09 0f 0a 0e   <<<..............
        .db     6,6,0eh,0eh,0,0,3,3,3,3,3,2,0ffh,7eh,0c9h,3fh,78h,7fh,9 ; 3e3b 06 06 0e 0e 00 00 03 03 03 03 03 02 ff 7e c9 3f 78 7f 09   ..............I?x..
        .db     0fh,4,4,7,7,0b8h,0bfh,0c0h,0ffh,0ffh,0ffh,0,0,0,0,0,0,0 ; 3e4e 0f 04 04 07 07 b8 bf c0 ff ff ff 00 00 00 00 00 00 00   .....8?@..........
        .db     0,78h,78h,78h,78h,7bh,48h,60h,5fh,0b6h,0b0h,84h,84h,0b8h        ; 3e60 00 78 78 78 78 7b 48 60 5f b6 b0 84 84 b8   .xxxx{H`_60..8
        .db     0b8h,84h,84h,84h,84h,84h,84h,0fah,0fah,92h,92h,9eh,9eh,67h      ; 3e6e b8 84 84 84 84 84 84 fa fa 92 92 9e 9e 67   8......zz....g
        .db     67h,0e0h,0e0h,0,0,0,0,78h,78h,78h,78h,78h,48h,40h,7eh,0b4h      ; 3e7c 67 e0 e0 00 00 00 00 78 78 78 78 78 48 40 7e b4   g``....xxxxxH@.4
        .db     0b0h,84h,84h    ; 3e8c b0 84 84   0..
; Type-A Falling Blocks Screen (20x18 chars)
l3e8f:  .db     2ah,7bh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,7bh     ; 3e8f 2a 7b 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 7b   *{//////////{
        .db     30h,31h,31h,31h,31h,31h,32h,2ah,7ch,2fh,2fh,2fh,2fh,2fh ; 3e9c 30 31 31 31 31 31 32 2a 7c 2f 2f 2f 2f 2f   0111112*|/////
        .db     2fh,2fh,2fh,2fh,2fh,7ch,44h,1ch,0ch,18h,1bh,0eh,45h,2ah ; 3eaa 2f 2f 2f 2f 2f 7c 44 1c 0c 18 1b 0e 45 2a   /////|D.....E*
        .db     7dh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,7dh,67h,46h ; 3eb8 7d 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 7d 67 46   }//////////}gF
        .db     46h,46h,46h,46h,68h,2ah,7bh,2fh,2fh,2fh,2fh,2fh,2fh,2fh ; 3ec6 46 46 46 46 68 2a 7b 2f 2f 2f 2f 2f 2f 2f   FFFFh*{///////
        .db     2fh,2fh,2fh,7bh,2fh,2fh,2fh,2fh,2fh,0,2fh,2ah,7ch,2fh,2fh       ; 3ed4 2f 2f 2f 7b 2f 2f 2f 2f 2f 00 2f 2a 7c 2f 2f   ///{/////./*|//
        .db     2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,7ch,43h,34h,34h,34h,34h ; 3ee3 2f 2f 2f 2f 2f 2f 2f 2f 7c 43 34 34 34 34   ////////|C4444
        .db     34h,34h,2ah,7dh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh ; 3ef1 34 34 2a 7d 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f   44*}//////////
        .db     7dh,30h,31h,31h,31h,31h,31h,32h,2ah,7bh,2fh,2fh,2fh,2fh ; 3eff 7d 30 31 31 31 31 31 32 2a 7b 2f 2f 2f 2f   }0111112*{////
        .db     2fh,2fh,2fh,2fh,2fh,2fh,7bh,36h,15h,0eh,1fh,0eh,15h,37h ; 3f0d 2f 2f 2f 2f 2f 2f 7b 36 15 0e 1f 0e 15 37   //////{6.....7
        .db     2ah,7ch,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,7ch,36h ; 3f1b 2a 7c 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 7c 36   *|//////////|6
        .db     2fh,2fh,2fh,2fh,2fh,37h,2ah,7dh,2fh,2fh,2fh,2fh,2fh,2fh ; 3f29 2f 2f 2f 2f 2f 37 2a 7d 2f 2f 2f 2f 2f 2f   /////7*}//////
        .db     2fh,2fh,2fh,2fh,7dh,40h,42h,42h,42h,42h,42h,41h,2ah,7bh ; 3f37 2f 2f 2f 2f 7d 40 42 42 42 42 42 41 2a 7b   ////}@BBBBBA*{
        .db     2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,7bh,36h,15h,12h ; 3f45 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 7b 36 15 12   //////////{6..
        .db     17h,0eh,1ch,37h,2ah,7ch,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh ; 3f53 17 0e 1c 37 2a 7c 2f 2f 2f 2f 2f 2f 2f 2f   ...7*|////////
        .db     2fh,2fh,7ch,36h,2fh,2fh,2fh,2fh,2fh,37h,2ah,7dh,2fh,2fh ; 3f61 2f 2f 7c 36 2f 2f 2f 2f 2f 37 2a 7d 2f 2f   //|6/////7*}//
        .db     2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,7dh,33h,34h,34h,34h,34h ; 3f6f 2f 2f 2f 2f 2f 2f 2f 2f 7d 33 34 34 34 34   ////////}34444
        .db     34h,35h,2ah,7bh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh ; 3f7d 34 35 2a 7b 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f   45*{//////////
        .db     7bh,2bh,38h,39h,39h,39h,39h,3ah,2ah,7ch,2fh,2fh,2fh,2fh ; 3f8b 7b 2b 38 39 39 39 39 3a 2a 7c 2f 2f 2f 2f   {+89999:*|////
        .db     2fh,2fh,2fh,2fh,2fh,2fh,7ch,2bh,3bh,2fh,2fh,2fh,2fh,3ch ; 3f99 2f 2f 2f 2f 2f 2f 7c 2b 3b 2f 2f 2f 2f 3c   //////|+;////<
        .db     2ah,7dh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,7dh,2bh ; 3fa7 2a 7d 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 7d 2b   *}//////////}+
        .db     3bh,2fh,2fh,2fh,2fh,3ch,2ah,7bh,2fh,2fh,2fh,2fh,2fh,2fh ; 3fb5 3b 2f 2f 2f 2f 3c 2a 7b 2f 2f 2f 2f 2f 2f   ;////<*{//////
        .db     2fh,2fh,2fh,2fh,7bh,2bh,3bh,2fh,2fh,2fh,2fh,3ch,2ah,7ch ; 3fc3 2f 2f 2f 2f 7b 2b 3b 2f 2f 2f 2f 3c 2a 7c   ////{+;////<*|
        .db     2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,7ch,2bh,3bh,2fh ; 3fd1 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 7c 2b 3b 2f   //////////|+;/
        .db     2fh,2fh,2fh,3ch,2ah,7dh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh ; 3fdf 2f 2f 2f 3c 2a 7d 2f 2f 2f 2f 2f 2f 2f 2f   ///<*}////////
        .db     2fh,2fh,7dh,2bh,3dh,3eh,3eh,3eh,3eh,3fh ; 3fed 2f 2f 7d 2b 3d 3e 3e 3e 3e 3f   //}+=>>>>?
; Type-B Falling Blocks Screen (20x18 chars)
l3ff7:  .db     2ah,7bh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,7bh     ; 3ff7 2a 7b 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 7b   *{//////////{
        .db     30h,31h,31h,31h,31h,31h,32h,2ah,7ch,2fh,2fh,2fh,2fh,2fh ; 4004 30 31 31 31 31 31 32 2a 7c 2f 2f 2f 2f 2f   0111112*|/////
        .db     2fh,2fh,2fh,2fh,2fh,7ch,36h,15h,0eh,1fh,0eh,15h,37h,2ah ; 4012 2f 2f 2f 2f 2f 7c 36 15 0e 1f 0e 15 37 2a   /////|6.....7*
        .db     7dh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,7dh,36h,2fh ; 4020 7d 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 7d 36 2f   }//////////}6/
        .db     2fh,2fh,2fh,2fh,37h,2ah,7bh,2fh,2fh,2fh,2fh,2fh,2fh,2fh ; 402e 2f 2f 2f 2f 37 2a 7b 2f 2f 2f 2f 2f 2f 2f   ////7*{///////
        .db     2fh,2fh,2fh,7bh,40h,42h,42h,42h,42h,42h,41h,2ah,7ch,2fh ; 403c 2f 2f 2f 7b 40 42 42 42 42 42 41 2a 7c 2f   ///{@BBBBBA*|/
        .db     2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,7ch,36h,11h,12h,10h ; 404a 2f 2f 2f 2f 2f 2f 2f 2f 2f 7c 36 11 12 10   /////////|6...
        .db     11h,2fh,37h,2ah,7dh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh ; 4058 11 2f 37 2a 7d 2f 2f 2f 2f 2f 2f 2f 2f 2f   ./7*}/////////
        .db     2fh,7dh,36h,2fh,2fh,2fh,2fh,2fh,37h,2ah,7bh,2fh,2fh,2fh ; 4066 2f 7d 36 2f 2f 2f 2f 2f 37 2a 7b 2f 2f 2f   /}6/////7*{///
        .db     2fh,2fh,2fh,2fh,2fh,2fh,2fh,7bh,33h,34h,34h,34h,34h,34h ; 4074 2f 2f 2f 2f 2f 2f 2f 7b 33 34 34 34 34 34   ///////{344444
        .db     35h,2ah,7ch,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,7ch ; 4082 35 2a 7c 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 7c   5*|//////////|
        .db     2bh,8eh,8eh,8eh,8eh,8eh,8eh,2ah,7dh,2fh,2fh,2fh,2fh,2fh ; 4090 2b 8e 8e 8e 8e 8e 8e 2a 7d 2f 2f 2f 2f 2f   +......*}/////
        .db     2fh,2fh,2fh,2fh,2fh,7dh,30h,31h,31h,31h,31h,31h,32h,2ah ; 409e 2f 2f 2f 2f 2f 7d 30 31 31 31 31 31 32 2a   /////}0111112*
        .db     7bh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,7bh,36h,15h ; 40ac 7b 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 7b 36 15   {//////////{6.
        .db     12h,17h,0eh,1ch,37h,2ah,7ch,2fh,2fh,2fh,2fh,2fh,2fh,2fh ; 40ba 12 17 0e 1c 37 2a 7c 2f 2f 2f 2f 2f 2f 2f   ....7*|///////
        .db     2fh,2fh,2fh,7ch,36h,2fh,2fh,2,5,2fh,37h,2ah,7dh,2fh,2fh ; 40c8 2f 2f 2f 7c 36 2f 2f 02 05 2f 37 2a 7d 2f 2f   ///|6//../7*}//
        .db     2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,7dh,33h,34h,34h,34h,34h ; 40d7 2f 2f 2f 2f 2f 2f 2f 2f 7d 33 34 34 34 34   ////////}34444
        .db     34h,35h,2ah,7bh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh ; 40e5 34 35 2a 7b 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f   45*{//////////
        .db     7bh,2bh,38h,39h,39h,39h,39h,3ah,2ah,7ch,2fh,2fh,2fh,2fh ; 40f3 7b 2b 38 39 39 39 39 3a 2a 7c 2f 2f 2f 2f   {+89999:*|////
        .db     2fh,2fh,2fh,2fh,2fh,2fh,7ch,2bh,3bh,2fh,2fh,2fh,2fh,3ch ; 4101 2f 2f 2f 2f 2f 2f 7c 2b 3b 2f 2f 2f 2f 3c   //////|+;////<
        .db     2ah,7dh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,7dh,2bh ; 410f 2a 7d 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 7d 2b   *}//////////}+
        .db     3bh,2fh,2fh,2fh,2fh,3ch,2ah,7bh,2fh,2fh,2fh,2fh,2fh,2fh ; 411d 3b 2f 2f 2f 2f 3c 2a 7b 2f 2f 2f 2f 2f 2f   ;////<*{//////
        .db     2fh,2fh,2fh,2fh,7bh,2bh,3bh,2fh,2fh,2fh,2fh,3ch,2ah,7ch ; 412b 2f 2f 2f 2f 7b 2b 3b 2f 2f 2f 2f 3c 2a 7c   ////{+;////<*|
        .db     2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,7ch,2bh,3bh,2fh ; 4139 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 7c 2b 3b 2f   //////////|+;/
        .db     2fh,2fh,2fh,3ch,2ah,7dh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh ; 4147 2f 2f 2f 3c 2a 7d 2f 2f 2f 2f 2f 2f 2f 2f   ///<*}////////
        .db     2fh,2fh,7dh,2bh,3dh,3eh,3eh,3eh,3eh,3fh ; 4155 2f 2f 7d 2b 3d 3e 3e 3e 3e 3f   //}+=>>>>?
; Character Set
l415f:  .db     0,3ch,66h,66h,66h,66h,3ch,0,0,18h,38h,18h,18h,18h       ; 415f 00 3c 66 66 66 66 3c 00 00 18 38 18 18 18   .<ffff<...8...
        .db     3ch,0,0,3ch,4eh,0eh,3ch,70h,7eh,0,0,7ch,0eh,3ch,0eh,0eh ; 416d 3c 00 00 3c 4e 0e 3c 70 7e 00 00 7c 0e 3c 0e 0e   <..<N.<p...|.<..
        .db     7ch,0,0,3ch,6ch,4ch,4eh,7eh,0ch,0,0,7ch,60h,7ch,0eh,4eh ; 417d 7c 00 00 3c 6c 4c 4e 7e 0c 00 00 7c 60 7c 0e 4e   |..<lLN....|`|.N
        .db     3ch,0,0,3ch,60h,7ch,66h,66h,3ch,0,0,7eh,6,0ch,18h,38h,38h       ; 418d 3c 00 00 3c 60 7c 66 66 3c 00 00 7e 06 0c 18 38 38   <..<`|ff<......88
        .db     0,0,3ch,4eh,3ch,4eh,4eh,3ch,0,0,3ch,4eh,4eh,3eh,0eh,3ch ; 419e 00 00 3c 4e 3c 4e 4e 3c 00 00 3c 4e 4e 3e 0e 3c   ..<N<NN<..<NN>.<
        .db     0,0,3ch,4eh,4eh,7eh,4eh,4eh,0,0,7ch,66h,7ch,66h,66h,7ch ; 41ae 00 00 3c 4e 4e 7e 4e 4e 00 00 7c 66 7c 66 66 7c   ..<NN.NN..|f|ff|
        .db     0,0,3ch,66h,60h,60h,66h,3ch,0,0,7ch,4eh,4eh,4eh,4eh,7ch ; 41be 00 00 3c 66 60 60 66 3c 00 00 7c 4e 4e 4e 4e 7c   ..<f``f<..|NNNN|
        .db     0,0,7eh,60h,7ch,60h,60h,7eh,0,0,7eh,60h,60h,7ch,60h,60h ; 41ce 00 00 7e 60 7c 60 60 7e 00 00 7e 60 60 7c 60 60   ...`|``....``|``
        .db     0,0,3ch,66h,60h,6eh,66h,3eh,0,0,46h,46h,7eh,46h,46h,46h ; 41de 00 00 3c 66 60 6e 66 3e 00 00 46 46 7e 46 46 46   ..<f`nf>..FF.FFF
        .db     0,0,3ch,18h,18h,18h,18h,3ch,0,0,1eh,0ch,0ch,6ch,6ch,38h ; 41ee 00 00 3c 18 18 18 18 3c 00 00 1e 0c 0c 6c 6c 38   ..<....<.....ll8
        .db     0,0,66h,6ch,78h,78h,6ch,66h,0,0,60h,60h,60h,60h,60h,7eh ; 41fe 00 00 66 6c 78 78 6c 66 00 00 60 60 60 60 60 7e   ..flxxlf..`````.
        .db     0,0,46h,6eh,7eh,56h,46h,46h,0,0,46h,66h,76h,5eh,4eh,46h ; 420e 00 00 46 6e 7e 56 46 46 00 00 46 66 76 5e 4e 46   ..Fn.VFF..Ffv^NF
        .db     0,0,3ch,66h,66h,66h,66h,3ch,0,0,7ch,66h,66h,7ch,60h,60h ; 421e 00 00 3c 66 66 66 66 3c 00 00 7c 66 66 7c 60 60   ..<ffff<..|ff|``
        .db     0,0,3ch,62h,62h,6ah,64h,3ah,0,0,7ch,66h,66h,7ch,68h,66h ; 422e 00 00 3c 62 62 6a 64 3a 00 00 7c 66 66 7c 68 66   ..<bbjd:..|ff|hf
        .db     0,0,3ch,60h,3ch,0eh,4eh,3ch,0,0,7eh,18h,18h,18h,18h,18h ; 423e 00 00 3c 60 3c 0e 4e 3c 00 00 7e 18 18 18 18 18   ..<`<.N<........
        .db     0,0,46h,46h,46h,46h,4eh,3ch,0,0,46h,46h,46h,46h,2ch,18h ; 424e 00 00 46 46 46 46 4e 3c 00 00 46 46 46 46 2c 18   ..FFFFN<..FFFF,.
        .db     0,0,46h,46h,56h,7eh,6eh,46h,0,0,46h,2ch,18h,38h,64h,42h ; 425e 00 00 46 46 56 7e 6e 46 00 00 46 2c 18 38 64 42   ..FFV.nF..F,.8dB
        .db     0,0,66h,66h,3ch,18h,18h,18h,0,0,7eh,0eh,1ch,38h,70h,7eh ; 426e 00 00 66 66 3c 18 18 18 00 00 7e 0e 1c 38 70 7e   ..ff<........8p.
        .db     0,0,0,0,0,0,60h,60h,0,0,0,0,3ch,3ch,0,0,0,0,0,22h,14h,8 ; 427e 00 00 00 00 00 00 60 60 00 00 00 00 3c 3c 00 00 00 00 00 22 14 08   ......``....<<....."..
        .db     14h,22h,0,0,0,36h,36h,5fh,49h,5fh,41h,7fh,41h,3eh,22h,1ch       ; 4294 14 22 00 00 00 36 36 5f 49 5f 41 7f 41 3e 22 1c   ."...66_I_A.A>".
        .db     14h,8,8,0ffh,0ffh,0ffh,81h,0c1h,0bfh,0c1h,0bfh,0c1h,0bfh        ; 42a4 14 08 08 ff ff ff 81 c1 bf c1 bf c1 bf   .......A?A?A?
        .db     0c1h,0bfh,81h,0ffh,0ffh,0ffh,0aah,0aah,0,0,0,0,0,0,0,0,0        ; 42b1 c1 bf 81 ff ff ff aa aa 00 00 00 00 00 00 00 00 00   A?....**.........
        .db     0,0,0,0,0,0feh,0feh,0feh,0feh,0feh,0feh,0feh,0feh,0feh,0feh     ; 42c2 00 00 00 00 00 fe fe fe fe fe fe fe fe fe fe   ...............
        .db     0feh,0feh,0feh,0feh,0feh,0feh,7fh,7fh,7fh,7fh,7fh,7fh,7fh       ; 42d1 fe fe fe fe fe fe 7f 7f 7f 7f 7f 7f 7f   .............
        .db     7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,0ffh,0,0ffh,40h,0ffh        ; 42de 7f 7f 7f 7f 7f 7f 7f 7f 7f ff 00 ff 40 ff   ............@.
        .db     2,0ffh,0,0ffh,10h,0ffh,80h,0ffh,2,0ffh,0,0f0h,10h,0ffh,1fh      ; 42ec 02 ff 00 ff 10 ff 80 ff 02 ff 00 f0 10 ff 1f   ...........p...
        .db     0ffh,0,0ffh,40h,0ffh,0,0ffh,2,0ffh,40h,0ffh,0,0fh,8,0ffh        ; 42fb ff 00 ff 40 ff 00 ff 02 ff 40 ff 00 0f 08 ff   ...@.....@.....
        .db     0f8h,0ffh,0,0ffh,2,0ffh,0,0ffh,40h,0ffh,2,0ffh,0,0,0,0,0        ; 430a f8 ff 00 ff 02 ff 00 ff 40 ff 02 ff 00 00 00 00 00   x.......@........
        .db     0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,18h,18h,38h,38h,18h,18h ; 431b 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 18 18 38 38 18 18   ..................88..
        .db     18h,18h,18h,18h,3ch,3ch,0,0,0,0,3ch,3ch,4eh,4eh,4eh,4eh ; 4331 18 18 18 18 3c 3c 00 00 00 00 3c 3c 4e 4e 4e 4e   ....<<....<<NNNN
        .db     3eh,3eh,0eh,0eh,3ch,3ch,0,0,0,0,3ch,3ch,4eh,4eh,3ch,3ch ; 4341 3e 3e 0e 0e 3c 3c 00 00 00 00 3c 3c 4e 4e 3c 3c   >>..<<....<<NN<<
        .db     4eh,4eh,4eh,4eh,3ch,3ch,0,0,38h,38h,44h,44h,0bah,0bah,0a2h      ; 4351 4e 4e 4e 4e 3c 3c 00 00 38 38 44 44 ba ba a2   NNNN<<..88DD::"
        .db     0a2h,0bah,0bah,44h,44h,38h,38h,0c6h,0c6h,0e6h,0e6h,0e6h ; 4360 a2 ba ba 44 44 38 38 c6 c6 e6 e6 e6   "::DD88FFfff
        .db     0e6h,0d6h,0d6h,0d6h,0d6h,0ceh,0ceh,0ceh,0ceh,0c6h,0c6h,0c0h     ; 436c e6 d6 d6 d6 d6 ce ce ce ce c6 c6 c0   fVVVVNNNNFF@
        .db     0c0h,0c0h,0c0h,0,0,0dbh,0dbh,0ddh,0ddh,0d9h,0d9h,0d9h,0d9h      ; 4378 c0 c0 c0 00 00 db db dd dd d9 d9 d9 d9   @@@..[[]]YYYY
        .db     0d9h,0d9h,0,0,30h,30h,78h,78h,33h,33h,0b6h,0b6h,0b7h,0b7h       ; 4385 d9 d9 00 00 30 30 78 78 33 33 b6 b6 b7 b7   YY..00xx336677
        .db     0b6h,0b6h,0b3h,0b3h,0,0,0,0,0,0,0cdh,0cdh,6eh,6eh,0ech,0ech     ; 4393 b6 b6 b3 b3 00 00 00 00 00 00 cd cd 6e 6e ec ec   6633......MMnnll
        .db     0ch,0ch,0ech,0ech,1,1,1,1,1,1,8fh,8fh,0d9h,0d9h,0d9h,0d9h       ; 43a3 0c 0c ec ec 01 01 01 01 01 01 8f 8f d9 d9 d9 d9   ..ll........YYYY
        .db     0d9h,0d9h,0cfh,0cfh,80h,80h,80h,80h,80h,80h,9eh,9eh,0b3h        ; 43b3 d9 d9 cf cf 80 80 80 80 80 80 9e 9e b3   YYOO........3
        .db     0b3h,0b3h,0b3h,0b3h,0b3h,9eh,9eh,0ffh,0,0ffh,0,0ffh,0,0efh      ; 43c0 b3 b3 b3 b3 b3 9e 9e ff 00 ff 00 ff 00 ef   33333........o
        .db     0,0ffh,0,0ffh,0,0ffh,0,0ffh,0,0ffh,0,0ffh,0,0ffh,0,0e7h ; 43ce 00 ff 00 ff 00 ff 00 ff 00 ff 00 ff 00 ff 00 e7   ...............g
        .db     0,0e7h,0,0ffh,0,0ffh,0,0ffh,0,0,0ffh,0ffh,0ffh,0,0ffh,0 ; 43de 00 e7 00 ff 00 ff 00 ff 00 00 ff ff ff 00 ff 00   .g..............
        .db     0ffh,0ffh,0,0,0ffh,0ffh,0,0ffh,0,0,0ffh,0ffh,0ffh,1,0ffh        ; 43ee ff ff 00 00 ff ff 00 ff 00 00 ff ff ff 01 ff   ...............
        .db     2,0feh,0feh,2,4,0fch,0fch,4,0fch,4,0,0ffh,0ffh,0ffh,80h ; 43fd 02 fe fe 02 04 fc fc 04 fc 04 00 ff ff ff 80   .....||.|......
        .db     0ffh,40h,7fh,0ffh,40h,0e0h,3fh,0ffh,20h,0bfh,60h,0ffh,0 ; 440c ff 40 7f ff 40 e0 3f ff 20 bf 60 ff 00   .@..@`?. ?`..
        .db     0ffh,0,0ffh,1,0feh,2,0feh,2,0fch,4,0fch,4,0fch,4,0ffh,0 ; 4419 ff 00 ff 01 fe 02 fe 02 fc 04 fc 04 fc 04 ff 00   ........|.|.|...
        .db     0ffh,0,0ffh,80h,7fh,40h,0ffh,40h,0ffh,20h,0ffh,20h,0bfh ; 4429 ff 00 ff 80 7f 40 ff 40 ff 20 ff 20 bf   .....@.@. . ?
        .db     60h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh      ; 4436 60 ff ff ff ff ff ff ff ff ff ff ff   `...........
        .db     0ffh,0,0,0,0,0ffh,2,0ffh,1,0ffh,1,0ffh,1,0ffh,1,0ffh,1,0ffh     ; 4442 ff 00 00 00 00 ff 02 ff 01 ff 01 ff 01 ff 01 ff 01 ff   ..................
        .db     1,0ffh,1,7fh,0c0h,0ffh,80h,0ffh,80h,0ffh,80h,0ffh,80h,0ffh      ; 4454 01 ff 01 7f c0 ff 80 ff 80 ff 80 ff 80 ff   ....@.........
        .db     80h,0ffh,80h,0ffh,80h,0feh,2,0feh,2,0ffh,3,0fch,5,0f8h,9        ; 4462 80 ff 80 ff 80 fe 02 fe 02 ff 03 fc 05 f8 09   ...........|.x.
        .db     0f1h,12h,0e1h,26h,0c3h,4ch,7fh,0c0h,7fh,0c0h,0ffh,0c0h,0bfh     ; 4471 f1 12 e1 26 c3 4c 7f c0 7f c0 ff c0 bf   q.a&CL.@.@.@?
        .db     60h,9fh,70h,0afh,58h,27h,0dch,33h,0ceh,0ffh,0,0ffh,1,0feh       ; 447e 60 9f 70 af 58 27 dc 33 ce ff 00 ff 01 fe   `.p/X'\3N.....
        .db     2,0fch,4,0f8h,9,0f0h,13h,0e0h,27h,0e0h,2fh,87h,98h,6,39h        ; 448c 02 fc 04 f8 09 f0 13 e0 27 e0 2f 87 98 06 39   .|.x.p.`'`/...9
        .db     0eh,71h,1eh,0e1h,3ch,0c3h,3ch,0c3h,78h,87h,78h,87h,35h,0cbh     ; 449b 0e 71 1e e1 3c c3 3c c3 78 87 78 87 35 cb   .q.a<C<Cx.x.5K
        .db     32h,0cdh,3ah,0c5h,79h,86h,78h,87h,78h,87h,7ch,83h,7ch,83h       ; 44a9 32 cd 3a c5 79 86 78 87 78 87 7c 83 7c 83   2M:Ey.x.x.|.|.
        .db     0ffh,0,0ffh,80h,7fh,0c0h,3fh,0e0h,9fh,70h,4fh,0b8h,67h,9ch      ; 44b7 ff 00 ff 80 7f c0 3f e0 9f 70 4f b8 67 9c   .....@?`.pO8g.
        .db     37h,0cch,0c0h,4fh,0c0h,4fh,80h,9fh,80h,9fh,80h,9fh,80h,9fh      ; 44c5 37 cc c0 4f c0 4f 80 9f 80 9f 80 9f 80 9f   7L@O@O........
        .db     80h,9fh,80h,9fh,0f8h,7,0f0h,0fh,0f0h,0fh,0f0h,0fh,0f0h,0fh      ; 44d3 80 9f 80 9f f8 07 f0 0f f0 0f f0 0f f0 0f   ....x.p.p.p.p.
        .db     0f0h,0fh,0f0h,0fh,0f8h,7,7ch,83h,7eh,81h,7eh,81h,3eh,0c1h       ; 44e1 f0 0f f0 0f f8 07 7c 83 7e 81 7e 81 3e c1   p.p.x.|.....>A
        .db     3fh,0c0h,1fh,0e0h,1fh,0e0h,1fh,0e0h,33h,0ceh,1bh,0e6h,9 ; 44ef 3f c0 1f e0 1f e0 1f e0 33 ce 1b e6 09   ?@.`.`.`3N.f.
        .db     0f7h,0dh,0f3h,0dh,0f3h,0dh,0f3h,0dh,0f3h,9,0f7h,0c0h,5fh        ; 44fc f7 0d f3 0d f3 0d f3 0d f3 09 f7 c0 5f   w.s.s.s.s.w@_
        .db     0c0h,4fh,0e0h,2fh,0e0h,27h,0f0h,11h,0bfh,4fh,0ch,0f4h,7 ; 4509 c0 4f e0 2f e0 27 f0 11 bf 4f 0c f4 07   @O`/`'p.?O.t.
        .db     0ffh,78h,87h,7ch,83h,3ch,0c3h,1eh,0e1h,0fh,0f0h,0ffh,0ffh       ; 4516 ff 78 87 7c 83 3c c3 1e e1 0f f0 ff ff   .x.|.<C.a.p..
        .db     0ffh,0,0ffh,0ffh,0fh,0f0h,0fh,0f0h,0eh,0f1h,0eh,0f1h,6,0f9h     ; 4523 ff 00 ff ff 0f f0 0f f0 0e f1 0e f1 06 f9   .....p.p.q.q.y
        .db     0ffh,0ffh,0c5h,3fh,0ffh,0ffh,1bh,0e6h,13h,0eeh,37h,0cch ; 4531 ff ff c5 3f ff ff 1b e6 13 ee 37 cc   ..E?...f.n7L
        .db     27h,0dch,4fh,0b8h,0fch,0f3h,0fch,0a3h,0e0h,0ffh,0feh,2,0feh     ; 453d 27 dc 4f b8 fc f3 fc a3 e0 ff fe 02 fe   '\O8|s|#`....
        .db     2,0bfh,43h,1ch,0e5h,0b8h,49h,0b1h,52h,0a1h,66h,43h,0cch ; 454a 02 bf 43 1c e5 b8 49 b1 52 a1 66 43 cc   .?C.e8I1R!fCL
        .db     0ffh,0,0ffh,0,0ffh,0,0ffh,0,0ffh,0,0ffh,0,0efh,10h,0c7h ; 4557 ff 00 ff 00 ff 00 ff 00 ff 00 ff 00 ef 10 c7   ............o.G
        .db     38h,0ffh,0,0fbh,4,0fbh,4,0fbh,4,0fbh,4,0f1h,0eh,0f1h,0eh        ; 4566 38 ff 00 fb 04 fb 04 fb 04 fb 04 f1 0e f1 0e   8..{.{.{.{.q.q.
        .db     0f1h,0eh,83h,7ch,1,0feh,1,0feh,1,0feh,83h,7ch,0ffh,0,83h        ; 4575 f1 0e 83 7c 01 fe 01 fe 01 fe 83 7c ff 00 83   q..|.......|...
        .db     7ch,83h,7ch,0f1h,0eh,0e0h,1fh,0e0h,1fh,0e0h,1fh,0e0h,1fh        ; 4584 7c 83 7c f1 0e e0 1f e0 1f e0 1f e0 1f   |.|q.`.`.`.`.
        .db     0e0h,1fh,80h,7fh,80h,7fh,0f7h,8,0ebh,14h,0f7h,8,0f7h,8,0e3h     ; 4591 e0 1f 80 7f 80 7f f7 08 eb 14 f7 08 f7 08 e3   `.....w.k.w.w.c
        .db     1ch,0e3h,1ch,63h,9ch,1,0feh,0,0,60h,60h,70h,70h,78h,78h ; 45a0 1c e3 1c 63 9c 01 fe 00 00 60 60 70 70 78 78   .c.c.....``ppxx
        .db     78h,78h,70h,70h,60h,60h,0,0,0,0,30h,30h,70h,70h,30h,30h ; 45af 78 78 70 70 60 60 00 00 00 00 30 30 70 70 30 30   xxpp``....00pp00
        .db     30h,30h,30h,30h,78h,78h,0,0,0e0h,0e0h,0f0h,0e0h,0fbh,0e0h       ; 45bf 30 30 30 30 78 78 00 00 e0 e0 f0 e0 fb e0   0000xx..``p`{`
        .db     0fch,0e0h,0fch,0e1h,0fch,0e1h,0fch,0e1h,0fch,0e1h,0,0,0 ; 45cd fc e0 fc e1 fc e1 fc e1 fc e1 00 00 00   |`|a|a|a|a...
        .db     0,0ffh,0,0,0,0,0ffh,0,0,0,0,0,0,7,7,0fh,7,0dfh,7,3fh,7,3fh      ; 45da 00 ff 00 00 00 00 ff 00 00 00 00 00 00 07 07 0f 07 df 07 3f 07 3f   ................._.?.?
        .db     87h,3fh,87h,3fh,87h,3fh,87h,0fch,0e1h,0fch,0e1h,0fch,0e1h       ; 45f0 87 3f 87 3f 87 3f 87 fc e1 fc e1 fc e1   .?.?.?.|a|a|a
        .db     0fch,0e1h,0fch,0e1h,0fch,0e1h,0fch,0e1h,0fch,0e1h,3fh,87h       ; 45fd fc e1 fc e1 fc e1 fc e1 fc e1 3f 87   |a|a|a|a|a?.
        .db     3fh,87h,3fh,87h,3fh,87h,3fh,87h,3fh,87h,3fh,87h,3fh,87h ; 4609 3f 87 3f 87 3f 87 3f 87 3f 87 3f 87 3f 87   ?.?.?.?.?.?.?.
        .db     0fch,0e1h,0fch,0e1h,0fch,0e1h,0fch,0e1h,0fch,0e0h,0ffh,0e7h     ; 4617 fc e1 fc e1 fc e1 fc e1 fc e0 ff e7   |a|a|a|a|`.g
        .db     0ffh,0efh,0e0h,0ffh,0,0,0,0,0,0,0,0ffh,0,0,0ffh,0ffh,0ffh       ; 4623 ff ef e0 ff 00 00 00 00 00 00 00 ff 00 00 ff ff ff   .o`..............
        .db     0ffh,0,0ffh,3fh,87h,3fh,87h,3fh,87h,3fh,87h,3fh,7,0ffh,0e7h     ; 4634 ff 00 ff 3f 87 3f 87 3f 87 3f 87 3f 07 ff e7   ...?.?.?.?.?..g
        .db     0ffh,0f7h,7,0ffh,0f8h,0,0e0h,0,0c0h,0,80h,0,80h,0,0,0,0 ; 4643 ff f7 07 ff f8 00 e0 00 c0 00 80 00 80 00 00 00 00   .w..x.`.@........
        .db     0,0,0,7fh,0,1fh,0,0fh,0,7,0,7,0,3,0,3,0,3,0,0,0,80h,0,80h       ; 4654 00 00 00 7f 00 1f 00 0f 00 07 00 07 00 03 00 03 00 03 00 00 00 80 00 80   ........................
        .db     0,0c0h,0,0e0h,0,0f8h,0,0ffh,0,0ffh,0,3,0,7,0,7,0,0fh,0,1fh      ; 466c 00 c0 00 e0 00 f8 00 ff 00 ff 00 03 00 07 00 07 00 0f 00 1f   .@.`.x..............
        .db     0,7fh,0,0ffh,0,0ffh,0,1,1,1,1,81h,81h,0c1h,0c1h,0c1h,0c1h       ; 4680 00 7f 00 ff 00 ff 00 01 01 01 01 81 81 c1 c1 c1 c1   .............AAAA
        .db     0e1h,0e1h,0f1h,0f1h,0f9h,0f9h,0feh,0feh,0feh,0feh,0feh,0feh     ; 4691 e1 e1 f1 f1 f9 f9 fe fe fe fe fe fe   aaqqyy......
        .db     0feh,0feh,0feh,0feh,0feh,0feh,0feh,0feh,0feh,0feh,7eh,7eh       ; 469d fe fe fe fe fe fe fe fe fe fe 7e 7e   ............
        .db     7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh ; 46a9 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f   ..............
        .db     7fh,7fh,3fh,3fh,9fh,9fh,8fh,8fh,0cfh,0cfh,0e7h,0e7h,0f3h        ; 46b7 7f 7f 3f 3f 9f 9f 8f 8f cf cf e7 e7 f3   ..??....OOggs
        .db     0f3h,0f7h,0f7h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h     ; 46c4 f3 f7 f7 e0 e0 e0 e0 e0 e0 e0 e0 e0   sww`````````
        .db     0e0h,0c0h,0c0h,0c0h,0c0h,80h,80h,0f0h,0f0h,0f0h,0f0h,0f0h       ; 46d0 e0 c0 c0 c0 c0 80 80 f0 f0 f0 f0 f0   `@@@@..ppppp
        .db     0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0        ; 46dc f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 00   ppppppppppp.
        .db     0,7ch,7ch,47h,47h,41h,41h,40h,40h,40h,40h,40h,40h,7fh,40h       ; 46e8 00 7c 7c 47 47 41 41 40 40 40 40 40 40 7f 40   .||GGAA@@@@@@.@
        .db     0,0,1,1,1,1,81h,81h,0c1h,0c1h,41h,41h,61h,61h,0e1h,61h,0        ; 46f7 00 00 01 01 01 01 81 81 c1 c1 41 41 61 61 e1 61 00   ........AAAAaaaa.
        .db     0,0feh,0feh,6,6,6,6,6,6,6,6,6,6,0feh,6,0,0,1bh,1bh,32h,32h      ; 4708 00 fe fe 06 06 06 06 06 06 06 06 06 06 fe 06 00 00 1b 1b 32 32   ...................22
        .db     59h,59h,4ch,4ch,8ch,8ch,86h,86h,0ffh,83h,0,0,0ffh,0ffh,1        ; 471d 59 59 4c 4c 8c 8c 86 86 ff 83 00 00 ff ff 01   YYLL...........
        .db     1,1,1,81h,81h,41h,41h,41h,41h,3fh,21h,0,0,0beh,0beh,88h ; 472c 01 01 01 81 81 41 41 41 41 3f 21 00 00 be be 88   .....AAAA?!..>>.
        .db     88h,88h,88h,88h,88h,88h,88h,80h,80h,80h,80h,0,0,88h,88h ; 473c 88 88 88 88 88 88 88 80 80 80 80 00 00 88 88   ...............
        .db     0d8h,0d8h,0a8h,0a8h,88h,88h,88h,88h,0,0,0,0,7fh,40h,7fh ; 474b d8 d8 a8 a8 88 88 88 88 00 00 00 00 7f 40 7f   XX((.........@.
        .db     40h,7fh,40h,7fh,40h,7fh,40h,7fh,40h,7fh,40h,47h,7fh,0e1h        ; 475a 40 7f 40 7f 40 7f 40 7f 40 7f 40 47 7f e1   @.@.@.@.@.@G.a
        .db     61h,0e1h,61h,0e1h,61h,0e1h,61h,0e1h,61h,0c1h,0c1h,0c1h,0c1h     ; 4768 61 e1 61 e1 61 e1 61 e1 61 c1 c1 c1 c1   aaaaaaaaaAAAA
        .db     81h,81h,0feh,6,0feh,6,0feh,6,0feh,6,0feh,6,0feh,6,0feh,6        ; 4775 81 81 fe 06 fe 06 fe 06 fe 06 fe 06 fe 06 fe 06   ................
        .db     6,0feh,0ffh,83h,0ffh,81h,7fh,40h,7fh,40h,7fh,40h,3fh,20h        ; 4785 06 fe ff 83 ff 81 7f 40 7f 40 7f 40 3f 20   .......@.@.@? 
        .db     3fh,20h,10h,1fh,1fh,11h,9fh,91h,0cfh,0c9h,0c7h,0c5h,0e3h        ; 4793 3f 20 10 1f 1f 11 9f 91 cf c9 c7 c5 e3   ? ......OIGEc
        .db     63h,0f3h,33h,0f9h,19h,8,0f8h,80h,80h,80h,80h,80h,80h,80h        ; 47a0 63 f3 33 f9 19 08 f8 80 80 80 80 80 80 80   cs3y..x.......
        .db     80h,80h,80h,80h,80h,80h,80h,80h,80h,5fh,7fh,78h,78h,60h ; 47ae 80 80 80 80 80 80 80 80 80 5f 7f 78 78 60   ........._.xx`
        .db     60h,50h,70h,50h,70h,48h,78h,44h,7ch,7eh,7eh,1,1,1,1,1,1 ; 47bc 60 50 70 50 70 48 78 44 7c 7e 7e 01 01 01 01 01 01   `PpPpHxD|........
        .db     1,1,1,1,1,1,1,1,1,1,6,0feh,6,0feh,6,0feh,6,0feh,6,0feh,6        ; 47cd 01 01 01 01 01 01 01 01 01 01 06 fe 06 fe 06 fe 06 fe 06 fe 06   .....................
        .db     0feh,6,0feh,0feh,0feh,8,0fh,44h,47h,64h,67h,72h,73h,51h ; 47e2 fe 06 fe fe fe 08 0f 44 47 64 67 72 73 51   .......DGdgrsQ
        .db     71h,59h,79h,4ch,7ch,7eh,7eh,0ch,0fch,6,0feh,3,0ffh,1,0ffh       ; 47f0 71 59 79 4c 7c 7e 7e 0c fc 06 fe 03 ff 01 ff   qYyL|...|......
        .db     1,0ffh,0,0ffh,80h,0ffh,7fh,7fh,0,0,0,0,0,0,80h,80h,80h,80h      ; 47ff 01 ff 00 ff 80 ff 7f 7f 00 00 00 00 00 00 80 80 80 80   ..................
        .db     0c0h,0c0h,0c0h,0c0h,0e0h,0e0h,7eh,7eh,7fh,7fh,7fh,7fh,7fh       ; 4811 c0 c0 c0 c0 e0 e0 7e 7e 7f 7f 7f 7f 7f   @@@@``.......
        .db     7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,0,0,3,3,2,2,2,2,2,2 ; 481e 7f 7f 7f 7f 7f 7f 7f 7f 7f 00 00 03 03 02 02 02 02 02 02   ...................
        .db     2,2,2,2,3,2,0,0,0fbh,0fbh,0ah,0ah,12h,12h,22h,22h,22h,22h       ; 4831 02 02 02 02 03 02 00 00 fb fb 0a 0a 12 12 22 22 22 22   ........{{....""""
        .db     42h,42h,0c3h,42h,0,0,0fdh,0fdh,0dh,0dh,0ch,0ch,0ch,0ch,0ch      ; 4843 42 42 c3 42 00 00 fd fd 0d 0d 0c 0c 0c 0c 0c   BBCB..}}.......
        .db     0ch,0ch,0ch,0fch,0ch,0,0,0fch,0fch,0ch,0ch,8ch,8ch,4ch,4ch      ; 4852 0c 0c 0c fc 0c 00 00 fc fc 0c 0c 8c 8c 4c 4c   ...|...||....LL
        .db     4ch,4ch,2ch,2ch,3ch,2ch,3,2,3,2,3,3,3,3,2,2,0,0,0,0,0,0 ; 4861 4c 4c 2c 2c 3c 2c 03 02 03 02 03 03 03 03 02 02 00 00 00 00 00 00   LL,,<,................
        .db     83h,82h,83h,82h,3,2,3,2,3,2,3,2,3,2,2,3,0fch,0ch,0fch,0ch       ; 4877 83 82 83 82 03 02 03 02 03 02 03 02 03 02 02 03 fc 0c fc 0c   ................|.|.
        .db     0fch,0ch,0fch,0ch,0fch,0ch,0fch,0ch,0fch,0ch,0ch,0fch,1ch       ; 488b fc 0c fc 0c fc 0c fc 0c fc 0c 0c fc 1c   |.|.|.|.|..|.
        .db     1ch,1ch,1ch,0ch,0ch,0ch,0ch,4,4,0,0,0,0,0,0,2,3,2,3,2,3 ; 4898 1c 1c 1c 0c 0c 0c 0c 04 04 00 00 00 00 00 00 02 03 02 03 02 03   .....................
        .db     2,3,2,3,2,3,2,3,3,3,0ch,0fch,0ch,0fch,0ch,0fch,0ch,0fch ; 48ad 02 03 02 03 02 03 02 03 03 03 0c fc 0c fc 0c fc 0c fc   ...........|.|.|.|
        .db     0ch,0fch,0ch,0fch,0ch,0fch,0fch,0fch,3,3,3,3,3,3,3,3,3,3        ; 48bf 0c fc 0c fc 0c fc fc fc 03 03 03 03 03 03 03 03 03 03   .|.|.|||..........
        .db     3,3,3,3,3,3,0fch,0fch,0fch,0fch,0fch,0fch,0fch,0fch,0fch        ; 48d1 03 03 03 03 03 03 fc fc fc fc fc fc fc fc fc   ......|||||||||
        .db     0fch,0fch,0fch,0fch,0fch,0fch,0fch,0ffh,0,0ffh,0,0ffh,0 ; 48e0 fc fc fc fc fc fc fc ff 00 ff 00 ff 00   |||||||......
        .db     0ffh,0,0ffh,0,0ffh,0,0ffh,0,0ffh,0,0,0ffh,0,0ffh,0,0ffh ; 48ed ff 00 ff 00 ff 00 ff 00 ff 00 00 ff 00 ff 00 ff   ................
        .db     0,0ffh,0,0ffh,0,0ffh,0,0ffh,0,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh     ; 48fd 00 ff 00 ff 00 ff 00 ff 00 ff ff ff ff ff ff   ...............
        .db     0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0        ; 490c ff ff ff ff ff ff ff ff ff ff ff 00   ............
        .db     0,1,1,3,3,7,7,0fh,0fh,1fh,1fh,3fh,3fh,7fh,7fh,0,0,0ffh,0ffh     ; 4918 00 01 01 03 03 07 07 0f 0f 1f 1f 3f 3f 7f 7f 00 00 ff ff   ...........??......
        .db     83h,83h,83h,83h,83h,83h,83h,83h,83h,83h,0ffh,83h,0,0,7fh        ; 492b 83 83 83 83 83 83 83 83 83 83 ff 83 00 00 7f   ...............
        .db     7fh,20h,20h,10h,10h,8,8,4,4,2,2,1,1,0,0,0f3h,0f3h,32h,32h       ; 493a 7f 20 20 10 10 08 08 04 04 02 02 01 01 00 00 f3 f3 32 32   .  ............ss22
        .db     32h,32h,32h,32h,32h,32h,32h,32h,0f3h,32h,0ffh,83h,0ffh,83h      ; 494d 32 32 32 32 32 32 32 32 f3 32 ff 83 ff 83   22222222s2....
        .db     0ffh,83h,0ffh,83h,0ffh,83h,0ffh,83h,0ffh,83h,83h,0ffh,0 ; 495b ff 83 ff 83 ff 83 ff 83 ff 83 83 ff 00   .............
        .db     0,0,0,1,1,3,3,7,7,0fh,0bh,1fh,13h,23h,3fh,0f3h,0b2h,73h ; 4968 00 00 00 01 01 03 03 07 07 0f 0b 1f 13 23 3f f3 b2 73   .............#?s2s
        .db     72h,33h,33h,13h,13h,2,2,0,0,0,0,0,0,83h,0ffh,83h,0ffh,83h       ; 497a 72 33 33 13 13 02 02 00 00 00 00 00 00 83 ff 83 ff 83   r33...............
        .db     0ffh,83h,0ffh,83h,0ffh,83h,0ffh,83h,0ffh,0ffh,0ffh,43h,7fh      ; 498c ff 83 ff 83 ff 83 ff 83 ff ff ff 43 7f   ...........C.
        .db     23h,3fh,13h,1fh,0bh,0fh,7,7,3,3,1,1,0,0,0,0,0,0,0,0,0,0 ; 4999 23 3f 13 1f 0b 0f 07 07 03 03 01 01 00 00 00 00 00 00 00 00 00 00   #?....................
        .db     0,0,10h,10h,30h,30h,70h,70h,0,0,78h,78h,9ch,9ch,1ch,1ch ; 49af 00 00 10 10 30 30 70 70 00 00 78 78 9c 9c 1c 1c   ....00pp..xx....
        .db     78h,78h,0e0h,0e0h,0fch,0fch,0,0,0ffh,0,0,0,0,0,0,0,0,0,0        ; 49bf 78 78 e0 e0 fc fc 00 00 ff 00 00 00 00 00 00 00 00 00 00   xx``||.............
        .db     0,0,0,0,0,1bh,1bh,1bh,1bh,9,9,0,0,0,0,0,0,0,0,0,0,0,0,0 ; 49d2 00 00 00 00 00 1b 1b 1b 1b 09 09 00 00 00 00 00 00 00 00 00 00 00 00 00   ........................
        .db     0,0,0,0,0,60h,60h,60h,60h,20h,20h,0,0,1bh,1bh,1bh,1bh,9 ; 49ea 00 00 00 00 00 60 60 60 60 20 20 00 00 1b 1b 1b 1b 09   .....````  .......
        .db     9,0,0,0,0,60h,60h,60h,60h,0,0   ; 49fc 09 00 00 00 00 60 60 60 60 00 00   .....````..
; Initial Credits Screen (20x18 chars)
l4a07:  .db     2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh     ; 4a07 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f   /////////////
        .db     2fh,2fh,2fh,2fh,2fh,2fh,2fh,9bh,1dh,16h,2fh,0ah,17h,0dh ; 4a14 2f 2f 2f 2f 2f 2f 2f 9b 1d 16 2f 0a 17 0d   ///////.../...
        .db     2fh,33h,1,9,8,7,2fh,0eh,15h,18h,1bh,10h,9ch,2fh,1dh,0eh ; 4a22 2f 33 01 09 08 07 2f 0e 15 18 1b 10 9c 2f 1d 0e   /3..../....../..
        .db     1dh,1bh,12h,1ch,2fh,15h,12h,0ch,0eh,17h,1ch,0eh,0dh,2fh ; 4a32 1d 1b 12 1c 2f 15 12 0c 0e 17 1c 0e 0d 2f   ..../......../
        .db     1dh,18h,2fh,2fh,2fh,2fh,2fh,0bh,1eh,15h,15h,0eh,1dh,25h ; 4a40 1d 18 2f 2f 2f 2f 2f 0b 1e 15 15 0e 1d 25   ../////......%
        .db     19h,1bh,18h,18h,0fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,1ch ; 4a4e 19 1b 18 18 0f 2f 2f 2f 2f 2f 2f 2f 2f 1c   .....////////.
        .db     18h,0fh,1dh,20h,0ah,1bh,0eh,2fh,0ah,17h,0dh,2fh,2fh,2fh ; 4a5c 18 0f 1d 20 0a 1b 0e 2f 0a 17 0d 2f 2f 2f   ... .../...///
        .db     2fh,2fh,2fh,2fh,1ch,1eh,0bh,25h,15h,12h,0ch,0eh,17h,1ch ; 4a6a 2f 2f 2f 2f 1c 1e 0b 25 15 12 0c 0e 17 1c   ////...%......
        .db     0eh,0dh,2fh,1dh,18h,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,17h ; 4a78 0e 0d 2f 1d 18 2f 2f 2f 2f 2f 2f 2f 2f 17   ../..////////.
        .db     12h,17h,1dh,0eh,17h,0dh,18h,24h,2fh,2fh,2fh,2fh,2fh,2fh ; 4a86 12 17 1d 0e 17 0d 18 24 2f 2f 2f 2f 2f 2f   .......$//////
        .db     2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh ; 4a94 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f   //////////////
        .db     2fh,2fh,2fh,2fh,2fh,2fh,33h,1,9,8,9,2fh,0bh,1eh,15h,15h ; 4aa2 2f 2f 2f 2f 2f 2f 33 01 09 08 09 2f 0b 1e 15 15   //////3..../....
        .db     0eh,1dh,25h,19h,1bh,18h,18h,0fh,2fh,2fh,2fh,2fh,2fh,2fh ; 4ab2 0e 1d 25 19 1b 18 18 0f 2f 2f 2f 2f 2f 2f   ..%.....//////
        .db     2fh,1ch,18h,0fh,1dh,20h,0ah,1bh,0eh,24h,2fh,2fh,2fh,2fh ; 4ac0 2f 1c 18 0f 1d 20 0a 1b 0e 24 2f 2f 2f 2f   /.... ...$////
        .db     2fh,2fh,2fh,2fh,33h,30h,31h,32h,31h,2fh,34h,35h,36h,37h ; 4ace 2f 2f 2f 2f 33 30 31 32 31 2f 34 35 36 37   ////30121/4567
        .db     38h,39h,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh ; 4adc 38 39 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f   89////////////
        .db     2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,0ah ; 4aea 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 0a   /////////////.
        .db     15h,15h,2fh,1bh,12h,10h,11h,1dh,1ch,2fh,1bh,0eh,1ch,0eh ; 4af8 15 15 2f 1b 12 10 11 1d 1c 2f 1b 0e 1c 0e   ../....../....
        .db     1bh,1fh,0eh,0dh,24h,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh ; 4b06 1b 1f 0e 0d 24 2f 2f 2f 2f 2f 2f 2f 2f 2f   ....$/////////
        .db     2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,18h ; 4b14 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 18   /////////////.
        .db     1bh,12h,10h,12h,17h,0ah,15h,2fh,0ch,18h,17h,0ch,0eh,19h ; 4b22 1b 12 10 12 17 0a 15 2f 0c 18 17 0c 0e 19   ......./......
        .db     1dh,9ch,2fh,2fh,0dh,0eh,1ch,12h,10h,17h,2fh,0ah,17h,0dh ; 4b30 1d 9c 2f 2f 0d 0e 1c 12 10 17 2f 0a 17 0d   ..//....../...
        .db     2fh,19h,1bh,18h,10h,1bh,0ah,16h,2fh,0bh,22h,2fh,0ah,15h ; 4b3e 2f 19 1b 18 10 1b 0a 16 2f 0b 22 2f 0a 15   /......./."/..
        .db     0eh,21h,0eh,22h,2fh,19h,0ah,23h,11h,12h,1dh,17h,18h,1fh ; 4b4c 0e 21 0e 22 2f 19 0a 23 11 12 1d 17 18 1f   .!."/..#......
        .db     9dh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh ; 4b5a 9d 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f   ./////////////
        .db     2fh,2fh,2fh,2fh,2fh,2fh,2fh     ; 4b68 2f 2f 2f 2f 2f 2f 2f   ///////
; Intro Player Select Screen (20x18 chars)
l4b6f:  .db     8eh,8eh,8eh,8eh,8eh,8eh,8eh,8eh,8eh,8eh,8eh,8eh,8eh     ; 4b6f 8e 8e 8e 8e 8e 8e 8e 8e 8e 8e 8e 8e 8e   .............
        .db     8eh,8eh,8eh,8eh,8eh,8eh,8eh,5ah,5bh,5bh,5bh,5bh,5bh,5bh ; 4b7c 8e 8e 8e 8e 8e 8e 8e 5a 5b 5b 5b 5b 5b 5b   .......Z[[[[[[
        .db     5bh,5bh,5bh,5bh,5bh,5bh,5bh,5bh,5bh,5bh,5bh,5bh,5ch,5dh ; 4b8a 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5c 5d   [[[[[[[[[[[[\]
        .db     80h,81h,82h,83h,90h,91h,92h,81h,82h,83h,90h,6ch,6dh,6eh ; 4b98 80 81 82 83 90 91 92 81 82 83 90 6c 6d 6e   ...........lmn
        .db     6fh,70h,71h,72h,5eh,5dh,84h,85h,86h,87h,93h,94h,95h,85h ; 4ba6 6f 70 71 72 5e 5d 84 85 86 87 93 94 95 85   opqr^]........
        .db     86h,87h,93h,73h,74h,75h,76h,77h,78h,2fh,5eh,5dh,2fh,88h ; 4bb4 86 87 93 73 74 75 76 77 78 2f 5e 5d 2f 88   ...stuvwx/^]/.
        .db     89h,2fh,96h,97h,98h,88h,89h,2fh,96h,79h,7ah,7bh,7ch,7dh ; 4bc2 89 2f 96 97 98 88 89 2f 96 79 7a 7b 7c 7d   ./...../.yz{|}
        .db     7eh,2fh,5eh,5dh,2fh,8ah,8bh,2fh,8eh,8fh,6bh,8ah,8bh,2fh ; 4bd0 7e 2f 5e 5d 2f 8a 8b 2f 8e 8f 6b 8a 8b 2f   ./^]/../..k../
        .db     8eh,7fh,66h,67h,68h,69h,6ah,2fh,5eh,5fh,60h,60h,60h,60h ; 4bde 8e 7f 66 67 68 69 6a 2f 5e 5f 60 60 60 60   ..fghij/^_````
        .db     60h,60h,60h,60h,60h,60h,60h,60h,60h,60h,60h,60h,60h,60h ; 4bec 60 60 60 60 60 60 60 60 60 60 60 60 60 60   ``````````````
        .db     61h,8eh,3ch,3ch,3ch,3ch,3ch,3ch,3ch,3ch,3ch,3ch,3ch,3ch ; 4bfa 61 8e 3c 3c 3c 3c 3c 3c 3c 3c 3c 3c 3c 3c   a.<<<<<<<<<<<<
        .db     3ch,3dh,3eh,3ch,3ch,3ch,8eh,8eh,8ch,8ch,62h,63h,8ch,8ch ; 4c08 3c 3d 3e 3c 3c 3c 8e 8e 8c 8c 62 63 8c 8c   <=><<<....bc..
        .db     3ah,8ch,8ch,8ch,8ch,8ch,3ah,42h,43h,3bh,8ch,8ch,8eh,8eh ; 4c16 3a 8c 8c 8c 8c 8c 3a 42 43 3b 8c 8c 8e 8e   :.....:BC;....
        .db     3ah,8ch,64h,65h,8ch,8ch,8ch,8ch,3bh,8ch,8ch,8ch,8ch,44h ; 4c24 3a 8c 64 65 8c 8c 8c 8c 3b 8c 8c 8c 8c 44   :.de....;....D
        .db     45h,8ch,8ch,8ch,8eh,8eh,8ch,8ch,8ch,8ch,8ch,8ch,8ch,8ch ; 4c32 45 8c 8c 8c 8e 8e 8c 8c 8c 8c 8c 8c 8c 8c   E.............
        .db     8ch,8ch,8ch,8ch,46h,47h,48h,49h,3fh,40h,8eh,8eh,8ch,8ch ; 4c40 8c 8c 8c 8c 46 47 48 49 3f 40 8e 8e 8c 8c   ....FGHI?@....
        .db     8ch,8ch,3ah,8ch,8ch,8ch,8ch,53h,54h,8ch,4ah,4bh,4ch,4dh ; 4c4e 8c 8c 3a 8c 8c 8c 8c 53 54 8c 4a 4b 4c 4d   ..:....ST.JKLM
        .db     42h,43h,8eh,8eh,8ch,8ch,8ch,8ch,8ch,8ch,8ch,8ch,54h,55h ; 4c5c 42 43 8e 8e 8c 8c 8c 8c 8c 8c 8c 8c 54 55   BC..........TU
        .db     56h,57h,4eh,4fh,50h,51h,52h,45h,8eh,41h,41h,41h,41h,41h ; 4c6a 56 57 4e 4f 50 51 52 45 8e 41 41 41 41 41   VWNOPQRE.AAAAA
        .db     41h,41h,41h,41h,41h,41h,41h,41h,41h,41h,41h,41h,41h,41h ; 4c78 41 41 41 41 41 41 41 41 41 41 41 41 41 41   AAAAAAAAAAAAAA
        .db     41h,2fh,2fh,59h,19h,15h,0ah,22h,0eh,1bh,2fh,2fh,2fh,99h ; 4c86 41 2f 2f 59 19 15 0a 22 0e 1b 2f 2f 2f 99   A//Y..."..///.
        .db     19h,15h,0ah,22h,0eh,1bh,2fh,2fh,2fh,9ah,9ah,9ah,9ah,9ah ; 4c94 19 15 0a 22 0e 1b 2f 2f 2f 9a 9a 9a 9a 9a   ..."..///.....
        .db     9ah,9ah,2fh,2fh,2fh,9ah,9ah,9ah,9ah,9ah,9ah,9ah,2fh,2fh ; 4ca2 9a 9a 2f 2f 2f 9a 9a 9a 9a 9a 9a 9a 2f 2f   ..///.......//
        .db     2fh,2fh,2fh,33h,30h,31h,32h,31h,2fh,34h,35h,36h,37h,38h ; 4cb0 2f 2f 2f 33 30 31 32 31 2f 34 35 36 37 38   ///30121/45678
        .db     39h,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh ; 4cbe 39 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f   9/////////////
        .db     2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh     ; 4ccc 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f   ///////////
; Select Game & Music Type Screen (20x18 chars)
l4cd7:  .db     47h,48h,48h,48h,48h,48h,48h,48h,48h,48h,48h,48h,48h     ; 4cd7 47 48 48 48 48 48 48 48 48 48 48 48 48   GHHHHHHHHHHHH
        .db     48h,48h,48h,48h,48h,48h,49h,4ah,2ch,2ch,2ch,2ch,2ch,2ch ; 4ce4 48 48 48 48 48 48 49 4a 2c 2c 2c 2c 2c 2c   HHHHHHIJ,,,,,,
        .db     2ch,2ch,2ch,2ch,2ch,2ch,2ch,2ch,2ch,2ch,2ch,2ch,4bh,4ah ; 4cf2 2c 2c 2c 2c 2c 2c 2c 2c 2c 2c 2c 2c 4b 4a   ,,,,,,,,,,,,KJ
        .db     2ch,2ch,2ch,50h,51h,51h,51h,51h,51h,51h,51h,51h,51h,52h ; 4d00 2c 2c 2c 50 51 51 51 51 51 51 51 51 51 52   ,,,PQQQQQQQQQR
        .db     2ch,2ch,2ch,2ch,4bh,4ah,2ch,2ch,2ch,53h,10h,0ah,16h,0eh ; 4d0e 2c 2c 2c 2c 4b 4a 2c 2c 2c 53 10 0a 16 0e   ,,,,KJ,,,S....
        .db     2fh,1dh,22h,19h,0eh,54h,2ch,2ch,2ch,2ch,4bh,4ah,2ch,55h ; 4d1c 2f 1d 22 19 0e 54 2c 2c 2c 2c 4b 4a 2c 55   /."..T,,,,KJ,U
        .db     56h,6dh,58h,58h,58h,58h,58h,0a9h,58h,58h,58h,6eh,56h,56h        ; 4d2a 56 6d 58 58 58 58 58 a9 58 58 58 6e 56 56   VmXXXXX)XXXnVV
        .db     5ah,2ch,4bh,4ah,2ch,5bh,78h,77h,7eh,7fh,9ah,9bh,2fh,0aah        ; 4d38 5a 2c 4b 4a 2c 5b 78 77 7e 7f 9a 9b 2f aa   Z,KJ,[xw..../*
        .db     79h,77h,7eh,7fh,9ah,9bh,5ch,2ch,4bh,4ah,2ch,2dh,4fh,4fh ; 4d46 79 77 7e 7f 9a 9b 5c 2c 4b 4a 2c 2d 4f 4f   yw....\,KJ,-OO
        .db     4fh,4fh,4fh,4fh,4fh,0ach,4fh,4fh,4fh,4fh,4fh,4fh,2eh,2ch        ; 4d54 4f 4f 4f 4f 4f ac 4f 4f 4f 4f 4f 4f 2e 2c   OOOOO,OOOOOO.,
        .db     4bh,4ah,2ch,2ch,2ch,2ch,2ch,2ch,2ch,2ch,2ch,2ch,2ch,2ch ; 4d62 4b 4a 2c 2c 2c 2c 2c 2c 2c 2c 2c 2c 2c 2c   KJ,,,,,,,,,,,,
        .db     2ch,2ch,2ch,2ch,2ch,2ch,4bh,4ah,2ch,2ch,2ch,2ch,2ch,2ch ; 4d70 2c 2c 2c 2c 2c 2c 4b 4a 2c 2c 2c 2c 2c 2c   ,,,,,,KJ,,,,,,
        .db     2ch,2ch,2ch,2ch,2ch,2ch,2ch,2ch,2ch,2ch,2ch,2ch,4bh,4ah ; 4d7e 2c 2c 2c 2c 2c 2c 2c 2c 2c 2c 2c 2c 4b 4a   ,,,,,,,,,,,,KJ
        .db     2ch,2ch,2ch,50h,51h,51h,51h,51h,51h,51h,51h,51h,51h,51h ; 4d8c 2c 2c 2c 50 51 51 51 51 51 51 51 51 51 51   ,,,PQQQQQQQQQQ
        .db     52h,2ch,2ch,2ch,4bh,4ah,2ch,2ch,2ch,53h,16h,1eh,1ch,12h ; 4d9a 52 2c 2c 2c 4b 4a 2c 2c 2c 53 16 1e 1c 12   R,,,KJ,,,S....
        .db     0ch,2fh,1dh,22h,19h,0eh,54h,2ch,2ch,2ch,4bh,4ah,2ch,55h ; 4da8 0c 2f 1d 22 19 0e 54 2c 2c 2c 4b 4a 2c 55   ./."..T,,,KJ,U
        .db     56h,6dh,58h,58h,58h,58h,58h,0a9h,58h,58h,58h,58h,6eh,56h        ; 4db6 56 6d 58 58 58 58 58 a9 58 58 58 58 6e 56   VmXXXXX)XXXXnV
        .db     5ah,2ch,4bh,4ah,2ch,5bh,78h,77h,7eh,7fh,9ah,9bh,2fh,0aah        ; 4dc4 5a 2c 4b 4a 2c 5b 78 77 7e 7f 9a 9b 2f aa   Z,KJ,[xw..../*
        .db     79h,77h,7eh,7fh,9ah,9bh,5ch,2ch,4bh,4ah,2ch,71h,72h,72h ; 4dd2 79 77 7e 7f 9a 9b 5c 2c 4b 4a 2c 71 72 72   yw....\,KJ,qrr
        .db     72h,72h,72h,72h,72h,0abh,72h,72h,72h,72h,72h,72h,74h,2ch        ; 4de0 72 72 72 72 72 ab 72 72 72 72 72 72 74 2c   rrrrr+rrrrrrt,
        .db     4bh,4ah,2ch,5bh,7ah,77h,7eh,7fh,9ah,9bh,2fh,0aah,2fh,9dh        ; 4dee 4b 4a 2c 5b 7a 77 7e 7f 9a 9b 2f aa 2f 9d   KJ,[zw..../*/.
        .db     9ch,9ch,2fh,2fh,5ch,2ch,4bh,4ah,2ch,2dh,4fh,4fh,4fh,4fh ; 4dfc 9c 9c 2f 2f 5c 2c 4b 4a 2c 2d 4f 4f 4f 4f   ..//\,KJ,-OOOO
        .db     4fh,4fh,4fh,0ach,4fh,4fh,4fh,4fh,4fh,4fh,2eh,2ch,4bh,4ah        ; 4e0a 4f 4f 4f ac 4f 4f 4f 4f 4f 4f 2e 2c 4b 4a   OOO,OOOOOO.,KJ
        .db     2ch,2ch,2ch,2ch,2ch,2ch,2ch,2ch,2ch,2ch,2ch,2ch,2ch,2ch ; 4e18 2c 2c 2c 2c 2c 2c 2c 2c 2c 2c 2c 2c 2c 2c   ,,,,,,,,,,,,,,
        .db     2ch,2ch,2ch,2ch,4bh,4ch,4dh,4dh,4dh,4dh,4dh,4dh,4dh,4dh ; 4e26 2c 2c 2c 2c 4b 4c 4d 4d 4d 4d 4d 4d 4d 4d   ,,,,KLMMMMMMMM
        .db     4dh,4dh,4dh,4dh,4dh,4dh,4dh,4dh,4dh,4dh,4eh     ; 4e34 4d 4d 4d 4d 4d 4d 4d 4d 4d 4d 4e   MMMMMMMMMMN
; Type-A Select Level / Top Score Screen (20x18 chars)
l4e3f:  .db     47h,48h,48h,48h,48h,48h,48h,48h,48h,48h,48h,48h,48h     ; 4e3f 47 48 48 48 48 48 48 48 48 48 48 48 48   GHHHHHHHHHHHH
        .db     48h,48h,48h,48h,48h,48h,49h,4ah,2fh,0ah,25h,1dh,22h,19h ; 4e4c 48 48 48 48 48 48 49 4a 2f 0a 25 1d 22 19   HHHHHHIJ/.%.".
        .db     0eh,2fh,2ch,2ch,2ch,2ch,2ch,2ch,2ch,2ch,2ch,2ch,4bh,4ah ; 4e5a 0e 2f 2c 2c 2c 2c 2c 2c 2c 2c 2c 2c 4b 4a   ./,,,,,,,,,,KJ
        .db     2ch,2ch,2ch,2ch,2ch,2ch,2ch,2ch,2ch,2ch,2ch,2ch,2ch,2ch ; 4e68 2c 2c 2c 2c 2c 2c 2c 2c 2c 2c 2c 2c 2c 2c   ,,,,,,,,,,,,,,
        .db     2ch,2ch,2ch,2ch,4bh,4ah,2ch,2ch,2ch,2ch,2ch,50h,51h,51h ; 4e76 2c 2c 2c 2c 4b 4a 2c 2c 2c 2c 2c 50 51 51   ,,,,KJ,,,,,PQQ
        .db     51h,51h,51h,52h,2ch,2ch,2ch,2ch,2ch,2ch,4bh,4ah,2ch,2ch ; 4e84 51 51 51 52 2c 2c 2c 2c 2c 2c 4b 4a 2c 2c   QQQR,,,,,,KJ,,
        .db     2ch,2ch,2ch,53h,15h,0eh,1fh,0eh,15h,54h,2ch,2ch,2ch,2ch ; 4e92 2c 2c 2c 53 15 0e 1f 0e 15 54 2c 2c 2c 2c   ,,,S.....T,,,,
        .db     2ch,2ch,4bh,4ah,2ch,2ch,2ch,55h,56h,57h,58h,6ch,58h,6ch ; 4ea0 2c 2c 4b 4a 2c 2c 2c 55 56 57 58 6c 58 6c   ,,KJ,,,UVWXlXl
        .db     58h,59h,56h,5ah,2ch,2ch,2ch,2ch,4bh,4ah,2ch,2ch,2ch,5bh ; 4eae 58 59 56 5a 2c 2c 2c 2c 4b 4a 2c 2c 2c 5b   XYVZ,,,,KJ,,,[
        .db     90h,6fh,91h,6fh,92h,6fh,93h,6fh,94h,5ch,2ch,2ch,2ch,2ch ; 4ebc 90 6f 91 6f 92 6f 93 6f 94 5c 2c 2c 2c 2c   .o.o.o.o.\,,,,
        .db     4bh,4ah,2ch,2ch,2ch,71h,72h,73h,72h,73h,72h,73h,72h,73h ; 4eca 4b 4a 2c 2c 2c 71 72 73 72 73 72 73 72 73   KJ,,,qrsrsrsrs
        .db     72h,74h,2ch,2ch,2ch,2ch,4bh,4ah,2ch,2ch,2ch,5bh,95h,6fh ; 4ed8 72 74 2c 2c 2c 2c 4b 4a 2c 2c 2c 5b 95 6f   rt,,,,KJ,,,[.o
        .db     96h,6fh,97h,6fh,98h,6fh,99h,5ch,2ch,2ch,2ch,2ch,4bh,4ah ; 4ee6 96 6f 97 6f 98 6f 99 5c 2c 2c 2c 2c 4b 4a   .o.o.o.\,,,,KJ
        .db     2ch,2ch,2ch,2dh,4fh,6bh,4fh,6bh,4fh,6bh,4fh,6bh,4fh,2eh ; 4ef4 2c 2c 2c 2d 4f 6b 4f 6b 4f 6b 4f 6b 4f 2e   ,,,-OkOkOkOkO.
        .db     2ch,2ch,2ch,2ch,4bh,4ah,2ch,2ch,2ch,50h,51h,51h,51h,51h ; 4f02 2c 2c 2c 2c 4b 4a 2c 2c 2c 50 51 51 51 51   ,,,,KJ,,,PQQQQ
        .db     51h,51h,51h,51h,51h,52h,2ch,2ch,2ch,2ch,4bh,4ah,2ch,2ch ; 4f10 51 51 51 51 51 52 2c 2c 2c 2c 4b 4a 2c 2c   QQQQQR,,,,KJ,,
        .db     2ch,53h,1dh,18h,19h,25h,1ch,0ch,18h,1bh,0eh,54h,2ch,2ch ; 4f1e 2c 53 1d 18 19 25 1c 0c 18 1b 0e 54 2c 2c   ,S...%.....T,,
        .db     2ch,2ch,4bh,4ah,55h,56h,70h,6dh,58h,58h,58h,58h,58h,58h ; 4f2c 2c 2c 4b 4a 55 56 70 6d 58 58 58 58 58 58   ,,KJUVpmXXXXXX
        .db     58h,58h,58h,6eh,56h,56h,56h,5ah,4bh,4ah,5bh,1,6fh,60h,60h       ; 4f3a 58 58 58 6e 56 56 56 5a 4b 4a 5b 01 6f 60 60   XXXnVVVZKJ[.o``
        .db     60h,60h,60h,60h,2fh,2fh,60h,60h,60h,60h,60h,60h,5ch,4bh ; 4f49 60 60 60 60 2f 2f 60 60 60 60 60 60 5c 4b   ````//``````\K
        .db     4ah,5bh,2,6fh,60h,60h,60h,60h,60h,60h,2fh,2fh,60h,60h,60h       ; 4f57 4a 5b 02 6f 60 60 60 60 60 60 2f 2f 60 60 60   J[.o``````//```
        .db     60h,60h,60h,5ch,4bh,4ah,5bh,3,6fh,60h,60h,60h,60h,60h,60h       ; 4f66 60 60 60 5c 4b 4a 5b 03 6f 60 60 60 60 60 60   ```\KJ[.o``````
        .db     2fh,2fh,60h,60h,60h,60h,60h,60h,5ch,4bh,4ah,2dh,4fh,6bh ; 4f75 2f 2f 60 60 60 60 60 60 5c 4b 4a 2d 4f 6b   //``````\KJ-Ok
        .db     4fh,4fh,4fh,4fh,4fh,4fh,4fh,4fh,4fh,4fh,4fh,4fh,4fh,4fh ; 4f83 4f 4f 4f 4f 4f 4f 4f 4f 4f 4f 4f 4f 4f 4f   OOOOOOOOOOOOOO
        .db     2eh,4bh,4ch,4dh,4dh,4dh,4dh,4dh,4dh,4dh,4dh,4dh,4dh,4dh ; 4f91 2e 4b 4c 4d 4d 4d 4d 4d 4d 4d 4d 4d 4d 4d   .KLMMMMMMMMMMM
        .db     4dh,4dh,4dh,4dh,4dh,4dh,4dh,4eh ; 4f9f 4d 4d 4d 4d 4d 4d 4d 4e   MMMMMMMN
; Type-B Select Level / High / Top Score Screen (20x18 chars)
l4fa7:  .db     47h,48h,48h,48h,48h,48h,48h,48h,48h,48h,48h,48h,48h     ; 4fa7 47 48 48 48 48 48 48 48 48 48 48 48 48   GHHHHHHHHHHHH
        .db     48h,48h,48h,48h,48h,48h,49h,4ah,2fh,0bh,25h,1dh,22h,19h ; 4fb4 48 48 48 48 48 48 49 4a 2f 0b 25 1d 22 19   HHHHHHIJ/.%.".
        .db     0eh,2fh,2ch,2ch,2ch,2ch,2ch,2ch,2ch,2ch,2ch,2ch,4bh,4ah ; 4fc2 0e 2f 2c 2c 2c 2c 2c 2c 2c 2c 2c 2c 4b 4a   ./,,,,,,,,,,KJ
        .db     2ch,2ch,2ch,2ch,2ch,2ch,2ch,2ch,2ch,2ch,2ch,2ch,2ch,2ch ; 4fd0 2c 2c 2c 2c 2c 2c 2c 2c 2c 2c 2c 2c 2c 2c   ,,,,,,,,,,,,,,
        .db     2ch,2ch,2ch,2ch,4bh,4ah,2ch,2ch,50h,51h,51h,51h,51h,51h ; 4fde 2c 2c 2c 2c 4b 4a 2c 2c 50 51 51 51 51 51   ,,,,KJ,,PQQQQQ
        .db     52h,2ch,2ch,50h,51h,51h,51h,51h,52h,2ch,4bh,4ah,2ch,2ch ; 4fec 52 2c 2c 50 51 51 51 51 52 2c 4b 4a 2c 2c   R,,PQQQQR,KJ,,
        .db     53h,15h,0eh,1fh,0eh,15h,54h,2ch,2ch,53h,11h,12h,10h,11h ; 4ffa 53 15 0e 1f 0e 15 54 2c 2c 53 11 12 10 11   S.....T,,S....
        .db     54h,2ch,4bh,4ah,55h,56h,57h,58h,6ch,58h,6ch,58h,59h,56h ; 5008 54 2c 4b 4a 55 56 57 58 6c 58 6c 58 59 56   T,KJUVWXlXlXYV
        .db     5ah,75h,58h,6ch,58h,6ch,6eh,5ah,4bh,4ah,5bh,90h,6fh,91h ; 5016 5a 75 58 6c 58 6c 6e 5a 4b 4a 5b 90 6f 91   ZuXlXlnZKJ[.o.
        .db     6fh,92h,6fh,93h,6fh,94h,5ch,5bh,90h,6fh,91h,6fh,92h,5ch ; 5024 6f 92 6f 93 6f 94 5c 5b 90 6f 91 6f 92 5c   o.o.o.\[.o.o.\
        .db     4bh,4ah,71h,72h,73h,72h,73h,72h,73h,72h,73h,72h,74h,71h ; 5032 4b 4a 71 72 73 72 73 72 73 72 73 72 74 71   KJqrsrsrsrsrtq
        .db     72h,73h,72h,73h,72h,74h,4bh,4ah,5bh,95h,6fh,96h,6fh,97h ; 5040 72 73 72 73 72 74 4b 4a 5b 95 6f 96 6f 97   rsrsrtKJ[.o.o.
        .db     6fh,98h,6fh,99h,5ch,5bh,93h,6fh,94h,6fh,95h,5ch,4bh,4ah ; 504e 6f 98 6f 99 5c 5b 93 6f 94 6f 95 5c 4b 4a   o.o.\[.o.o.\KJ
        .db     2dh,4fh,6bh,4fh,6bh,4fh,6bh,4fh,6bh,4fh,2eh,2dh,4fh,6bh ; 505c 2d 4f 6b 4f 6b 4f 6b 4f 6b 4f 2e 2d 4f 6b   -OkOkOkOkO.-Ok
        .db     4fh,6bh,4fh,2eh,4bh,4ah,2ch,2ch,2ch,50h,51h,51h,51h,51h ; 506a 4f 6b 4f 2e 4b 4a 2c 2c 2c 50 51 51 51 51   OkO.KJ,,,PQQQQ
        .db     51h,51h,51h,51h,51h,52h,2ch,2ch,2ch,2ch,4bh,4ah,2ch,2ch ; 5078 51 51 51 51 51 52 2c 2c 2c 2c 4b 4a 2c 2c   QQQQQR,,,,KJ,,
        .db     2ch,53h,1dh,18h,19h,25h,1ch,0ch,18h,1bh,0eh,54h,2ch,2ch ; 5086 2c 53 1d 18 19 25 1c 0c 18 1b 0e 54 2c 2c   ,S...%.....T,,
        .db     2ch,2ch,4bh,4ah,55h,56h,70h,6dh,58h,58h,58h,58h,58h,58h ; 5094 2c 2c 4b 4a 55 56 70 6d 58 58 58 58 58 58   ,,KJUVpmXXXXXX
        .db     58h,58h,58h,6eh,56h,56h,56h,5ah,4bh,4ah,5bh,1,6fh,60h,60h       ; 50a2 58 58 58 6e 56 56 56 5a 4b 4a 5b 01 6f 60 60   XXXnVVVZKJ[.o``
        .db     60h,60h,60h,60h,2fh,2fh,60h,60h,60h,60h,60h,60h,5ch,4bh ; 50b1 60 60 60 60 2f 2f 60 60 60 60 60 60 5c 4b   ````//``````\K
        .db     4ah,5bh,2,6fh,60h,60h,60h,60h,60h,60h,2fh,2fh,60h,60h,60h       ; 50bf 4a 5b 02 6f 60 60 60 60 60 60 2f 2f 60 60 60   J[.o``````//```
        .db     60h,60h,60h,5ch,4bh,4ah,5bh,3,6fh,60h,60h,60h,60h,60h,60h       ; 50ce 60 60 60 5c 4b 4a 5b 03 6f 60 60 60 60 60 60   ```\KJ[.o``````
        .db     2fh,2fh,60h,60h,60h,60h,60h,60h,5ch,4bh,4ah,2dh,4fh,6bh ; 50dd 2f 2f 60 60 60 60 60 60 5c 4b 4a 2d 4f 6b   //``````\KJ-Ok
        .db     4fh,4fh,4fh,4fh,4fh,4fh,4fh,4fh,4fh,4fh,4fh,4fh,4fh,4fh ; 50eb 4f 4f 4f 4f 4f 4f 4f 4f 4f 4f 4f 4f 4f 4f   OOOOOOOOOOOOOO
        .db     2eh,4bh,4ch,4dh,4dh,4dh,4dh,4dh,4dh,4dh,4dh,4dh,4dh,4dh ; 50f9 2e 4b 4c 4d 4d 4d 4d 4d 4d 4d 4d 4d 4d 4d   .KLMMMMMMMMMMM
        .db     4dh,4dh,4dh,4dh,4dh,4dh,4dh,4eh ; 5107 4d 4d 4d 4d 4d 4d 4d 4e   MMMMMMMN
l510f:  .db     0cdh,0cdh,0cdh,0cdh,0cdh,0cdh,0cdh,0cdh,0cdh,0cdh       ; 510f cd cd cd cd cd cd cd cd cd cd   MMMMMMMMMM
        .db     8ch,0c9h,0cah,8ch,8ch,8ch,8ch,8ch,8ch,8ch,8ch,0cbh,0cch ; 5119 8c c9 ca 8c 8c 8c 8c 8c 8c 8c 8c cb cc   .IJ........KL
        .db     8ch,8ch,8ch,8ch,8ch,8ch,0ceh,0d7h,0d7h,0d7h,0d7h,0d7h,0d7h      ; 5126 8c 8c 8c 8c 8c 8c ce d7 d7 d7 d7 d7 d7   ......NWWWWWW
        .db     0d7h,0d7h,0d7h,0cfh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh ; 5133 d7 d7 d7 cf 2f 2f 2f 2f 2f 2f 2f 2f 2f   WWWO/////////
        .db     0d0h,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,0d1h,0d2h,2fh,2fh,2fh      ; 5140 d0 2f 2f 2f 2f 2f 2f 2f 2f d1 d2 2f 2f 2f   P////////QR///
        .db     2fh,2fh,2fh,2fh,2fh,0d3h,0d4h,7ch,7ch,7ch,7ch,7ch,7ch,2fh       ; 514e 2f 2f 2f 2f 2f d3 d4 7c 7c 7c 7c 7c 7c 2f   /////ST||||||/
        .db     2fh,0d5h,0d6h,7dh,7dh,7dh,7dh,2fh,2fh,2fh,2fh,0d8h,2fh,7bh      ; 515c 2f d5 d6 7d 7d 7d 7d 2f 2f 2f 2f d8 2f 7b   /UV}}}}////X/{
        .db     7bh,7bh,7bh,2fh,2fh,2fh,2fh,0d8h,2fh,7ch,7ch,7ch,7ch,2fh        ; 516a 7b 7b 7b 2f 2f 2f 2f d8 2f 7c 7c 7c 7c 2f   {{{////X/||||/
        .db     2fh,2fh,2fh,0d8h,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,0d8h       ; 5178 2f 2f 2f d8 2f 2f 2f 2f 2f 2f 2f 2f 2f d8   ///X/////////X
        .db     2fh,2fh,2fh,2fh,2fh,2fh,2fh,7ch,7ch,7ch,7ch,2fh,2fh,2fh ; 5186 2f 2f 2f 2f 2f 2f 2f 7c 7c 7c 7c 2f 2f 2f   ///////||||///
        .db     2fh,2fh,2fh,2fh,2fh,2fh,7ch,7dh,7dh,2fh,2fh,2fh,2fh,2fh ; 5194 2f 2f 2f 2f 2f 2f 7c 7d 7d 2f 2f 2f 2f 2f   //////|}}/////
        .db     2fh,2fh,7dh,2fh,2fh,2fh,0d9h,2fh,2fh,2fh,2fh,2fh,7bh,0b7h       ; 51a2 2f 2f 7d 2f 2f 2f d9 2f 2f 2f 2f 2f 7b b7   //}///Y/////{7
        .db     0b8h,0d9h,0b7h,2fh,7ch,7ch,7ch,7ch,7ch,7dh,7dh,7dh,7dh,7dh      ; 51b0 b8 d9 b7 2f 7c 7c 7c 7c 7c 7d 7d 7d 7d 7d   8Y7/|||||}}}}}
        .db     7dh,7dh,7dh,7dh,7dh,0ffh        ; 51be 7d 7d 7d 7d 7d ff   }}}}}.
l51c4:  .db     4ah,4ah,4ah,4ah,4ah,4ah,59h,69h,69h,69h,69h,69h,69h     ; 51c4 4a 4a 4a 4a 4a 4a 59 69 69 69 69 69 69   JJJJJJYiiiiii
        .db     49h,4ah,4ah,4ah,4ah,4ah,4ah,5ah,5ah,5ah,5ah,5ah,5ah,85h ; 51d1 49 4a 4a 4a 4a 4a 4a 5a 5a 5a 5a 5a 5a 85   IJJJJJJZZZZZZ.
        .db     85h,85h,85h,85h,85h,85h,85h,5ah,5ah,38h,39h,38h,5ah,6ah ; 51df 85 85 85 85 85 85 85 5a 5a 38 39 38 5a 6a   .......ZZ898Zj
        .db     6ah,6ah,6ah,6ah,6ah,6ah,6ah,6ah,6ah,6ah,6ah,6ah,6ah,6ah ; 51ed 6a 6a 6a 6a 6a 6a 6a 6a 6a 6a 6a 6a 6a 6a   jjjjjjjjjjjjjj
        .db     6ah,6ah,6ah,6ah,6ah,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7 ; 51fb 6a 6a 6a 6a 6a 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07   jjjjj..................
        .db     7,7             ; 5212 07 07   ..
; Mario VS Luigi Screen (20x18 chars)
l5214:  .db     47h,48h,48h,48h,48h,48h,48h,48h,48h,48h,48h,48h,48h     ; 5214 47 48 48 48 48 48 48 48 48 48 48 48 48   GHHHHHHHHHHHH
        .db     48h,48h,48h,48h,48h,48h,49h,4ah,2ch,2ch,2ch,2ch,2ch,2ch ; 5221 48 48 48 48 48 48 49 4a 2c 2c 2c 2c 2c 2c   HHHHHHIJ,,,,,,
        .db     2ch,2ch,2ch,2ch,2ch,2ch,2ch,2ch,2ch,2ch,2ch,2ch,4bh,4ah ; 522f 2c 2c 2c 2c 2c 2c 2c 2c 2c 2c 2c 2c 4b 4a   ,,,,,,,,,,,,KJ
        .db     2ch,2ch,16h,0ah,1bh,12h,18h,2fh,1fh,1ch,24h,15h,1eh,12h ; 523d 2c 2c 16 0a 1b 12 18 2f 1f 1c 24 15 1e 12   ,,...../..$...
        .db     10h,12h,2ch,2ch,4bh,4ah,2ch,2ch,2ch,2ch,2ch,2ch,2ch,2ch ; 524b 10 12 2c 2c 4b 4a 2c 2c 2c 2c 2c 2c 2c 2c   ..,,KJ,,,,,,,,
        .db     2ch,50h,51h,51h,51h,51h,52h,2ch,2ch,2ch,4bh,4ah,2ch,2ch ; 5259 2c 50 51 51 51 51 52 2c 2c 2c 4b 4a 2c 2c   ,PQQQQR,,,KJ,,
        .db     2ch,2ch,2ch,2ch,2ch,2ch,2ch,53h,11h,12h,10h,11h,54h,2ch ; 5267 2c 2c 2c 2c 2c 2c 2c 53 11 12 10 11 54 2c   ,,,,,,,S....T,
        .db     2ch,2ch,4bh,4ah,2ch,2ch,55h,56h,56h,5ah,2ch,2ch,2ch,75h ; 5275 2c 2c 4b 4a 2c 2c 55 56 56 5a 2c 2c 2c 75   ,,KJ,,UVVZ,,,u
        .db     58h,6ch,58h,6ch,6eh,5ah,2ch,2ch,4bh,4ah,2ch,2ch,5bh,2fh ; 5283 58 6c 58 6c 6e 5a 2c 2c 4b 4a 2c 2c 5b 2f   XlXlnZ,,KJ,,[/
        .db     2fh,5ch,2ch,2ch,2ch,5bh,90h,6fh,91h,6fh,92h,5ch,2ch,2ch ; 5291 2f 5c 2c 2c 2c 5b 90 6f 91 6f 92 5c 2c 2c   /\,,,[.o.o.\,,
        .db     4bh,4ah,2ch,2ch,5bh,2fh,2fh,5ch,2ch,2ch,2ch,71h,72h,73h ; 529f 4b 4a 2c 2c 5b 2f 2f 5c 2c 2c 2c 71 72 73   KJ,,[//\,,,qrs
        .db     72h,73h,72h,74h,2ch,2ch,4bh,4ah,2ch,2ch,2dh,4fh,4fh,2eh ; 52ad 72 73 72 74 2c 2c 4b 4a 2c 2c 2d 4f 4f 2e   rsrt,,KJ,,-OO.
        .db     2ch,2ch,2ch,5bh,93h,6fh,94h,6fh,95h,5ch,2ch,2ch,4bh,4ah ; 52bb 2c 2c 2c 5b 93 6f 94 6f 95 5c 2c 2c 4b 4a   ,,,[.o.o.\,,KJ
        .db     2ch,2ch,16h,0ah,1bh,12h,18h,2ch,2ch,2dh,4fh,6bh,4fh,6bh ; 52c9 2c 2c 16 0a 1b 12 18 2c 2c 2d 4f 6b 4f 6b   ,,.....,,-OkOk
        .db     4fh,2eh,2ch,2ch,4bh,4ah,2ch,2ch,2ch,2ch,2ch,2ch,2ch,2ch ; 52d7 4f 2e 2c 2c 4b 4a 2c 2c 2c 2c 2c 2c 2c 2c   O.,,KJ,,,,,,,,
        .db     2ch,50h,51h,51h,51h,51h,52h,2ch,2ch,2ch,4bh,4ah,2ch,2ch ; 52e5 2c 50 51 51 51 51 52 2c 2c 2c 4b 4a 2c 2c   ,PQQQQR,,,KJ,,
        .db     2ch,2ch,2ch,2ch,2ch,2ch,2ch,53h,11h,12h,10h,11h,54h,2ch ; 52f3 2c 2c 2c 2c 2c 2c 2c 53 11 12 10 11 54 2c   ,,,,,,,S....T,
        .db     2ch,2ch,4bh,4ah,2ch,2ch,55h,56h,56h,5ah,2ch,2ch,2ch,75h ; 5301 2c 2c 4b 4a 2c 2c 55 56 56 5a 2c 2c 2c 75   ,,KJ,,UVVZ,,,u
        .db     58h,6ch,58h,6ch,6eh,5ah,2ch,2ch,4bh,4ah,2ch,2ch,5bh,2fh ; 530f 58 6c 58 6c 6e 5a 2c 2c 4b 4a 2c 2c 5b 2f   XlXlnZ,,KJ,,[/
        .db     2fh,5ch,2ch,2ch,2ch,5bh,90h,6fh,91h,6fh,92h,5ch,2ch,2ch ; 531d 2f 5c 2c 2c 2c 5b 90 6f 91 6f 92 5c 2c 2c   /\,,,[.o.o.\,,
        .db     4bh,4ah,2ch,2ch,5bh,2fh,2fh,5ch,2ch,2ch,2ch,71h,72h,73h ; 532b 4b 4a 2c 2c 5b 2f 2f 5c 2c 2c 2c 71 72 73   KJ,,[//\,,,qrs
        .db     72h,73h,72h,74h,2ch,2ch,4bh,4ah,2ch,2ch,2dh,4fh,4fh,2eh ; 5339 72 73 72 74 2c 2c 4b 4a 2c 2c 2d 4f 4f 2e   rsrt,,KJ,,-OO.
        .db     2ch,2ch,2ch,5bh,93h,6fh,94h,6fh,95h,5ch,2ch,2ch,4bh,4ah ; 5347 2c 2c 2c 5b 93 6f 94 6f 95 5c 2c 2c 4b 4a   ,,,[.o.o.\,,KJ
        .db     2ch,2ch,15h,1eh,12h,10h,12h,2ch,2ch,2dh,4fh,6bh,4fh,6bh ; 5355 2c 2c 15 1e 12 10 12 2c 2c 2d 4f 6b 4f 6b   ,,.....,,-OkOk
        .db     4fh,2eh,2ch,2ch,4bh,4ch,4dh,4dh,4dh,4dh,4dh,4dh,4dh,4dh ; 5363 4f 2e 2c 2c 4b 4c 4d 4d 4d 4d 4d 4d 4d 4d   O.,,KLMMMMMMMM
        .db     4dh,4dh,4dh,4dh,4dh,4dh,4dh,4dh,4dh,4dh,4eh     ; 5371 4d 4d 4d 4d 4d 4d 4d 4d 4d 4d 4e   MMMMMMMMMMN
; Type-B Falling Blocks Screen (20x18 chars) (same as 3ff7 ????)
l537c:  .db     8eh,0b2h,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,0b3h   ; 537c 8e b2 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f b3   .2//////////3
        .db     30h,31h,31h,31h,31h,31h,32h,8eh,0b0h,2fh,2fh,2fh,2fh,2fh        ; 5389 30 31 31 31 31 31 32 8e b0 2f 2f 2f 2f 2f   0111112.0/////
        .db     2fh,2fh,2fh,2fh,2fh,0b5h,36h,2fh,2fh,2fh,2fh,2fh,37h,8eh        ; 5397 2f 2f 2f 2f 2f b5 36 2f 2f 2f 2f 2f 37 8e   /////56/////7.
        .db     0b0h,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,0b5h,36h,2fh       ; 53a5 b0 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f b5 36 2f   0//////////56/
        .db     2fh,2fh,2fh,2fh,37h,8eh,0b0h,2fh,2fh,2fh,2fh,2fh,2fh,2fh        ; 53b3 2f 2f 2f 2f 37 8e b0 2f 2f 2f 2f 2f 2f 2f   ////7.0///////
        .db     2fh,2fh,2fh,0b5h,40h,42h,42h,42h,42h,42h,41h,8eh,0b0h,2fh       ; 53c1 2f 2f 2f b5 40 42 42 42 42 42 41 8e b0 2f   ///5@BBBBBA.0/
        .db     2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,0b5h,36h,11h,12h,10h        ; 53cf 2f 2f 2f 2f 2f 2f 2f 2f 2f b5 36 11 12 10   /////////56...
        .db     11h,2fh,37h,8eh,0b0h,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh        ; 53dd 11 2f 37 8e b0 2f 2f 2f 2f 2f 2f 2f 2f 2f   ./7.0/////////
        .db     2fh,0b5h,36h,2fh,2fh,2fh,2fh,2fh,37h,8eh,0b0h,2fh,2fh,2fh       ; 53eb 2f b5 36 2f 2f 2f 2f 2f 37 8e b0 2f 2f 2f   /56/////7.0///
        .db     2fh,2fh,2fh,2fh,2fh,2fh,2fh,0b5h,33h,34h,34h,34h,34h,34h        ; 53f9 2f 2f 2f 2f 2f 2f 2f b5 33 34 34 34 34 34   ///////5344444
        .db     35h,8eh,0b0h,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,0b5h       ; 5407 35 8e b0 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f b5   5.0//////////5
        .db     2bh,8eh,8eh,8eh,8eh,8eh,8eh,8eh,0b0h,2fh,2fh,2fh,2fh,2fh        ; 5415 2b 8e 8e 8e 8e 8e 8e 8e b0 2f 2f 2f 2f 2f   +.......0/////
        .db     2fh,2fh,2fh,2fh,2fh,0b5h,30h,31h,31h,31h,31h,31h,32h,8eh        ; 5423 2f 2f 2f 2f 2f b5 30 31 31 31 31 31 32 8e   /////50111112.
        .db     0b0h,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,0b5h,36h,15h       ; 5431 b0 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f b5 36 15   0//////////56.
        .db     12h,17h,0eh,1ch,37h,8eh,0b0h,2fh,2fh,2fh,2fh,2fh,2fh,2fh        ; 543f 12 17 0e 1c 37 8e b0 2f 2f 2f 2f 2f 2f 2f   ....7.0///////
        .db     2fh,2fh,2fh,0b5h,36h,2fh,2fh,2fh,2fh,2fh,37h,8eh,0b0h,2fh       ; 544d 2f 2f 2f b5 36 2f 2f 2f 2f 2f 37 8e b0 2f   ///56/////7.0/
        .db     2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,0b5h,33h,34h,34h,34h        ; 545b 2f 2f 2f 2f 2f 2f 2f 2f 2f b5 33 34 34 34   /////////53444
        .db     34h,34h,35h,8eh,0b0h,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh        ; 5469 34 34 35 8e b0 2f 2f 2f 2f 2f 2f 2f 2f 2f   445.0/////////
        .db     2fh,0b5h,2bh,38h,39h,39h,39h,39h,3ah,8eh,0b0h,2fh,2fh,2fh       ; 5477 2f b5 2b 38 39 39 39 39 3a 8e b0 2f 2f 2f   /5+89999:.0///
        .db     2fh,2fh,2fh,2fh,2fh,2fh,2fh,0b5h,2bh,3bh,2fh,2fh,2fh,2fh        ; 5485 2f 2f 2f 2f 2f 2f 2f b5 2b 3b 2f 2f 2f 2f   ///////5+;////
        .db     3ch,8eh,0b0h,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,0b5h       ; 5493 3c 8e b0 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f b5   <.0//////////5
        .db     2bh,3bh,2fh,2fh,2fh,2fh,3ch,8eh,0b0h,2fh,2fh,2fh,2fh,2fh        ; 54a1 2b 3b 2f 2f 2f 2f 3c 8e b0 2f 2f 2f 2f 2f   +;////<.0/////
        .db     2fh,2fh,2fh,2fh,2fh,0b5h,2bh,3bh,2fh,2fh,2fh,2fh,3ch,8eh        ; 54af 2f 2f 2f 2f 2f b5 2b 3b 2f 2f 2f 2f 3c 8e   /////5+;////<.
        .db     0b0h,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,2fh,0b5h,2bh,3bh       ; 54bd b0 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f b5 2b 3b   0//////////5+;
        .db     2fh,2fh,2fh,2fh,3ch,8eh,0b1h,2fh,2fh,2fh,2fh,2fh,2fh,2fh        ; 54cb 2f 2f 2f 2f 3c 8e b1 2f 2f 2f 2f 2f 2f 2f   ////<.1///////
        .db     2fh,2fh,2fh,0b4h,2bh,3dh,3eh,3eh,3eh,3eh,3fh    ; 54d9 2f 2f 2f b4 2b 3d 3e 3e 3e 3e 3f   ///4+=>>>>?
l54e4:  .db     7,7,7,7,7,7,84h,87h,87h,8ch,87h,87h,8ch,87h,87h,8ch     ; 54e4 07 07 07 07 07 07 84 87 87 8c 87 87 8c 87 87 8c   ................
        .db     87h,87h,86h,7,7,1eh,1eh,1eh,1eh,1eh,79h,2fh,2fh,8dh,2fh ; 54f4 87 87 86 07 07 1e 1e 1e 1e 1e 79 2f 2f 8d 2f   ..........y//./
        .db     2fh,8dh,2fh,2fh,8dh,2fh,2fh,88h,7,7,0b4h,0b5h,0bbh,2eh,0bch     ; 5503 2f 8d 2f 2f 8d 2f 2f 88 07 07 b4 b5 bb 2e bc   /.//.//...45;.<
        .db     79h,2fh,2fh,8dh,2fh,2fh,8dh,2fh,2fh,8dh,2fh,2fh,88h,7,7 ; 5512 79 2f 2f 8d 2f 2f 8d 2f 2f 8d 2f 2f 88 07 07   y//.//.//.//...
        .db     0bfh,0bfh,0bfh,0bfh,0bfh,89h,8ah,8ah,8eh,8ah,8ah,8eh,8ah        ; 5521 bf bf bf bf bf 89 8a 8a 8e 8a 8a 8e 8a   ?????........
        .db     8ah,8eh,8ah,8ah,8bh,7,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6 ; 552e 8a 8e 8a 8a 8b 07 06 06 06 06 06 06 06 06 06 06 06 06 06 06 06 06 06   .......................
        .db     6,6,6,16h,16h,16h,16h,16h,16h,16h,16h,16h,16h,16h,16h,16h       ; 5545 06 06 06 16 16 16 16 16 16 16 16 16 16 16 16 16   ................
        .db     16h,16h,16h,16h,16h,16h,16h,7,7,7,7,7,7,84h,87h,87h,8ch ; 5555 16 16 16 16 16 16 16 07 07 07 07 07 07 84 87 87 8c   .................
        .db     87h,87h,8ch,87h,87h,8ch,87h,87h,86h,7,7,1eh,1eh,1eh,1eh ; 5566 87 87 8c 87 87 8c 87 87 86 07 07 1e 1e 1e 1e   ...............
        .db     1eh,79h,2fh,2fh,8dh,2fh,2fh,8dh,2fh,2fh,8dh,2fh,2fh,88h ; 5575 1e 79 2f 2f 8d 2f 2f 8d 2f 2f 8d 2f 2f 88   .y//.//.//.//.
        .db     7,7,0bdh,0b2h,2eh,0beh,2eh,79h,2fh,2fh,8dh,2fh,2fh,8dh,2fh      ; 5583 07 07 bd b2 2e be 2e 79 2f 2f 8d 2f 2f 8d 2f   ..=2.>.y//.//./
        .db     2fh,8dh,2fh,2fh,88h,7,7,0bfh,0bfh,0bfh,0bfh,0bfh,89h,8ah        ; 5592 2f 8d 2f 2f 88 07 07 bf bf bf bf bf 89 8a   /.//...?????..
        .db     8ah,8eh,8ah,8ah,8eh,8ah,8ah,8eh,8ah,8ah,8bh,7   ; 55a0 8a 8e 8a 8a 8e 8a 8a 8e 8a 8a 8b 07   ............
l55ac:  .db     1,1,1,1,1,1,2,2,3,3,1,1,1,1,2,2,0,0,0,0,0,0,0,0,7       ; 55ac 01 01 01 01 01 01 02 02 03 03 01 01 01 01 02 02 00 00 00 00 00 00 00 00 07   .........................
        .db     7,18h,1fh,21h,3eh,47h,7fh,0f2h,0feh,12h,1eh,12h,1eh,12h ; 55c5 07 18 1f 21 3e 47 7f f2 fe 12 1e 12 1e 12   ...!>G.r......
        .db     1eh,7eh,7eh,0ffh,83h,0ffh,81h,0ffh,0ffh,0,0,0,0,0,0,0,0 ; 55d3 1e 7e 7e ff 83 ff 81 ff ff 00 00 00 00 00 00 00 00   .................
        .db     7,7,18h,1fh,21h,3eh,47h,7fh,4,0fch,2,0feh,2,0feh,7,0fdh ; 55e4 07 07 18 1f 21 3e 47 7f 04 fc 02 fe 02 fe 07 fd   ....!>G..|.....}
        .db     7,0fdh,1fh,0ffh,0ffh,0ffh,0ffh,0fah,0,0,0,0,0,0,0,0,0,0 ; 55f4 07 fd 1f ff ff ff ff fa 00 00 00 00 00 00 00 00 00 00   .}.....z..........
        .db     0,0,7,7,18h,1fh,0ffh,0ffh,77h,11h,0ffh,11h,0ffh,0ffh,0ddh       ; 5606 00 00 07 07 18 1f ff ff 77 11 ff 11 ff ff dd   ........w.....]
        .db     44h,0ffh,44h,0ffh,0ffh,77h,11h,0ffh,0ffh,0ffh,0ffh,0ffh ; 5615 44 ff 44 ff ff 77 11 ff ff ff ff ff   D.D..w......
        .db     0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0        ; 5621 ff ff ff ff ff ff ff ff ff ff ff 00   ............
        .db     0,3,3,5,4,3,3,0,0,18h,18h,2ch,24h,1ah,1ah,8,8,40h,40h,7 ; 562d 00 03 03 05 04 03 03 00 00 18 18 2c 24 1a 1a 08 08 40 40 07   ...........,$....@@.
        .db     7,18h,1fh,0a0h,0bfh,3bh,3fh,7ch,44h,7ch,44h,10h,10h,2,2 ; 5641 07 18 1f a0 bf 3b 3f 7c 44 7c 44 10 10 02 02   ... ?;?|D|D....
        .db     0e0h,0e0h,18h,0f8h,5,0fdh,8ch,0fch,78h,48h,6ch,74h,0,0,7        ; 5650 e0 e0 18 f8 05 fd 8c fc 78 48 6c 74 00 00 07   ``.x.}.|xHlt...
        .db     7,18h,1fh,20h,3fh,30h,3fh,1fh,1dh,3eh,22h,3eh,22h,80h,80h       ; 565f 07 18 1f 20 3f 30 3f 1f 1d 3e 22 3e 22 80 80   ... ?0?..>">"..
        .db     80h,80h,80h,80h,80h,80h,0,0,0c0h,0c0h,0e0h,0e0h,0e0h,0e0h       ; 566e 80 80 80 80 80 80 00 00 c0 c0 e0 e0 e0 e0   ........@@````
        .db     0,0,7ch,7ch,66h,66h,66h,66h,7ch,7ch,60h,60h,60h,60h,0,0 ; 567c 00 00 7c 7c 66 66 66 66 7c 7c 60 60 60 60 00 00   ..||ffff||````..
        .db     0,0,3ch,3ch,60h,60h,3ch,3ch,0eh,0eh,4eh,4eh,3ch,3ch,0,0 ; 568c 00 00 3c 3c 60 60 3c 3c 0e 0e 4e 4e 3c 3c 00 00   ..<<``<<..NN<<..
        .db     7,7,1fh,18h,3eh,20h,7fh,4fh,7fh,5fh,70h,70h,0a2h,0a2h,0b0h      ; 569c 07 07 1f 18 3e 20 7f 4f 7f 5f 70 70 a2 a2 b0   ....> .O._pp""0
        .db     0b0h,4,4,7,4,4,4,4,0dh,4,0dh,4,4,4,4,3,2,5fh,7fh,39h,30h        ; 56ab b0 04 04 07 04 04 04 04 0d 04 0d 04 04 04 04 03 02 5f 7f 39 30   0................_.90
        .db     7bh,62h,0fbh,0b2h,0ffh,0a0h,0ffh,0c2h,7fh,54h,7fh,5ch,0 ; 56c0 7b 62 fb b2 ff a0 ff c2 7f 54 7f 5c 00   {b{2. .B.T.\.
        .db     0,0,0,0,0,3,3,4,4,8,8,9,9,4,4,5fh,7fh,39h,30h,7bh,62h,0fbh      ; 56cd 00 00 00 00 00 03 03 04 04 08 08 09 09 04 04 5f 7f 39 30 7b 62 fb   ..............._.90{b{
        .db     0b2h,0ffh,0a0h,0ffh,0c2h,7fh,54h,7fh,5ch,18h,0f8h,4,0fch        ; 56e3 b2 ff a0 ff c2 7f 54 7f 5c 18 f8 04 fc   2. .B.T.\.x.|
        .db     2,0feh,2,0feh,7,0fdh,7,0fdh,0ffh,0ffh,0ffh,0fah,20h,3fh ; 56f0 02 fe 02 fe 07 fd 07 fd ff ff ff fa 20 3f   .....}.}...z ?
        .db     40h,7fh,40h,7fh,0e0h,0bfh,0e0h,0bfh,0f8h,0ffh,7fh,7fh,7fh       ; 56fe 40 7f 40 7f e0 bf e0 bf f8 ff 7f 7f 7f   @.@.`?`?x....
        .db     5fh,0ffh,11h,0ffh,0ffh,0ddh,44h,0ffh,44h,0ffh,0ffh,77h,11h      ; 570b 5f ff 11 ff ff dd 44 ff 44 ff ff 77 11   _....]D.D..w.
        .db     0ffh,11h,0ffh,0ffh,0,0,0,0,0,0,0,0,0,0,0,0,80h,80h,0c0h ; 5718 ff 11 ff ff 00 00 00 00 00 00 00 00 00 00 00 00 80 80 c0   ..................@
        .db     40h,0,0,0,0,0,0,4,4,8,8,1ch,14h,14h,14h,8,8,18h,1fh,20h ; 572b 40 00 00 00 00 00 00 04 04 08 08 1c 14 14 14 08 08 18 1f 20   @.................. 
        .db     3fh,40h,7fh,40h,7fh,0e0h,0bfh,0e0h,0bfh,7fh,7fh,7fh,5fh ; 573f 3f 40 7f 40 7f e0 bf e0 bf 7f 7f 7f 5f   ?@.@.`?`?..._
        .db     0ddh,44h,0ffh,44h,0ffh,0ffh,77h,11h,0ffh,11h,0ffh,0ffh,0ddh     ; 574c dd 44 ff 44 ff ff 77 11 ff 11 ff ff dd   ]D.D..w.....]
        .db     44h,0ffh,44h,0,0,0,0,0,0,20h,20h,10h,10h,38h,28h,28h,28h        ; 5759 44 ff 44 00 00 00 00 00 00 20 20 10 10 38 28 28 28   D.D......  ..8(((
        .db     90h,90h,0,0,46h,46h,46h,46h,7eh,7eh,46h,46h,46h,46h,46h ; 576a 90 90 00 00 46 46 46 46 7e 7e 46 46 46 46 46   ....FFFF..FFFFF
        .db     46h,0,0,0,0,7eh,7eh,18h,18h,18h,18h,18h,18h,18h,18h,18h ; 5779 46 00 00 00 00 7e 7e 18 18 18 18 18 18 18 18 18   F...............
        .db     18h,0,0,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh       ; 5789 18 00 00 ff ff ff ff ff ff ff ff ff ff   .............
        .db     0ffh,0ffh,0,0,0,0eeh,0b4h,0b4h,64h,64h,3ch,3ch,2eh,2eh,27h      ; 5796 ff ff 00 00 00 ee b4 b4 64 64 3c 3c 2e 2e 27   .....n44dd<<..'
        .db     27h,70h,70h,0fch,9ch,0f7h,9fh,0,0,0,0,0,0,1,1,1,1,2,2,2 ; 57a5 27 70 70 fc 9c f7 9f 00 00 00 00 00 00 01 01 01 01 02 02 02   'pp|.w..............
        .db     2,2,2,3fh,2eh,7fh,63h,0ffh,98h,0f7h,1fh,0f7h,1ch,0f7h,0d7h      ; 57b9 02 02 02 3f 2e 7f 63 ff 98 f7 1f f7 1c f7 d7   ...?..c..w.w.wW
        .db     34h,3fh,0ach,0bfh,3,3,1,1,1,1,0,0,0,0,6,6,5,5,7,7,0ffh,0aeh     ; 57c8 34 3f ac bf 03 03 01 01 01 01 00 00 00 00 06 06 05 05 07 07 ff ae   4?,?..................
        .db     0ffh,23h,0ffh,18h,0f7h,9fh,0f7h,9ch,77h,57h,34h,3fh,6ch ; 57de ff 23 ff 18 f7 9f f7 9c 77 57 34 3f 6c   .#..w.w.wW4?l
        .db     7fh,0,0,0,0,0,0,1,1,1,1,2,2,2,2,2,2,3fh,2fh,7fh,7ch,0f7h        ; 57eb 7f 00 00 00 00 00 00 01 01 01 01 02 02 02 02 02 02 3f 2f 7f 7c f7   .................?/.|w
        .db     9ch,0f3h,1fh,0f0h,1fh,0f0h,0dfh,30h,3fh,0a0h,0bfh,0ffh,0f4h     ; 5801 9c f3 1f f0 1f f0 df 30 3f a0 bf ff f4   .s.p.p_0? ?.t
        .db     0ffh,3eh,0efh,38h,0cfh,0f8h,0fh,0fbh,0eh,0fah,0ch,0fch,4        ; 580e ff 3e ef 38 cf f8 0f fb 0e fa 0c fc 04   .>o8Ox.{.z.|.
        .db     0fch,0e0h,20h,0e0h,20h,0e0h,20h,0c0h,40h,80h,80h,0,0,0,0        ; 581b fc e0 20 e0 20 e0 20 c0 40 80 80 00 00 00 00   |` ` ` @@......
        .db     0,0,0,0,0,0,0,0,0,0,1,1,1,1,2,2,2,2,3fh,2fh,3fh,3ch,77h ; 582a 00 00 00 00 00 00 00 00 00 00 01 01 01 01 02 02 02 02 3f 2f 3f 3c 77   ..................?/?<w
        .db     5ch,0f3h,9fh,0f0h,1fh,0f0h,1fh,0f0h,0ffh,20h,3fh,0ffh,0f4h      ; 5841 5c f3 9f f0 1f f0 1f f0 ff 20 3f ff f4   \s.p.p.p. ?.t
        .db     0ffh,3eh,0efh,38h,0cfh,0f9h,0eh,0fah,0eh,0fah,0ch,0fch,4        ; 584e ff 3e ef 38 cf f9 0e fa 0e fa 0c fc 04   .>o8Oy.z.z.|.
        .db     0fch,0c0h,40h,0c0h,40h,0c0h,40h,80h,80h,0,0,0,0,0,0,0,0 ; 585b fc c0 40 c0 40 c0 40 80 80 00 00 00 00 00 00 00 00   |@@@@@@..........
        .db     0f7h,1ch,0f7h,34h,0f7h,0bfh,6ch,7fh,10h,1fh,50h,5fh,32h ; 586c f7 1c f7 34 f7 bf 6c 7f 10 1f 50 5f 32   w.w4w?l...P_2
        .db     3fh,0f1h,0ffh,0,0,46h,46h,46h,46h,56h,56h,7eh,7eh,6eh,6eh       ; 5879 3f f1 ff 00 00 46 46 46 46 56 56 7e 7e 6e 6e   ?q...FFFFVV..nn
        .db     46h,46h,0,0,0,0,3ch,3ch,18h,18h,18h,18h,18h,18h,18h,18h ; 5888 46 46 00 00 00 00 3c 3c 18 18 18 18 18 18 18 18   FF....<<........
        .db     3ch,3ch,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,2,1,1,0,0 ; 5898 3c 3c 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02 02 01 01 00 00   <<........................
        .db     0,0,0,0,0,0,0,0,0,0,40h,7fh,0c0h,0ffh,20h,3fh,22h,3fh,11h       ; 58b2 00 00 00 00 00 00 00 00 00 00 40 7f c0 ff 20 3f 22 3f 11   ..........@.@. ?"?.
        .db     1fh,72h,7eh,0bfh,0bfh,0ffh,0ffh,7,7,6,7,6,7,6,7,7,7,0,0 ; 58c5 1f 72 7e bf bf ff ff 07 07 06 07 06 07 06 07 07 07 00 00   .r.??..............
        .db     0,0,0,0,0c0h,0ffh,0,0ffh,0,0ffh,2,0ffh,0ffh,0ffh,0,0,0,0        ; 58d8 00 00 00 00 c0 ff 00 ff 00 ff 02 ff ff ff 00 00 00 00   ....@.............
        .db     0,0,2,2,1,1,0,0,0,0,0,0,0,0,0,0,0,0,40h,7fh,0c0h,0ffh,20h       ; 58ea 00 00 02 02 01 01 00 00 00 00 00 00 00 00 00 00 00 00 40 7f c0 ff 20   ..................@.@. 
        .db     3fh,20h,3fh,11h,1fh,72h,7eh,0ffh,0ffh,0ffh,0ffh,2,0feh,2        ; 5901 3f 20 3f 11 1f 72 7e ff ff ff ff 02 fe 02   ? ?..r........
        .db     0feh,4,0fch,4,0fch,88h,0f8h,4eh,7eh,0ffh,0ffh,0ffh,0ffh ; 590f fe 04 fc 04 fc 88 f8 4e 7e ff ff ff ff   ..|.|.xN.....
        .db     0,0,0,0,80h,80h,40h,40h,0,0,0,0,0,0,7,7,0,0,0,0,0ffh,0,0fdh     ; 591c 00 00 00 00 80 80 40 40 00 00 00 00 00 00 07 07 00 00 00 00 ff 00 fd   ......@@..............}
        .db     2,0cdh,32h,9,0f6h,8,0f7h,0,0ffh,0,0,0,0,0ffh,0,0ffh,0,0ffh      ; 5933 02 cd 32 09 f6 08 f7 00 ff 00 00 00 00 ff 00 ff 00 ff   .M2.v.w...........
        .db     0,0fch,3,0cch,33h,8,0f7h,7ch,44h,3fh,3fh,10h,1fh,10h,1fh        ; 5945 00 fc 03 cc 33 08 f7 7c 44 3f 3f 10 1f 10 1f   .|.L3.w|D??....
        .db     12h,1fh,19h,1fh,3fh,3fh,3eh,3eh,0ceh,0f2h,8eh,0dah,9,0f9h       ; 5954 12 1f 19 1f 3f 3f 3e 3e ce f2 8e da 09 f9   ....??>>Nr.Z.y
        .db     9,0f9h,4eh,0feh,98h,0f8h,0fch,0fch,7ch,7ch,7,7,1fh,18h,3eh      ; 5962 09 f9 4e fe 98 f8 fc fc 7c 7c 07 07 1f 18 3e   .yN..x||||....>
        .db     20h,7fh,4fh,7fh,5fh,70h,70h,0a2h,0a2h,0b0h,0b0h,0,0,46h ; 5971 20 7f 4f 7f 5f 70 70 a2 a2 b0 b0 00 00 46    .O._pp""00..F
        .db     46h,66h,66h,76h,76h,5eh,5eh,4eh,4eh,46h,46h,0,0,0,0,18h ; 597f 46 66 66 76 76 5e 5e 4e 4e 46 46 00 00 00 00 18   Fffvv^^NNFF.....
        .db     18h,18h,18h,18h,18h,18h,18h,0,0,18h,18h,0,0,12h,1eh,12h ; 598f 18 18 18 18 18 18 18 00 00 18 18 00 00 12 1e 12   ................
        .db     1eh,12h,1eh,12h,1eh,7eh,7eh,0bfh,83h,0ffh,81h,0ffh,0ffh ; 599f 1e 12 1e 12 1e 7e 7e bf 83 ff 81 ff ff   .......?.....
        .db     0,0,0e0h,0e0h,18h,0f8h,4,0fch,0ch,0fch,0f8h,0c8h,2ch,34h        ; 59ac 00 00 e0 e0 18 f8 04 fc 0c fc f8 c8 2c 34   ..``.x.|.|xH,4
        .db     2eh,32h,0,0,46h,46h,46h,46h,46h,46h,46h,46h,2ch,2ch,18h ; 59ba 2e 32 00 00 46 46 46 46 46 46 46 46 2c 2c 18   .2..FFFFFFFF,,.
        .db     18h,0,0,0,0,36h,36h,5fh,49h,5fh,41h,7fh,41h,3eh,22h,1ch ; 59c9 18 00 00 00 00 36 36 5f 49 5f 41 7f 41 3e 22 1c   .....66_I_A.A>".
        .db     14h,8,8,0feh,2,0fdh,5,0fdh,5,0ffh,1fh,0ffh,0fch,0ffh,0feh       ; 59d9 14 08 08 fe 02 fd 05 fd 05 ff 1f ff fc ff fe   .....}.}....|..
        .db     0efh,38h,0efh,39h,0,4,0,4,0,4,1,5,1,5,3,7,6,6,0ch,0ch,0cah      ; 59e8 ef 38 ef 39 00 04 00 04 00 04 01 05 01 05 03 07 06 06 0c 0c ca   o8o9................J
        .db     0c0h,0c8h,0c0h,0cah,0c0h,88h,80h,88h,87h,8,0,0ah,0,8,0,6fh      ; 59fd c0 c8 c0 ca c0 88 80 88 87 08 00 0a 00 08 00 6f   @H@J@..........o
        .db     13h,2fh,13h,6fh,13h,2fh,11h,2dh,0d1h,2ch,10h,6ch,10h,2ch        ; 5a0d 13 2f 13 6f 13 2f 11 2d d1 2c 10 6c 10 2c   ./.o./.-Q,.l.,
        .db     10h,0a0h,20h,0a0h,20h,0a0h,20h,0a0h,0a0h,0a0h,0a0h,0e0h ; 5a1b 10 a0 20 a0 20 a0 20 a0 a0 a0 a0 e0   .          `
        .db     0e0h,60h,60h,30h,30h,8,0a8h,8,18h,8,0a8h,8,48h,8,0a8h,8 ; 5a27 e0 60 60 30 30 08 a8 08 18 08 a8 08 48 08 a8 08   ```00.(...(.H.(.
        .db     18h,8,0a8h,8,48h,0,0feh,0,0ffh,7fh,0ffh,7fh,0c1h,7fh,0c1h       ; 5a37 18 08 a8 08 48 00 fe 00 ff 7f ff 7f c1 7f c1   ..(.H.......A.A
        .db     7fh,0ebh,7fh,0c1h,1,0ffh,0,0,0,0,0,0,0ffh,0,0,0,0ffh,0,0        ; 5a46 7f eb 7f c1 01 ff 00 00 00 00 00 00 ff 00 00 00 ff 00 00   .k.A...............
        .db     0,0ffh,0,10h,10h,0bh,0bh,7,4,7,4,3,2,1,1,0,0,0,0,0b4h,0b4h      ; 5a59 00 ff 00 10 10 0b 0b 07 04 07 04 03 02 01 01 00 00 00 00 b4 b4   ...................44
        .db     0e4h,0e4h,0bch,0bch,0eeh,6eh,0e7h,27h,0f0h,10h,0fch,9ch ; 5a6e e4 e4 bc bc ee 6e e7 27 f0 10 fc 9c   dd<<nng'p.|.
        .db     77h,5fh,0,0,0,0,7,7,1fh,18h,3fh,20h,7fh,40h,7fh,40h,7fh ; 5a7a 77 5f 00 00 00 00 07 07 1f 18 3f 20 7f 40 7f 40 7f   w_........? .@.@.
        .db     40h,0,0,0,0,0,0,80h,80h,0c0h,40h,0c0h,40h,0c0h,40h,80h,80h      ; 5a8b 40 00 00 00 00 00 00 80 80 c0 40 c0 40 c0 40 80 80   @........@@@@@@..
        .db     2,3,5,4,7,4,4,7,4,7,4,6,4,5,4,7,0ceh,0fah,0ch,0fch,8,0f8h       ; 5a9c 02 03 05 04 07 04 04 07 04 07 04 06 04 05 04 07 ce fa 0c fc 08 f8   ................Nz.|.x
        .db     8,0f8h,8,0f8h,8,0f8h,8,0f8h,88h,0f8h,0,3ch,0,7eh,10h,67h        ; 5ab2 08 f8 08 f8 08 f8 08 f8 88 f8 00 3c 00 7e 10 67   .x.x.x.x.x.<...g
        .db     24h,0c3h,24h,0c3h,24h,0c3h,24h,0c3h,34h,0c3h,0,3ch,0,66h        ; 5ac2 24 c3 24 c3 24 c3 24 c3 34 c3 00 3c 00 66   $C$C$C$C4C.<.f
        .db     0,0e7h,2ch,0c3h,3ch,0c3h,3ch,0c3h,3ch,42h,18h,66h,0,0,0 ; 5ad0 00 e7 2c c3 3c c3 3c c3 3c 42 18 66 00 00 00   .g,C<C<C<B.f...
        .db     0,0,0,20h,20h,90h,90h,0b8h,0a8h,0a8h,0a8h,10h,10h,0ah,10h       ; 5adf 00 00 00 20 20 90 90 b8 a8 a8 a8 10 10 0a 10   ...  ..8(((....
        .db     6,8,2,4,0,4,0,4,0,4,0,4,0,4,17h,50h,28h,60h,2ah,60h,28h ; 5aee 06 08 02 04 00 04 00 04 00 04 00 04 00 04 17 50 28 60 2a 60 28   ...............P(`*`(
        .db     60h,2ah,60h,28h,60h,28h,67h,68h,60h,0deh,2bh,2eh,17h,6eh        ; 5b03 60 2a 60 28 60 28 67 68 60 de 2b 2e 17 6e   `*`(`(gh`^+..n
        .db     17h,2eh,17h,6eh,17h,2eh,17h,2eh,0d7h,2eh,17h,98h,48h,0b0h       ; 5b11 17 2e 17 6e 17 2e 17 2e d7 2e 17 98 48 b0   ...n....W...H0
        .db     50h,0a0h,60h,0a0h,20h,0a0h,20h,0a0h,20h,0a0h,20h,0a0h,20h       ; 5b1f 50 a0 60 a0 20 a0 20 a0 20 a0 20 a0 20   P `          
        .db     8,0a8h,8,18h,8,0a8h,8,48h,8,0b8h,8,3fh,8,0bfh,9,7fh,0,7fh       ; 5b2c 08 a8 08 18 08 a8 08 48 08 b8 08 3f 08 bf 09 7f 00 7f   .(...(.H.8.?.?....
        .db     0,0ffh,7eh,0ffh,7eh,0c1h,7eh,0c1h,7eh,0ebh,7eh,0c1h,0,0ffh      ; 5b3e 00 ff 7e ff 7e c1 7e c1 7e eb 7e c1 00 ff   .....A.A.k.A..
        .db     0,0,0,0,0ffh,0,0ffh,0,0ffh,0,0ffh,0,0ffh,0,0ffh,0,0,0,38h       ; 5b4c 00 00 00 00 ff 00 ff 00 ff 00 ff 00 ff 00 ff 00 00 00 38   ..................8
        .db     38h,34h,24h,3ch,24h,3fh,27h,3ch,27h,3ch,27h,3fh,2fh,37h ; 5b5f 38 34 24 3c 24 3f 27 3c 27 3c 27 3f 2f 37   84$<$?'<'<'?/7
        .db     3ch,17h,14h,17h,1fh,1ch,1fh,0f0h,0ffh,0,0ffh,2,0ffh,0ffh        ; 5b6d 3c 17 14 17 1f 1c 1f f0 ff 00 ff 02 ff ff   <......p......
        .db     0ffh,0bfh,0a0h,0bfh,0a0h,0bfh,0b8h,7fh,7fh,2fh,2fh,7fh,7fh      ; 5b7b ff bf a0 bf a0 bf b8 7f 7f 2f 2f 7f 7f   .? ? ?8..//..
        .db     0f7h,9ch,0f7h,9ch,0fdh,5,0fdh,5,0fdh,1dh,0ffh,0ffh,0f7h ; 5b88 f7 9c f7 9c fd 05 fd 05 fd 1d ff ff f7   w.w.}.}.}...w
        .db     0f4h,0ffh,0feh,0efh,38h,0efh,38h,1,1,1,1,1,1,2,2,2,2,2,2        ; 5b95 f4 ff fe ef 38 ef 38 01 01 01 01 01 01 02 02 02 02 02 02   t..o8o8............
        .db     1,1,0,0,2,2,2,2,1,1,0,0,0,0,0,0,0,0,0,0,34h,0c3h,3ch,43h        ; 5ba8 01 01 00 00 02 02 02 02 01 01 00 00 00 00 00 00 00 00 00 00 34 c3 3c 43   ....................4C<C
        .db     3ch,43h,18h,66h,18h,66h,8,76h,8,36h,8,34h,18h,26h,18h,24h       ; 5bc0 3c 43 18 66 18 66 08 76 08 36 08 34 18 26 18 24   <C.f.f.v.6.4.&.$
        .db     18h,24h,8,34h,0,18h,0,8,0,8,0,8,0,0,0fh,0fh,1fh,10h,3ch ; 5bd0 18 24 08 34 00 18 00 08 00 08 00 08 00 00 0f 0f 1f 10 3c   .$.4..............<
        .db     20h,70h,40h,73h,43h,67h,4ch,3fh,28h,0,0,80h,80h,0dch,5ch        ; 5be3 20 70 40 73 43 67 4c 3f 28 00 00 80 80 dc 5c    p@sCgL?(....\\
        .db     3eh,22h,32h,0e2h,0b1h,0c1h,0c3h,4bh,27h,7ch,0,0,0,0,0,0 ; 5bf2 3e 22 32 e2 b1 c1 c3 4b 27 7c 00 00 00 00 00 00   >"2b1ACK'|......
        .db     0,0,0e0h,0e0h,0d0h,10h,0d0h,0d0h,0e0h,20h,5ch,50h,7ch,50h       ; 5c02 00 00 e0 e0 d0 10 d0 d0 e0 20 5c 50 7c 50   ..``P.PP` \P|P
        .db     39h,30h,7ch,4ch,0eeh,82h,0c0h,84h,60h,43h,31h,26h,1fh,3ch       ; 5c10 39 30 7c 4c ee 82 c0 84 60 43 31 26 1f 3c   90|Ln.@.`C1&.<
        .db     0bbh,62h,0f1h,41h,61h,41h,0c3h,3,0f7h,4,0eeh,8,9ch,60h,90h      ; 5c1e bb 62 f1 41 61 41 c3 03 f7 04 ee 08 9c 60 90   ;bqAaAC.w.n..`.
        .db     10h,8,8,18h,18h,3ch,64h,0f2h,0c2h,0e3h,60h,39h,20h,0f2h ; 5c2d 10 08 08 18 18 3c 64 f2 c2 e3 60 39 20 f2   .....<drBc`9 r
        .db     0,0,0ffh,0,0ffh,0ffh,0ffh,0ffh,0,0ffh,0,0ffh,0,0,0ffh,0 ; 5c3b 00 00 ff 00 ff ff ff ff 00 ff 00 ff 00 00 ff 00   ................
        .db     0ffh,0ffh,0ffh,0ffh,0,0ffh,0ffh,0,0ffh,0,0ffh,0ffh,0ffh ; 5c4b ff ff ff ff 00 ff ff 00 ff 00 ff ff ff   .............
        .db     0ffh,0ffh,0ffh,0ffh,38h,38h,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; 5c58 ff ff ff ff 38 38 00 00 00 00 00 00 00 00 00 00 00 00 00 00   ....88..............
        .db     0,0,0,0,0,0,0,0,0eh,0eh,11h,11h,11h,11h,12h,12h,0f3h,1fh        ; 5c6c 00 00 00 00 00 00 00 00 0e 0e 11 11 11 11 12 12 f3 1f   ................s.
        .db     0f0h,3fh,0f0h,0bfh,60h,7fh,10h,1fh,50h,5fh,30h,3fh,0f1h ; 5c7e f0 3f f0 bf 60 7f 10 1f 50 5f 30 3f f1   p?p?`...P_0?q
        .db     0ffh,0cfh,0fbh,0ch,0fch,8,0f8h,8,0f8h,8,0f8h,8,0f8h,8,0f8h      ; 5c8b ff cf fb 0c fc 08 f8 08 f8 08 f8 08 f8 08 f8   .O{.|.x.x.x.x.x
        .db     88h,0f8h,4eh,7ah,0c9h,0d9h,9,0f9h,0eh,0feh,48h,0f8h,98h ; 5c9a 88 f8 4e 7a c9 d9 09 f9 0e fe 48 f8 98   .xNzIY.y..Hx.
        .db     0f8h,0fch,0fch,7ch,7ch,0a0h,0bfh,40h,7fh,0e0h,0ffh,20h,3fh      ; 5ca7 f8 fc fc 7c 7c a0 bf 40 7f e0 ff 20 3f   x|||| ?@.`. ?
        .db     11h,1fh,72h,7eh,0ffh,0ffh,0ffh,0ffh,0,3ch,0,1ch,0,1ch,0 ; 5cb4 11 1f 72 7e ff ff ff ff 00 3c 00 1c 00 1c 00   ..r......<.....
        .db     18h,0,8,0,0,0,0,0,0,0,0ffh,0,0abh,0,55h,0,0ffh,0,0,0,0,0        ; 5cc3 18 00 08 00 00 00 00 00 00 00 ff 00 ab 00 55 00 ff 00 00 00 00 00   ............+.U.......
        .db     0,0,0,0,15h,0,18h,0,15h,0,12h,0,15h,0,18h,0,15h,0,12h,40h       ; 5cd9 00 00 00 00 15 00 18 00 15 00 12 00 15 00 18 00 15 00 12 40   ...................@
        .db     40h,40h,0c0h,40h,40h,40h,40h,40h,40h,40h,0c0h,40h,40h,40h       ; 5ced 40 40 c0 40 40 40 40 40 40 40 c0 40 40 40   @@@@@@@@@@@@@@
        .db     40h,0eh,32h,0eh,32h,0eh,32h,0eh,32h,0fh,33h,8fh,0b3h,0ceh       ; 5cfb 40 0e 32 0e 32 0e 32 0e 32 0f 33 8f b3 ce   @.2.2.2.2.3.3N
        .db     0f3h,0eeh,73h,0,0,0,0,0,0,0,0,0,0,0,0,80h,80h,0c0h,40h,0        ; 5d09 f3 ee 73 00 00 00 00 00 00 00 00 00 00 00 00 80 80 c0 40 00   sns..............@@.
        .db     0,0,0,80h,80h,47h,47h,1fh,18h,3fh,20h,7fh,40h,7fh,40h,7fh       ; 5d1d 00 00 00 80 80 47 47 1f 18 3f 20 7f 40 7f 40 7f   .....GG..? .@.@.
        .db     40h,0bfh,0a0h,0bfh,0a0h,0bfh,0b8h,7fh,7fh,3fh,3fh,77h,7ch       ; 5d2d 40 bf a0 bf a0 bf b8 7f 7f 3f 3f 77 7c   @? ? ?8..??w|
        .db     0f7h,9ch,0f2h,0e6h,0f2h,0e6h,0f2h,0e6h,0f2h,0e6h,0f2h,0e6h      ; 5d3a f7 9c f2 e6 f2 e6 f2 e6 f2 e6 f2 e6   w.rfrfrfrfrf
        .db     0f2h,0e6h,0f2h,0e6h,0f2h,0e6h,0,0,1,1,1,1,1,1,2,2,2,2,2 ; 5d46 f2 e6 f2 e6 f2 e6 00 00 01 01 01 01 01 01 02 02 02 02 02   rfrfrf.............
        .db     2,1,1,0f3h,9fh,0f0h,1fh,0f0h,3fh,0e0h,0bfh,70h,7fh,10h,1fh      ; 5d59 02 01 01 f3 9f f0 1f f0 3f e0 bf 70 7f 10 1f   ...s.p.p?`?p...
        .db     50h,5fh,31h,3fh,3eh,22h,1fh,1fh,10h,1fh,10h,1fh,12h,1fh ; 5d68 50 5f 31 3f 3e 22 1f 1f 10 1f 10 1f 12 1f   P_1?>"........
        .db     19h,1fh,3fh,3fh,3eh,3eh,12h,1eh,12h,1eh,12h,1eh,12h,1eh ; 5d76 19 1f 3f 3f 3e 3e 12 1e 12 1e 12 1e 12 1e   ..??>>........
        .db     7eh,7eh,0ffh,83h,0ffh,81h,0ffh,0ffh,1,1,1,1,1,1,2,2,2,2 ; 5d84 7e 7e ff 83 ff 81 ff ff 01 01 01 01 01 01 02 02 02 02   ..................
        .db     2,2,1,1,0,0,60h,0e0h,80h,80h,80h,80h,80h,80h,80h,80h,80h        ; 5d96 02 02 01 01 00 00 60 e0 80 80 80 80 80 80 80 80 80   ......``.........
        .db     80h,80h,80h,80h,80h,7,4,7,4,7,4,7,4,7,4,7,4,7,4,7,4,0bh ; 5da7 80 80 80 80 80 07 04 07 04 07 04 07 04 07 04 07 04 07 04 07 04 0b   ......................
        .db     9,0bh,0ah,0fh,0ah,17h,12h,17h,1ch,14h,17h,17h,14h,2fh,24h       ; 5dbd 09 0b 0a 0f 0a 17 12 17 1c 14 17 17 14 2f 24   ............./$
        .db     0,0,70h,70h,8fh,8fh,98h,9fh,0e0h,0ffh,0f0h,9fh,78h,57h,7fh      ; 5dcc 00 00 70 70 8f 8f 98 9f e0 ff f0 9f 78 57 7f   ..pp....`.p.xW.
        .db     4ch,3bh,2fh,0d0h,0dfh,0f0h,0ffh,0c0h,0ffh,0c0h,0ffh,0ffh        ; 5ddb 4c 3b 2f d0 df f0 ff c0 ff c0 ff ff   L;/P_p.@.@..
        .db     0ffh,0,0,0,0,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0f8h,0f8h       ; 5de7 ff 00 00 00 00 ff ff ff ff ff ff ff f8 f8   ............xx
        .db     0f0h,0f2h,0e1h,0f5h,0e3h,0f2h,0e6h,0ffh,0ffh,0ffh,81h,0c3h      ; 5df5 f0 f2 e1 f5 e3 f2 e6 ff ff ff 81 c3   praucrf....C
        .db     81h,0dfh,85h,0dfh,85h,0ffh,0bdh,0ffh,81h,0ffh,0ffh,0ffh ; 5e01 81 df 85 df 85 ff bd ff 81 ff ff ff   ._._..=.....
        .db     0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,1fh,1fh,0fh,4fh,87h,0afh,0c7h     ; 5e0d ff ff ff ff ff ff 1f 1f 0f 4f 87 af c7   .........O./G
        .db     4fh,67h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0,0,0,0,0ffh ; 5e1a 4f 67 ff ff ff ff ff ff ff 00 00 00 00 ff   Og............
        .db     0ffh,0ffh,0,0,4fh,67h,4fh,67h,4fh,67h,4fh,67h,4fh,67h,4fh       ; 5e28 ff ff 00 00 4f 67 4f 67 4f 67 4f 67 4f 67 4f   ....OgOgOgOgOgO
        .db     67h,4fh,67h,4fh,67h,0f2h,0e6h,0f5h,0e3h,0f2h,0e1h,0f8h,0f0h     ; 5e37 67 4f 67 4f 67 f2 e6 f5 e3 f2 e1 f8 f0   gOgOgrfucraxp
        .db     0ffh,0f8h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0,0,0ffh,0ffh,0 ; 5e44 ff f8 ff ff ff ff ff ff 00 00 ff ff 00   .x...........
        .db     0ffh,0,0,0ffh,0,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,4fh,67h,0afh      ; 5e51 ff 00 00 ff 00 ff ff ff ff ff ff 4f 67 af   ...........Og/
        .db     0c7h,4fh,87h,1fh,0fh,0ffh,1fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh     ; 5e5f c7 4f 87 1f 0f ff 1f ff ff ff ff ff ff   GO...........
        .db     0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0,0,0,0,0efh,0e7h,0cfh       ; 5e6c ff ff ff ff ff ff ff 00 00 00 00 ef e7 cf   ...........ogO
        .db     24h,0ch,24h,0ch,24h,0ch,24h,0ch,24h,0ch,24h,0ch,24h,0ch ; 5e7a 24 0c 24 0c 24 0c 24 0c 24 0c 24 0c 24 0c   $.$.$.$.$.$.$.
        .db     24h,0ch,24h,0ch,24h,0ch,0e7h,0cfh,0,0efh,0,0,0ffh,0,0ffh        ; 5e88 24 0c 24 0c 24 0c e7 cf 00 ef 00 00 ff 00 ff   $.$.$.gO.o.....
        .db     0ffh,0ffh,0ffh,0ffh,0ffh,7,7,18h,1fh,21h,3eh,47h,7fh,5fh        ; 5e97 ff ff ff ff ff 07 07 18 1f 21 3e 47 7f 5f   .........!>G._
        .db     7fh,39h,30h,7bh,62h,0fbh,0b2h,0e0h,0e0h,18h,0f8h,84h,7ch        ; 5ea5 7f 39 30 7b 62 fb b2 e0 e0 18 f8 84 7c   .90{b{2``.x.|
        .db     0e2h,0feh,0fah,0feh,9ch,0ch,0deh,46h,0dfh,4dh,0ffh,0a0h ; 5eb2 e2 fe fa fe 9c 0c de 46 df 4d ff a0   b.z...^F_M. 
        .db     0ffh,0c2h,7fh,54h,7fh,5ch,3fh,2eh,3fh,23h,1fh,18h,7,7,0ffh      ; 5ebe ff c2 7f 54 7f 5c 3f 2e 3f 23 1f 18 07 07 ff   .B.T.\?.?#.....
        .db     5,0ffh,43h,0feh,2ah,0feh,3ah,0fch,74h,0fch,0c4h,0f8h,18h        ; 5ecd 05 ff 43 fe 2a fe 3a fc 74 fc c4 f8 18   ..C.*.:|t|Dx.
        .db     0e0h,0e0h,7,7,1fh,18h,3eh,20h,7fh,4fh,7fh,5fh,70h,70h,0a2h      ; 5eda e0 e0 07 07 1f 18 3e 20 7f 4f 7f 5f 70 70 a2   ``....> .O._pp"
        .db     0a2h,0b0h,0b0h,0e0h,0e0h,0f8h,18h,7ch,4,0feh,0f2h,0feh,0fah     ; 5ee9 a2 b0 b0 e0 e0 f8 18 7c 04 fe f2 fe fa   "00``x.|..r.z
        .db     0eh,0eh,45h,45h,0dh,0dh,0b4h,0b4h,64h,64h,3ch,3ch,2eh,2eh       ; 5ef6 0e 0e 45 45 0d 0d b4 b4 64 64 3c 3c 2e 2e   ..EE..44dd<<..
        .db     27h,27h,10h,10h,0ch,0ch,3,3,2dh,2dh,26h,26h,3ch,3ch,74h ; 5f04 27 27 10 10 0c 0c 03 03 2d 2d 26 26 3c 3c 74   ''......--&&<<t
        .db     74h,0e4h,0e4h,8,8,30h,30h,0c0h,0c0h,2fh,24h,2fh,24h,2fh ; 5f13 74 e4 e4 08 08 30 30 c0 c0 2f 24 2f 24 2f   tdd..00@@/$/$/
        .db     24h,2fh,24h,67h,7ch,0bch,0a7h,0ffh,0e4h,1bh,1bh,0,0,0,0 ; 5f21 24 2f 24 67 7c bc a7 ff e4 1b 1b 00 00 00 00   $/$g|<'.d......
        .db     1,1,1,1,3,3,3,3,3,2,7,4,4,7,7,4,7,4,4,4,6,6,5,5,5,5,6,6 ; 5f30 01 01 01 01 03 03 03 03 03 02 07 04 04 07 07 04 07 04 04 04 06 06 05 05 05 05 06 06   ............................
        .db     7,4,7,4,4,7,4,4,4,4,7,7,7,7,6,6,6,6,6,6,4,4,7,7,5,5,3,3 ; 5f4c 07 04 07 04 04 07 04 04 04 04 07 07 07 07 06 06 06 06 06 06 04 04 07 07 05 05 03 03   ............................
        .db     5,5,0eh,0eh,0fh,1fh,1,10h,1,10h,1,10h,1,8,1,7,4,9,0,0fh ; 5f68 05 05 0e 0e 0f 1f 01 10 01 10 01 10 01 08 01 07 04 09 00 0f   ....................
        .db     8,1,0f8h,0f1h,4eh,0c1h,2,0c7h,8ch,0bdh,84h,0adh,62h,0cfh        ; 5f7c 08 01 f8 f1 4e c1 02 c7 8c bd 84 ad 62 cf   ..xqNA.G.=.-bO
        .db     7eh,0feh,0ech,90h,0efh,9fh,0fah,0f7h,0dah,0e7h,0bdh,0bdh        ; 5f8a 7e fe ec 90 ef 9f fa f7 da e7 bd bd   ..l.o.zwZg==
        .db     0b5h,0adh,0d2h,0efh,7fh,7fh,0f8h,0f8h,18h,0e8h,38h,88h,0b8h     ; 5f96 b5 ad d2 ef 7f 7f f8 f8 18 e8 38 88 b8   5-Ro..xx.h8.8
        .db     8,0b0h,10h,0e0h,0e0h,0d0h,30h,0f0h,0f0h,18h,18h,30h,30h ; 5fa3 08 b0 10 e0 e0 d0 30 f0 f0 18 18 30 30   .0.``P0pp..00
        .db     60h,60h,0c0h,0c0h,0c0h,0c0h,0ffh,0ffh,83h,83h,60h,62h,0ah       ; 5fb0 60 60 c0 c0 c0 c0 ff ff 83 83 60 62 0a   ``@@@@....`b.
        .db     0,8,0,8,7,8,0,8,1,0f8h,0f1h,0f8h,0f1h,8,1,6ch,10h,2ch,10h       ; 5fbd 00 08 00 08 07 08 00 08 01 f8 f1 f8 f1 08 01 6c 10 2c 10   .........xqxq..l.,.
        .db     2ch,0d1h,2ch,11h,0ach,90h,0efh,9fh,0efh,9fh,0ech,90h,18h        ; 5fd0 2c d1 2c 11 ac 90 ef 9f ef 9f ec 90 18   ,Q,.,.o.o.l..
        .db     18h,0ch,0ch,6,0c6h,3,0c3h,3,3,0ffh,0ffh,0c1h,0c1h,6,46h ; 5fdd 18 0c 0c 06 c6 03 c3 03 03 ff ff c1 c1 06 46   ....F.C....AA.F
        .db     0,4,0,0ch,2,10h,2,10h,2,10h,2,10h,2,10h,2,10h,0ch,4ch,0ch       ; 5fec 00 04 00 0c 02 10 02 10 02 10 02 10 02 10 02 10 0c 4c 0c   .................L.
        .db     4ch,9,49h,0bh,4bh,0ah,4ah,10h,50h,12h,52h,10h,50h,7eh,33h       ; 5fff 4c 09 49 0b 4b 0a 4a 10 50 12 52 10 50 7e 33   L.I.K.J.P.R.P.3
        .db     7eh,33h,0beh,93h,0feh,0d3h,7eh,53h,3eh,0bh,7eh,4bh,3eh,0bh      ; 600e 7e 33 be 93 fe d3 7e 53 3e 0b 7e 4b 3e 0b   .3>..S.S>..K>.
        .db     0a0h,20h,90h,30h,98h,48h,98h,48h,98h,48h,98h,48h,98h,48h        ; 601c a0 20 90 30 98 48 98 48 98 48 98 48 98 48     .0.H.H.H.H.H
        .db     98h,48h,0,0,0,0,0,0,0,0,1,1,1,1,2,2,2,2,2,2,2,2,2,2,0,1 ; 602a 98 48 00 00 00 00 00 00 00 00 01 01 01 01 02 02 02 02 02 02 02 02 02 02 00 01   .H........................
        .db     2,2,2,2,2,2,2,3,2,3,2,2,2,2,2,3,2,2,6,6,0eh,0ah,0eh,0ah ; 6044 02 02 02 02 02 02 02 03 02 03 02 02 02 02 02 03 02 02 06 06 0e 0a 0e 0a   ........................
        .db     0bh,0ah,0bh,0ah,0fh,0ah,0ah,0ah,6,6,0ah,0ah,1ah,12h,1fh ; 605c 0b 0a 0b 0a 0f 0a 0a 0a 06 06 0a 0a 1a 12 1f   ...............
        .db     1fh,0,0,0,0,1fh,1fh,3fh,20h,7fh,47h,7ch,4ch,7ch,4ch,7ch ; 606b 1f 00 00 00 00 1f 1f 3f 20 7f 47 7c 4c 7c 4c 7c   .......? .G|L|L|
        .db     4ch,0,0,0,0,0e0h,0e0h,0f0h,30h,0f8h,18h,0f8h,98h,0f8h,98h       ; 607b 4c 00 00 00 00 e0 e0 f0 30 f8 18 f8 98 f8 98   L....``p0x.x.x.
        .db     0f8h,98h,7fh,4fh,7fh,40h,7fh,4fh,7ch,4ch,7ch,4ch,7ch,7ch        ; 608a f8 98 7f 4f 7f 40 7f 4f 7c 4c 7c 4c 7c 7c   x..O.@.O|L|L||
        .db     0,0,0,0,0f8h,98h,0f8h,18h,0f8h,98h,0f8h,98h,0f8h,98h,0f8h       ; 6098 00 00 00 00 f8 98 f8 18 f8 98 f8 98 f8 98 f8   ....x.x.x.x.x.x
        .db     0f8h,0,0,0,0,0,0,7ch,7ch,4eh,4eh,4eh,4eh,4eh,4eh,4eh,4eh        ; 60a7 f8 00 00 00 00 00 00 7c 7c 4e 4e 4e 4e 4e 4e 4e 4e   x......||NNNNNNNN
        .db     7ch,7ch,0,0,0,0,7eh,7eh,60h,60h,7ch,7ch,60h,60h,60h,60h ; 60b8 7c 7c 00 00 00 00 7e 7e 60 60 7c 7c 60 60 60 60   ||......``||````
        .db     7eh,7eh,0,0,0,0,46h,46h,46h,46h,46h,46h,46h,46h,4eh,4eh ; 60c8 7e 7e 00 00 00 00 46 46 46 46 46 46 46 46 4e 4e   ......FFFFFFFFNN
        .db     3ch,3ch,0,0,0,0,3ch,3ch,66h,66h,60h,60h,60h,60h,66h,66h ; 60d8 3c 3c 00 00 00 00 3c 3c 66 66 60 60 60 60 66 66   <<....<<ff````ff
        .db     3ch,3ch,0,0,0,0,46h,46h,6eh,6eh,7eh,7eh,56h,56h,46h,46h ; 60e8 3c 3c 00 00 00 00 46 46 6e 6e 7e 7e 56 56 46 46   <<....FFnn..VVFF
        .db     46h,46h,0,0,0,0,3ch,3ch,4eh,4eh,4eh,4eh,7eh,7eh,4eh,4eh ; 60f8 46 46 00 00 00 00 3c 3c 4e 4e 4e 4e 7e 7e 4e 4e   FF....<<NNNN..NN
        .db     4eh,4eh,0,0,0ffh,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0        ; 6108 4e 4e 00 00 ff 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   NN.......................
        .db     0,0,0,1,1,0ffh,1,1,0ffh,0ffh,0ffh,0,0,0,0,0,0,0,0,0f0h,0f0h     ; 6121 00 00 00 01 01 ff 01 01 ff ff ff 00 00 00 00 00 00 00 00 f0 f0   ...................pp
        .db     0f0h,0b0h,0f0h,0b0h,0f0h,0f0h,0,0,0,0,7,7,18h,1fh,20h,3fh       ; 6136 f0 b0 f0 b0 f0 f0 00 00 00 00 07 07 18 1f 20 3f   p0p0pp........ ?
        .db     30h,3fh,18h,17h,3fh,2ch,7bh,4fh,70h,5fh,90h,9fh,90h,9fh ; 6146 30 3f 18 17 3f 2c 7b 4f 70 5f 90 9f 90 9f   0?..?,{Op_....
        .db     70h,7fh,11h,1fh,3eh,3eh,3eh,3eh,0,0,7ch,7ch,66h,66h,66h ; 6154 70 7f 11 1f 3e 3e 3e 3e 00 00 7c 7c 66 66 66   p...>>>>..||fff
        .db     66h,7ch,7ch,68h,68h,66h,66h,0,0,0,0,3ch,3ch,66h,66h,66h ; 6163 66 7c 7c 68 68 66 66 00 00 00 00 3c 3c 66 66 66   f||hhff....<<fff
        .db     66h,66h,66h,66h,66h,3ch,3ch,0,0,0,0,60h,60h,60h,60h,60h ; 6173 66 66 66 66 66 3c 3c 00 00 00 00 60 60 60 60 60   fffff<<....`````
        .db     60h,60h,60h,60h,60h,7eh,7eh,0,0,0,0,3ch,3ch,66h,66h,60h ; 6183 60 60 60 60 60 7e 7e 00 00 00 00 3c 3c 66 66 60   `````......<<ff`
        .db     60h,6eh,6eh,66h,66h,3eh,3eh,0,0,0,0eeh,0,0,0ffh,0ffh,0ffh       ; 6193 60 6e 6e 66 66 3e 3e 00 00 00 ee 00 00 ff ff ff   `nnff>>...n.....
        .db     0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0,1,0,2,0,2        ; 61a3 ff ff ff ff ff ff ff ff ff 00 01 00 02 00 02   ...............
        .db     0,4,0,8,0,8,0,10h,0,10h,80h,80h,0c0h,40h,0c0h,40h,0e0h,20h      ; 61b2 00 04 00 08 00 08 00 10 00 10 80 80 c0 40 c0 40 e0 20   ............@@@@` 
        .db     30h,50h,30h,50h,38h,48h,18h,28h,0,0,0,0,0,0,0,0,0,3,0,3 ; 61c4 30 50 30 50 38 48 18 28 00 00 00 00 00 00 00 00 00 03 00 03   0P0P8H.(............
        .db     0,2,0,2,0,0,0,0,0,0,0,0,8,0f8h,8,18h,8,0a8h,8,48h,0,80h ; 61d8 00 02 00 02 00 00 00 00 00 00 00 00 08 f8 08 18 08 a8 08 48 00 80   .............x...(.H..
        .db     0,80h,0,80h,0,80h,0,0,0,0,0,0,0,0,0,20h,0,20h,0,20h,1fh ; 61ee 00 80 00 80 00 80 00 00 00 00 00 00 00 00 00 20 00 20 00 20 1f   ............... . . .
        .db     20h,0,40h,0,40h,0,40h,0,40h,1ch,24h,0ch,34h,0ch,34h,4,0fch      ; 6203 20 00 40 00 40 00 40 00 40 1c 24 0c 34 0c 34 04 fc    .@.@.@.@.$.4.4.|
        .db     0eh,32h,0eh,32h,0eh,32h,0eh,32h,0,0,0,0,0,0,0,0,0,0,0,0 ; 6214 0e 32 0e 32 0e 32 0e 32 00 00 00 00 00 00 00 00 00 00 00 00   .2.2.2.2............
        .db     0,0,0,0,0,0,0,0,0,0,0,0,0,1fh,0,18h,0,15h,0,12h,0,0,0,0 ; 6228 00 00 00 00 00 00 00 00 00 00 00 00 00 1f 00 18 00 15 00 12 00 00 00 00   ........................
        .db     0,0,0,0,40h,0c0h,40h,0c0h,40h,40h,40h,40h,0,2,0,3,0,2,0 ; 6240 00 00 00 00 40 c0 40 c0 40 40 40 40 00 02 00 03 00 02 00   ....@@@@@@@@.......
        .db     2,0,2,0,3,0,2,0,2,8,0afh,8,1ah,8,0adh,8,4fh,8,0a8h,8,18h        ; 6253 02 00 02 00 03 00 02 00 02 08 af 08 1a 08 ad 08 4f 08 a8 08 18   ........../...-.O.(..
        .db     8,0a8h,8,48h,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,2,0,40h,15h,40h      ; 6268 08 a8 08 48 00 00 00 00 00 00 00 00 00 00 00 00 00 01 00 02 00 40 15 40   .(.H.................@.@
        .db     15h,40h,15h,40h,15h,0c0h,15h,0c1h,17h,43h,16h,46h,24h,0ch       ; 6280 15 40 15 40 15 c0 15 c1 17 43 16 46 24 0c   .@.@.@.A.C.F$.
        .db     34h,0ch,34h,4,0fch,0eh,32h,0eh,32h,0eh,32h,0eh,32h,0,0,0        ; 628e 34 0c 34 04 fc 0e 32 0e 32 0e 32 0e 32 00 00 00   4.4.|.2.2.2.2...
        .db     0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2ah,20h,1,0,1dh,1 ; 629e 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 2a 20 01 00 1d 01   ...................* ....
        .db     9,0,7,1,0bh,0,3,20h,4,0,20h,20h,6,0,0ah,80h,17h,0,6,1,6 ; 62b7 09 00 07 01 0b 00 03 20 04 00 20 20 06 00 0a 80 17 00 06 01 06   ....... ..  .........
        .db     0,4,1,5,0,1eh,80h,0bh,0,6,80h,1ch,0,0ah,10h,8,11h,4,1,2 ; 62cc 00 04 01 05 00 1e 80 0b 00 06 80 1c 00 0a 10 08 11 04 01 02   ....................
        .db     0,4,1,6,0,0,10h,6,0,4,10h,5,0,1ah,80h,24h,0,15h,1,7,0,20h       ; 62e0 00 04 01 06 00 00 10 06 00 04 10 05 00 1a 80 24 00 15 01 07 00 20   ...............$..... 
        .db     10h,4,0,5,10h,3,0,0dh,10h,6,0,3,10h,5,0,25h,80h,15h,0,1bh       ; 62f6 10 04 00 05 10 03 00 0d 10 06 00 03 10 05 00 25 80 15 00 1b   ...............%....
        .db     10h,4,0,13h,80h,3,0,1ch,80h,19h,0,1ah,1,6,0,0ah,20h,1,0 ; 630a 10 04 00 13 80 03 00 1c 80 19 00 1a 01 06 00 0a 20 01 00   ................ ..
        .db     9,20h,2,0,14h,10h,3,0,0eh,80h,16h,0,0ah,10h,0ah,11h,6,10h       ; 631d 09 20 02 00 14 10 03 00 0e 80 16 00 0a 10 0a 11 06 10   . ................
        .db     16h,0,13h,80h,25h,0,1ch,1,6,0,3,20h,2,0,0eh,20h,3,0,4,20h       ; 632f 16 00 13 80 25 00 1c 01 06 00 03 20 02 00 0e 20 03 00 04 20   ....%...... ... ... 
        .db     2,0,3,20h,5,0,0dh,80h,21h,0,13h,1,7,0,5,1,6,0,4,1,5,0,6 ; 6343 02 00 03 20 05 00 0d 80 21 00 13 01 07 00 05 01 06 00 04 01 05 00 06   ... ....!..............
        .db     20h,3,0,5,20h,2,0,1ch,20h,3,0,0eh,80h,12h,0,0ch,10h,4,0 ; 635a 20 03 00 05 20 02 00 1c 20 03 00 0e 80 12 00 0c 10 04 00    ... ... ..........
        .db     2,1,8,0,10h,1,8,0,1eh,80h,19h,0,10h,10h,3,0,4,10h,5,0,24h       ; 636d 02 01 08 00 10 01 08 00 1e 80 19 00 10 10 03 00 04 10 05 00 24   ....................$
        .db     80h,1ch,0,5,1,5,0,11h,20h,3,0,12h,80h,20h,0,0ah,10h,1,11h       ; 6382 80 1c 00 05 01 05 00 11 20 03 00 12 80 20 00 0a 10 01 11   ........ .... .....
        .db     6,1,0,0,4,10h,4,0,4,10h,3,0,2,10h,19h,0,4,10h,7,0,0ah,0 ; 6395 06 01 00 00 04 10 04 00 04 10 03 00 02 10 19 00 04 10 07 00 0a 00   ......................
        .db     0,0,0,0,0,0,4dh,20h,8,21h,6,20h,0bh,0,7,20h,6,0,64h,10h ; 63ab 00 00 00 00 00 00 4d 20 08 21 06 20 0b 00 07 20 06 00 64 10   ......M .!. ... ..d.
        .db     0,11h,6,10h,5,0,2fh,80h,16h,0,17h,20h,5,0,6,20h,6,0,10h ; 63bf 00 11 06 10 05 00 2f 80 16 00 17 20 05 00 06 20 06 00 10   ....../.... ... ...
        .db     80h,18h,0,34h,1,5,0,1,10h,0eh,11h,6,10h,20h,0,0ah,80h,0ah       ; 63d2 80 18 00 34 01 05 00 01 10 0e 11 06 10 20 00 0a 80 0a   ...4......... ....
        .db     0,2bh,20h,6,0,6,20h,5,0,5,20h,6,0,0ah,80h,0ch,0,0ah,1,7 ; 63e4 00 2b 20 06 00 06 20 05 00 05 20 06 00 0a 80 0c 00 0a 01 07   .+ ... ... .........
        .db     0,2,10h,0bh,0,5,10h,4,0,0dh,80h,1ch,0,75h,1,6,0,0eh,80h ; 63f8 00 02 10 0b 00 05 10 04 00 0d 80 1c 00 75 01 06 00 0e 80   .............u.....
        .db     1fh,0,1ah,1,6,0,0,10h,7,0,5,10h,6,0,4,10h,8,0,3,10h,8,0 ; 640b 1f 00 1a 01 06 00 00 10 07 00 05 10 06 00 04 10 08 00 03 10 08 00   ......................
        .db     0ch,80h,0fh,0,0ah,1,7,0,0,10h,3dh,0,5,80h,1fh,0,0,0,0,0 ; 6421 0c 80 0f 00 0a 01 07 00 00 10 3d 00 05 80 1f 00 00 00 00 00   ..........=.........
        .db     0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0   ; 6435 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   ...........................
l6450:  .db     10h,18h,0,4,8,0,4,8,8,0,4,14h,10h,8,10h,10h,14h,18h     ; 6450 10 18 00 04 08 00 04 08 08 00 04 14 10 08 10 10 14 18   ..................
        .db     14h,0,0ch,4,18h,0,14h,14h,8,4,4,0ch,0,18h,4,0,8,0ch,0ch ; 6462 14 00 0c 04 18 00 14 14 08 04 04 0c 00 18 04 00 08 0c 0c   ...................
        .db     18h,0,0ch,8,0,18h,10h,14h,14h,18h,8     ; 6475 18 00 0c 08 00 18 10 14 14 18 08   ...........

l6480:  .dw     l65aa,l65c6,l66fc,l6628,l6734,l66af,l65f1,l6654 ; 6480 aa 65 c6 65 fc 66 28 66 34 67 af 66 f1 65 54 66   *eFe|f(f4g/fqeTf
l6490:  .dw     l65b2,l65ce,l6714,l65ce,l65ce,l66c3,l65f7,l6660 ; 6490 b2 65 ce 65 14 67 ce 65 ce 65 c3 66 f7 65 60 66   2eNe.gNeNeCfwe`f
l64a0:  .dw     l67d4,l67dc,l679d,l67a5 ; 64a0 d4 67 dc 67 9d 67 a5 67   Tg\g.g%g
l64a8:  .dw     l67e4,l67e4,l67e4,l67ad ; 64a8 e4 67 e4 67 e4 67 ad 67   dgdgdg-g
l64b0:  .dw     l6f3f,l6f4a,l6f55,l6f60,l6f6b,l6f76,l6f81,l6f8c,l6f97   ; 64b0 3f 6f 4a 6f 55 6f 60 6f 6b 6f 76 6f 81 6f 8c 6f 97 6f   ?oJoUo`okovo.o.o.o
        .dw     l6fa2,l6fad,l6fb8,l6fc3,l6fce,l6fd9,l6fe4,l6fef ; 64c2 a2 6f ad 6f b8 6f c3 6f ce 6f d9 6f e4 6f ef 6f   "o-o8oCoNoYodooo

l64d2:  ret                     ; 64d2 c9   I

l64d3:  push    af              ; 64d3 f5   u
        push    bc              ; 64d4 c5   E
        push    de              ; 64d5 d5   U
        push    hl              ; 64d6 e5   e
        ld      a,(0df7fh)      ; 64d7 fa 7f df   z._
        cp      1               ; 64da fe 01   ..
        jr      z,l6524         ; 64dc 28 46   (F
        cp      2               ; 64de fe 02   ..
        jr      z,l655d         ; 64e0 28 7b   ({
        ld      a,(0df7eh)      ; 64e2 fa 7e df   z._
        and     a               ; 64e5 a7   '
        jr      nz,l6563        ; 64e6 20 7b    {
l64e8:  ldh     a,(0e4h)        ; 64e8 f0 e4   pd
        and     a               ; 64ea a7   '
        jr      z,l64fa         ; 64eb 28 0d   (.
        xor     a               ; 64ed af   /
        ld      (0dfe0h),a      ; 64ee ea e0 df   j`_
        ld      (0dfe8h),a      ; 64f1 ea e8 df   jh_
        ld      (0dff0h),a      ; 64f4 ea f0 df   jp_
        ld      (0dff8h),a      ; 64f7 ea f8 df   jx_
l64fa:  call    l64d2           ; 64fa cd d2 64   MRd
        call    l69dd           ; 64fd cd dd 69   M]i
        call    l69fd           ; 6500 cd fd 69   M}i
        call    l683c           ; 6503 cd 3c 68   M<h
        call    l6a21           ; 6506 cd 21 6a   M!j
        call    l6c44           ; 6509 cd 44 6c   MDl
        call    l6a65           ; 650c cd 65 6a   Mej
l650f:  xor     a               ; 650f af   /
        ld      (0dfe0h),a      ; 6510 ea e0 df   j`_
        ld      (0dfe8h),a      ; 6513 ea e8 df   jh_
        ld      (0dff0h),a      ; 6516 ea f0 df   jp_
        ld      (0dff8h),a      ; 6519 ea f8 df   jx_
        ld      (0df7fh),a      ; 651c ea 7f df   j._
        pop     hl              ; 651f e1   a
        pop     de              ; 6520 d1   Q
        pop     bc              ; 6521 c1   A
        pop     af              ; 6522 f1   q
        ret                     ; 6523 c9   I

l6524:  call    l69c7           ; 6524 cd c7 69   MGi
        xor     a               ; 6527 af   /
        ld      (0dfe1h),a      ; 6528 ea e1 df   ja_
        ld      (0dff1h),a      ; 652b ea f1 df   jq_
        ld      (0dff9h),a      ; 652e ea f9 df   jy_
        ld      hl,0dfbfh       ; 6531 21 bf df   !?_
        res     7,(hl)          ; 6534 cb be   K>
        ld      hl,0df9fh       ; 6536 21 9f df   !._
        res     7,(hl)          ; 6539 cb be   K>
        ld      hl,0dfafh       ; 653b 21 af df   !/_
        res     7,(hl)          ; 653e cb be   K>
        ld      hl,0dfcfh       ; 6540 21 cf df   !O_
        res     7,(hl)          ; 6543 cb be   K>
        ld      hl,l6ee9        ; 6545 21 e9 6e   !in
        call    l6998           ; 6548 cd 98 69   M.i
        ld      a,30h           ; 654b 3e 30   >0
        ld      (0df7eh),a      ; 654d ea 7e df   j._
l6550:  ld      hl,l657b        ; 6550 21 7b 65   !{e
l6553:  call    l695d           ; 6553 cd 5d 69   M]i
        jr      l650f           ; 6556 18 b7   .7

l6558:  ld      hl,l657f        ; 6558 21 7f 65   !.e
        jr      l6553           ; 655b 18 f6   .v

l655d:  xor     a               ; 655d af   /
        ld      (0df7eh),a      ; 655e ea 7e df   j._
        jr      l64e8           ; 6561 18 85   ..

l6563:  ld      hl,0df7eh       ; 6563 21 7e df   !._
        dec     (hl)            ; 6566 35   5
        ld      a,(hl)          ; 6567 7e   .
        cp      28h             ; 6568 fe 28   .(
        jr      z,l6558         ; 656a 28 ec   (l
        cp      20h             ; 656c fe 20   . 
        jr      z,l6550         ; 656e 28 e0   (`
        cp      18h             ; 6570 fe 18   ..
        jr      z,l6558         ; 6572 28 e4   (d
        cp      10h             ; 6574 fe 10   ..
        jr      nz,l650f        ; 6576 20 97    .
        inc     (hl)            ; 6578 34   4
        jr      l650f           ; 6579 18 94   ..

l657b:  .db     0b2h,0e3h,83h,0c7h      ; 657b b2 e3 83 c7   2c.G
l657f:  .db     0b2h,0e3h,0c1h,0c7h     ; 657f b2 e3 c1 c7   2cAG

l6583:  ld      a,(0dff1h)      ; 6583 fa f1 df   zq_
        cp      1               ; 6586 fe 01   ..
        ret                     ; 6588 c9   I

l6589:  ld      a,(0dfe1h)      ; 6589 fa e1 df   za_
        cp      5               ; 658c fe 05   ..
        ret                     ; 658e c9   I

l658f:  ld      a,(0dfe1h)      ; 658f fa e1 df   za_
        cp      7               ; 6592 fe 07   ..
        ret                     ; 6594 c9   I

l6595:  ld      a,(0dfe1h)      ; 6595 fa e1 df   za_
        cp      8               ; 6598 fe 08   ..
        ret                     ; 659a c9   I

l659b:  .db     0,0b5h,0d0h,40h,0c7h    ; 659b 00 b5 d0 40 c7   .5P@G
l65a0:  .db     0,0b5h,20h,40h,0c7h     ; 65a0 00 b5 20 40 c7   .5 @G
l65a5:  .db     0,0b6h,0a1h,80h,0c7h    ; 65a5 00 b6 a1 80 c7   .6!.G

l65aa:  ld      a,5             ; 65aa 3e 05   >.
        ld      hl,l659b        ; 65ac 21 9b 65   !.e
        jp      l6936           ; 65af c3 36 69   C6i

l65b2:  call    l698b           ; 65b2 cd 8b 69   M.i
        and     a               ; 65b5 a7   '
        ret     nz              ; 65b6 c0   @
        ld      hl,0dfe4h       ; 65b7 21 e4 df   !d_
        inc     (hl)            ; 65ba 34   4
        ld      a,(hl)          ; 65bb 7e   .
        cp      2               ; 65bc fe 02   ..
        jr      z,l65d3         ; 65be 28 13   (.
        ld      hl,l65a0        ; 65c0 21 a0 65   ! e
        jp      l6956           ; 65c3 c3 56 69   CVi

l65c6:  ld      a,3             ; 65c6 3e 03   >.
        ld      hl,l65a5        ; 65c8 21 a5 65   !%e
        jp      l6936           ; 65cb c3 36 69   C6i

l65ce:  call    l698b           ; 65ce cd 8b 69   M.i
        and     a               ; 65d1 a7   '
        ret     nz              ; 65d2 c0   @
l65d3:  xor     a               ; 65d3 af   /
        ld      (0dfe1h),a      ; 65d4 ea e1 df   ja_
        ldh     (10h),a         ; 65d7 e0 10   `.
        ld      a,8             ; 65d9 3e 08   >.
        ldh     (12h),a         ; 65db e0 12   `.
        ld      a,80h           ; 65dd 3e 80   >.
        ldh     (14h),a         ; 65df e0 14   `.
        ld      hl,0df9fh       ; 65e1 21 9f df   !._
        res     7,(hl)          ; 65e4 cb be   K>
        ret                     ; 65e6 c9   I

l65e7:  .db     0,80h,0e1h,0c1h,87h     ; 65e7 00 80 e1 c1 87   ..aA.
l65ec:  .db     0,80h,0e1h,0ach,87h     ; 65ec 00 80 e1 ac 87   ..a,.

l65f1:  ld      hl,l65e7        ; 65f1 21 e7 65   !ge
        jp      l6936           ; 65f4 c3 36 69   C6i

l65f7:  ld      hl,0dfe4h       ; 65f7 21 e4 df   !d_
        inc     (hl)            ; 65fa 34   4
        ld      a,(hl)          ; 65fb 7e   .
        cp      4               ; 65fc fe 04   ..
        jr      z,l6617         ; 65fe 28 17   (.
        cp      0bh             ; 6600 fe 0b   ..
        jr      z,l661d         ; 6602 28 19   (.
        cp      0fh             ; 6604 fe 0f   ..
        jr      z,l6617         ; 6606 28 0f   (.
        cp      18h             ; 6608 fe 18   ..
        jp      z,l660e         ; 660a ca 0e 66   J.f
        ret                     ; 660d c9   I

l660e:  ld      a,1             ; 660e 3e 01   >.
        ld      hl,0dff0h       ; 6610 21 f0 df   !p_
        ld      (hl),a          ; 6613 77   w
        jp      l65d3           ; 6614 c3 d3 65   CSe

l6617:  ld      hl,l65ec        ; 6617 21 ec 65   !le
        jp      l6956           ; 661a c3 56 69   CVi

l661d:  ld      hl,l65e7        ; 661d 21 e7 65   !ge
        jp      l6956           ; 6620 c3 56 69   CVi

l6623:  .db     48h,0bch,42h,66h,87h    ; 6623 48 bc 42 66 87   H<Bf.

l6628:  call    l6583           ; 6628 cd 83 65   M.e
        ret     z               ; 662b c8   H
        call    l6595           ; 662c cd 95 65   M.e
        ret     z               ; 662f c8   H
        call    l658f           ; 6630 cd 8f 65   M.e
        ret     z               ; 6633 c8   H
        call    l6589           ; 6634 cd 89 65   M.e
        ret     z               ; 6637 c8   H
        ld      a,2             ; 6638 3e 02   >.
        ld      hl,l6623        ; 663a 21 23 66   !#f
        jp      l6936           ; 663d c3 36 69   C6i

l6640:  .db     0,0b0h,0f1h,0b6h,0c7h   ; 6640 00 b0 f1 b6 c7   .0q6G
l6645:  .db     0,0b0h,0f1h,0c4h,0c7h   ; 6645 00 b0 f1 c4 c7   .0qDG
l664a:  .db     0,0b0h,0f1h,0ceh,0c7h   ; 664a 00 b0 f1 ce c7   .0qNG
l664f:  .db     0,0b0h,0f1h,0dbh,0c7h   ; 664f 00 b0 f1 db c7   .0q[G

l6654:  call    l658f           ; 6654 cd 8f 65   M.e
        ret     z               ; 6657 c8   H
        ld      a,7             ; 6658 3e 07   >.
        ld      hl,l6640        ; 665a 21 40 66   !@f
        jp      l6936           ; 665d c3 36 69   C6i

l6660:  call    l698b           ; 6660 cd 8b 69   M.i
        and     a               ; 6663 a7   '
        ret     nz              ; 6664 c0   @
        ld      hl,0dfe4h       ; 6665 21 e4 df   !d_
        inc     (hl)            ; 6668 34   4
        ld      a,(hl)          ; 6669 7e   .
        cp      1               ; 666a fe 01   ..
        jr      z,l6680         ; 666c 28 12   (.
        cp      2               ; 666e fe 02   ..
        jr      z,l6685         ; 6670 28 13   (.
        cp      3               ; 6672 fe 03   ..
        jr      z,l668a         ; 6674 28 14   (.
        cp      4               ; 6676 fe 04   ..
        jr      z,l668f         ; 6678 28 15   (.
        cp      5               ; 667a fe 05   ..
        jp      z,l65d3         ; 667c ca d3 65   JSe
        ret                     ; 667f c9   I

l6680:  ld      hl,l6645        ; 6680 21 45 66   !Ef
        jr      l6692           ; 6683 18 0d   ..

l6685:  ld      hl,l664a        ; 6685 21 4a 66   !Jf
        jr      l6692           ; 6688 18 08   ..

l668a:  ld      hl,l664f        ; 668a 21 4f 66   !Of
        jr      l6692           ; 668d 18 03   ..

l668f:  ld      hl,l6640        ; 668f 21 40 66   !@f
l6692:  jp      l6956           ; 6692 c3 56 69   CVi

l6695:  .db     3eh,80h,0e3h,0,0c4h     ; 6695 3e 80 e3 00 c4   >.c.D
l669a:  .db     93h,83h,83h,73h,63h,53h,43h,33h,23h,13h,0       ; 669a 93 83 83 73 63 53 43 33 23 13 00   ...scSC3#..
l66a5:  .db     0,23h,43h,63h,83h,0a3h,0c3h,0d3h,0e3h,0ffh      ; 66a5 00 23 43 63 83 a3 c3 d3 e3 ff   .#Cc.#CSc.

l66af:  call    l6583           ; 66af cd 83 65   M.e
        ret     z               ; 66b2 c8   H
        call    l6595           ; 66b3 cd 95 65   M.e
        ret     z               ; 66b6 c8   H
        call    l658f           ; 66b7 cd 8f 65   M.e
        ret     z               ; 66ba c8   H
        ld      a,6             ; 66bb 3e 06   >.
        ld      hl,l6695        ; 66bd 21 95 66   !.f
        jp      l6936           ; 66c0 c3 36 69   C6i

l66c3:  call    l698b           ; 66c3 cd 8b 69   M.i
        and     a               ; 66c6 a7   '
        ret     nz              ; 66c7 c0   @
        ld      hl,0dfe4h       ; 66c8 21 e4 df   !d_
        ld      c,(hl)          ; 66cb 4e   N
        inc     (hl)            ; 66cc 34   4
        ld      b,0             ; 66cd 06 00   ..
        ld      hl,l669a        ; 66cf 21 9a 66   !.f
        add     hl,bc           ; 66d2 09   .
        ld      a,(hl)          ; 66d3 7e   .
        and     a               ; 66d4 a7   '
        jp      z,l65d3         ; 66d5 ca d3 65   JSe
        ld      e,a             ; 66d8 5f   _
        ld      hl,l66a5        ; 66d9 21 a5 66   !%f
        add     hl,bc           ; 66dc 09   .
        ld      a,(hl)          ; 66dd 7e   .
        ld      d,a             ; 66de 57   W
        ld      b,86h           ; 66df 06 86   ..
l66e1:  ld      c,12h           ; 66e1 0e 12   ..
        ld      a,e             ; 66e3 7b   {
        ldh     (c),a           ; 66e4 e2   b
        inc     c               ; 66e5 0c   .
        ld      a,d             ; 66e6 7a   z
        ldh     (c),a           ; 66e7 e2   b
        inc     c               ; 66e8 0c   .
        ld      a,b             ; 66e9 78   x
        ldh     (c),a           ; 66ea e2   b
        ret                     ; 66eb c9   I

l66ec:  .db     3bh,80h,0b2h,87h,87h    ; 66ec 3b 80 b2 87 87   ;.2..
l66f1:  .db     0a2h,93h,62h,43h,23h,0  ; 66f1 a2 93 62 43 23 00   ".bC#.
l66f7:  .db     80h,40h,80h,40h,80h     ; 66f7 80 40 80 40 80   .@.@.

l66fc:  call    l6583           ; 66fc cd 83 65   M.e
        ret     z               ; 66ff c8   H
        call    l6595           ; 6700 cd 95 65   M.e
        ret     z               ; 6703 c8   H
        call    l658f           ; 6704 cd 8f 65   M.e
        ret     z               ; 6707 c8   H
        call    l6589           ; 6708 cd 89 65   M.e
        ret     z               ; 670b c8   H
        ld      a,3             ; 670c 3e 03   >.
        ld      hl,l66ec        ; 670e 21 ec 66   !lf
        jp      l6936           ; 6711 c3 36 69   C6i

l6714:  call    l698b           ; 6714 cd 8b 69   M.i
        and     a               ; 6717 a7   '
        ret     nz              ; 6718 c0   @
        ld      hl,0dfe4h       ; 6719 21 e4 df   !d_
        ld      c,(hl)          ; 671c 4e   N
        inc     (hl)            ; 671d 34   4
        ld      b,0             ; 671e 06 00   ..
        ld      hl,l66f1        ; 6720 21 f1 66   !qf
        add     hl,bc           ; 6723 09   .
        ld      a,(hl)          ; 6724 7e   .
        and     a               ; 6725 a7   '
        jp      z,l65d3         ; 6726 ca d3 65   JSe
        ld      e,a             ; 6729 5f   _
        ld      hl,l66f7        ; 672a 21 f7 66   !wf
        add     hl,bc           ; 672d 09   .
        ld      a,(hl)          ; 672e 7e   .
        ld      d,a             ; 672f 57   W
        ld      b,87h           ; 6730 06 87   ..
        jr      l66e1           ; 6732 18 ad   .-

l6734:  call    l658f           ; 6734 cd 8f 65   M.e
        ret     z               ; 6737 c8   H
        ld      a,28h           ; 6738 3e 28   >(
        ld      hl,l6740        ; 673a 21 40 67   !@g
        jp      l6936           ; 673d c3 36 69   C6i

l6740:  .db     0b7h,80h,90h,0ffh,83h   ; 6740 b7 80 90 ff 83   7....
l6745:  .db     0,0d1h,45h,80h  ; 6745 00 d1 45 80   .QE.
l6749:  .db     0,0f1h,54h,80h  ; 6749 00 f1 54 80   .qT.
l674d:  .db     0,0d5h,65h,80h  ; 674d 00 d5 65 80   .Ue.
l6751:  .db     0,70h,66h,80h   ; 6751 00 70 66 80   .pf.
l6755:  .db     65h,65h,65h,64h,57h,56h,55h,54h,54h,54h,54h,54h,47h     ; 6755 65 65 65 64 57 56 55 54 54 54 54 54 47   eeedWVUTTTTTG
        .db     46h,46h,45h,45h,45h,44h,44h,44h,34h,34h,34h,34h,34h,34h ; 6762 46 46 45 45 45 44 44 44 34 34 34 34 34 34   FFEEEDDD444444
        .db     34h,34h,34h,34h,34h,34h,34h,34h,34h     ; 6770 34 34 34 34 34 34 34 34 34   444444444
l6779:  .db     70h,60h,70h,70h,70h,80h,90h,0a0h,0d0h,0f0h,0e0h,0d0h    ; 6779 70 60 70 70 70 80 90 a0 d0 f0 e0 d0   p`ppp.. Pp`P
        .db     0c0h,0b0h,0a0h,90h,80h,70h,60h,50h,40h,30h,30h,20h,20h,20h      ; 6785 c0 b0 a0 90 80 70 60 50 40 30 30 20 20 20   @0 ..p`P@00   
        .db     20h,20h,20h,20h,20h,20h,20h,20h,10h,10h ; 6793 20 20 20 20 20 20 20 20 10 10           ..

l679d:  ld      a,30h           ; 679d 3e 30   >0
        ld      hl,l674d        ; 679f 21 4d 67   !Mg
        jp      l6936           ; 67a2 c3 36 69   C6i

l67a5:  ld      a,30h           ; 67a5 3e 30   >0
        ld      hl,l6751        ; 67a7 21 51 67   !Qg
        jp      l6936           ; 67aa c3 36 69   C6i

l67ad:  call    l698b           ; 67ad cd 8b 69   M.i
        and     a               ; 67b0 a7   '
        ret     nz              ; 67b1 c0   @
        ld      hl,0dffch       ; 67b2 21 fc df   !|_
        ld      a,(hl)          ; 67b5 7e   .
        ld      c,a             ; 67b6 4f   O
        cp      24h             ; 67b7 fe 24   .$
        jp      z,l67e9         ; 67b9 ca e9 67   Jig
        inc     (hl)            ; 67bc 34   4
        ld      b,0             ; 67bd 06 00   ..
        push    bc              ; 67bf c5   E
        ld      hl,l6755        ; 67c0 21 55 67   !Ug
        add     hl,bc           ; 67c3 09   .
        ld      a,(hl)          ; 67c4 7e   .
        ldh     (22h),a         ; 67c5 e0 22   `"
        pop     bc              ; 67c7 c1   A
        ld      hl,l6779        ; 67c8 21 79 67   !yg
        add     hl,bc           ; 67cb 09   .
        ld      a,(hl)          ; 67cc 7e   .
        ldh     (21h),a         ; 67cd e0 21   `!
        ld      a,80h           ; 67cf 3e 80   >.
        ldh     (23h),a         ; 67d1 e0 23   `#
        ret                     ; 67d3 c9   I

l67d4:  ld      a,20h           ; 67d4 3e 20   > 
        ld      hl,l6749        ; 67d6 21 49 67   !Ig
        jp      l6936           ; 67d9 c3 36 69   C6i

l67dc:  ld      a,12h           ; 67dc 3e 12   >.
        ld      hl,l6745        ; 67de 21 45 67   !Eg
        jp      l6936           ; 67e1 c3 36 69   C6i

l67e4:  call    l698b           ; 67e4 cd 8b 69   M.i
        and     a               ; 67e7 a7   '
        ret     nz              ; 67e8 c0   @
l67e9:  xor     a               ; 67e9 af   /
        ld      (0dff9h),a      ; 67ea ea f9 df   jy_
        ld      a,8             ; 67ed 3e 08   >.
        ldh     (21h),a         ; 67ef e0 21   `!
        ld      a,80h           ; 67f1 3e 80   >.
        ldh     (23h),a         ; 67f3 e0 23   `#
        ld      hl,0dfcfh       ; 67f5 21 cf df   !O_
        res     7,(hl)          ; 67f8 cb be   K>
        ret                     ; 67fa c9   I

l67fb:  .db     80h,3ah,20h,60h,0c6h    ; 67fb 80 3a 20 60 c6   .: `F

l6800:  ld      hl,l6ed9        ; 6800 21 d9 6e   !Yn
        call    l690d           ; 6803 cd 0d 69   M.i
        ldh     a,(4)           ; 6806 f0 04   p.
        and     1fh             ; 6808 e6 1f   f.
        ld      b,a             ; 680a 47   G
        ld      a,0d0h          ; 680b 3e d0   >P
        add     a,b             ; 680d 80   .
        ld      (0dff5h),a      ; 680e ea f5 df   ju_
        ld      hl,l67fb        ; 6811 21 fb 67   !{g
        jp      l6964           ; 6814 c3 64 69   Cdi

l6817:  ldh     a,(4)           ; 6817 f0 04   p.
        and     0fh             ; 6819 e6 0f   f.
        ld      b,a             ; 681b 47   G
        ld      hl,0dff4h       ; 681c 21 f4 df   !t_
        inc     (hl)            ; 681f 34   4
        ld      a,(hl)          ; 6820 7e   .
        ld      hl,0dff5h       ; 6821 21 f5 df   !u_
        cp      0eh             ; 6824 fe 0e   ..
        jr      nc,l6832        ; 6826 30 0a   0.
        inc     (hl)            ; 6828 34   4
        inc     (hl)            ; 6829 34   4
l682a:  ld      a,(hl)          ; 682a 7e   .
        and     0f0h            ; 682b e6 f0   fp
        or      b               ; 682d b0   0
        ld      c,1dh           ; 682e 0e 1d   ..
        ldh     (c),a           ; 6830 e2   b
        ret                     ; 6831 c9   I

l6832:  cp      1eh             ; 6832 fe 1e   ..
        jp      z,l68e2         ; 6834 ca e2 68   Jbh
        dec     (hl)            ; 6837 35   5
        dec     (hl)            ; 6838 35   5
        dec     (hl)            ; 6839 35   5
        jr      l682a           ; 683a 18 ee   .n

l683c:  ld      a,(0dff0h)      ; 683c fa f0 df   zp_
        cp      1               ; 683f fe 01   ..
        jp      z,l686b         ; 6841 ca 6b 68   Jkh
        cp      2               ; 6844 fe 02   ..
        jp      z,l6800         ; 6846 ca 00 68   J.h
        ld      a,(0dff1h)      ; 6849 fa f1 df   zq_
        cp      1               ; 684c fe 01   ..
        jp      z,l68b6         ; 684e ca b6 68   J6h
        cp      2               ; 6851 fe 02   ..
        jp      z,l6817         ; 6853 ca 17 68   J.h
        ret                     ; 6856 c9   I

l6857:  .db     80h,80h,20h     ; 6857 80 80 20   .. 
l685a:  .db     9dh,87h         ; 685a 9d 87   ..
l685c:  .db     80h,0f8h,20h    ; 685c 80 f8 20   .x 
l685f:  .db     98h,87h         ; 685f 98 87   ..
l6861:  .db     80h,0fbh,20h    ; 6861 80 fb 20   .{ 
l6864:  .db     96h,87h         ; 6864 96 87   ..
l6866:  .db     80h,0f6h,20h    ; 6866 80 f6 20   .v 
l6869:  .db     95h,87h         ; 6869 95 87   ..

l686b:  ld      hl,l6ea9        ; 686b 21 a9 6e   !)n
        call    l690d           ; 686e cd 0d 69   M.i
        ld      hl,l685a        ; 6871 21 5a 68   !Zh
        ld      a,(hl)          ; 6874 7e   .
        ld      (0dff6h),a      ; 6875 ea f6 df   jv_
        ld      a,1             ; 6878 3e 01   >.
        ld      (0dff5h),a      ; 687a ea f5 df   ju_
        ld      hl,l6857        ; 687d 21 57 68   !Wh
l6880:  jp      l6964           ; 6880 c3 64 69   Cdi

l6883:  ld      a,0             ; 6883 3e 00   >.
        ld      (0dff5h),a      ; 6885 ea f5 df   ju_
        ld      hl,l685f        ; 6888 21 5f 68   !_h
        ld      a,(hl)          ; 688b 7e   .
        ld      (0dff6h),a      ; 688c ea f6 df   jv_
        ld      hl,l685c        ; 688f 21 5c 68   !\h
        jr      l6880           ; 6892 18 ec   .l

l6894:  ld      a,1             ; 6894 3e 01   >.
        ld      (0dff5h),a      ; 6896 ea f5 df   ju_
        ld      hl,l6864        ; 6899 21 64 68   !dh
        ld      a,(hl)          ; 689c 7e   .
        ld      (0dff6h),a      ; 689d ea f6 df   jv_
        ld      hl,l6861        ; 68a0 21 61 68   !ah
        jr      l6880           ; 68a3 18 db   .[

l68a5:  ld      a,2             ; 68a5 3e 02   >.
        ld      (0dff5h),a      ; 68a7 ea f5 df   ju_
        ld      hl,l6869        ; 68aa 21 69 68   !ih
        ld      a,(hl)          ; 68ad 7e   .
        ld      (0dff6h),a      ; 68ae ea f6 df   jv_
        ld      hl,l6866        ; 68b1 21 66 68   !fh
        jr      l6880           ; 68b4 18 ca   .J

l68b6:  ld      hl,0dff4h       ; 68b6 21 f4 df   !t_
        inc     (hl)            ; 68b9 34   4
        ldi     a,(hl)          ; 68ba 2a   *
        cp      9               ; 68bb fe 09   ..
        jr      z,l6883         ; 68bd 28 c4   (D
        cp      13h             ; 68bf fe 13   ..
        jr      z,l6894         ; 68c1 28 d1   (Q
        cp      17h             ; 68c3 fe 17   ..
        jr      z,l68a5         ; 68c5 28 de   (^
        cp      20h             ; 68c7 fe 20   . 
        jr      z,l68e2         ; 68c9 28 17   (.
        ldi     a,(hl)          ; 68cb 2a   *
        cp      0               ; 68cc fe 00   ..
        ret     z               ; 68ce c8   H
        cp      1               ; 68cf fe 01   ..
        jr      z,l68d8         ; 68d1 28 05   (.
        cp      2               ; 68d3 fe 02   ..
        jr      z,l68dc         ; 68d5 28 05   (.
        ret                     ; 68d7 c9   I

l68d8:  inc     (hl)            ; 68d8 34   4
        inc     (hl)            ; 68d9 34   4
        jr      l68de           ; 68da 18 02   ..

l68dc:  dec     (hl)            ; 68dc 35   5
        dec     (hl)            ; 68dd 35   5
l68de:  ld      a,(hl)          ; 68de 7e   .
        ldh     (1dh),a         ; 68df e0 1d   `.
        ret                     ; 68e1 c9   I

l68e2:  xor     a               ; 68e2 af   /
        ld      (0dff1h),a      ; 68e3 ea f1 df   jq_
        ldh     (1ah),a         ; 68e6 e0 1a   `.
        ld      hl,0dfbfh       ; 68e8 21 bf df   !?_
        res     7,(hl)          ; 68eb cb be   K>
        ld      hl,0df9fh       ; 68ed 21 9f df   !._
        res     7,(hl)          ; 68f0 cb be   K>
        ld      hl,0dfafh       ; 68f2 21 af df   !/_
        res     7,(hl)          ; 68f5 cb be   K>
        ld      hl,0dfcfh       ; 68f7 21 cf df   !O_
        res     7,(hl)          ; 68fa cb be   K>
        ld      a,(0dfe9h)      ; 68fc fa e9 df   zi_
        cp      5               ; 68ff fe 05   ..
        jr      z,l6908         ; 6901 28 05   (.
        ld      hl,l6ee9        ; 6903 21 e9 6e   !in
        jr      l6932           ; 6906 18 2a   .*

l6908:  ld      hl,l6ec9        ; 6908 21 c9 6e   !In
        jr      l6932           ; 690b 18 25   .%

l690d:  push    hl              ; 690d e5   e
        ld      (0dff1h),a      ; 690e ea f1 df   jq_
        ld      hl,0dfbfh       ; 6911 21 bf df   !?_
        set     7,(hl)          ; 6914 cb fe   K.
        xor     a               ; 6916 af   /
        ld      (0dff4h),a      ; 6917 ea f4 df   jt_
        ld      (0dff5h),a      ; 691a ea f5 df   ju_
        ld      (0dff6h),a      ; 691d ea f6 df   jv_
        ldh     (1ah),a         ; 6920 e0 1a   `.
        ld      hl,0df9fh       ; 6922 21 9f df   !._
        set     7,(hl)          ; 6925 cb fe   K.
        ld      hl,0dfafh       ; 6927 21 af df   !/_
        set     7,(hl)          ; 692a cb fe   K.
        ld      hl,0dfcfh       ; 692c 21 cf df   !O_
        set     7,(hl)          ; 692f cb fe   K.
        pop     hl              ; 6931 e1   a
l6932:  call    l6998           ; 6932 cd 98 69   M.i
        ret                     ; 6935 c9   I

l6936:  push    af              ; 6936 f5   u
        dec     e               ; 6937 1d   .
        ld      a,(0df71h)      ; 6938 fa 71 df   zq_
        ld      (de),a          ; 693b 12   .
        inc     e               ; 693c 1c   .
        pop     af              ; 693d f1   q
        inc     e               ; 693e 1c   .
        ld      (de),a          ; 693f 12   .
        dec     e               ; 6940 1d   .
        xor     a               ; 6941 af   /
        ld      (de),a          ; 6942 12   .
        inc     e               ; 6943 1c   .
        inc     e               ; 6944 1c   .
        ld      (de),a          ; 6945 12   .
        inc     e               ; 6946 1c   .
        ld      (de),a          ; 6947 12   .
        ld      a,e             ; 6948 7b   {
        cp      0e5h            ; 6949 fe e5   .e
        jr      z,l6956         ; 694b 28 09   (.
        cp      0f5h            ; 694d fe f5   .u
        jr      z,l6964         ; 694f 28 13   (.
        cp      0fdh            ; 6951 fe fd   .}
        jr      z,l696b         ; 6953 28 16   (.
        ret                     ; 6955 c9   I

; Set sound #1 regs
l6956:  push    bc              ; 6956 c5   E
        ld      c,10h           ; 6957 0e 10   ..
        ld      b,5             ; 6959 06 05   ..
        jr      l6970           ; 695b 18 13   ..

; Set sound #2 regs
l695d:  push    bc              ; 695d c5   E
        ld      c,16h           ; 695e 0e 16   ..
        ld      b,4             ; 6960 06 04   ..
        jr      l6970           ; 6962 18 0c   ..

; Set sound #3 regs
l6964:  push    bc              ; 6964 c5   E
        ld      c,1ah           ; 6965 0e 1a   ..
        ld      b,5             ; 6967 06 05   ..
        jr      l6970           ; 6969 18 05   ..

; Set sound #4 regs
l696b:  push    bc              ; 696b c5   E
        ld      c,20h           ; 696c 0e 20   . 
        ld      b,4             ; 696e 06 04   ..
l6970:  ldi     a,(hl)          ; 6970 2a   *
        ldh     (c),a           ; 6971 e2   b
        inc     c               ; 6972 0c   .
        dec     b               ; 6973 05   .
        jr      nz,l6970        ; 6974 20 fa    z
        pop     bc              ; 6976 c1   A
        ret                     ; 6977 c9   I

l6978:  inc     e               ; 6978 1c   .
        ld      (0df71h),a      ; 6979 ea 71 df   jq_
l697c:  inc     e               ; 697c 1c   .
        dec     a               ; 697d 3d   =
        sla     a               ; 697e cb 27   K'
        ld      c,a             ; 6980 4f   O
        ld      b,0             ; 6981 06 00   ..
        add     hl,bc           ; 6983 09   .
        ld      c,(hl)          ; 6984 4e   N
        inc     hl              ; 6985 23   #
        ld      b,(hl)          ; 6986 46   F
        ld      l,c             ; 6987 69   i
        ld      h,b             ; 6988 60   `
        ld      a,h             ; 6989 7c   |
        ret                     ; 698a c9   I

l698b:  push    de              ; 698b d5   U
        ld      l,e             ; 698c 6b   k
        ld      h,d             ; 698d 62   b
        inc     (hl)            ; 698e 34   4
        ldi     a,(hl)          ; 698f 2a   *
        cp      (hl)            ; 6990 be   >
        jr      nz,l6996        ; 6991 20 03    .
        dec     l               ; 6993 2d   -
        xor     a               ; 6994 af   /
        ld      (hl),a          ; 6995 77   w
l6996:  pop     de              ; 6996 d1   Q
        ret                     ; 6997 c9   I

; Copy from hl to sound wave pattern ram
l6998:  push    bc              ; 6998 c5   E
        ld      c,30h           ; 6999 0e 30   .0
l699b:  ldi     a,(hl)          ; 699b 2a   *
        ldh     (c),a           ; 699c e2   b
        inc     c               ; 699d 0c   .
        ld      a,c             ; 699e 79   y
        cp      40h             ; 699f fe 40   .@
        jr      nz,l699b        ; 69a1 20 f8    x
        pop     bc              ; 69a3 c1   A
        ret                     ; 69a4 c9   I

; Reset some sound registers
l69a5:  xor     a               ; 69a5 af   /
        ld      (0dfe1h),a      ; 69a6 ea e1 df   ja_
        ld      (0dfe9h),a      ; 69a9 ea e9 df   ji_
        ld      (0dff1h),a      ; 69ac ea f1 df   jq_
        ld      (0dff9h),a      ; 69af ea f9 df   jy_
        ld      (0df9fh),a      ; 69b2 ea 9f df   j._
        ld      (0dfafh),a      ; 69b5 ea af df   j/_
        ld      (0dfbfh),a      ; 69b8 ea bf df   j?_
        ld      (0dfcfh),a      ; 69bb ea cf df   jO_
        ld      a,0ffh          ; 69be 3e ff   >.
        ldh     (25h),a         ; 69c0 e0 25   `%
        ld      a,3             ; 69c2 3e 03   >.
        ld      (0df78h),a      ; 69c4 ea 78 df   jx_
l69c7:  ld      a,8             ; 69c7 3e 08   >.
        ldh     (12h),a         ; 69c9 e0 12   `.
        ldh     (17h),a         ; 69cb e0 17   `.
        ldh     (21h),a         ; 69cd e0 21   `!
        ld      a,80h           ; 69cf 3e 80   >.
        ldh     (14h),a         ; 69d1 e0 14   `.
        ldh     (19h),a         ; 69d3 e0 19   `.
        ldh     (23h),a         ; 69d5 e0 23   `#
        xor     a               ; 69d7 af   /
        ldh     (10h),a         ; 69d8 e0 10   `.
        ldh     (1ah),a         ; 69da e0 1a   `.
        ret                     ; 69dc c9   I

l69dd:  ld      de,0dfe0h       ; 69dd 11 e0 df   .`_
        ld      a,(de)          ; 69e0 1a   .
        and     a               ; 69e1 a7   '
        jr      z,l69f0         ; 69e2 28 0c   (.
        ld      hl,0df9fh       ; 69e4 21 9f df   !._
        set     7,(hl)          ; 69e7 cb fe   K.
        ld      hl,l6480        ; 69e9 21 80 64   !.d
        call    l6978           ; 69ec cd 78 69   Mxi
        jp      (hl)            ; 69ef e9   i

l69f0:  inc     e               ; 69f0 1c   .
        ld      a,(de)          ; 69f1 1a   .
        and     a               ; 69f2 a7   '
        jr      z,l69fc         ; 69f3 28 07   (.
        ld      hl,l6490        ; 69f5 21 90 64   !.d
        call    l697c           ; 69f8 cd 7c 69   M|i
        jp      (hl)            ; 69fb e9   i

l69fc:  ret                     ; 69fc c9   I

l69fd:  ld      de,0dff8h       ; 69fd 11 f8 df   .x_
        ld      a,(de)          ; 6a00 1a   .
        and     a               ; 6a01 a7   '
        jr      z,l6a10         ; 6a02 28 0c   (.
        ld      hl,0dfcfh       ; 6a04 21 cf df   !O_
        set     7,(hl)          ; 6a07 cb fe   K.
        ld      hl,l64a0        ; 6a09 21 a0 64   ! d
        call    l6978           ; 6a0c cd 78 69   Mxi
        jp      (hl)            ; 6a0f e9   i

l6a10:  inc     e               ; 6a10 1c   .
        ld      a,(de)          ; 6a11 1a   .
        and     a               ; 6a12 a7   '
        jr      z,l6a1c         ; 6a13 28 07   (.
        ld      hl,l64a8        ; 6a15 21 a8 64   !(d
        call    l697c           ; 6a18 cd 7c 69   M|i
        jp      (hl)            ; 6a1b e9   i

l6a1c:  ret                     ; 6a1c c9   I

l6a1d:  call    l69a5           ; 6a1d cd a5 69   M%i
        ret                     ; 6a20 c9   I

l6a21:  ld      hl,0dfe8h       ; 6a21 21 e8 df   !h_
        ldi     a,(hl)          ; 6a24 2a   *
        and     a               ; 6a25 a7   '
        ret     z               ; 6a26 c8   H
        cp      0ffh            ; 6a27 fe ff   ..
        jr      z,l6a1d         ; 6a29 28 f2   (r
        ld      (hl),a          ; 6a2b 77   w
        ld      b,a             ; 6a2c 47   G
        ld      hl,l64b0        ; 6a2d 21 b0 64   !0d
        and     1fh             ; 6a30 e6 1f   f.
        call    l697c           ; 6a32 cd 7c 69   M|i
        call    l6b13           ; 6a35 cd 13 6b   M.k
        call    l6a3c           ; 6a38 cd 3c 6a   M<j
        ret                     ; 6a3b c9   I

l6a3c:  ld      a,(0dfe9h)      ; 6a3c fa e9 df   zi_
        and     a               ; 6a3f a7   '
        ret     z               ; 6a40 c8   H
        ld      hl,l6abe        ; 6a41 21 be 6a   !>j
l6a44:  dec     a               ; 6a44 3d   =
        jr      z,l6a4d         ; 6a45 28 06   (.
        inc     hl              ; 6a47 23   #
        inc     hl              ; 6a48 23   #
        inc     hl              ; 6a49 23   #
        inc     hl              ; 6a4a 23   #
        jr      l6a44           ; 6a4b 18 f7   .w

l6a4d:  ldi     a,(hl)          ; 6a4d 2a   *
        ld      (0df78h),a      ; 6a4e ea 78 df   jx_
        ldi     a,(hl)          ; 6a51 2a   *
        ld      (0df76h),a      ; 6a52 ea 76 df   jv_
        ldi     a,(hl)          ; 6a55 2a   *
        ld      (0df79h),a      ; 6a56 ea 79 df   jy_
        ldi     a,(hl)          ; 6a59 2a   *
        ld      (0df7ah),a      ; 6a5a ea 7a df   jz_
        xor     a               ; 6a5d af   /
        ld      (0df75h),a      ; 6a5e ea 75 df   ju_
        ld      (0df77h),a      ; 6a61 ea 77 df   jw_
        ret                     ; 6a64 c9   I

l6a65:  ld      a,(0dfe9h)      ; 6a65 fa e9 df   zi_
        and     a               ; 6a68 a7   '
        jr      z,l6aa8         ; 6a69 28 3d   (=
        ld      hl,0df75h       ; 6a6b 21 75 df   !u_
        ld      a,(0df78h)      ; 6a6e fa 78 df   zx_
        cp      1               ; 6a71 fe 01   ..
        jr      z,l6aac         ; 6a73 28 37   (7
        cp      3               ; 6a75 fe 03   ..
        jr      z,l6aa8         ; 6a77 28 2f   (/
        inc     (hl)            ; 6a79 34   4
        ldi     a,(hl)          ; 6a7a 2a   *
        cp      (hl)            ; 6a7b be   >
        jr      nz,l6ab1        ; 6a7c 20 33    3
        dec     l               ; 6a7e 2d   -
        ld      (hl),0          ; 6a7f 36 00   6.
        inc     l               ; 6a81 2c   ,
        inc     l               ; 6a82 2c   ,
        inc     (hl)            ; 6a83 34   4
        ld      a,(0df79h)      ; 6a84 fa 79 df   zy_
        bit     0,(hl)          ; 6a87 cb 46   KF
        jp      z,l6a8f         ; 6a89 ca 8f 6a   J.j
        ld      a,(0df7ah)      ; 6a8c fa 7a df   zz_
l6a8f:  ld      b,a             ; 6a8f 47   G
        ld      a,(0dff1h)      ; 6a90 fa f1 df   zq_
        and     a               ; 6a93 a7   '
        jr      z,l6a9a         ; 6a94 28 04   (.
        set     2,b             ; 6a96 cb d0   KP
        set     6,b             ; 6a98 cb f0   Kp
l6a9a:  ld      a,(0dff9h)      ; 6a9a fa f9 df   zy_
        and     a               ; 6a9d a7   '
        jr      z,l6aa4         ; 6a9e 28 04   (.
        set     3,b             ; 6aa0 cb d8   KX
        set     7,b             ; 6aa2 cb f8   Kx
l6aa4:  ld      a,b             ; 6aa4 78   x
l6aa5:  ldh     (25h),a         ; 6aa5 e0 25   `%
        ret                     ; 6aa7 c9   I

l6aa8:  ld      a,0ffh          ; 6aa8 3e ff   >.
        jr      l6aa5           ; 6aaa 18 f9   .y

l6aac:  ld      a,(0df79h)      ; 6aac fa 79 df   zy_
        jr      l6a8f           ; 6aaf 18 de   .^

l6ab1:  ld      a,(0dff9h)      ; 6ab1 fa f9 df   zy_
        and     a               ; 6ab4 a7   '
        jr      nz,l6aa8        ; 6ab5 20 f1    q
        ld      a,(0dff1h)      ; 6ab7 fa f1 df   zq_
        and     a               ; 6aba a7   '
        jr      nz,l6aa8        ; 6abb 20 eb    k
        ret                     ; 6abd c9   I

l6abe:  .db     1,24h,0efh,56h,1,0,0e5h,0,1,20h,0fdh,0,1,20h,0deh       ; 6abe 01 24 ef 56 01 00 e5 00 01 20 fd 00 01 20 de   .$oV..e.. }.. ^
        .db     0f7h,3,18h,7fh,0f7h,3,18h,0f7h,7fh,3,48h,0dfh,5bh,1,18h ; 6acd f7 03 18 7f f7 03 18 f7 7f 03 48 df 5b 01 18   w...w..w..H_[..
        .db     0dbh,0e7h,1,0,0fdh,0f7h,3,20h,7fh,0f7h,1,20h,0edh,0f7h,1        ; 6adc db e7 01 00 fd f7 03 20 7f f7 01 20 ed f7 01   [g..}w. .w. mw.
        .db     20h,0edh,0f7h,1,20h,0edh,0f7h,1,20h,0edh,0f7h,1,20h,0edh        ; 6aeb 20 ed f7 01 20 ed f7 01 20 ed f7 01 20 ed    mw. mw. mw. m
        .db     0f7h,1,20h,0efh,0f7h,1,20h,0efh,0f7h    ; 6af9 f7 01 20 ef f7 01 20 ef f7   w. ow. ow

l6b02:  ldi     a,(hl)          ; 6b02 2a   *
        ld      c,a             ; 6b03 4f   O
        ld      a,(hl)          ; 6b04 7e   .
        ld      b,a             ; 6b05 47   G
        ld      a,(bc)          ; 6b06 0a   .
        ld      (de),a          ; 6b07 12   .
        inc     e               ; 6b08 1c   .
        inc     bc              ; 6b09 03   .
        ld      a,(bc)          ; 6b0a 0a   .
        ld      (de),a          ; 6b0b 12   .
        ret                     ; 6b0c c9   I

; Copy 2 bytes from (hl) to (de)
; (Copy can't cross page boundary.)
l6b0d:  ldi     a,(hl)          ; 6b0d 2a   *
        ld      (de),a          ; 6b0e 12   .
        inc     e               ; 6b0f 1c   .
        ldi     a,(hl)          ; 6b10 2a   *
        ld      (de),a          ; 6b11 12   .
        ret                     ; 6b12 c9   I

l6b13:  call    l69c7           ; 6b13 cd c7 69   MGi
        xor     a               ; 6b16 af   /
        ld      (0df75h),a      ; 6b17 ea 75 df   ju_
        ld      (0df77h),a      ; 6b1a ea 77 df   jw_
        ld      de,0df80h       ; 6b1d 11 80 df   .._
        ld      b,0             ; 6b20 06 00   ..
        ldi     a,(hl)          ; 6b22 2a   *
        ld      (de),a          ; 6b23 12   .
        inc     e               ; 6b24 1c   .
        call    l6b0d           ; 6b25 cd 0d 6b   M.k
        ld      de,0df90h       ; 6b28 11 90 df   .._
        call    l6b0d           ; 6b2b cd 0d 6b   M.k
        ld      de,0dfa0h       ; 6b2e 11 a0 df   . _
        call    l6b0d           ; 6b31 cd 0d 6b   M.k
        ld      de,0dfb0h       ; 6b34 11 b0 df   .0_
        call    l6b0d           ; 6b37 cd 0d 6b   M.k
        ld      de,0dfc0h       ; 6b3a 11 c0 df   .@_
        call    l6b0d           ; 6b3d cd 0d 6b   M.k
        ld      hl,0df90h       ; 6b40 21 90 df   !._
        ld      de,0df94h       ; 6b43 11 94 df   .._
        call    l6b02           ; 6b46 cd 02 6b   M.k
        ld      hl,0dfa0h       ; 6b49 21 a0 df   ! _
        ld      de,0dfa4h       ; 6b4c 11 a4 df   .$_
        call    l6b02           ; 6b4f cd 02 6b   M.k
        ld      hl,0dfb0h       ; 6b52 21 b0 df   !0_
        ld      de,0dfb4h       ; 6b55 11 b4 df   .4_
        call    l6b02           ; 6b58 cd 02 6b   M.k
        ld      hl,0dfc0h       ; 6b5b 21 c0 df   !@_
        ld      de,0dfc4h       ; 6b5e 11 c4 df   .D_
        call    l6b02           ; 6b61 cd 02 6b   M.k
        ld      bc,410h         ; 6b64 01 10 04   ...
        ld      hl,0df92h       ; 6b67 21 92 df   !._
l6b6a:  ld      (hl),1          ; 6b6a 36 01   6.
        ld      a,c             ; 6b6c 79   y
        add     a,l             ; 6b6d 85   .
        ld      l,a             ; 6b6e 6f   o
        dec     b               ; 6b6f 05   .
        jr      nz,l6b6a        ; 6b70 20 f8    x
        xor     a               ; 6b72 af   /
        ld      (0df9eh),a      ; 6b73 ea 9e df   j._
        ld      (0dfaeh),a      ; 6b76 ea ae df   j._
        ld      (0dfbeh),a      ; 6b79 ea be df   j>_
        ret                     ; 6b7c c9   I

l6b7d:  push    hl              ; 6b7d e5   e
        xor     a               ; 6b7e af   /
        ldh     (1ah),a         ; 6b7f e0 1a   `.
        ld      l,e             ; 6b81 6b   k
        ld      h,d             ; 6b82 62   b
        call    l6998           ; 6b83 cd 98 69   M.i
        pop     hl              ; 6b86 e1   a
        jr      l6bb3           ; 6b87 18 2a   .*

l6b89:  call    l6bb9           ; 6b89 cd b9 6b   M9k
        call    l6bce           ; 6b8c cd ce 6b   MNk
        ld      e,a             ; 6b8f 5f   _
        call    l6bb9           ; 6b90 cd b9 6b   M9k
        call    l6bce           ; 6b93 cd ce 6b   MNk
        ld      d,a             ; 6b96 57   W
        call    l6bb9           ; 6b97 cd b9 6b   M9k
        call    l6bce           ; 6b9a cd ce 6b   MNk
        ld      c,a             ; 6b9d 4f   O
        inc     l               ; 6b9e 2c   ,
        inc     l               ; 6b9f 2c   ,
        ld      (hl),e          ; 6ba0 73   s
        inc     l               ; 6ba1 2c   ,
        ld      (hl),d          ; 6ba2 72   r
        inc     l               ; 6ba3 2c   ,
        ld      (hl),c          ; 6ba4 71   q
        dec     l               ; 6ba5 2d   -
        dec     l               ; 6ba6 2d   -
        dec     l               ; 6ba7 2d   -
        dec     l               ; 6ba8 2d   -
        push    hl              ; 6ba9 e5   e
        ld      hl,0df70h       ; 6baa 21 70 df   !p_
        ld      a,(hl)          ; 6bad 7e   .
        pop     hl              ; 6bae e1   a
        cp      3               ; 6baf fe 03   ..
        jr      z,l6b7d         ; 6bb1 28 ca   (J
l6bb3:  call    l6bb9           ; 6bb3 cd b9 6b   M9k
        jp      l6c5e           ; 6bb6 c3 5e 6c   C^l

; Increment 16-bit number pointed to by hl
l6bb9:  push    de              ; 6bb9 d5   U
        ldi     a,(hl)          ; 6bba 2a   *
        ld      e,a             ; 6bbb 5f   _
        ldd     a,(hl)          ; 6bbc 3a   :
        ld      d,a             ; 6bbd 57   W
        inc     de              ; 6bbe 13   .
l6bbf:  ld      a,e             ; 6bbf 7b   {
        ldi     (hl),a          ; 6bc0 22   "
        ld      a,d             ; 6bc1 7a   z
        ldd     (hl),a          ; 6bc2 32   2
        pop     de              ; 6bc3 d1   Q
        ret                     ; 6bc4 c9   I

; Increment twice 16-bit number pointed to by hl
l6bc5:  push    de              ; 6bc5 d5   U
        ldi     a,(hl)          ; 6bc6 2a   *
        ld      e,a             ; 6bc7 5f   _
        ldd     a,(hl)          ; 6bc8 3a   :
        ld      d,a             ; 6bc9 57   W
        inc     de              ; 6bca 13   .
        inc     de              ; 6bcb 13   .
        jr      l6bbf           ; 6bcc 18 f1   .q

; b = ((hl))
l6bce:  ldi     a,(hl)          ; 6bce 2a   *
        ld      c,a             ; 6bcf 4f   O
        ldd     a,(hl)          ; 6bd0 3a   :
        ld      b,a             ; 6bd1 47   G
        ld      a,(bc)          ; 6bd2 0a   .
        ld      b,a             ; 6bd3 47   G
        ret                     ; 6bd4 c9   I

l6bd5:  pop     hl              ; 6bd5 e1   a
        jr      l6c04           ; 6bd6 18 2c   .,

l6bd8:  ld      a,(0df70h)      ; 6bd8 fa 70 df   zp_
        cp      3               ; 6bdb fe 03   ..
        jr      nz,l6bef        ; 6bdd 20 10    .
        ld      a,(0dfb8h)      ; 6bdf fa b8 df   z8_
        bit     7,a             ; 6be2 cb 7f   K.
        jr      z,l6bef         ; 6be4 28 09   (.
        ld      a,(hl)          ; 6be6 7e   .
        cp      6               ; 6be7 fe 06   ..
        jr      nz,l6bef        ; 6be9 20 04    .
        ld      a,40h           ; 6beb 3e 40   >@
        ldh     (1ch),a         ; 6bed e0 1c   `.
l6bef:  push    hl              ; 6bef e5   e
        ld      a,l             ; 6bf0 7d   }
        add     a,9             ; 6bf1 c6 09   F.
        ld      l,a             ; 6bf3 6f   o
        ld      a,(hl)          ; 6bf4 7e   .
        and     a               ; 6bf5 a7   '
        jr      nz,l6bd5        ; 6bf6 20 dd    ]
        ld      a,l             ; 6bf8 7d   }
        add     a,4             ; 6bf9 c6 04   F.
        ld      l,a             ; 6bfb 6f   o
        bit     7,(hl)          ; 6bfc cb 7e   K.
        jr      nz,l6bd5        ; 6bfe 20 d5    U
        pop     hl              ; 6c00 e1   a
        call    l6d67           ; 6c01 cd 67 6d   Mgm
l6c04:  dec     l               ; 6c04 2d   -
        dec     l               ; 6c05 2d   -
        jp      l6d39           ; 6c06 c3 39 6d   C9m

l6c09:  dec     l               ; 6c09 2d   -
        dec     l               ; 6c0a 2d   -
        dec     l               ; 6c0b 2d   -
        dec     l               ; 6c0c 2d   -
        call    l6bc5           ; 6c0d cd c5 6b   MEk
l6c10:  ld      a,l             ; 6c10 7d   }
        add     a,4             ; 6c11 c6 04   F.
        ld      e,a             ; 6c13 5f   _
        ld      d,h             ; 6c14 54   T
        call    l6b02           ; 6c15 cd 02 6b   M.k
        cp      0               ; 6c18 fe 00   ..
        jr      z,l6c3b         ; 6c1a 28 1f   (.
        cp      0ffh            ; 6c1c fe ff   ..
        jr      z,l6c24         ; 6c1e 28 04   (.
        inc     l               ; 6c20 2c   ,
        jp      l6c5c           ; 6c21 c3 5c 6c   C\l

l6c24:  dec     l               ; 6c24 2d   -
        push    hl              ; 6c25 e5   e
        call    l6bc5           ; 6c26 cd c5 6b   MEk
        call    l6bce           ; 6c29 cd ce 6b   MNk
        ld      e,a             ; 6c2c 5f   _
        call    l6bb9           ; 6c2d cd b9 6b   M9k
        call    l6bce           ; 6c30 cd ce 6b   MNk
        ld      d,a             ; 6c33 57   W
        pop     hl              ; 6c34 e1   a
        ld      a,e             ; 6c35 7b   {
        ldi     (hl),a          ; 6c36 22   "
        ld      a,d             ; 6c37 7a   z
        ldd     (hl),a          ; 6c38 32   2
        jr      l6c10           ; 6c39 18 d5   .U

l6c3b:  ld      hl,0dfe9h       ; 6c3b 21 e9 df   !i_
        ld      (hl),0          ; 6c3e 36 00   6.
        call    l69a5           ; 6c40 cd a5 69   M%i
        ret                     ; 6c43 c9   I

l6c44:  ld      hl,0dfe9h       ; 6c44 21 e9 df   !i_
        ld      a,(hl)          ; 6c47 7e   .
        and     a               ; 6c48 a7   '
        ret     z               ; 6c49 c8   H
        ld      a,1             ; 6c4a 3e 01   >.
        ld      (0df70h),a      ; 6c4c ea 70 df   jp_
        ld      hl,0df90h       ; 6c4f 21 90 df   !._
l6c52:  inc     l               ; 6c52 2c   ,
        ldi     a,(hl)          ; 6c53 2a   *
        and     a               ; 6c54 a7   '
        jp      z,l6c04         ; 6c55 ca 04 6c   J.l
        dec     (hl)            ; 6c58 35   5
        jp      nz,l6bd8        ; 6c59 c2 d8 6b   BXk
l6c5c:  inc     l               ; 6c5c 2c   ,
        inc     l               ; 6c5d 2c   ,
l6c5e:  call    l6bce           ; 6c5e cd ce 6b   MNk
        cp      0               ; 6c61 fe 00   ..
        jp      z,l6c09         ; 6c63 ca 09 6c   J.l
        cp      9dh             ; 6c66 fe 9d   ..
        jp      z,l6b89         ; 6c68 ca 89 6b   J.k
        and     0f0h            ; 6c6b e6 f0   fp
        cp      0a0h            ; 6c6d fe a0   . 
        jr      nz,l6c8b        ; 6c6f 20 1a    .
        ld      a,b             ; 6c71 78   x
        and     0fh             ; 6c72 e6 0f   f.
        ld      c,a             ; 6c74 4f   O
        ld      b,0             ; 6c75 06 00   ..
        push    hl              ; 6c77 e5   e
        ld      de,0df81h       ; 6c78 11 81 df   .._
        ld      a,(de)          ; 6c7b 1a   .
        ld      l,a             ; 6c7c 6f   o
        inc     de              ; 6c7d 13   .
        ld      a,(de)          ; 6c7e 1a   .
        ld      h,a             ; 6c7f 67   g
        add     hl,bc           ; 6c80 09   .
        ld      a,(hl)          ; 6c81 7e   .
        pop     hl              ; 6c82 e1   a
        dec     l               ; 6c83 2d   -
        ldi     (hl),a          ; 6c84 22   "
        call    l6bb9           ; 6c85 cd b9 6b   M9k
        call    l6bce           ; 6c88 cd ce 6b   MNk
l6c8b:  ld      a,b             ; 6c8b 78   x
        ld      c,a             ; 6c8c 4f   O
        ld      b,0             ; 6c8d 06 00   ..
        call    l6bb9           ; 6c8f cd b9 6b   M9k
        ld      a,(0df70h)      ; 6c92 fa 70 df   zp_
        cp      4               ; 6c95 fe 04   ..
        jp      z,l6cbc         ; 6c97 ca bc 6c   J<l
        push    hl              ; 6c9a e5   e
        ld      a,l             ; 6c9b 7d   }
        add     a,5             ; 6c9c c6 05   F.
        ld      l,a             ; 6c9e 6f   o
        ld      e,l             ; 6c9f 5d   ]
        ld      d,h             ; 6ca0 54   T
        inc     l               ; 6ca1 2c   ,
        inc     l               ; 6ca2 2c   ,
        ld      a,c             ; 6ca3 79   y
        cp      1               ; 6ca4 fe 01   ..
        jr      z,l6cb7         ; 6ca6 28 0f   (.
        ld      (hl),0          ; 6ca8 36 00   6.
        ld      hl,l6e02        ; 6caa 21 02 6e   !.n
        add     hl,bc           ; 6cad 09   .
        ldi     a,(hl)          ; 6cae 2a   *
        ld      (de),a          ; 6caf 12   .
        inc     e               ; 6cb0 1c   .
        ld      a,(hl)          ; 6cb1 7e   .
        ld      (de),a          ; 6cb2 12   .
        pop     hl              ; 6cb3 e1   a
        jp      l6cd3           ; 6cb4 c3 d3 6c   CSl

l6cb7:  ld      (hl),1          ; 6cb7 36 01   6.
        pop     hl              ; 6cb9 e1   a
        jr      l6cd3           ; 6cba 18 17   ..

l6cbc:  push    hl              ; 6cbc e5   e
        ld      de,0dfc6h       ; 6cbd 11 c6 df   .F_
        ld      hl,l6e94        ; 6cc0 21 94 6e   !.n
        add     hl,bc           ; 6cc3 09   .
l6cc4:  ldi     a,(hl)          ; 6cc4 2a   *
        ld      (de),a          ; 6cc5 12   .
        inc     e               ; 6cc6 1c   .
        ld      a,e             ; 6cc7 7b   {
        cp      0cbh            ; 6cc8 fe cb   .K
        jr      nz,l6cc4        ; 6cca 20 f8    x
        ld      c,20h           ; 6ccc 0e 20   . 
        ld      hl,0dfc4h       ; 6cce 21 c4 df   !D_
        jr      l6d01           ; 6cd1 18 2e   ..

l6cd3:  push    hl              ; 6cd3 e5   e
        ld      a,(0df70h)      ; 6cd4 fa 70 df   zp_
        cp      1               ; 6cd7 fe 01   ..
        jr      z,l6cfc         ; 6cd9 28 21   (!
        cp      2               ; 6cdb fe 02   ..
        jr      z,l6cf8         ; 6cdd 28 19   (.
        ld      c,1ah           ; 6cdf 0e 1a   ..
        ld      a,(0dfbfh)      ; 6ce1 fa bf df   z?_
        bit     7,a             ; 6ce4 cb 7f   K.
        jr      nz,l6ced        ; 6ce6 20 05    .
        xor     a               ; 6ce8 af   /
        ldh     (c),a           ; 6ce9 e2   b
        ld      a,80h           ; 6cea 3e 80   >.
        ldh     (c),a           ; 6cec e2   b
l6ced:  inc     c               ; 6ced 0c   .
        inc     l               ; 6cee 2c   ,
        inc     l               ; 6cef 2c   ,
        inc     l               ; 6cf0 2c   ,
        inc     l               ; 6cf1 2c   ,
        ldi     a,(hl)          ; 6cf2 2a   *
        ld      e,a             ; 6cf3 5f   _
        ld      d,0             ; 6cf4 16 00   ..
        jr      l6d0d           ; 6cf6 18 15   ..

l6cf8:  ld      c,16h           ; 6cf8 0e 16   ..
        jr      l6d01           ; 6cfa 18 05   ..

l6cfc:  ld      c,10h           ; 6cfc 0e 10   ..
        ld      a,0             ; 6cfe 3e 00   >.
        inc     c               ; 6d00 0c   .
l6d01:  inc     l               ; 6d01 2c   ,
        inc     l               ; 6d02 2c   ,
        inc     l               ; 6d03 2c   ,
        ldd     a,(hl)          ; 6d04 3a   :
        and     a               ; 6d05 a7   '
        jr      nz,l6d57        ; 6d06 20 4f    O
        ldi     a,(hl)          ; 6d08 2a   *
        ld      e,a             ; 6d09 5f   _
l6d0a:  inc     l               ; 6d0a 2c   ,
        ldi     a,(hl)          ; 6d0b 2a   *
        ld      d,a             ; 6d0c 57   W
l6d0d:  push    hl              ; 6d0d e5   e
        inc     l               ; 6d0e 2c   ,
        inc     l               ; 6d0f 2c   ,
        ldi     a,(hl)          ; 6d10 2a   *
        and     a               ; 6d11 a7   '
        jr      z,l6d16         ; 6d12 28 02   (.
        ld      e,1             ; 6d14 1e 01   ..
l6d16:  inc     l               ; 6d16 2c   ,
        inc     l               ; 6d17 2c   ,
        ld      (hl),0          ; 6d18 36 00   6.
        inc     l               ; 6d1a 2c   ,
        ld      a,(hl)          ; 6d1b 7e   .
        pop     hl              ; 6d1c e1   a
        bit     7,a             ; 6d1d cb 7f   K.
        jr      nz,l6d34        ; 6d1f 20 13    .
        ld      a,d             ; 6d21 7a   z
        ldh     (c),a           ; 6d22 e2   b
        inc     c               ; 6d23 0c   .
        ld      a,e             ; 6d24 7b   {
        ldh     (c),a           ; 6d25 e2   b
        inc     c               ; 6d26 0c   .
        ldi     a,(hl)          ; 6d27 2a   *
        ldh     (c),a           ; 6d28 e2   b
        inc     c               ; 6d29 0c   .
        ld      a,(hl)          ; 6d2a 7e   .
        or      80h             ; 6d2b f6 80   v.
        ldh     (c),a           ; 6d2d e2   b
        ld      a,l             ; 6d2e 7d   }
        or      5               ; 6d2f f6 05   v.
        ld      l,a             ; 6d31 6f   o
        res     0,(hl)          ; 6d32 cb 86   K.
l6d34:  pop     hl              ; 6d34 e1   a
        dec     l               ; 6d35 2d   -
        ldd     a,(hl)          ; 6d36 3a   :
        ldd     (hl),a          ; 6d37 32   2
        dec     l               ; 6d38 2d   -
l6d39:  ld      de,0df70h       ; 6d39 11 70 df   .p_
        ld      a,(de)          ; 6d3c 1a   .
        cp      4               ; 6d3d fe 04   ..
        jr      z,l6d4a         ; 6d3f 28 09   (.
        inc     a               ; 6d41 3c   <
        ld      (de),a          ; 6d42 12   .
        ld      de,10h          ; 6d43 11 10 00   ...
        add     hl,de           ; 6d46 19   .
        jp      l6c52           ; 6d47 c3 52 6c   CRl

l6d4a:  ld      hl,0df9eh       ; 6d4a 21 9e df   !._
        inc     (hl)            ; 6d4d 34   4
        ld      hl,0dfaeh       ; 6d4e 21 ae df   !._
        inc     (hl)            ; 6d51 34   4
        ld      hl,0dfbeh       ; 6d52 21 be df   !>_
        inc     (hl)            ; 6d55 34   4
        ret                     ; 6d56 c9   I

l6d57:  ld      b,0             ; 6d57 06 00   ..
        push    hl              ; 6d59 e5   e
        pop     hl              ; 6d5a e1   a
        inc     l               ; 6d5b 2c   ,
        jr      l6d0a           ; 6d5c 18 ac   .,

l6d5e:  ld      a,b             ; 6d5e 78   x
        srl     a               ; 6d5f cb 3f   K?
        ld      l,a             ; 6d61 6f   o
        ld      h,0             ; 6d62 26 00   &.
        add     hl,de           ; 6d64 19   .
        ld      e,(hl)          ; 6d65 5e   ^
        ret                     ; 6d66 c9   I

l6d67:  push    hl              ; 6d67 e5   e
        ld      a,l             ; 6d68 7d   }
        add     a,6             ; 6d69 c6 06   F.
        ld      l,a             ; 6d6b 6f   o
        ld      a,(hl)          ; 6d6c 7e   .
        and     0fh             ; 6d6d e6 0f   f.
        jr      z,l6d89         ; 6d6f 28 18   (.
        ld      (0df71h),a      ; 6d71 ea 71 df   jq_
        ld      a,(0df70h)      ; 6d74 fa 70 df   zp_
        ld      c,13h           ; 6d77 0e 13   ..
        cp      1               ; 6d79 fe 01   ..
        jr      z,l6d8b         ; 6d7b 28 0e   (.
        ld      c,18h           ; 6d7d 0e 18   ..
        cp      2               ; 6d7f fe 02   ..
        jr      z,l6d8b         ; 6d81 28 08   (.
        ld      c,1dh           ; 6d83 0e 1d   ..
        cp      3               ; 6d85 fe 03   ..
        jr      z,l6d8b         ; 6d87 28 02   (.
l6d89:  pop     hl              ; 6d89 e1   a
        ret                     ; 6d8a c9   I

l6d8b:  inc     l               ; 6d8b 2c   ,
        ldi     a,(hl)          ; 6d8c 2a   *
        ld      e,a             ; 6d8d 5f   _
        ld      a,(hl)          ; 6d8e 7e   .
        ld      d,a             ; 6d8f 57   W
        push    de              ; 6d90 d5   U
        ld      a,l             ; 6d91 7d   }
        add     a,4             ; 6d92 c6 04   F.
        ld      l,a             ; 6d94 6f   o
        ld      b,(hl)          ; 6d95 46   F
        ld      a,(0df71h)      ; 6d96 fa 71 df   zq_
        cp      1               ; 6d99 fe 01   ..
        jr      l6da6           ; 6d9b 18 09   ..

; The next 4 instructions are not used.
        cp      3               ; 6d9d fe 03   ..
        jr      l6da1           ; 6d9f 18 00   ..

l6da1:  ld      hl,0ffffh       ; 6da1 21 ff ff   !..
        jr      l6dc2           ; 6da4 18 1c   ..

l6da6:  ld      de,l6dcb        ; 6da6 11 cb 6d   .Km
        call    l6d5e           ; 6da9 cd 5e 6d   M^m
        bit     0,b             ; 6dac cb 40   K@
        jr      nz,l6db2        ; 6dae 20 02    .
        swap    e               ; 6db0 cb 33   K3
l6db2:  ld      a,e             ; 6db2 7b   {
        and     0fh             ; 6db3 e6 0f   f.
        bit     3,a             ; 6db5 cb 5f   K_
        jr      z,l6dbf         ; 6db7 28 06   (.
        ld      h,0ffh          ; 6db9 26 ff   &.
        or      0f0h            ; 6dbb f6 f0   vp
        jr      l6dc1           ; 6dbd 18 02   ..

l6dbf:  ld      h,0             ; 6dbf 26 00   &.
l6dc1:  ld      l,a             ; 6dc1 6f   o
l6dc2:  pop     de              ; 6dc2 d1   Q
        add     hl,de           ; 6dc3 19   .
        ld      a,l             ; 6dc4 7d   }
        ldh     (c),a           ; 6dc5 e2   b
        inc     c               ; 6dc6 0c   .
        ld      a,h             ; 6dc7 7c   |
        ldh     (c),a           ; 6dc8 e2   b
        jr      l6d89           ; 6dc9 18 be   .>

l6dcb:  .db     0,0,0,0,0,0,10h,0,0fh,0,0,11h,0,0fh,0f0h,1,12h,10h      ; 6dcb 00 00 00 00 00 00 10 00 0f 00 00 11 00 0f f0 01 12 10   ..............p...
        .db     0ffh,0efh,1,12h,10h,0ffh,0efh,1,12h,10h,0ffh,0efh,1,12h ; 6ddd ff ef 01 12 10 ff ef 01 12 10 ff ef 01 12   .o....o....o..
        .db     10h,0ffh,0efh,1,12h,10h,0ffh,0efh,1,12h,10h,0ffh,0efh,1 ; 6deb 10 ff ef 01 12 10 ff ef 01 12 10 ff ef 01   ..o....o....o.
        .db     12h,10h,0ffh,0efh,1,12h,10h,0ffh,0efh   ; 6df9 12 10 ff ef 01 12 10 ff ef   ...o....o
; Frequency Octave Table
;  The following 6 octaves of 12 values each
;  comprise a 72 data word table.
l6e02:  .db     0,0fh           ; 6e02 00 0f   ..
        .dw     2ch,9ch,106h,16bh,1c9h,223h,277h,2c6h,312h,356h,39bh,3dah       ; 6e04 2c 00 9c 00 06 01 6b 01 c9 01 23 02 77 02 c6 02 12 03 56 03 9b 03 da 03   ,.....k.I.#.w.F...V...Z.
        .dw     416h,44eh,483h,4b5h,4e5h,511h,53bh,563h,589h,5ach,5ceh,5edh     ; 6e1c 16 04 4e 04 83 04 b5 04 e5 04 11 05 3b 05 63 05 89 05 ac 05 ce 05 ed 05   ..N...5.e...;.c...,.N.m.
        .dw     60ah,627h,642h,65bh,672h,689h,69eh,6b2h,6c4h,6d6h,6e7h,6f7h     ; 6e34 0a 06 27 06 42 06 5b 06 72 06 89 06 9e 06 b2 06 c4 06 d6 06 e7 06 f7 06   ..'.B.[.r.....2.D.V.g.w.
        .dw     706h,714h,721h,72dh,739h,744h,74fh,759h,762h,76bh,773h,77bh     ; 6e4c 06 07 14 07 21 07 2d 07 39 07 44 07 4f 07 59 07 62 07 6b 07 73 07 7b 07   ....!.-.9.D.O.Y.b.k.s.{.
        .dw     783h,78ah,790h,797h,79dh,7a2h,7a7h,7ach,7b1h,7b6h,7bah,7beh     ; 6e64 83 07 8a 07 90 07 97 07 9d 07 a2 07 a7 07 ac 07 b1 07 b6 07 ba 07 be 07   ..........".'.,.1.6.:.>.
        .dw     7c1h,7c4h,7c8h,7cbh,7ceh,7d1h,7d4h,7d6h,7d9h,7dbh,7ddh,7dfh     ; 6e7c c1 07 c4 07 c8 07 cb 07 ce 07 d1 07 d4 07 d6 07 d9 07 db 07 dd 07 df 07   A.D.H.K.N.Q.T.V.Y.[.]._.

l6e94:  .db     0,0,0,0,0,0c0h,0a1h,0,3ah,0,0c0h,0b1h,0,29h,1,0c0h      ; 6e94 00 00 00 00 00 c0 a1 00 3a 00 c0 b1 00 29 01 c0   .....@!.:.@1.).@
        .db     61h,0,3ah,0,0c0h        ; 6ea4 61 00 3a 00 c0   a.:.@
l6ea9:  .db     12h,34h,45h,67h,9ah,0bch,0deh,0feh,98h,7ah,0b7h,0beh    ; 6ea9 12 34 45 67 9a bc de fe 98 7a b7 be   .4Eg.<^..z7>
        .db     0a8h,76h,54h,31h,1,23h,44h,55h,67h,88h,9ah,0bbh,0a9h,88h        ; 6eb5 a8 76 54 31 01 23 44 55 67 88 9a bb a9 88   (vT1.#DUg..;).
        .db     76h,55h,44h,33h,22h,11h ; 6ec3 76 55 44 33 22 11   vUD3".
l6ec9:  .db     1,23h,45h,67h,89h,0abh,0cdh,0efh,0feh,0dch,0bah,98h     ; 6ec9 01 23 45 67 89 ab cd ef fe dc ba 98   .#Eg.+Mo.\:.
        .db     76h,54h,32h,10h ; 6ed5 76 54 32 10   vT2.
l6ed9:  .db     0a1h,82h,23h,34h,45h,56h,67h,78h,89h,9ah,0abh,0bch      ; 6ed9 a1 82 23 34 45 56 67 78 89 9a ab bc   !.#4EVgx..+<
        .db     0cdh,64h,32h,10h        ; 6ee5 cd 64 32 10   Md2.
l6ee9:  .db     11h,23h,56h,78h,99h,98h,76h,67h,9ah,0dfh,0feh,0c9h      ; 6ee9 11 23 56 78 99 98 76 67 9a df fe c9   .#Vx..vg._.I
        .db     85h,42h,11h,31h ; 6ef5 85 42 11 31   .B.1
l6ef9:  .db     2,4,8,10h,20h,40h,0ch,18h,30h,5,0,1     ; 6ef9 02 04 08 10 20 40 0c 18 30 05 00 01   .... @..0...
l6f05:  .db     3,5,0ah,14h,28h,50h,0fh,1eh,3ch ; 6f05 03 05 0a 14 28 50 0f 1e 3c   ....(P..<
l6f0e:  .db     3,6,0ch,18h,30h,60h,12h,24h,48h,8,10h,0,7,0eh,1ch       ; 6f0e 03 06 0c 18 30 60 12 24 48 08 10 00 07 0e 1c   ....0`.$H......
        .db     38h,70h,15h,2ah,54h,4,8,10h,20h,40h,80h,18h,30h,60h     ; 6f1d 38 70 15 2a 54 04 08 10 20 40 80 18 30 60   8p.*T... @..0`
l6f2b:  .db     4,9,12h,24h,48h,90h,1bh,36h,6ch,0ch,18h,4,0ah,14h       ; 6f2b 04 09 12 24 48 90 1b 36 6c 0c 18 04 0a 14   ...$H..6l.....
        .db     28h,50h,0a0h,1eh,3ch,78h        ; 6f39 28 50 a0 1e 3c 78   (P .<x
l6f3f:  .db     0               ; 6f3f 00   .
        .dw     l6f0e,l7cf9,l7cff,l7d11,l7d21   ; 6f40 0e 6f f9 7c ff 7c 11 7d 21 7d   .oy|.|.}!}
l6f4a:  .db     0               ; 6f4a 00   .
        .dw     l6f05,l7e48,l7e44,l7e4a,l7e4c   ; 6f4b 05 6f 48 7e 44 7e 4a 7e 4c 7e   .oH.D.J.L.
l6f55:  .db     0               ; 6f55 00   .
        .dw     l6f0e,l763b,l7633,l7641,l7663   ; 6f56 0e 6f 3b 76 33 76 41 76 63 76   .o;v3vAvcv
l6f60:  .db     0               ; 6f60 00   .
        .dw     l6ef9,l7600,l75fc,l7602,0       ; 6f61 f9 6e 00 76 fc 75 02 76 00 00   yn.v|u.v..
l6f6b:  .db     0               ; 6f6b 00   .
        .dw     l6f0e,l714c,l7142,l7156,l7162   ; 6f6c 0e 6f 4c 71 42 71 56 71 62 71   .oLqBqVqbq
l6f76:  .db     0               ; 6f76 00   .
        .dw     l6f0e,l72c6,l72b8,l72d4,l7302   ; 6f77 0e 6f c6 72 b8 72 d4 72 02 73   .oFr8rTr.s
l6f81:  .db     0               ; 6f81 00   .
        .dw     l6f0e,l7008,l6ffa,0,0   ; 6f82 0e 6f 08 70 fa 6f 00 00 00 00   .o.pzo....
l6f8c:  .db     0               ; 6f8c 00   .
        .dw     l6f05,l7e9d,l7e91,l7ea9,l7eb5   ; 6f8d 05 6f 9d 7e 91 7e a9 7e b5 7e   .o....).5.
l6f97:  .db     0               ; 6f97 00   .
        .dw     l6f0e,l7c28,l7c24,l7c2a,l7c2c   ; 6f98 0e 6f 28 7c 24 7c 2a 7c 2c 7c   .o(|$|*|,|
l6fa2:  .db     0               ; 6fa2 00   .
        .dw     l6f0e,0,l7a00,0,0       ; 6fa3 0e 6f 00 00 00 7a 00 00 00 00   .o...z....
l6fad:  .db     0               ; 6fad 00   .
        .dw     l6f0e,0,l7a26,l7a2a,0   ; 6fae 0e 6f 00 00 26 7a 2a 7a 00 00   .o..&z*z..
l6fb8:  .db     0               ; 6fb8 00   .
        .dw     l6f0e,l7a73,l7a6f,l7a75,0       ; 6fb9 0e 6f 73 7a 6f 7a 75 7a 00 00   .oszozuz..
l6fc3:  .db     0               ; 6fc3 00   .
        .dw     l6f0e,l7adf,l7ae3,l7ae5,l7ae7   ; 6fc4 0e 6f df 7a e3 7a e5 7a e7 7a   .o_zczezgz
l6fce:  .db     0               ; 6fce 00   .
        .dw     l6f0e,l7b65,l7b6b,l7b6f,l7b73   ; 6fcf 0e 6f 65 7b 6b 7b 6f 7b 73 7b   .oe{k{o{s{
l6fd9:  .db     0               ; 6fd9 00   .
        .dw     l6f0e,l786c,l7876,l787e,l7886   ; 6fda 0e 6f 6c 78 76 78 7e 78 86 78   .olxvx.x.x
l6fe4:  .db     0               ; 6fe4 00   .
        .dw     l6f2b,l7543,l754b,l7551,0       ; 6fe5 2b 6f 43 75 4b 75 51 75 00 00   +oCuKuQu..
l6fef:  .db     0               ; 6fef 00   .
        .dw     l6f0e,l758d,l7595,l759b,0       ; 6ff0 0e 6f 8d 75 95 75 9b 75 00 00   .o.u.u.u..
l6ffa:  .dw     l7016,l7034,l7016,l704d,l7093,0ffffh,l6ffa      ; 6ffa 16 70 34 70 16 70 4d 70 93 70 ff ff fa 6f   .p4p.pMp.p..zo
l7008:  .dw     l7062,l7074,l7062,l7085,l70f4,0ffffh,l7008      ; 7008 62 70 74 70 62 70 85 70 f4 70 ff ff 08 70   bptpbp.ptp...p
l7016:  .dw     l749d           ; 7016 9d 74   .t
        .db     0,41h,0a2h,44h,4ch,56h,4ch,42h,4ch,44h,4ch,3eh,4ch,3ch,4ch      ; 7018 00 41 a2 44 4c 56 4c 42 4c 44 4c 3e 4c 3c 4c   .A"DLVLBLDL>L<L
        .db     44h,4ch,56h,4ch,42h,4ch,44h,4ch,3eh,4ch,3ch,4ch,0       ; 7027 44 4c 56 4c 42 4c 44 4c 3e 4c 3c 4c 00   DLVLBLDL>L<L.
l7034:  .db     44h,4ch,44h,3eh,4eh,48h,42h,48h,42h,3ah,4ch,44h,3eh     ; 7034 44 4c 44 3e 4e 48 42 48 42 3a 4c 44 3e   DLD>NHBHB:LD>
        .db     4ch,48h,44h,42h,3eh,3ch,34h,3ch,42h,4ch,48h,0   ; 7041 4c 48 44 42 3e 3c 34 3c 42 4c 48 00   LHDB><4<BLH.
l704d:  .db     44h,4ch,44h,3eh,4eh,48h,42h,48h,42h,3ah,52h,48h,4ch     ; 704d 44 4c 44 3e 4e 48 42 48 42 3a 52 48 4c   DLD>NHBHB:RHL
        .db     52h,4ch,44h,3ah,42h,0a8h,44h,0  ; 705a 52 4c 44 3a 42 a8 44 00   RLD:B(D.
l7062:  .db     9dh,64h,0,41h,0a3h,26h,3eh,3ch,26h,2ch,34h,3eh,36h      ; 7062 9d 64 00 41 a3 26 3e 3c 26 2c 34 3e 36   .d.A#&><&,4>6
        .db     34h,3eh,2ch,34h,0       ; 706f 34 3e 2c 34 00   4>,4.
l7074:  .db     26h,3eh,30h,22h,3ah,2ch,1eh,36h,30h,0a2h,34h,36h,34h    ; 7074 26 3e 30 22 3a 2c 1e 36 30 a2 34 36 34   &>0":,.60"464
        .db     30h,2ch,2ah,0   ; 7081 30 2c 2a 00   0,*.
l7085:  .db     0a3h,26h,3eh,30h,22h,3ah,2ah,2ch,34h,34h,2ch,22h,14h    ; 7085 a3 26 3e 30 22 3a 2a 2c 34 34 2c 22 14   #&>0":*,44,".
        .db     0               ; 7092 00   .
l7093:  .db     0a2h,52h,4eh,4ch,48h,44h,42h,44h,48h,4ch,44h,48h,4eh    ; 7093 a2 52 4e 4c 48 44 42 44 48 4c 44 48 4e   "RNLHDBDHLDHN
        .db     4ch,4eh,0a3h,52h,42h,0a2h,44h,48h,0a3h,4ch,48h,4ch,56h,50h      ; 70a0 4c 4e a3 52 42 a2 44 48 a3 4c 48 4c 56 50   LN#RB"DH#LHLVP
        .db     0a2h,56h,5ah,0a3h,5ch,5ah,0a2h,56h,52h,50h,4ch,50h,4ah,0a8h     ; 70ae a2 56 5a a3 5c 5a a2 56 52 50 4c 50 4a a8   "VZ#\Z"VRPLPJ(
        .db     4ch,0a7h,52h,0a1h,56h,58h,0a3h,56h,0a2h,52h,4eh,52h,4ch ; 70bc 4c a7 52 a1 56 58 a3 56 a2 52 4e 52 4c   L'R!VX#V"RNRL
        .db     4eh,48h,0a7h,56h,0a1h,5ah,5ch,0a3h,5ah,0a2h,56h,54h,56h ; 70c9 4e 48 a7 56 a1 5a 5c a3 5a a2 56 54 56   NH'V!Z\#Z"VTV
        .db     50h,54h,4ch,5ah,54h,4ch,54h,5ah,60h,66h,54h,64h,54h,60h ; 70d6 50 54 4c 5a 54 4c 54 5a 60 66 54 64 54 60   PTLZTLTZ`fTdT`
        .db     54h,0a3h,5ch,0a2h,60h,5ch,5ah,5ch,0a1h,56h,5ah,0a4h,56h ; 70e4 54 a3 5c a2 60 5c 5a 5c a1 56 5a a4 56   T#\"`\Z\!VZ$V
        .db     0a2h,1,0        ; 70f1 a2 01 00   "..
l70f4:  .db     0a2h,34h,3ah,44h,3ah,30h,3ah,34h,3ah,2ch,3ah,2ah,3ah    ; 70f4 a2 34 3a 44 3a 30 3a 34 3a 2c 3a 2a 3a   "4:D:0:4:,:*:
        .db     2ch,3ah,44h,3ah,30h,3ah,34h,3ah,2ch,3ah,2ah,3ah,2ch,34h ; 7101 2c 3a 44 3a 30 3a 34 3a 2c 3a 2a 3a 2c 34   ,:D:0:4:,:*:,4
        .db     2ch,26h,3eh,38h,32h,38h,2ah,38h,32h,38h,0a3h,34h,42h,2ah        ; 710f 2c 26 3e 38 32 38 2a 38 32 38 a3 34 42 2a   ,&>828*828#4B*
        .db     0a2h,34h,3ah,42h,3ah,30h,3ah,2eh,34h,26h,34h,2eh,34h,0a8h       ; 711d a2 34 3a 42 3a 30 3a 2e 34 26 34 2e 34 a8   "4:B:0:.4&4.4(
        .db     30h,0a2h,32h,38h,2ah,38h,32h,38h,0a8h,34h,0a3h,34h,2ah,24h      ; 712b 30 a2 32 38 2a 38 32 38 a8 34 a3 34 2a 24   0"28*828(4#4*$
        .db     1ch,20h,24h,2ch,30h,34h,0a8h,26h,0      ; 7139 1c 20 24 2c 30 34 a8 26 00   . $,04(&.

l7142:  .dw     l7168,l7168,l71ae,0ffffh,l7142  ; 7142 68 71 68 71 ae 71 ff ff 42 71   hqhq.q..Bq
l714c:  .dw     l71cb,l71cb,l721d,0ffffh,l714c  ; 714c cb 71 cb 71 1d 72 ff ff 4c 71   KqKq.r..Lq
l7156:  .dw     l723a,l723a,l727f,l727f,0ffffh,l7156    ; 7156 3a 72 3a 72 7f 72 7f 72 ff ff 56 71   :r:r.r.r..Vq
l7162:  .dw     l72a3,0ffffh,l7162      ; 7162 a3 72 ff ff 62 71   #r..bq
l7168:  .db     9dh,84h,0,81h,0a3h,52h,0a2h,48h,4ah,0a3h,4eh,0a2h       ; 7168 9d 84 00 81 a3 52 a2 48 4a a3 4e a2   ....#R"HJ#N"
        .db     4ah,48h,0a3h,44h,0a2h,44h,4ah,0a3h,52h,0a2h,4eh,4ah,0a7h        ; 7174 4a 48 a3 44 a2 44 4a a3 52 a2 4e 4a a7   JH#D"DJ#R"NJ'
        .db     48h,0a2h,4ah,0a3h,4eh,52h,0a3h,4ah,44h,44h,1,0a2h,1,0a3h        ; 7181 48 a2 4a a3 4e 52 a3 4a 44 44 01 a2 01 a3   H"J#NR#JDD.".#
        .db     4eh,0a2h,54h,0a3h,5ch,0a2h,58h,54h,0a7h,52h,0a2h,4ah,0a3h       ; 718f 4e a2 54 a3 5c a2 58 54 a7 52 a2 4a a3   N"T#\"XT'R"J#
        .db     52h,0a2h,4eh,4ah,0a3h,48h,0a2h,48h,4ah,0a3h,4eh,52h,0a3h        ; 719c 52 a2 4e 4a a3 48 a2 48 4a a3 4e 52 a3   R"NJ#H"HJ#NR#
        .db     4ah,44h,44h,1,0 ; 71a9 4a 44 44 01 00   JDD..
l71ae:  .db     9dh,50h,0,81h,0a4h,3ah,32h,36h,30h,0a4h,32h,2ch,0a8h    ; 71ae 9d 50 00 81 a4 3a 32 36 30 a4 32 2c a8   .P..$:260$2,(
        .db     2ah,0a3h,1,0a4h,3ah,32h,36h,30h,0a3h,32h,3ah,0a4h,44h,42h       ; 71bb 2a a3 01 a4 3a 32 36 30 a3 32 3a a4 44 42   *#.$:260#2:$DB
        .db     1,0             ; 71c9 01 00   ..
l71cb:  .db     9dh,43h,0,81h,0a3h,48h,0a2h,42h,44h,48h,0a1h,52h,4eh    ; 71cb 9d 43 00 81 a3 48 a2 42 44 48 a1 52 4e   .C..#H"BDH!RN
        .db     0a2h,44h,42h,0a7h,3ah,0a2h,44h,4ah,1,0a2h,48h,44h,0a1h,42h      ; 71d8 a2 44 42 a7 3a a2 44 4a 01 a2 48 44 a1 42   "DB':"DJ."HD!B
        .db     42h,0a2h,3ah,42h,44h,0a3h,48h,4ah,0a3h,44h,3ah,3ah,1,0a2h       ; 71e6 42 a2 3a 42 44 a3 48 4a a3 44 3a 3a 01 a2   B":BD#HJ#D::."
        .db     1eh,0a3h,3ch,0a2h,44h,4ah,0a1h,4ah,4ah,0a2h,48h,44h,0a7h        ; 71f4 1e a3 3c a2 44 4a a1 4a 4a a2 48 44 a7   .#<"DJ!JJ"HD'
        .db     40h,0a2h,3ah,40h,0a1h,44h,40h,0a2h,3ch,3ah,42h,3ah,42h,44h      ; 7201 40 a2 3a 40 a1 44 40 a2 3c 3a 42 3a 42 44   @":@!D@"<:B:BD
        .db     48h,42h,4ah,42h,0a1h,44h,4ah,3ah,1,0a3h,3ah,3ah,1,0     ; 720f 48 42 4a 42 a1 44 4a 3a 01 a3 3a 3a 01 00   HBJB!DJ:.#::..
l721d:  .db     9dh,30h,0,81h,0a4h,32h,2ch,30h,2ah,2ch,22h,0a4h,22h     ; 721d 9d 30 00 81 a4 32 2c 30 2a 2c 22 a4 22   .0..$2,0*,"$"
        .db     0a3h,30h,1,0a4h,32h,2ch,30h,2ah,0a3h,2ch,32h,0a4h,3ah,36h       ; 722a a3 30 01 a4 32 2c 30 2a a3 2c 32 a4 3a 36   #0.$2,0*#,2$:6
        .db     1,0             ; 7238 01 00   ..
l723a:  .db     9dh,0c9h,6eh,20h,0a2h,22h,3ah,22h,3ah,22h,3ah,22h       ; 723a 9d c9 6e 20 a2 22 3a 22 3a 22 3a 22   .In "":":":"
        .db     3ah,2ch,44h,2ch,44h,2ch,44h,2ch,44h,2ah,42h,2ah,42h,22h ; 7246 3a 2c 44 2c 44 2c 44 2c 44 2a 42 2a 42 22   :,D,D,D,D*B*B"
        .db     3ah,22h,3ah,2ch,44h,2ch,44h,2ch,44h,30h,32h,36h,1eh,1,1eh       ; 7254 3a 22 3a 2c 44 2c 44 2c 44 30 32 36 1e 01 1e   :":,D,D,D026...
        .db     1,1eh,2ch,24h,1ah,32h,1,32h,1ah,28h,28h,1,30h,48h,1,48h ; 7263 01 1e 2c 24 1a 32 01 32 1a 28 28 01 30 48 01 48   ..,$.2.2.((.0H.H
        .db     1,3ah,1,42h,2ch,3ah,2ch,3ah,0a3h,2ch,1,0        ; 7273 01 3a 01 42 2c 3a 2c 3a a3 2c 01 00   .:.B,:,:#,..
l727f:  .db     9dh,0c9h,6eh,20h,0a2h,44h,52h,44h,52h,44h,52h,44h       ; 727f 9d c9 6e 20 a2 44 52 44 52 44 52 44   .In "DRDRDRD
        .db     52h,42h,52h,42h,52h,42h,52h,42h,52h,44h,52h,44h,52h,44h ; 728b 52 42 52 42 52 42 52 42 52 44 52 44 52 44   RBRBRBRBRDRDRD
        .db     52h,44h,52h,42h,52h,42h,52h,0a4h,1,0    ; 7299 52 44 52 42 52 42 52 a4 01 00   RDRBRBR$..
l72a3:  .db     0a2h,1,6,1,6,1,0a1h,6,6,0a2h,1,6,1,6,1,6,1,6,6,6,0      ; 72a3 a2 01 06 01 06 01 a1 06 06 a2 01 06 01 06 01 06 01 06 06 06 00   ".....!.."...........

l72b8:  .dw     l730b,l733f,l7367,l7367,l73c9,0ffffh,l72b8      ; 72b8 0b 73 3f 73 67 73 67 73 c9 73 ff ff b8 72   .s?sgsgsIs..8r
l72c6:  .dw     l7308,l733c,l738e,l738e,l744b,0ffffh,l72c6      ; 72c6 08 73 3c 73 8e 73 8e 73 4b 74 ff ff c6 72   .s<s.s.sKt..Fr
l72d4:  .dw     l731f,l7353,l73b5,l73b5,l73b5,l73b5,l73b5,l73b5,l74c0   ; 72d4 1f 73 53 73 b5 73 b5 73 b5 73 b5 73 b5 73 b5 73 c0 74   .sSs5s5s5s5s5s5s@t
        .dw     l74de,l74de,l74de,l74ee,l74fe,l74fe,l750e,l750e,l751e,l751e     ; 72e6 de 74 de 74 de 74 ee 74 fe 74 fe 74 0e 75 0e 75 1e 75 1e 75   ^t^t^tnt.t.t.u.u.u.u
        .dw     l750e,l752e,0ffffh,l72d4        ; 72fa 0e 75 2e 75 ff ff d4 72   .u.u..Tr
l7302:  .dw     l7333,0ffffh,l7302      ; 7302 33 73 ff ff 02 73   3s...s
l7308:  .db     0a5h,1,0        ; 7308 a5 01 00   %..
l730b:  .db     9dh,62h,0,80h,0a2h,3ah,0a1h,3ah,3ah,0a2h,30h,30h,3ah    ; 730b 9d 62 00 80 a2 3a a1 3a 3a a2 30 30 3a   .b..":!::"00:
        .db     0a1h,3ah,3ah,0a2h,30h,30h,0     ; 7318 a1 3a 3a a2 30 30 00   !::"00.
l731f:  .db     9dh,0e9h,6eh,0a0h,0a2h,3ah,0a1h,3ah,3ah,0a2h,30h,30h    ; 731f 9d e9 6e a0 a2 3a a1 3a 3a a2 30 30   .in ":!::"00
        .db     3ah,0a1h,3ah,3ah,0a2h,30h,30h,0 ; 732b 3a a1 3a 3a a2 30 30 00   :!::"00.
l7333:  .db     0a2h,6,0a1h,6,6,0a2h,6,6,0      ; 7333 a2 06 a1 06 06 a2 06 06 00   ".!.."...
l733c:  .db     0a5h,1,0        ; 733c a5 01 00   %..
l733f:  .db     9dh,32h,0,80h,0a2h,3ah,0a1h,3ah,3ah,0a2h,30h,30h,3ah    ; 733f 9d 32 00 80 a2 3a a1 3a 3a a2 30 30 3a   .2..":!::"00:
        .db     0a1h,3ah,3ah,0a2h,30h,30h,0     ; 734c a1 3a 3a a2 30 30 00   !::"00.
l7353:  .db     9dh,0e9h,6eh,0a0h,0a2h,3ah,0a1h,3ah,3ah,0a2h,30h,30h    ; 7353 9d e9 6e a0 a2 3a a1 3a 3a a2 30 30   .in ":!::"00
        .db     3ah,0a1h,3ah,3ah,0a2h,30h,30h,0 ; 735f 3a a1 3a 3a a2 30 30 00   :!::"00.
l7367:  .db     9dh,82h,0,80h,0a2h,3ah,48h,52h,50h,52h,0a1h,48h,48h     ; 7367 9d 82 00 80 a2 3a 48 52 50 52 a1 48 48   ....":HRPR!HH
        .db     0a2h,4ah,44h,48h,0a1h,40h,40h,0a2h,44h,3eh,40h,0a1h,3ah ; 7374 a2 4a 44 48 a1 40 40 a2 44 3e 40 a1 3a   "JDH!@@"D>@!:
        .db     3ah,0a2h,3eh,38h,3ah,30h,32h,38h,3ah,30h,32h,3eh,0      ; 7381 3a a2 3e 38 3a 30 32 38 3a 30 32 3e 00   :">8:028:02>.
l738e:  .db     9dh,53h,0,40h,0a2h,30h,40h,40h,44h,40h,0a1h,3eh,40h     ; 738e 9d 53 00 40 a2 30 40 40 44 40 a1 3e 40   .S.@"0@@D@!>@
        .db     0a2h,44h,3eh,40h,0a1h,38h,3ah,0a2h,3eh,38h,3ah,0a1h,2eh ; 739b a2 44 3e 40 a1 38 3a a2 3e 38 3a a1 2e   "D>@!8:">8:!.
        .db     30h,0a2h,38h,30h,30h,28h,2ch,2ch,30h,28h,2ch,38h,0      ; 73a8 30 a2 38 30 30 28 2c 2c 30 28 2c 38 00   0"800(,,0(,8.
l73b5:  .db     9dh,0e9h,6eh,0a0h,0a2h,3ah,0a1h,3ah,3ah,0a2h,30h,30h    ; 73b5 9d e9 6e a0 a2 3a a1 3a 3a a2 30 30   .in ":!::"00
        .db     3ah,0a1h,3ah,3ah,0a2h,30h,30h,0 ; 73c1 3a a1 3a 3a a2 30 30 00   :!::"00.
l73c9:  .db     0a8h,3ah,0a2h,3eh,38h,0a8h,3ah,0a3h,3eh,0a2h,40h,0a1h   ; 73c9 a8 3a a2 3e 38 a8 3a a3 3e a2 40 a1   (:">8(:#>"@!
        .db     40h,40h,0a2h,44h,3eh,40h,0a1h,40h,40h,0a2h,44h,3eh,0a8h ; 73d5 40 40 a2 44 3e 40 a1 40 40 a2 44 3e a8   @@"D>@!@@"D>(
        .db     40h,0a3h,44h,0a2h,48h,0a1h,48h,48h,0a2h,4ah,44h,48h,0a1h        ; 73e2 40 a3 44 a2 48 a1 48 48 a2 4a 44 48 a1   @#D"H!HH"JDH!
        .db     48h,48h,0a2h,4ah,44h,0a8h,48h,0a3h,4ch,0a2h,4eh,0a1h,4eh        ; 73ef 48 48 a2 4a 44 a8 48 a3 4c a2 4e a1 4e   HH"JD(H#L"N!N
        .db     4eh,0a2h,4eh,4eh,52h,4eh,4eh,4ch,4eh,0a1h,4eh,4eh,0a2h,4eh      ; 73fc 4e a2 4e 4e 52 4e 4e 4c 4e a1 4e 4e a2 4e   N"NNRNNLN!NN"N
        .db     4eh,52h,4eh,4eh,4ch,4eh,0a1h,4eh,4eh,0a2h,4eh,4eh,4ch,0a1h      ; 740a 4e 52 4e 4e 4c 4e a1 4e 4e a2 4e 4e 4c a1   NRNNLN!NN"NNL!
        .db     4ch,4ch,0a2h,4ch,4ch,4ah,0a1h,4ah,4ah,0a2h,4ah,44h,3eh,40h      ; 7418 4c 4c a2 4c 4c 4a a1 4a 4a a2 4a 44 3e 40   LL"LLJ!JJ"JD>@
        .db     44h,36h,44h,0a1h,40h,40h,0a2h,36h,0a3h,40h,0a1h,36h,3ah ; 7426 44 36 44 a1 40 40 a2 36 a3 40 a1 36 3a   D6D!@@"6#@!6:
        .db     0a2h,36h,30h,44h,0a1h,40h,40h,0a2h,36h,0a3h,40h,0a1h,36h        ; 7433 a2 36 30 44 a1 40 40 a2 36 a3 40 a1 36   "60D!@@"6#@!6
        .db     3ah,0a2h,36h,2eh,0a5h,36h,0a8h,1,0a3h,38h,0     ; 7440 3a a2 36 2e a5 36 a8 01 a3 38 00   :"6.%6(.#8.
l744b:  .db     0a8h,30h,0a2h,30h,30h,0a8h,30h,0a3h,36h,0a5h,1,0a8h     ; 744b a8 30 a2 30 30 a8 30 a3 36 a5 01 a8   (0"00(0#6%.(
        .db     1,0a3h,3eh,0a2h,40h,0a1h,40h,40h,0a2h,44h,3eh,40h,0a1h,40h      ; 7457 01 a3 3e a2 40 a1 40 40 a2 44 3e 40 a1 40   .#>"@!@@"D>@!@
        .db     40h,0a2h,44h,3eh,0a8h,36h,0a3h,3ah,0a2h,3eh,0a1h,40h,44h        ; 7465 40 a2 44 3e a8 36 a3 3a a2 3e a1 40 44   @"D>(6#:">!@D
        .db     0a2h,3eh,44h,48h,48h,48h,3ah,3eh,0a1h,40h,44h,0a2h,3eh,44h      ; 7472 a2 3e 44 48 48 48 3a 3e a1 40 44 a2 3e 44   ">DHHH:>!@D">D
        .db     46h,46h,46h,3ah,3eh,0a1h,40h,44h,0a2h,3eh,44h,3ah,0a1h,3eh      ; 7480 46 46 46 3a 3e a1 40 44 a2 3e 44 3a a1 3e   FFF:>!@D">D:!>
        .db     40h,0a2h,3ah,40h,3ah,0a1h,3eh,40h,0a2h,3eh,3eh,2ch,3ah,3eh      ; 748e 40 a2 3a 40 3a a1 3e 40 a2 3e 3e 2c 3a 3e   @":@:!>@">>,:>
        .db     26h             ; 749c 26   &
l749d:  .db     30h,0a1h,30h,30h,0a2h,30h,0a3h,30h,0a1h,30h,34h,0a2h    ; 749d 30 a1 30 30 a2 30 a3 30 a1 30 34 a2   0!00"0#0!04"
        .db     30h,28h,2eh,0a1h,2eh,2eh,0a2h,2eh,0a3h,2eh,0a1h,2eh,32h ; 74a9 30 28 2e a1 2e 2e a2 2e a3 2e a1 2e 32   0(.!..".#.!.2
        .db     0a2h,2eh,28h,0a5h,26h,0a8h,1,0a3h,2ch,0 ; 74b6 a2 2e 28 a5 26 a8 01 a3 2c 00   ".(%&(.#,.
l74c0:  .db     0a2h,3ah,0a1h,3ah,3ah,0a2h,32h,2ch,3ah,0a1h,3ah,3ah     ; 74c0 a2 3a a1 3a 3a a2 32 2c 3a a1 3a 3a   ":!::"2,:!::
        .db     0a2h,38h,30h,3ah,0a1h,3ah,3ah,0a2h,32h,2ch,3ah,0a1h,3ah ; 74cc a2 38 30 3a a1 3a 3a a2 32 2c 3a a1 3a   "80:!::"2,:!:
        .db     3ah,0a2h,2ch,1eh,0      ; 74d9 3a a2 2c 1e 00   :",..
l74de:  .db     0a2h,28h,0a1h,40h,28h,0a2h,1eh,36h,28h,0a1h,40h,28h     ; 74de a2 28 a1 40 28 a2 1e 36 28 a1 40 28   "(!@(".6(!@(
        .db     0a2h,1eh,36h,0  ; 74ea a2 1e 36 00   ".6.
l74ee:  .db     0a2h,28h,0a1h,40h,28h,0a2h,1eh,36h,28h,0a1h,40h,28h     ; 74ee a2 28 a1 40 28 a2 1e 36 28 a1 40 28   "(!@(".6(!@(
        .db     0a2h,2ch,44h,0  ; 74fa a2 2c 44 00   ",D.
l74fe:  .db     0a2h,1eh,0a1h,36h,1eh,0a2h,1eh,36h,28h,0a1h,40h,28h     ; 74fe a2 1e a1 36 1e a2 1e 36 28 a1 40 28   ".!6.".6(!@(
        .db     0a2h,28h,40h,0  ; 750a a2 28 40 00   "(@.
l750e:  .db     0a2h,1eh,0a1h,36h,1eh,0a2h,1eh,36h,1eh,0a1h,36h,1eh     ; 750e a2 1e a1 36 1e a2 1e 36 1e a1 36 1e   ".!6.".6.!6.
        .db     0a2h,1eh,36h,0  ; 751a a2 1e 36 00   ".6.
l751e:  .db     0a2h,22h,0a1h,3ah,22h,0a2h,22h,3ah,22h,0a1h,3ah,22h     ; 751e a2 22 a1 3a 22 a2 22 3a 22 a1 3a 22   ""!:""":"!:"
        .db     0a2h,22h,3ah,0  ; 752a a2 22 3a 00   "":.
l752e:  .db     0a2h,1eh,0a1h,36h,1eh,0a2h,1eh,36h,1eh,0a1h,36h,1eh     ; 752e a2 1e a1 36 1e a2 1e 36 1e a1 36 1e   ".!6.".6.!6.
        .db     0a2h,0a4h,3eh,0,36h,3eh,44h,0a4h,44h    ; 753a a2 a4 3e 00 36 3e 44 a4 44   "$>.6>D$D

l7543:  .dw     l7557           ; 7543 57 75   Wu
l7545:  .dw     l7562,0ffffh,l7545      ; 7545 62 75 ff ff 45 75   bu..Eu
l754b:  .dw     l755e,0ffffh,l754b      ; 754b 5e 75 ff ff 4b 75   ^u..Ku
l7551:  .dw     l757c,0ffffh,l7551      ; 7551 7c 75 ff ff 51 75   |u..Qu
l7557:  .db     9dh,20h,0,81h,0aah,1,0  ; 7557 9d 20 00 81 aa 01 00   . ..*..
l755e:  .db     9dh,70h,0,81h   ; 755e 9d 70 00 81   .p..
l7562:  .db     0a2h,42h,32h,38h,42h,46h,34h,3ch,46h,4ah,38h,42h,4ah    ; 7562 a2 42 32 38 42 46 34 3c 46 4a 38 42 4a   "B28BF4<FJ8BJ
        .db     4ch,3ch,42h,4ch,46h,34h,3ch,46h,40h,2eh,34h,40h,0       ; 756f 4c 3c 42 4c 46 34 3c 46 40 2e 34 40 00   L<BLF4<F@.4@.
l757c:  .db     9dh,0e9h,6eh,21h,0a8h,42h,0a3h,2ah,0a8h,42h,0a3h,2ah    ; 757c 9d e9 6e 21 a8 42 a3 2a a8 42 a3 2a   .in!(B#*(B#*
        .db     0a8h,42h,0a3h,2ah,0     ; 7588 a8 42 a3 2a 00   (B#*.

l758d:  .dw     l75a1           ; 758d a1 75   !u
l758f:  .dw     l75ac,0ffffh,l758f      ; 758f ac 75 ff ff 8f 75   ,u...u
l7595:  .dw     l75a8,0ffffh,l7595      ; 7595 a8 75 ff ff 95 75   (u...u
l759b:  .dw     l75ee,0ffffh,l759b      ; 759b ee 75 ff ff 9b 75   nu...u
l75a1:  .db     9dh,20h,0,81h,0aah,1,0  ; 75a1 9d 20 00 81 aa 01 00   . ..*..
l75a8:  .db     9dh,70h,0,81h   ; 75a8 9d 70 00 81   .p..
l75ac:  .db     0a2h,4ch,42h,50h,42h,54h,42h,50h,42h,56h,42h,54h,42h    ; 75ac a2 4c 42 50 42 54 42 50 42 56 42 54 42   "LBPBTBPBVBTB
        .db     50h,42h,54h,42h,4ch,42h,50h,42h,54h,42h,50h,42h,56h,42h ; 75b9 50 42 54 42 4c 42 50 42 54 42 50 42 56 42   PBTBLBPBTBPBVB
        .db     54h,42h,50h,42h,54h,42h,5ah,46h,56h,46h,54h,46h,50h,46h ; 75c7 54 42 50 42 54 42 5a 46 56 46 54 46 50 46   TBPBTBZFVFTFPF
        .db     4eh,46h,50h,46h,54h,46h,50h,46h,50h,3eh,4ch,3eh,4ch,3eh ; 75d5 4e 46 50 46 54 46 50 46 50 3e 4c 3e 4c 3e   NFPFTFPFP>L>L>
        .db     4ah,3eh,4ah,3eh,46h,3eh,4ah,3eh,50h,3eh,0       ; 75e3 4a 3e 4a 3e 46 3e 4a 3e 50 3e 00   J>J>F>J>P>.
l75ee:  .db     9dh,0e9h,6eh,21h,0a5h,4ch,4ah,46h,42h,38h,3eh,42h       ; 75ee 9d e9 6e 21 a5 4c 4a 46 42 38 3e 42   .in!%LJFB8>B
        .db     42h,0           ; 75fa 42 00   B.

l75fc:  .dw     l7604,0         ; 75fc 04 76 00 00   .v..
l7600:  .dw     l7614           ; 7600 14 76   .v
l7602:  .dw     l7623           ; 7602 23 76   #v
l7604:  .db     9dh,0b2h,0,80h,0a2h,60h,5ch,60h,5ch,60h,62h,60h,5ch     ; 7604 9d b2 00 80 a2 60 5c 60 5c 60 62 60 5c   .2.."`\`\`b`\
        .db     0a4h,60h,0      ; 7611 a4 60 00   $`.
l7614:  .db     9dh,92h,0,80h,0a2h,52h,4eh,52h,4eh,52h,54h,52h,4eh      ; 7614 9d 92 00 80 a2 52 4e 52 4e 52 54 52 4e   ...."RNRNRTRN
        .db     0a4h,52h        ; 7621 a4 52   $R
l7623:  .db     9dh,0e9h,6eh,20h,0a2h,62h,60h,62h,60h,62h,66h,62h       ; 7623 9d e9 6e 20 a2 62 60 62 60 62 66 62   .in "b`b`bfb
        .db     60h,0a3h,62h,1  ; 762f 60 a3 62 01   `#b.

l7633:  .dw     l766f,l7769,l7769,0     ; 7633 6f 76 69 77 69 77 00 00   oviwiw..
l763b:  .dw     l76bf,l77aa,l783c       ; 763b bf 76 aa 77 3c 78   ?v*w<x
l7641:  .dw     l770c,l77eb,l77eb,l77f5,l77eb,l77eb,l77fe,l77f5,l77eb   ; 7641 0c 77 eb 77 eb 77 f5 77 eb 77 eb 77 fe 77 f5 77 eb 77   .wkwkwuwkwkw.wuwkw
        .dw     l77eb,l77fe,l77f5,l7807,l7811,l77fe,l77f5,l77eb ; 7653 eb 77 fe 77 f5 77 07 78 11 78 fe 77 f5 77 eb 77   kw.wuw.x.x.wuwkw
l7663:  .dw     l775b,l775b,l781a,l781a,l781a,l781a     ; 7663 5b 77 5b 77 1a 78 1a 78 1a 78 1a 78   [w[w.x.x.x.x
l766f:  .db     9dh,0c3h,0,80h,0a2h,3ch,3eh,3ch,3eh,38h,50h,0a3h,1      ; 766f 9d c3 00 80 a2 3c 3e 3c 3e 38 50 a3 01   .C.."<><>8P#.
        .db     0a2h,3ch,3eh,3ch,3eh,38h,50h,0a3h,1,0a2h,1,48h,1,46h,1,42h      ; 767c a2 3c 3e 3c 3e 38 50 a3 01 a2 01 48 01 46 01 42   "<><>8P#.".H.F.B
        .db     1,46h,0a1h,42h,46h,0a2h,42h,42h,38h,0a3h,3ch,1,0a2h,3eh ; 768c 01 46 a1 42 46 a2 42 42 38 a3 3c 01 a2 3e   .F!BF"BB8#<.">
        .db     42h,3eh,42h,3ch,54h,0a3h,1,0a2h,3eh,42h,3eh,42h,3ch,54h ; 769a 42 3e 42 3c 54 a3 01 a2 3e 42 3e 42 3c 54   B>B<T#.">B>B<T
        .db     0a3h,1,0a2h,1,56h,1,54h,1,54h,1,50h,0a2h,1,0a1h,50h,54h ; 76a8 a3 01 a2 01 56 01 54 01 54 01 50 a2 01 a1 50 54   #.".V.T.T.P".!PT
        .db     0a2h,50h,4eh,0a3h,50h,1,0       ; 76b8 a2 50 4e a3 50 01 00   "PN#P..
l76bf:  .db     9dh,74h,0,80h,0a2h,36h,38h,36h,38h,2eh,3eh,0a3h,1       ; 76bf 9d 74 00 80 a2 36 38 36 38 2e 3e a3 01   .t.."6868.>#.
        .db     0a2h,36h,38h,36h,38h,2eh,3eh,0a3h,1,0a2h,1,36h,1,36h,1,32h      ; 76cc a2 36 38 36 38 2e 3e a3 01 a2 01 36 01 36 01 32   "6868.>#.".6.6.2
        .db     1,36h,36h,32h,32h,30h,0a3h,36h,1,0a2h,38h,3ch,38h,3ch,36h       ; 76dc 01 36 36 32 32 30 a3 36 01 a2 38 3c 38 3c 36   .66220#6."8<8<6
        .db     4eh,0a3h,1,0a2h,38h,3ch,38h,3ch,36h,4eh,0a3h,1,0a2h,1,50h       ; 76eb 4e a3 01 a2 38 3c 38 3c 36 4e a3 01 a2 01 50   N#."8<8<6N#.".P
        .db     1,4eh,1,46h,1,46h,0a2h,1,0a1h,48h,4eh,0a2h,48h,46h,0a3h ; 76fa 01 4e 01 46 01 46 a2 01 a1 48 4e a2 48 46 a3   .N.F.F".!HN"HF#
        .db     40h,1,0         ; 7709 40 01 00   @..
l770c:  .db     9dh,0e9h,6eh,20h,0a2h,48h,46h,48h,46h,3eh,20h,0a3h      ; 770c 9d e9 6e 20 a2 48 46 48 46 3e 20 a3   .in "HFHF> #
        .db     1,0a2h,48h,46h,48h,46h,3eh,20h,0a3h,1,0a2h,2eh,3ch,2eh,24h      ; 7718 01 a2 48 46 48 46 3e 20 a3 01 a2 2e 3c 2e 24   ."HFHF> #.".<.$
        .db     24h,24h,24h,3ch,2ah,3eh,2ah,3eh,0a6h,2eh,0a3h,1,0a1h,1,0a2h     ; 7727 24 24 24 3c 2a 3e 2a 3e a6 2e a3 01 a1 01 a2   $$$<*>*>&.#.!."
        .db     48h,46h,48h,46h,2eh,2eh,0a3h,1,0a2h,48h,46h,48h,46h,2eh ; 7736 48 46 48 46 2e 2e a3 01 a2 48 46 48 46 2e   HFHF..#."HFHF.
        .db     2eh,0a3h,1,0a2h,2ah,3ch,2ah,3ch,2eh,3eh,2eh,3eh,2eh,42h ; 7744 2e a3 01 a2 2a 3c 2a 3c 2e 3e 2e 3e 2e 42   .#."*<*<.>.>.B
        .db     2eh,42h,0a6h,38h,0a3h,1,0a1h,1,0        ; 7752 2e 42 a6 38 a3 01 a1 01 00   .B&8#.!..
l775b:  .db     0a8h,1,0a2h,6,0bh,0a8h,1,0a2h,6,0bh,0a5h,1,1,0  ; 775b a8 01 a2 06 0b a8 01 a2 06 0b a5 01 01 00   (."..(."..%...
l7769:  .db     9dh,0c5h,0,80h,0a1h,46h,4ah,0a4h,46h,0a2h,1,0a3h,50h    ; 7769 9d c5 00 80 a1 46 4a a4 46 a2 01 a3 50   .E..!FJ$F".#P
        .db     0a8h,4ah,0a3h,1,0a1h,42h,46h,0a4h,42h,0a2h,1,0a3h,4eh,0a1h      ; 7776 a8 4a a3 01 a1 42 46 a4 42 a2 01 a3 4e a1   (J#.!BF$B".#N!
        .db     4eh,50h,0a4h,46h,0a7h,1,0a1h,40h,46h,0a4h,40h,0a2h,1,0a3h       ; 7784 4e 50 a4 46 a7 01 a1 40 46 a4 40 a2 01 a3   NP$F'.!@F$@".#
        .db     46h,0a1h,46h,4ah,0a4h,42h,0a7h,1,0a1h,36h,38h,0a4h,36h,0a2h     ; 7792 46 a1 46 4a a4 42 a7 01 a1 36 38 a4 36 a2   F!FJ$B'.!68$6"
        .db     1,0a3h,3ch,0a7h,42h,0a4h,40h,0a2h,1,0   ; 77a0 01 a3 3c a7 42 a4 40 a2 01 00   .#<'B$@"..
l77aa:  .db     9dh,84h,0,41h,0a1h,40h,42h,0a4h,40h,0a2h,1,0a3h,40h     ; 77aa 9d 84 00 41 a1 40 42 a4 40 a2 01 a3 40   ...A!@B$@".#@
        .db     0a8h,42h,0a3h,1,0a1h,3ch,40h,0a4h,3ch,0a2h,1,0a3h,3ch,0a1h      ; 77b7 a8 42 a3 01 a1 3c 40 a4 3c a2 01 a3 3c a1   (B#.!<@$<".#<!
        .db     3ch,40h,0a4h,40h,0a7h,1,0a1h,36h,32h,0a4h,2eh,0a2h,1,0a3h       ; 77c5 3c 40 a4 40 a7 01 a1 36 32 a4 2e a2 01 a3   <@$@'.!62$.".#
        .db     40h,0a1h,36h,38h,0a4h,32h,0a7h,1,0a1h,2eh,32h,0a4h,2eh,0a2h     ; 77d3 40 a1 36 38 a4 32 a7 01 a1 2e 32 a4 2e a2   @!68$2'.!.2$."
        .db     1,0a3h,2ah,0a7h,30h,0a4h,2eh,0a2h,1,0   ; 77e1 01 a3 2a a7 30 a4 2e a2 01 00   .#*'0$."..
l77eb:  .db     0a2h,38h,38h,1,38h,38h,38h,1,38h,0      ; 77eb a2 38 38 01 38 38 38 01 38 00   "88.888.8.
l77f5:  .db     2eh,2eh,1,2eh,2eh,2eh,1,2eh,0   ; 77f5 2e 2e 01 2e 2e 2e 01 2e 00   .........
l77fe:  .db     2ah,2ah,1,2ah,2ah,2ah,1,2ah,0   ; 77fe 2a 2a 01 2a 2a 2a 01 2a 00   **.***.*.
l7807:  .db     0a2h,38h,38h,1,38h,36h,36h,1,36h,0      ; 7807 a2 38 38 01 38 36 36 01 36 00   "88.866.6.
l7811:  .db     32h,32h,1,32h,2eh,2eh,1,2eh,0   ; 7811 32 32 01 32 2e 2e 01 2e 00   22.2.....
l781a:  .db     0a2h,6,0bh,1,6,6,0bh,1,6,6,0bh,1,6,6,0bh,1,6,6,0bh      ; 781a a2 06 0b 01 06 06 0b 01 06 06 0b 01 06 06 0b 01 06 06 0b   "..................
        .db     1,6,6,0bh,1,6,6,0bh,1,6,1,0bh,1,0bh,0   ; 782d 01 06 06 0b 01 06 06 0b 01 06 01 0b 01 0b 00   ...............
l783c:  .db     9dh,66h,0,81h,0a7h,58h,5ah,0a3h,58h,0a7h,5eh,0a4h       ; 783c 9d 66 00 81 a7 58 5a a3 58 a7 5e a4   .f..'XZ#X'^$
        .db     5ah,0a2h,1,0a7h,50h,54h,0a3h,58h,0a7h,5ah,0a4h,58h,0a2h ; 7848 5a a2 01 a7 50 54 a3 58 a7 5a a4 58 a2   Z".'PT#X'Z$X"
        .db     1,0a7h,50h,0a3h,4eh,0a7h,4eh,58h,54h,0a3h,4ah,0a7h,5ah,5eh      ; 7855 01 a7 50 a3 4e a7 4e 58 54 a3 4a a7 5a 5e   .'P#N'NXT#J'Z^
        .db     0a3h,5ah,0a7h,54h,0a4h,50h,0a2h,1,0     ; 7863 a3 5a a7 54 a4 50 a2 01 00   #Z'T$P"..

l786c:  .dw     l788e,l7911,l788e,l7996,0       ; 786c 8e 78 11 79 8e 78 96 79 00 00   .x.y.x.y..
l7876:  .dw     l78ad,l7938,l78ad,l79ba ; 7876 ad 78 38 79 ad 78 ba 79   -x8y-x:y
l787e:  .dw     l78d5,l795e,l78d5,l79dd ; 787e d5 78 5e 79 d5 78 dd 79   Ux^yUx]y
l7886:  .dw     l78fe,l7984,l78fe,l7984 ; 7886 fe 78 84 79 fe 78 84 79   .x.y.x.y
l788e:  .db     9dh,0d1h,0,80h,0a2h,5ch,0a1h,5ch,5ah,0a2h,5ch,5ch       ; 788e 9d d1 00 80 a2 5c a1 5c 5a a2 5c 5c   .Q.."\!\Z"\\
        .db     56h,52h,4eh,56h,0a2h,52h,0a1h,52h,50h,0a2h,52h,52h,4ch,48h      ; 789a 56 52 4e 56 a2 52 a1 52 50 a2 52 52 4c 48   VRNV"R!RP"RRLH
        .db     44h,0a1h,4ch,52h,0      ; 78a8 44 a1 4c 52 00   D!LR.
l78ad:  .db     9dh,0b2h,0,80h,0a2h,52h,0a1h,52h,52h,0a2h,52h,0a1h      ; 78ad 9d b2 00 80 a2 52 a1 52 52 a2 52 a1   .2.."R!RR"R!
        .db     52h,52h,0a2h,44h,0a1h,44h,44h,0a2h,44h,1,4ch,0a1h,4ch,4ch       ; 78b9 52 52 a2 44 a1 44 44 a2 44 01 4c a1 4c 4c   RR"D!DD"D.L!LL
        .db     0a2h,4ch,0a1h,4ch,4ch,0a2h,3ah,0a1h,3ah,3ah,0a2h,3ah,1,0        ; 78c7 a2 4c a1 4c 4c a2 3a a1 3a 3a a2 3a 01 00   "L!LL":!::":..
l78d5:  .db     9dh,0e9h,6eh,20h,0a2h,5ch,0a1h,5ch,5ch,0a2h,5ch,0a1h    ; 78d5 9d e9 6e 20 a2 5c a1 5c 5c a2 5c a1   .in "\!\\"\!
        .db     5ch,5ch,0a2h,4eh,0a1h,52h,52h,0a2h,56h,1,0a2h,5ch,0a1h,5ch      ; 78e1 5c 5c a2 4e a1 52 52 a2 56 01 a2 5c a1 5c   \\"N!RR"V."\!\
        .db     5ch,0a2h,5ch,0a1h,5ch,5ch,0a2h,44h,0a1h,48h,48h,0a2h,4ch        ; 78ef 5c a2 5c a1 5c 5c a2 44 a1 48 48 a2 4c   \"\!\\"D!HH"L
        .db     1,0             ; 78fc 01 00   ..
l78fe:  .db     0a2h,6,0a7h,1,0a2h,0bh,0bh,0bh,1,0a2h,6,0a7h,1,0a2h     ; 78fe a2 06 a7 01 a2 0b 0b 0b 01 a2 06 a7 01 a2   ".'."....".'."
        .db     0bh,0bh,0bh,1,0 ; 790c 0b 0b 0b 01 00   .....
l7911:  .db     0a2h,48h,0a1h,48h,52h,0a2h,44h,0a1h,44h,52h,0a2h,42h    ; 7911 a2 48 a1 48 52 a2 44 a1 44 52 a2 42   "H!HR"D!DR"B
        .db     0a1h,42h,52h,0a2h,48h,0a1h,48h,52h,0a2h,4ch,0a1h,4ch,52h        ; 791d a1 42 52 a2 48 a1 48 52 a2 4c a1 4c 52   !BR"H!HR"L!LR
        .db     0a2h,44h,0a1h,44h,52h,0a2h,48h,44h,0a1h,48h,52h,56h,5ah ; 792a a2 44 a1 44 52 a2 48 44 a1 48 52 56 5a   "D!DR"HD!HRVZ
        .db     0               ; 7937 00   .
l7938:  .db     3ah,0a1h,3ah,3ah,0a2h,3ah,0a1h,3ah,3ah,0a2h,3ah,0a1h    ; 7938 3a a1 3a 3a a2 3a a1 3a 3a a2 3a a1   :!::":!::":!
        .db     3ah,3ah,0a2h,3ah,0a1h,3ah,3ah,0a2h,3ah,0a1h,3ah,3ah,0a2h        ; 7944 3a 3a a2 3a a1 3a 3a a2 3a a1 3a 3a a2   ::":!::":!::"
        .db     3ah,0a1h,3ah,3ah,0a2h,36h,0a1h,36h,36h,0a2h,36h,1,0     ; 7951 3a a1 3a 3a a2 36 a1 36 36 a2 36 01 00   :!::"6!66"6..
l795e:  .db     48h,0a1h,48h,48h,0a2h,48h,0a1h,48h,48h,0a2h,48h,0a1h    ; 795e 48 a1 48 48 a2 48 a1 48 48 a2 48 a1   H!HH"H!HH"H!
        .db     48h,48h,0a2h,48h,0a1h,48h,48h,0a2h,44h,0a1h,44h,44h,0a2h        ; 796a 48 48 a2 48 a1 48 48 a2 44 a1 44 44 a2   HH"H!HH"D!DD"
        .db     44h,0a1h,44h,44h,0a2h,42h,0a1h,42h,42h,0a2h,42h,1,0     ; 7977 44 a1 44 44 a2 42 a1 42 42 a2 42 01 00   D!DD"B!BB"B..
l7984:  .db     0a2h,1,0bh,1,0bh,1,0bh,1,0bh,1,0bh,1,0bh,1,0bh,0bh      ; 7984 a2 01 0b 01 0b 01 0b 01 0b 01 0b 01 0b 01 0b 0b   "...............
        .db     1,0             ; 7994 01 00   ..
l7996:  .db     0a2h,48h,0a1h,48h,52h,0a2h,44h,0a1h,44h,52h,0a2h,42h    ; 7996 a2 48 a1 48 52 a2 44 a1 44 52 a2 42   "H!HR"D!DR"B
        .db     0a1h,42h,52h,0a2h,48h,0a1h,48h,52h,0a2h,4ch,0a1h,4ch,52h        ; 79a2 a1 42 52 a2 48 a1 48 52 a2 4c a1 4c 52   !BR"H!HR"L!LR
        .db     0a2h,48h,0a1h,48h,52h,0a2h,44h,52h,0a3h,5ch,0   ; 79af a2 48 a1 48 52 a2 44 52 a3 5c 00   "H!HR"DR#\.
l79ba:  .db     3ah,0a1h,3ah,3ah,0a2h,3ah,0a1h,3ah,3ah,0a2h,3ah,0a1h    ; 79ba 3a a1 3a 3a a2 3a a1 3a 3a a2 3a a1   :!::":!::":!
        .db     3ah,3ah,0a2h,3ah,0a1h,3ah,3ah,0a2h,3ah,0a1h,3ah,3ah,0a2h        ; 79c6 3a 3a a2 3a a1 3a 3a a2 3a a1 3a 3a a2   ::":!::":!::"
        .db     3ah,0a1h,3ah,3ah,0a2h,1,3ah,0a3h,4ch,0  ; 79d3 3a a1 3a 3a a2 01 3a a3 4c 00   :!::".:#L.
l79dd:  .db     48h,0a1h,48h,48h,0a2h,48h,0a1h,48h,48h,0a2h,48h,0a1h    ; 79dd 48 a1 48 48 a2 48 a1 48 48 a2 48 a1   H!HH"H!HH"H!
        .db     48h,48h,0a2h,48h,0a1h,48h,48h,0a2h,44h,0a1h,44h,44h,0a2h        ; 79e9 48 48 a2 48 a1 48 48 a2 44 a1 44 44 a2   HH"H!HH"D!DD"
        .db     44h,0a1h,44h,44h,0a2h,1,4ch,0a3h,44h,0  ; 79f6 44 a1 44 44 a2 01 4c a3 44 00   D!DD".L#D.

l7a00:  .dw     l7a04,0         ; 7a00 04 7a 00 00   .z..
l7a04:  .db     9dh,0c2h,0,40h,0a2h,5ch,0a1h,5ch,5ah,0a2h,5ch,5ch       ; 7a04 9d c2 00 40 a2 5c a1 5c 5a a2 5c 5c   .B.@"\!\Z"\\
        .db     56h,52h,4eh,56h,0a2h,52h,0a1h,52h,50h,0a2h,52h,52h,4ch,48h      ; 7a10 56 52 4e 56 a2 52 a1 52 50 a2 52 52 4c 48   VRNV"R!RP"RRLH
        .db     0a1h,44h,42h,0a2h,44h,0a4h,1,0  ; 7a1e a1 44 42 a2 44 a4 01 00   !DB"D$..

l7a26:  .dw     l7a2c,0         ; 7a26 2c 7a 00 00   ,z..
l7a2a:  .dw     l7a4b           ; 7a2a 4b 7a   Kz
l7a2c:  .db     9dh,0c2h,0,80h,0a2h,5ch,0a1h,5ch,5ah,0a2h,5ch,5ch       ; 7a2c 9d c2 00 80 a2 5c a1 5c 5a a2 5c 5c   .B.."\!\Z"\\
        .db     56h,52h,4eh,56h,0a2h,52h,0a1h,52h,50h,0a2h,52h,4ch,44h,52h      ; 7a38 56 52 4e 56 a2 52 a1 52 50 a2 52 4c 44 52   VRNV"R!RP"RLDR
        .db     0a3h,5ch,0a4h,1,0       ; 7a46 a3 5c a4 01 00   #\$..
l7a4b:  .db     9dh,0e9h,6eh,20h,0a2h,5ch,0a1h,5ch,5ch,0a2h,5ch,0a1h    ; 7a4b 9d e9 6e 20 a2 5c a1 5c 5c a2 5c a1   .in "\!\\"\!
        .db     5ch,5ch,0a2h,4eh,52h,56h,1,0a2h,5ch,0a1h,5ch,5ch,0a2h,5ch       ; 7a57 5c 5c a2 4e 52 56 01 a2 5c a1 5c 5c a2 5c   \\"NRV."\!\\"\
        .db     0a1h,5ch,5ch,0a2h,52h,4ch,44h,1,0a5h,1  ; 7a65 a1 5c 5c a2 52 4c 44 01 a5 01   !\\"RLD.%.

l7a6f:  .dw     l7a77,0         ; 7a6f 77 7a 00 00   wz..
l7a73:  .dw     l7a96           ; 7a73 96 7a   .z
l7a75:  .dw     l7ab4           ; 7a75 b4 7a   4z
l7a77:  .db     9dh,0c2h,0,80h,0a2h,5ch,0a1h,5ch,5ah,0a2h,5ch,5ch       ; 7a77 9d c2 00 80 a2 5c a1 5c 5a a2 5c 5c   .B.."\!\Z"\\
        .db     56h,52h,4eh,56h,0a2h,52h,0a1h,52h,50h,0a2h,52h,4ch,44h,52h      ; 7a83 56 52 4e 56 a2 52 a1 52 50 a2 52 4c 44 52   VRNV"R!RP"RLDR
        .db     0a3h,5ch,0a4h,1,0       ; 7a91 a3 5c a4 01 00   #\$..
l7a96:  .db     9dh,0c2h,0,40h,0a2h,4eh,0a1h,4eh,52h,0a2h,56h,4eh       ; 7a96 9d c2 00 40 a2 4e a1 4e 52 a2 56 4e   .B.@"N!NR"VN
        .db     0a3h,48h,48h,0a2h,4ch,0a1h,4ch,4ah,0a2h,4ch,44h,34h,4ch ; 7aa2 a3 48 48 a2 4c a1 4c 4a a2 4c 44 34 4c   #HH"L!LJ"LD4L
        .db     0a3h,4ch,0a5h,1,0       ; 7aaf a3 4c a5 01 00   #L%..
l7ab4:  .db     9dh,0e9h,6eh,20h,0a2h,5ch,0a1h,5ch,5ch,0a2h,5ch,0a1h    ; 7ab4 9d e9 6e 20 a2 5c a1 5c 5c a2 5c a1   .in "\!\\"\!
        .db     5ch,5ch,0a2h,4eh,52h,0a1h,56h,56h,0a2h,56h,0a2h,5ch,0a1h        ; 7ac0 5c 5c a2 4e 52 a1 56 56 a2 56 a2 5c a1   \\"NR!VV"V"\!
        .db     5ch,5ch,0a2h,5ch,0a1h,5ch,5ch,0a2h,52h,4ch,0a1h,44h,44h ; 7acd 5c 5c a2 5c a1 5c 5c a2 52 4c a1 44 44   \\"\!\\"RL!DD
        .db     0a2h,1,0a5h,1,0 ; 7ada a2 01 a5 01 00   ".%..

l7adf:  .dw     l7ae9,0         ; 7adf e9 7a 00 00   iz..
l7ae3:  .dw     l7b08           ; 7ae3 08 7b   .{
l7ae5:  .dw     l7b25           ; 7ae5 25 7b   %{
l7ae7:  .dw     l7b4f           ; 7ae7 4f 7b   O{
l7ae9:  .db     9dh,0c2h,0,80h,0a2h,5ch,0a1h,5ch,5ah,0a2h,5ch,5ch       ; 7ae9 9d c2 00 80 a2 5c a1 5c 5a a2 5c 5c   .B.."\!\Z"\\
        .db     56h,52h,4eh,56h,0a2h,52h,0a1h,52h,50h,0a2h,52h,4ch,44h,52h      ; 7af5 56 52 4e 56 a2 52 a1 52 50 a2 52 4c 44 52   VRNV"R!RP"RLDR
        .db     0a3h,5ch,0a4h,1,0       ; 7b03 a3 5c a4 01 00   #\$..
l7b08:  .db     9dh,0b2h,0,80h,0a2h,4eh,0a1h,4eh,52h,0a2h,56h,4eh       ; 7b08 9d b2 00 80 a2 4e a1 4e 52 a2 56 4e   .2.."N!NR"VN
        .db     0a3h,48h,48h,0a2h,4ch,0a1h,4ch,4ah,0a2h,4ch,44h,34h,4ch ; 7b14 a3 48 48 a2 4c a1 4c 4a a2 4c 44 34 4c   #HH"L!LJ"LD4L
        .db     0a3h,4ch,0a5h,1 ; 7b21 a3 4c a5 01   #L%.
l7b25:  .db     9dh,0e9h,6eh,20h,0a2h,5ch,0a1h,5ch,5ch,0a2h,5ch,0a1h    ; 7b25 9d e9 6e 20 a2 5c a1 5c 5c a2 5c a1   .in "\!\\"\!
        .db     5ch,5ch,4eh,56h,5ch,56h,4eh,44h,3eh,44h,0a2h,5ch,0a1h,5ch       ; 7b31 5c 5c 4e 56 5c 56 4e 44 3e 44 a2 5c a1 5c   \\NV\VND>D"\!\
        .db     5ch,0a2h,5ch,0a1h,5ch,5ch,52h,4ch,44h,4ch,5ch,1,0a2h,1,0a5h     ; 7b3f 5c a2 5c a1 5c 5c 52 4c 44 4c 5c 01 a2 01 a5   \"\!\\RLDL\.".%
        .db     1               ; 7b4e 01   .
l7b4f:  .db     0a2h,0bh,0bh,0bh,0bh,0a2h,0bh,0bh,0bh,1,0a2h,0bh,0bh    ; 7b4f a2 0b 0b 0b 0b a2 0b 0b 0b 01 a2 0b 0b   "...."...."..
        .db     0bh,0bh,0a2h,0bh,0bh,0bh,1,0a5h,1       ; 7b5c 0b 0b a2 0b 0b 0b 01 a5 01   .."....%.

l7b65:  .dw     l7b77,l7bce,0   ; 7b65 77 7b ce 7b 00 00   w{N{..
l7b6b:  .dw     l7b96,l7bf2     ; 7b6b 96 7b f2 7b   .{r{
l7b6f:  .dw     l7ba8,l7c02     ; 7b6f a8 7b 02 7c   ({.|
l7b73:  .dw     l7bbb,l7c12     ; 7b73 bb 7b 12 7c   ;{.|
l7b77:  .db     9dh,0d1h,0,80h,0a2h,5ch,0a1h,5ch,5ah,0a2h,5ch,5ch       ; 7b77 9d d1 00 80 a2 5c a1 5c 5a a2 5c 5c   .Q.."\!\Z"\\
        .db     56h,52h,4eh,56h,0a2h,52h,0a1h,52h,50h,0a2h,52h,52h,4ch,48h      ; 7b83 56 52 4e 56 a2 52 a1 52 50 a2 52 52 4c 48   VRNV"R!RP"RRLH
        .db     44h,0a1h,4ch,52h,0      ; 7b91 44 a1 4c 52 00   D!LR.
l7b96:  .db     0a2h,52h,0a7h,1,0a2h,44h,44h,44h,1,4ch,0a7h,1,0a2h      ; 7b96 a2 52 a7 01 a2 44 44 44 01 4c a7 01 a2   "R'."DDD.L'."
        .db     3ah,3ah,3ah,1,0 ; 7ba3 3a 3a 3a 01 00   :::..
l7ba8:  .db     0a2h,5ch,0a7h,1,0a2h,4eh,52h,56h,1,0a2h,5ch,0a7h,1      ; 7ba8 a2 5c a7 01 a2 4e 52 56 01 a2 5c a7 01   "\'."NRV."\'.
        .db     0a2h,44h,48h,4ch,1,0    ; 7bb5 a2 44 48 4c 01 00   "DHL..
l7bbb:  .db     0a2h,6,0a7h,1,0a2h,0bh,0bh,0bh,1,0a2h,6,0a7h,1,0a2h     ; 7bbb a2 06 a7 01 a2 0b 0b 0b 01 a2 06 a7 01 a2   ".'."....".'."
        .db     0bh,0bh,0bh,1,0 ; 7bc9 0b 0b 0b 01 00   .....
l7bce:  .db     0a2h,48h,0a1h,48h,52h,0a2h,44h,0a1h,44h,52h,0a2h,42h    ; 7bce a2 48 a1 48 52 a2 44 a1 44 52 a2 42   "H!HR"D!DR"B
        .db     0a1h,42h,52h,0a2h,48h,0a1h,48h,52h,0a2h,4ch,0a1h,4ch,52h        ; 7bda a1 42 52 a2 48 a1 48 52 a2 4c a1 4c 52   !BR"H!HR"L!LR
        .db     0a2h,48h,0a1h,48h,52h,0a2h,5ch,52h,0a3h,5ch,0   ; 7be7 a2 48 a1 48 52 a2 5c 52 a3 5c 00   "H!HR"\R#\.
l7bf2:  .db     1,3ah,1,3ah,1,3ah,1,3ah,1,3ah,1,3ah,1,3ah,0a3h,34h      ; 7bf2 01 3a 01 3a 01 3a 01 3a 01 3a 01 3a 01 3a a3 34   .:.:.:.:.:.:.:#4
l7c02:  .db     1,48h,1,48h,1,48h,1,48h,1,44h,1,44h,1,4ch,0a3h,44h      ; 7c02 01 48 01 48 01 48 01 48 01 44 01 44 01 4c a3 44   .H.H.H.H.D.D.L#D
l7c12:  .db     0a2h,1,0bh,1,0bh,1,0bh,1,0bh,1,0bh,1,0bh,0a2h,1,0bh     ; 7c12 a2 01 0b 01 0b 01 0b 01 0b 01 0b 01 0b a2 01 0b   "............"..
        .db     0bh,1           ; 7c22 0b 01   ..

l7c24:  .dw     l7c2e,0         ; 7c24 2e 7c 00 00   .|..
l7c28:  .dw     l7c63           ; 7c28 63 7c   c|
l7c2a:  .dw     l7c97           ; 7c2a 97 7c   .|
l7c2c:  .dw     l7ccb           ; 7c2c cb 7c   K|
l7c2e:  .db     9dh,0b3h,0,80h,0a6h,52h,0a1h,50h,0a6h,52h,0a1h,50h      ; 7c2e 9d b3 00 80 a6 52 a1 50 a6 52 a1 50   .3..&R!P&R!P
        .db     0a6h,52h,0a1h,48h,0a3h,1,0a6h,4ch,0a1h,4ah,0a6h,4ch,0a1h        ; 7c3a a6 52 a1 48 a3 01 a6 4c a1 4a a6 4c a1   &R!H#.&L!J&L!
        .db     4ah,0a6h,4ch,0a1h,42h,0a3h,1,0a6h,3eh,0a1h,42h,0a6h,44h ; 7c47 4a a6 4c a1 42 a3 01 a6 3e a1 42 a6 44   J&L!B#.&>!B&D
        .db     0a1h,48h,0a6h,4ch,0a1h,50h,0a6h,52h,0a1h,56h,0a6h,52h,0a1h      ; 7c54 a1 48 a6 4c a1 50 a6 52 a1 56 a6 52 a1   !H&L!P&R!V&R!
        .db     6ah,0           ; 7c61 6a 00   j.
l7c63:  .db     9dh,93h,0,0c0h,0a6h,42h,0a1h,40h,0a6h,42h,0a1h,40h      ; 7c63 9d 93 00 c0 a6 42 a1 40 a6 42 a1 40   ...@&B!@&B!@
        .db     0a6h,42h,0a1h,42h,0a3h,1,0a6h,3ah,0a1h,38h,0a6h,3ah,0a1h        ; 7c6f a6 42 a1 42 a3 01 a6 3a a1 38 a6 3a a1   &B!B#.&:!8&:!
        .db     38h,0a6h,3ah,0a1h,3ah,0a3h,1,0a6h,38h,0a1h,38h,0a6h,3ah ; 7c7c 38 a6 3a a1 3a a3 01 a6 38 a1 38 a6 3a   8&:!:#.&8!8&:
        .db     0a1h,3eh,0a6h,42h,0a1h,44h,0a6h,48h,0a1h,4ch,0a6h,42h,0a1h      ; 7c89 a1 3e a6 42 a1 44 a6 48 a1 4c a6 42 a1   !>&B!D&H!L&B!
        .db     42h             ; 7c96 42   B
l7c97:  .db     9dh,0e9h,6eh,0a0h,0a6h,48h,0a1h,46h,0a6h,48h,0a1h       ; 7c97 9d e9 6e a0 a6 48 a1 46 a6 48 a1   .in &H!F&H!
        .db     46h,0a6h,48h,0a1h,52h,0a3h,1,0a6h,44h,0a1h,42h,0a6h,44h ; 7ca2 46 a6 48 a1 52 a3 01 a6 44 a1 42 a6 44   F&H!R#.&D!B&D
        .db     0a1h,42h,0a6h,44h,0a1h,4ch,0a3h,1,0a6h,48h,0a1h,3ah,0a6h        ; 7caf a1 42 a6 44 a1 4c a3 01 a6 48 a1 3a a6   !B&D!L#.&H!:&
        .db     3eh,0a1h,42h,0a6h,44h,0a1h,48h,0a6h,4ch,0a1h,50h,0a6h,52h       ; 7cbc 3e a1 42 a6 44 a1 48 a6 4c a1 50 a6 52   >!B&D!H&L!P&R
        .db     0a1h,3ah        ; 7cc9 a1 3a   !:
l7ccb:  .db     0a6h,0bh,0a1h,6,0a6h,0bh,0a1h,6,0a6h,0bh,0a1h,6,0a3h    ; 7ccb a6 0b a1 06 a6 0b a1 06 a6 0b a1 06 a3   &.!.&.!.&.!.#
        .db     1,0a6h,0bh,0a1h,6,0a6h,0bh,0a1h,6,0a6h,0bh,0a1h,6,0a3h,1        ; 7cd8 01 a6 0b a1 06 a6 0b a1 06 a6 0b a1 06 a3 01   .&.!.&.!.&.!.#.
        .db     0a6h,0bh,0a1h,6,0a6h,0bh,0a1h,6,0a6h,0bh,0a1h,6,0a3h,1,0a6h     ; 7ce7 a6 0b a1 06 a6 0b a1 06 a6 0b a1 06 a3 01 a6   &.!.&.!.&.!.#.&
        .db     0bh,0a1h,6      ; 7cf6 0b a1 06   .!.

l7cf9:  .dw     l7d2e,0ffffh,l7d01      ; 7cf9 2e 7d ff ff 01 7d   .}...}
l7cff:  .dw     l7d29           ; 7cff 29 7d   )}
l7d01:  .dw     l7d35           ; 7d01 35 7d   5}
l7d03:  .dw     l7d5b,l7d82,l7d5b,l7da4,l7dc6,0ffffh,l7d03      ; 7d03 5b 7d 82 7d 5b 7d a4 7d c6 7d ff ff 03 7d   [}.}[}$}F}...}
l7d11:  .dw     l7d3b           ; 7d11 3b 7d   ;}
l7d13:  .dw     l7d6c,l7d93,l7d6c,l7db5,l7e07,0ffffh,l7d13      ; 7d13 6c 7d 93 7d 6c 7d b5 7d 07 7e ff ff 13 7d   l}.}l}5}.....}
l7d21:  .dw     l7d3e           ; 7d21 3e 7d   >}
l7d23:  .dw     l7d41,0ffffh,l7d23      ; 7d23 41 7d ff ff 23 7d   A}..#}
l7d29:  .db     9dh,60h,0,81h,0 ; 7d29 9d 60 00 81 00   .`...
l7d2e:  .db     9dh,20h,0,81h,0aah,1,0  ; 7d2e 9d 20 00 81 aa 01 00   . ..*..
l7d35:  .db     0a3h,1,50h,54h,58h,0    ; 7d35 a3 01 50 54 58 00   #.PTX.
l7d3b:  .db     0a5h,1,0        ; 7d3b a5 01 00   %..
l7d3e:  .db     0a5h,1,0        ; 7d3e a5 01 00   %..
l7d41:  .db     0a3h,1,6,1,6,1,0a2h,6,6,0a3h,1,6,0a3h,1,6,1,6,1,0a2h    ; 7d41 a3 01 06 01 06 01 a2 06 06 a3 01 06 a3 01 06 01 06 01 a2   #....."..#..#....."
        .db     6,6,1,1,6,6,0   ; 7d54 06 06 01 01 06 06 00   .......
l7d5b:  .db     0a7h,5ah,0a2h,5eh,0a7h,5ah,0a2h,58h,0a7h,58h,0a2h       ; 7d5b a7 5a a2 5e a7 5a a2 58 a7 58 a2   'Z"^'Z"X'X"
        .db     54h,0a7h,58h,0a2h,54h,0 ; 7d66 54 a7 58 a2 54 00   T'X"T.
l7d6c:  .db     9dh,0c9h,6eh,20h,0a2h,5ah,62h,68h,70h,5ah,62h,68h       ; 7d6c 9d c9 6e 20 a2 5a 62 68 70 5a 62 68   .In "ZbhpZbh
        .db     70h,5ah,64h,66h,6ch,5ah,64h,66h,6ch,0   ; 7d78 70 5a 64 66 6c 5a 64 66 6c 00   pZdflZdfl.
l7d82:  .db     0a7h,54h,0a2h,50h,0a7h,54h,0a2h,50h,0a7h,50h,0a2h       ; 7d82 a7 54 a2 50 a7 54 a2 50 a7 50 a2   'T"P'T"P'P"
        .db     4ch,0a7h,4ah,0a2h,50h,0 ; 7d8d 4c a7 4a a2 50 00   L'J"P.
l7d93:  .db     58h,5eh,64h,6ch,58h,5eh,64h,6ch,50h,54h,58h,5eh,50h     ; 7d93 58 5e 64 6c 58 5e 64 6c 50 54 58 5e 50   X^dlX^dlPTX^P
        .db     58h,5eh,64h,0   ; 7da0 58 5e 64 00   X^d.
l7da4:  .db     0a7h,54h,0a2h,50h,0a7h,54h,0a2h,50h,0a7h,50h,0a2h       ; 7da4 a7 54 a2 50 a7 54 a2 50 a7 50 a2   'T"P'T"P'P"
        .db     4ch,0a7h,4ah,0a2h,46h,0 ; 7daf 4c a7 4a a2 46 00   L'J"F.
l7db5:  .db     58h,5eh,64h,6ch,58h,5eh,64h,6ch,50h,54h,58h,5eh,50h     ; 7db5 58 5e 64 6c 58 5e 64 6c 50 54 58 5e 50   X^dlX^dlPTX^P
        .db     58h,5eh,64h,0   ; 7dc2 58 5e 64 00   X^d.
l7dc6:  .db     0a7h,4ah,0a2h,4ch,0a7h,4ah,0a2h,46h,0a7h,46h,0a2h       ; 7dc6 a7 4a a2 4c a7 4a a2 46 a7 46 a2   'J"L'J"F'F"
        .db     44h,0a7h,46h,0a2h,4ah,0a7h,4ch,0a2h,50h,0a7h,4ch,0a2h,4ah       ; 7dd1 44 a7 46 a2 4a a7 4c a2 50 a7 4c a2 4a   D'F"J'L"P'L"J
        .db     0a7h,4ah,0a2h,46h,0a7h,4ah,0a2h,4ch,0a7h,50h,0a2h,4eh,0a7h      ; 7dde a7 4a a2 46 a7 4a a2 4c a7 50 a2 4e a7   'J"F'J"L'P"N'
        .db     50h,0a2h,52h,0a7h,58h,0a2h,54h,0a7h,5ah,0a2h,54h,0a7h,52h       ; 7deb 50 a2 52 a7 58 a2 54 a7 5a a2 54 a7 52   P"R'X"T'Z"T'R
        .db     0a2h,50h,0a7h,4ch,0a2h,4ah,0a2h,42h,38h,3ch,4ah,0a3h,42h        ; 7df8 a2 50 a7 4c a2 4a a2 42 38 3c 4a a3 42   "P'L"J"B8<J#B
        .db     1,0             ; 7e05 01 00   ..
l7e07:  .db     4ah,52h,58h,5eh,4ah,58h,5eh,62h,54h,62h,68h,6ch,54h     ; 7e07 4a 52 58 5e 4a 58 5e 62 54 62 68 6c 54   JRX^JX^bTbhlT
        .db     62h,68h,6ch,46h,4ch,54h,5eh,46h,4ch,54h,5ah,50h,58h,5eh ; 7e14 62 68 6c 46 4c 54 5e 46 4c 54 5a 50 58 5e   bhlFLT^FLTZPX^
        .db     64h,50h,5eh,64h,6ch,4ah,50h,58h,5eh,4ah,58h,5eh,62h,4eh ; 7e22 64 50 5e 64 6c 4a 50 58 5e 4a 58 5e 62 4e   dP^dlJPX^JX^bN
        .db     54h,5ah,62h,4eh,54h,5ah,66h,50h,58h,5eh,64h,50h,5eh,64h ; 7e30 54 5a 62 4e 54 5a 66 50 58 5e 64 50 5e 64   TZbNTZfPX^dP^d
        .db     68h,0a8h,5ah,0a3h,1,0   ; 7e3e 68 a8 5a a3 01 00   h(Z#..

l7e44:  .dw     l7e4e,0         ; 7e44 4e 7e 00 00   N...
l7e48:  .dw     l7e5e           ; 7e48 5e 7e   ^.
l7e4a:  .dw     l7e6d           ; 7e4a 6d 7e   m.
l7e4c:  .dw     l7e7d           ; 7e4c 7d 7e   }.
l7e4e:  .db     9dh,0b1h,0,80h,0a7h,1,0a1h,5eh,5eh,0a6h,68h,0a1h,5eh    ; 7e4e 9d b1 00 80 a7 01 a1 5e 5e a6 68 a1 5e   .1..'.!^^&h!^
        .db     0a4h,68h,0      ; 7e5b a4 68 00   $h.
l7e5e:  .db     9dh,91h,0,80h,0a7h,1,0a1h,54h,54h,0a6h,5eh,0a1h,58h     ; 7e5e 9d 91 00 80 a7 01 a1 54 54 a6 5e a1 58   ....'.!TT&^!X
        .db     0a4h,5eh        ; 7e6b a4 5e   $^
l7e6d:  .db     9dh,0e9h,6eh,20h,0a7h,1,0a1h,4eh,4eh,0a6h,58h,0a1h      ; 7e6d 9d e9 6e 20 a7 01 a1 4e 4e a6 58 a1   .in '.!NN&X!
        .db     50h,0a3h,58h,1  ; 7e79 50 a3 58 01   P#X.
l7e7d:  .db     0a7h,1,0a1h,6,6,0a6h,0bh,0a1h,6,0a0h,6,6,6,6,6,6,6      ; 7e7d a7 01 a1 06 06 a6 0b a1 06 a0 06 06 06 06 06 06 06   '.!..&.!. .......
        .db     6,0a3h,1        ; 7e8e 06 a3 01   .#.

l7e91:  .dw     l7ebb,l7f28,l7ebb,l7f73,0ffffh,l7e91    ; 7e91 bb 7e 28 7f bb 7e 73 7f ff ff 91 7e   ;.(.;.s.....
l7e9d:  .dw     l7ee5,l7f4f,l7ee5,l7f96,0ffffh,l7e9d    ; 7e9d e5 7e 4f 7f e5 7e 96 7f ff ff 9d 7e   e.O.e.......
l7ea9:  .dw     l7efb,l7f61,l7efb,l7fae,0ffffh,l7ea9    ; 7ea9 fb 7e 61 7f fb 7e ae 7f ff ff a9 7e   {.a.{.....).
l7eb5:  .dw     l7f11,0ffffh,l7eb5      ; 7eb5 11 7f ff ff b5 7e   ....5.
l7ebb:  .db     9dh,82h,0,80h,0a2h,54h,0a1h,54h,54h,54h,4ah,46h,4ah     ; 7ebb 9d 82 00 80 a2 54 a1 54 54 54 4a 46 4a   ...."T!TTTJFJ
        .db     0a2h,54h,0a1h,54h,54h,54h,58h,5ch,58h,0a2h,54h,0a1h,54h ; 7ec8 a2 54 a1 54 54 54 58 5c 58 a2 54 a1 54   "T!TTTX\X"T!T
        .db     54h,58h,54h,52h,54h,0a1h,58h,5ch,58h,5ch,0a2h,58h,0a1h,56h      ; 7ed5 54 58 54 52 54 a1 58 5c 58 5c a2 58 a1 56   TXTRT!X\X\"X!V
        .db     58h,0           ; 7ee3 58 00   X.
l7ee5:  .db     9dh,62h,0,80h,0a2h,1,44h,1,40h,1,44h,1,46h,1,44h,1      ; 7ee5 9d 62 00 80 a2 01 44 01 40 01 44 01 46 01 44 01   .b..".D.@.D.F.D.
        .db     44h,1,40h,1,40h,0       ; 7ef5 44 01 40 01 40 00   D.@.@.
l7efb:  .db     9dh,0e9h,6eh,20h,0a2h,54h,54h,4ah,52h,54h,54h,4ah       ; 7efb 9d e9 6e 20 a2 54 54 4a 52 54 54 4a   .in "TTJRTTJ
        .db     58h,54h,54h,52h,54h,4eh,54h,4ah,52h,0   ; 7f07 58 54 54 52 54 4e 54 4a 52 00   XTTRTNTJR.
l7f11:  .db     0a2h,6,0bh,6,0bh,6,0bh,6,0bh,6,0bh,6,0bh,6,0a1h,0bh     ; 7f11 a2 06 0b 06 0b 06 0b 06 0b 06 0b 06 0b 06 a1 0b   ".............!.
        .db     0bh,6,0a2h,0bh,0a1h,6,0 ; 7f21 0b 06 a2 0b a1 06 00   ..".!..
l7f28:  .db     0a2h,5eh,0a1h,5eh,5eh,5eh,54h,50h,54h,0a2h,5eh,0a1h     ; 7f28 a2 5e a1 5e 5e 5e 54 50 54 a2 5e a1   "^!^^^TPT"^!
        .db     5eh,5eh,5eh,62h,66h,62h,0a2h,5eh,0a1h,5eh,5ch,0a2h,58h,0a1h     ; 7f34 5e 5e 5e 62 66 62 a2 5e a1 5e 5c a2 58 a1   ^^^bfb"^!^\"X!
        .db     58h,54h,0a1h,52h,54h,52h,54h,0a2h,52h,0a1h,4eh,52h,0    ; 7f42 58 54 a1 52 54 52 54 a2 52 a1 4e 52 00   XT!RTRT"R!NR.
l7f4f:  .db     0a2h,1,46h,1,4ah,1,46h,1,4ah,1,46h,1,46h,1,46h,1,46h    ; 7f4f a2 01 46 01 4a 01 46 01 4a 01 46 01 46 01 46 01 46   ".F.J.F.J.F.F.F.F
        .db     0               ; 7f60 00   .
l7f61:  .db     0a2h,46h,54h,54h,54h,46h,54h,54h,54h,46h,54h,52h,58h    ; 7f61 a2 46 54 54 54 46 54 54 54 46 54 52 58   "FTTTFTTTFTRX
        .db     44h,52h,4ah,58h,0       ; 7f6e 44 52 4a 58 00   DRJX.
l7f73:  .db     0a2h,62h,0a1h,62h,62h,62h,5eh,5ah,5eh,0a2h,62h,0a1h     ; 7f73 a2 62 a1 62 62 62 5e 5a 5e a2 62 a1   "b!bbb^Z^"b!
        .db     62h,62h,62h,5eh,5ah,5eh,0a2h,62h,0a1h,4ah,4eh,0a2h,52h,0a1h     ; 7f7f 62 62 62 5e 5a 5e a2 62 a1 4a 4e a2 52 a1   bbb^Z^"b!JN"R!
        .db     4ah,5ch,0a3h,58h,0a1h,54h,0a6h,6ch,0    ; 7f8d 4a 5c a3 58 a1 54 a6 6c 00   J\#X!T&l.
l7f96:  .db     0a2h,1,4ah,1,4ah,1,4ah,1,4ah,1,0a1h,46h,46h,0a2h,46h    ; 7f96 a2 01 4a 01 4a 01 4a 01 4a 01 a1 46 46 a2 46   ".J.J.J.J.!FF"F
        .db     0a1h,46h,46h,0a3h,46h,0a2h,44h,1,0      ; 7fa5 a1 46 46 a3 46 a2 44 01 00   !FF#F"D..
l7fae:  .db     0a2h,42h,5ah,50h,5ah,42h,5ah,50h,5ah,4ah,0a1h,52h       ; 7fae a2 42 5a 50 5a 42 5a 50 5a 4a a1 52   "BZPZBZPZJ!R
        .db     52h,0a2h,52h,0a1h,52h,52h,0a3h,52h,0a2h,54h,1,0,0,0,0,0 ; 7fba 52 a2 52 a1 52 52 a3 52 a2 54 01 00 00 00 00 00   R"R!RR#R"T......
        .db     0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; 7fca 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   ............................
        .db     0,0,0,0,0,0,0,0,0,0     ; 7fe6 00 00 00 00 00 00 00 00 00 00   ..........

l7ff0:  jp      l64d3           ; 7ff0 c3 d3 64   CSd

l7ff3:  jp      l69a5           ; 7ff3 c3 a5 69   C%i

        .db     0,0,0,0,0,0,0,0,0,0     ; 7ff6 00 00 00 00 00 00 00 00 00 00   ..........
 .end
