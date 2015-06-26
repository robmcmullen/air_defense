	.OPT NOLIST,NOEJECT
;
;   GAME 1.0       
;   BY ROB McMULLEN
;
;   OS VARS.
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
PLPFC0	= $D004 
HPOSM0	= $D004 
MSPLC0	= $D008 
SIZEP0	= $D008 
PLPLC0	= $D00C 
SIZEM	= $D00C 
COLPF0	= $D016 
GRACTL	= $D01D 
HITCLR	= $D01E 
CONSOL	= $D01F 
AUDF1	= $D200 
AUDC1	= $D201 
AUDCTL	= $D208 
RANDOM	= $D20A 
SKCTL	= $D20F 
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
;   ZERO PAGE
;
	*= $80 
VCOUNT	*= *+1 
DCOUNT	*= *+1 
XLOOP	*= *+1 
YLOOP	*= *+1 
LO	*= *+1 
HI	*= *+1 
TEMPLO	*= *+1 
TEMPHI	*= *+1 
COUNT	*= *+1 
COUNTR	*= *+1 
GUNDIR	*= *+1 
GCOUNT	*= *+1 
XSAVE	*= *+1 
YSAVE	*= *+1 
PLOTPOS	*= *+1 
PLOTX	*= *+1 
PLOTY	*= *+1 
PLOTCLR	*= *+1 
XCENTR	*= *+1 
YCENTR	*= *+1 
TEMP	*= *+1 
XTEMP	*= *+1 
YTEMP	*= *+1 
EXSCNT	*= *+1 
EXPCNT	*= *+1 
LASCNT	*= *+1 
LEVEL	*= *+1 
MCOUNT	*= *+1 
STOP?	*= *+1 
RTGDIR	*= *+1 
RTGYL	*= *+1 
HEXTMP	*= *+1 
SCORE	*= *+3 
SCADD	*= *+3 
LIVES	*= *+1 
LIVCNT	*= *+1 
LVLOK?	*= *+1 
STKCNT	*= *+1 
TRGCNT	*= *+1 
RTGO	*= *+1 
TPOS	*= *+1 
PLAST	*= *+1 
;
;   OTHER VARS.
;
	*= $3000 
YPLOTL	*= *+200 
YPLOTH	*= *+200 
BACTIV	*= *+8 
BDIR	*= *+8 
BXPOSL	*= *+8 
BXPOS	*= *+8 
BYPOSL	*= *+8 
BYPOS	*= *+8 
ERALO	*= *+8 
ERAHI	*= *+8 
EACTIV	*= *+20 
EXPOS	*= *+20 
EYPOS	*= *+20 
ECOUNT	*= *+20 
MACTIV	*= *+4 
MXPOSL	*= *+4 
MXPOS	*= *+4 
MYPOSL	*= *+4 
MYPOS	*= *+4 
MXDIR	*= *+4 
MYDIR	*= *+4 
MTIME	*= *+4 
MIMAGE	*= *+4 
MHOLD	*= *+4 
STARX	*= *+16 
STARY	*= *+16 
YBSROM	*= *+40 
YBSRAM	*= *+40 
PACTIV	*= *+10 
PXPOS	*= *+10 
PYPOSL	*= *+10 
PYPOS	*= *+10 
PCHUTE	*= *+10 
PLANEL	*= *+16 
;
PMLOC	= $3800 
PMM	= $3B00 
PM0	= $3C00 
PM1	= $3D00 
PM2	= $3E00 
PM3	= $3F00 
SCRSCO	= $3800 
SCREEN	= $4100 
;
	*= $02E0 
	.WORD INIT
	*= $6000 
;
INIT
;   LDA # <INIT
;   STA DOSVEC
;   LDA # >INIT
;   STA DOSVEC+1
;
	LDX #0 
	LDA #<SCREEN
	STA LO
	LDA #>SCREEN
	STA HI
YADRL	LDA LO
	STA YPLOTL,X
	LDA HI
	STA YPLOTH,X
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
	JSR CLRVAR
;
GAMEINIT
	JSR TITLE
	JSR CLRSCR
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
	STA SKCTL
	LDA #17 
	STA GPRIOR
	LDA #0 
	STA SIZEP0
	STA SIZEP0+1 
	STA SIZEP0+2 
	STA SIZEP0+3 
	STA SIZEM
	STA EXPCNT
	STA EXSCNT
	STA AUDCTL
	STA LASCNT
	LDA #$B6 
	STA PCOLR0+3 
	LDA #$D8 
	STA COLOR0
	LDA #$0A 
	STA COLOR0+2 
	LDA #1 
	STA STOP?
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
CLRSCR
	LDA #<SCREEN
	STA LO
	LDA #>SCREEN
	STA HI
CLRS0	LDA #0 
	TAY 
CLRS1	STA (LO),Y
	INY 
	BNE CLRS1
	INC HI
	LDA HI
	CMP #$5F 
	BCC CLRS0
	RTS 
;
CLRVAR
	LDA #0 
	TAY 
CLMEM	STA PMM,Y
	STA PM0,Y
	STA PM1,Y
	STA PM2,Y
	STA PM3,Y
	STA BACTIV,Y
	STA MACTIV,Y
	STA SCRSCO,Y
	INY 
	BNE CLMEM
	RTS 
;
;
TITLEDL	.BYTE $70 ,$70 ,$46 
	.WORD SCRSCO
	.BYTE $70 ,$70 ,$70 ,$70 ,$70 ,$70 ,$70 ,$70 ,$70 ,$70 ,$47 
	.WORD TITLESC
	.BYTE 6 ,$41 
	.WORD TITLEDL
;
TITLE	LDA #<TITLEDL
	STA SDLSTL
	LDA #>TITLEDL
	STA SDLSTL+1 
	LDA #8 
	STA CONSOL
TTL0	LDA CONSOL
	CMP #6 
	BNE TTL0
	RTS 
;
TITLESC	.SBYTE +$80 ,"     AIR DEFENSE    "
	.SBYTE +$C0 ," ----PRESS START----"
;
DLI	PHA 
	LDA COLOR0+2 
	CLC 
	ADC #$10 
	STA COLOR0+2 
	LDA #<DLI2
	STA VDSLST
	PLA 
	RTI 
;
DLI2	PHA 
	LDA #$28 
	STA WSYNC
	STA COLPF0+2 
	LDA #<DLI
	STA VDSLST
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
	.WORD SCREEN+$0F00 
	.BYTE 14 ,14 ,14 ,14 ,14 ,14 ,14 
	.BYTE 14 ,14 ,14 ,14 ,14 ,14 ,14 
	.BYTE 14 ,14 ,14 ,14 ,14 ,14 ,14 
	.BYTE 14 ,14 ,14 ,14 ,14 ,14 ,14 
	.BYTE 14 ,14 ,14 ,14 ,14 ,14 ,14 
	.BYTE 14 ,14 ,14 ,14 ,14 ,14 ,14 
	.BYTE 14 ,14 ,14 ,14 ,14 ,14 ,14 
	.BYTE 14 ,14 ,14 ,14 ,14 ,14 ,14 
	.BYTE 14 ,14 ,14 ,$8E ,14 ,14 ,14 
	.BYTE 14 ,14 ,14 ,14 ,14 ,14 ,14 
	.BYTE 14 ,14 ,14 ,14 ,14 ,14 ,14 
	.BYTE 14 ,14 ,14 ,14 ,14 ,14 ,14 
	.BYTE 14 ,14 ,14 ,14 ,14 ,14 ,14 
	.BYTE 14 ,14 ,14 ,14 ,$41 
	.WORD DLIST
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
	LDA LIVES
	BEQ GUNX
	LDA #126 
	LDY GUNDIR
	CPY #22 
	BCC GUN1
	LDA #122 
GUN1	STA HPOSP0+3 
	TYA 
	LSR A
	ASL A
	ASL A
	ASL A
	TAY 
	LDX #180 
GUN2	LDA PMGUN,Y
	STA PM3,X
	INY 
	INX 
	CPX #188 
	BCC GUN2
GUNX	RTS 
;
START	LDA #10 
	STA GUNDIR
	JSR CLRSCO
	JSR RTG
	JSR BASEDRAW
	JSR FINDBASE
	JSR STARSET
	LDA #0 
	STA STOP?
	STA LIVCNT
	LDA #1 
	STA LIVES
	STA HITCLR
	STA LEVEL
;
MAIN	LDA RTCLOK
MN1	CMP RTCLOK
	BEQ MN1
	INC STKCNT
	LDA STKCNT
	CMP #2 
	BCC MN2
	LDA #0 
	STA STKCNT
	JSR GETSTK
MN2	INC TRGCNT
	LDA TRGCNT
	CMP #3 
	BCC MN3
	LDA #0 
	STA TRGCNT
	JSR BULREQ
MN3	JSR KEYS
	JSR ALIVE
	JSR NEWENEMY
	JSR PARLAUNCH
	JMP MAIN
;
GETSTK
	LDA LIVES
	BEQ ST4
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
ST3	CMP #42 
	BCC ST4
	LDA #41 
	STA GUNDIR
ST4	RTS 
;
BULREQ
	LDA STRIG0
	BNE ST4
	LDY #0 
BRQ1	LDA BACTIV,Y
	BEQ BRQ2
	INY 
	CPY #8 
	BCC BRQ1
	RTS 
BRQ2	LDA #7 
	STA LASCNT
	LDA #$FF 
	STA BACTIV,Y
	LDA GUNDIR
	STA BDIR,Y
	LDA #79 
	STA BXPOS,Y
	LDA #154 
	STA BYPOS,Y
	LDA #0 
	STA BXPOSL,Y
	STA BYPOSL,Y
	RTS 
;
DVBLANK
	CLD 
	LDA STOP?
	BNE DVX
	INC DCOUNT
	JSR BULLET
	JSR EXPHAN
	JSR SOUNDS
	JSR ENEMY
	JSR STARS
	JSR GUNMOVE
	JSR PARCOLL
	JSR COLLIDE
DVX	JMP XITVBV
;
VBLANK
	CLD 
	LDA STOP?
	BNE VBX
	INC VCOUNT
	JSR PARACHUTE
VBX	JMP SYSVBV
;
PLMASK	.BYTE $3F ,$CF ,$F3 ,$FC 
PLOTC0	.BYTE 0 ,0 ,0 ,0 
PLOTC1	.BYTE $40 ,$10 ,4 ,1 
PLOTC2	.BYTE $80 ,$20 ,8 ,2 
PLOTC3	.BYTE $C0 ,$30 ,$0C ,3 
;
XDIRHI	.BYTE 2 ,2 ,2 ,2 ,2 ,2 ,2 ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,1 ,1 ,1 ,1 ,1 ,2 ,2 ,2 ,2 ,2 ,2 ,2 ,2 
XDIRLO	.BYTE 0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,224 ,192 ,152 ,112 ,64 ,16 ,216 ,160 ,104 ,80 ,56 ,32 ,0 ,0 
	.BYTE 32 ,56 ,80 ,104 ,160 ,216 ,16 ,64 ,112 ,152 ,192 ,224 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 
YDIRHI	.BYTE 0 ,0 ,0 ,0 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,2 ,2 ,2 ,2 ,2 ,2 ,2 ,2 ,2 ,2 ,2 ,2 ,2 ,2 ,2 ,2 ,2 ,2 ,2 ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 
YDIRLO	.BYTE 0 ,64 ,128 ,192 ,0 ,64 ,112 ,152 ,192 ,224 ,240 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 
	.BYTE 0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,240 ,224 ,192 ,152 ,112 ,64 ,0 ,192 ,128 ,64 ,0 
;
BULLET
	LDY #7 
BUL0	LDA BACTIV,Y
	BEQ BULXX
	LDA BXPOS,Y
	STA PLOTX
	LDA BYPOS,Y
	STA PLOTY
	STY YSAVE
	JSR PLOT
	LDA (LO),Y
	AND PLMASK,X
	STA (LO),Y
	LDY YSAVE
	LDX BDIR,Y
	CPX #22 
	BCS BUL1S
	LDA BXPOSL,Y
	CLC 
	ADC XDIRLO,X
	STA BXPOSL,Y
	LDA BXPOS,Y
	ADC XDIRHI,X
	STA BXPOS,Y
	JMP BUL2
BUL1S	LDA BXPOSL,Y
	SEC 
	SBC XDIRLO,X
	STA BXPOSL,Y
	LDA BXPOS,Y
	SBC XDIRHI,X
	STA BXPOS,Y
BUL2	STA PLOTX
	LDA BYPOSL,Y
	SEC 
	SBC YDIRLO,X
	STA BYPOSL,Y
	LDA BYPOS,Y
	SBC YDIRHI,X
	STA BYPOS,Y
	STA PLOTY
	STY YSAVE
	JSR PLOT
	BCS OUTBNDS
	LDA (LO),Y
	AND PLMASK,X
	ORA PLOTC3,X
	STA (LO),Y
	LDY YSAVE
BULXX	DEY 
	BPL BUL0
	RTS 
;
OUTBNDS
	LDY YSAVE
	LDA #0 
	STA BACTIV,Y
	BEQ BULXX
;
PLOT
	LDA PLOTX
	CMP #160 
	BCS PLXXX
	LDA PLOTY
	CMP #192 
	BCS PLXXX
	LDA PLOTX
	AND #3 
	TAX 
	LDA PLOTX
	LSR A
	LSR A
	LDY PLOTY
	CLC 
	ADC YPLOTL,Y
	STA LO
	LDA YPLOTH,Y
	ADC #0 
	STA HI
	LDY #0 
	CLC 
PLXXX	RTS 
;
NEWEXP
	LDA #64 
	STA EXSCNT
	LDY #0 
NEW0	LDA EACTIV,Y
	BEQ NEW1
	INY 
	CPY #20 
	BCC NEW0
	RTS 
NEW1	LDA #$FF 
	STA EACTIV,Y
	LDA XCENTR
	STA EXPOS,Y
	LDA YCENTR
	STA EYPOS,Y
	LDA #0 
	STA ECOUNT,Y
RT1	RTS 
;
EXPHAN
	LDA #0 
	STA COUNTR
RUNLP	INC COUNTR
	LDX COUNTR
	CPX #20 
	BCS RT1
	LDA EACTIV,X
	BEQ RUNLP
	LDA #1 
	STA PLOTCLR
	LDA ECOUNT,X
	CMP #37 
	BMI DOPLOT
	DEC PLOTCLR
	SEC 
	SBC #37 
	CMP #37 
	BMI DOPLOT
	LDA #0 
	STA EACTIV,X
	JMP RUNLP
DOPLOT	INC ECOUNT,X
	TAY 
	CLC 
	LDA EXPOS,X
	ADC XCOORD,Y
	STA PLOTX
	CLC 
	LDA EYPOS,X
	ADC YCOORD,Y
	STA PLOTY
	JSR PLOT
	BCS RUNLP
	LDA PLOTCLR
	BEQ GOEXP
	LDA PLOTC2,X
GOEXP	STA PLOTCLR
GETEXP	LDA (LO),Y
	AND PLOTC3,X
	CMP PLOTC3,X
	BEQ GEXP1
	LDA (LO),Y
	AND PLMASK,X
	ORA PLOTCLR
	STA (LO),Y
GEXP1	TYA 
	CLC 
	ADC #40 
	TAY 
	CPY #41 
	BCC GETEXP
	JMP RUNLP
;
XCOORD	.BYTE 0 ,1 ,-1 ,0 ,-1 ,1 
	.BYTE 0 ,2 ,-1 ,-2 ,0 ,1 
	.BYTE 0 ,-2 ,2 ,1 ,1 ,-1 
	.BYTE 0 ,2 ,-2 ,-1 ,3 ,0 
	.BYTE -3 ,-2 ,3 ,2 ,-1 ,-2 
	.BYTE 1 ,-1 ,3 ,-3 ,1 ,-3 ,2 
YCOORD	.BYTE 0 ,0 ,2 ,-2 ,0 ,2 
	.BYTE 2 ,0 ,-2 ,2 ,4 ,-2 
	.BYTE -4 ,-2 ,2 ,4 ,-4 ,4 
	.BYTE 6 ,-2 ,0 ,-4 ,2 ,-6 
	.BYTE 0 ,-4 ,-2 ,4 ,6 ,4 
	.BYTE -6 ,-6 ,0 ,2 ,6 ,-2 ,-4 
;
FINDBASE
	LDY #0 
FB1	STY XSAVE
	LDX #150 
FB2	LDA YPLOTL,X
	STA LO
	LDA YPLOTH,X
	STA HI
	LDY XSAVE
	LDA (LO),Y
	BNE FB3
	INX 
	BNE FB2
FB3	TXA 
	STA YBSROM,Y
	STA YBSRAM,Y
	INY 
	CPY #40 
	BCC FB1
	RTS 
;
BASEDRAW
	LDA #156 
	STA PLOTY
	LDA #72 
	STA XSAVE
	LDA #88 
	STA XTEMP
BD0	LDA XSAVE
	STA PLOTX
BD1	JSR PLOT
	LDA (LO),Y
	ORA PLOTC3,X
	STA (LO),Y
	INC PLOTX
	LDA PLOTX
	CMP XTEMP
	BCC BD1
	DEC XSAVE
	INC XTEMP
	INC PLOTY
	LDA PLOTY
	CMP #192 
	BCC BD0
	RTS 
;
SOUNDS
	LDA EXSCNT
	BEQ NXSND
	LSR A
	LSR A
	STA AUDC1+6 
	LDA #$40 
	STA AUDF1+6 
	DEC EXSCNT
;
NXSND	LDX LASCNT
	LDA LFQTBL,X
	STA AUDF1+4 
	BEQ NOSND
	DEC LASCNT
	LDA #$A6 
NOSND	STA AUDC1+4 
	RTS 
;
LFQTBL	.BYTE 0 ,254 ,212 ,170 ,127 ,85 ,43 ,1 
;
CLRPL
	TXA 
	CLC 
	ADC #>PM0
	STA HI
	LDA #0 
	STA LO
	TAY 
CLRP1	STA (LO),Y
	INY 
	BNE CLRP1
	RTS 
;
SCOML	.BYTE $10 ,$10 ,$10 ,$10 ,$30 ,$30 ,$20 ,$20 ,$50 ,$50 ,$50 
;
COLLIDE
	LDX #0 
COL1	LDA PLPFC0,X
	AND #4 
	CMP #4 
	BNE COLXXX
	LDY MIMAGE,X
	LDA SCOML,Y
	STA SCADD+2 
	JSR SCOREDIS
COL11	LDA MXPOS,X
	CLC 
	ADC #4 
	STA XCENTR
	LDA MYPOS,X
	CLC 
	ADC #3 
	STA YCENTR
	JSR NEWEXP
	LDA #$80 
	STA MACTIV,X
	LDA #0 
	STA HPOSP0,X
COLXXX	INX 
	CPX #3 
	BCC COL1
;
	LDA PLPLC0+3 
	BEQ COL3
	LDA #79 
	STA XCENTR
	LDA #152 
	STA YCENTR
	JSR NEWEXP
	LDA #0 
	STA LIVES
	STA HPOSP0+3 
COL3	STA HITCLR
	RTS 
;
RTG
	LDA #-1 
	STA RTGDIR
	LDY #170 
	STY YTEMP
	LDX #0 
	STX RTGO
	STX XTEMP
RTGL	LDA RTGDIR
	BMI RTG0
	LDA RTGYL
	CLC 
	ADC RANDOM
	STA RTGYL
	BCC RTG01
	INC YTEMP
	BNE RTG01
RTG0	LDA RTGYL
	SEC 
	SBC RANDOM
	STA RTGYL
	BCS RTG01
	DEC YTEMP
RTG01	LDA YTEMP
	CMP #180 
	BCC RTG1
	LDA #10 
	STA RTGO
	JMP RTG12
RTG1	CMP #160 
	BCS RTG2
	LDA #10 
	STA RTGO
	JMP RTG12
RTG2	LDA RTGO
	BEQ RTG11
	DEC RTGO
	BNE RTG3
RTG11	LDA RANDOM
	CMP #175 
	BCC RTG3
RTG12	LDA RTGDIR
	EOR #$FE 
	STA RTGDIR
RTG3	LDA YTEMP
	STA PLOTY
	LDA XTEMP
	STA PLOTX
	JSR PLOT
RTG4	LDA (LO),Y
	AND PLMASK,X
	ORA PLOTC3,X
	STA (LO),Y
	LDA LO
	CLC 
	ADC #40 
	STA LO
	BCC RTG5
	INC HI
RTG5	INC PLOTY
	LDA PLOTY
	CMP #192 
	BCC RTG4
	INC XTEMP
	LDA XTEMP
	CMP #160 
	BCC RTGL
	RTS 
;
STARSET
	LDX #0 
SS1	LDA RANDOM
	CMP #160 
	BCS SS1
	STA STARX,X
SS2	LDA RANDOM
	CMP #150 
	BCS SS2
	STA STARY,X
	INX 
	CPX #16 
	BCC SS1
	RTS 
;
STARS
	LDX #0 
STA0	LDA STARX,X
	STA PLOTX
	LDA STARY,X
	STA PLOTY
	STX XTEMP
	JSR PLOT
	CLC 
	LDA RANDOM
	BMI STA1
	SEC 
STA1	LDA (LO),Y
	AND PLMASK,X
	BCC STA2
	ORA PLOTC2,X
STA2	STA (LO),Y
	LDX XTEMP
	INX 
	CPX #16 
	BCC STA0
	RTS 
;
SCOREDIS
	SED 
	CLC 
	LDA SCADD+2 
	ADC SCORE+2 
	STA SCORE+2 
	LDA SCADD+1 
	ADC SCORE+1 
	STA SCORE+1 
	LDA SCADD
	ADC SCORE
	STA SCORE
	CLD 
	JSR HEXCON
	STY SCRSCO+7 
	STA SCRSCO+8 
	LDA SCORE+1 
	JSR HEXCON
	STY SCRSCO+9 
	STA SCRSCO+10 
	LDA SCORE+2 
	JSR HEXCON
	STY SCRSCO+11 
	STA SCRSCO+12 
	LDA #0 
	STA SCADD+2 
	STA SCADD+1 
	STA SCADD
	RTS 
;
HEXCON
	STA HEXTMP
	LSR A
	LSR A
	LSR A
	LSR A
	ORA #$D0 
	TAY 
	LDA HEXTMP
	AND #$0F 
	ORA #$D0 
	RTS 
;
CLRSCO
	LDA #0 
	LDY #5 
CLRSC1	STA SCORE,Y
	DEY 
	BPL CLRSC1
	JMP SCOREDIS
;
KEYS
	LDA CH
	CMP #33 
	BNE KEYX
	LDA #1 
	STA STOP?
	JSR SHUTUP
KEY1	LDA SKCTL
	AND #4 
	CMP #4 
	BEQ KEY1
	LDA #255 
	STA CH
KEY2	LDA CH
	CMP #33 
	BNE KEY2
KEY3	LDA SKCTL
	AND #4 
	CMP #4 
	BEQ KEY3
	LDA #255 
	STA CH
	LDA #0 
	STA STOP?
KEYX	RTS 
;
SHUTUP	LDA #0 
	STA AUDC1
	STA AUDC1+2 
	STA AUDC1+4 
	STA AUDC1+6 
	RTS 
;
ALIVE
	LDA LIVES
	BNE ALX
	INC LIVCNT
	LDA LIVCNT
	CMP #60 
	BNE ALX
	LDA #1 
	STA STOP?
	JSR SHUTUP
	JSR CLRVAR
	JSR SCOREDIS
	PLA 
	PLA 
	JMP GAMEINIT
ALX	RTS 
;
MCHPL1	.BYTE $E0 ,$20 ,$74 ,$9A ,$9E ,$7C ,$A8 ,$7C ,0 
MCHPL2	.BYTE $38 ,$20 ,$71 ,$9A ,$9E ,$7C ,$A8 ,$7C ,0 
MCHPR1	.BYTE 7 ,4 ,$2E ,$59 ,$79 ,$3E ,$15 ,$3E ,0 
MCHPR2	.BYTE $1C ,4 ,$8E ,$59 ,$79 ,$3E ,$15 ,$3E ,0 
MJETL	.BYTE 1 ,$63 ,$FF ,$FF ,$1C ,$0C ,0 
MJETR	.BYTE $80 ,$C6 ,$FF ,$FF ,$38 ,$30 ,0 
MBMRL	.BYTE 1 ,$63 ,$BF ,$FF ,$7E ,$19 ,$0C ,0 
MBMRR	.BYTE $80 ,$C6 ,$FD ,$FF ,$7E ,$98 ,$30 ,0 
MSAT1	.BYTE $FE ,$B6 ,$B6 ,$FE ,$28 ,$44 ,$82 ,0 
MSAT2	.BYTE $FE ,$DA ,$DA ,$FE ,$28 ,$44 ,$82 ,0 
MSAT3	.BYTE $FE ,$6C ,$6C ,$FE ,$28 ,$44 ,$82 ,0 
;
MOFFSET	.BYTE 0 ,9 ,18 ,27 ,36 ,43 ,50 ,58 ,66 ,74 ,82 
MSWAPM	.BYTE 1 ,0 ,3 ,2 ,4 ,5 ,6 ,7 ,9 ,10 ,8 
MLFTRT	.BYTE 0 ,4 ,6 ,8 ,2 ,5 ,7 ,8 
MADDL	.BYTE 64 ,96 ,112 ,176 ,0 ,32 ,78 ,128 
MADDH	.BYTE 0 ,0 ,0 ,0 ,1 ,1 ,1 ,1 
;
NEWENEMY
	LDX #0 
NEWE1	LDA MACTIV,X
	BNE NEWEX
	INC MCOUNT
	LDA #$FE 
	STA MACTIV,X
	STA MHOLD,X
	LDA RANDOM
	AND #63 
	ORA #15 
	STA MTIME,X
NEWE12	LDA RANDOM
	AND #7 
	TAY 
	LDA PLANEL,Y
	BNE NEWE12
	LDA #1 
	STA PLANEL,Y
	TYA 
	ASL A
	ASL A
	ASL A
	STA MYPOS,X
	LDA RANDOM
	AND #7 
	TAY 
	LDA MLFTRT,Y
	STA MIMAGE,X
	LDA #159 
	CPY #4 
	BCC NEWE2
	INC MACTIV,X
	LDA #0 
NEWE2	STA MXPOS,X
	LDA RANDOM
	AND #$F0 
	ORA #$06 
	STA PCOLR0,X
	LDA RANDOM
	AND #3 
	CLC 
	ADC LEVEL
	STA MXDIR,X
	LDA #0 
	STA MXPOSL,X
	STA SIZEP0,X
	LDA MIMAGE,X
	CMP #6 
	BEQ NEWSX
	CMP #7 
	BEQ NEWSX
NEWEX	INX 
	CPX #3 
	BCC NEWE1
	RTS 
NEWSX	LDA #1 
	STA SIZEP0,X
	BNE NEWEX
;
ENEMY
	LDX #0 
ENM1	LDA MACTIV,X
	BNE ENM11
	JMP ENMX
ENM11	LDA MHOLD,X
	BPL ENM12
	DEC MTIME,X
	BNE ENM13
	LDA #0 
	STA MHOLD,X
ENM13	JMP ENMX
ENM12	LDY MXDIR,X
	LDA MACTIV,X
	CMP #$FE 
	BEQ ENM2
	CMP #$80 
	BEQ ENMOUT
	LDA MXPOSL,X
	CLC 
	ADC MADDL,Y
	STA MXPOSL,X
	LDA MXPOS,X
	ADC MADDH,Y
	STA MXPOS,X
	JMP ENM3
ENM2	LDA MXPOSL,X
	SEC 
	SBC MADDL,Y
	STA MXPOSL,X
	LDA MXPOS,X
	SBC MADDH,Y
	STA MXPOS,X
ENM3	CMP #160 
	BCS ENMOUT
	CLC 
	ADC #48 
	STA HPOSP0,X
	INC MTIME,X
	LDA MTIME,X
	CMP #8 
	BCC ENM4
	LDA #0 
	STA MTIME,X
	LDY MIMAGE,X
	LDA MSWAPM,Y
	STA MIMAGE,X
ENM4	LDA MYPOS,X
	CLC 
	ADC #32 
	STA LO
	TXA 
	CLC 
	ADC #>PM0
	STA HI
	STX XSAVE
	LDY MIMAGE,X
	LDX MOFFSET,Y
	LDY #0 
ENM5	LDA MCHPL1,X
	BEQ ENM6
	STA (LO),Y
	INX 
	INY 
	BNE ENM5
ENM6	LDX XSAVE
ENMX	INX 
	CPX #3 
	BCS ENMXXX
	JMP ENM1
ENMXXX	RTS 
;
ENMOUT
	LDA MYPOS,X
	LSR A
	LSR A
	LSR A
	TAY 
	LDA #0 
	STA PLANEL,Y
	STA MACTIV,X
	STA HPOSP0,X
	JSR CLRPL
	JMP ENMX
;
PARLFT	.BYTE 0 ,0 ,$15 ,$55 ,$40 ,$11 ,4 ,$15 ,$15 ,$15 ,$15 
PARRGT	.BYTE 0 ,0 ,0 ,$40 ,$40 ,0 ,0 ,0 ,0 ,0 ,0 
;
PARACHUTE
	LDX #0 
PARI	STX XSAVE
	LDA PACTIV,X
	BEQ PARX
	LDA PCHUTE,X
	BNE PARI1
	INC PYPOS,X
	BNE PAR0
PARI1	CLC 
	LDA PYPOSL,X
	ADC #$80 
	STA PYPOSL,X
	BCC PAR0
	INC PYPOS,X
PAR0	LDA PXPOS,X
	TAY 
	ASL A
	ASL A
	STA PLOTX
	LDY PYPOS,X
	DEY 
	DEY 
	STY PLOTY
	JSR PLOT
	LDA PLOTY
	CLC 
	ADC #11 
	CMP YBSRAM,Y
	BCS PAR1
	LDA PCHUTE,X
	BEQ PAR01
	JSR PLOTPAR
	JMP PARX
PAR01	JSR PLOTBOX
	JMP PARX
PAR1	LDA #0 
	STA PACTIV,X
	LDA PCHUTE,X
	BEQ PAR2
	JSR PLOTBOX
	LDY PXPOS,X
	LDA YBSRAM,Y
	SEC 
	SBC #5 
	STA YBSRAM,Y
	JMP PARX
PAR2	JSR ERABOX
PARX	LDX XSAVE
	INX 
	CPX #10 
	BCC PARI
	RTS 
;
PLOTPAR
	LDA LO
	STA TEMPLO
	LDA HI
	STA TEMPHI
	LDX #0 
	LDY #0 
PPR1	LDA PARLFT,X
	STA (LO),Y
	INY 
	LDA (LO),Y
	AND #$3F 
	ORA PARRGT,X
	STA (LO),Y
	DEY 
	CLC 
	LDA TEMPLO
	ADC #40 
	STA TEMPLO
	BCC PPR2
	INC TEMPHI
PPR2	INX 
	CPX #10 
	BCC PPR1
	RTS 
;
PLOTBOX
	LDA LO
	STA TEMPLO
	LDA HI
	STA TEMPHI
	LDY #0 
PBX0	LDA #0 
	STA (TEMPLO),Y
	TYA 
	CLC 
	ADC #40 
	TAY 
	BCC PBX0
	LDY #121 
	LDA (TEMPLO),Y
	AND #$3F 
	STA (TEMPLO),Y
	LDY #161 
	LDA (TEMPLO),Y
	AND #$3F 
	STA (TEMPLO),Y
	CLC 
	LDA LO
	ADC #36 
	STA TEMPLO
	LDA HI
	ADC #1 
	STA TEMPHI
PBX1	LDA #$15 
	STA (TEMPLO),Y
	TYA 
	CLC 
	ADC #40 
	TAY 
	CPY #121 
	BCC PBX1
	RTS 
;
ERABOX
	LDY PXPOS,X
	LDA YBSROM,Y
	STA YBSRAM,Y
	STA TPOS
	LDA LO
	STA TEMPLO
	LDA HI
	STA TEMPHI
ERB1	LDA #0 
	STA (TEMPLO),Y
	LDA TEMPLO
	CLC 
	ADC #40 
	STA TEMPLO
	BCC ERB2
	INC TEMPHI
ERB2	INC PLOTY
	LDA PLOTY
	CMP TPOS
	BCC ERB1
	RTS 
;
PARCOLL
	LDX #0 
PRCI	LDY #0 
PRC0	LDA BACTIV,Y
	BEQ PRCX
	LDA PACTIV,X
	BEQ PRCX
	LDA PXPOS,X
	ASL A
	ASL A
	STA TPOS
	LDA BXPOS,Y
	CMP TPOS
	BCC PRCX
	LDA TPOS
	CLC 
	ADC #5 
	STA TPOS
	LDA BXPOS,Y
	CMP TPOS
	BCS PRCX
	LDA BYPOS,Y
	CMP PYPOS,X
	BCC PRCX
	LDA PYPOS,X
	CLC 
	ADC #5 
	STA TPOS
	LDA BYPOS,Y
	CMP TPOS
	BCS PRCB
	LDA #0 
	STA PCHUTE,X
	BEQ PRCX
PRCB	LDA TPOS
	CLC 
	ADC #4 
	STA TPOS
	LDA BYPOS,Y
	CMP TPOS
	BCC PREXP
PRCX	INY 
	CPY #8 
	BCC PRC0
	INX 
	CPX #10 
	BCC PRCI
	RTS 
;
PREXP
	LDA #0 
	STA PACTIV,X
	LDA PXPOS,X
	ASL A
	ASL A
	CLC 
	ADC #2 
	STA XCENTR
	LDA PYPOS,X
	CLC 
	ADC #4 
	STA YCENTR
	STY YSAVE
	STX XSAVE
	JSR NEWEXP
	LDA #1 
	STA SCADD+2 
	JSR SCOREDIS
	LDX XSAVE
	LDY YSAVE
	JMP PRCX
;
PARLAUNCH
	LDX #0 
PRL0	LDA PACTIV,X
	BNE PRLX
	LDA RANDOM
	AND #$1F 
	STA PYPOS,X
PRL1	LDA RANDOM
	AND #$3F 
	CMP #40 
	BCS PRL1
	STA PXPOS,X
	LDA #1 
	STA PCHUTE,X
	LDA #$FF 
	STA PACTIV,X
PRLX	INX 
	CPX #10 
	BCC PRL0
	RTS 
