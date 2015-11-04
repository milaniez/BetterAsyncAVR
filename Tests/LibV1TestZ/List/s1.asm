
;CodeVisionAVR C Compiler V2.05.0 Professional
;(C) Copyright 1998-2010 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Chip type                : ATmega16
;Program type             : Application
;Clock frequency          : 12.000000 MHz
;Memory model             : Small
;Optimize for             : Size
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
	.DEF _TCCR0_value=R5
	.DEF _glcd_writebyte_clmn=R4
	.DEF _glcd_writebyte_pg=R7
	.DEF _glcd_writebyte_data=R6
	.DEF _glcd_clear_page_page=R9
	.DEF _glcd_putchar_column=R8
	.DEF _glcd_putchar_page=R11
	.DEF _glcd_putchar_ch=R10
	.DEF _glcd_puts_column=R13
	.DEF _glcd_puts_page=R12

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

_glcd_intro_bmp:
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x2,0x2,0xFE,0xFE,0xFE
	.DB  0xFE,0x2,0x2,0x0,0x0,0x2,0x2,0xFE
	.DB  0xFE,0xFE,0xFE,0x2,0x2,0x0,0x0,0x0
	.DB  0x0,0x2,0x2,0xFE,0x2,0x2,0x0,0x0
	.DB  0x7E,0x1E,0x6,0x2,0x2,0xFE,0xFE,0xFE
	.DB  0xFE,0x2,0x2,0x6,0x1E,0x7E,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0xFF,0xFF,0xFF
	.DB  0xFF,0x0,0x0,0x0,0x0,0x0,0x0,0xFF
	.DB  0xFF,0xFF,0xFF,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0xFF,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0xFF,0xFF,0xFF
	.DB  0xFF,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x80,0x80
	.DB  0x80,0x80,0x0,0x80,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x4,0x4,0x7,0x7,0x7
	.DB  0x7,0x4,0x4,0x0,0x0,0x0,0x80,0x80
	.DB  0x81,0x83,0x87,0x7,0x6,0x4,0x4,0x4
	.DB  0x84,0x82,0x83,0x80,0x80,0x0,0x0,0x0
	.DB  0x0,0x0,0x4,0x4,0x4,0x7,0x87,0x87
	.DB  0x87,0x4,0x4,0x4,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0xE,0x19,0x30,0x30
	.DB  0x30,0x61,0x63,0xC7,0x80,0x0,0x0,0x20
	.DB  0xE0,0xE0,0x0,0x0,0x20,0xE0,0xE0,0x0
	.DB  0x0,0x0,0x20,0xE0,0xE0,0x40,0x20,0x20
	.DB  0x20,0xC0,0x80,0x0,0x0,0x80,0xC0,0x20
	.DB  0x20,0x20,0xC0,0x80,0x0,0x0,0x20,0xE0
	.DB  0xE0,0x40,0x20,0x60,0x60,0x0,0x0,0x0
	.DB  0xFF,0x1,0x1F,0xFE,0xE0,0x0,0xE0,0x1E
	.DB  0x1,0xFF,0xFF,0x0,0x0,0x0,0x0,0x0
	.DB  0x20,0xE3,0xE3,0x0,0x0,0x0,0x0,0xFF
	.DB  0xFF,0x0,0x0,0x0,0x80,0xC0,0x20,0x20
	.DB  0x20,0xC0,0x80,0x0,0x0,0xC0,0xE0,0x20
	.DB  0x20,0x20,0xE0,0xC0,0x0,0x0,0x0,0xC0
	.DB  0xE0,0x20,0x20,0x20,0xC0,0xC0,0x60,0x60
	.DB  0x0,0x80,0xC0,0x20,0x20,0x20,0xC0,0x80
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x1E,0xC,0x8,0x10
	.DB  0x10,0x10,0x10,0x8,0x7,0x0,0x0,0x0
	.DB  0xF,0x1F,0x10,0x10,0x8,0x1F,0x1F,0x10
	.DB  0x0,0x0,0x0,0xFF,0xFF,0x8,0x10,0x10
	.DB  0x10,0xF,0x7,0x0,0x0,0x7,0xF,0x11
	.DB  0x11,0x11,0x11,0x9,0x0,0x0,0x10,0x1F
	.DB  0x1F,0x10,0x10,0x0,0x0,0x0,0x10,0x10
	.DB  0x1F,0x10,0x10,0x1,0x1F,0x1E,0x1,0x10
	.DB  0x10,0x1F,0x1F,0x10,0x10,0x0,0x0,0x0
	.DB  0x10,0x1F,0x1F,0x10,0x0,0x0,0x10,0x1F
	.DB  0x1F,0x10,0x0,0x0,0x7,0xF,0x11,0x11
	.DB  0x11,0x11,0x9,0x0,0x0,0xC,0x1E,0x13
	.DB  0x11,0x9,0x1F,0x1F,0x10,0x0,0x0,0xB9
	.DB  0x77,0x34,0x34,0x34,0x37,0x33,0xE0,0x0
	.DB  0x0,0x7,0xF,0x11,0x11,0x11,0x11,0x9
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x2,0x3,0x3,0x2,0x2,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x80,0x80,0xE0,0xE0,0x80
	.DB  0x80,0x80,0x0,0x0,0x0,0x0,0x80,0x80
	.DB  0x80,0x0,0x0,0x0,0x0,0x0,0x80,0x80
	.DB  0x80,0x80,0x80,0x0,0x0,0x0,0x0,0x80
	.DB  0x80,0x80,0x0,0x80,0x80,0x80,0x0,0x0
	.DB  0x80,0x80,0x80,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x1
	.DB  0x2,0x2,0x2,0x2,0x2,0x1,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x3F,0x7F,0x40
	.DB  0x40,0x20,0x0,0x0,0x1E,0x3F,0x44,0x44
	.DB  0x44,0x47,0x26,0x0,0x0,0x33,0x7B,0x4C
	.DB  0x44,0x24,0x7F,0x7F,0x40,0x0,0x0,0x40
	.DB  0x7F,0x7F,0x41,0x0,0x40,0x7F,0x7F,0x41
	.DB  0x0,0x40,0x7F,0x7F,0x40,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
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

_0x13:
	.DB  0x9
_0x0:
	.DB  0x4D,0x65,0x68,0x64,0x69,0x20,0x5A,0x65
	.DB  0x69,0x6E,0x61,0x6C,0x69,0x0
_0x2000003:
	.DB  LOW(_nop_function),HIGH(_nop_function)
_0x2000004:
	.DB  0xFF

__GLOBAL_INI_TBL:
	.DW  0x01
	.DW  0x05
	.DW  _0x13*2

	.DW  0x02
	.DW  _glcd_free_fcn
	.DW  _0x2000003*2

	.DW  0x01
	.DW  _stack_pointer_G100
	.DW  _0x2000004*2

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
;Date    : 6/13/2011
;Author  : NeVaDa
;Company :
;Comments:
;
;
;Chip type               : ATmega16
;Program type            : Application
;AVR Core Clock frequency: 12.000000 MHz
;Memory model            : Small
;External RAM size       : 0
;Data Stack size         : 256
;*****************************************************/
;#define NORMAL_DELAY     1
;#define TIMER_DELAY      2
;#define GLCD_DELAY_TYPE  TIMER_DELAY
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
;#include <glcd128x64td.h>
;#include <delay.h>
;
;#if GLCD_DELAY_TYPE == TIMER_DELAY
;// Timer 0 output compare interrupt service routine
;interrupt [TIM0_COMP] void timer0_comp_isr(void)
; 0000 0022 {

	.CSEG
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
; 0000 0023 // Place your code here
; 0000 0024   timer_isr();
	RCALL _timer_isr
; 0000 0025 }
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
;#endif
;
;#if GLCD_DELAY_TYPE == TIMER_DELAY
;unsigned char TCCR0_value = 0x09;
;void timer_start (void)
; 0000 002B {
_timer_start:
; 0000 002C   TCCR0 = TCCR0_value;
	OUT  0x33,R5
; 0000 002D }
	RET
;
;void timer_stop (void)
; 0000 0030 {
_timer_stop:
; 0000 0031   TCCR0 = 0x08;
	LDI  R30,LOW(8)
	OUT  0x33,R30
; 0000 0032   TCNT0 = 0x00;
	LDI  R30,LOW(0)
	OUT  0x32,R30
; 0000 0033 }
	RET
;
;void set_ctc_7us (void)
; 0000 0036 {
_set_ctc_7us:
; 0000 0037   TCCR0_value = 0x09;
	LDI  R30,LOW(9)
	MOV  R5,R30
; 0000 0038   OCR0 = 0x53;
	LDI  R30,LOW(83)
	RJMP _0x204000A
; 0000 0039 }
;
;void set_ctc_10ms (void)
; 0000 003C {
_set_ctc_10ms:
; 0000 003D   TCCR0_value = 0x0D;
	LDI  R30,LOW(13)
	MOV  R5,R30
; 0000 003E   OCR0 = 0x74;
	LDI  R30,LOW(116)
_0x204000A:
	OUT  0x3C,R30
; 0000 003F }
	RET
;
;/*void portc_tgl(void)
;{
;/}*/
;#endif
;
;// Declare your global variables here
;flash char glcd_intro_bmp[1024] = {
;   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
;   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
;   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  2,  2,254,254,254,
; 254,  2,  2,  0,  0,  2,  2,254,254,254,254,  2,  2,  0,  0,  0,
;   0,  2,  2,254,  2,  2,  0,  0,126, 30,  6,  2,  2,254,254,254,
; 254,  2,  2,  6, 30,126,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
;   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
;   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
;   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
;   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
;   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,255,255,255,
; 255,  0,  0,  0,  0,  0,  0,255,255,255,255,  0,  0,  0,  0,  0,
;   0,  0,  0,255,  0,  0,  0,  0,  0,  0,  0,  0,  0,255,255,255,
; 255,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
;   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
;   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
;   0,  0,  0,  0,  0,  0,128,128,128,128,  0,128,  0,  0,  0,  0,
;   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
;   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  4,  4,  7,  7,  7,
;   7,  4,  4,  0,  0,  0,128,128,129,131,135,  7,  6,  4,  4,  4,
; 132,130,131,128,128,  0,  0,  0,  0,  0,  4,  4,  4,  7,135,135,
; 135,  4,  4,  4,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
;   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
;   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
;   0,  0,  0,  0, 14, 25, 48, 48, 48, 97, 99,199,128,  0,  0, 32,
; 224,224,  0,  0, 32,224,224,  0,  0,  0, 32,224,224, 64, 32, 32,
;  32,192,128,  0,  0,128,192, 32, 32, 32,192,128,  0,  0, 32,224,
; 224, 64, 32, 96, 96,  0,  0,  0,255,  1, 31,254,224,  0,224, 30,
;   1,255,255,  0,  0,  0,  0,  0, 32,227,227,  0,  0,  0,  0,255,
; 255,  0,  0,  0,128,192, 32, 32, 32,192,128,  0,  0,192,224, 32,
;  32, 32,224,192,  0,  0,  0,192,224, 32, 32, 32,192,192, 96, 96,
;   0,128,192, 32, 32, 32,192,128,  0,  0,  0,  0,  0,  0,  0,  0,
;   0,  0,  0,  0, 30, 12,  8, 16, 16, 16, 16,  8,  7,  0,  0,  0,
;  15, 31, 16, 16,  8, 31, 31, 16,  0,  0,  0,255,255,  8, 16, 16,
;  16, 15,  7,  0,  0,  7, 15, 17, 17, 17, 17,  9,  0,  0, 16, 31,
;  31, 16, 16,  0,  0,  0, 16, 16, 31, 16, 16,  1, 31, 30,  1, 16,
;  16, 31, 31, 16, 16,  0,  0,  0, 16, 31, 31, 16,  0,  0, 16, 31,
;  31, 16,  0,  0,  7, 15, 17, 17, 17, 17,  9,  0,  0, 12, 30, 19,
;  17,  9, 31, 31, 16,  0,  0,185,119, 52, 52, 52, 55, 51,224,  0,
;   0,  7, 15, 17, 17, 17, 17,  9,  0,  0,  0,  0,  0,  0,  0,  0,
;   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
;   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  2,  3,  3,  2,  2,  0,
;   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,128,128,224,224,128,
; 128,128,  0,  0,  0,  0,128,128,128,  0,  0,  0,  0,  0,128,128,
; 128,128,128,  0,  0,  0,  0,128,128,128,  0,128,128,128,  0,  0,
; 128,128,128,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
;   0,  0,  0,  0,  0,  0,  0,  1,  2,  2,  2,  2,  2,  1,  0,  0,
;   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
;   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
;   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
;   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 63,127, 64,
;  64, 32,  0,  0, 30, 63, 68, 68, 68, 71, 38,  0,  0, 51,123, 76,
;  68, 36,127,127, 64,  0,  0, 64,127,127, 65,  0, 64,127,127, 65,
;   0, 64,127,127, 64,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
;   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
;   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
;   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
;   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
;   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
;   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
;   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
;   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
;   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
;   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0
;};
;void main(void)
; 0000 008A {
_main:
; 0000 008B // Declare your local variables here
; 0000 008C 
; 0000 008D // Input/Output Ports initialization
; 0000 008E // Port A initialization
; 0000 008F // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 0090 // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 0091 PORTA=0x00;
	LDI  R30,LOW(0)
	OUT  0x1B,R30
; 0000 0092 DDRA=0x00;
	OUT  0x1A,R30
; 0000 0093 
; 0000 0094 // Port B initialization
; 0000 0095 // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 0096 // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 0097 PORTB=0x00;
	OUT  0x18,R30
; 0000 0098 DDRB=0x00;
	OUT  0x17,R30
; 0000 0099 
; 0000 009A // Port C initialization
; 0000 009B // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 009C // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 009D PORTC=0x00;
	OUT  0x15,R30
; 0000 009E DDRC=0xFF;
	LDI  R30,LOW(255)
	OUT  0x14,R30
; 0000 009F 
; 0000 00A0 // Port D initialization
; 0000 00A1 // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 00A2 // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 00A3 PORTD=0x00;
	LDI  R30,LOW(0)
	OUT  0x12,R30
; 0000 00A4 DDRD=0x00;
	OUT  0x11,R30
; 0000 00A5 
; 0000 00A6 #if GLCD_DELAY_TYPE == NORMAL_DELAY
; 0000 00A7 // Timer/Counter 0 initialization
; 0000 00A8 // Clock source: System Clock
; 0000 00A9 // Clock value: Timer 0 Stopped
; 0000 00AA // Mode: Normal top=0xFF
; 0000 00AB // OC0 output: Disconnected
; 0000 00AC TCCR0=0x00;
; 0000 00AD TCNT0=0x00;
; 0000 00AE OCR0=0x00;
; 0000 00AF #elif GLCD_DELAY_TYPE == TIMER_DELAY
; 0000 00B0 // Timer/Counter 0 initialization
; 0000 00B1 // Clock source: System Clock
; 0000 00B2 // Clock value: Timer 0 Stopped
; 0000 00B3 // Mode: CTC top=OCR0
; 0000 00B4 // OC0 output: Disconnected
; 0000 00B5 TCCR0=0x08;
	LDI  R30,LOW(8)
	OUT  0x33,R30
; 0000 00B6 TCNT0=0x00;
	LDI  R30,LOW(0)
	OUT  0x32,R30
; 0000 00B7 OCR0 = 0x53/*((unsigned char)((_MCU_CLOCK_FREQUENCY_*7)/1000000))*/;
	LDI  R30,LOW(83)
	OUT  0x3C,R30
; 0000 00B8 #endif
; 0000 00B9 
; 0000 00BA // Timer/Counter 1 initialization
; 0000 00BB // Clock source: System Clock
; 0000 00BC // Clock value: Timer1 Stopped
; 0000 00BD // Mode: Normal top=0xFFFF
; 0000 00BE // OC1A output: Discon.
; 0000 00BF // OC1B output: Discon.
; 0000 00C0 // Noise Canceler: Off
; 0000 00C1 // Input Capture on Falling Edge
; 0000 00C2 // Timer1 Overflow Interrupt: Off
; 0000 00C3 // Input Capture Interrupt: Off
; 0000 00C4 // Compare A Match Interrupt: Off
; 0000 00C5 // Compare B Match Interrupt: Off
; 0000 00C6 TCCR1A=0x00;
	LDI  R30,LOW(0)
	OUT  0x2F,R30
; 0000 00C7 TCCR1B=0x00;
	OUT  0x2E,R30
; 0000 00C8 TCNT1H=0x00;
	OUT  0x2D,R30
; 0000 00C9 TCNT1L=0x00;
	OUT  0x2C,R30
; 0000 00CA ICR1H=0x00;
	OUT  0x27,R30
; 0000 00CB ICR1L=0x00;
	OUT  0x26,R30
; 0000 00CC OCR1AH=0x00;
	OUT  0x2B,R30
; 0000 00CD OCR1AL=0x00;
	OUT  0x2A,R30
; 0000 00CE OCR1BH=0x00;
	OUT  0x29,R30
; 0000 00CF OCR1BL=0x00;
	OUT  0x28,R30
; 0000 00D0 
; 0000 00D1 // Timer/Counter 2 initialization
; 0000 00D2 // Clock source: System Clock
; 0000 00D3 // Clock value: Timer2 Stopped
; 0000 00D4 // Mode: Normal top=0xFF
; 0000 00D5 // OC2 output: Disconnected
; 0000 00D6 ASSR=0x00;
	OUT  0x22,R30
; 0000 00D7 TCCR2=0x00;
	OUT  0x25,R30
; 0000 00D8 TCNT2=0x00;
	OUT  0x24,R30
; 0000 00D9 OCR2=0x00;
	OUT  0x23,R30
; 0000 00DA 
; 0000 00DB // External Interrupt(s) initialization
; 0000 00DC // INT0: Off
; 0000 00DD // INT1: Off
; 0000 00DE // INT2: Off
; 0000 00DF MCUCR=0x00;
	OUT  0x35,R30
; 0000 00E0 MCUCSR=0x00;
	OUT  0x34,R30
; 0000 00E1 
; 0000 00E2 // Timer(s)/Counter(s) Interrupt(s) initialization
; 0000 00E3 #if GLCD_DELAY_TYPE == NORMAL_DELAY
; 0000 00E4 TIMSK=0x00;
; 0000 00E5 #elif GLCD_DELAY_TYPE == TIMER_DELAY
; 0000 00E6 TIMSK=0x02;
	LDI  R30,LOW(2)
	OUT  0x39,R30
; 0000 00E7 #endif
; 0000 00E8 
; 0000 00E9 // USART initialization
; 0000 00EA // USART disabled
; 0000 00EB UCSRB=0x00;
	LDI  R30,LOW(0)
	OUT  0xA,R30
; 0000 00EC 
; 0000 00ED // Analog Comparator initialization
; 0000 00EE // Analog Comparator: Off
; 0000 00EF // Analog Comparator Input Capture by Timer/Counter 1: Off
; 0000 00F0 ACSR=0x80;
	LDI  R30,LOW(128)
	OUT  0x8,R30
; 0000 00F1 SFIOR=0x00;
	LDI  R30,LOW(0)
	OUT  0x30,R30
; 0000 00F2 
; 0000 00F3 // ADC initialization
; 0000 00F4 // ADC disabled
; 0000 00F5 ADCSRA=0x00;
	OUT  0x6,R30
; 0000 00F6 
; 0000 00F7 // SPI initialization
; 0000 00F8 // SPI disabled
; 0000 00F9 SPCR=0x00;
	OUT  0xD,R30
; 0000 00FA 
; 0000 00FB // TWI initialization
; 0000 00FC // TWI disabled
; 0000 00FD TWCR=0x00;
	OUT  0x36,R30
; 0000 00FE 
; 0000 00FF #if GLCD_DELAY_TYPE == TIMER_DELAY
; 0000 0100 // Global enable interrupts
; 0000 0101 #asm("sei")
	sei
; 0000 0102 #endif
; 0000 0103 
; 0000 0104 #if GLCD_DELAY_TYPE == TIMER_DELAY
; 0000 0105 timer_interrupt_enable = (void (*)())(timer_start);
	LDI  R30,LOW(_timer_start)
	LDI  R31,HIGH(_timer_start)
	STS  _timer_interrupt_enable,R30
	STS  _timer_interrupt_enable+1,R31
; 0000 0106 timer_interrupt_disable = (void (*)())(timer_stop);
	LDI  R30,LOW(_timer_stop)
	LDI  R31,HIGH(_timer_stop)
	STS  _timer_interrupt_disable,R30
	STS  _timer_interrupt_disable+1,R31
; 0000 0107 set_delay_7us = (void (*)())(set_ctc_7us);
	LDI  R30,LOW(_set_ctc_7us)
	LDI  R31,HIGH(_set_ctc_7us)
	STS  _set_delay_7us,R30
	STS  _set_delay_7us+1,R31
; 0000 0108 set_delay_10ms = (void (*)())(set_ctc_10ms);
	LDI  R30,LOW(_set_ctc_10ms)
	LDI  R31,HIGH(_set_ctc_10ms)
	STS  _set_delay_10ms,R30
	STS  _set_delay_10ms+1,R31
; 0000 0109 //glcd_free_fcn = (void (*)())(portc_tgl);
; 0000 010A #endif
; 0000 010B 
; 0000 010C glcd_define (&PORTB, &PORTA, 2, &PORTA, 3, &PORTA, 4, &PORTA, 5, &PORTA, 6, &PORTA, 7);
	LDI  R30,LOW(56)
	LDI  R31,HIGH(56)
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0x0
	LDI  R30,LOW(2)
	ST   -Y,R30
	CALL SUBOPT_0x0
	LDI  R30,LOW(3)
	ST   -Y,R30
	CALL SUBOPT_0x0
	LDI  R30,LOW(4)
	ST   -Y,R30
	CALL SUBOPT_0x0
	LDI  R30,LOW(5)
	ST   -Y,R30
	CALL SUBOPT_0x0
	LDI  R30,LOW(6)
	ST   -Y,R30
	CALL SUBOPT_0x0
	LDI  R30,LOW(7)
	ST   -Y,R30
	RCALL _glcd_define
; 0000 010D glcd_init ();
	RCALL _glcd_init
; 0000 010E while (glcd_status());
_0x3:
	RCALL _glcd_status
	CPI  R30,0
	BRNE _0x3
; 0000 010F glcd_clear();
	RCALL _glcd_clear
; 0000 0110 while (glcd_status());
_0x6:
	RCALL _glcd_status
	CPI  R30,0
	BRNE _0x6
; 0000 0111 glcd_putsf (3,3,"Mehdi Zeinali");
	LDI  R30,LOW(3)
	ST   -Y,R30
	ST   -Y,R30
	__POINTW1FN _0x0,0
	ST   -Y,R31
	ST   -Y,R30
	RCALL _glcd_putsf
; 0000 0112 while (glcd_status());
_0x9:
	RCALL _glcd_status
	CPI  R30,0
	BRNE _0x9
; 0000 0113 glcd_putbmp(glcd_intro_bmp);
	LDI  R30,LOW(_glcd_intro_bmp*2)
	LDI  R31,HIGH(_glcd_intro_bmp*2)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _glcd_putbmp
; 0000 0114 while (glcd_status());
_0xC:
	RCALL _glcd_status
	CPI  R30,0
	BRNE _0xC
; 0000 0115 delay_ms(1000);
	LDI  R30,LOW(1000)
	LDI  R31,HIGH(1000)
	ST   -Y,R31
	ST   -Y,R30
	CALL _delay_ms
; 0000 0116 glcd_clear();
	RCALL _glcd_clear
; 0000 0117 
; 0000 0118 while (1)
_0xF:
; 0000 0119       {
; 0000 011A       // Place your code here
; 0000 011B       }
	RJMP _0xF
; 0000 011C }
_0x12:
	RJMP _0x12

	.CSEG
_glcd_define:
	LDD  R30,Y+18
	LDD  R31,Y+18+1
	STS  _glcd_data_address_G100,R30
	STS  _glcd_data_address_G100+1,R31
	LDD  R30,Y+16
	LDD  R31,Y+16+1
	STS  _glcd_rs_address_G100,R30
	STS  _glcd_rs_address_G100+1,R31
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	STS  _glcd_rw_address_G100,R30
	STS  _glcd_rw_address_G100+1,R31
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	STS  _glcd_en_address_G100,R30
	STS  _glcd_en_address_G100+1,R31
	LDD  R30,Y+7
	LDD  R31,Y+7+1
	STS  _glcd_cs1_address_G100,R30
	STS  _glcd_cs1_address_G100+1,R31
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	STS  _glcd_cs2_address_G100,R30
	STS  _glcd_cs2_address_G100+1,R31
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	STS  _glcd_rst_address_G100,R30
	STS  _glcd_rst_address_G100+1,R31
	LDD  R30,Y+15
	STS  _glcd_rs_bit_pos_G100,R30
	LDD  R30,Y+12
	STS  _glcd_rw_bit_pos_G100,R30
	LDD  R30,Y+9
	STS  _glcd_en_bit_pos_G100,R30
	LDD  R30,Y+6
	STS  _glcd_cs1_bit_pos_G100,R30
	LDD  R30,Y+3
	STS  _glcd_cs2_bit_pos_G100,R30
	LD   R30,Y
	STS  _glcd_rst_bit_pos_G100,R30
	LDS  R30,_glcd_data_address_G100
	LDS  R31,_glcd_data_address_G100+1
	SBIW R30,1
	LDI  R26,LOW(255)
	STD  Z+0,R26
	LDS  R30,_glcd_rs_address_G100
	LDS  R31,_glcd_rs_address_G100+1
	SBIW R30,1
	MOVW R22,R30
	LD   R1,Z
	CALL SUBOPT_0x1
	OR   R30,R1
	MOVW R26,R22
	ST   X,R30
	LDS  R30,_glcd_rw_address_G100
	LDS  R31,_glcd_rw_address_G100+1
	SBIW R30,1
	MOVW R22,R30
	LD   R1,Z
	CALL SUBOPT_0x2
	OR   R30,R1
	MOVW R26,R22
	CALL SUBOPT_0x3
	CALL SUBOPT_0x4
	LDS  R30,_glcd_en_address_G100
	LDS  R31,_glcd_en_address_G100+1
	SBIW R30,1
	MOVW R22,R30
	LD   R1,Z
	LDS  R30,_glcd_en_bit_pos_G100
	CALL SUBOPT_0x5
	LDS  R30,_glcd_cs1_address_G100
	LDS  R31,_glcd_cs1_address_G100+1
	SBIW R30,1
	MOVW R22,R30
	LD   R1,Z
	LDS  R30,_glcd_cs1_bit_pos_G100
	CALL SUBOPT_0x5
	LDS  R30,_glcd_cs2_address_G100
	LDS  R31,_glcd_cs2_address_G100+1
	SBIW R30,1
	MOVW R22,R30
	LD   R1,Z
	LDS  R30,_glcd_cs2_bit_pos_G100
	CALL SUBOPT_0x5
	LDS  R30,_glcd_rst_address_G100
	LDS  R31,_glcd_rst_address_G100+1
	SBIW R30,1
	MOVW R22,R30
	LD   R1,Z
	LDS  R30,_glcd_rst_bit_pos_G100
	CALL SUBOPT_0x5
	ADIW R28,20
	RET
_nop_function:
	RET

	.DSEG

	.CSEG
_push:
	CALL SUBOPT_0x6
	ADIW R30,1
	SBIW R30,6
	BRLT _0x2000006
	LDS  R26,_stack_pointer_G100
	CPI  R26,LOW(0xFF)
	BRNE _0x2000005
_0x2000006:
	LDS  R30,_stack_pointer_G100
	SUBI R30,-LOW(1)
	STS  _stack_pointer_G100,R30
	CALL SUBOPT_0x6
	SUBI R30,LOW(-_function_status)
	SBCI R31,HIGH(-_function_status)
	LD   R26,Y
	STD  Z+0,R26
	CALL SUBOPT_0x7
	ADD  R30,R26
	ADC  R31,R27
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	STD  Z+0,R26
	STD  Z+1,R27
	LDI  R30,LOW(0)
	RJMP _0x2040003
_0x2000005:
	LDI  R30,LOW(1)
	RJMP _0x2040003
_run_function:
	LDS  R26,_stack_pointer_G100
	CPI  R26,LOW(0xFF)
	BREQ _0x2000009
	CALL SUBOPT_0x7
	ADD  R26,R30
	ADC  R27,R31
	CALL __GETW1P
	RET
_0x2000009:
	LDI  R30,LOW(_nop_function)
	LDI  R31,HIGH(_nop_function)
	RET
	RET
_pull_void:
	LDS  R26,_stack_pointer_G100
	CPI  R26,LOW(0xFF)
	BREQ _0x200000B
	CALL SUBOPT_0x6
	SUBI R30,LOW(-_function_status)
	SBCI R31,HIGH(-_function_status)
	LDI  R26,LOW(0)
	STD  Z+0,R26
	LDS  R30,_stack_pointer_G100
	SUBI R30,LOW(1)
	STS  _stack_pointer_G100,R30
	LDI  R30,LOW(0)
	RET
_0x200000B:
	LDI  R30,LOW(1)
	RET
	RET
_glcd_status:
	LDS  R26,_stack_pointer_G100
	LDI  R30,LOW(6)
	CALL __LTB12U
	RET
_timer_isr:
	CALL SUBOPT_0x6
	CALL SUBOPT_0x8
	BRNE _0x2000010
	CALL SUBOPT_0x6
	CALL SUBOPT_0x9
	__CALL1MN _timer_interrupt_enable,0
	RET
	RJMP _0x200000F
_0x2000010:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0x200000F
	__CALL1MN _timer_interrupt_disable,0
	CALL SUBOPT_0xA
	LDS  R26,_stack_pointer_G100
	CPI  R26,LOW(0xFF)
	BRNE _0x2000012
	__CALL1MN _glcd_free_fcn,0
_0x2000012:
	RET
_0x200000F:
	RET
_delay:
	LDI  R30,LOW(_timer_isr)
	LDI  R31,HIGH(_timer_isr)
	CALL SUBOPT_0xB
	RCALL _timer_isr
	RET
_glcd_unlock_lock_void:
	CALL SUBOPT_0x6
	CALL SUBOPT_0x8
	BRNE _0x2000016
	__CALL1MN _set_delay_7us,0
	CALL SUBOPT_0x6
	SUBI R30,LOW(-_function_status)
	SBCI R31,HIGH(-_function_status)
	LDI  R26,LOW(2)
	RJMP _0x2040008
_0x2000016:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0x2000017
	CALL SUBOPT_0xC
	RJMP _0x2040009
_0x2000017:
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	BRNE _0x2000015
	CALL SUBOPT_0xC
	CALL SUBOPT_0xD
	RJMP _0x2040004
_0x2000015:
	RET
_glcd_unlock_lock:
	LDI  R30,LOW(_glcd_unlock_lock_void)
	LDI  R31,HIGH(_glcd_unlock_lock_void)
	CALL SUBOPT_0xB
	RCALL _glcd_unlock_lock_void
	RET
_glcd_init_void:
	CALL SUBOPT_0x6
	CALL SUBOPT_0x8
	BRNE _0x200001C
	LDI  R30,LOW(0)
	STS  _i_S100000A000,R30
	CALL SUBOPT_0xE
	CALL SUBOPT_0xD
	__CALL1MN _set_delay_10ms,0
	CALL SUBOPT_0x6
	SUBI R30,LOW(-_function_status)
	SBCI R31,HIGH(-_function_status)
	LDI  R26,LOW(2)
	RJMP _0x2040008
_0x200001C:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0x200001D
	CALL SUBOPT_0xE
_0x2040009:
	LDI  R26,LOW(1)
	CALL SUBOPT_0xF
	CALL SUBOPT_0x6
	SUBI R30,LOW(-_function_status)
	SBCI R31,HIGH(-_function_status)
	LDI  R26,LOW(3)
_0x2040008:
	STD  Z+0,R26
	RCALL _delay
	RET
	RJMP _0x200001B
_0x200001D:
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	BRNE _0x200001E
	CALL SUBOPT_0x10
	CALL SUBOPT_0x4
	CALL SUBOPT_0x11
	CALL SUBOPT_0xD
	CALL SUBOPT_0x12
	CALL SUBOPT_0xF
	CALL SUBOPT_0x13
	LDI  R30,LOW(62)
	ST   X,R30
	RJMP _0x2040006
_0x200001E:
	CPI  R30,LOW(0x4)
	LDI  R26,HIGH(0x4)
	CPC  R31,R26
	BRNE _0x200001F
	CALL SUBOPT_0x13
	LDI  R30,LOW(64)
	ST   X,R30
	CALL SUBOPT_0x6
	SUBI R30,LOW(-_function_status)
	SBCI R31,HIGH(-_function_status)
	LDI  R26,LOW(5)
	RJMP _0x2040005
_0x200001F:
	CPI  R30,LOW(0x5)
	LDI  R26,HIGH(0x5)
	CPC  R31,R26
	BRNE _0x2000020
	CALL SUBOPT_0x13
	LDI  R30,LOW(184)
	ST   X,R30
	CALL SUBOPT_0x6
	SUBI R30,LOW(-_function_status)
	SBCI R31,HIGH(-_function_status)
	LDI  R26,LOW(6)
	RJMP _0x2040005
_0x2000020:
	CPI  R30,LOW(0x6)
	LDI  R26,HIGH(0x6)
	CPC  R31,R26
	BRNE _0x2000021
	CALL SUBOPT_0x13
	LDI  R30,LOW(63)
	ST   X,R30
	LDS  R30,_i_S100000A000
	SUBI R30,-LOW(1)
	STS  _i_S100000A000,R30
	LDS  R26,_i_S100000A000
	CPI  R26,LOW(0x2)
	BRSH _0x2000022
	CALL SUBOPT_0x6
	SUBI R30,LOW(-_function_status)
	SBCI R31,HIGH(-_function_status)
	LDI  R26,LOW(7)
	RJMP _0x2000066
_0x2000022:
	CALL SUBOPT_0x6
	SUBI R30,LOW(-_function_status)
	SBCI R31,HIGH(-_function_status)
	LDI  R26,LOW(8)
_0x2000066:
	STD  Z+0,R26
	RJMP _0x2040007
_0x2000021:
	CPI  R30,LOW(0x7)
	LDI  R26,HIGH(0x7)
	CPC  R31,R26
	BRNE _0x2000024
	CALL SUBOPT_0x11
	LDI  R26,LOW(1)
	CALL __LSLB12
	EOR  R30,R1
	MOV  R26,R22
	ST   X,R30
	CALL SUBOPT_0x12
	CALL __LSLB12
	EOR  R30,R1
	MOV  R26,R22
	ST   X,R30
	CALL SUBOPT_0x13
	LDI  R30,LOW(62)
	ST   X,R30
	RJMP _0x2040006
_0x2000024:
	CPI  R30,LOW(0x8)
	LDI  R26,HIGH(0x8)
	CPC  R31,R26
	BRNE _0x200001B
	RJMP _0x2040004
_0x200001B:
	RET
_glcd_init:
	LDI  R30,LOW(_glcd_init_void)
	LDI  R31,HIGH(_glcd_init_void)
	CALL SUBOPT_0xB
	RCALL _glcd_init_void
	RET
_glcd_writebyte_void:
	CALL SUBOPT_0x6
	CALL SUBOPT_0x8
	BRNE _0x2000029
	LDI  R30,LOW(64)
	CP   R4,R30
	BRLO _0x200002A
	CALL SUBOPT_0x11
	CALL SUBOPT_0xD
	CALL SUBOPT_0x12
	CALL __LSLB12
	OR   R30,R1
	RJMP _0x2000067
_0x200002A:
	CALL SUBOPT_0x11
	LDI  R26,LOW(1)
	CALL SUBOPT_0xF
	CALL SUBOPT_0x12
	CALL __LSLB12
	COM  R30
	AND  R30,R1
_0x2000067:
	MOV  R26,R22
	ST   X,R30
	CALL SUBOPT_0x10
	COM  R30
	AND  R30,R1
	MOV  R26,R22
	CALL SUBOPT_0x3
	CALL SUBOPT_0x4
	MOV  R30,R7
	ORI  R30,LOW(0xB8)
	CALL SUBOPT_0x13
	ST   X,R30
	CALL SUBOPT_0x6
	SUBI R30,LOW(-_function_status)
	SBCI R31,HIGH(-_function_status)
	LDI  R26,LOW(2)
	RJMP _0x2040005
_0x2000029:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0x200002C
	CALL SUBOPT_0x10
	COM  R30
	AND  R30,R1
	MOV  R26,R22
	CALL SUBOPT_0x3
	CALL SUBOPT_0x4
	MOV  R30,R4
	ORI  R30,0x40
	CALL SUBOPT_0x13
	ST   X,R30
	CALL SUBOPT_0x6
	SUBI R30,LOW(-_function_status)
	SBCI R31,HIGH(-_function_status)
	LDI  R26,LOW(3)
	RJMP _0x2040005
_0x200002C:
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	BRNE _0x200002D
	CALL SUBOPT_0x10
	OR   R30,R1
	MOV  R26,R22
	CALL SUBOPT_0x3
	CALL SUBOPT_0x4
	CALL SUBOPT_0x13
	ST   X,R6
_0x2040006:
	LDS  R30,_stack_pointer_G100
	LDI  R31,0
	SUBI R30,LOW(-_function_status)
	SBCI R31,HIGH(-_function_status)
	LDI  R26,LOW(4)
_0x2040005:
	STD  Z+0,R26
_0x2040007:
	RCALL _glcd_unlock_lock
	RET
	RJMP _0x2000028
_0x200002D:
	CPI  R30,LOW(0x4)
	LDI  R26,HIGH(0x4)
	CPC  R31,R26
	BRNE _0x2000028
_0x2040004:
	RCALL _pull_void
	RCALL _run_function
	ICALL
	RET
_0x2000028:
	RET
_glcd_writebyte:
	LDD  R4,Y+2
	LDD  R7,Y+1
	LDD  R6,Y+0
	LDI  R30,LOW(_glcd_writebyte_void)
	LDI  R31,HIGH(_glcd_writebyte_void)
	CALL SUBOPT_0xB
	RCALL _glcd_writebyte_void
	RJMP _0x2040003
_glcd_putchar_void:
	CALL SUBOPT_0x6
	CALL SUBOPT_0x8
	BRNE _0x2000039
	LDI  R30,LOW(0)
	STS  _i_S1000010001,R30
	MOV  R30,R10
	LDI  R31,0
	SBIW R30,32
	MOV  R10,R30
	CALL SUBOPT_0x6
	CALL SUBOPT_0x9
	CALL SUBOPT_0x14
	RJMP _0x2040002
_0x2000039:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0x2000038
	LDS  R30,_i_S1000010001
	SUBI R30,-LOW(1)
	STS  _i_S1000010001,R30
	LDS  R26,_i_S1000010001
	CPI  R26,LOW(0x6)
	BRSH _0x200003B
	INC  R8
	CALL SUBOPT_0x14
	MOVW R26,R30
	LDS  R30,_i_S1000010001
	LDI  R31,0
	CALL SUBOPT_0x15
	RJMP _0x200003C
_0x200003B:
	CALL SUBOPT_0xA
_0x200003C:
	RET
_0x2000038:
	RET
_glcd_putchar:
	LDD  R8,Y+2
	LDD  R11,Y+1
	LDD  R10,Y+0
	LDI  R30,LOW(_glcd_putchar_void)
	LDI  R31,HIGH(_glcd_putchar_void)
	CALL SUBOPT_0xB
	RCALL _glcd_putchar_void
_0x2040003:
	ADIW R28,3
	RET
_glcd_putsf_void:
	CALL SUBOPT_0x6
	CALL SUBOPT_0x8
	BRNE _0x200004A
	LDS  R30,_glcd_putsf_str
	LDS  R31,_glcd_putsf_str+1
	LPM  R30,Z
	CPI  R30,0
	BREQ _0x200004C
	LDS  R30,_glcd_putsf_column
	ST   -Y,R30
	LDS  R30,_glcd_putsf_page
	ST   -Y,R30
	LDI  R26,LOW(_glcd_putsf_str)
	LDI  R27,HIGH(_glcd_putsf_str)
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
	SBIW R30,1
	LPM  R30,Z
	ST   -Y,R30
	RCALL _glcd_putchar
	LDS  R30,_glcd_putsf_column
	SUBI R30,-LOW(6)
	STS  _glcd_putsf_column,R30
	RJMP _0x200004D
_0x200004C:
	CALL SUBOPT_0xA
_0x200004D:
	RET
_0x200004A:
	RET
_glcd_putsf:
	LDD  R30,Y+3
	STS  _glcd_putsf_column,R30
	LDD  R30,Y+2
	STS  _glcd_putsf_page,R30
	LD   R30,Y
	LDD  R31,Y+1
	STS  _glcd_putsf_str,R30
	STS  _glcd_putsf_str+1,R31
	LDI  R30,LOW(_glcd_putsf_void)
	LDI  R31,HIGH(_glcd_putsf_void)
	CALL SUBOPT_0xB
	RCALL _glcd_putsf_void
	ADIW R28,4
	RET
_glcd_clear_void:
	CALL SUBOPT_0x6
	CALL SUBOPT_0x8
	BRNE _0x2000056
	LDI  R30,LOW(0)
	STS  _i_S100001A000,R30
	STS  _j_S100001A000,R30
	CALL SUBOPT_0x6
	CALL SUBOPT_0x9
	LDI  R30,LOW(0)
	ST   -Y,R30
	ST   -Y,R30
	RJMP _0x2040001
_0x2000056:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0x2000055
	LDS  R26,_i_S100001A000
	CPI  R26,LOW(0x7)
	BRNE _0x2000059
	LDS  R26,_j_S100001A000
	CPI  R26,LOW(0x7F)
	BRLO _0x200005B
_0x2000059:
	LDS  R26,_i_S100001A000
	CPI  R26,LOW(0x7)
	BRSH _0x2000058
_0x200005B:
	LDS  R30,_j_S100001A000
	SUBI R30,-LOW(1)
	STS  _j_S100001A000,R30
	LDS  R26,_j_S100001A000
	CPI  R26,LOW(0x80)
	BRNE _0x200005D
	LDI  R30,LOW(0)
	STS  _j_S100001A000,R30
	LDS  R30,_i_S100001A000
	SUBI R30,-LOW(1)
	STS  _i_S100001A000,R30
_0x200005D:
	LDS  R30,_j_S100001A000
	ST   -Y,R30
	LDS  R30,_i_S100001A000
	ST   -Y,R30
	LDI  R30,LOW(0)
	ST   -Y,R30
	RCALL _glcd_writebyte
	RJMP _0x200005E
_0x2000058:
	CALL SUBOPT_0xA
_0x200005E:
	RET
_0x2000055:
	RET
_glcd_clear:
	LDI  R30,LOW(_glcd_clear_void)
	LDI  R31,HIGH(_glcd_clear_void)
	CALL SUBOPT_0xB
	RCALL _glcd_clear_void
	RET
_glcd_putbmp_void:
	CALL SUBOPT_0x6
	CALL SUBOPT_0x8
	BRNE _0x2000062
	LDI  R30,LOW(0)
	STS  _i_S100001C000,R30
	STS  _i_S100001C000+1,R30
	CALL SUBOPT_0x6
	CALL SUBOPT_0x9
	LDI  R30,LOW(0)
	ST   -Y,R30
	ST   -Y,R30
	LDS  R30,_glcd_putbmp_bmp
	LDS  R31,_glcd_putbmp_bmp+1
_0x2040002:
	LPM  R30,Z
_0x2040001:
	ST   -Y,R30
	RCALL _glcd_writebyte
	RET
	RJMP _0x2000061
_0x2000062:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0x2000061
	LDI  R26,LOW(_i_S100001C000)
	LDI  R27,HIGH(_i_S100001C000)
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
	LDS  R26,_i_S100001C000
	LDS  R27,_i_S100001C000+1
	CPI  R26,LOW(0x400)
	LDI  R30,HIGH(0x400)
	CPC  R27,R30
	BRSH _0x2000064
	LDS  R30,_i_S100001C000
	LDS  R31,_i_S100001C000+1
	ANDI R30,LOW(0x7F)
	ANDI R31,HIGH(0x7F)
	ST   -Y,R30
	LDI  R30,LOW(128)
	LDI  R31,HIGH(128)
	CALL __DIVW21U
	ST   -Y,R30
	LDS  R30,_i_S100001C000
	LDS  R31,_i_S100001C000+1
	LDS  R26,_glcd_putbmp_bmp
	LDS  R27,_glcd_putbmp_bmp+1
	CALL SUBOPT_0x15
	RJMP _0x2000065
_0x2000064:
	CALL SUBOPT_0xA
_0x2000065:
	RET
_0x2000061:
	RET
_glcd_putbmp:
	LD   R30,Y
	LDD  R31,Y+1
	STS  _glcd_putbmp_bmp,R30
	STS  _glcd_putbmp_bmp+1,R31
	LDI  R30,LOW(_glcd_putbmp_void)
	LDI  R31,HIGH(_glcd_putbmp_void)
	CALL SUBOPT_0xB
	RCALL _glcd_putbmp_void
	ADIW R28,2
	RET

	.CSEG

	.DSEG
_timer_interrupt_enable:
	.BYTE 0x2
_timer_interrupt_disable:
	.BYTE 0x2
_set_delay_7us:
	.BYTE 0x2
_set_delay_10ms:
	.BYTE 0x2
_glcd_free_fcn:
	.BYTE 0x2
_glcd_data_address_G100:
	.BYTE 0x2
_glcd_rs_address_G100:
	.BYTE 0x2
_glcd_rs_bit_pos_G100:
	.BYTE 0x1
_glcd_rw_address_G100:
	.BYTE 0x2
_glcd_rw_bit_pos_G100:
	.BYTE 0x1
_glcd_en_address_G100:
	.BYTE 0x2
_glcd_en_bit_pos_G100:
	.BYTE 0x1
_glcd_cs1_address_G100:
	.BYTE 0x2
_glcd_cs1_bit_pos_G100:
	.BYTE 0x1
_glcd_cs2_address_G100:
	.BYTE 0x2
_glcd_cs2_bit_pos_G100:
	.BYTE 0x1
_glcd_rst_address_G100:
	.BYTE 0x2
_glcd_rst_bit_pos_G100:
	.BYTE 0x1
_function_stack:
	.BYTE 0xC
_function_status:
	.BYTE 0x6
_stack_pointer_G100:
	.BYTE 0x1
_i_S100000A000:
	.BYTE 0x1
_i_S1000010001:
	.BYTE 0x1
_glcd_puts_str:
	.BYTE 0x2
_glcd_puts_center_page:
	.BYTE 0x1
_glcd_puts_center_str:
	.BYTE 0x2
_glcd_putsf_column:
	.BYTE 0x1
_glcd_putsf_page:
	.BYTE 0x1
_glcd_putsf_str:
	.BYTE 0x2
_glcd_putsf_center_page:
	.BYTE 0x1
_glcd_putsf_center_str:
	.BYTE 0x2
_i_S100001A000:
	.BYTE 0x1
_j_S100001A000:
	.BYTE 0x1
_glcd_putbmp_bmp:
	.BYTE 0x2
_i_S100001C000:
	.BYTE 0x2

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x0:
	LDI  R30,LOW(59)
	LDI  R31,HIGH(59)
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x1:
	LDS  R30,_glcd_rs_bit_pos_G100
	LDI  R26,LOW(1)
	CALL __LSLB12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x2:
	LDS  R30,_glcd_rw_bit_pos_G100
	LDI  R26,LOW(1)
	CALL __LSLB12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:18 WORDS
SUBOPT_0x3:
	ST   X,R30
	LDS  R26,_glcd_rw_address_G100
	LDS  R27,_glcd_rw_address_G100+1
	MOV  R22,R26
	LD   R1,X
	RJMP SUBOPT_0x2

;OPTIMIZER ADDED SUBROUTINE, CALLED 9 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x4:
	COM  R30
	AND  R30,R1
	MOV  R26,R22
	ST   X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x5:
	LDI  R26,LOW(1)
	CALL __LSLB12
	OR   R30,R1
	MOVW R26,R22
	ST   X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 24 TIMES, CODE SIZE REDUCTION:66 WORDS
SUBOPT_0x6:
	LDS  R30,_stack_pointer_G100
	LDI  R31,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x7:
	LDS  R30,_stack_pointer_G100
	LDI  R26,LOW(_function_stack)
	LDI  R27,HIGH(_function_stack)
	LDI  R31,0
	LSL  R30
	ROL  R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:46 WORDS
SUBOPT_0x8:
	SUBI R30,LOW(-_function_status)
	SBCI R31,HIGH(-_function_status)
	LD   R30,Z
	LDI  R31,0
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x9:
	SUBI R30,LOW(-_function_status)
	SBCI R31,HIGH(-_function_status)
	LDI  R26,LOW(2)
	STD  Z+0,R26
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0xA:
	CALL _pull_void
	CALL _run_function
	ICALL
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:25 WORDS
SUBOPT_0xB:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(1)
	ST   -Y,R30
	JMP  _push

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xC:
	LDS  R26,_glcd_en_address_G100
	LDS  R27,_glcd_en_address_G100+1
	MOV  R22,R26
	LD   R1,X
	LDS  R30,_glcd_en_bit_pos_G100
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0xD:
	LDI  R26,LOW(1)
	CALL __LSLB12
	RJMP SUBOPT_0x4

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xE:
	LDS  R26,_glcd_rst_address_G100
	LDS  R27,_glcd_rst_address_G100+1
	MOV  R22,R26
	LD   R1,X
	LDS  R30,_glcd_rst_bit_pos_G100
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xF:
	CALL __LSLB12
	OR   R30,R1
	MOV  R26,R22
	ST   X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:15 WORDS
SUBOPT_0x10:
	LDS  R26,_glcd_rs_address_G100
	LDS  R27,_glcd_rs_address_G100+1
	MOV  R22,R26
	LD   R1,X
	RJMP SUBOPT_0x1

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:15 WORDS
SUBOPT_0x11:
	LDS  R26,_glcd_cs1_address_G100
	LDS  R27,_glcd_cs1_address_G100+1
	MOV  R22,R26
	LD   R1,X
	LDS  R30,_glcd_cs1_bit_pos_G100
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:18 WORDS
SUBOPT_0x12:
	LDS  R26,_glcd_cs2_address_G100
	LDS  R27,_glcd_cs2_address_G100+1
	MOV  R22,R26
	LD   R1,X
	LDS  R30,_glcd_cs2_bit_pos_G100
	LDI  R26,LOW(1)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0x13:
	LDS  R26,_glcd_data_address_G100
	LDS  R27,_glcd_data_address_G100+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x14:
	ST   -Y,R8
	ST   -Y,R11
	MOV  R30,R10
	LDI  R26,LOW(6)
	MUL  R30,R26
	MOVW R30,R0
	SUBI R30,LOW(-_glcd_font*2)
	SBCI R31,HIGH(-_glcd_font*2)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x15:
	ADD  R30,R26
	ADC  R31,R27
	LPM  R30,Z
	ST   -Y,R30
	JMP  _glcd_writebyte


	.CSEG
_delay_ms:
	ld   r30,y+
	ld   r31,y+
	adiw r30,0
	breq __delay_ms1
__delay_ms0:
	__DELAY_USW 0xBB8
	wdr
	sbiw r30,1
	brne __delay_ms0
__delay_ms1:
	ret

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

__LTB12U:
	CP   R26,R30
	LDI  R30,1
	BRLO __LTB12U1
	CLR  R30
__LTB12U1:
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

__GETW1P:
	LD   R30,X+
	LD   R31,X
	SBIW R26,1
	RET

;END OF CODE MARKER
__END_OF_CODE:
