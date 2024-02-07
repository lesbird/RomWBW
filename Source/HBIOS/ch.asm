;
;==================================================================================================
; CH375/376 USB/SD DRIVER
;==================================================================================================
;
; https://www.wch-ic.com/
;
; Thanks and credit to Alan Cox.  Much of this driver is based on
; his code in FUZIX (https://github.com/EtchedPixels/FUZIX).
;
; This file is the core driver file for the CH37x devices.  Since the
; CH376 supports both a USB Drive interface and an SD Card interface,
; the code for these interfaces is included as needed.  See
; chusb.asm and chsd.asm.
;
; CH DEVICE TYPES
;
CHTYP_NONE	.EQU	0		; NONE
CHTYP_375	.EQU	1		; CH375
CHTYP_376	.EQU	2		; CH376
;
; CH MODE MANAGEMENT
;
CH_MODE_UNK	.EQU	0		; CURRENT MODE UNKNOWN
CH_MODE_USB	.EQU	1		; CURRENT MODE = USB
CH_MODE_SD	.EQU	2		; CURRENT MODE = SD
;
; CH375/376 COMMANDS
;
CH_CMD_VER	.EQU	$01		; GET IC VER
CH_CMD_RESET	.EQU	$05		; FULL CH37X RESET
CH_CMD_EXIST	.EQU	$06		; CHECK EXISTS
CH_CMD_MAXLUN	.EQU	$0A		; GET MAX LUN NUMBER
CH_CMD_PKTSEC	.EQU	$0B		; SET PACKETS PER SECTOR
CH_CMD_SETRETRY	.EQU	$0B		; SET RETRIES
CH_CMD_FILESIZE	.EQU	$0C		; GET FILE SIZE (376)
CH_CMD_MODE	.EQU	$15		; SET USB MODE
CH_CMD_TSTCON	.EQU	$16		; TEST CONNECT
CH_CMD_ABRTNAK	.EQU	$17		; ABORT DEVICE NAK RETRIES
CH_CMD_STAT	.EQU	$22		; GET STATUS
CH_CMD_RD6	.EQU	$27		; READ USB DATA (375 & 376)
CH_CMD_RD5	.EQU	$28		; READ USB DATA (375)
CH_CMD_WR5	.EQU	$2B		; WRITE USB DATA (375)
CH_CMD_WR6	.EQU	$2C		; WRITE USB DATA (376)
CH_CMD_WRREQDAT	.EQU	$2D		; WRITE REQUESTED DATA (376)
CH_CMD_SET_FN	.EQU	$2F		; SET FILENAME (376)
CH_CMD_DSKMNT	.EQU	$31		; DISK MOUNT
CH_CMD_FOPEN	.EQU	$32		; FILE OPEN (376)
CH_CMD_FCREAT	.EQU	$34		; FILE CREATE (376)
CH_CMD_BYTE_LOC	.EQU	$39		; BYTE LOCATE
CH_CMD_BYTERD	.EQU	$3A		; BYTE READ
CH_CMD_BYTERDGO	.EQU	$3B		; BYTE READ GO
CH_CMD_BYTEWR	.EQU	$3C		; BYTE WRITE
CH_CMD_BYTEWRGO	.EQU	$3D		; BYTE WRITE GO
CH_CMD_DSKCAP	.EQU	$3E		; DISK CAPACITY
CH_CMD_AUTOSET	.EQU	$4D		; USB AUTO SETUP
CH_CMD_DSKINIT	.EQU	$51		; DISK INIT
CH_CMD_DSKRES	.EQU	$52		; DISK RESET
CH_CMD_DSKSIZ	.EQU	$53		; DISK SIZE
CH_CMD_DSKRD	.EQU	$54		; DISK READ
CH_CMD_DSKRDGO	.EQU	$55		; CONTINUE DISK READ
CH_CMD_DSKWR	.EQU	$56		; DISK WRITE
CH_CMD_DSKWRGO	.EQU	$57		; CONTINUE DISK WRITE
CH_CMD_DSKINQ	.EQU	$58		; DISK INQUIRY
CH_CMD_DSKRDY	.EQU	$59		; DISK READY
;
; SUB-DRIVER SETUP
;
CHUSBENABLE	.EQU	((CH0USBENABLE == TRUE) | (CH1USBENABLE == TRUE))
CHSDENABLE	.EQU	((CH0SDENABLE == TRUE) | (CH1SDENABLE == TRUE))
;
#IF (!CHUSBENABLE)
CHUSB_CFG0	.EQU	0		; DUMMY ENTRY
CHUSB_CFG1	.EQU	0		; DUMMY ENTRY
#ENDIF
;
#IF (!CHSDENABLE)
CHSD_CFG0	.EQU	0		; DUMMY ENTRY
CHSD_CFG1	.EQU	0		; DUMMY ENTRY
#ENDIF
;
; CH DEVICE CONFIGURATION
;
CH_CFGSIZ	.EQU	9		; SIZE OF CFG TBL ENTRIES
;
; CONFIG ENTRY DATA OFFSETS
;
CH_DEV		.EQU	0		; OFFSET OF DEVICE NUMBER (BYTE)
CH_TYPE		.EQU	1		; CH DEVICE TYPE (CHTYP_XXX)
CH_IOBASE	.EQU	2		; IO BASE ADDRESS (BYTE)
CH_USBENABLE	.EQU	3		; ENABLE USB SUB-DRIVER
CH_USBCFG	.EQU	4		; USB SUB-DRIVER CFG ENTRY
CH_SDENABLE	.EQU	6		; ENABLE SD CARD SUB-DRIVER
CH_SDCFG	.EQU	7		; SD CARD SUB-DRIVER CFG ENTRY
;
CH_CFGTBL:
;
#IF (CHCNT >= 1)
CH_CFG0:	; DEVICE 0
	.DB	0			; DEV NUM
	.DB	CHTYP_NONE		; DEV TYPE, FILLED DYNCAMICALLY
	.DB	CH0BASE			; IO BASE ADDRESS
	.DB	CH0USBENABLE		; ENABLE USB SUB-DRIVER
	.DW	CHUSB_CFG0		; USB SUB-DRIVER INIT ADR
	.DB	CH0SDENABLE		; ENABLE SD CARD SUB-DRIVER
	.DW	CHSD_CFG0		; SD CARD SUB-DRIVER INIT ADR
;
	.ECHO	"CH: IO="
	.ECHO	CH0BASE
	.ECHO	"\n"
#ENDIF
;
#IF (CHCNT >= 2)
CH_CFG1:	; DEVICE 1
	.DB	1			; DEV NUM
	.DB	CHTYP_NONE		; DEV TYPE, FILLED DYNCAMICALLY
	.DB	CH1BASE			; IO BASE ADDRESS
	.DB	CH1USBENABLE		; ENABLE USB SUB-DRIVER
	.DW	CHUSB_CFG1		; USB SUB-DRIVER INIT ADR
	.DB	CH1SDENABLE		; ENABLE SD CARD SUB-DRIVER
	.DW	CHSD_CFG1		; SD CARD SUB-DRIVER INIT ADR
;
	.ECHO	"CH: IO="
	.ECHO	CH1BASE
	.ECHO	"\n"
#ENDIF
;
#IF ($ - CH_CFGTBL) != (CHCNT * CH_CFGSIZ)
	.ECHO	"*** INVALID CH CONFIG TABLE ***\n"
#ENDIF
;
	.DB	$FF			; END OF TABLE MARKER
;
; GLOBAL CH37X INITIALIZATION
;
CH_INIT:
	LD	IY,CH_CFGTBL		; POINT TO START OF CONFIG TABLE
;
CH_INIT1:
	LD	A,(IY)			; LOAD FIRST BYTE TO CHECK FOR END
	CP	$FF			; CHECK FOR END OF TABLE VALUE
	JR	NZ,CH_INIT2		; IF NOT END OF TABLE, CONTINUE
	XOR	A			; SIGNAL SUCCESS
	RET				; AND RETURN
;
CH_INIT2:
	CALL	NEWLINE			; FORMATTING
	PRTS("CH$")			; LABEL FOR IO ADDRESS
	LD	A,(IY+CH_DEV)		; DEVICE NUMBER
	CALL	PRTDECB			; PRINT IT
	CALL	PC_COLON		; FORMATTING
;
	PRTS(" IO=0x$")			; LABEL FOR IO ADDRESS
	LD	A,(IY+CH_IOBASE)	; GET IO BASE ADDRES
	CALL	PRTHEXBYTE		; DISPLAY IT
;
	XOR	A			; UNKNOWN MODE
	LD	(CH0_MODE),A		; SAVE IT
	LD	(CH1_MODE),A		; SAVE IT
	;CALL	CH_FLUSH		; FLUSH DEVICE OUTPUT QUEUE
;
	; VERSION 4 OF THE CH376 CHIPS ARE HAVING TROUBLE WITH THE
	; RESET COMMAND.  ON Z80 SYSTEMS THEY TAKE A VERY LONG TIME
	; TO RESET.  ON Z180 SYSTEMS, I AM NOT SEEING AN ISSUE.
	; CH375 CHIPS AND VERSION 3 OF THE CH376 SEEM FINE (IN Z80
	; OR Z180 SYSTEMS).  NO IDEA WHAT IS GOING ON, SO I AM
	; GIVING UP FOR NOW AND REMOVING THE RESET.
;
	;CALL	CH_RESET		; FULL CH37X RESET
;
	CALL	CH_DETECT		; DETECT CHIP PRESENCE
	JR	Z,CH_INIT3		; GO AHEAD IF CHIP FOUND
	LD	DE,CH_STR_NOHW		; NOT PRESENT
	CALL	WRITESTR		; PRINT IT
	JR	CH_INIT4		; NEXT ENTRY
;
CH_INIT3:
	CALL	CH_GETVER		; GET VERSION BYTE
	;CALL	PC_SPACE		; *DEBUG*
	;CALL	PRTHEXBYTE		; *DEBUG*
;
	LD	B,A			; SAVE IN REG B
	AND	$C0			; ISOLATE CHIP TYPE BITS
	LD	C,CHTYP_375		; ASSUME CH375
	LD	DE,CH_STR_375		; STRING FOR CH375
	CP	$80			; 375?
	JR	Z,CH_INIT3A		; IF SO, RECORD IT
	LD	C,CHTYP_376		; ASSUME CH376
	LD	DE,CH_STR_376		; STRING FOR CH376
	CP	$40			; 376?
	JR	Z,CH_INIT3A		; IF SO, RECORD IT
	PRTS(" VER ERR 0x$")		; SHOW VERSION ERROR
	LD	A,B			; GET VERSION BYTE BACK
	CALL	PRTHEXBYTE		; PRINT IT
	JR	CH_INIT4		; NEXT ENTRY
;
CH_INIT3A:
	LD	A,C			; CHIP TYPE TO ACCUM
	LD	(IY+CH_TYPE),A		; SAVE IT
	PRTS(" TYPE=$")			; TAG
	CALL	WRITESTR		; PRINT CHIP TYPE
	PRTS(" VER=0x$")		; LABEL FOR CHIP VERSION
	LD	A,B			; RECOVER VERSION BYTE
	AND	$3F			; ISOLATE VERSION BITS
	CALL	PRTHEXBYTE		; PRINT IT
;
#IF (CHUSBENABLE)
	; USB SUB-DRIVER INIT
	LD	L,(IY+CH_USBCFG+0)	; LSB OF USB CFG ENTRY
	LD	H,(IY+CH_USBCFG+1)	; MSB OF USB CFG ENTRY
	LD	A,(IY+CH_USBENABLE)	; USB ENABLED?
	PUSH	IY			; SAVE IY
	OR	A			; SET FLAGS
	CALL	NZ,CHUSB_INIT		; IF SO, DO USB INIT
	POP	IY			; RESTORE IY
#ENDIF
;
#IF (CHSDENABLE)
	; SD CARD SUB-DRIVER INIT
	LD	L,(IY+CH_SDCFG+0)	; LSB OF SD CFG ENTRY
	LD	H,(IY+CH_SDCFG+1)	; MSB OF SD CFG ENTRY
	LD	A,(IY+CH_SDENABLE)	; SD ENABLED?
	PUSH	IY			; SAVE IY
	OR	A			; SET FLAGS
	CALL	NZ,CHSD_INIT		; IF SO, DO SD INIT
	POP	IY			; RESTORE IY
#ENDIF
;
CH_INIT4:
	LD	DE,CH_CFGSIZ		; SIZE OF CFG TABLE ENTRY
	ADD	IY,DE			; BUMP POINTER
	JP	CH_INIT1		; AND LOOP
;
; SEND COMMAND IN A
;
CH_CMD:
	LD	C,(IY+CH_IOBASE)	; BASE PORT
	INC	C			; BUMP TO CMD PORT
	OUT	(C),A			; SEND COMMAND
	CALL	CH_NAP			; *DEBUG*
	RET
;
; GET STATUS
;
CH_STAT:
	LD	C,(IY+CH_IOBASE)	; BASE PORT
	INC	C			; BUMP TO CMD PORT
	IN	A,(C)			; READ STATUS
	RET
;
; READ A BYTE FROM DATA PORT
;
CH_RD:
	LD	C,(IY+CH_IOBASE)	; BASE PORT
	IN	A,(C)			; READ BYTE
	RET
;
; WRITE A BYTE TO DATA PORT
;
CH_WR:
	LD	C,(IY+CH_IOBASE)	; BASE PORT
	OUT	(C),A			; READ BYTE
	RET
;
; SMALL DELAY REQUIRED AT STRATEGIC LOCATIONS
;
CH_NAP:
	JP	DELAY
;
; POLL WAITING FOR INTERRUPT
;
CH_POLL:
	PUSH	BC			; SAVE BC
	PUSH	HL			; SAVE HL
	CALL	CH_NAP			; SMALL DELAY
	LD	A,(CB_CPUMHZ)		; USE CPU SPEED AS CPU
	LD	B,A			; ... SPEED COMP COUNTER
CH_POLL0:
	LD	HL,$8000		; PRIMARY LOOP COUNTER
CH_POLL1:
	CALL	CH_STAT			; GET INT STATUS
	BIT	7,A			; CHECK BIT
	JR	Z,CH_POLL2		; IF ZERO, MOVE ON
	DEC	HL			; DECREMENT COUNTER
	LD	A,H			; CHECK
	OR	L			; ... LOOP COUNTER
	JR	NZ,CH_POLL1		; INNER LOOP AS NEEDED
	DJNZ	CH_POLL0		; OUTER LOOP AS NEEDED
	POP	HL			; RESTORE HL
	POP	BC			; RESTORE BC
	OR	$FF			; FLAG TIMEOUT
	RET				; AND RETURN
CH_POLL2:
	LD	A,CH_CMD_STAT		; GET STATUS
	CALL	CH_CMD			; SEND IT
	CALL	CH_NAP			; SMALL DELAY
	CALL	CH_RD			; GET RESULT
	;PUSH	AF			; *DEBUG*
	;LD	A,B			; *DEBUG*
	;CALL	PC_SPACE		; *DEBUG*
	;CALL	PC_LBKT			; *DEBUG*
	;CALL	PRTHEXBYTE		; *DEBUG*
	;CALL	PC_RBKT			; *DEBUG*
	;POP	AF			; *DEBUG*
	POP	HL			; RESTORE HL
	POP	BC			; RESTORE BC
	RET				; AND RETURN
;
; SEND READ USB DATA COMMAND
; USING BEST OPCODE FOR DEVICE
;
CH_CMD_RD:
	LD	A,(IY+CH_TYPE)
	CP	CHTYP_375
	JR	NZ,CH_CMD_RD1
;
	; SEND CH375 READ USB DATA CMD
	LD	A,CH_CMD_RD5
	JP	CH_CMD
;
CH_CMD_RD1:
	; SEND CH376 READ USB DATA CMD
	LD	A,CH_CMD_RD6
	JP	CH_CMD
;
; SEND WRITE USB DATA COMMAND
; USING BEST OPCODE FOR DEVICE
;
CH_CMD_WR:
	LD	A,(IY+CH_TYPE)
	CP	CHTYP_375
	JR	NZ,CH_CMD_WR1
;
	; SEND CH375 WRITE USB DATA CMD
	LD	A,CH_CMD_WR5
	JP	CH_CMD
;
CH_CMD_WR1:
	; SEND CH376 WRITE USB DATA CMD
	LD	A,CH_CMD_WR6
	JP	CH_CMD
;
; PERFORM A FULL HARDWARE RESET ON CH37X
;
CH_RESET:
	;PRTS("\r\nHW RESET:$")		; *DEBUG*
	PUSH	DE
	LD	A,CH_CMD_RESET
	CALL	CH_CMD
	LD	DE,2500			; 16US * 2500 = 40MS
	CALL	VDELAY
	;CALL	CH_RD			; *DEBUG*
	;CALL	PC_SPACE		; *DEBUG*
	;CALL	PRTHEXBYTE		; *DEBUG*
	POP	DE
	RET
;
; EMPTY THE CH37X OUTPUT QUEUE OF GARBAGE
;
CH_FLUSH:
	LD	B,$80
CH_FLUSH1:
	CALL	CH_RD
	DJNZ	CH_FLUSH1
	RET
;
;
;
CH_DETECT:
	;PRTS("\r\nDETECT:$")		; *DEBUG*
CH_DETECT1:
	LD	A,CH_CMD_EXIST		; LOAD COMMAND
	CALL	CH_CMD			; SEND COMMAND
	LD	A,$AA			; LOAD CHECK PATTERN
	CALL	CH_WR			; SEND IT
	CALL	CH_NAP			; SMALL DELAY
	CALL	CH_RD			; GET ECHO
	;CALL	PC_SPACE		; *DEBUG*
	;CALL	PRTHEXBYTE		; *DEBUG*
	CP	$55			; SHOULD BE INVERTED
	RET				; RETURN
;
;
;
CH_GETVER:
	LD	A,CH_CMD_VER		; LOAD COMMAND
	CALL	CH_CMD			; SEND COMMAND
	CALL	CH_RD			; GET VERSION BYTE
	RET				; DONE
;
; SET MODE TO VALUE IN A
; AVOID CHANGING MODES IF CURRENT MODE = NEW MODE
; THE CH376 DOES NOT SEEM TO MAINTAIN SEPARATE OPERATING CONTEXTS FOR
; THE USB AND SD DEVICES.  IF BOTH ARE IN OPERATION, THEN A MODE
; SWITCH REQUIRES A COMPLETE REINITIALIZATION OF THE REQUESTED
; DEVICE.  THIS WHOLE MESS IS ONLY NEEDED IF BOTH CHSD AND CHUSB
; ARE ENDABLED, SO IT IS CONDITIONAL.
;
CH_SETMODE:
#IF (CHUSBENABLE & CHSDENABLE)
	PUSH	BC			; SAVE BC
	PUSH	DE			; SAVE DE
	PUSH	HL			; SAVE HL
	;PRTS("\r\nSETMODE:$")		; *DEBUG*
	;CALL	PC_SPACE		; *DEBUG*
	;CALL	PRTHEXBYTE		; *DEBUG*
	LD	E,A			; SAVE REQUESTED MODE
;
	; WARNING: CH_SETMODE IS CALLED BY THE SUB-DRIVERS, SO
	; IY WILL BE A POINTER TO THE CONFIG BLOCK OF THE SUB-DRIVER.
	; BY CONVENTION, THE LOCATION OF THE MODE BYTE FOR EACH
	; SUB-DRIVER IS AT OFFSET 12 IN THE CONFIG BLOCK!
	LD	L,(IY+12)		; GET MODE PTR (LSB)
	LD	H,(IY+13)		; GET MODE PTR (MSB)
	LD	A,(HL)			; GET CUR MODE
	;CALL	PC_SPACE		; *DEBUG*
	;CALL	PRTHEXBYTE		; *DEBUG*
	CP	E			; COMPARE
	JR	Z,CH_SETMODE_Z		; IF EQUAL, DONE
;
	; NEED TO CHANGE MODES
	LD	A,E			; RECOVER REQUESTED MODE
	CP	CH_MODE_USB		; USB?
	JR	Z,CH_SETMODE_USB	; IF SO, DO IT
	CP	CH_MODE_SD		; SD?
	JR	Z,CH_SETMODE_SD		; IF SO, DO IT
	OR	$FF			; SIGNAL ERROR
	JR	CH_SETMODE_Z		; BAIL OUT
;
CH_SETMODE_USB:
#IF (CHUSBENABLE)
	CALL	CHUSB_RESET		; FULL USB STACK RESET
#ENDIF
	JR	CH_SETMODE_Z		; MOVE ON
;
CH_SETMODE_SD:
#IF (CHSDENABLE)
	CALL	CHSD_RESET		; FULL SD STACK RESET
#ENDIF
	JR	CH_SETMODE_Z		; MOVE ON
;
CH_SETMODE_Z:
	POP	HL			; RECOVER HL
	POP	DE			; RECOVER DE
	POP	BC			; RECOVER BC
#ENDIF
	RET				; DONE
;
;
;
CH0_MODE	.DB	CH_MODE_UNK
CH1_MODE	.DB	CH_MODE_UNK
;
CH_STR_NOHW	.TEXT	" NOT PRESENT$"
;
CH_STR_375	.TEXT	"CH375$"
CH_STR_376	.TEXT	"CH376$"
;
; INCLUDE SUB-DRIVERS AS NEEDED
;
#IF (CHUSBENABLE)
  #INCLUDE "chusb.asm"
#ENDIF
;
#IF (CHSDENABLE)
  #INCLUDE "chsd.asm"
#ENDIF
;