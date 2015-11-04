
;CodeVisionAVR C Compiler V2.05.0 Professional
;(C) Copyright 1998-2010 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Chip type                : ATmega16
;Program type             : Application
;Clock frequency          : 16.000000 MHz
;Memory model             : Small
;Optimize for             : Speed
;(s)printf features       : int, width
;(s)scanf features        : int, width
;External RAM size        : 0
;Data Stack size          : 256 byte(s)
;Heap size                : 0 byte(s)
;Promote 'char' to 'int'  : Yes
;'char' is unsigned       : Yes
;8 bit enums              : Yes
;global 'const' stored in FLASH: No
;Enhanced core instructions    : On
;Smart register allocation     : On
;Automatic register allocation : On

	#pragma AVRPART ADMIN PART_NAME ATmega16
	#pragma AVRPART MEMORY PROG_FLASH 16384
	#pragma AVRPART MEMORY EEPROM 512
	#pragma AVRPART MEMORY INT_SRAM SIZE 1119
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x60

	#define CALL_SUPPORTED 1

	.LISTMAC
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU USR=0xB
	.EQU UDR=0xC
	.EQU SPSR=0xE
	.EQU SPDR=0xF
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU EECR=0x1C
	.EQU EEDR=0x1D
	.EQU EEARL=0x1E
	.EQU EEARH=0x1F
	.EQU WDTCR=0x21
	.EQU MCUCR=0x35
	.EQU GICR=0x3B
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __SRAM_START=0x0060
	.EQU __SRAM_END=0x045F
	.EQU __DSTACK_SIZE=0x0100
	.EQU __HEAP_SIZE=0x0000
	.EQU __CLEAR_SRAM_SIZE=__SRAM_END-__SRAM_START+1

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ANDI R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ANDD2N
	ANDI R26,LOW(@0)
	ANDI R27,HIGH(@0)
	ANDI R24,BYTE3(@0)
	ANDI R25,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ORI  R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD2N
	ORI  R26,LOW(@0)
	ORI  R27,HIGH(@0)
	ORI  R24,BYTE3(@0)
	ORI  R25,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __CLRD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+(@1))
	LDI  R31,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	LDI  R22,BYTE3(2*@0+(@1))
	LDI  R23,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+(@2))
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+(@3))
	LDI  R@1,HIGH(@2+(@3))
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+(@3))
	LDI  R@1,HIGH(@2*2+(@3))
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+(@1)
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+(@1)
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	LDS  R22,@0+(@1)+2
	LDS  R23,@0+(@1)+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+(@2)
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+(@3)
	LDS  R@1,@2+(@3)+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+(@1)
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	LDS  R24,@0+(@1)+2
	LDS  R25,@0+(@1)+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+(@1),R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	STS  @0+(@1)+2,R22
	STS  @0+(@1)+3,R23
	.ENDM

	.MACRO __PUTB1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRD
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+(@1),R0
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+(@1),R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+(@1),R@2
	STS  @0+(@1)+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTBSR
	STD  Y+@1,R@0
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	CALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMRDW
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R26,SPL
	IN   R27,SPH
	ADIW R26,@0+1
	LD   R30,X+
	LD   R31,X
	.ENDM

	.MACRO __GETD1STACK
	IN   R26,SPL
	IN   R27,SPH
	ADIW R26,@0+1
	LD   R30,X+
	LD   R31,X+
	LD   R22,X
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	CALL __PUTDP1
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z+
	LD   R23,Z
	MOVW R30,R0
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R1,X+
	LD   R24,X+
	LD   R25,X
	MOVW R26,R0
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __GETBRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	LD   R@0,X
	.ENDM

	.MACRO __GETWRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	LD   R@0,X+
	LD   R@1,X
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __CLRD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R30
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	ST   Z,R@0
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

;NAME DEFINITIONS FOR GLOBAL VARIABLES ALLOCATED TO REGISTERS
	.DEF _CaseAddressIndex=R2
	.DEF _timer_interrupt_enable=R4
	.DEF _timer_interrupt_disable=R6
	.DEF _set_delay_7us=R8
	.DEF _set_delay_10ms=R10
	.DEF _StackPointer=R13
	.DEF _GlcdPage=R12

	.CSEG
	.ORG 0x00

;START OF CODE MARKER
__START_OF_CODE:

;INTERRUPT VECTORS
	JMP  __RESET
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  _timer0_comp_isr
	JMP  0x00

_glcd_font:
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x5F,0x0,0x0,0x0,0x0,0x0,0x5F,0x0
	.DB  0x0,0x0,0x14,0x7F,0x14,0x7F,0x14,0x0
	.DB  0x24,0x2A,0x7F,0x2A,0x12,0x0,0x23,0x13
	.DB  0x8,0x64,0x62,0x0,0x36,0x49,0x55,0x22
	.DB  0x50,0x0,0x0,0x5,0x3,0x0,0x0,0x0
	.DB  0x0,0x1C,0x22,0x41,0x0,0x0,0x0,0x41
	.DB  0x22,0x1C,0x0,0x0,0x8,0x2A,0x1C,0x2A
	.DB  0x8,0x0,0x8,0x8,0x3E,0x8,0x8,0x0
	.DB  0x0,0x50,0x30,0x0,0x0,0x0,0x8,0x8
	.DB  0x8,0x8,0x8,0x0,0x0,0x30,0x30,0x0
	.DB  0x0,0x0,0x20,0x10,0x8,0x4,0x2,0x0
	.DB  0x3E,0x51,0x49,0x45,0x3E,0x0,0x0,0x42
	.DB  0x7F,0x40,0x0,0x0,0x42,0x61,0x51,0x49
	.DB  0x46,0x0,0x21,0x41,0x45,0x4B,0x31,0x0
	.DB  0x18,0x14,0x12,0x7F,0x10,0x0,0x27,0x45
	.DB  0x45,0x45,0x39,0x0,0x3C,0x4A,0x49,0x49
	.DB  0x30,0x0,0x1,0x71,0x9,0x5,0x3,0x0
	.DB  0x36,0x49,0x49,0x49,0x36,0x0,0x6,0x49
	.DB  0x49,0x29,0x1E,0x0,0x0,0x36,0x36,0x0
	.DB  0x0,0x0,0x0,0x56,0x36,0x0,0x0,0x0
	.DB  0x0,0x8,0x14,0x22,0x41,0x0,0x14,0x14
	.DB  0x14,0x14,0x14,0x0,0x41,0x22,0x14,0x8
	.DB  0x0,0x0,0x2,0x1,0x51,0x9,0x6,0x0
	.DB  0x32,0x49,0x79,0x41,0x3E,0x0,0x7E,0x11
	.DB  0x11,0x11,0x7E,0x0,0x7F,0x49,0x49,0x49
	.DB  0x36,0x0,0x3E,0x41,0x41,0x41,0x22,0x0
	.DB  0x7F,0x41,0x41,0x22,0x1C,0x0,0x7F,0x49
	.DB  0x49,0x49,0x41,0x0,0x7F,0x9,0x9,0x1
	.DB  0x1,0x0,0x3E,0x41,0x41,0x51,0x32,0x0
	.DB  0x7F,0x8,0x8,0x8,0x7F,0x0,0x0,0x41
	.DB  0x7F,0x41,0x0,0x0,0x20,0x40,0x41,0x3F
	.DB  0x1,0x0,0x7F,0x8,0x14,0x22,0x41,0x0
	.DB  0x7F,0x40,0x40,0x40,0x40,0x0,0x7F,0x2
	.DB  0x4,0x2,0x7F,0x0,0x7F,0x4,0x8,0x10
	.DB  0x7F,0x0,0x3E,0x41,0x41,0x41,0x3E,0x0
	.DB  0x7F,0x9,0x9,0x9,0x6,0x0,0x3E,0x41
	.DB  0x51,0x21,0x5E,0x0,0x7F,0x9,0x19,0x29
	.DB  0x46,0x0,0x46,0x49,0x49,0x49,0x31,0x0
	.DB  0x1,0x1,0x7F,0x1,0x1,0x0,0x3F,0x40
	.DB  0x40,0x40,0x3F,0x0,0x1F,0x20,0x40,0x20
	.DB  0x1F,0x0,0x7F,0x20,0x18,0x20,0x7F,0x0
	.DB  0x63,0x14,0x8,0x14,0x63,0x0,0x3,0x4
	.DB  0x78,0x4,0x3,0x0,0x61,0x51,0x49,0x45
	.DB  0x43,0x0,0x0,0x0,0x7F,0x41,0x41,0x0
	.DB  0x2,0x4,0x8,0x10,0x20,0x0,0x41,0x41
	.DB  0x7F,0x0,0x0,0x0,0x4,0x2,0x1,0x2
	.DB  0x4,0x0,0x40,0x40,0x40,0x40,0x40,0x0
	.DB  0x0,0x1,0x2,0x4,0x0,0x0,0x20,0x54
	.DB  0x54,0x54,0x78,0x0,0x7F,0x48,0x44,0x44
	.DB  0x38,0x0,0x38,0x44,0x44,0x44,0x20,0x0
	.DB  0x38,0x44,0x44,0x48,0x7F,0x0,0x38,0x54
	.DB  0x54,0x54,0x18,0x0,0x8,0x7E,0x9,0x1
	.DB  0x2,0x0,0x8,0x14,0x54,0x54,0x3C,0x0
	.DB  0x7F,0x8,0x4,0x4,0x78,0x0,0x0,0x44
	.DB  0x7D,0x40,0x0,0x0,0x20,0x40,0x44,0x3D
	.DB  0x0,0x0,0x0,0x7F,0x10,0x28,0x44,0x0
	.DB  0x0,0x41,0x7F,0x40,0x0,0x0,0x7C,0x4
	.DB  0x18,0x4,0x78,0x0,0x7C,0x8,0x4,0x4
	.DB  0x78,0x0,0x38,0x44,0x44,0x44,0x38,0x0
	.DB  0x7C,0x14,0x14,0x14,0x8,0x0,0x8,0x14
	.DB  0x14,0x18,0x7C,0x0,0x7C,0x8,0x4,0x4
	.DB  0x8,0x0,0x48,0x54,0x54,0x54,0x20,0x0
	.DB  0x4,0x3F,0x44,0x40,0x20,0x0,0x3C,0x40
	.DB  0x40,0x20,0x7C,0x0,0x1C,0x20,0x40,0x20
	.DB  0x1C,0x0,0x3C,0x40,0x30,0x40,0x3C,0x0
	.DB  0x44,0x28,0x10,0x28,0x44,0x0,0xC,0x50
	.DB  0x50,0x50,0x3C,0x0,0x44,0x64,0x54,0x4C
	.DB  0x44,0x0
_picture:
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0xC0,0xF8,0xFF,0xFF,0xFF,0xFF
	.DB  0xFF,0xFF,0xF8,0xC0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x80
	.DB  0xC0,0xE0,0xF0,0xF8,0xFC,0xFE,0x7F,0x3F
	.DB  0x1F,0x8F,0x8F,0xDF,0xFF,0xFF,0xFE,0xFC
	.DB  0xF8,0xF0,0xE0,0xE0,0xE0,0xE0,0xE0,0xC0
	.DB  0xC0,0xC0,0xC0,0xE0,0xE0,0xF0,0xF0,0xF0
	.DB  0xF8,0xF8,0xF8,0xF8,0xF8,0xF8,0xF8,0xF0
	.DB  0xF0,0xF0,0xF8,0xFC,0xFE,0xFE,0xFE,0xFC
	.DB  0xF8,0xF8,0xF8,0xF8,0xF8,0xF8,0xF8,0xF0
	.DB  0xF0,0xF0,0xE0,0xC0,0xC0,0x80,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0xC0,0xF8,0xFC,0xFE
	.DB  0xFE,0xFC,0xF8,0xC0,0x0,0x0,0x0,0x0
	.DB  0xF0,0xF0,0xF8,0xF8,0xF8,0xFC,0xFC,0xFC
	.DB  0xFE,0xBE,0xBF,0xBF,0x1F,0x1F,0x3,0x3
	.DB  0x1F,0x1F,0xBF,0xBF,0xBE,0xFE,0xFC,0xFC
	.DB  0xFC,0xF8,0xF8,0xF8,0xF8,0xFC,0xFC,0xFE
	.DB  0x3E,0x3E,0x1F,0x1F,0x1F,0x1F,0x1F,0x1F
	.DB  0x1F,0x1F,0x1F,0x1F,0x3F,0x7F,0xFE,0xFF
	.DB  0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0x7F,0x3F
	.DB  0x1F,0xF,0x7,0x3,0x3,0x3,0xF,0x1F
	.DB  0x1F,0x1F,0x1F,0xF,0xF,0x3,0x1,0x1
	.DB  0x0,0x1C,0x3E,0x7F,0xFF,0xFF,0xFF,0xFF
	.DB  0xFF,0xEF,0xCF,0x8F,0xF,0x7,0x1,0x81
	.DB  0xC1,0xE3,0xF7,0xFF,0xFF,0xFF,0xFF,0x7F
	.DB  0x3F,0x1F,0x7,0xF,0x3F,0x7F,0x7F,0x7E
	.DB  0x7C,0xFC,0xF8,0xF8,0xF0,0xFC,0xFE,0xBE
	.DB  0x3E,0x7F,0x7F,0x7F,0xFF,0xFF,0xFF,0xFF
	.DB  0xF7,0xFF,0xFF,0xFF,0x7F,0x7F,0x7F,0x3E
	.DB  0x1,0x1,0x3,0x3,0x3,0x7,0x7,0x7
	.DB  0xF,0xF,0x7F,0xFF,0xFF,0xFF,0xF8,0xF8
	.DB  0xFE,0xFF,0xFF,0xFF,0xFF,0xFF,0xF7,0xFF
	.DB  0xFF,0xFF,0xFF,0xFF,0x3,0x1,0x1,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x1
	.DB  0x1,0x3,0x3,0x1,0x1,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x1,0x3
	.DB  0x7,0xF,0xF,0x1F,0x3F,0x3F,0x3F,0x1F
	.DB  0xF,0xF,0x7,0x3,0x1,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x80,0xC1,0xE3,0xFF,0xFF,0xFF,0xFF
	.DB  0xFE,0x0,0x0,0x0,0x1,0xF,0x1F,0x3F
	.DB  0x3F,0x3F,0xF,0x1,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0xC0,0xE0,0xF0,0xF0
	.DB  0xE0,0xC0,0x0,0x3,0x1F,0x7F,0xFF,0xFF
	.DB  0xFF,0xFF,0xE7,0xC3,0x81,0x81,0x1,0x1
	.DB  0x1,0x1,0x1,0x1,0x0,0x0,0x0,0x0
	.DB  0x0,0x80,0xE1,0xFF,0x9F,0x81,0xC1,0x7F
	.DB  0x1E,0x0,0x70,0xF8,0x9C,0x94,0x94,0xDC
	.DB  0x58,0x0,0x80,0x81,0xF1,0xFF,0x8F,0x80
	.DB  0x0,0x0,0xE0,0xF0,0x94,0x94,0xF4,0xFC
	.DB  0x98,0x0,0x4,0x1C,0xFC,0xC4,0x60,0x3C
	.DB  0xC,0x4,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x80,0xE1,0xFF,0x9F,0x11,0x31,0xF9
	.DB  0xCF,0x86,0x0,0x0,0xF0,0xE0,0xE0,0xE0
	.DB  0xC0,0x80,0x80,0x0,0x0,0x0,0x0,0x80
	.DB  0xC7,0xCF,0xCF,0x8F,0x87,0xF7,0xFF,0xFF
	.DB  0xFF,0xFF,0xFC,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x3E,0x3E,0x3E,0x7F,0xFF,0xFF,0xFF,0xFF
	.DB  0xFF,0xFF,0x7F,0x3E,0x3E,0x3E,0xFC,0xF1
	.DB  0xFB,0xFF,0xFF,0xFF,0xFF,0x1F,0x1F,0x1F
	.DB  0x1F,0x1F,0x1F,0xC,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x2,0x2,0x2,0x3,0x2,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x3,0x3,0x7,0x7
	.DB  0x1F,0xFF,0xFF,0xFF,0xFC,0xF8,0xF8,0xFF
	.DB  0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0x7F,0x3F
	.DB  0x7F,0xFF,0xFF,0xFC,0xF8,0xF0,0xF0,0xF0
	.DB  0xE0,0xE0,0xE0,0xC0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x1,0x3,0x7,0x7
	.DB  0x37,0x79,0xFC,0xFC,0xFC,0xFE,0xFF,0xFF
	.DB  0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFE,0xFC
	.DB  0x7C,0xFC,0xF8,0xF8,0xF8,0xF8,0xFC,0xFC
	.DB  0xFC,0xFC,0xB8,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0xC0,0xE0,0xE0,0xE0,0xC0,0x80,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0xC0,0xE0,0xE0,0xE0,0xC0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x80,0xE0,0xF8
	.DB  0xFC,0xFC,0xFC,0xF8,0xE0,0xE0,0xE0,0xE0
	.DB  0xE0,0xE0,0xE0,0xF0,0xF0,0xF0,0xF8,0xFC
	.DB  0xFE,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF
	.DB  0x7F,0xF,0x7F,0xFF,0xFF,0xFF,0xFF,0xFE
	.DB  0xFF,0xFF,0xFF,0xDF,0x8F,0x87,0x7,0x7
	.DB  0x7,0x3,0x3,0x1,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x1,0x1F,0x7F
	.DB  0x7F,0x7F,0x3F,0x1F,0x1,0x0,0x0,0x0
	.DB  0x0,0x80,0xC0,0xF9,0xFF,0xFF,0xFF,0xFF
	.DB  0xFF,0xDF,0xDF,0xDF,0xDF,0xDF,0xDF,0xFF
	.DB  0xFF,0xFF,0xFF,0xFF,0x1F,0x1F,0x1F,0x1F
	.DB  0x1F,0xF,0xF,0xF,0xF,0x1F,0x1F,0x3F
	.DB  0x7E,0xFE,0xFC,0xFC,0xFC,0xF8,0xF8,0xFE
	.DB  0xFF,0xFF,0xFF,0xFF,0xFF,0xFE,0xF8,0xF8
	.DB  0xFC,0xFC,0xFE,0xFE,0x7F,0x1F,0x1F,0xF
	.DB  0x7,0x83,0x81,0x83,0x83,0x83,0xC3,0xC3
	.DB  0xFB,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF
	.DB  0xFF,0xFF,0xFF,0xFF,0xFF,0xF9,0xF9,0xF0
	.DB  0xE0,0x0,0xE0,0xF0,0xF9,0xFF,0xFF,0xFF
	.DB  0x7F,0x7F,0x3F,0x3F,0x1F,0x1F,0xF,0x6
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x3C,0x7E,0xFE,0xFE
	.DB  0xFF,0xFF,0xFF,0xFF,0x7F,0x7F,0x3F,0x3F
	.DB  0x3F,0x1F,0x1F,0x7,0x7,0x7,0x7,0x7
	.DB  0x7,0x3,0x3,0x1,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0xE1,0xFF,0xFF,0xFF,0xFF
	.DB  0xFF,0x7F,0x3E,0x7F,0xFF,0xFF,0xFF,0xFF
	.DB  0xFF,0xE1,0x1,0x0,0x0,0x0,0x0,0x6
	.DB  0xF,0x1F,0x1F,0x1F,0x1F,0x3F,0x3F,0x3F
	.DB  0xFF,0xFF,0xFF,0xF9,0xFF,0xFF,0xFF,0x7F
	.DB  0x3F,0x3F,0x1F,0x1F,0x1F,0x1F,0xFF,0xFF
	.DB  0xFF,0xFF,0xFF,0xFF,0xFF,0x1F,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
_tbl10_G101:
	.DB  0x10,0x27,0xE8,0x3,0x64,0x0,0xA,0x0
	.DB  0x1,0x0
_tbl16_G101:
	.DB  0x0,0x10,0x0,0x1,0x10,0x0,0x1,0x0

_0x144:
	.DB  0x9
_0x145:
	.DB  0x57,0x68,0x61,0x74,0x27,0x73,0x20,0x74
	.DB  0x68,0x61,0x74,0x3F,0x3F,0x3F,0x3F,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0
_0x150:
	.DB  0xFF
_0x0:
	.DB  0x30,0x31,0x32,0x33,0x34,0x35,0x36,0x37
	.DB  0x38,0x39,0x41,0x42,0x43,0x44,0x45,0x46
	.DB  0x0,0x48,0x69,0x21,0x0,0x6B,0x6A,0x6B
	.DB  0x0,0x73,0x64,0x61,0x68,0x0,0x46,0x69
	.DB  0x6E,0x69,0x73,0x68,0x65,0x64,0x21,0x0
_0x2000003:
	.DB  0x80,0xC0

__GLOBAL_INI_TBL:
	.DW  0x01
	.DW  _TCCR0_value
	.DW  _0x144*2

	.DW  0x01
	.DW  0x0D
	.DW  _0x150*2

	.DW  0x02
	.DW  __base_y_G100
	.DW  _0x2000003*2

_0xFFFFFFFF:
	.DW  0

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  GICR,R31
	OUT  GICR,R30
	OUT  MCUCR,R30

;DISABLE WATCHDOG
	LDI  R31,0x18
	OUT  WDTCR,R31
	OUT  WDTCR,R30

;CLEAR R2-R14
	LDI  R24,(14-2)+1
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(__CLEAR_SRAM_SIZE)
	LDI  R25,HIGH(__CLEAR_SRAM_SIZE)
	LDI  R26,__SRAM_START
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

;HARDWARE STACK POINTER INITIALIZATION
	LDI  R30,LOW(__SRAM_END-__HEAP_SIZE)
	OUT  SPL,R30
	LDI  R30,HIGH(__SRAM_END-__HEAP_SIZE)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(__SRAM_START+__DSTACK_SIZE)
	LDI  R29,HIGH(__SRAM_START+__DSTACK_SIZE)

	JMP  _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0x160

	.CSEG
;/*****************************************************
;This program was produced by the
;CodeWizardAVR V2.05.0 Professional
;Automatic Program Generator
;© Copyright 1998-2010 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com
;
;Project :
;Version :
;Date    : 9/23/2011
;Author  : NeVaDa
;Company :
;Comments:
;
;
;Chip type               : ATmega16
;Program type            : Application
;AVR Core Clock frequency: 16.000000 MHz
;Memory model            : Small
;External RAM size       : 0
;Data Stack size         : 512
;*****************************************************/
;
;#include <mega16.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x40
	.EQU __sm_mask=0xB0
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0xA0
	.EQU __sm_ext_standby=0xB0
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif
;
;// Alphanumeric LCD Module functions
;#include <alcd.h>
;
;// C standard input/output
;#include <stdio.h>
;
;
;
;
;
;
;//#define Debugging
;
;#ifndef _ATXMEGA_DEVICE_
;#include <iobits.h>
;#endif
;
;// Global Variables
;static unsigned char *glcd_data_address;
;static unsigned char *glcd_rs_address;
;#ifdef _ATXMEGA_DEVICE_
;static unsigned char glcd_rs_bit_msk;
;#else
;static unsigned char glcd_rs_bit_pos;
;#endif
;static unsigned char *glcd_rw_address;
;#ifdef _ATXMEGA_DEVICE_
;static unsigned char glcd_rw_bit_msk;
;#else
;static unsigned char glcd_rw_bit_pos;
;#endif
;static unsigned char *glcd_en_address;
;#ifdef _ATXMEGA_DEVICE_
;static unsigned char glcd_en_bit_msk;
;#else
;static unsigned char glcd_en_bit_pos;
;#endif
;static unsigned char *glcd_cs1_address;
;#ifdef _ATXMEGA_DEVICE_
;static unsigned char glcd_cs1_bit_msk;
;#else
;static unsigned char glcd_cs1_bit_pos;
;#endif
;static unsigned char *glcd_cs2_address;
;#ifdef _ATXMEGA_DEVICE_
;static unsigned char glcd_cs2_bit_msk;
;#else
;static unsigned char glcd_cs2_bit_pos;
;#endif
;static unsigned char *glcd_rst_address;
;#ifdef _ATXMEGA_DEVICE_
;static unsigned char glcd_rst_bit_msk;
;#else
;static unsigned char glcd_rst_bit_pos;
;#endif
;
;flash char glcd_font [91][6] =
;{
;    { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 },   // sp
;    { 0x00, 0x00, 0x5F, 0x00, 0x00, 0x00 },   // !
;    { 0x00, 0x00, 0x5F, 0x00, 0x00, 0x00 },   // "
;    { 0x14, 0x7F, 0x14, 0x7F, 0x14, 0x00 },   // #
;    { 0x24, 0x2A, 0x7F, 0x2A, 0x12, 0x00 },   // $
;    { 0x23, 0x13, 0x08, 0x64, 0x62, 0x00 },   // %
;    { 0x36, 0x49, 0x55, 0x22, 0x50, 0x00 },   // &
;    { 0x00, 0x05, 0x03, 0x00, 0x00, 0x00 },   // '
;    { 0x00, 0x1C, 0x22, 0x41, 0x00, 0x00 },   // (
;    { 0x00, 0x41, 0x22, 0x1C, 0x00, 0x00 },   // )
;    { 0x08, 0x2A, 0x1C, 0x2A, 0x08, 0x00 },   // *
;    { 0x08, 0x08, 0x3E, 0x08, 0x08, 0x00 },   // +
;    { 0x00, 0x50, 0x30, 0x00, 0x00, 0x00 },   // ,
;    { 0x08, 0x08, 0x08, 0x08, 0x08, 0x00 },   // -
;    { 0x00, 0x30, 0x30, 0x00, 0x00, 0x00 },   // .
;    { 0x20, 0x10, 0x08, 0x04, 0x02, 0x00 },   // /
;    { 0x3E, 0x51, 0x49, 0x45, 0x3E, 0x00 },   // 0
;    { 0x00, 0x42, 0x7F, 0x40, 0x00, 0x00 },   // 1
;    { 0x42, 0x61, 0x51, 0x49, 0x46, 0x00 },   // 2
;    { 0x21, 0x41, 0x45, 0x4B, 0x31, 0x00 },   // 3
;    { 0x18, 0x14, 0x12, 0x7F, 0x10, 0x00 },   // 4
;    { 0x27, 0x45, 0x45, 0x45, 0x39, 0x00 },   // 5
;    { 0x3C, 0x4A, 0x49, 0x49, 0x30, 0x00 },   // 6
;    { 0x01, 0x71, 0x09, 0x05, 0x03, 0x00 },   // 7
;    { 0x36, 0x49, 0x49, 0x49, 0x36, 0x00 },   // 8
;    { 0x06, 0x49, 0x49, 0x29, 0x1E, 0x00 },   // 9
;    { 0x00, 0x36, 0x36, 0x00, 0x00, 0x00 },   // :
;    { 0x00, 0x56, 0x36, 0x00, 0x00, 0x00 },   // ;
;    { 0x00, 0x08, 0x14, 0x22, 0x41, 0x00 },   // <
;    { 0x14, 0x14, 0x14, 0x14, 0x14, 0x00 },   // =
;    { 0x41, 0x22, 0x14, 0x08, 0x00, 0x00 },   // >
;    { 0x02, 0x01, 0x51, 0x09, 0x06, 0x00 },   // ?
;    { 0x32, 0x49, 0x79, 0x41, 0x3E, 0x00 },   // @
;    { 0x7E, 0x11, 0x11, 0x11, 0x7E, 0x00 },   // A
;    { 0x7F, 0x49, 0x49, 0x49, 0x36, 0x00 },   // B
;    { 0x3E, 0x41, 0x41, 0x41, 0x22, 0x00 },   // C
;    { 0x7F, 0x41, 0x41, 0x22, 0x1C, 0x00 },   // D
;    { 0x7F, 0x49, 0x49, 0x49, 0x41, 0x00 },   // E
;    { 0x7F, 0x09, 0x09, 0x01, 0x01, 0x00 },   // F
;    { 0x3E, 0x41, 0x41, 0x51, 0x32, 0x00 },   // G
;    { 0x7F, 0x08, 0x08, 0x08, 0x7F, 0x00 },   // H
;    { 0x00, 0x41, 0x7F, 0x41, 0x00, 0x00 },   // I
;    { 0x20, 0x40, 0x41, 0x3F, 0x01, 0x00 },   // J
;    { 0x7F, 0x08, 0x14, 0x22, 0x41, 0x00 },   // K
;    { 0x7F, 0x40, 0x40, 0x40, 0x40, 0x00 },   // L
;    { 0x7F, 0x02, 0x04, 0x02, 0x7F, 0x00 },   // M
;    { 0x7F, 0x04, 0x08, 0x10, 0x7F, 0x00 },   // N
;    { 0x3E, 0x41, 0x41, 0x41, 0x3E, 0x00 },   // O
;    { 0x7F, 0x09, 0x09, 0x09, 0x06, 0x00 },   // P
;    { 0x3E, 0x41, 0x51, 0x21, 0x5E, 0x00 },   // Q
;    { 0x7F, 0x09, 0x19, 0x29, 0x46, 0x00 },   // R
;    { 0x46, 0x49, 0x49, 0x49, 0x31, 0x00 },   // S
;    { 0x01, 0x01, 0x7F, 0x01, 0x01, 0x00 },   // T
;    { 0x3F, 0x40, 0x40, 0x40, 0x3F, 0x00 },   // U
;    { 0x1F, 0x20, 0x40, 0x20, 0x1F, 0x00 },   // V
;    { 0x7F, 0x20, 0x18, 0x20, 0x7F, 0x00 },   // W
;    { 0x63, 0x14, 0x08, 0x14, 0x63, 0x00 },   // X
;    { 0x03, 0x04, 0x78, 0x04, 0x03, 0x00 },   // Y
;    { 0x61, 0x51, 0x49, 0x45, 0x43, 0x00 },   // Z
;    { 0x00, 0x00, 0x7F, 0x41, 0x41, 0x00 },   // [
;    { 0x02, 0x04, 0x08, 0x10, 0x20, 0x00 },   // 55
;    { 0x41, 0x41, 0x7F, 0x00, 0x00, 0x00 },   // ]
;    { 0x04, 0x02, 0x01, 0x02, 0x04, 0x00 },   // ^
;    { 0x40, 0x40, 0x40, 0x40, 0x40, 0x00 },   // _
;    { 0x00, 0x01, 0x02, 0x04, 0x00, 0x00 },   // '
;    { 0x20, 0x54, 0x54, 0x54, 0x78, 0x00 },   // a
;    { 0x7F, 0x48, 0x44, 0x44, 0x38, 0x00 },   // b
;    { 0x38, 0x44, 0x44, 0x44, 0x20, 0x00 },   // c
;    { 0x38, 0x44, 0x44, 0x48, 0x7F, 0x00 },   // d
;    { 0x38, 0x54, 0x54, 0x54, 0x18, 0x00 },   // e
;    { 0x08, 0x7E, 0x09, 0x01, 0x02, 0x00 },   // f
;    { 0x08, 0x14, 0x54, 0x54, 0x3C, 0x00 },   // g
;    { 0x7F, 0x08, 0x04, 0x04, 0x78, 0x00 },   // h
;    { 0x00, 0x44, 0x7D, 0x40, 0x00, 0x00 },   // i
;    { 0x20, 0x40, 0x44, 0x3D, 0x00, 0x00 },   // j
;    { 0x00, 0x7F, 0x10, 0x28, 0x44, 0x00 },   // k
;    { 0x00, 0x41, 0x7F, 0x40, 0x00, 0x00 },   // l
;    { 0x7C, 0x04, 0x18, 0x04, 0x78, 0x00 },   // m
;    { 0x7C, 0x08, 0x04, 0x04, 0x78, 0x00 },   // n
;    { 0x38, 0x44, 0x44, 0x44, 0x38, 0x00 },   // o
;    { 0x7C, 0x14, 0x14, 0x14, 0x08, 0x00 },   // p
;    { 0x08, 0x14, 0x14, 0x18, 0x7C, 0x00 },   // q
;    { 0x7C, 0x08, 0x04, 0x04, 0x08, 0x00 },   // r
;    { 0x48, 0x54, 0x54, 0x54, 0x20, 0x00 },   // s
;    { 0x04, 0x3F, 0x44, 0x40, 0x20, 0x00 },   // t
;    { 0x3C, 0x40, 0x40, 0x20, 0x7C, 0x00 },   // u
;    { 0x1C, 0x20, 0x40, 0x20, 0x1C, 0x00 },   // v
;    { 0x3C, 0x40, 0x30, 0x40, 0x3C, 0x00 },   // w
;    { 0x44, 0x28, 0x10, 0x28, 0x44, 0x00 },   // x
;    { 0x0C, 0x50, 0x50, 0x50, 0x3C, 0x00 },   // y
;    { 0x44, 0x64, 0x54, 0x4C, 0x44, 0x00 }    // z
;};
;
;// Bit Control
;#ifdef _ATXMEGA_DEVICE_
;#define set_rs  *(glcd_rs_address  + 0x01) = glcd_rs_bit_msk
;#define set_rw  *(glcd_rw_address  + 0x01) = glcd_rw_bit_msk
;#define set_en  *(glcd_en_address  + 0x01) = glcd_en_bit_msk
;#define set_cs1 *(glcd_cs1_address + 0x01) = glcd_cs1_bit_msk
;#define set_cs2 *(glcd_cs2_address + 0x01) = glcd_cs2_bit_msk
;#define set_rst *(glcd_rst_address + 0x01) = glcd_rst_bit_msk
;#define clr_rs  *(glcd_rs_address  + 0x02) = glcd_rs_bit_msk
;#define clr_rw  *(glcd_rw_address  + 0x02) = glcd_rw_bit_msk
;#define clr_en  *(glcd_en_address  + 0x02) = glcd_en_bit_msk
;#define clr_cs1 *(glcd_cs1_address + 0x02) = glcd_cs1_bit_msk
;#define clr_cs2 *(glcd_cs2_address + 0x02) = glcd_cs2_bit_msk
;#define clr_rst *(glcd_rst_address + 0x02) = glcd_rst_bit_msk
;#define tgl_rs  *(glcd_rs_address  + 0x03) = glcd_rs_bit_msk
;#define tgl_rw  *(glcd_rw_address  + 0x03) = glcd_rw_bit_msk
;#define tgl_en  *(glcd_en_address  + 0x03) = glcd_en_bit_msk
;#define tgl_cs1 *(glcd_cs1_address + 0x03) = glcd_cs1_bit_msk
;#define tgl_cs2 *(glcd_cs2_address + 0x03) = glcd_cs2_bit_msk
;#define tgl_rst *(glcd_rst_address + 0x03) = glcd_rst_bit_msk
;#else
;#define set_rs  SETBIT(*glcd_rs_address, glcd_rs_bit_pos)
;#define set_rw  SETBIT(*glcd_rw_address, glcd_rw_bit_pos)
;#define set_en  SETBIT(*glcd_en_address, glcd_en_bit_pos)
;#define set_cs1 SETBIT(*glcd_cs1_address,glcd_cs1_bit_pos)
;#define set_cs2 SETBIT(*glcd_cs2_address,glcd_cs2_bit_pos)
;#define set_rst SETBIT(*glcd_rst_address,glcd_rst_bit_pos)
;#define clr_rs  CLRBIT(*glcd_rs_address, glcd_rs_bit_pos)
;#define clr_rw  CLRBIT(*glcd_rw_address, glcd_rw_bit_pos)
;#define clr_en  CLRBIT(*glcd_en_address, glcd_en_bit_pos)
;#define clr_cs1 CLRBIT(*glcd_cs1_address,glcd_cs1_bit_pos)
;#define clr_cs2 CLRBIT(*glcd_cs2_address,glcd_cs2_bit_pos)
;#define clr_rst CLRBIT(*glcd_rst_address,glcd_rst_bit_pos)
;#define tgl_rs  TGLBIT(*glcd_rs_address, glcd_rs_bit_pos)
;#define tgl_rw  TGLBIT(*glcd_rw_address, glcd_rw_bit_pos)
;#define tgl_en  TGLBIT(*glcd_en_address, glcd_en_bit_pos)
;#define tgl_cs1 TGLBIT(*glcd_cs1_address,glcd_cs1_bit_pos)
;#define tgl_cs2 TGLBIT(*glcd_cs2_address,glcd_cs2_bit_pos)
;#define tgl_rst TGLBIT(*glcd_rst_address,glcd_rst_bit_pos)
;#endif
;
;#define NumberOfCases 33
;         unsigned int  CaseAddress[NumberOfCases];
;register unsigned int  CaseAddressIndex @0x02; //R3:R2
;#define  GotoAddress   CaseAddressIndex
;
;// External (user's) functions
;void glcd_define (unsigned char *glcd_data_port_address,
; 0000 00E1                   unsigned char *glcd_rs_port_address,  unsigned char glcd_rs_pin,
; 0000 00E2                   unsigned char *glcd_rw_port_address,  unsigned char glcd_rw_pin,
; 0000 00E3                   unsigned char *glcd_en_port_address,  unsigned char glcd_en_pin,
; 0000 00E4                   unsigned char *glcd_cs1_port_address, unsigned char glcd_cs1_pin,
; 0000 00E5                   unsigned char *glcd_cs2_port_address, unsigned char glcd_cs2_pin,
; 0000 00E6                   unsigned char *glcd_rst_port_address, unsigned char glcd_rst_pin)
; 0000 00E7 {

	.CSEG
_glcd_define:
; 0000 00E8     glcd_data_address = glcd_data_port_address;
;	*glcd_data_port_address -> Y+18
;	*glcd_rs_port_address -> Y+16
;	glcd_rs_pin -> Y+15
;	*glcd_rw_port_address -> Y+13
;	glcd_rw_pin -> Y+12
;	*glcd_en_port_address -> Y+10
;	glcd_en_pin -> Y+9
;	*glcd_cs1_port_address -> Y+7
;	glcd_cs1_pin -> Y+6
;	*glcd_cs2_port_address -> Y+4
;	glcd_cs2_pin -> Y+3
;	*glcd_rst_port_address -> Y+1
;	glcd_rst_pin -> Y+0
	LDD  R30,Y+18
	LDD  R31,Y+18+1
	STS  _glcd_data_address_G000,R30
	STS  _glcd_data_address_G000+1,R31
; 0000 00E9     glcd_rs_address   = glcd_rs_port_address;
	LDD  R30,Y+16
	LDD  R31,Y+16+1
	STS  _glcd_rs_address_G000,R30
	STS  _glcd_rs_address_G000+1,R31
; 0000 00EA     glcd_rw_address   = glcd_rw_port_address;
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	STS  _glcd_rw_address_G000,R30
	STS  _glcd_rw_address_G000+1,R31
; 0000 00EB     glcd_en_address   = glcd_en_port_address;
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	STS  _glcd_en_address_G000,R30
	STS  _glcd_en_address_G000+1,R31
; 0000 00EC     glcd_cs1_address  = glcd_cs1_port_address;
	LDD  R30,Y+7
	LDD  R31,Y+7+1
	STS  _glcd_cs1_address_G000,R30
	STS  _glcd_cs1_address_G000+1,R31
; 0000 00ED     glcd_cs2_address  = glcd_cs2_port_address;
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	STS  _glcd_cs2_address_G000,R30
	STS  _glcd_cs2_address_G000+1,R31
; 0000 00EE     glcd_rst_address  = glcd_rst_port_address;
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	STS  _glcd_rst_address_G000,R30
	STS  _glcd_rst_address_G000+1,R31
; 0000 00EF #ifdef _ATXMEGA_DEVICE_
; 0000 00F0     glcd_rs_bit_msk  = 0b00000001 << glcd_rs_pin;
; 0000 00F1     glcd_rw_bit_msk  = 0b00000001 << glcd_rw_pin;
; 0000 00F2     glcd_en_bit_msk  = 0b00000001 << glcd_en_pin;
; 0000 00F3     glcd_cs1_bit_msk = 0b00000001 << glcd_cs1_pin;
; 0000 00F4     glcd_cs2_bit_msk = 0b00000001 << glcd_cs2_pin;
; 0000 00F5     glcd_rst_bit_msk = 0b00000001 << glcd_rst_pin;
; 0000 00F6     // Set all the pins as output
; 0000 00F7     *(glcd_data_address - 0x03) = 0xFF;
; 0000 00F8     *(glcd_rs_address - 0x03)   = glcd_rs_bit_msk;
; 0000 00F9     clr_rw;
; 0000 00FA     *(glcd_rw_address - 0x03)   = glcd_rw_bit_msk;
; 0000 00FB     *(glcd_en_address - 0x03)   = glcd_en_bit_msk;
; 0000 00FC     *(glcd_cs1_address - 0x03)  = glcd_cs1_bit_msk;
; 0000 00FD     *(glcd_cs2_address - 0x03)  = glcd_cs2_bit_msk;
; 0000 00FE     *(glcd_rst_address - 0x03)  = glcd_rst_bit_msk;
; 0000 00FF #else
; 0000 0100     glcd_rs_bit_pos  = glcd_rs_pin;
	LDD  R30,Y+15
	STS  _glcd_rs_bit_pos_G000,R30
; 0000 0101     glcd_rw_bit_pos  = glcd_rw_pin;
	LDD  R30,Y+12
	STS  _glcd_rw_bit_pos_G000,R30
; 0000 0102     glcd_en_bit_pos  = glcd_en_pin;
	LDD  R30,Y+9
	STS  _glcd_en_bit_pos_G000,R30
; 0000 0103     glcd_cs1_bit_pos = glcd_cs1_pin;
	LDD  R30,Y+6
	STS  _glcd_cs1_bit_pos_G000,R30
; 0000 0104     glcd_cs2_bit_pos = glcd_cs2_pin;
	LDD  R30,Y+3
	STS  _glcd_cs2_bit_pos_G000,R30
; 0000 0105     glcd_rst_bit_pos = glcd_rst_pin;
	LD   R30,Y
	STS  _glcd_rst_bit_pos_G000,R30
; 0000 0106     // Sets the pins as output
; 0000 0107     *(glcd_data_address - 1) = 0xFF;
	LDS  R30,_glcd_data_address_G000
	LDS  R31,_glcd_data_address_G000+1
	SBIW R30,1
	LDI  R26,LOW(255)
	STD  Z+0,R26
; 0000 0108     SETBIT (*(glcd_rs_address - 0x01),glcd_rs_bit_pos);
	LDS  R30,_glcd_rs_address_G000
	LDS  R31,_glcd_rs_address_G000+1
	SBIW R30,1
	MOVW R22,R30
	LD   R1,Z
	LDS  R30,_glcd_rs_bit_pos_G000
	LDI  R26,LOW(1)
	CALL __LSLB12
	OR   R30,R1
	MOVW R26,R22
	ST   X,R30
; 0000 0109     SETBIT (*(glcd_rw_address - 0x01),glcd_rw_bit_pos);
	LDS  R30,_glcd_rw_address_G000
	LDS  R31,_glcd_rw_address_G000+1
	SBIW R30,1
	MOVW R22,R30
	LD   R1,Z
	LDS  R30,_glcd_rw_bit_pos_G000
	LDI  R26,LOW(1)
	CALL __LSLB12
	OR   R30,R1
	MOVW R26,R22
	ST   X,R30
; 0000 010A     clr_rw;
	LDS  R26,_glcd_rw_address_G000
	LDS  R27,_glcd_rw_address_G000+1
	MOV  R22,R26
	LD   R1,X
	LDS  R30,_glcd_rw_bit_pos_G000
	LDI  R26,LOW(1)
	CALL __LSLB12
	COM  R30
	AND  R30,R1
	MOV  R26,R22
	ST   X,R30
; 0000 010B     SETBIT (*(glcd_en_address - 0x01),glcd_en_bit_pos);
	LDS  R30,_glcd_en_address_G000
	LDS  R31,_glcd_en_address_G000+1
	SBIW R30,1
	MOVW R22,R30
	LD   R1,Z
	LDS  R30,_glcd_en_bit_pos_G000
	LDI  R26,LOW(1)
	CALL __LSLB12
	OR   R30,R1
	MOVW R26,R22
	ST   X,R30
; 0000 010C     SETBIT (*(glcd_cs1_address - 0x01),glcd_cs1_bit_pos);
	LDS  R30,_glcd_cs1_address_G000
	LDS  R31,_glcd_cs1_address_G000+1
	SBIW R30,1
	MOVW R22,R30
	LD   R1,Z
	LDS  R30,_glcd_cs1_bit_pos_G000
	LDI  R26,LOW(1)
	CALL __LSLB12
	OR   R30,R1
	MOVW R26,R22
	ST   X,R30
; 0000 010D     SETBIT (*(glcd_cs2_address - 0x01),glcd_cs2_bit_pos);
	LDS  R30,_glcd_cs2_address_G000
	LDS  R31,_glcd_cs2_address_G000+1
	SBIW R30,1
	MOVW R22,R30
	LD   R1,Z
	LDS  R30,_glcd_cs2_bit_pos_G000
	LDI  R26,LOW(1)
	CALL __LSLB12
	OR   R30,R1
	MOVW R26,R22
	ST   X,R30
; 0000 010E     SETBIT (*(glcd_rst_address - 0x01),glcd_rst_bit_pos);
	LDS  R30,_glcd_rst_address_G000
	LDS  R31,_glcd_rst_address_G000+1
	SBIW R30,1
	MOVW R22,R30
	LD   R1,Z
	LDS  R30,_glcd_rst_bit_pos_G000
	LDI  R26,LOW(1)
	CALL __LSLB12
	OR   R30,R1
	MOVW R26,R22
	ST   X,R30
; 0000 010F #endif
; 0000 0110 #asm
; 0000 0111     LDI        R30, LOW(_CaseAddress)
    LDI        R30, LOW(_CaseAddress)
; 0000 0112     LDI     R31, HIGH(_CaseAddress)
    LDI     R31, HIGH(_CaseAddress)
; 0000 0113     ;//Save R16, R17
    ;//Save R16, R17
; 0000 0114     PUSH    R16
    PUSH    R16
; 0000 0115     PUSH    R17
    PUSH    R17
; 0000 0116     ;//Load #1 case for delay function
    ;//Load #1 case for delay function
; 0000 0117     LDI     R16, LOW(DelayLabel1)
    LDI     R16, LOW(DelayLabel1)
; 0000 0118     LDI        R17, HIGH(DelayLabel1)
    LDI        R17, HIGH(DelayLabel1)
; 0000 0119     ST        Z+,  R16
    ST        Z+,  R16
; 0000 011A     ST        Z+,  R17
    ST        Z+,  R17
; 0000 011B     ;//Load #2 case for delay function
    ;//Load #2 case for delay function
; 0000 011C     LDI     R16, LOW(DelayLabel2)
    LDI     R16, LOW(DelayLabel2)
; 0000 011D     LDI        R17, HIGH(DelayLabel2)
    LDI        R17, HIGH(DelayLabel2)
; 0000 011E     ST        Z+,  R16
    ST        Z+,  R16
; 0000 011F     ST        Z+,  R17
    ST        Z+,  R17
; 0000 0120 

; 0000 0121     LDI     R16, LOW(GlcdUnlockLockLabel1)
    LDI     R16, LOW(GlcdUnlockLockLabel1)
; 0000 0122     LDI        R17, HIGH(GlcdUnlockLockLabel1)
    LDI        R17, HIGH(GlcdUnlockLockLabel1)
; 0000 0123     ST        Z+,  R16
    ST        Z+,  R16
; 0000 0124     ST        Z+,  R17
    ST        Z+,  R17
; 0000 0125 

; 0000 0126     LDI     R16, LOW(GlcdUnlockLockLabel2)
    LDI     R16, LOW(GlcdUnlockLockLabel2)
; 0000 0127     LDI        R17, HIGH(GlcdUnlockLockLabel2)
    LDI        R17, HIGH(GlcdUnlockLockLabel2)
; 0000 0128     ST        Z+,  R16
    ST        Z+,  R16
; 0000 0129     ST        Z+,  R17
    ST        Z+,  R17
; 0000 012A 

; 0000 012B     LDI     R16, LOW(GlcdUnlockLockLabel3)
    LDI     R16, LOW(GlcdUnlockLockLabel3)
; 0000 012C     LDI        R17, HIGH(GlcdUnlockLockLabel3)
    LDI        R17, HIGH(GlcdUnlockLockLabel3)
; 0000 012D     ST        Z+,  R16
    ST        Z+,  R16
; 0000 012E     ST        Z+,  R17
    ST        Z+,  R17
; 0000 012F 

; 0000 0130     LDI     R16, LOW(GlcdInitLabel1)
    LDI     R16, LOW(GlcdInitLabel1)
; 0000 0131     LDI        R17, HIGH(GlcdInitLabel1)
    LDI        R17, HIGH(GlcdInitLabel1)
; 0000 0132     ST        Z+,  R16
    ST        Z+,  R16
; 0000 0133     ST        Z+,  R17
    ST        Z+,  R17
; 0000 0134 

; 0000 0135     LDI     R16, LOW(GlcdInitLabel2)
    LDI     R16, LOW(GlcdInitLabel2)
; 0000 0136     LDI        R17, HIGH(GlcdInitLabel2)
    LDI        R17, HIGH(GlcdInitLabel2)
; 0000 0137     ST        Z+,  R16
    ST        Z+,  R16
; 0000 0138     ST        Z+,  R17
    ST        Z+,  R17
; 0000 0139 

; 0000 013A     LDI     R16, LOW(GlcdInitLabel3)
    LDI     R16, LOW(GlcdInitLabel3)
; 0000 013B     LDI        R17, HIGH(GlcdInitLabel3)
    LDI        R17, HIGH(GlcdInitLabel3)
; 0000 013C     ST        Z+,  R16
    ST        Z+,  R16
; 0000 013D     ST        Z+,  R17
    ST        Z+,  R17
; 0000 013E 

; 0000 013F     LDI     R16, LOW(GlcdInitLabel4)
    LDI     R16, LOW(GlcdInitLabel4)
; 0000 0140     LDI        R17, HIGH(GlcdInitLabel4)
    LDI        R17, HIGH(GlcdInitLabel4)
; 0000 0141     ST        Z+,  R16
    ST        Z+,  R16
; 0000 0142     ST        Z+,  R17
    ST        Z+,  R17
; 0000 0143 

; 0000 0144     LDI     R16, LOW(GlcdInitLabel5)
    LDI     R16, LOW(GlcdInitLabel5)
; 0000 0145     LDI        R17, HIGH(GlcdInitLabel5)
    LDI        R17, HIGH(GlcdInitLabel5)
; 0000 0146     ST        Z+,  R16
    ST        Z+,  R16
; 0000 0147     ST        Z+,  R17
    ST        Z+,  R17
; 0000 0148 

; 0000 0149     LDI     R16, LOW(GlcdInitLabel6)
    LDI     R16, LOW(GlcdInitLabel6)
; 0000 014A     LDI        R17, HIGH(GlcdInitLabel6)
    LDI        R17, HIGH(GlcdInitLabel6)
; 0000 014B     ST        Z+,  R16
    ST        Z+,  R16
; 0000 014C     ST        Z+,  R17
    ST        Z+,  R17
; 0000 014D 

; 0000 014E     LDI     R16, LOW(GlcdInitLabel7)
    LDI     R16, LOW(GlcdInitLabel7)
; 0000 014F     LDI        R17, HIGH(GlcdInitLabel7)
    LDI        R17, HIGH(GlcdInitLabel7)
; 0000 0150     ST        Z+,  R16
    ST        Z+,  R16
; 0000 0151     ST        Z+,  R17
    ST        Z+,  R17
; 0000 0152 

; 0000 0153     LDI     R16, LOW(GlcdInitLabel8)
    LDI     R16, LOW(GlcdInitLabel8)
; 0000 0154     LDI        R17, HIGH(GlcdInitLabel8)
    LDI        R17, HIGH(GlcdInitLabel8)
; 0000 0155     ST        Z+,  R16
    ST        Z+,  R16
; 0000 0156     ST        Z+,  R17
    ST        Z+,  R17
; 0000 0157 

; 0000 0158     LDI     R16, LOW(GlcdWriteByteLabel1)
    LDI     R16, LOW(GlcdWriteByteLabel1)
; 0000 0159     LDI        R17, HIGH(GlcdWriteByteLabel1)
    LDI        R17, HIGH(GlcdWriteByteLabel1)
; 0000 015A     ST        Z+,  R16
    ST        Z+,  R16
; 0000 015B     ST        Z+,  R17
    ST        Z+,  R17
; 0000 015C 

; 0000 015D     LDI     R16, LOW(GlcdWriteByteLabel2)
    LDI     R16, LOW(GlcdWriteByteLabel2)
; 0000 015E     LDI        R17, HIGH(GlcdWriteByteLabel2)
    LDI        R17, HIGH(GlcdWriteByteLabel2)
; 0000 015F     ST        Z+,  R16
    ST        Z+,  R16
; 0000 0160     ST        Z+,  R17
    ST        Z+,  R17
; 0000 0161 

; 0000 0162     LDI     R16, LOW(GlcdWriteByteLabel3)
    LDI     R16, LOW(GlcdWriteByteLabel3)
; 0000 0163     LDI        R17, HIGH(GlcdWriteByteLabel3)
    LDI        R17, HIGH(GlcdWriteByteLabel3)
; 0000 0164     ST        Z+,  R16
    ST        Z+,  R16
; 0000 0165     ST        Z+,  R17
    ST        Z+,  R17
; 0000 0166 

; 0000 0167     LDI     R16, LOW(GlcdWriteByteLabel4)
    LDI     R16, LOW(GlcdWriteByteLabel4)
; 0000 0168     LDI        R17, HIGH(GlcdWriteByteLabel4)
    LDI        R17, HIGH(GlcdWriteByteLabel4)
; 0000 0169     ST        Z+,  R16
    ST        Z+,  R16
; 0000 016A     ST        Z+,  R17
    ST        Z+,  R17
; 0000 016B 

; 0000 016C     LDI     R16, LOW(GlcdClearPageLabel1)
    LDI     R16, LOW(GlcdClearPageLabel1)
; 0000 016D     LDI        R17, HIGH(GlcdClearPageLabel1)
    LDI        R17, HIGH(GlcdClearPageLabel1)
; 0000 016E     ST        Z+,  R16
    ST        Z+,  R16
; 0000 016F     ST        Z+,  R17
    ST        Z+,  R17
; 0000 0170 

; 0000 0171     LDI     R16, LOW(GlcdClearPageLabel2)
    LDI     R16, LOW(GlcdClearPageLabel2)
; 0000 0172     LDI        R17, HIGH(GlcdClearPageLabel2)
    LDI        R17, HIGH(GlcdClearPageLabel2)
; 0000 0173     ST        Z+,  R16
    ST        Z+,  R16
; 0000 0174     ST        Z+,  R17
    ST        Z+,  R17
; 0000 0175 

; 0000 0176     LDI     R16, LOW(GlcdPutcharLabel1)
    LDI     R16, LOW(GlcdPutcharLabel1)
; 0000 0177     LDI        R17, HIGH(GlcdPutcharLabel1)
    LDI        R17, HIGH(GlcdPutcharLabel1)
; 0000 0178     ST        Z+,  R16
    ST        Z+,  R16
; 0000 0179     ST        Z+,  R17
    ST        Z+,  R17
; 0000 017A 

; 0000 017B     LDI     R16, LOW(GlcdPutcharLabel2)
    LDI     R16, LOW(GlcdPutcharLabel2)
; 0000 017C     LDI        R17, HIGH(GlcdPutcharLabel2)
    LDI        R17, HIGH(GlcdPutcharLabel2)
; 0000 017D     ST        Z+,  R16
    ST        Z+,  R16
; 0000 017E     ST        Z+,  R17
    ST        Z+,  R17
; 0000 017F 

; 0000 0180     LDI     R16, LOW(GlcdPutsLabel1)
    LDI     R16, LOW(GlcdPutsLabel1)
; 0000 0181     LDI        R17, HIGH(GlcdPutsLabel1)
    LDI        R17, HIGH(GlcdPutsLabel1)
; 0000 0182     ST        Z+,  R16
    ST        Z+,  R16
; 0000 0183     ST        Z+,  R17
    ST        Z+,  R17
; 0000 0184 

; 0000 0185     LDI     R16, LOW(GlcdPutsLabel2)
    LDI     R16, LOW(GlcdPutsLabel2)
; 0000 0186     LDI        R17, HIGH(GlcdPutsLabel2)
    LDI        R17, HIGH(GlcdPutsLabel2)
; 0000 0187     ST        Z+,  R16
    ST        Z+,  R16
; 0000 0188     ST        Z+,  R17
    ST        Z+,  R17
; 0000 0189 

; 0000 018A     LDI     R16, LOW(GlcdPutsCenterLabel1)
    LDI     R16, LOW(GlcdPutsCenterLabel1)
; 0000 018B     LDI        R17, HIGH(GlcdPutsCenterLabel1)
    LDI        R17, HIGH(GlcdPutsCenterLabel1)
; 0000 018C     ST        Z+,  R16
    ST        Z+,  R16
; 0000 018D     ST        Z+,  R17
    ST        Z+,  R17
; 0000 018E 

; 0000 018F     LDI     R16, LOW(GlcdPutsCenterLabel2)
    LDI     R16, LOW(GlcdPutsCenterLabel2)
; 0000 0190     LDI        R17, HIGH(GlcdPutsCenterLabel2)
    LDI        R17, HIGH(GlcdPutsCenterLabel2)
; 0000 0191     ST        Z+,  R16
    ST        Z+,  R16
; 0000 0192     ST        Z+,  R17
    ST        Z+,  R17
; 0000 0193 

; 0000 0194     LDI     R16, LOW(GlcdPutsfLabel1)
    LDI     R16, LOW(GlcdPutsfLabel1)
; 0000 0195     LDI        R17, HIGH(GlcdPutsfLabel1)
    LDI        R17, HIGH(GlcdPutsfLabel1)
; 0000 0196     ST        Z+,  R16
    ST        Z+,  R16
; 0000 0197     ST        Z+,  R17
    ST        Z+,  R17
; 0000 0198 

; 0000 0199     LDI     R16, LOW(GlcdPutsfLabel2)
    LDI     R16, LOW(GlcdPutsfLabel2)
; 0000 019A     LDI        R17, HIGH(GlcdPutsfLabel2)
    LDI        R17, HIGH(GlcdPutsfLabel2)
; 0000 019B     ST        Z+,  R16
    ST        Z+,  R16
; 0000 019C     ST        Z+,  R17
    ST        Z+,  R17
; 0000 019D 

; 0000 019E     LDI     R16, LOW(GlcdPutsfCenterLabel1)
    LDI     R16, LOW(GlcdPutsfCenterLabel1)
; 0000 019F     LDI        R17, HIGH(GlcdPutsfCenterLabel1)
    LDI        R17, HIGH(GlcdPutsfCenterLabel1)
; 0000 01A0     ST        Z+,  R16
    ST        Z+,  R16
; 0000 01A1     ST        Z+,  R17
    ST        Z+,  R17
; 0000 01A2 

; 0000 01A3     LDI     R16, LOW(GlcdPutsfCenterLabel2)
    LDI     R16, LOW(GlcdPutsfCenterLabel2)
; 0000 01A4     LDI        R17, HIGH(GlcdPutsfCenterLabel2)
    LDI        R17, HIGH(GlcdPutsfCenterLabel2)
; 0000 01A5     ST        Z+,  R16
    ST        Z+,  R16
; 0000 01A6     ST        Z+,  R17
    ST        Z+,  R17
; 0000 01A7 

; 0000 01A8     LDI     R16, LOW(GlcdClearLabel1)
    LDI     R16, LOW(GlcdClearLabel1)
; 0000 01A9     LDI        R17, HIGH(GlcdClearLabel1)
    LDI        R17, HIGH(GlcdClearLabel1)
; 0000 01AA     ST        Z+,  R16
    ST        Z+,  R16
; 0000 01AB     ST        Z+,  R17
    ST        Z+,  R17
; 0000 01AC 

; 0000 01AD     LDI     R16, LOW(GlcdClearLabel2)
    LDI     R16, LOW(GlcdClearLabel2)
; 0000 01AE     LDI        R17, HIGH(GlcdClearLabel2)
    LDI        R17, HIGH(GlcdClearLabel2)
; 0000 01AF     ST        Z+,  R16
    ST        Z+,  R16
; 0000 01B0     ST        Z+,  R17
    ST        Z+,  R17
; 0000 01B1 

; 0000 01B2     LDI     R16, LOW(GlcdPutbmpLabel1)
    LDI     R16, LOW(GlcdPutbmpLabel1)
; 0000 01B3     LDI        R17, HIGH(GlcdPutbmpLabel1)
    LDI        R17, HIGH(GlcdPutbmpLabel1)
; 0000 01B4     ST        Z+,  R16
    ST        Z+,  R16
; 0000 01B5     ST        Z+,  R17
    ST        Z+,  R17
; 0000 01B6 

; 0000 01B7     LDI     R16, LOW(GlcdPutbmpLabel2)
    LDI     R16, LOW(GlcdPutbmpLabel2)
; 0000 01B8     LDI        R17, HIGH(GlcdPutbmpLabel2)
    LDI        R17, HIGH(GlcdPutbmpLabel2)
; 0000 01B9     ST        Z+,  R16
    ST        Z+,  R16
; 0000 01BA     ST        Z+,  R17
    ST        Z+,  R17
; 0000 01BB 

; 0000 01BC     POP        R17
    POP        R17
; 0000 01BD     POP        R16
    POP        R16
; 0000 01BE #endasm
; 0000 01BF }
	ADIW R28,20
	RET
;
;// Timer function pointers
;void (*timer_interrupt_enable) (void);
;
;void (*timer_interrupt_disable) (void);
;
;void (*set_delay_7us) (void);
;
;void (*set_delay_10ms) (void);
;
;#define StackSize     10
;enum cases
;{
;    DelayCase1 = 0,
;    DelayCase2,
;    GlcdUnlockLockCase1,
;    GlcdUnlockLockCase2,
;    GlcdUnlockLockCase3,
;    GlcdInitCase1,
;    GlcdInitCase2,
;    GlcdInitCase3,
;    GlcdInitCase4,
;    GlcdInitCase5,
;    GlcdInitCase6,
;    GlcdInitCase7,
;    GlcdInitCase8,
;    GlcdWriteByteCase1,
;    GlcdWriteByteCase2,
;    GlcdWriteByteCase3,
;    GlcdWriteByteCase4,
;    GlcdClearPageCase1,
;    GlcdClearPageCase2,
;    GlcdPutcharCase1,
;    GlcdPutcharCase2,
;    GlcdPutsCase1,
;    GlcdPutsCase2,
;    GlcdPutsCenterCase1,
;    GlcdPutsCenterCase2,
;    GlcdPutsfCase1,
;    GlcdPutsfCase2,
;    GlcdPutsfCenterCase1,
;    GlcdPutsfCenterCase2,
;    GlcdClearCase1,
;    GlcdClearCase2,
;    GlcdPutbmpCase1,
;    GlcdPutbmpCase2
;} CaseStack[StackSize];
;unsigned char StackPointer = 0xFF;
;#define GlcdBusy (~StackPointer)
;
;unsigned char PushCase (enum cases Case)
; 0000 01F3 {
_PushCase:
; 0000 01F4     if (((StackPointer + 1) < StackSize) || (StackPointer == 0xFF) )
;	Case -> Y+0
	MOV  R30,R13
	LDI  R31,0
	ADIW R30,1
	SBIW R30,10
	BRLT _0x4
	LDI  R30,LOW(255)
	CP   R30,R13
	BRNE _0x3
_0x4:
; 0000 01F5     {
; 0000 01F6         StackPointer++;
	INC  R13
; 0000 01F7         CaseStack[StackPointer] = Case;
	MOV  R30,R13
	LDI  R31,0
	SUBI R30,LOW(-_CaseStack)
	SBCI R31,HIGH(-_CaseStack)
	LD   R26,Y
	STD  Z+0,R26
; 0000 01F8         return 0;
	LDI  R30,LOW(0)
	RJMP _0x2080008
; 0000 01F9     }
; 0000 01FA     else
_0x3:
; 0000 01FB         return 1;
	LDI  R30,LOW(1)
; 0000 01FC }
_0x2080008:
	ADIW R28,1
	RET
;
;unsigned char PopCase (void)
; 0000 01FF {
_PopCase:
; 0000 0200     if (~StackPointer)
	MOV  R30,R13
	COM  R30
	CPI  R30,0
	BREQ _0x7
; 0000 0201     {
; 0000 0202         StackPointer--;
	DEC  R13
; 0000 0203         return 0;
	LDI  R30,LOW(0)
	RET
; 0000 0204     }
; 0000 0205     else
_0x7:
; 0000 0206         return 1;
	LDI  R30,LOW(1)
	RET
; 0000 0207 }
	RET
;
;unsigned char strlen_char (unsigned char *str)
; 0000 020A {
_strlen_char:
; 0000 020B     unsigned char i;
; 0000 020C     for (i = 0; *str++ != 0;i++);
	ST   -Y,R17
;	*str -> Y+1
;	i -> R17
	LDI  R17,LOW(0)
_0xA:
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	LD   R30,X+
	STD  Y+1,R26
	STD  Y+1+1,R27
	CPI  R30,0
	BREQ _0xB
	SUBI R17,-1
	RJMP _0xA
_0xB:
; 0000 020D     return i;
	RJMP _0x2080007
; 0000 020E }
;
;unsigned char strlenf_char (flash unsigned char *str)
; 0000 0211 {
_strlenf_char:
; 0000 0212     unsigned char i;
; 0000 0213     for (i = 0; *str++ != 0;i++);
	ST   -Y,R17
;	*str -> Y+1
;	i -> R17
	LDI  R17,LOW(0)
_0xD:
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	ADIW R30,1
	STD  Y+1,R30
	STD  Y+1+1,R31
	SBIW R30,1
	LPM  R30,Z
	CPI  R30,0
	BREQ _0xE
	SUBI R17,-1
	RJMP _0xD
_0xE:
; 0000 0214     return i;
_0x2080007:
	MOV  R30,R17
	LDD  R17,Y+0
	ADIW R28,3
	RET
; 0000 0215 }
;
;#define IndirectGoto    do\
;                        {\
;                            #asm("MOV    R30, R2")\
;                            #asm("MOV    R31, R3")\
;                            #asm("IJMP")\
;                        } while (0)
;
;#define GotoNextCase    if ((~StackPointer))\
;                        {\
;                            GotoAddress = CaseAddress[CaseStack[StackPointer]];\
;                            IndirectGoto;\
;                        }\
;                        else\
;                            return
;
;#define SetCurrentCase(CCase)    CaseStack[StackPointer] = CCase
;
;#define StackPlus(Case,Label)   do\
;                                {\
;                                    SetCurrentCase(Case);\
;                                    StackPointer++;\
;                                    goto Label;\
;                                }\
;                                while (0)
;
;#define StackMinus()            do\
;                                {\
;                                    PopCase();\
;                                    GotoNextCase;\
;                                }\
;                                while (0)
;
;#define DebugDisplay(Pos,Char)  do\
;                                {\
;                                    lcd_gotoxy(0,0);\
;                                    lcd_putsf("          ");\
;                                    lcd_gotoxy(Pos,0);\
;                                    lcd_putchar(Char);\
;                                }\
;                                while (0)
;
;unsigned char GlcdPage;
;unsigned char GlcdColumn;
;unsigned char GlcdDataByte;
;unsigned char GlcdChar;
;unsigned char *GlcdString;
;flash unsigned char *GlcdFlashString;
;flash unsigned char *GlcdFlashPointer;
;
;void glcd_timer_isr (void)
; 0000 0249 {
_glcd_timer_isr:
; 0000 024A     static unsigned char i;
; 0000 024B     static unsigned int  j;
; 0000 024C     if (StackPointer != 0xFF)
	LDI  R30,LOW(255)
	CP   R30,R13
	BRNE PC+3
	JMP _0xF
; 0000 024D     {
; 0000 024E         if (StackPointer == 0x00)
	TST  R13
	BRNE _0x10
; 0000 024F         {
; 0000 0250             GotoNextCase;
	MOV  R30,R13
	COM  R30
	CPI  R30,0
	BREQ _0x11
	MOV  R30,R13
	LDI  R31,0
	SUBI R30,LOW(-_CaseStack)
	SBCI R31,HIGH(-_CaseStack)
	LD   R30,Z
	LDI  R26,LOW(_CaseAddress)
	LDI  R27,HIGH(_CaseAddress)
	LDI  R31,0
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	LD   R2,X+
	LD   R3,X
	MOV    R30, R2
	MOV    R31, R3
	IJMP
	RJMP _0x15
_0x11:
	RET
; 0000 0251         }
_0x15:
; 0000 0252 /////////////////////////////////////////////////////////////////////////
; 0000 0253 #asm
_0x10:
; 0000 0254 DelayLabel2:
DelayLabel2:
; 0000 0255 #endasm
; 0000 0256 DelayLabel2:
; 0000 0257         (*timer_interrupt_disable)();
	MOVW R30,R6
	ICALL
; 0000 0258 #ifdef Debugging
; 0000 0259         DebugDisplay(0x0,'2');
; 0000 025A         while (PINB & 0x01); while (!(PINB & 0x01));
; 0000 025B #endif
; 0000 025C         StackMinus();
	RCALL _PopCase
	MOV  R30,R13
	COM  R30
	CPI  R30,0
	BREQ _0x1A
	MOV  R30,R13
	LDI  R31,0
	SUBI R30,LOW(-_CaseStack)
	SBCI R31,HIGH(-_CaseStack)
	LD   R30,Z
	LDI  R26,LOW(_CaseAddress)
	LDI  R27,HIGH(_CaseAddress)
	LDI  R31,0
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	LD   R2,X+
	LD   R3,X
	MOV    R30, R2
	MOV    R31, R3
	IJMP
	RJMP _0x1E
_0x1A:
	RET
_0x1E:
; 0000 025D #asm
; 0000 025E DelayLabel1:
DelayLabel1:
; 0000 025F #endasm
; 0000 0260 DelayLabel1:
_0x1F:
; 0000 0261 #ifdef Debugging
; 0000 0262         DebugDisplay(0x0,'1');
; 0000 0263         while (PINB & 0x01); while (!(PINB & 0x01));
; 0000 0264 #endif
; 0000 0265         SetCurrentCase(DelayCase2);
	MOV  R30,R13
	LDI  R31,0
	SUBI R30,LOW(-_CaseStack)
	SBCI R31,HIGH(-_CaseStack)
	LDI  R26,LOW(1)
	STD  Z+0,R26
; 0000 0266         (*timer_interrupt_enable)();
	MOVW R30,R4
	ICALL
; 0000 0267         return;
	RET
; 0000 0268 #asm
; 0000 0269 GlcdUnlockLockLabel3:
GlcdUnlockLockLabel3:
; 0000 026A #endasm
; 0000 026B GlcdUnlockLockLabel3:
; 0000 026C #ifdef Debugging
; 0000 026D         DebugDisplay(0x1,'3');
; 0000 026E         while (PINB & 0x01); while (!(PINB & 0x01));
; 0000 026F #endif
; 0000 0270         clr_en;
	LDS  R26,_glcd_en_address_G000
	LDS  R27,_glcd_en_address_G000+1
	MOV  R22,R26
	LD   R1,X
	LDS  R30,_glcd_en_bit_pos_G000
	LDI  R26,LOW(1)
	CALL __LSLB12
	COM  R30
	AND  R30,R1
	MOV  R26,R22
	ST   X,R30
; 0000 0271         StackMinus();
	RCALL _PopCase
	MOV  R30,R13
	COM  R30
	CPI  R30,0
	BREQ _0x24
	MOV  R30,R13
	LDI  R31,0
	SUBI R30,LOW(-_CaseStack)
	SBCI R31,HIGH(-_CaseStack)
	LD   R30,Z
	LDI  R26,LOW(_CaseAddress)
	LDI  R27,HIGH(_CaseAddress)
	LDI  R31,0
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	LD   R2,X+
	LD   R3,X
	MOV    R30, R2
	MOV    R31, R3
	IJMP
	RJMP _0x28
_0x24:
	RET
_0x28:
; 0000 0272 #asm
; 0000 0273 GlcdUnlockLockLabel2:
GlcdUnlockLockLabel2:
; 0000 0274 #endasm
; 0000 0275 GlcdUnlockLockLabel2:
; 0000 0276 #ifdef Debugging
; 0000 0277         DebugDisplay(0x1,'2');
; 0000 0278         while (PINB & 0x01); while (!(PINB & 0x01));
; 0000 0279 #endif
; 0000 027A         set_en;
	LDS  R26,_glcd_en_address_G000
	LDS  R27,_glcd_en_address_G000+1
	MOV  R22,R26
	LD   R1,X
	LDS  R30,_glcd_en_bit_pos_G000
	LDI  R26,LOW(1)
	CALL __LSLB12
	OR   R30,R1
	MOV  R26,R22
	ST   X,R30
; 0000 027B         StackPlus(GlcdUnlockLockCase3,DelayLabel1);
	MOV  R30,R13
	LDI  R31,0
	SUBI R30,LOW(-_CaseStack)
	SBCI R31,HIGH(-_CaseStack)
	LDI  R26,LOW(4)
	STD  Z+0,R26
	INC  R13
	RJMP _0x1F
; 0000 027C #asm
; 0000 027D GlcdUnlockLockLabel1:
GlcdUnlockLockLabel1:
; 0000 027E #endasm
; 0000 027F GlcdUnlockLockLabel1:
_0x2D:
; 0000 0280 #ifdef Debugging
; 0000 0281         DebugDisplay(0x1,'1');
; 0000 0282         while (PINB & 0x01); while (!(PINB & 0x01));
; 0000 0283 #endif
; 0000 0284         (*set_delay_7us)();
	MOVW R30,R8
	ICALL
; 0000 0285         StackPlus(GlcdUnlockLockCase2,DelayLabel1);
	MOV  R30,R13
	LDI  R31,0
	SUBI R30,LOW(-_CaseStack)
	SBCI R31,HIGH(-_CaseStack)
	LDI  R26,LOW(3)
	STD  Z+0,R26
	INC  R13
	RJMP _0x1F
; 0000 0286 #asm
; 0000 0287 GlcdInitLabel8:
GlcdInitLabel8:
; 0000 0288 #endasm
; 0000 0289 GlcdInitLabel8:
; 0000 028A #ifdef Debugging
; 0000 028B         DebugDisplay(0x2,'8');
; 0000 028C         while (PINB & 0x01); while (!(PINB & 0x01));
; 0000 028D #endif
; 0000 028E         StackMinus();
	CALL _PopCase
	MOV  R30,R13
	COM  R30
	CPI  R30,0
	BREQ _0x35
	MOV  R30,R13
	LDI  R31,0
	SUBI R30,LOW(-_CaseStack)
	SBCI R31,HIGH(-_CaseStack)
	LD   R30,Z
	LDI  R26,LOW(_CaseAddress)
	LDI  R27,HIGH(_CaseAddress)
	LDI  R31,0
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	LD   R2,X+
	LD   R3,X
	MOV    R30, R2
	MOV    R31, R3
	IJMP
	RJMP _0x39
_0x35:
	RET
_0x39:
; 0000 028F #asm
; 0000 0290 GlcdInitLabel7:
GlcdInitLabel7:
; 0000 0291 #endasm
; 0000 0292 GlcdInitLabel7:
; 0000 0293 #ifdef Debugging
; 0000 0294         DebugDisplay(0x2,'7');
; 0000 0295         while (PINB & 0x01); while (!(PINB & 0x01));
; 0000 0296 #endif
; 0000 0297         tgl_cs1;
	LDS  R26,_glcd_cs1_address_G000
	LDS  R27,_glcd_cs1_address_G000+1
	MOV  R22,R26
	LD   R1,X
	LDS  R30,_glcd_cs1_bit_pos_G000
	LDI  R26,LOW(1)
	CALL __LSLB12
	EOR  R30,R1
	MOV  R26,R22
	ST   X,R30
; 0000 0298         tgl_cs2;
	LDS  R26,_glcd_cs2_address_G000
	LDS  R27,_glcd_cs2_address_G000+1
	MOV  R22,R26
	LD   R1,X
	LDS  R30,_glcd_cs2_bit_pos_G000
	LDI  R26,LOW(1)
	CALL __LSLB12
	EOR  R30,R1
	MOV  R26,R22
	ST   X,R30
; 0000 0299         *glcd_data_address = 0x3E;
	LDS  R26,_glcd_data_address_G000
	LDS  R27,_glcd_data_address_G000+1
	LDI  R30,LOW(62)
	ST   X,R30
; 0000 029A         StackPlus(GlcdInitCase4,GlcdUnlockLockLabel1);
	MOV  R30,R13
	LDI  R31,0
	SUBI R30,LOW(-_CaseStack)
	SBCI R31,HIGH(-_CaseStack)
	LDI  R26,LOW(8)
	STD  Z+0,R26
	INC  R13
	RJMP _0x2D
; 0000 029B #asm
; 0000 029C GlcdInitLabel6:
GlcdInitLabel6:
; 0000 029D #endasm
; 0000 029E GlcdInitLabel6:
; 0000 029F #ifdef Debugging
; 0000 02A0         DebugDisplay(0x2,'6');
; 0000 02A1         while (PINB & 0x01); while (!(PINB & 0x01));
; 0000 02A2 #endif
; 0000 02A3         *glcd_data_address = 0x3F;
	LDS  R26,_glcd_data_address_G000
	LDS  R27,_glcd_data_address_G000+1
	LDI  R30,LOW(63)
	ST   X,R30
; 0000 02A4         i++;
	LDS  R30,_i_S0000005000
	SUBI R30,-LOW(1)
	STS  _i_S0000005000,R30
; 0000 02A5         if (i < 2)
	LDS  R26,_i_S0000005000
	CPI  R26,LOW(0x2)
	BRSH _0x3F
; 0000 02A6             SetCurrentCase(GlcdInitCase7);
	MOV  R30,R13
	LDI  R31,0
	SUBI R30,LOW(-_CaseStack)
	SBCI R31,HIGH(-_CaseStack)
	LDI  R26,LOW(11)
	RJMP _0x14D
; 0000 02A7         else
_0x3F:
; 0000 02A8             SetCurrentCase(GlcdInitCase8);
	MOV  R30,R13
	LDI  R31,0
	SUBI R30,LOW(-_CaseStack)
	SBCI R31,HIGH(-_CaseStack)
	LDI  R26,LOW(12)
_0x14D:
	STD  Z+0,R26
; 0000 02A9         StackPointer++;
	INC  R13
; 0000 02AA         #asm("JMP GlcdUnlockLockLabel1")
	JMP GlcdUnlockLockLabel1
; 0000 02AB #asm
; 0000 02AC GlcdInitLabel5:
GlcdInitLabel5:
; 0000 02AD #endasm
; 0000 02AE GlcdInitLabel5:
; 0000 02AF #ifdef Debugging
; 0000 02B0         DebugDisplay(0x2,'5');
; 0000 02B1         while (PINB & 0x01); while (!(PINB & 0x01));
; 0000 02B2 #endif
; 0000 02B3         *glcd_data_address = 0xB8;
	LDS  R26,_glcd_data_address_G000
	LDS  R27,_glcd_data_address_G000+1
	LDI  R30,LOW(184)
	ST   X,R30
; 0000 02B4         StackPlus(GlcdInitCase6,GlcdUnlockLockLabel1);
	MOV  R30,R13
	LDI  R31,0
	SUBI R30,LOW(-_CaseStack)
	SBCI R31,HIGH(-_CaseStack)
	LDI  R26,LOW(10)
	STD  Z+0,R26
	INC  R13
	RJMP _0x2D
; 0000 02B5 #asm
; 0000 02B6 GlcdInitLabel4:
GlcdInitLabel4:
; 0000 02B7 #endasm
; 0000 02B8 GlcdInitLabel4:
; 0000 02B9 #ifdef Debugging
; 0000 02BA         DebugDisplay(0x2,'4');
; 0000 02BB         while (PINB & 0x01); while (!(PINB & 0x01));
; 0000 02BC #endif
; 0000 02BD         *glcd_data_address = 0x40;
	LDS  R26,_glcd_data_address_G000
	LDS  R27,_glcd_data_address_G000+1
	LDI  R30,LOW(64)
	ST   X,R30
; 0000 02BE         StackPlus(GlcdInitCase5,GlcdUnlockLockLabel1);
	MOV  R30,R13
	LDI  R31,0
	SUBI R30,LOW(-_CaseStack)
	SBCI R31,HIGH(-_CaseStack)
	LDI  R26,LOW(9)
	STD  Z+0,R26
	INC  R13
	RJMP _0x2D
; 0000 02BF #asm
; 0000 02C0 GlcdInitLabel3:
GlcdInitLabel3:
; 0000 02C1 #endasm
; 0000 02C2 GlcdInitLabel3:
; 0000 02C3 #ifdef Debugging
; 0000 02C4         DebugDisplay(0x2,'3');
; 0000 02C5         while (PINB & 0x01); while (!(PINB & 0x01));
; 0000 02C6 #endif
; 0000 02C7         clr_rs;
	LDS  R26,_glcd_rs_address_G000
	LDS  R27,_glcd_rs_address_G000+1
	MOV  R22,R26
	LD   R1,X
	LDS  R30,_glcd_rs_bit_pos_G000
	LDI  R26,LOW(1)
	CALL __LSLB12
	COM  R30
	AND  R30,R1
	MOV  R26,R22
	ST   X,R30
; 0000 02C8         clr_cs1;
	LDS  R26,_glcd_cs1_address_G000
	LDS  R27,_glcd_cs1_address_G000+1
	MOV  R22,R26
	LD   R1,X
	LDS  R30,_glcd_cs1_bit_pos_G000
	LDI  R26,LOW(1)
	CALL __LSLB12
	COM  R30
	AND  R30,R1
	MOV  R26,R22
	ST   X,R30
; 0000 02C9         set_cs2;
	LDS  R26,_glcd_cs2_address_G000
	LDS  R27,_glcd_cs2_address_G000+1
	MOV  R22,R26
	LD   R1,X
	LDS  R30,_glcd_cs2_bit_pos_G000
	LDI  R26,LOW(1)
	CALL __LSLB12
	OR   R30,R1
	MOV  R26,R22
	ST   X,R30
; 0000 02CA         *glcd_data_address = 0x3E;
	LDS  R26,_glcd_data_address_G000
	LDS  R27,_glcd_data_address_G000+1
	LDI  R30,LOW(62)
	ST   X,R30
; 0000 02CB         StackPlus(GlcdInitCase4,GlcdUnlockLockLabel1);
	MOV  R30,R13
	LDI  R31,0
	SUBI R30,LOW(-_CaseStack)
	SBCI R31,HIGH(-_CaseStack)
	LDI  R26,LOW(8)
	STD  Z+0,R26
	INC  R13
	RJMP _0x2D
; 0000 02CC #asm
; 0000 02CD GlcdInitLabel2:
GlcdInitLabel2:
; 0000 02CE #endasm
; 0000 02CF GlcdInitLabel2:
; 0000 02D0 #ifdef Debugging
; 0000 02D1         DebugDisplay(0x2,'2');
; 0000 02D2         while (PINB & 0x01); while (!(PINB & 0x01));
; 0000 02D3 #endif
; 0000 02D4         set_rst;
	LDS  R26,_glcd_rst_address_G000
	LDS  R27,_glcd_rst_address_G000+1
	MOV  R22,R26
	LD   R1,X
	LDS  R30,_glcd_rst_bit_pos_G000
	LDI  R26,LOW(1)
	CALL __LSLB12
	OR   R30,R1
	MOV  R26,R22
	ST   X,R30
; 0000 02D5         StackPlus(GlcdInitCase3,DelayLabel1);
	MOV  R30,R13
	LDI  R31,0
	SUBI R30,LOW(-_CaseStack)
	SBCI R31,HIGH(-_CaseStack)
	LDI  R26,LOW(7)
	STD  Z+0,R26
	INC  R13
	JMP  _0x1F
; 0000 02D6 #asm
; 0000 02D7 GlcdInitLabel1:
GlcdInitLabel1:
; 0000 02D8 #endasm
; 0000 02D9 GlcdInitLabel1:
; 0000 02DA         i = 0;
	LDI  R30,LOW(0)
	STS  _i_S0000005000,R30
; 0000 02DB         clr_rst;
	LDS  R26,_glcd_rst_address_G000
	LDS  R27,_glcd_rst_address_G000+1
	MOV  R22,R26
	LD   R1,X
	LDS  R30,_glcd_rst_bit_pos_G000
	LDI  R26,LOW(1)
	CALL __LSLB12
	COM  R30
	AND  R30,R1
	MOV  R26,R22
	ST   X,R30
; 0000 02DC         (*set_delay_10ms)();
	MOVW R30,R10
	ICALL
; 0000 02DD #ifdef Debugging
; 0000 02DE         DebugDisplay(0x2,'1');
; 0000 02DF         while (PINB & 0x01); while (!(PINB & 0x01));
; 0000 02E0 #endif
; 0000 02E1         StackPlus(GlcdInitCase2,DelayLabel1);
	MOV  R30,R13
	LDI  R31,0
	SUBI R30,LOW(-_CaseStack)
	SBCI R31,HIGH(-_CaseStack)
	LDI  R26,LOW(6)
	STD  Z+0,R26
	INC  R13
	JMP  _0x1F
; 0000 02E2 #asm
; 0000 02E3 GlcdWriteByteLabel4:
GlcdWriteByteLabel4:
; 0000 02E4 #endasm
; 0000 02E5 GlcdWriteByteLabel4:
; 0000 02E6 #ifdef Debugging
; 0000 02E7         DebugDisplay(0x3,'4');
; 0000 02E8         while (PINB & 0x01); while (!(PINB & 0x01));
; 0000 02E9 #endif
; 0000 02EA         StackMinus();
	CALL _PopCase
	MOV  R30,R13
	COM  R30
	CPI  R30,0
	BREQ _0x59
	MOV  R30,R13
	LDI  R31,0
	SUBI R30,LOW(-_CaseStack)
	SBCI R31,HIGH(-_CaseStack)
	LD   R30,Z
	LDI  R26,LOW(_CaseAddress)
	LDI  R27,HIGH(_CaseAddress)
	LDI  R31,0
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	LD   R2,X+
	LD   R3,X
	MOV    R30, R2
	MOV    R31, R3
	IJMP
	RJMP _0x5D
_0x59:
	RET
_0x5D:
; 0000 02EB #asm
; 0000 02EC GlcdWriteByteLabel3:
GlcdWriteByteLabel3:
; 0000 02ED #endasm
; 0000 02EE GlcdWriteByteLabel3:
; 0000 02EF #ifdef Debugging
; 0000 02F0         DebugDisplay(0x3,'3');
; 0000 02F1         while (PINB & 0x01); while (!(PINB & 0x01));
; 0000 02F2 #endif
; 0000 02F3         set_rs;
	LDS  R26,_glcd_rs_address_G000
	LDS  R27,_glcd_rs_address_G000+1
	MOV  R22,R26
	LD   R1,X
	LDS  R30,_glcd_rs_bit_pos_G000
	LDI  R26,LOW(1)
	CALL __LSLB12
	OR   R30,R1
	MOV  R26,R22
	ST   X,R30
; 0000 02F4         clr_rw;
	LDS  R26,_glcd_rw_address_G000
	LDS  R27,_glcd_rw_address_G000+1
	MOV  R22,R26
	LD   R1,X
	LDS  R30,_glcd_rw_bit_pos_G000
	LDI  R26,LOW(1)
	CALL __LSLB12
	COM  R30
	AND  R30,R1
	MOV  R26,R22
	ST   X,R30
; 0000 02F5         *glcd_data_address = GlcdDataByte;
	LDS  R30,_GlcdDataByte
	LDS  R26,_glcd_data_address_G000
	LDS  R27,_glcd_data_address_G000+1
	ST   X,R30
; 0000 02F6         StackPlus(GlcdWriteByteCase4,GlcdUnlockLockLabel1);
	MOV  R30,R13
	LDI  R31,0
	SUBI R30,LOW(-_CaseStack)
	SBCI R31,HIGH(-_CaseStack)
	LDI  R26,LOW(16)
	STD  Z+0,R26
	INC  R13
	JMP  _0x2D
; 0000 02F7 #asm
; 0000 02F8 GlcdWriteByteLabel2:
GlcdWriteByteLabel2:
; 0000 02F9 #endasm
; 0000 02FA GlcdWriteByteLabel2:
; 0000 02FB #ifdef Debugging
; 0000 02FC         DebugDisplay(0x3,'2');
; 0000 02FD         while (PINB & 0x01); while (!(PINB & 0x01));
; 0000 02FE #endif
; 0000 02FF         clr_rs;
	LDS  R26,_glcd_rs_address_G000
	LDS  R27,_glcd_rs_address_G000+1
	MOV  R22,R26
	LD   R1,X
	LDS  R30,_glcd_rs_bit_pos_G000
	LDI  R26,LOW(1)
	CALL __LSLB12
	COM  R30
	AND  R30,R1
	MOV  R26,R22
	ST   X,R30
; 0000 0300         clr_rw;
	LDS  R26,_glcd_rw_address_G000
	LDS  R27,_glcd_rw_address_G000+1
	MOV  R22,R26
	LD   R1,X
	LDS  R30,_glcd_rw_bit_pos_G000
	LDI  R26,LOW(1)
	CALL __LSLB12
	COM  R30
	AND  R30,R1
	MOV  R26,R22
	ST   X,R30
; 0000 0301         *glcd_data_address = 0x40 | GlcdColumn;
	LDS  R30,_GlcdColumn
	ORI  R30,0x40
	LDS  R26,_glcd_data_address_G000
	LDS  R27,_glcd_data_address_G000+1
	ST   X,R30
; 0000 0302         StackPlus(GlcdWriteByteCase3,GlcdUnlockLockLabel1);
	MOV  R30,R13
	LDI  R31,0
	SUBI R30,LOW(-_CaseStack)
	SBCI R31,HIGH(-_CaseStack)
	LDI  R26,LOW(15)
	STD  Z+0,R26
	INC  R13
	JMP  _0x2D
; 0000 0303 #asm
; 0000 0304 GlcdWriteByteLabel1:
GlcdWriteByteLabel1:
; 0000 0305 #endasm
; 0000 0306 GlcdWriteByteLabel1:
_0x66:
; 0000 0307 #ifdef Debugging
; 0000 0308         DebugDisplay(0x3,'1');
; 0000 0309         while (PINB & 0x01); while (!(PINB & 0x01));
; 0000 030A #endif
; 0000 030B         if(GlcdColumn >= 64)
	LDS  R26,_GlcdColumn
	CPI  R26,LOW(0x40)
	BRLO _0x67
; 0000 030C         {
; 0000 030D             clr_cs1;
	LDS  R26,_glcd_cs1_address_G000
	LDS  R27,_glcd_cs1_address_G000+1
	MOV  R22,R26
	LD   R1,X
	LDS  R30,_glcd_cs1_bit_pos_G000
	LDI  R26,LOW(1)
	CALL __LSLB12
	COM  R30
	AND  R30,R1
	MOV  R26,R22
	ST   X,R30
; 0000 030E             set_cs2;
	LDS  R26,_glcd_cs2_address_G000
	LDS  R27,_glcd_cs2_address_G000+1
	MOV  R22,R26
	LD   R1,X
	LDS  R30,_glcd_cs2_bit_pos_G000
	LDI  R26,LOW(1)
	CALL __LSLB12
	OR   R30,R1
	RJMP _0x14E
; 0000 030F         }
; 0000 0310         else
_0x67:
; 0000 0311         {
; 0000 0312             set_cs1;
	LDS  R26,_glcd_cs1_address_G000
	LDS  R27,_glcd_cs1_address_G000+1
	MOV  R22,R26
	LD   R1,X
	LDS  R30,_glcd_cs1_bit_pos_G000
	LDI  R26,LOW(1)
	CALL __LSLB12
	OR   R30,R1
	MOV  R26,R22
	ST   X,R30
; 0000 0313             clr_cs2;
	LDS  R26,_glcd_cs2_address_G000
	LDS  R27,_glcd_cs2_address_G000+1
	MOV  R22,R26
	LD   R1,X
	LDS  R30,_glcd_cs2_bit_pos_G000
	LDI  R26,LOW(1)
	CALL __LSLB12
	COM  R30
	AND  R30,R1
_0x14E:
	MOV  R26,R22
	ST   X,R30
; 0000 0314         }
; 0000 0315         clr_rs;
	LDS  R26,_glcd_rs_address_G000
	LDS  R27,_glcd_rs_address_G000+1
	MOV  R22,R26
	LD   R1,X
	LDS  R30,_glcd_rs_bit_pos_G000
	LDI  R26,LOW(1)
	CALL __LSLB12
	COM  R30
	AND  R30,R1
	MOV  R26,R22
	ST   X,R30
; 0000 0316         clr_rw;
	LDS  R26,_glcd_rw_address_G000
	LDS  R27,_glcd_rw_address_G000+1
	MOV  R22,R26
	LD   R1,X
	LDS  R30,_glcd_rw_bit_pos_G000
	LDI  R26,LOW(1)
	CALL __LSLB12
	COM  R30
	AND  R30,R1
	MOV  R26,R22
	ST   X,R30
; 0000 0317         *glcd_data_address = 0xB8 | GlcdPage;
	MOV  R30,R12
	ORI  R30,LOW(0xB8)
	LDS  R26,_glcd_data_address_G000
	LDS  R27,_glcd_data_address_G000+1
	ST   X,R30
; 0000 0318         StackPlus(GlcdWriteByteCase2,GlcdUnlockLockLabel1);
	MOV  R30,R13
	LDI  R31,0
	SUBI R30,LOW(-_CaseStack)
	SBCI R31,HIGH(-_CaseStack)
	LDI  R26,LOW(14)
	STD  Z+0,R26
	INC  R13
	JMP  _0x2D
; 0000 0319 #asm
; 0000 031A GlcdClearPageLabel2:
GlcdClearPageLabel2:
; 0000 031B #endasm
; 0000 031C GlcdClearPageLabel2:
; 0000 031D #ifdef Debugging
; 0000 031E         DebugDisplay(0x4,'2');
; 0000 031F         while (PINB & 0x01); while (!(PINB & 0x01));
; 0000 0320 #endif
; 0000 0321         GlcdColumn++;
	LDS  R30,_GlcdColumn
	SUBI R30,-LOW(1)
	STS  _GlcdColumn,R30
; 0000 0322         if (GlcdColumn < 128)
	LDS  R26,_GlcdColumn
	CPI  R26,LOW(0x80)
	BRSH _0x6D
; 0000 0323             StackPlus(GlcdClearPageCase2,GlcdWriteByteLabel1);
	MOV  R30,R13
	LDI  R31,0
	SUBI R30,LOW(-_CaseStack)
	SBCI R31,HIGH(-_CaseStack)
	LDI  R26,LOW(18)
	STD  Z+0,R26
	INC  R13
	RJMP _0x66
; 0000 0324         else
_0x6D:
; 0000 0325         {
; 0000 0326             StackMinus();
	CALL _PopCase
	MOV  R30,R13
	COM  R30
	CPI  R30,0
	BREQ _0x75
	MOV  R30,R13
	LDI  R31,0
	SUBI R30,LOW(-_CaseStack)
	SBCI R31,HIGH(-_CaseStack)
	LD   R30,Z
	LDI  R26,LOW(_CaseAddress)
	LDI  R27,HIGH(_CaseAddress)
	LDI  R31,0
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	LD   R2,X+
	LD   R3,X
	MOV    R30, R2
	MOV    R31, R3
	IJMP
	RJMP _0x79
_0x75:
	RET
_0x79:
; 0000 0327         }
; 0000 0328 #asm
; 0000 0329 GlcdClearPageLabel1:
GlcdClearPageLabel1:
; 0000 032A #endasm
; 0000 032B GlcdClearPageLabel1:
; 0000 032C #ifdef Debugging
; 0000 032D         DebugDisplay(0x4,'1');
; 0000 032E         while (PINB & 0x01); while (!(PINB & 0x01));
; 0000 032F #endif
; 0000 0330         GlcdColumn = 0;
	LDI  R30,LOW(0)
	STS  _GlcdColumn,R30
; 0000 0331         GlcdDataByte = 0x00;
	STS  _GlcdDataByte,R30
; 0000 0332         StackPlus(GlcdClearPageCase2,GlcdWriteByteLabel1);
	MOV  R30,R13
	LDI  R31,0
	SUBI R30,LOW(-_CaseStack)
	SBCI R31,HIGH(-_CaseStack)
	LDI  R26,LOW(18)
	STD  Z+0,R26
	INC  R13
	RJMP _0x66
; 0000 0333 #asm
; 0000 0334 GlcdPutcharLabel2:
GlcdPutcharLabel2:
; 0000 0335 #endasm
; 0000 0336 GlcdPutcharLabel2:
; 0000 0337 #ifdef Debugging
; 0000 0338         DebugDisplay(0x5,'2');
; 0000 0339         while (PINB & 0x01); while (!(PINB & 0x01));
; 0000 033A #endif
; 0000 033B         if (++i < 6)
	LDS  R26,_i_S0000005000
	SUBI R26,-LOW(1)
	STS  _i_S0000005000,R26
	CPI  R26,LOW(0x6)
	BRSH _0x7F
; 0000 033C         {
; 0000 033D             GlcdDataByte = glcd_font[GlcdChar][i];
	LDS  R30,_GlcdChar
	LDI  R26,LOW(6)
	MUL  R30,R26
	MOVW R30,R0
	SUBI R30,LOW(-_glcd_font*2)
	SBCI R31,HIGH(-_glcd_font*2)
	MOVW R26,R30
	LDS  R30,_i_S0000005000
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	LPM  R0,Z
	STS  _GlcdDataByte,R0
; 0000 033E             GlcdColumn++;
	LDS  R30,_GlcdColumn
	SUBI R30,-LOW(1)
	STS  _GlcdColumn,R30
; 0000 033F             StackPlus(GlcdPutcharCase2,GlcdWriteByteLabel1);
	MOV  R30,R13
	LDI  R31,0
	SUBI R30,LOW(-_CaseStack)
	SBCI R31,HIGH(-_CaseStack)
	LDI  R26,LOW(20)
	STD  Z+0,R26
	INC  R13
	RJMP _0x66
; 0000 0340         }
; 0000 0341         else
_0x7F:
; 0000 0342         {
; 0000 0343             StackMinus();
	CALL _PopCase
	MOV  R30,R13
	COM  R30
	CPI  R30,0
	BREQ _0x87
	MOV  R30,R13
	LDI  R31,0
	SUBI R30,LOW(-_CaseStack)
	SBCI R31,HIGH(-_CaseStack)
	LD   R30,Z
	LDI  R26,LOW(_CaseAddress)
	LDI  R27,HIGH(_CaseAddress)
	LDI  R31,0
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	LD   R2,X+
	LD   R3,X
	MOV    R30, R2
	MOV    R31, R3
	IJMP
	RJMP _0x8B
_0x87:
	RET
_0x8B:
; 0000 0344         }
; 0000 0345 #asm
; 0000 0346 GlcdPutcharLabel1:
GlcdPutcharLabel1:
; 0000 0347 #endasm
; 0000 0348 GlcdPutcharLabel1:
_0x8C:
; 0000 0349 #ifdef Debugging
; 0000 034A         DebugDisplay(0x5,'1');
; 0000 034B         while (PINB & 0x01); while (!(PINB & 0x01));
; 0000 034C #endif
; 0000 034D         i = 0;
	LDI  R30,LOW(0)
	STS  _i_S0000005000,R30
; 0000 034E         GlcdChar -= 0x20;
	LDS  R30,_GlcdChar
	LDI  R31,0
	SBIW R30,32
	STS  _GlcdChar,R30
; 0000 034F         GlcdDataByte = glcd_font[GlcdChar][0];
	LDI  R26,LOW(6)
	MUL  R30,R26
	MOVW R30,R0
	SUBI R30,LOW(-_glcd_font*2)
	SBCI R31,HIGH(-_glcd_font*2)
	LPM  R0,Z
	STS  _GlcdDataByte,R0
; 0000 0350         StackPlus(GlcdPutcharCase2,GlcdWriteByteLabel1);
	MOV  R30,R13
	LDI  R31,0
	SUBI R30,LOW(-_CaseStack)
	SBCI R31,HIGH(-_CaseStack)
	LDI  R26,LOW(20)
	STD  Z+0,R26
	INC  R13
	RJMP _0x66
; 0000 0351 #asm
; 0000 0352 GlcdPutsLabel2:
GlcdPutsLabel2:
; 0000 0353 #endasm
; 0000 0354 GlcdPutsLabel2:
; 0000 0355 #ifdef Debugging
; 0000 0356         DebugDisplay(0x6,'2');
; 0000 0357         while (PINB & 0x01); while (!(PINB & 0x01));
; 0000 0358 #endif
; 0000 0359         if (*GlcdString)
	LDS  R26,_GlcdString
	LDS  R27,_GlcdString+1
	LD   R30,X
	CPI  R30,0
	BREQ _0x91
; 0000 035A         {
; 0000 035B             GlcdColumn++;
	LDS  R30,_GlcdColumn
	SUBI R30,-LOW(1)
	STS  _GlcdColumn,R30
; 0000 035C             GlcdChar = *GlcdString++;
	LDI  R26,LOW(_GlcdString)
	LDI  R27,HIGH(_GlcdString)
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
	SBIW R30,1
	LD   R30,Z
	STS  _GlcdChar,R30
; 0000 035D             StackPlus(GlcdPutsCase2,GlcdPutcharLabel1);
	MOV  R30,R13
	LDI  R31,0
	SUBI R30,LOW(-_CaseStack)
	SBCI R31,HIGH(-_CaseStack)
	LDI  R26,LOW(22)
	STD  Z+0,R26
	INC  R13
	RJMP _0x8C
; 0000 035E         }
; 0000 035F         else
_0x91:
; 0000 0360         {
; 0000 0361             StackMinus();
	CALL _PopCase
	MOV  R30,R13
	COM  R30
	CPI  R30,0
	BREQ _0x99
	MOV  R30,R13
	LDI  R31,0
	SUBI R30,LOW(-_CaseStack)
	SBCI R31,HIGH(-_CaseStack)
	LD   R30,Z
	LDI  R26,LOW(_CaseAddress)
	LDI  R27,HIGH(_CaseAddress)
	LDI  R31,0
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	LD   R2,X+
	LD   R3,X
	MOV    R30, R2
	MOV    R31, R3
	IJMP
	RJMP _0x9D
_0x99:
	RET
_0x9D:
; 0000 0362         }
; 0000 0363 #asm
; 0000 0364 GlcdPutsLabel1:
GlcdPutsLabel1:
; 0000 0365 #endasm
; 0000 0366 GlcdPutsLabel1:
_0x9E:
; 0000 0367 #ifdef Debugging
; 0000 0368         DebugDisplay(0x6,'1');
; 0000 0369         while (PINB & 0x01); while (!(PINB & 0x01));
; 0000 036A #endif
; 0000 036B         if (*GlcdString)
	LDS  R26,_GlcdString
	LDS  R27,_GlcdString+1
	LD   R30,X
	CPI  R30,0
	BREQ _0x9F
; 0000 036C         {
; 0000 036D             GlcdChar = *GlcdString++;
	LDI  R26,LOW(_GlcdString)
	LDI  R27,HIGH(_GlcdString)
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
	SBIW R30,1
	LD   R30,Z
	STS  _GlcdChar,R30
; 0000 036E             StackPlus(GlcdPutsCase2,GlcdPutcharLabel1);
	MOV  R30,R13
	LDI  R31,0
	SUBI R30,LOW(-_CaseStack)
	SBCI R31,HIGH(-_CaseStack)
	LDI  R26,LOW(22)
	STD  Z+0,R26
	INC  R13
	RJMP _0x8C
; 0000 036F         }
; 0000 0370         else
_0x9F:
; 0000 0371         {
; 0000 0372             StackMinus();
	CALL _PopCase
	MOV  R30,R13
	COM  R30
	CPI  R30,0
	BREQ _0xA7
	MOV  R30,R13
	LDI  R31,0
	SUBI R30,LOW(-_CaseStack)
	SBCI R31,HIGH(-_CaseStack)
	LD   R30,Z
	LDI  R26,LOW(_CaseAddress)
	LDI  R27,HIGH(_CaseAddress)
	LDI  R31,0
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	LD   R2,X+
	LD   R3,X
	MOV    R30, R2
	MOV    R31, R3
	IJMP
	RJMP _0xAB
_0xA7:
	RET
_0xAB:
; 0000 0373         }
; 0000 0374 #asm
; 0000 0375 GlcdPutsCenterLabel2:
GlcdPutsCenterLabel2:
; 0000 0376 #endasm
; 0000 0377 GlcdPutsCenterLabel2:
; 0000 0378 #ifdef Debugging
; 0000 0379         DebugDisplay(0x7,'2');
; 0000 037A         while (PINB & 0x01); while (!(PINB & 0x01));
; 0000 037B #endif
; 0000 037C         StackMinus();
	CALL _PopCase
	MOV  R30,R13
	COM  R30
	CPI  R30,0
	BREQ _0xB0
	MOV  R30,R13
	LDI  R31,0
	SUBI R30,LOW(-_CaseStack)
	SBCI R31,HIGH(-_CaseStack)
	LD   R30,Z
	LDI  R26,LOW(_CaseAddress)
	LDI  R27,HIGH(_CaseAddress)
	LDI  R31,0
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	LD   R2,X+
	LD   R3,X
	MOV    R30, R2
	MOV    R31, R3
	IJMP
	RJMP _0xB4
_0xB0:
	RET
_0xB4:
; 0000 037D #asm
; 0000 037E GlcdPutsCenterLabel1:
GlcdPutsCenterLabel1:
; 0000 037F #endasm
; 0000 0380 GlcdPutsCenterLabel1:
; 0000 0381 #ifdef Debugging
; 0000 0382         DebugDisplay(0x7,'1');
; 0000 0383         while (PINB & 0x01); while (!(PINB & 0x01));
; 0000 0384 #endif
; 0000 0385         i = strlen_char(GlcdString);
	LDS  R30,_GlcdString
	LDS  R31,_GlcdString+1
	ST   -Y,R31
	ST   -Y,R30
	CALL _strlen_char
	STS  _i_S0000005000,R30
; 0000 0386         i = i * 6;
	LDI  R26,LOW(6)
	MULS R30,R26
	MOVW R30,R0
	STS  _i_S0000005000,R30
; 0000 0387         i = 128 - i;
	LDI  R31,0
	LDI  R26,LOW(128)
	LDI  R27,HIGH(128)
	CALL __SWAPW12
	SUB  R30,R26
	SBC  R31,R27
	STS  _i_S0000005000,R30
; 0000 0388         GlcdColumn = i / 2;
	LDS  R26,_i_S0000005000
	LDI  R27,0
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	CALL __DIVW21
	STS  _GlcdColumn,R30
; 0000 0389         StackPlus(GlcdPutsCenterCase2,GlcdPutsLabel1);
	MOV  R30,R13
	LDI  R31,0
	SUBI R30,LOW(-_CaseStack)
	SBCI R31,HIGH(-_CaseStack)
	LDI  R26,LOW(24)
	STD  Z+0,R26
	INC  R13
	RJMP _0x9E
; 0000 038A #asm
; 0000 038B GlcdPutsfLabel2:
GlcdPutsfLabel2:
; 0000 038C #endasm
; 0000 038D GlcdPutsfLabel2:
; 0000 038E #ifdef Debugging
; 0000 038F         DebugDisplay(0x8,'2');
; 0000 0390         while (PINB & 0x01); while (!(PINB & 0x01));
; 0000 0391 #endif
; 0000 0392         if (*GlcdFlashString)
	LDS  R30,_GlcdFlashString
	LDS  R31,_GlcdFlashString+1
	LPM  R30,Z
	CPI  R30,0
	BREQ _0xBA
; 0000 0393         {
; 0000 0394             GlcdColumn++;
	LDS  R30,_GlcdColumn
	SUBI R30,-LOW(1)
	STS  _GlcdColumn,R30
; 0000 0395             GlcdChar = *GlcdFlashString++;
	LDI  R26,LOW(_GlcdFlashString)
	LDI  R27,HIGH(_GlcdFlashString)
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
	SBIW R30,1
	LPM  R0,Z
	STS  _GlcdChar,R0
; 0000 0396             StackPlus(GlcdPutsfCase2,GlcdPutcharLabel1);
	MOV  R30,R13
	LDI  R31,0
	SUBI R30,LOW(-_CaseStack)
	SBCI R31,HIGH(-_CaseStack)
	LDI  R26,LOW(26)
	STD  Z+0,R26
	INC  R13
	JMP  _0x8C
; 0000 0397         }
; 0000 0398         else
_0xBA:
; 0000 0399         {
; 0000 039A             StackMinus();
	CALL _PopCase
	MOV  R30,R13
	COM  R30
	CPI  R30,0
	BREQ _0xC2
	MOV  R30,R13
	LDI  R31,0
	SUBI R30,LOW(-_CaseStack)
	SBCI R31,HIGH(-_CaseStack)
	LD   R30,Z
	LDI  R26,LOW(_CaseAddress)
	LDI  R27,HIGH(_CaseAddress)
	LDI  R31,0
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	LD   R2,X+
	LD   R3,X
	MOV    R30, R2
	MOV    R31, R3
	IJMP
	RJMP _0xC6
_0xC2:
	RET
_0xC6:
; 0000 039B         }
; 0000 039C #asm
; 0000 039D GlcdPutsfLabel1:
GlcdPutsfLabel1:
; 0000 039E #endasm
; 0000 039F GlcdPutsfLabel1:
_0xC7:
; 0000 03A0 #ifdef Debugging
; 0000 03A1         DebugDisplay(0x8,'1');
; 0000 03A2         while (PINB & 0x01); while (!(PINB & 0x01));
; 0000 03A3 #endif
; 0000 03A4         if (*GlcdFlashString)
	LDS  R30,_GlcdFlashString
	LDS  R31,_GlcdFlashString+1
	LPM  R30,Z
	CPI  R30,0
	BREQ _0xC8
; 0000 03A5         {
; 0000 03A6             GlcdChar = *GlcdFlashString++;
	LDI  R26,LOW(_GlcdFlashString)
	LDI  R27,HIGH(_GlcdFlashString)
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
	SBIW R30,1
	LPM  R0,Z
	STS  _GlcdChar,R0
; 0000 03A7             StackPlus(GlcdPutsfCase2,GlcdPutcharLabel1);
	MOV  R30,R13
	LDI  R31,0
	SUBI R30,LOW(-_CaseStack)
	SBCI R31,HIGH(-_CaseStack)
	LDI  R26,LOW(26)
	STD  Z+0,R26
	INC  R13
	JMP  _0x8C
; 0000 03A8         }
; 0000 03A9         else
_0xC8:
; 0000 03AA         {
; 0000 03AB             StackMinus();
	CALL _PopCase
	MOV  R30,R13
	COM  R30
	CPI  R30,0
	BREQ _0xD0
	MOV  R30,R13
	LDI  R31,0
	SUBI R30,LOW(-_CaseStack)
	SBCI R31,HIGH(-_CaseStack)
	LD   R30,Z
	LDI  R26,LOW(_CaseAddress)
	LDI  R27,HIGH(_CaseAddress)
	LDI  R31,0
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	LD   R2,X+
	LD   R3,X
	MOV    R30, R2
	MOV    R31, R3
	IJMP
	RJMP _0xD4
_0xD0:
	RET
_0xD4:
; 0000 03AC         }
; 0000 03AD #asm
; 0000 03AE GlcdPutsfCenterLabel2:
GlcdPutsfCenterLabel2:
; 0000 03AF #endasm
; 0000 03B0 GlcdPutsfCenterLabel2:
; 0000 03B1 #ifdef Debugging
; 0000 03B2         DebugDisplay(0x9,'2');
; 0000 03B3         while (PINB & 0x01); while (!(PINB & 0x01));
; 0000 03B4 #endif
; 0000 03B5         StackMinus();
	CALL _PopCase
	MOV  R30,R13
	COM  R30
	CPI  R30,0
	BREQ _0xD9
	MOV  R30,R13
	LDI  R31,0
	SUBI R30,LOW(-_CaseStack)
	SBCI R31,HIGH(-_CaseStack)
	LD   R30,Z
	LDI  R26,LOW(_CaseAddress)
	LDI  R27,HIGH(_CaseAddress)
	LDI  R31,0
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	LD   R2,X+
	LD   R3,X
	MOV    R30, R2
	MOV    R31, R3
	IJMP
	RJMP _0xDD
_0xD9:
	RET
_0xDD:
; 0000 03B6 #asm
; 0000 03B7 GlcdPutsfCenterLabel1:
GlcdPutsfCenterLabel1:
; 0000 03B8 #endasm
; 0000 03B9 GlcdPutsfCenterLabel1:
; 0000 03BA #ifdef Debugging
; 0000 03BB         DebugDisplay(0x9,'1');
; 0000 03BC         while (PINB & 0x01); while (!(PINB & 0x01));
; 0000 03BD #endif
; 0000 03BE         i = strlenf_char(GlcdFlashString);
	LDS  R30,_GlcdFlashString
	LDS  R31,_GlcdFlashString+1
	ST   -Y,R31
	ST   -Y,R30
	CALL _strlenf_char
	STS  _i_S0000005000,R30
; 0000 03BF         i = i * 6;
	LDI  R26,LOW(6)
	MULS R30,R26
	MOVW R30,R0
	STS  _i_S0000005000,R30
; 0000 03C0         i = 128 - i;
	LDI  R31,0
	LDI  R26,LOW(128)
	LDI  R27,HIGH(128)
	CALL __SWAPW12
	SUB  R30,R26
	SBC  R31,R27
	STS  _i_S0000005000,R30
; 0000 03C1         GlcdColumn = i / 2;
	LDS  R26,_i_S0000005000
	LDI  R27,0
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	CALL __DIVW21
	STS  _GlcdColumn,R30
; 0000 03C2         StackPlus(GlcdPutsfCenterCase2,GlcdPutsfLabel1);
	MOV  R30,R13
	LDI  R31,0
	SUBI R30,LOW(-_CaseStack)
	SBCI R31,HIGH(-_CaseStack)
	LDI  R26,LOW(28)
	STD  Z+0,R26
	INC  R13
	RJMP _0xC7
; 0000 03C3 #asm
; 0000 03C4 GlcdClearLabel2:
GlcdClearLabel2:
; 0000 03C5 #endasm
; 0000 03C6 GlcdClearLabel2:
; 0000 03C7 #ifdef Debugging
; 0000 03C8         DebugDisplay(0xa,'2');
; 0000 03C9         while (PINB & 0x01); while (!(PINB & 0x01));
; 0000 03CA #endif
; 0000 03CB         if (((GlcdPage == 7) && (GlcdColumn < 127)) || (GlcdPage < 7))
	LDI  R30,LOW(7)
	CP   R30,R12
	BRNE _0xE4
	LDS  R26,_GlcdColumn
	CPI  R26,LOW(0x7F)
	BRLO _0xE6
_0xE4:
	LDI  R30,LOW(7)
	CP   R12,R30
	BRSH _0xE3
_0xE6:
; 0000 03CC         {
; 0000 03CD             GlcdColumn++;
	LDS  R30,_GlcdColumn
	SUBI R30,-LOW(1)
	STS  _GlcdColumn,R30
; 0000 03CE             if (GlcdColumn == 128)
	LDS  R26,_GlcdColumn
	CPI  R26,LOW(0x80)
	BRNE _0xE8
; 0000 03CF             {
; 0000 03D0                 GlcdColumn = 0;
	LDI  R30,LOW(0)
	STS  _GlcdColumn,R30
; 0000 03D1                 GlcdPage++;
	INC  R12
; 0000 03D2             }
; 0000 03D3             StackPlus(GlcdClearCase2,GlcdWriteByteLabel1);
_0xE8:
	MOV  R30,R13
	LDI  R31,0
	SUBI R30,LOW(-_CaseStack)
	SBCI R31,HIGH(-_CaseStack)
	LDI  R26,LOW(30)
	STD  Z+0,R26
	INC  R13
	JMP  _0x66
; 0000 03D4         }
; 0000 03D5         else
_0xE3:
; 0000 03D6         {
; 0000 03D7             StackMinus();
	CALL _PopCase
	MOV  R30,R13
	COM  R30
	CPI  R30,0
	BREQ _0xF0
	MOV  R30,R13
	LDI  R31,0
	SUBI R30,LOW(-_CaseStack)
	SBCI R31,HIGH(-_CaseStack)
	LD   R30,Z
	LDI  R26,LOW(_CaseAddress)
	LDI  R27,HIGH(_CaseAddress)
	LDI  R31,0
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	LD   R2,X+
	LD   R3,X
	MOV    R30, R2
	MOV    R31, R3
	IJMP
	RJMP _0xF4
_0xF0:
	RET
_0xF4:
; 0000 03D8         }
; 0000 03D9 #asm
; 0000 03DA GlcdClearLabel1:
GlcdClearLabel1:
; 0000 03DB #endasm
; 0000 03DC GlcdClearLabel1:
; 0000 03DD #ifdef Debugging
; 0000 03DE         DebugDisplay(0xa,'1');
; 0000 03DF         while (PINB & 0x01); while (!(PINB & 0x01));
; 0000 03E0 #endif
; 0000 03E1         GlcdColumn = 0;
	LDI  R30,LOW(0)
	STS  _GlcdColumn,R30
; 0000 03E2         GlcdPage = 0;
	CLR  R12
; 0000 03E3         GlcdDataByte = 0x00;
	STS  _GlcdDataByte,R30
; 0000 03E4         StackPlus(GlcdClearCase2,GlcdWriteByteLabel1);
	MOV  R30,R13
	LDI  R31,0
	SUBI R30,LOW(-_CaseStack)
	SBCI R31,HIGH(-_CaseStack)
	LDI  R26,LOW(30)
	STD  Z+0,R26
	INC  R13
	JMP  _0x66
; 0000 03E5 #asm
; 0000 03E6 GlcdPutbmpLabel2:
GlcdPutbmpLabel2:
; 0000 03E7 #endasm
; 0000 03E8 GlcdPutbmpLabel2:
; 0000 03E9 #ifdef Debugging
; 0000 03EA         DebugDisplay(0xb,'2');
; 0000 03EB         while (PINB & 0x01); while (!(PINB & 0x01));
; 0000 03EC #endif
; 0000 03ED         if (++j < 1024)
	LDI  R26,LOW(_j_S0000005000)
	LDI  R27,HIGH(_j_S0000005000)
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
	CPI  R30,LOW(0x400)
	LDI  R26,HIGH(0x400)
	CPC  R31,R26
	BRSH _0xFA
; 0000 03EE         {
; 0000 03EF             GlcdColumn = ((unsigned char)(j)) & 0x7F;
	LDS  R30,_j_S0000005000
	ANDI R30,0x7F
	STS  _GlcdColumn,R30
; 0000 03F0             GlcdPage = ((unsigned char)(j >> 7));
	LDS  R26,_j_S0000005000
	LDS  R27,_j_S0000005000+1
	LDI  R30,LOW(7)
	CALL __LSRW12
	MOV  R12,R30
; 0000 03F1             GlcdDataByte = *(++GlcdFlashPointer);
	LDI  R26,LOW(_GlcdFlashPointer)
	LDI  R27,HIGH(_GlcdFlashPointer)
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
	LPM  R0,Z
	STS  _GlcdDataByte,R0
; 0000 03F2             StackPlus(GlcdPutbmpCase2,GlcdWriteByteLabel1);
	MOV  R30,R13
	LDI  R31,0
	SUBI R30,LOW(-_CaseStack)
	SBCI R31,HIGH(-_CaseStack)
	LDI  R26,LOW(32)
	STD  Z+0,R26
	INC  R13
	JMP  _0x66
; 0000 03F3         }
; 0000 03F4         else
_0xFA:
; 0000 03F5         {
; 0000 03F6             StackMinus();
	CALL _PopCase
	MOV  R30,R13
	COM  R30
	CPI  R30,0
	BREQ _0x102
	MOV  R30,R13
	LDI  R31,0
	SUBI R30,LOW(-_CaseStack)
	SBCI R31,HIGH(-_CaseStack)
	LD   R30,Z
	LDI  R26,LOW(_CaseAddress)
	LDI  R27,HIGH(_CaseAddress)
	LDI  R31,0
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	LD   R2,X+
	LD   R3,X
	MOV    R30, R2
	MOV    R31, R3
	IJMP
	RJMP _0x106
_0x102:
	RET
_0x106:
; 0000 03F7         }
; 0000 03F8 #asm
; 0000 03F9 GlcdPutbmpLabel1:
GlcdPutbmpLabel1:
; 0000 03FA #endasm
; 0000 03FB GlcdPutbmpLabel1:
; 0000 03FC #ifdef Debugging
; 0000 03FD         DebugDisplay(0xb,'1');
; 0000 03FE         while (PINB & 0x01); while (!(PINB & 0x01));
; 0000 03FF #endif
; 0000 0400         j = 0;
	LDI  R30,LOW(0)
	STS  _j_S0000005000,R30
	STS  _j_S0000005000+1,R30
; 0000 0401         GlcdColumn = 0;
	STS  _GlcdColumn,R30
; 0000 0402         GlcdPage = 0;
	CLR  R12
; 0000 0403         GlcdDataByte = *GlcdFlashPointer;
	LDS  R30,_GlcdFlashPointer
	LDS  R31,_GlcdFlashPointer+1
	LPM  R0,Z
	STS  _GlcdDataByte,R0
; 0000 0404         StackPlus(GlcdPutbmpCase2,GlcdWriteByteLabel1);
	MOV  R30,R13
	LDI  R31,0
	SUBI R30,LOW(-_CaseStack)
	SBCI R31,HIGH(-_CaseStack)
	LDI  R26,LOW(32)
	STD  Z+0,R26
	INC  R13
	JMP  _0x66
; 0000 0405     }
; 0000 0406 }
_0xF:
	RET
;
;
;
;// GLCD initializing function
;void glcd_init (void)
; 0000 040C {
_glcd_init:
; 0000 040D     while (GlcdBusy);
_0x10B:
	MOV  R30,R13
	COM  R30
	CPI  R30,0
	BRNE _0x10B
; 0000 040E     PushCase (GlcdInitCase1);
	LDI  R30,LOW(5)
	RJMP _0x2080005
; 0000 040F     glcd_timer_isr();
; 0000 0410 }
;
;// GLCD write byte in specific column and page function
;void glcd_writebyte (unsigned char column, unsigned char page, unsigned char data)
; 0000 0414 {
; 0000 0415     while (GlcdBusy);
;	column -> Y+2
;	page -> Y+1
;	data -> Y+0
; 0000 0416     GlcdColumn = column;
; 0000 0417     GlcdPage = page;
; 0000 0418     GlcdDataByte = data;
; 0000 0419     PushCase(GlcdWriteByteCase1);
; 0000 041A     glcd_timer_isr();
; 0000 041B }
;
;// GLCD clear page function
;void glcd_clear_page (unsigned char page)
; 0000 041F {
; 0000 0420     while (GlcdBusy);
;	page -> Y+0
; 0000 0421     GlcdPage = page;
; 0000 0422     PushCase (GlcdClearPageCase1);
; 0000 0423     glcd_timer_isr();
; 0000 0424 }
;
;// GLCD put character function
;void glcd_putchar (unsigned char column, unsigned char page, unsigned char ch)
; 0000 0428 {
_glcd_putchar:
; 0000 0429     while (GlcdBusy);
;	column -> Y+2
;	page -> Y+1
;	ch -> Y+0
_0x114:
	MOV  R30,R13
	COM  R30
	CPI  R30,0
	BRNE _0x114
; 0000 042A     GlcdColumn = column;
	LDD  R30,Y+2
	STS  _GlcdColumn,R30
; 0000 042B     GlcdPage = page;
	LDD  R12,Y+1
; 0000 042C     GlcdChar = ch;
	LD   R30,Y
	STS  _GlcdChar,R30
; 0000 042D     PushCase(GlcdPutcharCase1);
	LDI  R30,LOW(19)
	ST   -Y,R30
	CALL _PushCase
; 0000 042E     glcd_timer_isr();
	CALL _glcd_timer_isr
; 0000 042F }
	JMP  _0x2080002
;
;// GLCD put string function
;void glcd_puts (unsigned char column, unsigned char page, unsigned char *str)
; 0000 0433 {
_glcd_puts:
; 0000 0434     while (GlcdBusy);
;	column -> Y+3
;	page -> Y+2
;	*str -> Y+0
_0x117:
	MOV  R30,R13
	COM  R30
	CPI  R30,0
	BRNE _0x117
; 0000 0435     GlcdColumn = column;
	LDD  R30,Y+3
	STS  _GlcdColumn,R30
; 0000 0436     GlcdPage = page;
	LDD  R12,Y+2
; 0000 0437     GlcdString = str;
	LD   R30,Y
	LDD  R31,Y+1
	STS  _GlcdString,R30
	STS  _GlcdString+1,R31
; 0000 0438     PushCase(GlcdPutsCase1);
	LDI  R30,LOW(21)
	RJMP _0x2080006
; 0000 0439     glcd_timer_isr();
; 0000 043A }
;
;// GLCD put string in center function
;void glcd_puts_center (unsigned char page, unsigned char *str)
; 0000 043E {
_glcd_puts_center:
; 0000 043F     while (GlcdBusy);
;	page -> Y+2
;	*str -> Y+0
_0x11A:
	MOV  R30,R13
	COM  R30
	CPI  R30,0
	BRNE _0x11A
; 0000 0440     GlcdPage = page;
	LDD  R12,Y+2
; 0000 0441     GlcdString = str;
	LD   R30,Y
	LDD  R31,Y+1
	STS  _GlcdString,R30
	STS  _GlcdString+1,R31
; 0000 0442     PushCase(GlcdPutsCenterCase1);
	LDI  R30,LOW(23)
	ST   -Y,R30
	CALL _PushCase
; 0000 0443     glcd_timer_isr();
	CALL _glcd_timer_isr
; 0000 0444 }
	JMP  _0x2080002
;
;// GLCD put flash string function
;void glcd_putsf (unsigned char column, unsigned char page, flash unsigned char *str)
; 0000 0448 {
_glcd_putsf:
; 0000 0449     while (GlcdBusy);
;	column -> Y+3
;	page -> Y+2
;	*str -> Y+0
_0x11D:
	MOV  R30,R13
	COM  R30
	CPI  R30,0
	BRNE _0x11D
; 0000 044A     GlcdColumn = column;
	LDD  R30,Y+3
	STS  _GlcdColumn,R30
; 0000 044B     GlcdPage = page;
	LDD  R12,Y+2
; 0000 044C     GlcdFlashString = str;
	LD   R30,Y
	LDD  R31,Y+1
	STS  _GlcdFlashString,R30
	STS  _GlcdFlashString+1,R31
; 0000 044D     PushCase(GlcdPutsfCase1);
	LDI  R30,LOW(25)
_0x2080006:
	ST   -Y,R30
	CALL _PushCase
; 0000 044E     glcd_timer_isr();
	CALL _glcd_timer_isr
; 0000 044F }
	ADIW R28,4
	RET
;
;// GLCD put flash string in center function
;void glcd_putsf_center (unsigned char page, flash unsigned char *str)
; 0000 0453 {
_glcd_putsf_center:
; 0000 0454     while (GlcdBusy);
;	page -> Y+2
;	*str -> Y+0
_0x120:
	MOV  R30,R13
	COM  R30
	CPI  R30,0
	BRNE _0x120
; 0000 0455     GlcdPage = page;
	LDD  R12,Y+2
; 0000 0456     GlcdFlashString = str;
	LD   R30,Y
	LDD  R31,Y+1
	STS  _GlcdFlashString,R30
	STS  _GlcdFlashString+1,R31
; 0000 0457     PushCase(GlcdPutsfCenterCase1);
	LDI  R30,LOW(27)
	ST   -Y,R30
	CALL _PushCase
; 0000 0458     glcd_timer_isr();
	CALL _glcd_timer_isr
; 0000 0459 }
	JMP  _0x2080002
;
;// GLCD clear function
;void glcd_clear (void)
; 0000 045D {
_glcd_clear:
; 0000 045E     while (GlcdBusy);
_0x123:
	MOV  R30,R13
	COM  R30
	CPI  R30,0
	BRNE _0x123
; 0000 045F     PushCase(GlcdClearCase1);
	LDI  R30,LOW(29)
_0x2080005:
	ST   -Y,R30
	CALL _PushCase
; 0000 0460     glcd_timer_isr();
	CALL _glcd_timer_isr
; 0000 0461 }
	RET
;
;// GLCD put bitmap function
;void glcd_putbmp (flash unsigned char *bmp)
; 0000 0465 {
_glcd_putbmp:
; 0000 0466     while (GlcdBusy);
;	*bmp -> Y+0
_0x126:
	MOV  R30,R13
	COM  R30
	CPI  R30,0
	BRNE _0x126
; 0000 0467     GlcdFlashPointer = bmp;
	LD   R30,Y
	LDD  R31,Y+1
	STS  _GlcdFlashPointer,R30
	STS  _GlcdFlashPointer+1,R31
; 0000 0468     PushCase(GlcdPutbmpCase1);
	LDI  R30,LOW(31)
	ST   -Y,R30
	CALL _PushCase
; 0000 0469     glcd_timer_isr();
	CALL _glcd_timer_isr
; 0000 046A }
	JMP  _0x2080003
;
;/////////////////////////////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////////////// Normal Delay ///////////////////////////////////////////
;/////////////////////////////////////////////////////////////////////////////////////////////////////
;
;#include <delay.h>
;
;void glcd_define2 (unsigned char *glcd_data_port_address,
; 0000 0473                   unsigned char *glcd_rs_port_address,  unsigned char glcd_rs_pin,
; 0000 0474                   unsigned char *glcd_rw_port_address,  unsigned char glcd_rw_pin,
; 0000 0475                   unsigned char *glcd_en_port_address,  unsigned char glcd_en_pin,
; 0000 0476                   unsigned char *glcd_cs1_port_address, unsigned char glcd_cs1_pin,
; 0000 0477                   unsigned char *glcd_cs2_port_address, unsigned char glcd_cs2_pin,
; 0000 0478                   unsigned char *glcd_rst_port_address, unsigned char glcd_rst_pin)
; 0000 0479 {
; 0000 047A   glcd_data_address = glcd_data_port_address;
;	*glcd_data_port_address -> Y+18
;	*glcd_rs_port_address -> Y+16
;	glcd_rs_pin -> Y+15
;	*glcd_rw_port_address -> Y+13
;	glcd_rw_pin -> Y+12
;	*glcd_en_port_address -> Y+10
;	glcd_en_pin -> Y+9
;	*glcd_cs1_port_address -> Y+7
;	glcd_cs1_pin -> Y+6
;	*glcd_cs2_port_address -> Y+4
;	glcd_cs2_pin -> Y+3
;	*glcd_rst_port_address -> Y+1
;	glcd_rst_pin -> Y+0
; 0000 047B   glcd_rs_address   = glcd_rs_port_address;
; 0000 047C   glcd_rw_address   = glcd_rw_port_address;
; 0000 047D   glcd_en_address   = glcd_en_port_address;
; 0000 047E   glcd_cs1_address  = glcd_cs1_port_address;
; 0000 047F   glcd_cs2_address  = glcd_cs2_port_address;
; 0000 0480   glcd_rst_address  = glcd_rst_port_address;
; 0000 0481 #ifdef _ATXMEGA_DEVICE_
; 0000 0482   glcd_rs_bit_msk  = 0b00000001 << glcd_rs_pin;
; 0000 0483   glcd_rw_bit_msk  = 0b00000001 << glcd_rw_pin;
; 0000 0484   glcd_en_bit_msk  = 0b00000001 << glcd_en_pin;
; 0000 0485   glcd_cs1_bit_msk = 0b00000001 << glcd_cs1_pin;
; 0000 0486   glcd_cs2_bit_msk = 0b00000001 << glcd_cs2_pin;
; 0000 0487   glcd_rst_bit_msk = 0b00000001 << glcd_rst_pin;
; 0000 0488   // Set all the pins as output
; 0000 0489   *(glcd_data_address - 0x03) = 0xFF;
; 0000 048A   *(glcd_rs_address - 0x03)   = glcd_rs_bit_msk;
; 0000 048B   clr_rw;
; 0000 048C   *(glcd_rw_address - 0x03)   = glcd_rw_bit_msk;
; 0000 048D   *(glcd_en_address - 0x03)   = glcd_en_bit_msk;
; 0000 048E   *(glcd_cs1_address - 0x03)  = glcd_cs1_bit_msk;
; 0000 048F   *(glcd_cs2_address - 0x03)  = glcd_cs2_bit_msk;
; 0000 0490   *(glcd_rst_address - 0x03)  = glcd_rst_bit_msk;
; 0000 0491 #else
; 0000 0492   glcd_rs_bit_pos  = glcd_rs_pin;
; 0000 0493   glcd_rw_bit_pos  = glcd_rw_pin;
; 0000 0494   glcd_en_bit_pos  = glcd_en_pin;
; 0000 0495   glcd_cs1_bit_pos = glcd_cs1_pin;
; 0000 0496   glcd_cs2_bit_pos = glcd_cs2_pin;
; 0000 0497   glcd_rst_bit_pos = glcd_rst_pin;
; 0000 0498   // Sets the pins as output
; 0000 0499   *(glcd_data_address - 1) = 0xFF;
; 0000 049A   SETBIT (*(glcd_rs_address - 0x01),glcd_rs_bit_pos);
; 0000 049B   SETBIT (*(glcd_rw_address - 0x01),glcd_rw_bit_pos);
; 0000 049C   clr_rw;
; 0000 049D   SETBIT (*(glcd_en_address - 0x01),glcd_en_bit_pos);
; 0000 049E   SETBIT (*(glcd_cs1_address - 0x01),glcd_cs1_bit_pos);
; 0000 049F   SETBIT (*(glcd_cs2_address - 0x01),glcd_cs2_bit_pos);
; 0000 04A0   SETBIT (*(glcd_rst_address - 0x01),glcd_rst_bit_pos);
; 0000 04A1 #endif
; 0000 04A2 }
;
;void glcd_unlock_lock2 (void)
; 0000 04A5 {
; 0000 04A6   delay_us(7);
; 0000 04A7   set_en;
; 0000 04A8   delay_us(7);
; 0000 04A9   clr_en;
; 0000 04AA }
;
;void glcd_init2 (void)
; 0000 04AD {
; 0000 04AE   char i;
; 0000 04AF   clr_rst;
;	i -> R17
; 0000 04B0   delay_ms(10);
; 0000 04B1   set_rst;
; 0000 04B2   delay_ms(10);
; 0000 04B3   clr_rs;
; 0000 04B4   clr_cs1;
; 0000 04B5   set_cs2;
; 0000 04B6   for (i=0;i<2;i++)
; 0000 04B7   {
; 0000 04B8     *glcd_data_address = 0x3E;
; 0000 04B9     glcd_unlock_lock2();
; 0000 04BA     *glcd_data_address = 0x40;
; 0000 04BB     glcd_unlock_lock2();
; 0000 04BC     *glcd_data_address = 0xB8;
; 0000 04BD     glcd_unlock_lock2();
; 0000 04BE     *glcd_data_address = 0x3F;
; 0000 04BF     glcd_unlock_lock2();
; 0000 04C0     tgl_cs1;
; 0000 04C1     tgl_cs2;
; 0000 04C2   }
; 0000 04C3 }
;
;void glcd_writebyte2 (char clmn, char pg, char data)
; 0000 04C6 {
; 0000 04C7   if(clmn >= 64)
;	clmn -> Y+2
;	pg -> Y+1
;	data -> Y+0
; 0000 04C8   {
; 0000 04C9     clr_cs1;
; 0000 04CA     set_cs2;
; 0000 04CB   }
; 0000 04CC   else
; 0000 04CD   {
; 0000 04CE     set_cs1;
; 0000 04CF     clr_cs2;
; 0000 04D0   }
; 0000 04D1   clr_rs;
; 0000 04D2   clr_rw;
; 0000 04D3   *glcd_data_address = 0xB8 | pg;
; 0000 04D4   glcd_unlock_lock2();
; 0000 04D5 
; 0000 04D6   clr_rs;
; 0000 04D7   clr_rw;
; 0000 04D8   *glcd_data_address = 0x40 | clmn;
; 0000 04D9   glcd_unlock_lock2();
; 0000 04DA 
; 0000 04DB   set_rs;
; 0000 04DC   clr_rw;
; 0000 04DD   *glcd_data_address = data;
; 0000 04DE   glcd_unlock_lock2();
; 0000 04DF }
;
;void glcd_clear_page2 (char page)
; 0000 04E2 {
; 0000 04E3   char i;
; 0000 04E4   for (i = 0;i < 128;i++)
;	page -> Y+1
;	i -> R17
; 0000 04E5     glcd_writebyte2(i,page,0x00);
; 0000 04E6 }
;
;void glcd_putchar2 (char column, char page, char ch)
; 0000 04E9 {
; 0000 04EA   char i;
; 0000 04EB   ch -= 32;
;	column -> Y+3
;	page -> Y+2
;	ch -> Y+1
;	i -> R17
; 0000 04EC   for (i = 0;i < 6;i++)
; 0000 04ED   {
; 0000 04EE     glcd_writebyte2(column, page, glcd_font[ch][i]);
; 0000 04EF     column++;
; 0000 04F0   };
; 0000 04F1 }
;
;void glcd_puts2 (char column, char page, char* str)
; 0000 04F4 {
; 0000 04F5   while (*str)
;	column -> Y+3
;	page -> Y+2
;	*str -> Y+0
; 0000 04F6   {
; 0000 04F7     glcd_putchar2(column, page, *str++);
; 0000 04F8     column += 6;
; 0000 04F9   }
; 0000 04FA }
;
;void glcd_puts_center2 (char page, char* str)
; 0000 04FD {
; 0000 04FE   char i;
; 0000 04FF   i = strlen_char(str);
;	page -> Y+3
;	*str -> Y+1
;	i -> R17
; 0000 0500   i = (128 - i * 6) / 2;
; 0000 0501   glcd_puts2(i,page,str);
; 0000 0502 }
;
;void glcd_putsf2 (char column, char page,flash char* str)
; 0000 0505 {
; 0000 0506   while (*str)
;	column -> Y+3
;	page -> Y+2
;	*str -> Y+0
; 0000 0507   {
; 0000 0508     glcd_putchar2(column, page, *str++ );
; 0000 0509     column += 6;
; 0000 050A   }
; 0000 050B }
;
;void glcd_putsf_center2 (char page, flash char* str)
; 0000 050E {
; 0000 050F   char i;
; 0000 0510   i = strlenf_char(str);
;	page -> Y+3
;	*str -> Y+1
;	i -> R17
; 0000 0511   i = (128 - i * 6) / 2;
; 0000 0512   glcd_putsf2(i,page,str);
; 0000 0513 }
;
;void glcd_clear2 (void)
; 0000 0516 {
; 0000 0517   char i, j;
; 0000 0518   for (i = 0;i < 8;i++)
;	i -> R17
;	j -> R16
; 0000 0519     for (j = 0;j < 128;j++)
; 0000 051A       glcd_writebyte2(j, i, 0);
; 0000 051B }
;
;void glcd_putbmp2 (flash unsigned char bmp[])
; 0000 051E {
; 0000 051F   char x=0;
; 0000 0520   char y=0;
; 0000 0521   unsigned int i;
; 0000 0522   for(i=0;i<1024;i++)
;	x -> R17
;	y -> R16
;	i -> R18,R19
; 0000 0523   {
; 0000 0524     if(x==128)
; 0000 0525     {
; 0000 0526       x=0;
; 0000 0527       y++;
; 0000 0528     }
; 0000 0529     glcd_writebyte2(x,y,bmp[i]);
; 0000 052A     x++;
; 0000 052B   }
; 0000 052C }
;
;
;
;
;
;
;
;// Timer 0 output compare interrupt service routine
;interrupt [TIM0_COMP] void timer0_comp_isr(void)
; 0000 0536 {
_timer0_comp_isr:
	ST   -Y,R0
	ST   -Y,R1
	ST   -Y,R15
	ST   -Y,R22
	ST   -Y,R23
	ST   -Y,R24
	ST   -Y,R25
	ST   -Y,R26
	ST   -Y,R27
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
; 0000 0537 // Place your code here
; 0000 0538     glcd_timer_isr();
	CALL _glcd_timer_isr
; 0000 0539 }
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R27,Y+
	LD   R26,Y+
	LD   R25,Y+
	LD   R24,Y+
	LD   R23,Y+
	LD   R22,Y+
	LD   R15,Y+
	LD   R1,Y+
	LD   R0,Y+
	RETI
;
;char TCCR0_value = 0x09;

	.DSEG
;
;void timer0_start (void)
; 0000 053E {

	.CSEG
_timer0_start:
; 0000 053F     TCCR0 = TCCR0_value;
	LDS  R30,_TCCR0_value
	OUT  0x33,R30
; 0000 0540 }
	RET
;
;void timer0_stop (void)
; 0000 0543 {
_timer0_stop:
; 0000 0544     TCCR0 = 0x00;
	LDI  R30,LOW(0)
	OUT  0x33,R30
; 0000 0545     TCNT0 = 0x00;
	OUT  0x32,R30
; 0000 0546 }
	RET
;
;void timer0_set_7us (void)
; 0000 0549 {
_timer0_set_7us:
; 0000 054A     TCCR0_value = 0x09;
	LDI  R30,LOW(9)
	STS  _TCCR0_value,R30
; 0000 054B     OCR0 = 0x6F;
	LDI  R30,LOW(111)
	RJMP _0x2080004
; 0000 054C }
;
;void timer0_set_10ms (void)
; 0000 054F {
_timer0_set_10ms:
; 0000 0550     TCCR0_value = 0x0D;
	LDI  R30,LOW(13)
	STS  _TCCR0_value,R30
; 0000 0551     OCR0 = 0x9B;
	LDI  R30,LOW(155)
_0x2080004:
	OUT  0x3C,R30
; 0000 0552 }
	RET
;
;// Declare your global variables here
;flash unsigned char  picture[1024] = {
;   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,192,248,255,255,255,255,
; 255,255,248,192,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
;   0,  0,  0,  0,  0,  0,  0,128,192,224,240,248,252,254,127, 63,
;  31,143,143,223,255,255,254,252,248,240,224,224,224,224,224,192,
; 192,192,192,224,224,240,240,240,248,248,248,248,248,248,248,240,
; 240,240,248,252,254,254,254,252,248,248,248,248,248,248,248,240,
; 240,240,224,192,192,128,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
;   0,  0,  0,  0,192,248,252,254,254,252,248,192,  0,  0,  0,  0,
; 240,240,248,248,248,252,252,252,254,190,191,191, 31, 31,  3,  3,
;  31, 31,191,191,190,254,252,252,252,248,248,248,248,252,252,254,
;  62, 62, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 63,127,254,255,
; 255,255,255,255,255,255,127, 63, 31, 15,  7,  3,  3,  3, 15, 31,
;  31, 31, 31, 15, 15,  3,  1,  1,  0, 28, 62,127,255,255,255,255,
; 255,239,207,143, 15,  7,  1,129,193,227,247,255,255,255,255,127,
;  63, 31,  7, 15, 63,127,127,126,124,252,248,248,240,252,254,190,
;  62,127,127,127,255,255,255,255,247,255,255,255,127,127,127, 62,
;   1,  1,  3,  3,  3,  7,  7,  7, 15, 15,127,255,255,255,248,248,
; 254,255,255,255,255,255,247,255,255,255,255,255,  3,  1,  1,  0,
;   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  1,
;   1,  3,  3,  1,  1,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
;   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  1,  3,
;   7, 15, 15, 31, 63, 63, 63, 31, 15, 15,  7,  3,  1,  0,  0,  0,
;   0,  0,  0,  0,  0,  0,  0,  0,  0,128,193,227,255,255,255,255,
; 254,  0,  0,  0,  1, 15, 31, 63, 63, 63, 15,  1,  0,  0,  0,  0,
;   0,  0,  0,  0,192,224,240,240,224,192,  0,  3, 31,127,255,255,
; 255,255,231,195,129,129,  1,  1,  1,  1,  1,  1,  0,  0,  0,  0,
;   0,128,225,255,159,129,193,127, 30,  0,112,248,156,148,148,220,
;  88,  0,128,129,241,255,143,128,  0,  0,224,240,148,148,244,252,
; 152,  0,  4, 28,252,196, 96, 60, 12,  4,  0,  0,  0,  0,  0,  0,
;   0,128,225,255,159, 17, 49,249,207,134,  0,  0,240,224,224,224,
; 192,128,128,  0,  0,  0,  0,128,199,207,207,143,135,247,255,255,
; 255,255,252,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
;  62, 62, 62,127,255,255,255,255,255,255,127, 62, 62, 62,252,241,
; 251,255,255,255,255, 31, 31, 31, 31, 31, 31, 12,  0,  0,  0,  0,
;   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
;   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
;   0,  2,  2,  2,  3,  2,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
;   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  3,  3,  7,  7,
;  31,255,255,255,252,248,248,255,255,255,255,255,255,255,127, 63,
; 127,255,255,252,248,240,240,240,224,224,224,192,  0,  0,  0,  0,
;   0,  0,  0,  0,  1,  3,  7,  7, 55,121,252,252,252,254,255,255,
; 255,255,255,255,255,255,254,252,124,252,248,248,248,248,252,252,
; 252,252,184,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
;   0,192,224,224,224,192,128,  0,  0,  0,  0,  0,  0,  0,  0,  0,
; 192,224,224,224,192,  0,  0,  0,  0,  0,  0,  0,  0,128,224,248,
; 252,252,252,248,224,224,224,224,224,224,224,240,240,240,248,252,
; 254,255,255,255,255,255,255,255,127, 15,127,255,255,255,255,254,
; 255,255,255,223,143,135,  7,  7,  7,  3,  3,  1,  0,  0,  0,  0,
;   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  1, 31,127,
; 127,127, 63, 31,  1,  0,  0,  0,  0,128,192,249,255,255,255,255,
; 255,223,223,223,223,223,223,255,255,255,255,255, 31, 31, 31, 31,
;  31, 15, 15, 15, 15, 31, 31, 63,126,254,252,252,252,248,248,254,
; 255,255,255,255,255,254,248,248,252,252,254,254,127, 31, 31, 15,
;   7,131,129,131,131,131,195,195,251,255,255,255,255,255,255,255,
; 255,255,255,255,255,249,249,240,224,  0,224,240,249,255,255,255,
; 127,127, 63, 63, 31, 31, 15,  6,  0,  0,  0,  0,  0,  0,  0,  0,
;   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
;   0,  0,  0,  0, 60,126,254,254,255,255,255,255,127,127, 63, 63,
;  63, 31, 31,  7,  7,  7,  7,  7,  7,  3,  3,  1,  0,  0,  0,  0,
;   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,225,255,255,255,255,
; 255,127, 62,127,255,255,255,255,255,225,  1,  0,  0,  0,  0,  6,
;  15, 31, 31, 31, 31, 63, 63, 63,255,255,255,249,255,255,255,127,
;  63, 63, 31, 31, 31, 31,255,255,255,255,255,255,255, 31,  0,  0,
;   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0
;};
;
;void main(void)
; 0000 0599 {
_main:
; 0000 059A // Declare your local variables here
; 0000 059B char str[22] = "What's that????";
; 0000 059C // Input/Output Ports initialization
; 0000 059D // Port A initialization
; 0000 059E // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 059F // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 05A0 PORTA=0x00;
	SBIW R28,22
	LDI  R24,22
	LDI  R26,LOW(0)
	LDI  R27,HIGH(0)
	LDI  R30,LOW(_0x145*2)
	LDI  R31,HIGH(_0x145*2)
	CALL __INITLOCB
;	str -> Y+0
	LDI  R30,LOW(0)
	OUT  0x1B,R30
; 0000 05A1 DDRA=0x00;
	OUT  0x1A,R30
; 0000 05A2 
; 0000 05A3 // Port B initialization
; 0000 05A4 // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 05A5 // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 05A6 PORTB=0x01;
	LDI  R30,LOW(1)
	OUT  0x18,R30
; 0000 05A7 DDRB=0x00;
	LDI  R30,LOW(0)
	OUT  0x17,R30
; 0000 05A8 
; 0000 05A9 // Port C initialization
; 0000 05AA // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 05AB // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 05AC PORTC=0x00;
	OUT  0x15,R30
; 0000 05AD DDRC=0x00;
	OUT  0x14,R30
; 0000 05AE 
; 0000 05AF // Port D initialization
; 0000 05B0 // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 05B1 // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 05B2 PORTD=0x00;
	OUT  0x12,R30
; 0000 05B3 DDRD=0x00;
	OUT  0x11,R30
; 0000 05B4 
; 0000 05B5 // Timer/Counter 0 initialization
; 0000 05B6 // Clock source: System Clock
; 0000 05B7 // Clock value: 16000.000 kHz
; 0000 05B8 // Mode: CTC top=OCR0
; 0000 05B9 // OC0 output: Disconnected
; 0000 05BA TCCR0=0x00;// 0x09 for 7us, 0x0D for 10ms
	OUT  0x33,R30
; 0000 05BB TCNT0=0x00;
	OUT  0x32,R30
; 0000 05BC OCR0=0x6F;// 0x6F for 7us, 0x9B for 10ms
	LDI  R30,LOW(111)
	OUT  0x3C,R30
; 0000 05BD 
; 0000 05BE // Timer/Counter 1 initialization
; 0000 05BF // Clock source: System Clock
; 0000 05C0 // Clock value: Timer1 Stopped
; 0000 05C1 // Mode: Normal top=0xFFFF
; 0000 05C2 // OC1A output: Discon.
; 0000 05C3 // OC1B output: Discon.
; 0000 05C4 // Noise Canceler: Off
; 0000 05C5 // Input Capture on Falling Edge
; 0000 05C6 // Timer1 Overflow Interrupt: Off
; 0000 05C7 // Input Capture Interrupt: Off
; 0000 05C8 // Compare A Match Interrupt: Off
; 0000 05C9 // Compare B Match Interrupt: Off
; 0000 05CA TCCR1A=0x00;
	LDI  R30,LOW(0)
	OUT  0x2F,R30
; 0000 05CB TCCR1B=0x00;
	OUT  0x2E,R30
; 0000 05CC TCNT1H=0x00;
	OUT  0x2D,R30
; 0000 05CD TCNT1L=0x00;
	OUT  0x2C,R30
; 0000 05CE ICR1H=0x00;
	OUT  0x27,R30
; 0000 05CF ICR1L=0x00;
	OUT  0x26,R30
; 0000 05D0 OCR1AH=0x00;
	OUT  0x2B,R30
; 0000 05D1 OCR1AL=0x00;
	OUT  0x2A,R30
; 0000 05D2 OCR1BH=0x00;
	OUT  0x29,R30
; 0000 05D3 OCR1BL=0x00;
	OUT  0x28,R30
; 0000 05D4 
; 0000 05D5 // Timer/Counter 2 initialization
; 0000 05D6 // Clock source: System Clock
; 0000 05D7 // Clock value: Timer2 Stopped
; 0000 05D8 // Mode: Normal top=0xFF
; 0000 05D9 // OC2 output: Disconnected
; 0000 05DA ASSR=0x00;
	OUT  0x22,R30
; 0000 05DB TCCR2=0x00;
	OUT  0x25,R30
; 0000 05DC TCNT2=0x00;
	OUT  0x24,R30
; 0000 05DD OCR2=0x00;
	OUT  0x23,R30
; 0000 05DE 
; 0000 05DF // External Interrupt(s) initialization
; 0000 05E0 // INT0: Off
; 0000 05E1 // INT1: Off
; 0000 05E2 // INT2: Off
; 0000 05E3 MCUCR=0x00;
	OUT  0x35,R30
; 0000 05E4 MCUCSR=0x00;
	OUT  0x34,R30
; 0000 05E5 
; 0000 05E6 // Timer(s)/Counter(s) Interrupt(s) initialization
; 0000 05E7 TIMSK=0x02;
	LDI  R30,LOW(2)
	OUT  0x39,R30
; 0000 05E8 
; 0000 05E9 // Alphanumeric LCD initialization
; 0000 05EA // Connections specified in the
; 0000 05EB // Project|Configure|C Compiler|Libraries|Alphanumeric LCD menu:
; 0000 05EC // RS - PORTA Bit 0
; 0000 05ED // RD - PORTA Bit 1
; 0000 05EE // EN - PORTA Bit 2
; 0000 05EF // D4 - PORTA Bit 4
; 0000 05F0 // D5 - PORTA Bit 5
; 0000 05F1 // D6 - PORTA Bit 6
; 0000 05F2 // D7 - PORTA Bit 7
; 0000 05F3 // Characters/line: 16
; 0000 05F4 // USART initialization
; 0000 05F5 // USART disabled
; 0000 05F6 UCSRB=0x00;
	LDI  R30,LOW(0)
	OUT  0xA,R30
; 0000 05F7 
; 0000 05F8 // Analog Comparator initialization
; 0000 05F9 // Analog Comparator: Off
; 0000 05FA // Analog Comparator Input Capture by Timer/Counter 1: Off
; 0000 05FB ACSR=0x80;
	LDI  R30,LOW(128)
	OUT  0x8,R30
; 0000 05FC SFIOR=0x00;
	LDI  R30,LOW(0)
	OUT  0x30,R30
; 0000 05FD 
; 0000 05FE // ADC initialization
; 0000 05FF // ADC disabled
; 0000 0600 ADCSRA=0x00;
	OUT  0x6,R30
; 0000 0601 
; 0000 0602 // SPI initialization
; 0000 0603 // SPI disabled
; 0000 0604 SPCR=0x00;
	OUT  0xD,R30
; 0000 0605 
; 0000 0606 // TWI initialization
; 0000 0607 // TWI disabled
; 0000 0608 TWCR=0x00;
	OUT  0x36,R30
; 0000 0609 
; 0000 060A timer_interrupt_enable  = (void (*)())(timer0_start);
	LDI  R30,LOW(_timer0_start)
	LDI  R31,HIGH(_timer0_start)
	MOVW R4,R30
; 0000 060B timer_interrupt_disable = (void (*)())(timer0_stop);
	LDI  R30,LOW(_timer0_stop)
	LDI  R31,HIGH(_timer0_stop)
	MOVW R6,R30
; 0000 060C set_delay_7us           = (void (*)())(timer0_set_7us);
	LDI  R30,LOW(_timer0_set_7us)
	LDI  R31,HIGH(_timer0_set_7us)
	MOVW R8,R30
; 0000 060D set_delay_10ms          = (void (*)())(timer0_set_10ms);
	LDI  R30,LOW(_timer0_set_10ms)
	LDI  R31,HIGH(_timer0_set_10ms)
	MOVW R10,R30
; 0000 060E 
; 0000 060F #asm("sei")
	sei
; 0000 0610 
; 0000 0611 lcd_init(16);
	LDI  R30,LOW(16)
	ST   -Y,R30
	CALL _lcd_init
; 0000 0612 lcd_clear();
	CALL _lcd_clear
; 0000 0613 lcd_gotoxy(0,1);
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R30,LOW(1)
	ST   -Y,R30
	CALL _lcd_gotoxy
; 0000 0614 lcd_putsf("0123456789ABCDEF");
	__POINTW1FN _0x0,0
	ST   -Y,R31
	ST   -Y,R30
	CALL _lcd_putsf
; 0000 0615 
; 0000 0616 glcd_define(&PORTC,&PORTD,0,&PORTD,1,&PORTD,2,&PORTD,3,&PORTD,4,&PORTD,5);
	LDI  R30,LOW(53)
	LDI  R31,HIGH(53)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(50)
	LDI  R31,HIGH(50)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R30,LOW(50)
	LDI  R31,HIGH(50)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(1)
	ST   -Y,R30
	LDI  R30,LOW(50)
	LDI  R31,HIGH(50)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(2)
	ST   -Y,R30
	LDI  R30,LOW(50)
	LDI  R31,HIGH(50)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(3)
	ST   -Y,R30
	LDI  R30,LOW(50)
	LDI  R31,HIGH(50)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(4)
	ST   -Y,R30
	LDI  R30,LOW(50)
	LDI  R31,HIGH(50)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(5)
	ST   -Y,R30
	CALL _glcd_define
; 0000 0617 
; 0000 0618 glcd_init();
	RCALL _glcd_init
; 0000 0619 glcd_clear();
	RCALL _glcd_clear
; 0000 061A glcd_putchar(0,6,'M');
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R30,LOW(6)
	ST   -Y,R30
	LDI  R30,LOW(77)
	ST   -Y,R30
	RCALL _glcd_putchar
; 0000 061B glcd_putsf(0,0,"Hi!\0kjk");
	LDI  R30,LOW(0)
	ST   -Y,R30
	ST   -Y,R30
	__POINTW1FN _0x0,17
	ST   -Y,R31
	ST   -Y,R30
	RCALL _glcd_putsf
; 0000 061C glcd_puts(0,1,str);
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R30,LOW(1)
	ST   -Y,R30
	MOVW R30,R28
	ADIW R30,2
	ST   -Y,R31
	ST   -Y,R30
	RCALL _glcd_puts
; 0000 061D glcd_putsf_center(2,"sdah");
	LDI  R30,LOW(2)
	ST   -Y,R30
	__POINTW1FN _0x0,25
	ST   -Y,R31
	ST   -Y,R30
	RCALL _glcd_putsf_center
; 0000 061E glcd_puts_center(3,str);
	LDI  R30,LOW(3)
	ST   -Y,R30
	MOVW R30,R28
	ADIW R30,1
	ST   -Y,R31
	ST   -Y,R30
	RCALL _glcd_puts_center
; 0000 061F delay_ms(500);
	LDI  R30,LOW(500)
	LDI  R31,HIGH(500)
	ST   -Y,R31
	ST   -Y,R30
	CALL _delay_ms
; 0000 0620 glcd_clear();
	RCALL _glcd_clear
; 0000 0621 delay_ms(500);
	LDI  R30,LOW(500)
	LDI  R31,HIGH(500)
	ST   -Y,R31
	ST   -Y,R30
	CALL _delay_ms
; 0000 0622 glcd_putbmp(picture);
	LDI  R30,LOW(_picture*2)
	LDI  R31,HIGH(_picture*2)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _glcd_putbmp
; 0000 0623 while (GlcdBusy)
_0x146:
	MOV  R30,R13
	COM  R30
	CPI  R30,0
	BREQ _0x148
; 0000 0624 {
; 0000 0625     #asm("cli")
	cli
; 0000 0626     lcd_gotoxy(15,1);
	LDI  R30,LOW(15)
	ST   -Y,R30
	LDI  R30,LOW(1)
	ST   -Y,R30
	CALL _lcd_gotoxy
; 0000 0627     lcd_putchar('Y');
	LDI  R30,LOW(89)
	ST   -Y,R30
	CALL _lcd_putchar
; 0000 0628     #asm("sei")
	sei
; 0000 0629     delay_ms(100);
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	ST   -Y,R31
	ST   -Y,R30
	CALL _delay_ms
; 0000 062A     #asm("cli")
	cli
; 0000 062B     lcd_gotoxy(15,1);
	LDI  R30,LOW(15)
	ST   -Y,R30
	LDI  R30,LOW(1)
	ST   -Y,R30
	RCALL _lcd_gotoxy
; 0000 062C     lcd_putchar('X');
	LDI  R30,LOW(88)
	ST   -Y,R30
	RCALL _lcd_putchar
; 0000 062D     #asm("sei")
	sei
; 0000 062E     delay_ms(100);
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	ST   -Y,R31
	ST   -Y,R30
	CALL _delay_ms
; 0000 062F }
	RJMP _0x146
_0x148:
; 0000 0630 lcd_clear();
	RCALL _lcd_clear
; 0000 0631 lcd_gotoxy(0,1);
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R30,LOW(1)
	ST   -Y,R30
	RCALL _lcd_gotoxy
; 0000 0632 lcd_putsf("Finished!");
	__POINTW1FN _0x0,30
	ST   -Y,R31
	ST   -Y,R30
	RCALL _lcd_putsf
; 0000 0633 
; 0000 0634 // Global enable interrupts
; 0000 0635 #asm("sei")
	sei
; 0000 0636 
; 0000 0637 while (1)
_0x149:
; 0000 0638       {
; 0000 0639       // Place your code here
; 0000 063A 
; 0000 063B       }
	RJMP _0x149
; 0000 063C }
_0x14C:
	RJMP _0x14C
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x40
	.EQU __sm_mask=0xB0
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0xA0
	.EQU __sm_ext_standby=0xB0
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif

	.DSEG

	.CSEG
__lcd_write_nibble_G100:
	LD   R30,Y
	ANDI R30,LOW(0x10)
	BREQ _0x2000004
	SBI  0x1B,4
	RJMP _0x2000005
_0x2000004:
	CBI  0x1B,4
_0x2000005:
	LD   R30,Y
	ANDI R30,LOW(0x20)
	BREQ _0x2000006
	SBI  0x1B,5
	RJMP _0x2000007
_0x2000006:
	CBI  0x1B,5
_0x2000007:
	LD   R30,Y
	ANDI R30,LOW(0x40)
	BREQ _0x2000008
	SBI  0x1B,6
	RJMP _0x2000009
_0x2000008:
	CBI  0x1B,6
_0x2000009:
	LD   R30,Y
	ANDI R30,LOW(0x80)
	BREQ _0x200000A
	SBI  0x1B,7
	RJMP _0x200000B
_0x200000A:
	CBI  0x1B,7
_0x200000B:
	__DELAY_USB 11
	SBI  0x1B,2
	__DELAY_USB 27
	CBI  0x1B,2
	__DELAY_USB 27
	RJMP _0x2080001
__lcd_write_data:
	LD   R30,Y
	ST   -Y,R30
	RCALL __lcd_write_nibble_G100
    ld    r30,y
    swap  r30
    st    y,r30
	LD   R30,Y
	ST   -Y,R30
	RCALL __lcd_write_nibble_G100
	__DELAY_USW 200
	RJMP _0x2080001
_lcd_gotoxy:
	LD   R30,Y
	LDI  R31,0
	SUBI R30,LOW(-__base_y_G100)
	SBCI R31,HIGH(-__base_y_G100)
	LD   R30,Z
	LDD  R26,Y+1
	ADD  R30,R26
	ST   -Y,R30
	RCALL __lcd_write_data
	LDD  R30,Y+1
	STS  __lcd_x,R30
	LD   R30,Y
	STS  __lcd_y,R30
_0x2080003:
	ADIW R28,2
	RET
_lcd_clear:
	LDI  R30,LOW(2)
	ST   -Y,R30
	RCALL __lcd_write_data
	LDI  R30,LOW(3)
	LDI  R31,HIGH(3)
	ST   -Y,R31
	ST   -Y,R30
	CALL _delay_ms
	LDI  R30,LOW(12)
	ST   -Y,R30
	RCALL __lcd_write_data
	LDI  R30,LOW(1)
	ST   -Y,R30
	RCALL __lcd_write_data
	LDI  R30,LOW(3)
	LDI  R31,HIGH(3)
	ST   -Y,R31
	ST   -Y,R30
	CALL _delay_ms
	LDI  R30,LOW(0)
	STS  __lcd_y,R30
	STS  __lcd_x,R30
	RET
_lcd_putchar:
	LD   R26,Y
	CPI  R26,LOW(0xA)
	BREQ _0x2000011
	LDS  R30,__lcd_maxx
	LDS  R26,__lcd_x
	CP   R26,R30
	BRLO _0x2000010
_0x2000011:
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDS  R30,__lcd_y
	SUBI R30,-LOW(1)
	STS  __lcd_y,R30
	ST   -Y,R30
	RCALL _lcd_gotoxy
	LD   R26,Y
	CPI  R26,LOW(0xA)
	BRNE _0x2000013
	RJMP _0x2080001
_0x2000013:
_0x2000010:
	LDS  R30,__lcd_x
	SUBI R30,-LOW(1)
	STS  __lcd_x,R30
	SBI  0x1B,0
	LD   R30,Y
	ST   -Y,R30
	RCALL __lcd_write_data
	CBI  0x1B,0
	RJMP _0x2080001
_lcd_putsf:
	ST   -Y,R17
_0x2000017:
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	ADIW R30,1
	STD  Y+1,R30
	STD  Y+1+1,R31
	SBIW R30,1
	LPM  R30,Z
	MOV  R17,R30
	CPI  R30,0
	BREQ _0x2000019
	ST   -Y,R17
	RCALL _lcd_putchar
	RJMP _0x2000017
_0x2000019:
	LDD  R17,Y+0
_0x2080002:
	ADIW R28,3
	RET
_lcd_init:
	SBI  0x1A,4
	SBI  0x1A,5
	SBI  0x1A,6
	SBI  0x1A,7
	SBI  0x1A,2
	SBI  0x1A,0
	SBI  0x1A,1
	CBI  0x1B,2
	CBI  0x1B,0
	CBI  0x1B,1
	LD   R30,Y
	STS  __lcd_maxx,R30
	SUBI R30,-LOW(128)
	__PUTB1MN __base_y_G100,2
	LD   R30,Y
	SUBI R30,-LOW(192)
	__PUTB1MN __base_y_G100,3
	LDI  R30,LOW(20)
	LDI  R31,HIGH(20)
	ST   -Y,R31
	ST   -Y,R30
	CALL _delay_ms
	LDI  R30,LOW(48)
	ST   -Y,R30
	RCALL __lcd_write_nibble_G100
	__DELAY_USW 400
	LDI  R30,LOW(48)
	ST   -Y,R30
	RCALL __lcd_write_nibble_G100
	__DELAY_USW 400
	LDI  R30,LOW(48)
	ST   -Y,R30
	RCALL __lcd_write_nibble_G100
	__DELAY_USW 400
	LDI  R30,LOW(32)
	ST   -Y,R30
	RCALL __lcd_write_nibble_G100
	__DELAY_USW 400
	LDI  R30,LOW(40)
	ST   -Y,R30
	RCALL __lcd_write_data
	LDI  R30,LOW(4)
	ST   -Y,R30
	RCALL __lcd_write_data
	LDI  R30,LOW(133)
	ST   -Y,R30
	RCALL __lcd_write_data
	LDI  R30,LOW(6)
	ST   -Y,R30
	RCALL __lcd_write_data
	RCALL _lcd_clear
_0x2080001:
	ADIW R28,1
	RET
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x40
	.EQU __sm_mask=0xB0
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0xA0
	.EQU __sm_ext_standby=0xB0
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif

	.CSEG

	.CSEG

	.CSEG

	.DSEG
_glcd_data_address_G000:
	.BYTE 0x2
_glcd_rs_address_G000:
	.BYTE 0x2
_glcd_rs_bit_pos_G000:
	.BYTE 0x1
_glcd_rw_address_G000:
	.BYTE 0x2
_glcd_rw_bit_pos_G000:
	.BYTE 0x1
_glcd_en_address_G000:
	.BYTE 0x2
_glcd_en_bit_pos_G000:
	.BYTE 0x1
_glcd_cs1_address_G000:
	.BYTE 0x2
_glcd_cs1_bit_pos_G000:
	.BYTE 0x1
_glcd_cs2_address_G000:
	.BYTE 0x2
_glcd_cs2_bit_pos_G000:
	.BYTE 0x1
_glcd_rst_address_G000:
	.BYTE 0x2
_glcd_rst_bit_pos_G000:
	.BYTE 0x1
_CaseAddress:
	.BYTE 0x42
_CaseStack:
	.BYTE 0xA
_GlcdColumn:
	.BYTE 0x1
_GlcdDataByte:
	.BYTE 0x1
_GlcdChar:
	.BYTE 0x1
_GlcdString:
	.BYTE 0x2
_GlcdFlashString:
	.BYTE 0x2
_GlcdFlashPointer:
	.BYTE 0x2
_i_S0000005000:
	.BYTE 0x1
_j_S0000005000:
	.BYTE 0x2
_TCCR0_value:
	.BYTE 0x1
__base_y_G100:
	.BYTE 0x4
__lcd_x:
	.BYTE 0x1
__lcd_y:
	.BYTE 0x1
__lcd_maxx:
	.BYTE 0x1

	.CSEG

	.CSEG
_delay_ms:
	ld   r30,y+
	ld   r31,y+
	adiw r30,0
	breq __delay_ms1
__delay_ms0:
	__DELAY_USW 0xFA0
	wdr
	sbiw r30,1
	brne __delay_ms0
__delay_ms1:
	ret

__ANEGW1:
	NEG  R31
	NEG  R30
	SBCI R31,0
	RET

__LSLB12:
	TST  R30
	MOV  R0,R30
	MOV  R30,R26
	BREQ __LSLB12R
__LSLB12L:
	LSL  R30
	DEC  R0
	BRNE __LSLB12L
__LSLB12R:
	RET

__LSRW12:
	TST  R30
	MOV  R0,R30
	MOVW R30,R26
	BREQ __LSRW12R
__LSRW12L:
	LSR  R31
	ROR  R30
	DEC  R0
	BRNE __LSRW12L
__LSRW12R:
	RET

__DIVW21U:
	CLR  R0
	CLR  R1
	LDI  R25,16
__DIVW21U1:
	LSL  R26
	ROL  R27
	ROL  R0
	ROL  R1
	SUB  R0,R30
	SBC  R1,R31
	BRCC __DIVW21U2
	ADD  R0,R30
	ADC  R1,R31
	RJMP __DIVW21U3
__DIVW21U2:
	SBR  R26,1
__DIVW21U3:
	DEC  R25
	BRNE __DIVW21U1
	MOVW R30,R26
	MOVW R26,R0
	RET

__DIVW21:
	RCALL __CHKSIGNW
	RCALL __DIVW21U
	BRTC __DIVW211
	RCALL __ANEGW1
__DIVW211:
	RET

__CHKSIGNW:
	CLT
	SBRS R31,7
	RJMP __CHKSW1
	RCALL __ANEGW1
	SET
__CHKSW1:
	SBRS R27,7
	RJMP __CHKSW2
	COM  R26
	COM  R27
	ADIW R26,1
	BLD  R0,0
	INC  R0
	BST  R0,0
__CHKSW2:
	RET

__SWAPW12:
	MOV  R1,R27
	MOV  R27,R31
	MOV  R31,R1

__SWAPB12:
	MOV  R1,R26
	MOV  R26,R30
	MOV  R30,R1
	RET

__INITLOCB:
__INITLOCW:
	ADD  R26,R28
	ADC  R27,R29
__INITLOC0:
	LPM  R0,Z+
	ST   X+,R0
	DEC  R24
	BRNE __INITLOC0
	RET

;END OF CODE MARKER
__END_OF_CODE:
