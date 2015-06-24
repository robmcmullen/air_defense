	.OPT NOLIST,NOEJECT
;
;   GAME 1.0       
;   BY ROB McMULLEN
;
;   OS VARIABLES
;
DOSVEC	= $0A 
RTCLOK	= $14 
VDSLST	= $0200 
SDMCTL	= $022F 
SDLSTL	= $0230 
COLDST	= $0244 
GPRIOR	= $026F 
PADDL0	= $0270 
STICK0	= $0278 
PTRIG0	= $027C 
STRIG0	= $0284 
PCOLR0	= $02C0 
COLOR0	= $02C4 
COLORM	= $02C7 
RUNAD	= $02E0 
CHBAS	= $02F4 
CH	= $02FC 
HPOSP0	= $D000 
HPOSM0	= $D004 
SIZEP0	= $D008 
SIZEM	= $D00C 
COLPF0	= $D016 
GRACTL	= $D01D 
HITCLR	= $D01E 
COLSOL	= $D01F 
AUDF1	= $D200 
AUDC1	= $D201 
RANDOM	= $D20A 
HSCROL	= $D404 
VSCROL	= $D405 
PMBASE	= $D407 
CHBASE	= $D409 
WSYNC	= $D40A 
NMIEN	= $D40E 
SETVBV	= $E45C 
SYSVBV	= $E45F 
XITVBV	= $E462 
;
;   ZERO PAGE VARS.
;
	*= $80 
VCOUNT	*= *+1 
DCOUNT	*= *+1 
XLOOP	*= *+1 
YLOOP	*= *+1 
CSHIFT	*= *+1 
LO	*= *+1 
HI	*= *+1 
COUNT	*= *+1 
GUNDIR	*= *+1 
XSAVE	*= *+1 
YSAVE	*= *+1 
PLOTPOS	*= *+1 
TEMP	*= *+1 
DCOLSV	*= *+1 
;
;   CONSTANTS
;
	*= $3000 
YPLOTL	*= *+200 
YPLOTH	*= *+200 
BACTIV	*= *+8 
BDIR	*= *+8 
BXPOS	*= *+8 
BYPOS	*= *+8 
ERALO	*= *+8 
ERAHI	*= *+8 
EXPRQ	*= *+8 
EXPXC	*= *+8 
EXPYC	*= *+8 
EXPXPL	*= *+64 
EXPYPL	*= *+64 
PMLOC	= $3800 
PMM	= PMLOC+$0300 
PM0	= PMLOC+$0400 
PM1	= PMLOC+$0500 
PM2	= PMLOC+$0600 
PM3	= PMLOC+$0700 
TITLESC	= PMM
SCRSCO	= $3800 
SCREEN	= $4100 
SCREEN2	= $5000 
;
	*= SCRSCO
	.SBYTE "       000000       "
	*= $02E0 
	.WORD INIT
	*= $6000 
;
;   INITIALIZATION
;
INIT
;   LDA # <INIT
;   STA DOSVEC
;   LDA # >INIT
;   STA DOSVEC+1
	LDA #<TITLEDL
	STA SDLSTL
	LDA #>TITLEDL
	STA SDLSTL+1 
	JSR TITLE
;
GAMEINIT
	LDA #<DLIST
	STA SDLSTL
	LDA #>DLIST
	STA SDLSTL+1 
	LDA #192 
	STA NMIEN
	LDA #<DLI
	STA VDSLST
	LDA #>DLI
	STA VDSLST+1 
	LDA #>PMLOC
	STA PMBASE
	LDA #62 
	STA SDMCTL
	LDA #3 
	STA GRACTL
	LDA #1 
	STA GPRIOR
	LDA #0 
	STA SIZEP0
	STA SIZEP0+1 
	STA SIZEP0+2 
	STA SIZEP0+3 
	STA SIZEM
	LDA #$86 
	STA PCOLR0
	LDA #$A8 
	STA PCOLR0+1 
	LDA #$0D 
	STA PCOLR0+3 
	LDA #$0A 
	STA DCOLSV
	LDA #0 
	TAY 
CLMEM	STA PMM,Y
	STA PM0,Y
	STA PM1,Y
	STA PM2,Y
	STA PM3,Y
	STA YPLOTL,Y
	STA YPLOTH,Y
	INY 
	BNE CLMEM
	LDX #0 
	LDA #<SCREEN
	STA LO
	LDA #>SCREEN
	STA HI
YADRL	LDA LO
	STA YPLOTL,X
	LDA HI
	STA YPLOTH,X
	LDA #0 
	TAY 
YADR1	STA (LO),Y
	INY 
	CPY #40 
	BCC YADR1
	CLC 
	LDA LO
	ADC #40 
	STA LO
	LDA HI
	ADC #0 
	STA HI
	INX 
	CPX #193 
	BCC YADRL
	LDA #7 	;DEFERRED
	LDX #>DVBLANK
	LDY #<DVBLANK
	JSR SETVBV
	LDA #6 	;IMMEDIATE
	LDX #>VBLANK
	LDY #<VBLANK
	JSR SETVBV
	JMP START
;
TITLEDL	.BYTE $70 ,$70 ,$70 ,$70 ,$70 ,$70 ,$70 ,$70 ,$70 ,$70 ,$70 ,$70 ,$70 
TTLDLSZ	.BYTE $46 
	.WORD TITLESC
	.BYTE 6 ,$41 
	.WORD TITLEDL
;
TITLE	LDA #0 
	STA XSAVE
	STA XLOOP
	JSR TTLCLR
	LDA #60 
	STA YLOOP
	JSR DELAY
TTLOOP	LDA #140 
	STA YLOOP
	LDA #15 
	STA COLOR0
	JSR TTLCLR
	LDY #$46 
	LDA XLOOP
	CMP #1 
	BNE TTL01
	INY 
TTL01	STY TTLDLSZ
	LDY #0 
	LDX XSAVE
TTL1	LDA CREDITS,X
	CMP #$FF 
	BEQ TTL1A
	STA TITLESC,Y
	INX 
	INY 
	BNE TTL1
TTL1A	INX 
	STX XSAVE
	INC XLOOP
	JSR DELAY
	LDA #2 
	STA YLOOP
TTL2	JSR DELAY
	DEC COLOR0
	BNE TTL2
	LDA #60 
	STA YLOOP
	JSR DELAY
	LDA XLOOP
	CMP #3 
	BCC TTLOOP
	RTS 
;
TTLCLR	LDY #39 
	LDA #0 
TLC0	STA TITLESC,Y
	DEY 
	BPL TLC0
	RTS 
;
DELAY	LDA #0 
	STA RTCLOK
DEL1	LDA RTCLOK
	CMP YLOOP
	BCC DEL1
	RTS 
;
CREDITS	.SBYTE "  ANALOG COMPUTING  "
	.SBYTE "      PRESENTS"
	.SBYTE "       A. D. C.      AIR DEFENSE COMMAND"
	.SBYTE "   BY ROB MCMULLEN"
;
DLI	PHA 
	LDA DCOLSV
	CLC 
	ADC #$10 
	STA DCOLSV
	STA COLPF0+2 
	PLA 
	RTI 
;
DLIST	.BYTE $70 ,$70 ,$46 
	.WORD SCRSCO
	.BYTE $CE 
	.WORD SCREEN
	.BYTE 14 ,14 ,14 ,14 ,14 ,14 ,14 
	.BYTE 14 ,14 ,14 ,14 ,14 ,14 ,14 
	.BYTE 14 ,14 ,14 ,14 ,14 ,14 ,14 
	.BYTE 14 ,14 ,14 ,14 ,14 ,14 ,14 
	.BYTE 14 ,14 ,14 ,14 ,14 ,14 ,14 
	.BYTE 14 ,14 ,14 ,14 ,14 ,14 ,14 
	.BYTE 14 ,14 ,14 ,14 ,14 ,14 ,14 
	.BYTE 14 ,14 ,14 ,14 ,14 ,14 ,14 
	.BYTE 14 ,14 ,14 ,14 ,14 ,14 ,14 
	.BYTE 14 ,14 ,14 ,14 ,14 ,14 ,14 
	.BYTE 14 ,14 ,14 ,14 ,14 ,14 ,14 
	.BYTE 14 ,14 ,14 ,14 ,14 ,14 ,14 
	.BYTE 14 ,14 ,14 ,14 ,14 ,14 ,14 
	.BYTE 14 ,14 ,14 ,14 ,$4E 
	.WORD SCREEN2
	.BYTE 14 ,14 ,14 ,14 ,14 ,14 ,14 
	.BYTE 14 ,14 ,14 ,14 ,14 ,14 ,14 
	.BYTE 14 ,14 ,14 ,14 ,14 ,14 ,14 
	.BYTE 14 ,14 ,14 ,14 ,14 ,14 ,14 
	.BYTE 14 ,14 ,14 ,14 ,14 ,14 ,14 
	.BYTE 14 ,14 ,14 ,14 ,14 ,14 ,14 
	.BYTE 14 ,14 ,14 ,14 ,14 ,14 ,14 
	.BYTE 14 ,14 ,14 ,14 ,14 ,14 ,14 
	.BYTE 14 ,14 ,14 ,14 ,14 ,14 ,14 
	.BYTE 14 ,14 ,14 ,14 ,14 ,14 ,14 
	.BYTE 14 ,14 ,14 ,14 ,14 ,14 ,14 
	.BYTE 14 ,14 ,14 ,14 ,14 ,14 ,14 
	.BYTE 14 ,14 ,14 ,14 ,14 ,14 ,14 
	.BYTE 14 ,14 ,14 ,14 ,$41 
	.WORD DLIST
;
;   PLAYER MISSLE SHAPES
;
PMGUN	.BYTE 0 ,0 ,0 ,0 ,0 ,$7E ,$7E ,$F0 
	.BYTE 0 ,0 ,0 ,0 ,$0E ,$7E ,$70 ,$F0 
	.BYTE 0 ,0 ,0 ,6 ,$1E ,$78 ,$60 ,$F0 
	.BYTE 0 ,0 ,6 ,$0E ,$3C ,$70 ,$60 ,$F0 
	.BYTE 0 ,6 ,$0E ,$1C ,$38 ,$70 ,$60 ,$F0 
	.BYTE 0 ,$0C ,$1C ,$38 ,$30 ,$70 ,$60 ,$F0 
	.BYTE 0 ,$18 ,$18 ,$38 ,$30 ,$70 ,$60 ,$F0 
	.BYTE 0 ,$18 ,$38 ,$30 ,$30 ,$70 ,$60 ,$F0 
	.BYTE 0 ,$30 ,$30 ,$30 ,$60 ,$60 ,$60 ,$F0 
	.BYTE 0 ,$30 ,$30 ,$60 ,$60 ,$60 ,$60 ,$F0 
	.BYTE 0 ,$60 ,$60 ,$60 ,$60 ,$60 ,$60 ,$F0 
	.BYTE 0 ,$0C ,$0C ,6 ,6 ,6 ,6 ,$0F 
	.BYTE 0 ,$0C ,$0C ,$0C ,6 ,6 ,6 ,$0F 
	.BYTE 0 ,$18 ,$1C ,$0C ,$0C ,$0E ,6 ,$0F 
	.BYTE 0 ,$18 ,$18 ,$1C ,$0C ,$0E ,6 ,$0F 
	.BYTE 0 ,$30 ,$38 ,$1C ,$0C ,$0E ,6 ,$0F 
	.BYTE 0 ,$60 ,$70 ,$38 ,$1C ,$0E ,6 ,$0F 
	.BYTE 0 ,0 ,$60 ,$70 ,$3C ,$0E ,6 ,$0F 
	.BYTE 0 ,0 ,0 ,$60 ,$78 ,$1E ,6 ,$0F 
	.BYTE 0 ,0 ,0 ,0 ,$70 ,$7E ,$0E ,$0F 
	.BYTE 0 ,0 ,0 ,0 ,0 ,$7E ,$7E ,$0F 
;
GUNMOVE
	LDY #126 
	LDA GUNDIR
	CMP #11 
	BCC GUN1
	LDY #122 
GUN1	STY HPOSP0+3 
	ASL A
	ASL A
	ASL A
	TAY 	;POS. IN TABLE
	LDX #199 
GUN2	LDA PMGUN,Y
	STA PM3,X
	INY 
	INX 
	CPX #207 
	BCC GUN2
	RTS 
;
START	LDA #10 
	STA GUNDIR
ST0	LDA #0 
	STA RTCLOK
ST01	LDA RTCLOK
	CMP #4 
	BCC ST01
	LDA STICK0
	CMP #11 
	BNE ST1
	INC GUNDIR
ST1	CMP #7 
	BNE ST2
	DEC GUNDIR
ST2	LDA GUNDIR
	BPL ST3
	LDA #0 
	STA GUNDIR
ST3	CMP #21 
	BCC ST4
	LDA #20 
	STA GUNDIR
ST4	LDA STRIG0
	BNE ST0
	LDY #0 
ST5	LDA BACTIV,Y
	BEQ ST6
	INY 
	CPY #8 
	BCC ST5
	BCS ST0
ST6	LDA #$FF 
	STA BACTIV,Y
	LDA GUNDIR
	STA BDIR,Y
	LDA #79 
	STA BXPOS,Y
	LDA #172 
	STA BYPOS,Y
	JMP ST0
;
DVBLANK
	INC DCOUNT
	LDA DCOUNT
	AND #3 
	STA DCOUNT
	JSR GUNMOVE
	JSR BULLET
	JMP XITVBV
;
VBLANK
	INC VCOUNT
	AND #1 
	STA VCOUNT
	JMP SYSVBV
;
PLMASK	.BYTE $3F ,$CF ,$F3 ,$FC 
PLOTC0	.BYTE 0 ,0 ,0 ,0 
PLOTC1	.BYTE $40 ,$10 ,4 ,1 
PLOTC2	.BYTE $80 ,$20 ,8 ,2 
PLOTC3	.BYTE $C0 ,$30 ,$0C ,3 
;
XDIRP1	.BYTE 2 ,2 ,2 ,2 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,-1 ,-1 ,-1 ,-2 ,-2 ,-2 ,-2 ,-2 
XDIRP2	.BYTE 2 ,2 ,2 ,2 ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,-1 ,-1 ,-1 ,-2 ,-2 ,-2 ,-2 ,-2 ,-2 
XDIRP3	.BYTE 2 ,2 ,2 ,2 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,-1 ,-1 ,-1 ,-2 ,-2 ,-2 ,-2 ,-2 
XDIRP4	.BYTE 2 ,2 ,2 ,2 ,2 ,2 ,1 ,0 ,1 ,1 ,0 ,-1 ,-1 ,0 ,-1 ,-2 ,-2 ,-2 ,-2 ,-2 ,-2 
YDIRP1	.BYTE 0 ,0 ,1 ,1 ,2 ,2 ,2 ,2 ,2 ,2 ,2 ,2 ,2 ,2 ,2 ,2 ,2 ,1 ,1 ,0 ,0 
YDIRP2	.BYTE 0 ,1 ,1 ,2 ,2 ,2 ,2 ,2 ,2 ,2 ,2 ,2 ,2 ,2 ,2 ,2 ,2 ,2 ,1 ,1 ,0 
;
BULLET
	LDY #7 
BUL0	LDA BACTIV,Y
	BNE BUL01
	JMP BULXX
BUL01	LDA ERAHI,Y
	STA HI
	LDA ERALO,Y
	STA LO
	LDA #0 
	TAX 
	STA (LO,X)
	STY TEMP
	LDX BDIR,Y
	LDA DCOUNT
	LDY XDIRP1,X
	CMP #0 
	BEQ BUL1X
	LDY XDIRP2,X
	CMP #1 
	BEQ BUL1X
	LDY XDIRP3,X
	CMP #2 
	BEQ BUL1X
	LDY XDIRP4,X
BUL1X	STY XSAVE
	LDY YDIRP1,X
	AND #1 
	CMP #0 
	BEQ BUL1Y
	LDY YDIRP2,X
BUL1Y	STY YSAVE
	LDY TEMP
BUL1	LDA BXPOS,Y
	CLC 
	ADC XSAVE
	STA BXPOS,Y
	CMP #160 
	BCS OUTBNDS
	AND #3 
	STA PLOTPOS
	LDA BXPOS,Y
	LSR A
	LSR A
	STA TEMP
	LDA BYPOS,Y
	SEC 
	SBC YSAVE
	STA BYPOS,Y
	CMP #192 
	BCC BUL2
OUTBNDS
	LDA #0 
	STA BACTIV,Y
	BEQ BULXX
BUL2	TAX 
	LDA YPLOTL,X
	STA LO
	LDA YPLOTH,X
	STA HI
	CLC 
	LDA LO
	ADC TEMP
	STA LO
	STA ERALO,Y
	LDA HI
	ADC #0 
	STA HI
	STA ERAHI,Y
	LDX PLOTPOS
	LDA PLOTC3,X
	LDX #0 
	STA (LO,X)
BULXX	DEY 
	BMI BULRTS
	JMP BUL0
BULRTS	RTS 
