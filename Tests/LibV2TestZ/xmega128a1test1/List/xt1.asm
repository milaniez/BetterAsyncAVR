
;CodeVisionAVR C Compiler V2.05.0 Professional
;(C) Copyright 1998-2010 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Chip type                : ATxmega128A1
;Program type             : Application
;Clock frequency          : 32.000000 MHz
;Memory model             : Small
;Optimize for             : Size
;(s)printf features       : int, width
;(s)scanf features        : int, width
;External RAM size        : 0
;Data Stack size          : 2048 byte(s)
;Heap size                : 0 byte(s)
;Promote 'char' to 'int'  : Yes
;'char' is unsigned       : Yes
;8 bit enums              : Yes
;global 'const' stored in FLASH: No
;Enhanced core instructions    : On
;Smart register allocation     : On
;Automatic register allocation : On

	#pragma AVRPART ADMIN PART_NAME ATxmega128A1
	#pragma AVRPART MEMORY PROG_FLASH 135168
	#pragma AVRPART MEMORY EEPROM 2048
	#pragma AVRPART MEMORY INT_SRAM SIZE 16383
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x2000

	#define CALL_SUPPORTED 1

	.LISTMAC
	.EQU CCP=0x34
	.EQU RAMPD=0x38
	.EQU RAMPX=0x39
	.EQU RAMPY=0x3A
	.EQU RAMPZ=0x3B
	.EQU EIND=0x3C
	.EQU WDT_CTRL=0x80
	.EQU PMIC_CTRL=0xA2
	.EQU NVM_ADDR0=0X01C0
	.EQU NVM_ADDR1=NVM_ADDR0+1
	.EQU NVM_ADDR2=NVM_ADDR1+1
	.EQU NVM_DATA0=NVM_ADDR0+4
	.EQU NVM_CMD=NVM_ADDR0+0xA
	.EQU NVM_CTRLA=NVM_ADDR0+0xB
	.EQU NVM_CTRLB=NVM_ADDR0+0xC
	.EQU NVM_STATUS=NVM_ADDR0+0xF
	.EQU PORTCFG_MPCMASK=0xB0
	.EQU PORTH_DIR=0x6E0
	.EQU PORTH_OUT=0x6E4
	.EQU PORTH_PIN0CTRL=0x6F0
	.EQU PORTJ_DIR=0x700
	.EQU PORTJ_OUT=0x704
	.EQU PORTJ_PIN0CTRL=0x710
	.EQU PORTK_DIR=0x720
	.EQU PORTK_OUT=0x724
	.EQU PORTK_PIN0CTRL=0x730
	.EQU EBI_CTRL=0x0440
	.EQU EBI_SDRAMCTRLA=EBI_CTRL+1
	.EQU EBI_REFRESHL=EBI_CTRL+4
	.EQU EBI_REFRESHH=EBI_CTRL+5
	.EQU EBI_INITDLYL=EBI_CTRL+6
	.EQU EBI_INITDLYH=EBI_CTRL+7
	.EQU EBI_SDRAMCTRLB=EBI_CTRL+8
	.EQU EBI_SDRAMCTRLC=EBI_CTRL+9
	.EQU EBI_CS0_CTRLA=EBI_CTRL+0x10
	.EQU EBI_CS0_CTRLB=EBI_CS0_CTRLA+1
	.EQU EBI_CS0_BASEADDRL=EBI_CS0_CTRLA+2
	.EQU EBI_CS0_BASEADDRH=EBI_CS0_CTRLA+3
	.EQU EBI_CS1_CTRLA=EBI_CTRL+0x14
	.EQU EBI_CS1_CTRLB=EBI_CS1_CTRLA+1
	.EQU EBI_CS1_BASEADDRL=EBI_CS1_CTRLA+2
	.EQU EBI_CS1_BASEADDRH=EBI_CS1_CTRLA+3
	.EQU EBI_CS2_CTRLA=EBI_CTRL+0x18
	.EQU EBI_CS2_CTRLB=EBI_CS2_CTRLA+1
	.EQU EBI_CS2_BASEADDRL=EBI_CS2_CTRLA+2
	.EQU EBI_CS2_BASEADDRH=EBI_CS2_CTRLA+3
	.EQU EBI_CS3_CTRLA=EBI_CTRL+0x1C
	.EQU EBI_CS3_CTRLB=EBI_CS3_CTRLA+1
	.EQU EBI_CS3_BASEADDRL=EBI_CS3_CTRLA+2
	.EQU EBI_CS3_BASEADDRH=EBI_CS3_CTRLA+3
	.EQU EBI_SDCAS_bp=3
	.EQU EBI_SDCAS_bm=8
	.EQU EBI_SDROW_bp=2
	.EQU EBI_SDROW_bm=4
	.EQU EBI_SDCOL_bp=0
	.EQU EBI_MRDLY_bp=6
	.EQU EBI_ROWCYCDLY_bp=3
	.EQU EBI_RPDLY_bp=0
	.EQU EBI_WRDLY_bp=6
	.EQU EBI_ESRDLY_bp=3
	.EQU EBI_ROWCOLDLY_bp=0
	.EQU EBI_CS_SDSREN_bm=4
	.EQU EBI_CS_ASPACE_256B_gc=0x00<<2
	.EQU EBI_CS_ASPACE_512B_gc=0x01<<2
	.EQU EBI_CS_ASPACE_1KB_gc=0x02<<2
	.EQU EBI_CS_ASPACE_2KB_gc=0x03<<2
	.EQU EBI_CS_ASPACE_4KB_gc=0x04<<2
	.EQU EBI_CS_ASPACE_8KB_gc=0x05<<2
	.EQU EBI_CS_ASPACE_16KB_gc=0x06<<2
	.EQU EBI_CS_ASPACE_32KB_gc=0x07<<2
	.EQU EBI_CS_ASPACE_64KB_gc=0x08<<2
	.EQU EBI_CS_ASPACE_128KB_gc=0x09<<2
	.EQU EBI_CS_ASPACE_256KB_gc=0x0A<<2
	.EQU EBI_CS_ASPACE_512KB_gc=0x0B<<2
	.EQU EBI_CS_ASPACE_1MB_gc=0x0C<<2
	.EQU EBI_CS_ASPACE_2MB_gc=0x0D<<2
	.EQU EBI_CS_ASPACE_4MB_gc=0x0E<<2
	.EQU EBI_CS_ASPACE_8MB_gc=0x0F<<2
	.EQU EBI_CS_ASPACE_16M_gc=0x10<<2
	.EQU EBI_CS_MODE_DISABLED_gc=0x00
	.EQU EBI_CS_MODE_SRAM_gc=0x01
	.EQU EBI_CS_MODE_LPC_gc=0x02
	.EQU EBI_CS_MODE_SDRAM_gc=0x03
	.EQU EBI_SDDATAW_4BIT_gc=0x00<<6
	.EQU EBI_SDDATAW_8BIT_gc=0x01<<6
	.EQU EBI_LPCMODE_ALE1_gc=0x00<<4
	.EQU EBI_LPCMODE_ALE12_gc=0x02<<4
	.EQU EBI_SRMODE_ALE1_gc=0x00<<2
	.EQU EBI_SRMODE_ALE2_gc=0x01<<2
	.EQU EBI_SRMODE_ALE12_gc=0x02<<2
	.EQU EBI_SRMODE_NOALE_gc=0x03<<2
	.EQU EBI_IFMODE_DISABLED_gc=0x00
	.EQU EBI_IFMODE_3PORT_gc=0x01
	.EQU EBI_IFMODE_4PORT_gc=0x02
	.EQU EBI_IFMODE_2PORT_gc=0x03
	.EQU EBI_SDCOL_8BIT_gc=0x00
	.EQU EBI_SDCOL_9BIT_gc=0x01
	.EQU EBI_SDCOL_10BIT_gc=0x02
	.EQU EBI_SDCOL_11BIT_gc=0x03
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F
	.EQU GPIO0=0x00
	.EQU GPIO1=0x01
	.EQU GPIO2=0x02
	.EQU GPIO3=0x03
	.EQU GPIO4=0x04
	.EQU GPIO5=0x05
	.EQU GPIO6=0x06
	.EQU GPIO7=0x07
	.EQU GPIO8=0x08
	.EQU GPIO9=0x09
	.EQU GPIO10=0x0A
	.EQU GPIO11=0x0B
	.EQU GPIO12=0x0C
	.EQU GPIO13=0x0D
	.EQU GPIO14=0x0E
	.EQU GPIO15=0x0F

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

	.EQU __SRAM_START=0x2000
	.EQU __SRAM_END=0x3FFF
	.EQU __DSTACK_SIZE=0x0800
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

;GPIO0-GPIO15 INITIALIZATION VALUES
	.EQU __GPIO0_INIT=0x00
	.EQU __GPIO1_INIT=0x00
	.EQU __GPIO2_INIT=0x00
	.EQU __GPIO3_INIT=0x00
	.EQU __GPIO4_INIT=0x00
	.EQU __GPIO5_INIT=0x00
	.EQU __GPIO6_INIT=0x00
	.EQU __GPIO7_INIT=0x00
	.EQU __GPIO8_INIT=0x00
	.EQU __GPIO9_INIT=0x00
	.EQU __GPIO10_INIT=0x00
	.EQU __GPIO11_INIT=0x00
	.EQU __GPIO12_INIT=0x00
	.EQU __GPIO13_INIT=0x00
	.EQU __GPIO14_INIT=0x00
	.EQU __GPIO15_INIT=0x00

;GLOBAL REGISTER VARIABLES INITIALIZATION VALUES
	.EQU __R2_INIT=0x00
	.EQU __R3_INIT=0x00
	.EQU __R4_INIT=0x00
	.EQU __R5_INIT=0x00
	.EQU __R6_INIT=0x00
	.EQU __R7_INIT=0x00
	.EQU __R8_INIT=0x00
	.EQU __R9_INIT=0x00
	.EQU __R10_INIT=0x00
	.EQU __R11_INIT=0x00
	.EQU __R12_INIT=0x00
	.EQU __R13_INIT=0xFF
	.EQU __R14_INIT=0x00

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
	JMP  _tcc0_overflow_isr
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  _tcc1_overflow_isr
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
_tbl10_G100:
	.DB  0x10,0x27,0xE8,0x3,0x64,0x0,0xA,0x0
	.DB  0x1,0x0
_tbl16_G100:
	.DB  0x0,0x10,0x0,0x1,0x10,0x0,0x1,0x0

_0x14A:
	.DB  0x1
_0x0:
	.DB  0x30,0x78,0x25,0x30,0x34,0x58,0x25,0x30
	.DB  0x34,0x58,0x0

__GLOBAL_INI_TBL:
	.DW  0x01
	.DW  _CTRLA_value
	.DW  _0x14A*2

_0xFFFFFFFF:
	.DW  0

__RESET:
	CLI
	CLR  R30
	OUT  RAMPD,R30
	OUT  RAMPX,R30
	OUT  RAMPY,R30

;MEMORY MAPPED EEPROM ACCESS IS USED
	LDS  R31,NVM_CTRLB
	ORI  R31,0x08
	STS  NVM_CTRLB,R31

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,0xD8
	OUT  CCP,R31
	STS  PMIC_CTRL,R30

;NO EXTERNAL RAM IS USED
	STS  EBI_CTRL,R30

;DISABLE WATCHDOG
	LDS  R26,WDT_CTRL
	CBR  R26,2
	SBR  R26,1
	OUT  CCP,R31
	STS  WDT_CTRL,R26

;CLEAR SRAM
	LDI  R24,LOW(__CLEAR_SRAM_SIZE)
	LDI  R25,HIGH(__CLEAR_SRAM_SIZE)
	LDI  R26,LOW(__SRAM_START)
	LDI  R27,HIGH(__SRAM_START)
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

	OUT  RAMPZ,R24

;GPIO0-GPIO15 INITIALIZATION
	LDI  R30,__GPIO0_INIT
	OUT  GPIO0,R30
	;__GPIO1_INIT = __GPIO0_INIT
	OUT  GPIO1,R30
	;__GPIO2_INIT = __GPIO0_INIT
	OUT  GPIO2,R30
	;__GPIO3_INIT = __GPIO0_INIT
	OUT  GPIO3,R30
	;__GPIO4_INIT = __GPIO0_INIT
	OUT  GPIO4,R30
	;__GPIO5_INIT = __GPIO0_INIT
	OUT  GPIO5,R30
	;__GPIO6_INIT = __GPIO0_INIT
	OUT  GPIO6,R30
	;__GPIO7_INIT = __GPIO0_INIT
	OUT  GPIO7,R30
	;__GPIO8_INIT = __GPIO0_INIT
	OUT  GPIO8,R30
	;__GPIO9_INIT = __GPIO0_INIT
	OUT  GPIO9,R30
	;__GPIO10_INIT = __GPIO0_INIT
	OUT  GPIO10,R30
	;__GPIO11_INIT = __GPIO0_INIT
	OUT  GPIO11,R30
	;__GPIO12_INIT = __GPIO0_INIT
	OUT  GPIO12,R30
	;__GPIO13_INIT = __GPIO0_INIT
	OUT  GPIO13,R30
	;__GPIO14_INIT = __GPIO0_INIT
	OUT  GPIO14,R30
	;__GPIO15_INIT = __GPIO0_INIT
	OUT  GPIO15,R30

;GLOBAL REGISTER VARIABLES INITIALIZATION
	;__R2_INIT = __GPIO0_INIT
	MOV  R2,R30
	;__R3_INIT = __GPIO0_INIT
	MOV  R3,R30
	;__R4_INIT = __GPIO0_INIT
	MOV  R4,R30
	;__R5_INIT = __GPIO0_INIT
	MOV  R5,R30
	;__R6_INIT = __GPIO0_INIT
	MOV  R6,R30
	;__R7_INIT = __GPIO0_INIT
	MOV  R7,R30
	;__R8_INIT = __GPIO0_INIT
	MOV  R8,R30
	;__R9_INIT = __GPIO0_INIT
	MOV  R9,R30
	;__R10_INIT = __GPIO0_INIT
	MOV  R10,R30
	;__R11_INIT = __GPIO0_INIT
	MOV  R11,R30
	;__R12_INIT = __GPIO0_INIT
	MOV  R12,R30
	LDI  R30,__R13_INIT
	MOV  R13,R30

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
	.ORG 0x2800

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
;Date    : 8/25/2011
;Author  : NeVaDa
;Company :
;Comments:
;
;
;Chip type               : ATxmega128A1
;Program type            : Application
;AVR Core Clock frequency: 32.000000 MHz
;Memory model            : Small
;Data Stack size         : 2048
;*****************************************************/
;
;// I/O Registers definitions
;#include <io.h>
;#include <stdio.h>
;
;// Declare your global variables here
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
; 0000 00DA                   unsigned char *glcd_rs_port_address,  unsigned char glcd_rs_pin,
; 0000 00DB                   unsigned char *glcd_rw_port_address,  unsigned char glcd_rw_pin,
; 0000 00DC                   unsigned char *glcd_en_port_address,  unsigned char glcd_en_pin,
; 0000 00DD                   unsigned char *glcd_cs1_port_address, unsigned char glcd_cs1_pin,
; 0000 00DE                   unsigned char *glcd_cs2_port_address, unsigned char glcd_cs2_pin,
; 0000 00DF                   unsigned char *glcd_rst_port_address, unsigned char glcd_rst_pin)
; 0000 00E0 {

	.CSEG
; 0000 00E1     glcd_data_address = glcd_data_port_address;
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
; 0000 00E2     glcd_rs_address   = glcd_rs_port_address;
; 0000 00E3     glcd_rw_address   = glcd_rw_port_address;
; 0000 00E4     glcd_en_address   = glcd_en_port_address;
; 0000 00E5     glcd_cs1_address  = glcd_cs1_port_address;
; 0000 00E6     glcd_cs2_address  = glcd_cs2_port_address;
; 0000 00E7     glcd_rst_address  = glcd_rst_port_address;
; 0000 00E8 #ifdef _ATXMEGA_DEVICE_
; 0000 00E9     glcd_rs_bit_msk  = 0b00000001 << glcd_rs_pin;
; 0000 00EA     glcd_rw_bit_msk  = 0b00000001 << glcd_rw_pin;
; 0000 00EB     glcd_en_bit_msk  = 0b00000001 << glcd_en_pin;
; 0000 00EC     glcd_cs1_bit_msk = 0b00000001 << glcd_cs1_pin;
; 0000 00ED     glcd_cs2_bit_msk = 0b00000001 << glcd_cs2_pin;
; 0000 00EE     glcd_rst_bit_msk = 0b00000001 << glcd_rst_pin;
; 0000 00EF     // Set all the pins as output
; 0000 00F0     *(glcd_data_address - 0x03) = 0xFF;
; 0000 00F1     *(glcd_rs_address - 0x03)   = glcd_rs_bit_msk;
; 0000 00F2     clr_rw;
; 0000 00F3     *(glcd_rw_address - 0x03)   = glcd_rw_bit_msk;
; 0000 00F4     *(glcd_en_address - 0x03)   = glcd_en_bit_msk;
; 0000 00F5     *(glcd_cs1_address - 0x03)  = glcd_cs1_bit_msk;
; 0000 00F6     *(glcd_cs2_address - 0x03)  = glcd_cs2_bit_msk;
; 0000 00F7     *(glcd_rst_address - 0x03)  = glcd_rst_bit_msk;
; 0000 00F8 #else
; 0000 00F9     glcd_rs_bit_pos  = glcd_rs_pin;
; 0000 00FA     glcd_rw_bit_pos  = glcd_rw_pin;
; 0000 00FB     glcd_en_bit_pos  = glcd_en_pin;
; 0000 00FC     glcd_cs1_bit_pos = glcd_cs1_pin;
; 0000 00FD     glcd_cs2_bit_pos = glcd_cs2_pin;
; 0000 00FE     glcd_rst_bit_pos = glcd_rst_pin;
; 0000 00FF     // Sets the pins as output
; 0000 0100     *(glcd_data_address - 1) = 0xFF;
; 0000 0101     SETBIT (*(glcd_rs_address - 0x01),glcd_rs_bit_pos);
; 0000 0102     SETBIT (*(glcd_rw_address - 0x01),glcd_rw_bit_pos);
; 0000 0103     clr_rw;
; 0000 0104     SETBIT (*(glcd_en_address - 0x01),glcd_en_bit_pos);
; 0000 0105     SETBIT (*(glcd_cs1_address - 0x01),glcd_cs1_bit_pos);
; 0000 0106     SETBIT (*(glcd_cs2_address - 0x01),glcd_cs2_bit_pos);
; 0000 0107     SETBIT (*(glcd_rst_address - 0x01),glcd_rst_bit_pos);
; 0000 0108 #endif
; 0000 0109 #asm
; 0000 010A     LDI        R30, LOW(_CaseAddress)
; 0000 010B     LDI     R31, HIGH(_CaseAddress)
; 0000 010C     ;//Save R16, R17
; 0000 010D     PUSH    R16
; 0000 010E     PUSH    R17
; 0000 010F     ;//Load #1 case for delay function
; 0000 0110     LDI     R16, LOW(DelayLabel1)
; 0000 0111     LDI        R17, HIGH(DelayLabel1)
; 0000 0112     ST        Z+,  R16
; 0000 0113     ST        Z+,  R17
; 0000 0114     ;//Load #2 case for delay function
; 0000 0115     LDI     R16, LOW(DelayLabel2)
; 0000 0116     LDI        R17, HIGH(DelayLabel2)
; 0000 0117     ST        Z+,  R16
; 0000 0118     ST        Z+,  R17
; 0000 0119 
; 0000 011A     LDI     R16, LOW(GlcdUnlockLockLabel1)
; 0000 011B     LDI        R17, HIGH(GlcdUnlockLockLabel1)
; 0000 011C     ST        Z+,  R16
; 0000 011D     ST        Z+,  R17
; 0000 011E 
; 0000 011F     LDI     R16, LOW(GlcdUnlockLockLabel2)
; 0000 0120     LDI        R17, HIGH(GlcdUnlockLockLabel2)
; 0000 0121     ST        Z+,  R16
; 0000 0122     ST        Z+,  R17
; 0000 0123 
; 0000 0124     LDI     R16, LOW(GlcdUnlockLockLabel3)
; 0000 0125     LDI        R17, HIGH(GlcdUnlockLockLabel3)
; 0000 0126     ST        Z+,  R16
; 0000 0127     ST        Z+,  R17
; 0000 0128 
; 0000 0129     LDI     R16, LOW(GlcdInitLabel1)
; 0000 012A     LDI        R17, HIGH(GlcdInitLabel1)
; 0000 012B     ST        Z+,  R16
; 0000 012C     ST        Z+,  R17
; 0000 012D 
; 0000 012E     LDI     R16, LOW(GlcdInitLabel2)
; 0000 012F     LDI        R17, HIGH(GlcdInitLabel2)
; 0000 0130     ST        Z+,  R16
; 0000 0131     ST        Z+,  R17
; 0000 0132 
; 0000 0133     LDI     R16, LOW(GlcdInitLabel3)
; 0000 0134     LDI        R17, HIGH(GlcdInitLabel3)
; 0000 0135     ST        Z+,  R16
; 0000 0136     ST        Z+,  R17
; 0000 0137 
; 0000 0138     LDI     R16, LOW(GlcdInitLabel4)
; 0000 0139     LDI        R17, HIGH(GlcdInitLabel4)
; 0000 013A     ST        Z+,  R16
; 0000 013B     ST        Z+,  R17
; 0000 013C 
; 0000 013D     LDI     R16, LOW(GlcdInitLabel5)
; 0000 013E     LDI        R17, HIGH(GlcdInitLabel5)
; 0000 013F     ST        Z+,  R16
; 0000 0140     ST        Z+,  R17
; 0000 0141 
; 0000 0142     LDI     R16, LOW(GlcdInitLabel6)
; 0000 0143     LDI        R17, HIGH(GlcdInitLabel6)
; 0000 0144     ST        Z+,  R16
; 0000 0145     ST        Z+,  R17
; 0000 0146 
; 0000 0147     LDI     R16, LOW(GlcdInitLabel7)
; 0000 0148     LDI        R17, HIGH(GlcdInitLabel7)
; 0000 0149     ST        Z+,  R16
; 0000 014A     ST        Z+,  R17
; 0000 014B 
; 0000 014C     LDI     R16, LOW(GlcdInitLabel8)
; 0000 014D     LDI        R17, HIGH(GlcdInitLabel8)
; 0000 014E     ST        Z+,  R16
; 0000 014F     ST        Z+,  R17
; 0000 0150 
; 0000 0151     LDI     R16, LOW(GlcdWriteByteLabel1)
; 0000 0152     LDI        R17, HIGH(GlcdWriteByteLabel1)
; 0000 0153     ST        Z+,  R16
; 0000 0154     ST        Z+,  R17
; 0000 0155 
; 0000 0156     LDI     R16, LOW(GlcdWriteByteLabel2)
; 0000 0157     LDI        R17, HIGH(GlcdWriteByteLabel2)
; 0000 0158     ST        Z+,  R16
; 0000 0159     ST        Z+,  R17
; 0000 015A 
; 0000 015B     LDI     R16, LOW(GlcdWriteByteLabel3)
; 0000 015C     LDI        R17, HIGH(GlcdWriteByteLabel3)
; 0000 015D     ST        Z+,  R16
; 0000 015E     ST        Z+,  R17
; 0000 015F 
; 0000 0160     LDI     R16, LOW(GlcdWriteByteLabel4)
; 0000 0161     LDI        R17, HIGH(GlcdWriteByteLabel4)
; 0000 0162     ST        Z+,  R16
; 0000 0163     ST        Z+,  R17
; 0000 0164 
; 0000 0165     LDI     R16, LOW(GlcdClearPageLabel1)
; 0000 0166     LDI        R17, HIGH(GlcdClearPageLabel1)
; 0000 0167     ST        Z+,  R16
; 0000 0168     ST        Z+,  R17
; 0000 0169 
; 0000 016A     LDI     R16, LOW(GlcdClearPageLabel2)
; 0000 016B     LDI        R17, HIGH(GlcdClearPageLabel2)
; 0000 016C     ST        Z+,  R16
; 0000 016D     ST        Z+,  R17
; 0000 016E 
; 0000 016F     LDI     R16, LOW(GlcdPutcharLabel1)
; 0000 0170     LDI        R17, HIGH(GlcdPutcharLabel1)
; 0000 0171     ST        Z+,  R16
; 0000 0172     ST        Z+,  R17
; 0000 0173 
; 0000 0174     LDI     R16, LOW(GlcdPutcharLabel2)
; 0000 0175     LDI        R17, HIGH(GlcdPutcharLabel2)
; 0000 0176     ST        Z+,  R16
; 0000 0177     ST        Z+,  R17
; 0000 0178 
; 0000 0179     LDI     R16, LOW(GlcdPutsLabel1)
; 0000 017A     LDI        R17, HIGH(GlcdPutsLabel1)
; 0000 017B     ST        Z+,  R16
; 0000 017C     ST        Z+,  R17
; 0000 017D 
; 0000 017E     LDI     R16, LOW(GlcdPutsLabel2)
; 0000 017F     LDI        R17, HIGH(GlcdPutsLabel2)
; 0000 0180     ST        Z+,  R16
; 0000 0181     ST        Z+,  R17
; 0000 0182 
; 0000 0183     LDI     R16, LOW(GlcdPutsCenterLabel1)
; 0000 0184     LDI        R17, HIGH(GlcdPutsCenterLabel1)
; 0000 0185     ST        Z+,  R16
; 0000 0186     ST        Z+,  R17
; 0000 0187 
; 0000 0188     LDI     R16, LOW(GlcdPutsCenterLabel2)
; 0000 0189     LDI        R17, HIGH(GlcdPutsCenterLabel2)
; 0000 018A     ST        Z+,  R16
; 0000 018B     ST        Z+,  R17
; 0000 018C 
; 0000 018D     LDI     R16, LOW(GlcdPutsfLabel1)
; 0000 018E     LDI        R17, HIGH(GlcdPutsfLabel1)
; 0000 018F     ST        Z+,  R16
; 0000 0190     ST        Z+,  R17
; 0000 0191 
; 0000 0192     LDI     R16, LOW(GlcdPutsfLabel2)
; 0000 0193     LDI        R17, HIGH(GlcdPutsfLabel2)
; 0000 0194     ST        Z+,  R16
; 0000 0195     ST        Z+,  R17
; 0000 0196 
; 0000 0197     LDI     R16, LOW(GlcdPutsfCenterLabel1)
; 0000 0198     LDI        R17, HIGH(GlcdPutsfCenterLabel1)
; 0000 0199     ST        Z+,  R16
; 0000 019A     ST        Z+,  R17
; 0000 019B 
; 0000 019C     LDI     R16, LOW(GlcdPutsfCenterLabel2)
; 0000 019D     LDI        R17, HIGH(GlcdPutsfCenterLabel2)
; 0000 019E     ST        Z+,  R16
; 0000 019F     ST        Z+,  R17
; 0000 01A0 
; 0000 01A1     LDI     R16, LOW(GlcdClearLabel1)
; 0000 01A2     LDI        R17, HIGH(GlcdClearLabel1)
; 0000 01A3     ST        Z+,  R16
; 0000 01A4     ST        Z+,  R17
; 0000 01A5 
; 0000 01A6     LDI     R16, LOW(GlcdClearLabel2)
; 0000 01A7     LDI        R17, HIGH(GlcdClearLabel2)
; 0000 01A8     ST        Z+,  R16
; 0000 01A9     ST        Z+,  R17
; 0000 01AA 
; 0000 01AB     LDI     R16, LOW(GlcdPutbmpLabel1)
; 0000 01AC     LDI        R17, HIGH(GlcdPutbmpLabel1)
; 0000 01AD     ST        Z+,  R16
; 0000 01AE     ST        Z+,  R17
; 0000 01AF 
; 0000 01B0     LDI     R16, LOW(GlcdPutbmpLabel2)
; 0000 01B1     LDI        R17, HIGH(GlcdPutbmpLabel2)
; 0000 01B2     ST        Z+,  R16
; 0000 01B3     ST        Z+,  R17
; 0000 01B4 
; 0000 01B5     POP        R17
; 0000 01B6     POP        R16
; 0000 01B7 #endasm
; 0000 01B8 }
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
; 0000 01EC {
; 0000 01ED     if (((StackPointer + 1) < StackSize) || (StackPointer == 0xFF) )
;	Case -> Y+0
; 0000 01EE     {
; 0000 01EF         StackPointer++;
; 0000 01F0         CaseStack[StackPointer] = Case;
; 0000 01F1         return 0;
; 0000 01F2     }
; 0000 01F3     else
; 0000 01F4         return 1;
; 0000 01F5 }
;
;unsigned char PopCase (void)
; 0000 01F8 {
_PopCase:
; 0000 01F9     if (~StackPointer)
	MOV  R30,R13
	COM  R30
	CPI  R30,0
	BREQ _0x7
; 0000 01FA     {
; 0000 01FB         StackPointer--;
	DEC  R13
; 0000 01FC         return 0;
	LDI  R30,LOW(0)
	RET
; 0000 01FD     }
; 0000 01FE     else
_0x7:
; 0000 01FF         return 1;
	LDI  R30,LOW(1)
	RET
; 0000 0200 }
	RET
;
;unsigned char strlen_char (unsigned char *str)
; 0000 0203 {
_strlen_char:
; 0000 0204     unsigned char i;
; 0000 0205     for (i = 0; *str++ != 0;i++);
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
; 0000 0206     return i;
	MOV  R30,R17
	LDD  R17,Y+0
	JMP  _0x206000A
; 0000 0207 }
;
;unsigned char strlenf_char (flash unsigned char *str)
; 0000 020A {
_strlenf_char:
; 0000 020B     unsigned char i;
; 0000 020C     for (i = 0; *str++ != 0;i++);
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
; 0000 020D     return i;
	MOV  R30,R17
	LDD  R17,Y+0
	JMP  _0x206000A
; 0000 020E }
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
; 0000 0242 {
_glcd_timer_isr:
; 0000 0243     static unsigned char i;
; 0000 0244     static unsigned int  j;
; 0000 0245     if (StackPointer != 0xFF)
	LDI  R30,LOW(255)
	CP   R30,R13
	BRNE PC+3
	JMP _0xF
; 0000 0246     {
; 0000 0247         if (StackPointer == 0x00)
	TST  R13
	BRNE _0x10
; 0000 0248         {
; 0000 0249             GotoNextCase;
	MOV  R30,R13
	COM  R30
	CPI  R30,0
	BREQ _0x11
	CALL SUBOPT_0x0
	MOV    R30, R2
	MOV    R31, R3
	IJMP
	RJMP _0x15
_0x11:
	RET
; 0000 024A         }
_0x15:
; 0000 024B /////////////////////////////////////////////////////////////////////////
; 0000 024C #asm
_0x10:
; 0000 024D DelayLabel2:
DelayLabel2:
; 0000 024E #endasm
; 0000 024F DelayLabel2:
; 0000 0250         (*timer_interrupt_disable)();
	MOVW R30,R6
	ICALL
; 0000 0251 #ifdef Debugging
; 0000 0252         DebugDisplay(0x0,'2');
; 0000 0253         while (PINB & 0x01); while (!(PINB & 0x01));
; 0000 0254 #endif
; 0000 0255         StackMinus();
	CALL SUBOPT_0x1
	BREQ _0x1A
	CALL SUBOPT_0x0
	MOV    R30, R2
	MOV    R31, R3
	IJMP
	RJMP _0x1E
_0x1A:
	RET
_0x1E:
; 0000 0256 #asm
; 0000 0257 DelayLabel1:
DelayLabel1:
; 0000 0258 #endasm
; 0000 0259 DelayLabel1:
_0x1F:
; 0000 025A #ifdef Debugging
; 0000 025B         DebugDisplay(0x0,'1');
; 0000 025C         while (PINB & 0x01); while (!(PINB & 0x01));
; 0000 025D #endif
; 0000 025E         SetCurrentCase(DelayCase2);
	CALL SUBOPT_0x2
	LDI  R26,LOW(1)
	STD  Z+0,R26
; 0000 025F         (*timer_interrupt_enable)();
	MOVW R30,R4
	ICALL
; 0000 0260         return;
	RET
; 0000 0261 #asm
; 0000 0262 GlcdUnlockLockLabel3:
GlcdUnlockLockLabel3:
; 0000 0263 #endasm
; 0000 0264 GlcdUnlockLockLabel3:
; 0000 0265 #ifdef Debugging
; 0000 0266         DebugDisplay(0x1,'3');
; 0000 0267         while (PINB & 0x01); while (!(PINB & 0x01));
; 0000 0268 #endif
; 0000 0269         clr_en;
	CALL SUBOPT_0x3
; 0000 026A         StackMinus();
	CALL SUBOPT_0x1
	BREQ _0x24
	CALL SUBOPT_0x0
	MOV    R30, R2
	MOV    R31, R3
	IJMP
	RJMP _0x28
_0x24:
	RET
_0x28:
; 0000 026B #asm
; 0000 026C GlcdUnlockLockLabel2:
GlcdUnlockLockLabel2:
; 0000 026D #endasm
; 0000 026E GlcdUnlockLockLabel2:
; 0000 026F #ifdef Debugging
; 0000 0270         DebugDisplay(0x1,'2');
; 0000 0271         while (PINB & 0x01); while (!(PINB & 0x01));
; 0000 0272 #endif
; 0000 0273         set_en;
	CALL SUBOPT_0x4
; 0000 0274         StackPlus(GlcdUnlockLockCase3,DelayLabel1);
	CALL SUBOPT_0x2
	LDI  R26,LOW(4)
	STD  Z+0,R26
	INC  R13
	RJMP _0x1F
; 0000 0275 #asm
; 0000 0276 GlcdUnlockLockLabel1:
GlcdUnlockLockLabel1:
; 0000 0277 #endasm
; 0000 0278 GlcdUnlockLockLabel1:
_0x2D:
; 0000 0279 #ifdef Debugging
; 0000 027A         DebugDisplay(0x1,'1');
; 0000 027B         while (PINB & 0x01); while (!(PINB & 0x01));
; 0000 027C #endif
; 0000 027D         (*set_delay_7us)();
	MOVW R30,R8
	ICALL
; 0000 027E         StackPlus(GlcdUnlockLockCase2,DelayLabel1);
	CALL SUBOPT_0x2
	LDI  R26,LOW(3)
	STD  Z+0,R26
	INC  R13
	RJMP _0x1F
; 0000 027F #asm
; 0000 0280 GlcdInitLabel8:
GlcdInitLabel8:
; 0000 0281 #endasm
; 0000 0282 GlcdInitLabel8:
; 0000 0283 #ifdef Debugging
; 0000 0284         DebugDisplay(0x2,'8');
; 0000 0285         while (PINB & 0x01); while (!(PINB & 0x01));
; 0000 0286 #endif
; 0000 0287         StackMinus();
	CALL SUBOPT_0x1
	BREQ _0x35
	CALL SUBOPT_0x0
	MOV    R30, R2
	MOV    R31, R3
	IJMP
	RJMP _0x39
_0x35:
	RET
_0x39:
; 0000 0288 #asm
; 0000 0289 GlcdInitLabel7:
GlcdInitLabel7:
; 0000 028A #endasm
; 0000 028B GlcdInitLabel7:
; 0000 028C #ifdef Debugging
; 0000 028D         DebugDisplay(0x2,'7');
; 0000 028E         while (PINB & 0x01); while (!(PINB & 0x01));
; 0000 028F #endif
; 0000 0290         tgl_cs1;
	CALL SUBOPT_0x5
; 0000 0291         tgl_cs2;
; 0000 0292         *glcd_data_address = 0x3E;
	CALL SUBOPT_0x6
	LDI  R30,LOW(62)
	ST   X,R30
; 0000 0293         StackPlus(GlcdInitCase4,GlcdUnlockLockLabel1);
	CALL SUBOPT_0x2
	LDI  R26,LOW(8)
	STD  Z+0,R26
	INC  R13
	RJMP _0x2D
; 0000 0294 #asm
; 0000 0295 GlcdInitLabel6:
GlcdInitLabel6:
; 0000 0296 #endasm
; 0000 0297 GlcdInitLabel6:
; 0000 0298 #ifdef Debugging
; 0000 0299         DebugDisplay(0x2,'6');
; 0000 029A         while (PINB & 0x01); while (!(PINB & 0x01));
; 0000 029B #endif
; 0000 029C         *glcd_data_address = 0x3F;
	CALL SUBOPT_0x6
	LDI  R30,LOW(63)
	ST   X,R30
; 0000 029D         i++;
	LDS  R30,_i_S0000005000
	SUBI R30,-LOW(1)
	CALL SUBOPT_0x7
; 0000 029E         if (i < 2)
	CPI  R26,LOW(0x2)
	BRSH _0x3F
; 0000 029F             SetCurrentCase(GlcdInitCase7);
	CALL SUBOPT_0x2
	LDI  R26,LOW(11)
	RJMP _0x14F
; 0000 02A0         else
_0x3F:
; 0000 02A1             SetCurrentCase(GlcdInitCase8);
	CALL SUBOPT_0x2
	LDI  R26,LOW(12)
_0x14F:
	STD  Z+0,R26
; 0000 02A2         StackPointer++;
	INC  R13
; 0000 02A3         #asm("JMP GlcdUnlockLockLabel1")
	JMP GlcdUnlockLockLabel1
; 0000 02A4 #asm
; 0000 02A5 GlcdInitLabel5:
GlcdInitLabel5:
; 0000 02A6 #endasm
; 0000 02A7 GlcdInitLabel5:
; 0000 02A8 #ifdef Debugging
; 0000 02A9         DebugDisplay(0x2,'5');
; 0000 02AA         while (PINB & 0x01); while (!(PINB & 0x01));
; 0000 02AB #endif
; 0000 02AC         *glcd_data_address = 0xB8;
	CALL SUBOPT_0x6
	LDI  R30,LOW(184)
	ST   X,R30
; 0000 02AD         StackPlus(GlcdInitCase6,GlcdUnlockLockLabel1);
	CALL SUBOPT_0x2
	LDI  R26,LOW(10)
	STD  Z+0,R26
	INC  R13
	RJMP _0x2D
; 0000 02AE #asm
; 0000 02AF GlcdInitLabel4:
GlcdInitLabel4:
; 0000 02B0 #endasm
; 0000 02B1 GlcdInitLabel4:
; 0000 02B2 #ifdef Debugging
; 0000 02B3         DebugDisplay(0x2,'4');
; 0000 02B4         while (PINB & 0x01); while (!(PINB & 0x01));
; 0000 02B5 #endif
; 0000 02B6         *glcd_data_address = 0x40;
	CALL SUBOPT_0x6
	LDI  R30,LOW(64)
	ST   X,R30
; 0000 02B7         StackPlus(GlcdInitCase5,GlcdUnlockLockLabel1);
	CALL SUBOPT_0x2
	LDI  R26,LOW(9)
	STD  Z+0,R26
	INC  R13
	RJMP _0x2D
; 0000 02B8 #asm
; 0000 02B9 GlcdInitLabel3:
GlcdInitLabel3:
; 0000 02BA #endasm
; 0000 02BB GlcdInitLabel3:
; 0000 02BC #ifdef Debugging
; 0000 02BD         DebugDisplay(0x2,'3');
; 0000 02BE         while (PINB & 0x01); while (!(PINB & 0x01));
; 0000 02BF #endif
; 0000 02C0         clr_rs;
	CALL SUBOPT_0x8
; 0000 02C1         clr_cs1;
	CALL SUBOPT_0x9
; 0000 02C2         set_cs2;
; 0000 02C3         *glcd_data_address = 0x3E;
	CALL SUBOPT_0x6
	LDI  R30,LOW(62)
	ST   X,R30
; 0000 02C4         StackPlus(GlcdInitCase4,GlcdUnlockLockLabel1);
	CALL SUBOPT_0x2
	LDI  R26,LOW(8)
	STD  Z+0,R26
	INC  R13
	RJMP _0x2D
; 0000 02C5 #asm
; 0000 02C6 GlcdInitLabel2:
GlcdInitLabel2:
; 0000 02C7 #endasm
; 0000 02C8 GlcdInitLabel2:
; 0000 02C9 #ifdef Debugging
; 0000 02CA         DebugDisplay(0x2,'2');
; 0000 02CB         while (PINB & 0x01); while (!(PINB & 0x01));
; 0000 02CC #endif
; 0000 02CD         set_rst;
	CALL SUBOPT_0xA
; 0000 02CE         StackPlus(GlcdInitCase3,DelayLabel1);
	CALL SUBOPT_0x2
	LDI  R26,LOW(7)
	STD  Z+0,R26
	INC  R13
	JMP  _0x1F
; 0000 02CF #asm
; 0000 02D0 GlcdInitLabel1:
GlcdInitLabel1:
; 0000 02D1 #endasm
; 0000 02D2 GlcdInitLabel1:
; 0000 02D3         i = 0;
	LDI  R30,LOW(0)
	STS  _i_S0000005000,R30
; 0000 02D4         clr_rst;
	CALL SUBOPT_0xB
; 0000 02D5         (*set_delay_10ms)();
	MOVW R30,R10
	ICALL
; 0000 02D6 #ifdef Debugging
; 0000 02D7         DebugDisplay(0x2,'1');
; 0000 02D8         while (PINB & 0x01); while (!(PINB & 0x01));
; 0000 02D9 #endif
; 0000 02DA         StackPlus(GlcdInitCase2,DelayLabel1);
	CALL SUBOPT_0x2
	LDI  R26,LOW(6)
	STD  Z+0,R26
	INC  R13
	JMP  _0x1F
; 0000 02DB #asm
; 0000 02DC GlcdWriteByteLabel4:
GlcdWriteByteLabel4:
; 0000 02DD #endasm
; 0000 02DE GlcdWriteByteLabel4:
; 0000 02DF #ifdef Debugging
; 0000 02E0         DebugDisplay(0x3,'4');
; 0000 02E1         while (PINB & 0x01); while (!(PINB & 0x01));
; 0000 02E2 #endif
; 0000 02E3         StackMinus();
	CALL SUBOPT_0x1
	BREQ _0x59
	CALL SUBOPT_0x0
	MOV    R30, R2
	MOV    R31, R3
	IJMP
	RJMP _0x5D
_0x59:
	RET
_0x5D:
; 0000 02E4 #asm
; 0000 02E5 GlcdWriteByteLabel3:
GlcdWriteByteLabel3:
; 0000 02E6 #endasm
; 0000 02E7 GlcdWriteByteLabel3:
; 0000 02E8 #ifdef Debugging
; 0000 02E9         DebugDisplay(0x3,'3');
; 0000 02EA         while (PINB & 0x01); while (!(PINB & 0x01));
; 0000 02EB #endif
; 0000 02EC         set_rs;
	CALL SUBOPT_0xC
; 0000 02ED         clr_rw;
; 0000 02EE         *glcd_data_address = GlcdDataByte;
	LDS  R30,_GlcdDataByte
	CALL SUBOPT_0x6
	ST   X,R30
; 0000 02EF         StackPlus(GlcdWriteByteCase4,GlcdUnlockLockLabel1);
	CALL SUBOPT_0x2
	LDI  R26,LOW(16)
	STD  Z+0,R26
	INC  R13
	JMP  _0x2D
; 0000 02F0 #asm
; 0000 02F1 GlcdWriteByteLabel2:
GlcdWriteByteLabel2:
; 0000 02F2 #endasm
; 0000 02F3 GlcdWriteByteLabel2:
; 0000 02F4 #ifdef Debugging
; 0000 02F5         DebugDisplay(0x3,'2');
; 0000 02F6         while (PINB & 0x01); while (!(PINB & 0x01));
; 0000 02F7 #endif
; 0000 02F8         clr_rs;
	CALL SUBOPT_0x8
; 0000 02F9         clr_rw;
	CALL SUBOPT_0xD
; 0000 02FA         *glcd_data_address = 0x40 | GlcdColumn;
	LDS  R30,_GlcdColumn
	ORI  R30,0x40
	CALL SUBOPT_0x6
	ST   X,R30
; 0000 02FB         StackPlus(GlcdWriteByteCase3,GlcdUnlockLockLabel1);
	CALL SUBOPT_0x2
	LDI  R26,LOW(15)
	STD  Z+0,R26
	INC  R13
	JMP  _0x2D
; 0000 02FC #asm
; 0000 02FD GlcdWriteByteLabel1:
GlcdWriteByteLabel1:
; 0000 02FE #endasm
; 0000 02FF GlcdWriteByteLabel1:
_0x66:
; 0000 0300 #ifdef Debugging
; 0000 0301         DebugDisplay(0x3,'1');
; 0000 0302         while (PINB & 0x01); while (!(PINB & 0x01));
; 0000 0303 #endif
; 0000 0304         if(GlcdColumn >= 64)
	LDS  R26,_GlcdColumn
	CPI  R26,LOW(0x40)
	BRLO _0x67
; 0000 0305         {
; 0000 0306             clr_cs1;
	CALL SUBOPT_0x9
; 0000 0307             set_cs2;
; 0000 0308         }
; 0000 0309         else
	RJMP _0x68
_0x67:
; 0000 030A         {
; 0000 030B             set_cs1;
	CALL SUBOPT_0xE
; 0000 030C             clr_cs2;
; 0000 030D         }
_0x68:
; 0000 030E         clr_rs;
	CALL SUBOPT_0x8
; 0000 030F         clr_rw;
	CALL SUBOPT_0xD
; 0000 0310         *glcd_data_address = 0xB8 | GlcdPage;
	MOV  R30,R12
	ORI  R30,LOW(0xB8)
	CALL SUBOPT_0x6
	ST   X,R30
; 0000 0311         StackPlus(GlcdWriteByteCase2,GlcdUnlockLockLabel1);
	CALL SUBOPT_0x2
	LDI  R26,LOW(14)
	STD  Z+0,R26
	INC  R13
	JMP  _0x2D
; 0000 0312 #asm
; 0000 0313 GlcdClearPageLabel2:
GlcdClearPageLabel2:
; 0000 0314 #endasm
; 0000 0315 GlcdClearPageLabel2:
; 0000 0316 #ifdef Debugging
; 0000 0317         DebugDisplay(0x4,'2');
; 0000 0318         while (PINB & 0x01); while (!(PINB & 0x01));
; 0000 0319 #endif
; 0000 031A         GlcdColumn++;
	CALL SUBOPT_0xF
; 0000 031B         if (GlcdColumn < 128)
	LDS  R26,_GlcdColumn
	CPI  R26,LOW(0x80)
	BRSH _0x6D
; 0000 031C             StackPlus(GlcdClearPageCase2,GlcdWriteByteLabel1);
	CALL SUBOPT_0x2
	LDI  R26,LOW(18)
	STD  Z+0,R26
	INC  R13
	RJMP _0x66
; 0000 031D         else
_0x6D:
; 0000 031E         {
; 0000 031F             StackMinus();
	CALL SUBOPT_0x1
	BREQ _0x75
	CALL SUBOPT_0x0
	MOV    R30, R2
	MOV    R31, R3
	IJMP
	RJMP _0x79
_0x75:
	RET
_0x79:
; 0000 0320         }
; 0000 0321 #asm
; 0000 0322 GlcdClearPageLabel1:
GlcdClearPageLabel1:
; 0000 0323 #endasm
; 0000 0324 GlcdClearPageLabel1:
; 0000 0325 #ifdef Debugging
; 0000 0326         DebugDisplay(0x4,'1');
; 0000 0327         while (PINB & 0x01); while (!(PINB & 0x01));
; 0000 0328 #endif
; 0000 0329         GlcdColumn = 0;
	LDI  R30,LOW(0)
	STS  _GlcdColumn,R30
; 0000 032A         GlcdDataByte = 0x00;
	STS  _GlcdDataByte,R30
; 0000 032B         StackPlus(GlcdClearPageCase2,GlcdWriteByteLabel1);
	CALL SUBOPT_0x2
	LDI  R26,LOW(18)
	STD  Z+0,R26
	INC  R13
	RJMP _0x66
; 0000 032C #asm
; 0000 032D GlcdPutcharLabel2:
GlcdPutcharLabel2:
; 0000 032E #endasm
; 0000 032F GlcdPutcharLabel2:
; 0000 0330 #ifdef Debugging
; 0000 0331         DebugDisplay(0x5,'2');
; 0000 0332         while (PINB & 0x01); while (!(PINB & 0x01));
; 0000 0333 #endif
; 0000 0334         if (++i < 6)
	LDS  R26,_i_S0000005000
	SUBI R26,-LOW(1)
	STS  _i_S0000005000,R26
	CPI  R26,LOW(0x6)
	BRSH _0x7F
; 0000 0335         {
; 0000 0336             GlcdDataByte = glcd_font[GlcdChar][i];
	CALL SUBOPT_0x10
	MOVW R26,R30
	CALL SUBOPT_0x11
	ADD  R30,R26
	ADC  R31,R27
	LPM  R0,Z
	STS  _GlcdDataByte,R0
; 0000 0337             GlcdColumn++;
	CALL SUBOPT_0xF
; 0000 0338             StackPlus(GlcdPutcharCase2,GlcdWriteByteLabel1);
	CALL SUBOPT_0x2
	LDI  R26,LOW(20)
	STD  Z+0,R26
	INC  R13
	RJMP _0x66
; 0000 0339         }
; 0000 033A         else
_0x7F:
; 0000 033B         {
; 0000 033C             StackMinus();
	CALL SUBOPT_0x1
	BREQ _0x87
	CALL SUBOPT_0x0
	MOV    R30, R2
	MOV    R31, R3
	IJMP
	RJMP _0x8B
_0x87:
	RET
_0x8B:
; 0000 033D         }
; 0000 033E #asm
; 0000 033F GlcdPutcharLabel1:
GlcdPutcharLabel1:
; 0000 0340 #endasm
; 0000 0341 GlcdPutcharLabel1:
_0x8C:
; 0000 0342 #ifdef Debugging
; 0000 0343         DebugDisplay(0x5,'1');
; 0000 0344         while (PINB & 0x01); while (!(PINB & 0x01));
; 0000 0345 #endif
; 0000 0346         i = 0;
	LDI  R30,LOW(0)
	STS  _i_S0000005000,R30
; 0000 0347         GlcdChar -= 0x20;
	LDS  R30,_GlcdChar
	LDI  R31,0
	SBIW R30,32
	STS  _GlcdChar,R30
; 0000 0348         GlcdDataByte = glcd_font[GlcdChar][0];
	CALL SUBOPT_0x10
	LPM  R0,Z
	STS  _GlcdDataByte,R0
; 0000 0349         StackPlus(GlcdPutcharCase2,GlcdWriteByteLabel1);
	CALL SUBOPT_0x2
	LDI  R26,LOW(20)
	STD  Z+0,R26
	INC  R13
	RJMP _0x66
; 0000 034A #asm
; 0000 034B GlcdPutsLabel2:
GlcdPutsLabel2:
; 0000 034C #endasm
; 0000 034D GlcdPutsLabel2:
; 0000 034E #ifdef Debugging
; 0000 034F         DebugDisplay(0x6,'2');
; 0000 0350         while (PINB & 0x01); while (!(PINB & 0x01));
; 0000 0351 #endif
; 0000 0352         if (*GlcdString)
	CALL SUBOPT_0x12
	LD   R30,X
	CPI  R30,0
	BREQ _0x91
; 0000 0353         {
; 0000 0354             GlcdColumn++;
	CALL SUBOPT_0xF
; 0000 0355             GlcdChar = *GlcdString++;
	CALL SUBOPT_0x13
; 0000 0356             StackPlus(GlcdPutsCase2,GlcdPutcharLabel1);
	CALL SUBOPT_0x2
	LDI  R26,LOW(22)
	STD  Z+0,R26
	INC  R13
	RJMP _0x8C
; 0000 0357         }
; 0000 0358         else
_0x91:
; 0000 0359         {
; 0000 035A             StackMinus();
	CALL SUBOPT_0x1
	BREQ _0x99
	CALL SUBOPT_0x0
	MOV    R30, R2
	MOV    R31, R3
	IJMP
	RJMP _0x9D
_0x99:
	RET
_0x9D:
; 0000 035B         }
; 0000 035C #asm
; 0000 035D GlcdPutsLabel1:
GlcdPutsLabel1:
; 0000 035E #endasm
; 0000 035F GlcdPutsLabel1:
_0x9E:
; 0000 0360 #ifdef Debugging
; 0000 0361         DebugDisplay(0x6,'1');
; 0000 0362         while (PINB & 0x01); while (!(PINB & 0x01));
; 0000 0363 #endif
; 0000 0364         if (*GlcdString)
	CALL SUBOPT_0x12
	LD   R30,X
	CPI  R30,0
	BREQ _0x9F
; 0000 0365         {
; 0000 0366             GlcdChar = *GlcdString++;
	CALL SUBOPT_0x13
; 0000 0367             StackPlus(GlcdPutsCase2,GlcdPutcharLabel1);
	CALL SUBOPT_0x2
	LDI  R26,LOW(22)
	STD  Z+0,R26
	INC  R13
	RJMP _0x8C
; 0000 0368         }
; 0000 0369         else
_0x9F:
; 0000 036A         {
; 0000 036B             StackMinus();
	CALL SUBOPT_0x1
	BREQ _0xA7
	CALL SUBOPT_0x0
	MOV    R30, R2
	MOV    R31, R3
	IJMP
	RJMP _0xAB
_0xA7:
	RET
_0xAB:
; 0000 036C         }
; 0000 036D #asm
; 0000 036E GlcdPutsCenterLabel2:
GlcdPutsCenterLabel2:
; 0000 036F #endasm
; 0000 0370 GlcdPutsCenterLabel2:
; 0000 0371 #ifdef Debugging
; 0000 0372         DebugDisplay(0x7,'2');
; 0000 0373         while (PINB & 0x01); while (!(PINB & 0x01));
; 0000 0374 #endif
; 0000 0375         StackMinus();
	CALL SUBOPT_0x1
	BREQ _0xB0
	CALL SUBOPT_0x0
	MOV    R30, R2
	MOV    R31, R3
	IJMP
	RJMP _0xB4
_0xB0:
	RET
_0xB4:
; 0000 0376 #asm
; 0000 0377 GlcdPutsCenterLabel1:
GlcdPutsCenterLabel1:
; 0000 0378 #endasm
; 0000 0379 GlcdPutsCenterLabel1:
; 0000 037A #ifdef Debugging
; 0000 037B         DebugDisplay(0x7,'1');
; 0000 037C         while (PINB & 0x01); while (!(PINB & 0x01));
; 0000 037D #endif
; 0000 037E         i = strlen_char(GlcdString);
	LDS  R30,_GlcdString
	LDS  R31,_GlcdString+1
	ST   -Y,R31
	ST   -Y,R30
	CALL _strlen_char
	CALL SUBOPT_0x14
; 0000 037F         i = i * 6;
; 0000 0380         i = 128 - i;
	CALL SUBOPT_0x15
; 0000 0381         GlcdColumn = i / 2;
	CALL SUBOPT_0x16
; 0000 0382         StackPlus(GlcdPutsCenterCase2,GlcdPutsLabel1);
	CALL SUBOPT_0x2
	LDI  R26,LOW(24)
	STD  Z+0,R26
	INC  R13
	RJMP _0x9E
; 0000 0383 #asm
; 0000 0384 GlcdPutsfLabel2:
GlcdPutsfLabel2:
; 0000 0385 #endasm
; 0000 0386 GlcdPutsfLabel2:
; 0000 0387 #ifdef Debugging
; 0000 0388         DebugDisplay(0x8,'2');
; 0000 0389         while (PINB & 0x01); while (!(PINB & 0x01));
; 0000 038A #endif
; 0000 038B         if (*GlcdFlashString)
	CALL SUBOPT_0x17
	LPM  R30,Z
	CPI  R30,0
	BREQ _0xBA
; 0000 038C         {
; 0000 038D             GlcdColumn++;
	CALL SUBOPT_0xF
; 0000 038E             GlcdChar = *GlcdFlashString++;
	CALL SUBOPT_0x18
; 0000 038F             StackPlus(GlcdPutsfCase2,GlcdPutcharLabel1);
	CALL SUBOPT_0x2
	LDI  R26,LOW(26)
	STD  Z+0,R26
	INC  R13
	RJMP _0x8C
; 0000 0390         }
; 0000 0391         else
_0xBA:
; 0000 0392         {
; 0000 0393             StackMinus();
	CALL SUBOPT_0x1
	BREQ _0xC2
	CALL SUBOPT_0x0
	MOV    R30, R2
	MOV    R31, R3
	IJMP
	RJMP _0xC6
_0xC2:
	RET
_0xC6:
; 0000 0394         }
; 0000 0395 #asm
; 0000 0396 GlcdPutsfLabel1:
GlcdPutsfLabel1:
; 0000 0397 #endasm
; 0000 0398 GlcdPutsfLabel1:
_0xC7:
; 0000 0399 #ifdef Debugging
; 0000 039A         DebugDisplay(0x8,'1');
; 0000 039B         while (PINB & 0x01); while (!(PINB & 0x01));
; 0000 039C #endif
; 0000 039D         if (*GlcdFlashString)
	CALL SUBOPT_0x17
	LPM  R30,Z
	CPI  R30,0
	BREQ _0xC8
; 0000 039E         {
; 0000 039F             GlcdChar = *GlcdFlashString++;
	CALL SUBOPT_0x18
; 0000 03A0             StackPlus(GlcdPutsfCase2,GlcdPutcharLabel1);
	CALL SUBOPT_0x2
	LDI  R26,LOW(26)
	STD  Z+0,R26
	INC  R13
	JMP  _0x8C
; 0000 03A1         }
; 0000 03A2         else
_0xC8:
; 0000 03A3         {
; 0000 03A4             StackMinus();
	CALL SUBOPT_0x1
	BREQ _0xD0
	CALL SUBOPT_0x0
	MOV    R30, R2
	MOV    R31, R3
	IJMP
	RJMP _0xD4
_0xD0:
	RET
_0xD4:
; 0000 03A5         }
; 0000 03A6 #asm
; 0000 03A7 GlcdPutsfCenterLabel2:
GlcdPutsfCenterLabel2:
; 0000 03A8 #endasm
; 0000 03A9 GlcdPutsfCenterLabel2:
; 0000 03AA #ifdef Debugging
; 0000 03AB         DebugDisplay(0x9,'2');
; 0000 03AC         while (PINB & 0x01); while (!(PINB & 0x01));
; 0000 03AD #endif
; 0000 03AE         StackMinus();
	CALL SUBOPT_0x1
	BREQ _0xD9
	CALL SUBOPT_0x0
	MOV    R30, R2
	MOV    R31, R3
	IJMP
	RJMP _0xDD
_0xD9:
	RET
_0xDD:
; 0000 03AF #asm
; 0000 03B0 GlcdPutsfCenterLabel1:
GlcdPutsfCenterLabel1:
; 0000 03B1 #endasm
; 0000 03B2 GlcdPutsfCenterLabel1:
; 0000 03B3 #ifdef Debugging
; 0000 03B4         DebugDisplay(0x9,'1');
; 0000 03B5         while (PINB & 0x01); while (!(PINB & 0x01));
; 0000 03B6 #endif
; 0000 03B7         i = strlenf_char(GlcdFlashString);
	CALL SUBOPT_0x17
	ST   -Y,R31
	ST   -Y,R30
	CALL _strlenf_char
	CALL SUBOPT_0x14
; 0000 03B8         i = i * 6;
; 0000 03B9         i = 128 - i;
	CALL SUBOPT_0x15
; 0000 03BA         GlcdColumn = i / 2;
	CALL SUBOPT_0x16
; 0000 03BB         StackPlus(GlcdPutsfCenterCase2,GlcdPutsfLabel1);
	CALL SUBOPT_0x2
	LDI  R26,LOW(28)
	STD  Z+0,R26
	INC  R13
	RJMP _0xC7
; 0000 03BC #asm
; 0000 03BD GlcdClearLabel2:
GlcdClearLabel2:
; 0000 03BE #endasm
; 0000 03BF GlcdClearLabel2:
; 0000 03C0 #ifdef Debugging
; 0000 03C1         DebugDisplay(0xa,'2');
; 0000 03C2         while (PINB & 0x01); while (!(PINB & 0x01));
; 0000 03C3 #endif
; 0000 03C4         if (((GlcdPage == 7) && (GlcdColumn < 127)) || (GlcdPage < 7))
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
; 0000 03C5         {
; 0000 03C6             GlcdColumn++;
	CALL SUBOPT_0xF
; 0000 03C7             if (GlcdColumn == 128)
	LDS  R26,_GlcdColumn
	CPI  R26,LOW(0x80)
	BRNE _0xE8
; 0000 03C8             {
; 0000 03C9                 GlcdColumn = 0;
	LDI  R30,LOW(0)
	STS  _GlcdColumn,R30
; 0000 03CA                 GlcdPage++;
	INC  R12
; 0000 03CB             }
; 0000 03CC             StackPlus(GlcdClearCase2,GlcdWriteByteLabel1);
_0xE8:
	CALL SUBOPT_0x2
	LDI  R26,LOW(30)
	STD  Z+0,R26
	INC  R13
	JMP  _0x66
; 0000 03CD         }
; 0000 03CE         else
_0xE3:
; 0000 03CF         {
; 0000 03D0             StackMinus();
	CALL SUBOPT_0x1
	BREQ _0xF0
	CALL SUBOPT_0x0
	MOV    R30, R2
	MOV    R31, R3
	IJMP
	RJMP _0xF4
_0xF0:
	RET
_0xF4:
; 0000 03D1         }
; 0000 03D2 #asm
; 0000 03D3 GlcdClearLabel1:
GlcdClearLabel1:
; 0000 03D4 #endasm
; 0000 03D5 GlcdClearLabel1:
; 0000 03D6 #ifdef Debugging
; 0000 03D7         DebugDisplay(0xa,'1');
; 0000 03D8         while (PINB & 0x01); while (!(PINB & 0x01));
; 0000 03D9 #endif
; 0000 03DA         GlcdColumn = 0;
	LDI  R30,LOW(0)
	STS  _GlcdColumn,R30
; 0000 03DB         GlcdPage = 0;
	CLR  R12
; 0000 03DC         GlcdDataByte = 0x00;
	STS  _GlcdDataByte,R30
; 0000 03DD         StackPlus(GlcdClearCase2,GlcdWriteByteLabel1);
	CALL SUBOPT_0x2
	LDI  R26,LOW(30)
	STD  Z+0,R26
	INC  R13
	JMP  _0x66
; 0000 03DE #asm
; 0000 03DF GlcdPutbmpLabel2:
GlcdPutbmpLabel2:
; 0000 03E0 #endasm
; 0000 03E1 GlcdPutbmpLabel2:
; 0000 03E2 #ifdef Debugging
; 0000 03E3         DebugDisplay(0xb,'2');
; 0000 03E4         while (PINB & 0x01); while (!(PINB & 0x01));
; 0000 03E5 #endif
; 0000 03E6         if (++j < 1024)
	LDS  R26,_j_S0000005000
	LDS  R27,_j_S0000005000+1
	ADIW R26,1
	STS  _j_S0000005000,R26
	STS  _j_S0000005000+1,R27
	CPI  R26,LOW(0x400)
	LDI  R30,HIGH(0x400)
	CPC  R27,R30
	BRSH _0xFA
; 0000 03E7         {
; 0000 03E8             GlcdColumn = ((unsigned char)(j)) & 0x7F;
	LDS  R30,_j_S0000005000
	ANDI R30,0x7F
	STS  _GlcdColumn,R30
; 0000 03E9             GlcdPage = ((unsigned char)(j >> 7));
	LDI  R30,LOW(7)
	CALL __LSRW12
	MOV  R12,R30
; 0000 03EA             GlcdDataByte = *(++GlcdFlashPointer);
	LDS  R30,_GlcdFlashPointer
	LDS  R31,_GlcdFlashPointer+1
	ADIW R30,1
	STS  _GlcdFlashPointer,R30
	STS  _GlcdFlashPointer+1,R31
	LPM  R0,Z
	STS  _GlcdDataByte,R0
; 0000 03EB             StackPlus(GlcdPutbmpCase2,GlcdWriteByteLabel1);
	CALL SUBOPT_0x2
	LDI  R26,LOW(32)
	STD  Z+0,R26
	INC  R13
	JMP  _0x66
; 0000 03EC         }
; 0000 03ED         else
_0xFA:
; 0000 03EE         {
; 0000 03EF             StackMinus();
	CALL SUBOPT_0x1
	BREQ _0x102
	CALL SUBOPT_0x0
	MOV    R30, R2
	MOV    R31, R3
	IJMP
	RJMP _0x106
_0x102:
	RET
_0x106:
; 0000 03F0         }
; 0000 03F1 #asm
; 0000 03F2 GlcdPutbmpLabel1:
GlcdPutbmpLabel1:
; 0000 03F3 #endasm
; 0000 03F4 GlcdPutbmpLabel1:
; 0000 03F5 #ifdef Debugging
; 0000 03F6         DebugDisplay(0xb,'1');
; 0000 03F7         while (PINB & 0x01); while (!(PINB & 0x01));
; 0000 03F8 #endif
; 0000 03F9         j = 0;
	LDI  R30,LOW(0)
	STS  _j_S0000005000,R30
	STS  _j_S0000005000+1,R30
; 0000 03FA         GlcdColumn = 0;
	STS  _GlcdColumn,R30
; 0000 03FB         GlcdPage = 0;
	CLR  R12
; 0000 03FC         GlcdDataByte = *GlcdFlashPointer;
	LDS  R30,_GlcdFlashPointer
	LDS  R31,_GlcdFlashPointer+1
	LPM  R0,Z
	STS  _GlcdDataByte,R0
; 0000 03FD         StackPlus(GlcdPutbmpCase2,GlcdWriteByteLabel1);
	CALL SUBOPT_0x2
	LDI  R26,LOW(32)
	STD  Z+0,R26
	INC  R13
	JMP  _0x66
; 0000 03FE     }
; 0000 03FF }
_0xF:
	RET
;
;
;
;// GLCD initializing function
;void glcd_init (void)
; 0000 0405 {
; 0000 0406     while (GlcdBusy);
; 0000 0407     PushCase (GlcdInitCase1);
; 0000 0408     glcd_timer_isr();
; 0000 0409 }
;
;// GLCD write byte in specific column and page function
;void glcd_writebyte (unsigned char column, unsigned char page, unsigned char data)
; 0000 040D {
; 0000 040E     while (GlcdBusy);
;	column -> Y+2
;	page -> Y+1
;	data -> Y+0
; 0000 040F     GlcdColumn = column;
; 0000 0410     GlcdPage = page;
; 0000 0411     GlcdDataByte = data;
; 0000 0412     PushCase(GlcdWriteByteCase1);
; 0000 0413     glcd_timer_isr();
; 0000 0414 }
;
;// GLCD clear page function
;void glcd_clear_page (unsigned char page)
; 0000 0418 {
; 0000 0419     while (GlcdBusy);
;	page -> Y+0
; 0000 041A     GlcdPage = page;
; 0000 041B     PushCase (GlcdClearPageCase1);
; 0000 041C     glcd_timer_isr();
; 0000 041D }
;
;// GLCD put character function
;void glcd_putchar (unsigned char column, unsigned char page, unsigned char ch)
; 0000 0421 {
; 0000 0422     while (GlcdBusy);
;	column -> Y+2
;	page -> Y+1
;	ch -> Y+0
; 0000 0423     GlcdColumn = column;
; 0000 0424     GlcdPage = page;
; 0000 0425     GlcdChar = ch;
; 0000 0426     PushCase(GlcdPutcharCase1);
; 0000 0427     glcd_timer_isr();
; 0000 0428 }
;
;// GLCD put string function
;void glcd_puts (unsigned char column, unsigned char page, unsigned char *str)
; 0000 042C {
; 0000 042D     while (GlcdBusy);
;	column -> Y+3
;	page -> Y+2
;	*str -> Y+0
; 0000 042E     GlcdColumn = column;
; 0000 042F     GlcdPage = page;
; 0000 0430     GlcdString = str;
; 0000 0431     PushCase(GlcdPutsCase1);
; 0000 0432     glcd_timer_isr();
; 0000 0433 }
;
;// GLCD put string in center function
;void glcd_puts_center (unsigned char page, unsigned char *str)
; 0000 0437 {
; 0000 0438     while (GlcdBusy);
;	page -> Y+2
;	*str -> Y+0
; 0000 0439     GlcdPage = page;
; 0000 043A     GlcdString = str;
; 0000 043B     PushCase(GlcdPutsCenterCase1);
; 0000 043C     glcd_timer_isr();
; 0000 043D }
;
;// GLCD put flash string function
;void glcd_putsf (unsigned char column, unsigned char page, flash unsigned char *str)
; 0000 0441 {
; 0000 0442     while (GlcdBusy);
;	column -> Y+3
;	page -> Y+2
;	*str -> Y+0
; 0000 0443     GlcdColumn = column;
; 0000 0444     GlcdPage = page;
; 0000 0445     GlcdFlashString = str;
; 0000 0446     PushCase(GlcdPutsfCase1);
; 0000 0447     glcd_timer_isr();
; 0000 0448 }
;
;// GLCD put flash string in center function
;void glcd_putsf_center (unsigned char page, flash unsigned char *str)
; 0000 044C {
; 0000 044D     while (GlcdBusy);
;	page -> Y+2
;	*str -> Y+0
; 0000 044E     GlcdPage = page;
; 0000 044F     GlcdFlashString = str;
; 0000 0450     PushCase(GlcdPutsfCenterCase1);
; 0000 0451     glcd_timer_isr();
; 0000 0452 }
;
;// GLCD clear function
;void glcd_clear (void)
; 0000 0456 {
; 0000 0457     while (GlcdBusy);
; 0000 0458     PushCase(GlcdClearCase1);
; 0000 0459     glcd_timer_isr();
; 0000 045A }
;
;// GLCD put bitmap function
;void glcd_putbmp (flash unsigned char *bmp)
; 0000 045E {
; 0000 045F     while (GlcdBusy);
;	*bmp -> Y+0
; 0000 0460     GlcdFlashPointer = bmp;
; 0000 0461     PushCase(GlcdPutbmpCase1);
; 0000 0462     glcd_timer_isr();
; 0000 0463 }
;
;#include <delay.h>
;
;void glcd_define2 (unsigned char *glcd_data_port_address,
; 0000 0468                   unsigned char *glcd_rs_port_address,  unsigned char glcd_rs_pin,
; 0000 0469                   unsigned char *glcd_rw_port_address,  unsigned char glcd_rw_pin,
; 0000 046A                   unsigned char *glcd_en_port_address,  unsigned char glcd_en_pin,
; 0000 046B                   unsigned char *glcd_cs1_port_address, unsigned char glcd_cs1_pin,
; 0000 046C                   unsigned char *glcd_cs2_port_address, unsigned char glcd_cs2_pin,
; 0000 046D                   unsigned char *glcd_rst_port_address, unsigned char glcd_rst_pin)
; 0000 046E {
_glcd_define2:
; 0000 046F   glcd_data_address = glcd_data_port_address;
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
; 0000 0470   glcd_rs_address   = glcd_rs_port_address;
	LDD  R30,Y+16
	LDD  R31,Y+16+1
	STS  _glcd_rs_address_G000,R30
	STS  _glcd_rs_address_G000+1,R31
; 0000 0471   glcd_rw_address   = glcd_rw_port_address;
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	STS  _glcd_rw_address_G000,R30
	STS  _glcd_rw_address_G000+1,R31
; 0000 0472   glcd_en_address   = glcd_en_port_address;
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	STS  _glcd_en_address_G000,R30
	STS  _glcd_en_address_G000+1,R31
; 0000 0473   glcd_cs1_address  = glcd_cs1_port_address;
	LDD  R30,Y+7
	LDD  R31,Y+7+1
	STS  _glcd_cs1_address_G000,R30
	STS  _glcd_cs1_address_G000+1,R31
; 0000 0474   glcd_cs2_address  = glcd_cs2_port_address;
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	STS  _glcd_cs2_address_G000,R30
	STS  _glcd_cs2_address_G000+1,R31
; 0000 0475   glcd_rst_address  = glcd_rst_port_address;
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	STS  _glcd_rst_address_G000,R30
	STS  _glcd_rst_address_G000+1,R31
; 0000 0476 #ifdef _ATXMEGA_DEVICE_
; 0000 0477   glcd_rs_bit_msk  = 0b00000001 << glcd_rs_pin;
	LDD  R30,Y+15
	LDI  R26,LOW(1)
	CALL __LSLB12
	STS  _glcd_rs_bit_msk_G000,R30
; 0000 0478   glcd_rw_bit_msk  = 0b00000001 << glcd_rw_pin;
	LDD  R30,Y+12
	CALL __LSLB12
	STS  _glcd_rw_bit_msk_G000,R30
; 0000 0479   glcd_en_bit_msk  = 0b00000001 << glcd_en_pin;
	LDD  R30,Y+9
	CALL __LSLB12
	STS  _glcd_en_bit_msk_G000,R30
; 0000 047A   glcd_cs1_bit_msk = 0b00000001 << glcd_cs1_pin;
	LDD  R30,Y+6
	CALL __LSLB12
	STS  _glcd_cs1_bit_msk_G000,R30
; 0000 047B   glcd_cs2_bit_msk = 0b00000001 << glcd_cs2_pin;
	LDD  R30,Y+3
	CALL __LSLB12
	STS  _glcd_cs2_bit_msk_G000,R30
; 0000 047C   glcd_rst_bit_msk = 0b00000001 << glcd_rst_pin;
	LD   R30,Y
	CALL __LSLB12
	STS  _glcd_rst_bit_msk_G000,R30
; 0000 047D   // Set all the pins as output
; 0000 047E   *(glcd_data_address - 0x03) = 0xFF;
	LDS  R30,_glcd_data_address_G000
	LDS  R31,_glcd_data_address_G000+1
	SBIW R30,3
	LDI  R26,LOW(255)
	STD  Z+0,R26
; 0000 047F   *(glcd_rs_address - 0x03)   = glcd_rs_bit_msk;
	LDS  R30,_glcd_rs_address_G000
	LDS  R31,_glcd_rs_address_G000+1
	SBIW R30,3
	LDS  R26,_glcd_rs_bit_msk_G000
	STD  Z+0,R26
; 0000 0480   clr_rw;
	CALL SUBOPT_0xD
; 0000 0481   *(glcd_rw_address - 0x03)   = glcd_rw_bit_msk;
	LDS  R30,_glcd_rw_address_G000
	LDS  R31,_glcd_rw_address_G000+1
	SBIW R30,3
	LDS  R26,_glcd_rw_bit_msk_G000
	STD  Z+0,R26
; 0000 0482   *(glcd_en_address - 0x03)   = glcd_en_bit_msk;
	LDS  R30,_glcd_en_address_G000
	LDS  R31,_glcd_en_address_G000+1
	SBIW R30,3
	LDS  R26,_glcd_en_bit_msk_G000
	STD  Z+0,R26
; 0000 0483   *(glcd_cs1_address - 0x03)  = glcd_cs1_bit_msk;
	LDS  R30,_glcd_cs1_address_G000
	LDS  R31,_glcd_cs1_address_G000+1
	SBIW R30,3
	LDS  R26,_glcd_cs1_bit_msk_G000
	STD  Z+0,R26
; 0000 0484   *(glcd_cs2_address - 0x03)  = glcd_cs2_bit_msk;
	LDS  R30,_glcd_cs2_address_G000
	LDS  R31,_glcd_cs2_address_G000+1
	SBIW R30,3
	LDS  R26,_glcd_cs2_bit_msk_G000
	STD  Z+0,R26
; 0000 0485   *(glcd_rst_address - 0x03)  = glcd_rst_bit_msk;
	LDS  R30,_glcd_rst_address_G000
	LDS  R31,_glcd_rst_address_G000+1
	SBIW R30,3
	LDS  R26,_glcd_rst_bit_msk_G000
	STD  Z+0,R26
; 0000 0486 #else
; 0000 0487   glcd_rs_bit_pos  = glcd_rs_pin;
; 0000 0488   glcd_rw_bit_pos  = glcd_rw_pin;
; 0000 0489   glcd_en_bit_pos  = glcd_en_pin;
; 0000 048A   glcd_cs1_bit_pos = glcd_cs1_pin;
; 0000 048B   glcd_cs2_bit_pos = glcd_cs2_pin;
; 0000 048C   glcd_rst_bit_pos = glcd_rst_pin;
; 0000 048D   // Sets the pins as output
; 0000 048E   *(glcd_data_address - 1) = 0xFF;
; 0000 048F   SETBIT (*(glcd_rs_address - 0x01),glcd_rs_bit_pos);
; 0000 0490   SETBIT (*(glcd_rw_address - 0x01),glcd_rw_bit_pos);
; 0000 0491   clr_rw;
; 0000 0492   SETBIT (*(glcd_en_address - 0x01),glcd_en_bit_pos);
; 0000 0493   SETBIT (*(glcd_cs1_address - 0x01),glcd_cs1_bit_pos);
; 0000 0494   SETBIT (*(glcd_cs2_address - 0x01),glcd_cs2_bit_pos);
; 0000 0495   SETBIT (*(glcd_rst_address - 0x01),glcd_rst_bit_pos);
; 0000 0496 #endif
; 0000 0497 }
	RJMP _0x2060002
;
;void glcd_unlock_lock2 (void)
; 0000 049A {
_glcd_unlock_lock2:
; 0000 049B   delay_us(7);
	__DELAY_USB 75
; 0000 049C   set_en;
	CALL SUBOPT_0x4
; 0000 049D   delay_us(7);
	__DELAY_USB 75
; 0000 049E   clr_en;
	CALL SUBOPT_0x3
; 0000 049F }
	RET
;
;void glcd_init2 (void)
; 0000 04A2 {
_glcd_init2:
; 0000 04A3   char i;
; 0000 04A4   clr_rst;
	ST   -Y,R17
;	i -> R17
	CALL SUBOPT_0xB
; 0000 04A5   delay_ms(10);
	CALL SUBOPT_0x19
; 0000 04A6   set_rst;
	CALL SUBOPT_0xA
; 0000 04A7   delay_ms(10);
	CALL SUBOPT_0x19
; 0000 04A8   clr_rs;
	CALL SUBOPT_0x8
; 0000 04A9   clr_cs1;
	CALL SUBOPT_0x9
; 0000 04AA   set_cs2;
; 0000 04AB   for (i=0;i<2;i++)
	LDI  R17,LOW(0)
_0x12A:
	CPI  R17,2
	BRSH _0x12B
; 0000 04AC   {
; 0000 04AD     *glcd_data_address = 0x3E;
	CALL SUBOPT_0x6
	LDI  R30,LOW(62)
	CALL SUBOPT_0x1A
; 0000 04AE     glcd_unlock_lock2();
; 0000 04AF     *glcd_data_address = 0x40;
	LDI  R30,LOW(64)
	CALL SUBOPT_0x1A
; 0000 04B0     glcd_unlock_lock2();
; 0000 04B1     *glcd_data_address = 0xB8;
	LDI  R30,LOW(184)
	CALL SUBOPT_0x1A
; 0000 04B2     glcd_unlock_lock2();
; 0000 04B3     *glcd_data_address = 0x3F;
	LDI  R30,LOW(63)
	ST   X,R30
; 0000 04B4     glcd_unlock_lock2();
	RCALL _glcd_unlock_lock2
; 0000 04B5     tgl_cs1;
	CALL SUBOPT_0x5
; 0000 04B6     tgl_cs2;
; 0000 04B7   }
	SUBI R17,-1
	RJMP _0x12A
_0x12B:
; 0000 04B8 }
	RJMP _0x2060005
;
;void glcd_writebyte2 (char clmn, char pg, char data)
; 0000 04BB {
_glcd_writebyte2:
; 0000 04BC   if(clmn >= 64)
;	clmn -> Y+2
;	pg -> Y+1
;	data -> Y+0
	LDD  R26,Y+2
	CPI  R26,LOW(0x40)
	BRLO _0x12C
; 0000 04BD   {
; 0000 04BE     clr_cs1;
	CALL SUBOPT_0x9
; 0000 04BF     set_cs2;
; 0000 04C0   }
; 0000 04C1   else
	RJMP _0x12D
_0x12C:
; 0000 04C2   {
; 0000 04C3     set_cs1;
	CALL SUBOPT_0xE
; 0000 04C4     clr_cs2;
; 0000 04C5   }
_0x12D:
; 0000 04C6   clr_rs;
	CALL SUBOPT_0x8
; 0000 04C7   clr_rw;
	CALL SUBOPT_0xD
; 0000 04C8   *glcd_data_address = 0xB8 | pg;
	LDD  R30,Y+1
	ORI  R30,LOW(0xB8)
	CALL SUBOPT_0x1B
; 0000 04C9   glcd_unlock_lock2();
; 0000 04CA 
; 0000 04CB   clr_rs;
	CALL SUBOPT_0x8
; 0000 04CC   clr_rw;
	CALL SUBOPT_0xD
; 0000 04CD   *glcd_data_address = 0x40 | clmn;
	LDD  R30,Y+2
	ORI  R30,0x40
	CALL SUBOPT_0x1B
; 0000 04CE   glcd_unlock_lock2();
; 0000 04CF 
; 0000 04D0   set_rs;
	CALL SUBOPT_0xC
; 0000 04D1   clr_rw;
; 0000 04D2   *glcd_data_address = data;
	LD   R30,Y
	CALL SUBOPT_0x1B
; 0000 04D3   glcd_unlock_lock2();
; 0000 04D4 }
_0x206000A:
	ADIW R28,3
	RET
;
;void glcd_clear_page2 (char page)
; 0000 04D7 {
; 0000 04D8   char i;
; 0000 04D9   for (i = 0;i < 128;i++)
;	page -> Y+1
;	i -> R17
; 0000 04DA     glcd_writebyte2(i,page,0x00);
; 0000 04DB }
;
;void glcd_putchar2 (char column, char page, char ch)
; 0000 04DE {
_glcd_putchar2:
; 0000 04DF   char i;
; 0000 04E0   ch -= 32;
	ST   -Y,R17
;	column -> Y+3
;	page -> Y+2
;	ch -> Y+1
;	i -> R17
	LDD  R30,Y+1
	LDI  R31,0
	SBIW R30,32
	STD  Y+1,R30
; 0000 04E1   for (i = 0;i < 6;i++)
	LDI  R17,LOW(0)
_0x132:
	CPI  R17,6
	BRSH _0x133
; 0000 04E2   {
; 0000 04E3     glcd_writebyte2(column, page, glcd_font[ch][i]);
	LDD  R30,Y+3
	ST   -Y,R30
	LDD  R30,Y+3
	ST   -Y,R30
	LDD  R30,Y+3
	LDI  R26,LOW(6)
	MUL  R30,R26
	MOVW R30,R0
	SUBI R30,LOW(-_glcd_font*2)
	SBCI R31,HIGH(-_glcd_font*2)
	MOVW R26,R30
	MOV  R30,R17
	LDI  R31,0
	CALL SUBOPT_0x1C
; 0000 04E4     column++;
	LDD  R30,Y+3
	SUBI R30,-LOW(1)
	STD  Y+3,R30
; 0000 04E5   };
	SUBI R17,-1
	RJMP _0x132
_0x133:
; 0000 04E6 }
	RJMP _0x2060009
;
;void glcd_puts2 (char column, char page, char* str)
; 0000 04E9 {
_glcd_puts2:
; 0000 04EA   while (*str)
;	column -> Y+3
;	page -> Y+2
;	*str -> Y+0
_0x134:
	LD   R26,Y
	LDD  R27,Y+1
	LD   R30,X
	CPI  R30,0
	BREQ _0x136
; 0000 04EB   {
; 0000 04EC     glcd_putchar2(column, page, *str++);
	LDD  R30,Y+3
	ST   -Y,R30
	LDD  R30,Y+3
	ST   -Y,R30
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	LD   R30,X+
	STD  Y+2,R26
	STD  Y+2+1,R27
	ST   -Y,R30
	RCALL _glcd_putchar2
; 0000 04ED     column += 6;
	LDD  R30,Y+3
	SUBI R30,-LOW(6)
	STD  Y+3,R30
; 0000 04EE   }
	RJMP _0x134
_0x136:
; 0000 04EF }
	RJMP _0x2060008
;
;void glcd_puts_center2 (char page, char* str)
; 0000 04F2 {
_glcd_puts_center2:
; 0000 04F3   char i;
; 0000 04F4   i = strlen_char(str);
	ST   -Y,R17
;	page -> Y+3
;	*str -> Y+1
;	i -> R17
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	ST   -Y,R31
	ST   -Y,R30
	CALL _strlen_char
	MOV  R17,R30
; 0000 04F5   i = (128 - i * 6) / 2;
	LDI  R30,LOW(6)
	MUL  R30,R17
	MOVW R30,R0
	LDI  R26,LOW(128)
	LDI  R27,HIGH(128)
	SUB  R26,R30
	SBC  R27,R31
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	CALL __DIVW21
	MOV  R17,R30
; 0000 04F6   glcd_puts2(i,page,str);
	ST   -Y,R17
	LDD  R30,Y+4
	ST   -Y,R30
	LDD  R30,Y+3
	LDD  R31,Y+3+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL _glcd_puts2
; 0000 04F7 }
_0x2060009:
	LDD  R17,Y+0
_0x2060008:
	ADIW R28,4
	RET
;
;void glcd_putsf2 (char column, char page,flash char* str)
; 0000 04FA {
; 0000 04FB   while (*str)
;	column -> Y+3
;	page -> Y+2
;	*str -> Y+0
; 0000 04FC   {
; 0000 04FD     glcd_putchar2(column, page, *str++ );
; 0000 04FE     column += 6;
; 0000 04FF   }
; 0000 0500 }
;
;void glcd_putsf_center2 (char page, flash char* str)
; 0000 0503 {
; 0000 0504   char i;
; 0000 0505   i = strlenf_char(str);
;	page -> Y+3
;	*str -> Y+1
;	i -> R17
; 0000 0506   i = (128 - i * 6) / 2;
; 0000 0507   glcd_putsf2(i,page,str);
; 0000 0508 }
;
;void glcd_clear2 (void)
; 0000 050B {
_glcd_clear2:
; 0000 050C   char i, j;
; 0000 050D   for (i = 0;i < 8;i++)
	ST   -Y,R17
	ST   -Y,R16
;	i -> R17
;	j -> R16
	LDI  R17,LOW(0)
_0x13B:
	CPI  R17,8
	BRSH _0x13C
; 0000 050E     for (j = 0;j < 128;j++)
	LDI  R16,LOW(0)
_0x13E:
	CPI  R16,128
	BRSH _0x13F
; 0000 050F       glcd_writebyte2(j, i, 0);
	ST   -Y,R16
	ST   -Y,R17
	LDI  R30,LOW(0)
	ST   -Y,R30
	RCALL _glcd_writebyte2
	SUBI R16,-1
	RJMP _0x13E
_0x13F:
; 0000 0510 }
	SUBI R17,-1
	RJMP _0x13B
_0x13C:
	RJMP _0x2060006
;
;void glcd_putbmp2 (flash unsigned char bmp[])
; 0000 0513 {
_glcd_putbmp2:
; 0000 0514   char x=0;
; 0000 0515   char y=0;
; 0000 0516   unsigned int i;
; 0000 0517   for(i=0;i<1024;i++)
	CALL __SAVELOCR4
;	x -> R17
;	y -> R16
;	i -> R18,R19
	LDI  R17,0
	LDI  R16,0
	__GETWRN 18,19,0
_0x141:
	__CPWRN 18,19,1024
	BRSH _0x142
; 0000 0518   {
; 0000 0519     if(x==128)
	CPI  R17,128
	BRNE _0x143
; 0000 051A     {
; 0000 051B       x=0;
	LDI  R17,LOW(0)
; 0000 051C       y++;
	SUBI R16,-1
; 0000 051D     }
; 0000 051E     glcd_writebyte2(x,y,bmp[i]);
_0x143:
	ST   -Y,R17
	ST   -Y,R16
	MOVW R30,R18
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	CALL SUBOPT_0x1C
; 0000 051F     x++;
	SUBI R17,-1
; 0000 0520   }
	__ADDWRN 18,19,1
	RJMP _0x141
_0x142:
; 0000 0521 }
	CALL __LOADLOCR4
	ADIW R28,6
	RET
;
;// System Clocks initialization
;void system_clocks_init(void)
; 0000 0525 {
_system_clocks_init:
; 0000 0526 unsigned char n,s;
; 0000 0527 
; 0000 0528 // Optimize for speed
; 0000 0529 #pragma optsize-
; 0000 052A // Save interrupts enabled/disabled state
; 0000 052B s=SREG;
	ST   -Y,R17
	ST   -Y,R16
;	n -> R17
;	s -> R16
	IN   R16,63
; 0000 052C // Disable interrupts
; 0000 052D #asm("cli")
	cli
; 0000 052E 
; 0000 052F // External 12000.000 kHz clock source on XTAL1 initialization
; 0000 0530 OSC.XOSCCTRL=0xCB;
	LDI  R30,LOW(203)
	STS  82,R30
; 0000 0531 // Enable the external clock source
; 0000 0532 OSC.CTRL|=OSC_XOSCEN_bm;
	LDS  R30,80
	ORI  R30,8
	STS  80,R30
; 0000 0533 
; 0000 0534 // System Clock prescaler A division factor: 1
; 0000 0535 // System Clock prescalers B & C division factors: B:1, C:1
; 0000 0536 // ClkPer4: 24000.000 kHz
; 0000 0537 // ClkPer2: 24000.000 kHz
; 0000 0538 // ClkPer:  24000.000 kHz
; 0000 0539 // ClkCPU:  24000.000 kHz
; 0000 053A n=(CLK.PSCTRL & (~(CLK_PSADIV_gm | CLK_PSBCDIV1_bm | CLK_PSBCDIV0_bm))) |
; 0000 053B 	CLK_PSADIV_1_gc | CLK_PSBCDIV_1_1_gc;
	LDS  R30,65
	ANDI R30,LOW(0x80)
	MOV  R17,R30
; 0000 053C CCP=CCP_IOREG_gc;
	LDI  R30,LOW(216)
	OUT  0x34,R30
; 0000 053D CLK.PSCTRL=n;
	STS  65,R17
; 0000 053E 
; 0000 053F // PLL initialization
; 0000 0540 // PLL clock cource: External Osc. or Clock
; 0000 0541 // PLL multiplication factor: 2
; 0000 0542 // PLL frequency: 24.000000 MHz
; 0000 0543 // Set the PLL clock source and multiplication factor
; 0000 0544 n=(OSC.PLLCTRL & (~(OSC_PLLSRC_gm | OSC_PLLFAC_gm))) |
; 0000 0545 	OSC_PLLSRC_XOSC_gc | 2;
	LDS  R30,85
	ANDI R30,LOW(0x20)
	ORI  R30,LOW(0xC2)
	MOV  R17,R30
; 0000 0546 CCP=CCP_IOREG_gc;
	LDI  R30,LOW(216)
	OUT  0x34,R30
; 0000 0547 OSC.PLLCTRL=n;
	STS  85,R17
; 0000 0548 
; 0000 0549 // Wait for the clock source of PLL to be stable
; 0000 054A while ((OSC.STATUS & OSC_XOSCRDY_bm)==0);
_0x144:
	LDS  R30,81
	ANDI R30,LOW(0x8)
	BREQ _0x144
; 0000 054B 
; 0000 054C // Enable the PLL
; 0000 054D OSC.CTRL|=OSC_PLLEN_bm;
	LDS  R30,80
	ORI  R30,0x10
	STS  80,R30
; 0000 054E 
; 0000 054F // System Clock prescaler A division factor: 1
; 0000 0550 // System Clock prescalers B & C division factors: B:1, C:1
; 0000 0551 // ClkPer4: 24000.000 kHz
; 0000 0552 // ClkPer2: 24000.000 kHz
; 0000 0553 // ClkPer:  24000.000 kHz
; 0000 0554 // ClkCPU:  24000.000 kHz
; 0000 0555 n=(CLK.PSCTRL & (~(CLK_PSADIV_gm | CLK_PSBCDIV1_bm | CLK_PSBCDIV0_bm))) |
; 0000 0556 	CLK_PSADIV_1_gc | CLK_PSBCDIV_1_1_gc;
	LDS  R30,65
	ANDI R30,LOW(0x80)
	MOV  R17,R30
; 0000 0557 CCP=CCP_IOREG_gc;
	LDI  R30,LOW(216)
	OUT  0x34,R30
; 0000 0558 CLK.PSCTRL=n;
	STS  65,R17
; 0000 0559 
; 0000 055A // Wait for the PLL to stabilize
; 0000 055B while ((OSC.STATUS & OSC_PLLRDY_bm)==0);
_0x147:
	LDS  R30,81
	ANDI R30,LOW(0x10)
	BREQ _0x147
; 0000 055C 
; 0000 055D // Select the system clock source: Phase Locked Loop
; 0000 055E n=(CLK.CTRL & (~CLK_SCLKSEL_gm)) | CLK_SCLKSEL_PLL_gc;
	LDS  R30,64
	ANDI R30,LOW(0xF8)
	ORI  R30,4
	MOV  R17,R30
; 0000 055F CCP=CCP_IOREG_gc;
	LDI  R30,LOW(216)
	OUT  0x34,R30
; 0000 0560 CLK.CTRL=n;
	STS  64,R17
; 0000 0561 
; 0000 0562 // Disable the unused oscillators: 2 MHz, 32 MHz, internal 32 kHz
; 0000 0563 OSC.CTRL&= ~(OSC_RC2MEN_bm | OSC_RC32MEN_bm | OSC_RC32KEN_bm);
	LDS  R30,80
	ANDI R30,LOW(0xF8)
	STS  80,R30
; 0000 0564 
; 0000 0565 // Peripheral Clock output: Disabled
; 0000 0566 PORTCFG.CLKEVOUT=(PORTCFG.CLKEVOUT & (~PORTCFG_CLKOUT_gm)) | PORTCFG_CLKOUT_OFF_gc;
	LDS  R30,180
	ANDI R30,LOW(0xFC)
	STS  180,R30
; 0000 0567 
; 0000 0568 // Restore interrupts enabled/disabled state
; 0000 0569 SREG=s;
	OUT  0x3F,R16
; 0000 056A // Restore optimization for size if needed
; 0000 056B #pragma optsize_default
; 0000 056C }
	RJMP _0x2060006
;
;// Ports initialization
;void ports_init(void)
; 0000 0570 {
_ports_init:
; 0000 0571 // PORTA initialization
; 0000 0572 // OUT register
; 0000 0573 PORTA.OUT=0x00;
	LDI  R30,LOW(0)
	STS  1540,R30
; 0000 0574 // Bit0: Input
; 0000 0575 // Bit1: Input
; 0000 0576 // Bit2: Input
; 0000 0577 // Bit3: Input
; 0000 0578 // Bit4: Input
; 0000 0579 // Bit5: Input
; 0000 057A // Bit6: Input
; 0000 057B // Bit7: Input
; 0000 057C PORTA.DIR=0x00;
	STS  1536,R30
; 0000 057D // Bit0 Output/Pull configuration: Totempole/No
; 0000 057E // Bit0 Input/Sense configuration: Sense both edges
; 0000 057F // Bit0 inverted: Off
; 0000 0580 // Bit0 slew rate limitation: Off
; 0000 0581 PORTA.PIN0CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1552,R30
; 0000 0582 // Bit1 Output/Pull configuration: Totempole/No
; 0000 0583 // Bit1 Input/Sense configuration: Sense both edges
; 0000 0584 // Bit1 inverted: Off
; 0000 0585 // Bit1 slew rate limitation: Off
; 0000 0586 PORTA.PIN1CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1553,R30
; 0000 0587 // Bit2 Output/Pull configuration: Totempole/No
; 0000 0588 // Bit2 Input/Sense configuration: Sense both edges
; 0000 0589 // Bit2 inverted: Off
; 0000 058A // Bit2 slew rate limitation: Off
; 0000 058B PORTA.PIN2CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1554,R30
; 0000 058C // Bit3 Output/Pull configuration: Totempole/No
; 0000 058D // Bit3 Input/Sense configuration: Sense both edges
; 0000 058E // Bit3 inverted: Off
; 0000 058F // Bit3 slew rate limitation: Off
; 0000 0590 PORTA.PIN3CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1555,R30
; 0000 0591 // Bit4 Output/Pull configuration: Totempole/No
; 0000 0592 // Bit4 Input/Sense configuration: Sense both edges
; 0000 0593 // Bit4 inverted: Off
; 0000 0594 // Bit4 slew rate limitation: Off
; 0000 0595 PORTA.PIN4CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1556,R30
; 0000 0596 // Bit5 Output/Pull configuration: Totempole/No
; 0000 0597 // Bit5 Input/Sense configuration: Sense both edges
; 0000 0598 // Bit5 inverted: Off
; 0000 0599 // Bit5 slew rate limitation: Off
; 0000 059A PORTA.PIN5CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1557,R30
; 0000 059B // Bit6 Output/Pull configuration: Totempole/No
; 0000 059C // Bit6 Input/Sense configuration: Sense both edges
; 0000 059D // Bit6 inverted: Off
; 0000 059E // Bit6 slew rate limitation: Off
; 0000 059F PORTA.PIN6CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1558,R30
; 0000 05A0 // Bit7 Output/Pull configuration: Totempole/No
; 0000 05A1 // Bit7 Input/Sense configuration: Sense both edges
; 0000 05A2 // Bit7 inverted: Off
; 0000 05A3 // Bit7 slew rate limitation: Off
; 0000 05A4 PORTA.PIN7CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1559,R30
; 0000 05A5 // Interrupt 0 level: Disabled
; 0000 05A6 // Interrupt 1 level: Disabled
; 0000 05A7 PORTA.INTCTRL=(PORTA.INTCTRL & (~(PORT_INT1LVL_gm | PORT_INT0LVL_gm))) |
; 0000 05A8 	PORT_INT1LVL_OFF_gc | PORT_INT0LVL_OFF_gc;
	LDS  R30,1545
	ANDI R30,LOW(0xF0)
	STS  1545,R30
; 0000 05A9 // Bit0 pin change interrupt 0: Off
; 0000 05AA // Bit1 pin change interrupt 0: Off
; 0000 05AB // Bit2 pin change interrupt 0: Off
; 0000 05AC // Bit3 pin change interrupt 0: Off
; 0000 05AD // Bit4 pin change interrupt 0: Off
; 0000 05AE // Bit5 pin change interrupt 0: Off
; 0000 05AF // Bit6 pin change interrupt 0: Off
; 0000 05B0 // Bit7 pin change interrupt 0: Off
; 0000 05B1 PORTA.INT0MASK=0x00;
	LDI  R30,LOW(0)
	STS  1546,R30
; 0000 05B2 // Bit0 pin change interrupt 1: Off
; 0000 05B3 // Bit1 pin change interrupt 1: Off
; 0000 05B4 // Bit2 pin change interrupt 1: Off
; 0000 05B5 // Bit3 pin change interrupt 1: Off
; 0000 05B6 // Bit4 pin change interrupt 1: Off
; 0000 05B7 // Bit5 pin change interrupt 1: Off
; 0000 05B8 // Bit6 pin change interrupt 1: Off
; 0000 05B9 // Bit7 pin change interrupt 1: Off
; 0000 05BA PORTA.INT1MASK=0x00;
	STS  1547,R30
; 0000 05BB 
; 0000 05BC // PORTB initialization
; 0000 05BD // OUT register
; 0000 05BE PORTB.OUT=0x00;
	STS  1572,R30
; 0000 05BF // Bit0: Input
; 0000 05C0 // Bit1: Input
; 0000 05C1 // Bit2: Input
; 0000 05C2 // Bit3: Input
; 0000 05C3 // Bit4: Input
; 0000 05C4 // Bit5: Input
; 0000 05C5 // Bit6: Input
; 0000 05C6 // Bit7: Input
; 0000 05C7 PORTB.DIR=0x00;
	STS  1568,R30
; 0000 05C8 // Bit0 Output/Pull configuration: Totempole/No
; 0000 05C9 // Bit0 Input/Sense configuration: Sense both edges
; 0000 05CA // Bit0 inverted: Off
; 0000 05CB // Bit0 slew rate limitation: Off
; 0000 05CC PORTB.PIN0CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1584,R30
; 0000 05CD // Bit1 Output/Pull configuration: Totempole/No
; 0000 05CE // Bit1 Input/Sense configuration: Sense both edges
; 0000 05CF // Bit1 inverted: Off
; 0000 05D0 // Bit1 slew rate limitation: Off
; 0000 05D1 PORTB.PIN1CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1585,R30
; 0000 05D2 // Bit2 Output/Pull configuration: Totempole/No
; 0000 05D3 // Bit2 Input/Sense configuration: Sense both edges
; 0000 05D4 // Bit2 inverted: Off
; 0000 05D5 // Bit2 slew rate limitation: Off
; 0000 05D6 PORTB.PIN2CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1586,R30
; 0000 05D7 // Bit3 Output/Pull configuration: Totempole/No
; 0000 05D8 // Bit3 Input/Sense configuration: Sense both edges
; 0000 05D9 // Bit3 inverted: Off
; 0000 05DA // Bit3 slew rate limitation: Off
; 0000 05DB PORTB.PIN3CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1587,R30
; 0000 05DC // Bit4 Output/Pull configuration: Totempole/No
; 0000 05DD // Bit4 Input/Sense configuration: Sense both edges
; 0000 05DE // Bit4 inverted: Off
; 0000 05DF // Bit4 slew rate limitation: Off
; 0000 05E0 PORTB.PIN4CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1588,R30
; 0000 05E1 // Bit5 Output/Pull configuration: Totempole/No
; 0000 05E2 // Bit5 Input/Sense configuration: Sense both edges
; 0000 05E3 // Bit5 inverted: Off
; 0000 05E4 // Bit5 slew rate limitation: Off
; 0000 05E5 PORTB.PIN5CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1589,R30
; 0000 05E6 // Bit6 Output/Pull configuration: Totempole/No
; 0000 05E7 // Bit6 Input/Sense configuration: Sense both edges
; 0000 05E8 // Bit6 inverted: Off
; 0000 05E9 // Bit6 slew rate limitation: Off
; 0000 05EA PORTB.PIN6CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1590,R30
; 0000 05EB // Bit7 Output/Pull configuration: Totempole/No
; 0000 05EC // Bit7 Input/Sense configuration: Sense both edges
; 0000 05ED // Bit7 inverted: Off
; 0000 05EE // Bit7 slew rate limitation: Off
; 0000 05EF PORTB.PIN7CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1591,R30
; 0000 05F0 // Interrupt 0 level: Disabled
; 0000 05F1 // Interrupt 1 level: Disabled
; 0000 05F2 PORTB.INTCTRL=(PORTB.INTCTRL & (~(PORT_INT1LVL_gm | PORT_INT0LVL_gm))) |
; 0000 05F3 	PORT_INT1LVL_OFF_gc | PORT_INT0LVL_OFF_gc;
	LDS  R30,1577
	ANDI R30,LOW(0xF0)
	STS  1577,R30
; 0000 05F4 // Bit0 pin change interrupt 0: Off
; 0000 05F5 // Bit1 pin change interrupt 0: Off
; 0000 05F6 // Bit2 pin change interrupt 0: Off
; 0000 05F7 // Bit3 pin change interrupt 0: Off
; 0000 05F8 // Bit4 pin change interrupt 0: Off
; 0000 05F9 // Bit5 pin change interrupt 0: Off
; 0000 05FA // Bit6 pin change interrupt 0: Off
; 0000 05FB // Bit7 pin change interrupt 0: Off
; 0000 05FC PORTB.INT0MASK=0x00;
	LDI  R30,LOW(0)
	STS  1578,R30
; 0000 05FD // Bit0 pin change interrupt 1: Off
; 0000 05FE // Bit1 pin change interrupt 1: Off
; 0000 05FF // Bit2 pin change interrupt 1: Off
; 0000 0600 // Bit3 pin change interrupt 1: Off
; 0000 0601 // Bit4 pin change interrupt 1: Off
; 0000 0602 // Bit5 pin change interrupt 1: Off
; 0000 0603 // Bit6 pin change interrupt 1: Off
; 0000 0604 // Bit7 pin change interrupt 1: Off
; 0000 0605 PORTB.INT1MASK=0x00;
	STS  1579,R30
; 0000 0606 
; 0000 0607 // PORTC initialization
; 0000 0608 // OUT register
; 0000 0609 PORTC.OUT=0x00;
	STS  1604,R30
; 0000 060A // Bit0: Input
; 0000 060B // Bit1: Input
; 0000 060C // Bit2: Input
; 0000 060D // Bit3: Input
; 0000 060E // Bit4: Input
; 0000 060F // Bit5: Input
; 0000 0610 // Bit6: Input
; 0000 0611 // Bit7: Input
; 0000 0612 PORTC.DIR=0x00;
	STS  1600,R30
; 0000 0613 // Bit0 Output/Pull configuration: Totempole/No
; 0000 0614 // Bit0 Input/Sense configuration: Sense both edges
; 0000 0615 // Bit0 inverted: Off
; 0000 0616 // Bit0 slew rate limitation: Off
; 0000 0617 PORTC.PIN0CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1616,R30
; 0000 0618 // Bit1 Output/Pull configuration: Totempole/No
; 0000 0619 // Bit1 Input/Sense configuration: Sense both edges
; 0000 061A // Bit1 inverted: Off
; 0000 061B // Bit1 slew rate limitation: Off
; 0000 061C PORTC.PIN1CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1617,R30
; 0000 061D // Bit2 Output/Pull configuration: Totempole/No
; 0000 061E // Bit2 Input/Sense configuration: Sense both edges
; 0000 061F // Bit2 inverted: Off
; 0000 0620 // Bit2 slew rate limitation: Off
; 0000 0621 PORTC.PIN2CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1618,R30
; 0000 0622 // Bit3 Output/Pull configuration: Totempole/No
; 0000 0623 // Bit3 Input/Sense configuration: Sense both edges
; 0000 0624 // Bit3 inverted: Off
; 0000 0625 // Bit3 slew rate limitation: Off
; 0000 0626 PORTC.PIN3CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1619,R30
; 0000 0627 // Bit4 Output/Pull configuration: Totempole/No
; 0000 0628 // Bit4 Input/Sense configuration: Sense both edges
; 0000 0629 // Bit4 inverted: Off
; 0000 062A // Bit4 slew rate limitation: Off
; 0000 062B PORTC.PIN4CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1620,R30
; 0000 062C // Bit5 Output/Pull configuration: Totempole/No
; 0000 062D // Bit5 Input/Sense configuration: Sense both edges
; 0000 062E // Bit5 inverted: Off
; 0000 062F // Bit5 slew rate limitation: Off
; 0000 0630 PORTC.PIN5CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1621,R30
; 0000 0631 // Bit6 Output/Pull configuration: Totempole/No
; 0000 0632 // Bit6 Input/Sense configuration: Sense both edges
; 0000 0633 // Bit6 inverted: Off
; 0000 0634 // Bit6 slew rate limitation: Off
; 0000 0635 PORTC.PIN6CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1622,R30
; 0000 0636 // Bit7 Output/Pull configuration: Totempole/No
; 0000 0637 // Bit7 Input/Sense configuration: Sense both edges
; 0000 0638 // Bit7 inverted: Off
; 0000 0639 // Bit7 slew rate limitation: Off
; 0000 063A PORTC.PIN7CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1623,R30
; 0000 063B // Interrupt 0 level: Disabled
; 0000 063C // Interrupt 1 level: Disabled
; 0000 063D PORTC.INTCTRL=(PORTC.INTCTRL & (~(PORT_INT1LVL_gm | PORT_INT0LVL_gm))) |
; 0000 063E 	PORT_INT1LVL_OFF_gc | PORT_INT0LVL_OFF_gc;
	LDS  R30,1609
	ANDI R30,LOW(0xF0)
	STS  1609,R30
; 0000 063F // Bit0 pin change interrupt 0: Off
; 0000 0640 // Bit1 pin change interrupt 0: Off
; 0000 0641 // Bit2 pin change interrupt 0: Off
; 0000 0642 // Bit3 pin change interrupt 0: Off
; 0000 0643 // Bit4 pin change interrupt 0: Off
; 0000 0644 // Bit5 pin change interrupt 0: Off
; 0000 0645 // Bit6 pin change interrupt 0: Off
; 0000 0646 // Bit7 pin change interrupt 0: Off
; 0000 0647 PORTC.INT0MASK=0x00;
	LDI  R30,LOW(0)
	STS  1610,R30
; 0000 0648 // Bit0 pin change interrupt 1: Off
; 0000 0649 // Bit1 pin change interrupt 1: Off
; 0000 064A // Bit2 pin change interrupt 1: Off
; 0000 064B // Bit3 pin change interrupt 1: Off
; 0000 064C // Bit4 pin change interrupt 1: Off
; 0000 064D // Bit5 pin change interrupt 1: Off
; 0000 064E // Bit6 pin change interrupt 1: Off
; 0000 064F // Bit7 pin change interrupt 1: Off
; 0000 0650 PORTC.INT1MASK=0x00;
	STS  1611,R30
; 0000 0651 
; 0000 0652 // PORTD initialization
; 0000 0653 // OUT register
; 0000 0654 PORTD.OUT=0x00;
	STS  1636,R30
; 0000 0655 // Bit0: Input
; 0000 0656 // Bit1: Input
; 0000 0657 // Bit2: Input
; 0000 0658 // Bit3: Input
; 0000 0659 // Bit4: Input
; 0000 065A // Bit5: Input
; 0000 065B // Bit6: Input
; 0000 065C // Bit7: Input
; 0000 065D PORTD.DIR=0x00;
	STS  1632,R30
; 0000 065E // Bit0 Output/Pull configuration: Totempole/No
; 0000 065F // Bit0 Input/Sense configuration: Sense both edges
; 0000 0660 // Bit0 inverted: Off
; 0000 0661 // Bit0 slew rate limitation: Off
; 0000 0662 PORTD.PIN0CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1648,R30
; 0000 0663 // Bit1 Output/Pull configuration: Totempole/No
; 0000 0664 // Bit1 Input/Sense configuration: Sense both edges
; 0000 0665 // Bit1 inverted: Off
; 0000 0666 // Bit1 slew rate limitation: Off
; 0000 0667 PORTD.PIN1CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1649,R30
; 0000 0668 // Bit2 Output/Pull configuration: Totempole/No
; 0000 0669 // Bit2 Input/Sense configuration: Sense both edges
; 0000 066A // Bit2 inverted: Off
; 0000 066B // Bit2 slew rate limitation: Off
; 0000 066C PORTD.PIN2CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1650,R30
; 0000 066D // Bit3 Output/Pull configuration: Totempole/No
; 0000 066E // Bit3 Input/Sense configuration: Sense both edges
; 0000 066F // Bit3 inverted: Off
; 0000 0670 // Bit3 slew rate limitation: Off
; 0000 0671 PORTD.PIN3CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1651,R30
; 0000 0672 // Bit4 Output/Pull configuration: Totempole/No
; 0000 0673 // Bit4 Input/Sense configuration: Sense both edges
; 0000 0674 // Bit4 inverted: Off
; 0000 0675 // Bit4 slew rate limitation: Off
; 0000 0676 PORTD.PIN4CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1652,R30
; 0000 0677 // Bit5 Output/Pull configuration: Totempole/No
; 0000 0678 // Bit5 Input/Sense configuration: Sense both edges
; 0000 0679 // Bit5 inverted: Off
; 0000 067A // Bit5 slew rate limitation: Off
; 0000 067B PORTD.PIN5CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1653,R30
; 0000 067C // Bit6 Output/Pull configuration: Totempole/No
; 0000 067D // Bit6 Input/Sense configuration: Sense both edges
; 0000 067E // Bit6 inverted: Off
; 0000 067F // Bit6 slew rate limitation: Off
; 0000 0680 PORTD.PIN6CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1654,R30
; 0000 0681 // Bit7 Output/Pull configuration: Totempole/No
; 0000 0682 // Bit7 Input/Sense configuration: Sense both edges
; 0000 0683 // Bit7 inverted: Off
; 0000 0684 // Bit7 slew rate limitation: Off
; 0000 0685 PORTD.PIN7CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1655,R30
; 0000 0686 // Interrupt 0 level: Disabled
; 0000 0687 // Interrupt 1 level: Disabled
; 0000 0688 PORTD.INTCTRL=(PORTD.INTCTRL & (~(PORT_INT1LVL_gm | PORT_INT0LVL_gm))) |
; 0000 0689 	PORT_INT1LVL_OFF_gc | PORT_INT0LVL_OFF_gc;
	LDS  R30,1641
	ANDI R30,LOW(0xF0)
	STS  1641,R30
; 0000 068A // Bit0 pin change interrupt 0: Off
; 0000 068B // Bit1 pin change interrupt 0: Off
; 0000 068C // Bit2 pin change interrupt 0: Off
; 0000 068D // Bit3 pin change interrupt 0: Off
; 0000 068E // Bit4 pin change interrupt 0: Off
; 0000 068F // Bit5 pin change interrupt 0: Off
; 0000 0690 // Bit6 pin change interrupt 0: Off
; 0000 0691 // Bit7 pin change interrupt 0: Off
; 0000 0692 PORTD.INT0MASK=0x00;
	LDI  R30,LOW(0)
	STS  1642,R30
; 0000 0693 // Bit0 pin change interrupt 1: Off
; 0000 0694 // Bit1 pin change interrupt 1: Off
; 0000 0695 // Bit2 pin change interrupt 1: Off
; 0000 0696 // Bit3 pin change interrupt 1: Off
; 0000 0697 // Bit4 pin change interrupt 1: Off
; 0000 0698 // Bit5 pin change interrupt 1: Off
; 0000 0699 // Bit6 pin change interrupt 1: Off
; 0000 069A // Bit7 pin change interrupt 1: Off
; 0000 069B PORTD.INT1MASK=0x00;
	STS  1643,R30
; 0000 069C 
; 0000 069D // PORTE initialization
; 0000 069E // OUT register
; 0000 069F PORTE.OUT=0x00;
	STS  1668,R30
; 0000 06A0 // Bit0: Input
; 0000 06A1 // Bit1: Input
; 0000 06A2 // Bit2: Input
; 0000 06A3 // Bit3: Input
; 0000 06A4 // Bit4: Input
; 0000 06A5 // Bit5: Input
; 0000 06A6 // Bit6: Input
; 0000 06A7 // Bit7: Input
; 0000 06A8 PORTE.DIR=0x00;
	STS  1664,R30
; 0000 06A9 // Bit0 Output/Pull configuration: Totempole/No
; 0000 06AA // Bit0 Input/Sense configuration: Sense both edges
; 0000 06AB // Bit0 inverted: Off
; 0000 06AC // Bit0 slew rate limitation: Off
; 0000 06AD PORTE.PIN0CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1680,R30
; 0000 06AE // Bit1 Output/Pull configuration: Totempole/No
; 0000 06AF // Bit1 Input/Sense configuration: Sense both edges
; 0000 06B0 // Bit1 inverted: Off
; 0000 06B1 // Bit1 slew rate limitation: Off
; 0000 06B2 PORTE.PIN1CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1681,R30
; 0000 06B3 // Bit2 Output/Pull configuration: Totempole/No
; 0000 06B4 // Bit2 Input/Sense configuration: Sense both edges
; 0000 06B5 // Bit2 inverted: Off
; 0000 06B6 // Bit2 slew rate limitation: Off
; 0000 06B7 PORTE.PIN2CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1682,R30
; 0000 06B8 // Bit3 Output/Pull configuration: Totempole/No
; 0000 06B9 // Bit3 Input/Sense configuration: Sense both edges
; 0000 06BA // Bit3 inverted: Off
; 0000 06BB // Bit3 slew rate limitation: Off
; 0000 06BC PORTE.PIN3CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1683,R30
; 0000 06BD // Bit4 Output/Pull configuration: Totempole/No
; 0000 06BE // Bit4 Input/Sense configuration: Sense both edges
; 0000 06BF // Bit4 inverted: Off
; 0000 06C0 // Bit4 slew rate limitation: Off
; 0000 06C1 PORTE.PIN4CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1684,R30
; 0000 06C2 // Bit5 Output/Pull configuration: Totempole/No
; 0000 06C3 // Bit5 Input/Sense configuration: Sense both edges
; 0000 06C4 // Bit5 inverted: Off
; 0000 06C5 // Bit5 slew rate limitation: Off
; 0000 06C6 PORTE.PIN5CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1685,R30
; 0000 06C7 // Bit6 Output/Pull configuration: Totempole/No
; 0000 06C8 // Bit6 Input/Sense configuration: Sense both edges
; 0000 06C9 // Bit6 inverted: Off
; 0000 06CA // Bit6 slew rate limitation: Off
; 0000 06CB PORTE.PIN6CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1686,R30
; 0000 06CC // Bit7 Output/Pull configuration: Totempole/No
; 0000 06CD // Bit7 Input/Sense configuration: Sense both edges
; 0000 06CE // Bit7 inverted: Off
; 0000 06CF // Bit7 slew rate limitation: Off
; 0000 06D0 PORTE.PIN7CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1687,R30
; 0000 06D1 // Interrupt 0 level: Disabled
; 0000 06D2 // Interrupt 1 level: Disabled
; 0000 06D3 PORTE.INTCTRL=(PORTE.INTCTRL & (~(PORT_INT1LVL_gm | PORT_INT0LVL_gm))) |
; 0000 06D4 	PORT_INT1LVL_OFF_gc | PORT_INT0LVL_OFF_gc;
	LDS  R30,1673
	ANDI R30,LOW(0xF0)
	STS  1673,R30
; 0000 06D5 // Bit0 pin change interrupt 0: Off
; 0000 06D6 // Bit1 pin change interrupt 0: Off
; 0000 06D7 // Bit2 pin change interrupt 0: Off
; 0000 06D8 // Bit3 pin change interrupt 0: Off
; 0000 06D9 // Bit4 pin change interrupt 0: Off
; 0000 06DA // Bit5 pin change interrupt 0: Off
; 0000 06DB // Bit6 pin change interrupt 0: Off
; 0000 06DC // Bit7 pin change interrupt 0: Off
; 0000 06DD PORTE.INT0MASK=0x00;
	LDI  R30,LOW(0)
	STS  1674,R30
; 0000 06DE // Bit0 pin change interrupt 1: Off
; 0000 06DF // Bit1 pin change interrupt 1: Off
; 0000 06E0 // Bit2 pin change interrupt 1: Off
; 0000 06E1 // Bit3 pin change interrupt 1: Off
; 0000 06E2 // Bit4 pin change interrupt 1: Off
; 0000 06E3 // Bit5 pin change interrupt 1: Off
; 0000 06E4 // Bit6 pin change interrupt 1: Off
; 0000 06E5 // Bit7 pin change interrupt 1: Off
; 0000 06E6 PORTE.INT1MASK=0x00;
	STS  1675,R30
; 0000 06E7 
; 0000 06E8 // PORTF initialization
; 0000 06E9 // OUT register
; 0000 06EA PORTF.OUT=0x00;
	STS  1700,R30
; 0000 06EB // Bit0: Input
; 0000 06EC // Bit1: Input
; 0000 06ED // Bit2: Input
; 0000 06EE // Bit3: Input
; 0000 06EF // Bit4: Input
; 0000 06F0 // Bit5: Input
; 0000 06F1 // Bit6: Input
; 0000 06F2 // Bit7: Input
; 0000 06F3 PORTF.DIR=0x00;
	STS  1696,R30
; 0000 06F4 // Bit0 Output/Pull configuration: Totempole/No
; 0000 06F5 // Bit0 Input/Sense configuration: Sense both edges
; 0000 06F6 // Bit0 inverted: Off
; 0000 06F7 // Bit0 slew rate limitation: Off
; 0000 06F8 PORTF.PIN0CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1712,R30
; 0000 06F9 // Bit1 Output/Pull configuration: Totempole/No
; 0000 06FA // Bit1 Input/Sense configuration: Sense both edges
; 0000 06FB // Bit1 inverted: Off
; 0000 06FC // Bit1 slew rate limitation: Off
; 0000 06FD PORTF.PIN1CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1713,R30
; 0000 06FE // Bit2 Output/Pull configuration: Totempole/No
; 0000 06FF // Bit2 Input/Sense configuration: Sense both edges
; 0000 0700 // Bit2 inverted: Off
; 0000 0701 // Bit2 slew rate limitation: Off
; 0000 0702 PORTF.PIN2CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1714,R30
; 0000 0703 // Bit3 Output/Pull configuration: Totempole/No
; 0000 0704 // Bit3 Input/Sense configuration: Sense both edges
; 0000 0705 // Bit3 inverted: Off
; 0000 0706 // Bit3 slew rate limitation: Off
; 0000 0707 PORTF.PIN3CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1715,R30
; 0000 0708 // Bit4 Output/Pull configuration: Totempole/No
; 0000 0709 // Bit4 Input/Sense configuration: Sense both edges
; 0000 070A // Bit4 inverted: Off
; 0000 070B // Bit4 slew rate limitation: Off
; 0000 070C PORTF.PIN4CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1716,R30
; 0000 070D // Bit5 Output/Pull configuration: Totempole/No
; 0000 070E // Bit5 Input/Sense configuration: Sense both edges
; 0000 070F // Bit5 inverted: Off
; 0000 0710 // Bit5 slew rate limitation: Off
; 0000 0711 PORTF.PIN5CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1717,R30
; 0000 0712 // Bit6 Output/Pull configuration: Totempole/No
; 0000 0713 // Bit6 Input/Sense configuration: Sense both edges
; 0000 0714 // Bit6 inverted: Off
; 0000 0715 // Bit6 slew rate limitation: Off
; 0000 0716 PORTF.PIN6CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1718,R30
; 0000 0717 // Bit7 Output/Pull configuration: Totempole/No
; 0000 0718 // Bit7 Input/Sense configuration: Sense both edges
; 0000 0719 // Bit7 inverted: Off
; 0000 071A // Bit7 slew rate limitation: Off
; 0000 071B PORTF.PIN7CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1719,R30
; 0000 071C // Interrupt 0 level: Disabled
; 0000 071D // Interrupt 1 level: Disabled
; 0000 071E PORTF.INTCTRL=(PORTF.INTCTRL & (~(PORT_INT1LVL_gm | PORT_INT0LVL_gm))) |
; 0000 071F 	PORT_INT1LVL_OFF_gc | PORT_INT0LVL_OFF_gc;
	LDS  R30,1705
	ANDI R30,LOW(0xF0)
	STS  1705,R30
; 0000 0720 // Bit0 pin change interrupt 0: Off
; 0000 0721 // Bit1 pin change interrupt 0: Off
; 0000 0722 // Bit2 pin change interrupt 0: Off
; 0000 0723 // Bit3 pin change interrupt 0: Off
; 0000 0724 // Bit4 pin change interrupt 0: Off
; 0000 0725 // Bit5 pin change interrupt 0: Off
; 0000 0726 // Bit6 pin change interrupt 0: Off
; 0000 0727 // Bit7 pin change interrupt 0: Off
; 0000 0728 PORTF.INT0MASK=0x00;
	LDI  R30,LOW(0)
	STS  1706,R30
; 0000 0729 // Bit0 pin change interrupt 1: Off
; 0000 072A // Bit1 pin change interrupt 1: Off
; 0000 072B // Bit2 pin change interrupt 1: Off
; 0000 072C // Bit3 pin change interrupt 1: Off
; 0000 072D // Bit4 pin change interrupt 1: Off
; 0000 072E // Bit5 pin change interrupt 1: Off
; 0000 072F // Bit6 pin change interrupt 1: Off
; 0000 0730 // Bit7 pin change interrupt 1: Off
; 0000 0731 PORTF.INT1MASK=0x00;
	STS  1707,R30
; 0000 0732 
; 0000 0733 // PORTH initialization
; 0000 0734 // OUT register
; 0000 0735 PORTH.OUT=0x00;
	STS  1764,R30
; 0000 0736 // Bit0: Input
; 0000 0737 // Bit1: Input
; 0000 0738 // Bit2: Input
; 0000 0739 // Bit3: Input
; 0000 073A // Bit4: Input
; 0000 073B // Bit5: Input
; 0000 073C // Bit6: Input
; 0000 073D // Bit7: Input
; 0000 073E PORTH.DIR=0x00;
	STS  1760,R30
; 0000 073F // Bit0 Output/Pull configuration: Totempole/No
; 0000 0740 // Bit0 Input/Sense configuration: Sense both edges
; 0000 0741 // Bit0 inverted: Off
; 0000 0742 // Bit0 slew rate limitation: Off
; 0000 0743 PORTH.PIN0CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1776,R30
; 0000 0744 // Bit1 Output/Pull configuration: Totempole/No
; 0000 0745 // Bit1 Input/Sense configuration: Sense both edges
; 0000 0746 // Bit1 inverted: Off
; 0000 0747 // Bit1 slew rate limitation: Off
; 0000 0748 PORTH.PIN1CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1777,R30
; 0000 0749 // Bit2 Output/Pull configuration: Totempole/No
; 0000 074A // Bit2 Input/Sense configuration: Sense both edges
; 0000 074B // Bit2 inverted: Off
; 0000 074C // Bit2 slew rate limitation: Off
; 0000 074D PORTH.PIN2CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1778,R30
; 0000 074E // Bit3 Output/Pull configuration: Totempole/No
; 0000 074F // Bit3 Input/Sense configuration: Sense both edges
; 0000 0750 // Bit3 inverted: Off
; 0000 0751 // Bit3 slew rate limitation: Off
; 0000 0752 PORTH.PIN3CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1779,R30
; 0000 0753 // Bit4 Output/Pull configuration: Totempole/No
; 0000 0754 // Bit4 Input/Sense configuration: Sense both edges
; 0000 0755 // Bit4 inverted: Off
; 0000 0756 // Bit4 slew rate limitation: Off
; 0000 0757 PORTH.PIN4CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1780,R30
; 0000 0758 // Bit5 Output/Pull configuration: Totempole/No
; 0000 0759 // Bit5 Input/Sense configuration: Sense both edges
; 0000 075A // Bit5 inverted: Off
; 0000 075B // Bit5 slew rate limitation: Off
; 0000 075C PORTH.PIN5CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1781,R30
; 0000 075D // Bit6 Output/Pull configuration: Totempole/No
; 0000 075E // Bit6 Input/Sense configuration: Sense both edges
; 0000 075F // Bit6 inverted: Off
; 0000 0760 // Bit6 slew rate limitation: Off
; 0000 0761 PORTH.PIN6CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1782,R30
; 0000 0762 // Bit7 Output/Pull configuration: Totempole/No
; 0000 0763 // Bit7 Input/Sense configuration: Sense both edges
; 0000 0764 // Bit7 inverted: Off
; 0000 0765 // Bit7 slew rate limitation: Off
; 0000 0766 PORTH.PIN7CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1783,R30
; 0000 0767 // Interrupt 0 level: Disabled
; 0000 0768 // Interrupt 1 level: Disabled
; 0000 0769 PORTH.INTCTRL=(PORTH.INTCTRL & (~(PORT_INT1LVL_gm | PORT_INT0LVL_gm))) |
; 0000 076A 	PORT_INT1LVL_OFF_gc | PORT_INT0LVL_OFF_gc;
	LDS  R30,1769
	ANDI R30,LOW(0xF0)
	STS  1769,R30
; 0000 076B // Bit0 pin change interrupt 0: Off
; 0000 076C // Bit1 pin change interrupt 0: Off
; 0000 076D // Bit2 pin change interrupt 0: Off
; 0000 076E // Bit3 pin change interrupt 0: Off
; 0000 076F // Bit4 pin change interrupt 0: Off
; 0000 0770 // Bit5 pin change interrupt 0: Off
; 0000 0771 // Bit6 pin change interrupt 0: Off
; 0000 0772 // Bit7 pin change interrupt 0: Off
; 0000 0773 PORTH.INT0MASK=0x00;
	LDI  R30,LOW(0)
	STS  1770,R30
; 0000 0774 // Bit0 pin change interrupt 1: Off
; 0000 0775 // Bit1 pin change interrupt 1: Off
; 0000 0776 // Bit2 pin change interrupt 1: Off
; 0000 0777 // Bit3 pin change interrupt 1: Off
; 0000 0778 // Bit4 pin change interrupt 1: Off
; 0000 0779 // Bit5 pin change interrupt 1: Off
; 0000 077A // Bit6 pin change interrupt 1: Off
; 0000 077B // Bit7 pin change interrupt 1: Off
; 0000 077C PORTH.INT1MASK=0x00;
	STS  1771,R30
; 0000 077D 
; 0000 077E // PORTJ initialization
; 0000 077F // OUT register
; 0000 0780 PORTJ.OUT=0x00;
	STS  1796,R30
; 0000 0781 // Bit0: Input
; 0000 0782 // Bit1: Input
; 0000 0783 // Bit2: Input
; 0000 0784 // Bit3: Input
; 0000 0785 // Bit4: Input
; 0000 0786 // Bit5: Input
; 0000 0787 // Bit6: Input
; 0000 0788 // Bit7: Input
; 0000 0789 PORTJ.DIR=0x00;
	STS  1792,R30
; 0000 078A // Bit0 Output/Pull configuration: Totempole/No
; 0000 078B // Bit0 Input/Sense configuration: Sense both edges
; 0000 078C // Bit0 inverted: Off
; 0000 078D // Bit0 slew rate limitation: Off
; 0000 078E PORTJ.PIN0CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1808,R30
; 0000 078F // Bit1 Output/Pull configuration: Totempole/No
; 0000 0790 // Bit1 Input/Sense configuration: Sense both edges
; 0000 0791 // Bit1 inverted: Off
; 0000 0792 // Bit1 slew rate limitation: Off
; 0000 0793 PORTJ.PIN1CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1809,R30
; 0000 0794 // Bit2 Output/Pull configuration: Totempole/No
; 0000 0795 // Bit2 Input/Sense configuration: Sense both edges
; 0000 0796 // Bit2 inverted: Off
; 0000 0797 // Bit2 slew rate limitation: Off
; 0000 0798 PORTJ.PIN2CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1810,R30
; 0000 0799 // Bit3 Output/Pull configuration: Totempole/No
; 0000 079A // Bit3 Input/Sense configuration: Sense both edges
; 0000 079B // Bit3 inverted: Off
; 0000 079C // Bit3 slew rate limitation: Off
; 0000 079D PORTJ.PIN3CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1811,R30
; 0000 079E // Bit4 Output/Pull configuration: Totempole/No
; 0000 079F // Bit4 Input/Sense configuration: Sense both edges
; 0000 07A0 // Bit4 inverted: Off
; 0000 07A1 // Bit4 slew rate limitation: Off
; 0000 07A2 PORTJ.PIN4CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1812,R30
; 0000 07A3 // Bit5 Output/Pull configuration: Totempole/No
; 0000 07A4 // Bit5 Input/Sense configuration: Sense both edges
; 0000 07A5 // Bit5 inverted: Off
; 0000 07A6 // Bit5 slew rate limitation: Off
; 0000 07A7 PORTJ.PIN5CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1813,R30
; 0000 07A8 // Bit6 Output/Pull configuration: Totempole/No
; 0000 07A9 // Bit6 Input/Sense configuration: Sense both edges
; 0000 07AA // Bit6 inverted: Off
; 0000 07AB // Bit6 slew rate limitation: Off
; 0000 07AC PORTJ.PIN6CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1814,R30
; 0000 07AD // Bit7 Output/Pull configuration: Totempole/No
; 0000 07AE // Bit7 Input/Sense configuration: Sense both edges
; 0000 07AF // Bit7 inverted: Off
; 0000 07B0 // Bit7 slew rate limitation: Off
; 0000 07B1 PORTJ.PIN7CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1815,R30
; 0000 07B2 // Interrupt 0 level: Disabled
; 0000 07B3 // Interrupt 1 level: Disabled
; 0000 07B4 PORTJ.INTCTRL=(PORTJ.INTCTRL & (~(PORT_INT1LVL_gm | PORT_INT0LVL_gm))) |
; 0000 07B5 	PORT_INT1LVL_OFF_gc | PORT_INT0LVL_OFF_gc;
	LDS  R30,1801
	ANDI R30,LOW(0xF0)
	STS  1801,R30
; 0000 07B6 // Bit0 pin change interrupt 0: Off
; 0000 07B7 // Bit1 pin change interrupt 0: Off
; 0000 07B8 // Bit2 pin change interrupt 0: Off
; 0000 07B9 // Bit3 pin change interrupt 0: Off
; 0000 07BA // Bit4 pin change interrupt 0: Off
; 0000 07BB // Bit5 pin change interrupt 0: Off
; 0000 07BC // Bit6 pin change interrupt 0: Off
; 0000 07BD // Bit7 pin change interrupt 0: Off
; 0000 07BE PORTJ.INT0MASK=0x00;
	LDI  R30,LOW(0)
	STS  1802,R30
; 0000 07BF // Bit0 pin change interrupt 1: Off
; 0000 07C0 // Bit1 pin change interrupt 1: Off
; 0000 07C1 // Bit2 pin change interrupt 1: Off
; 0000 07C2 // Bit3 pin change interrupt 1: Off
; 0000 07C3 // Bit4 pin change interrupt 1: Off
; 0000 07C4 // Bit5 pin change interrupt 1: Off
; 0000 07C5 // Bit6 pin change interrupt 1: Off
; 0000 07C6 // Bit7 pin change interrupt 1: Off
; 0000 07C7 PORTJ.INT1MASK=0x00;
	STS  1803,R30
; 0000 07C8 
; 0000 07C9 // PORTK initialization
; 0000 07CA // OUT register
; 0000 07CB PORTK.OUT=0x00;
	STS  1828,R30
; 0000 07CC // Bit0: Input
; 0000 07CD // Bit1: Input
; 0000 07CE // Bit2: Input
; 0000 07CF // Bit3: Input
; 0000 07D0 // Bit4: Input
; 0000 07D1 // Bit5: Input
; 0000 07D2 // Bit6: Input
; 0000 07D3 // Bit7: Input
; 0000 07D4 PORTK.DIR=0x00;
	STS  1824,R30
; 0000 07D5 // Bit0 Output/Pull configuration: Totempole/No
; 0000 07D6 // Bit0 Input/Sense configuration: Sense both edges
; 0000 07D7 // Bit0 inverted: Off
; 0000 07D8 // Bit0 slew rate limitation: Off
; 0000 07D9 PORTK.PIN0CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1840,R30
; 0000 07DA // Bit1 Output/Pull configuration: Totempole/No
; 0000 07DB // Bit1 Input/Sense configuration: Sense both edges
; 0000 07DC // Bit1 inverted: Off
; 0000 07DD // Bit1 slew rate limitation: Off
; 0000 07DE PORTK.PIN1CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1841,R30
; 0000 07DF // Bit2 Output/Pull configuration: Totempole/No
; 0000 07E0 // Bit2 Input/Sense configuration: Sense both edges
; 0000 07E1 // Bit2 inverted: Off
; 0000 07E2 // Bit2 slew rate limitation: Off
; 0000 07E3 PORTK.PIN2CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1842,R30
; 0000 07E4 // Bit3 Output/Pull configuration: Totempole/No
; 0000 07E5 // Bit3 Input/Sense configuration: Sense both edges
; 0000 07E6 // Bit3 inverted: Off
; 0000 07E7 // Bit3 slew rate limitation: Off
; 0000 07E8 PORTK.PIN3CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1843,R30
; 0000 07E9 // Bit4 Output/Pull configuration: Totempole/No
; 0000 07EA // Bit4 Input/Sense configuration: Sense both edges
; 0000 07EB // Bit4 inverted: Off
; 0000 07EC // Bit4 slew rate limitation: Off
; 0000 07ED PORTK.PIN4CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1844,R30
; 0000 07EE // Bit5 Output/Pull configuration: Totempole/No
; 0000 07EF // Bit5 Input/Sense configuration: Sense both edges
; 0000 07F0 // Bit5 inverted: Off
; 0000 07F1 // Bit5 slew rate limitation: Off
; 0000 07F2 PORTK.PIN5CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1845,R30
; 0000 07F3 // Bit6 Output/Pull configuration: Totempole/No
; 0000 07F4 // Bit6 Input/Sense configuration: Sense both edges
; 0000 07F5 // Bit6 inverted: Off
; 0000 07F6 // Bit6 slew rate limitation: Off
; 0000 07F7 PORTK.PIN6CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1846,R30
; 0000 07F8 // Bit7 Output/Pull configuration: Totempole/No
; 0000 07F9 // Bit7 Input/Sense configuration: Sense both edges
; 0000 07FA // Bit7 inverted: Off
; 0000 07FB // Bit7 slew rate limitation: Off
; 0000 07FC PORTK.PIN7CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  1847,R30
; 0000 07FD // Interrupt 0 level: Disabled
; 0000 07FE // Interrupt 1 level: Disabled
; 0000 07FF PORTK.INTCTRL=(PORTK.INTCTRL & (~(PORT_INT1LVL_gm | PORT_INT0LVL_gm))) |
; 0000 0800 	PORT_INT1LVL_OFF_gc | PORT_INT0LVL_OFF_gc;
	LDS  R30,1833
	ANDI R30,LOW(0xF0)
	STS  1833,R30
; 0000 0801 // Bit0 pin change interrupt 0: Off
; 0000 0802 // Bit1 pin change interrupt 0: Off
; 0000 0803 // Bit2 pin change interrupt 0: Off
; 0000 0804 // Bit3 pin change interrupt 0: Off
; 0000 0805 // Bit4 pin change interrupt 0: Off
; 0000 0806 // Bit5 pin change interrupt 0: Off
; 0000 0807 // Bit6 pin change interrupt 0: Off
; 0000 0808 // Bit7 pin change interrupt 0: Off
; 0000 0809 PORTK.INT0MASK=0x00;
	LDI  R30,LOW(0)
	STS  1834,R30
; 0000 080A // Bit0 pin change interrupt 1: Off
; 0000 080B // Bit1 pin change interrupt 1: Off
; 0000 080C // Bit2 pin change interrupt 1: Off
; 0000 080D // Bit3 pin change interrupt 1: Off
; 0000 080E // Bit4 pin change interrupt 1: Off
; 0000 080F // Bit5 pin change interrupt 1: Off
; 0000 0810 // Bit6 pin change interrupt 1: Off
; 0000 0811 // Bit7 pin change interrupt 1: Off
; 0000 0812 PORTK.INT1MASK=0x00;
	STS  1835,R30
; 0000 0813 
; 0000 0814 // PORTQ initialization
; 0000 0815 // OUT register
; 0000 0816 PORTQ.OUT=0x00;
	STS  1988,R30
; 0000 0817 // Bit0: Input
; 0000 0818 // Bit1: Input
; 0000 0819 // Bit2: Input
; 0000 081A // Bit3: Input
; 0000 081B PORTQ.DIR=0x00;
	STS  1984,R30
; 0000 081C // Bit0 Output/Pull configuration: Totempole/No
; 0000 081D // Bit0 Input/Sense configuration: Sense both edges
; 0000 081E // Bit0 inverted: Off
; 0000 081F // Bit0 slew rate limitation: Off
; 0000 0820 PORTQ.PIN0CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  2000,R30
; 0000 0821 // Bit1 Output/Pull configuration: Totempole/No
; 0000 0822 // Bit1 Input/Sense configuration: Sense both edges
; 0000 0823 // Bit1 inverted: Off
; 0000 0824 // Bit1 slew rate limitation: Off
; 0000 0825 PORTQ.PIN1CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  2001,R30
; 0000 0826 // Bit2 Output/Pull configuration: Totempole/No
; 0000 0827 // Bit2 Input/Sense configuration: Sense both edges
; 0000 0828 // Bit2 inverted: Off
; 0000 0829 // Bit2 slew rate limitation: Off
; 0000 082A PORTQ.PIN2CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  2002,R30
; 0000 082B // Bit3 Output/Pull configuration: Totempole/No
; 0000 082C // Bit3 Input/Sense configuration: Sense both edges
; 0000 082D // Bit3 inverted: Off
; 0000 082E // Bit3 slew rate limitation: Off
; 0000 082F PORTQ.PIN3CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  2003,R30
; 0000 0830 // Interrupt 0 level: Disabled
; 0000 0831 // Interrupt 1 level: Disabled
; 0000 0832 PORTQ.INTCTRL=(PORTQ.INTCTRL & (~(PORT_INT1LVL_gm | PORT_INT0LVL_gm))) |
; 0000 0833 	PORT_INT1LVL_OFF_gc | PORT_INT0LVL_OFF_gc;
	LDS  R30,1993
	ANDI R30,LOW(0xF0)
	STS  1993,R30
; 0000 0834 // Bit0 pin change interrupt 0: Off
; 0000 0835 // Bit1 pin change interrupt 0: Off
; 0000 0836 // Bit2 pin change interrupt 0: Off
; 0000 0837 // Bit3 pin change interrupt 0: Off
; 0000 0838 PORTQ.INT0MASK=0x00;
	LDI  R30,LOW(0)
	STS  1994,R30
; 0000 0839 // Bit0 pin change interrupt 1: Off
; 0000 083A // Bit1 pin change interrupt 1: Off
; 0000 083B // Bit2 pin change interrupt 1: Off
; 0000 083C // Bit3 pin change interrupt 1: Off
; 0000 083D PORTQ.INT1MASK=0x00;
	STS  1995,R30
; 0000 083E 
; 0000 083F // PORTR initialization
; 0000 0840 // OUT register
; 0000 0841 PORTR.OUT=0x00;
	STS  2020,R30
; 0000 0842 // Bit0: Input
; 0000 0843 // Bit1: Input
; 0000 0844 PORTR.DIR=0x00;
	STS  2016,R30
; 0000 0845 // Bit0 Output/Pull configuration: Totempole/No
; 0000 0846 // Bit0 Input/Sense configuration: Sense both edges
; 0000 0847 // Bit0 inverted: Off
; 0000 0848 // Bit0 slew rate limitation: Off
; 0000 0849 PORTR.PIN0CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  2032,R30
; 0000 084A // Bit1 Output/Pull configuration: Totempole/No
; 0000 084B // Bit1 Input/Sense configuration: Sense both edges
; 0000 084C // Bit1 inverted: Off
; 0000 084D // Bit1 slew rate limitation: Off
; 0000 084E PORTR.PIN1CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
	STS  2033,R30
; 0000 084F // Interrupt 0 level: Disabled
; 0000 0850 // Interrupt 1 level: Disabled
; 0000 0851 PORTR.INTCTRL=(PORTR.INTCTRL & (~(PORT_INT1LVL_gm | PORT_INT0LVL_gm))) |
; 0000 0852 	PORT_INT1LVL_OFF_gc | PORT_INT0LVL_OFF_gc;
	LDS  R30,2025
	ANDI R30,LOW(0xF0)
	STS  2025,R30
; 0000 0853 // Bit0 pin change interrupt 0: Off
; 0000 0854 // Bit1 pin change interrupt 0: Off
; 0000 0855 PORTR.INT0MASK=0x00;
	LDI  R30,LOW(0)
	STS  2026,R30
; 0000 0856 // Bit0 pin change interrupt 1: Off
; 0000 0857 // Bit1 pin change interrupt 1: Off
; 0000 0858 PORTR.INT1MASK=0x00;
	STS  2027,R30
; 0000 0859 }
	RET
;
;// Virtual Ports initialization
;void vports_init(void)
; 0000 085D {
_vports_init:
; 0000 085E // PORTA mapped to VPORT0
; 0000 085F // PORTB mapped to VPORT1
; 0000 0860 PORTCFG.VPCTRLA=PORTCFG_VP1MAP_PORTB_gc | PORTCFG_VP0MAP_PORTA_gc;
	LDI  R30,LOW(16)
	STS  178,R30
; 0000 0861 // PORTC mapped to VPORT2
; 0000 0862 // PORTD mapped to VPORT3
; 0000 0863 PORTCFG.VPCTRLB=PORTCFG_VP3MAP_PORTD_gc | PORTCFG_VP2MAP_PORTC_gc;
	LDI  R30,LOW(50)
	STS  179,R30
; 0000 0864 }
	RET
;
;// Disable a Timer/Counter type 0
;void tc0_disable(TC0_t *ptc)
; 0000 0868 {
_tc0_disable:
; 0000 0869 // Timer/Counter off
; 0000 086A ptc->CTRLA=(ptc->CTRLA & (~TC0_CLKSEL_gm)) | TC_CLKSEL_OFF_gc;
;	*ptc -> Y+0
; 0000 086B // Issue a reset command
; 0000 086C ptc->CTRLFSET=TC_CMD_RESET_gc;
; 0000 086D }
;
;// Disable a Timer/Counter type 1
;void tc1_disable(TC1_t *ptc)
; 0000 0871 {
_tc1_disable:
; 0000 0872 // Timer/Counter off
; 0000 0873 ptc->CTRLA=(ptc->CTRLA & (~TC1_CLKSEL_gm)) | TC_CLKSEL_OFF_gc;
;	*ptc -> Y+0
_0x2060007:
	LD   R26,Y
	LDD  R27,Y+1
	LD   R30,X
	ANDI R30,LOW(0xF0)
	ST   X,R30
; 0000 0874 // Issue a reset command
; 0000 0875 ptc->CTRLFSET=TC_CMD_RESET_gc;
	ADIW R26,9
	LDI  R30,LOW(12)
	ST   X,R30
; 0000 0876 }
	ADIW R28,2
	RET
;
;// Timer/Counter TCC0 initialization
;void tcc0_init(void)
; 0000 087A {
_tcc0_init:
; 0000 087B unsigned char s;
; 0000 087C unsigned char n;
; 0000 087D 
; 0000 087E // Note: the correct PORTC direction for the Compare Channels outputs
; 0000 087F // is configured in the ports_init function
; 0000 0880 
; 0000 0881 // Save interrupts enabled/disabled state
; 0000 0882 s=SREG;
	ST   -Y,R17
	ST   -Y,R16
;	s -> R17
;	n -> R16
	IN   R17,63
; 0000 0883 // Disable interrupts
; 0000 0884 #asm("cli")
	cli
; 0000 0885 
; 0000 0886 // Disable and reset the timer/counter just to be sure
; 0000 0887 tc0_disable(&TCC0);
	LDI  R30,LOW(2048)
	LDI  R31,HIGH(2048)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _tc0_disable
; 0000 0888 // Clock source: Peripheral Clock/1
; 0000 0889 TCC0.CTRLA=(TCC0.CTRLA & (~TC0_CLKSEL_gm)) | TC_CLKSEL_DIV1_gc;
	LDS  R30,2048
	ANDI R30,LOW(0xF0)
	ORI  R30,1
	STS  2048,R30
; 0000 088A // Mode: Normal Operation, Overflow Int./Event on TOP
; 0000 088B // Compare/Capture on channel A: Off
; 0000 088C // Compare/Capture on channel B: Off
; 0000 088D // Compare/Capture on channel C: Off
; 0000 088E // Compare/Capture on channel D: Off
; 0000 088F TCC0.CTRLB=(TCC0.CTRLB & (~(TC0_CCAEN_bm | TC0_CCBEN_bm | TC0_CCCEN_bm | TC0_CCDEN_bm | TC0_WGMODE_gm))) |
; 0000 0890 	TC_WGMODE_NORMAL_gc;
	LDS  R30,2049
	ANDI R30,LOW(0x8)
	STS  2049,R30
; 0000 0891 
; 0000 0892 // Capture event source: None
; 0000 0893 // Capture event action: None
; 0000 0894 TCC0.CTRLD=(TCC0.CTRLD & (~(TC0_EVACT_gm | TC0_EVSEL_gm))) |
; 0000 0895 	TC_EVACT_OFF_gc | TC_EVSEL_OFF_gc;
	LDS  R30,2051
	ANDI R30,LOW(0x10)
	STS  2051,R30
; 0000 0896 
; 0000 0897 // Overflow interrupt: High Level
; 0000 0898 // Error interrupt: Disabled
; 0000 0899 TCC0.INTCTRLA=(TCC0.INTCTRLA & (~(TC0_ERRINTLVL_gm | TC0_OVFINTLVL_gm))) |
; 0000 089A 	TC_ERRINTLVL_OFF_gc | TC_OVFINTLVL_HI_gc;
	LDS  R30,2054
	ANDI R30,LOW(0xF0)
	ORI  R30,LOW(0x3)
	STS  2054,R30
; 0000 089B 
; 0000 089C // Compare/Capture channel A interrupt: Disabled
; 0000 089D // Compare/Capture channel B interrupt: Disabled
; 0000 089E // Compare/Capture channel C interrupt: Disabled
; 0000 089F // Compare/Capture channel D interrupt: Disabled
; 0000 08A0 TCC0.INTCTRLB=(TCC0.INTCTRLB & (~(TC0_CCDINTLVL_gm | TC0_CCCINTLVL_gm | TC0_CCBINTLVL_gm | TC0_CCAINTLVL_gm))) |
; 0000 08A1 	TC_CCDINTLVL_OFF_gc | TC_CCCINTLVL_OFF_gc | TC_CCBINTLVL_OFF_gc | TC_CCAINTLVL_OFF_gc;
	LDS  R30,2055
	ANDI R30,LOW(0x0)
	STS  2055,R30
; 0000 08A2 
; 0000 08A3 // High resolution extension: Off
; 0000 08A4 HIRESC.CTRL&= ~HIRES_HREN0_bm;
	LDS  R30,2192
	ANDI R30,0xFE
	STS  2192,R30
; 0000 08A5 
; 0000 08A6 // Advanced Waveform Extension initialization
; 0000 08A7 // Optimize for speed
; 0000 08A8 #pragma optsize-
; 0000 08A9 // Disable locking the AWEX configuration registers just to be sure
; 0000 08AA n=MCU.AWEXLOCK & (~MCU_AWEXCLOCK_bm);
	LDS  R30,153
	ANDI R30,0xFE
	MOV  R16,R30
; 0000 08AB CCP=CCP_IOREG_gc;
	LDI  R30,LOW(216)
	OUT  0x34,R30
; 0000 08AC MCU.AWEXLOCK=n;
	STS  153,R16
; 0000 08AD // Restore optimization for size if needed
; 0000 08AE #pragma optsize_default
; 0000 08AF 
; 0000 08B0 // Pattern generation: Off
; 0000 08B1 // Dead time insertion: Off
; 0000 08B2 AWEXC.CTRL&= ~(AWEX_PGM_bm | AWEX_CWCM_bm | AWEX_DTICCDEN_bm | AWEX_DTICCCEN_bm | AWEX_DTICCBEN_bm | AWEX_DTICCAEN_bm);
	LDS  R30,2176
	ANDI R30,LOW(0xC0)
	STS  2176,R30
; 0000 08B3 
; 0000 08B4 // Fault protection initialization
; 0000 08B5 // Fault detection on OCD Break detection: On
; 0000 08B6 // Fault detection restart mode: Latched Mode
; 0000 08B7 // Fault detection action: None (Fault protection disabled)
; 0000 08B8 AWEXC.FDCTRL=(AWEXC.FDCTRL & (~(AWEX_FDDBD_bm | AWEX_FDMODE_bm | AWEX_FDACT_gm))) |
; 0000 08B9 	AWEX_FDACT_NONE_gc;
	LDS  R30,2179
	ANDI R30,LOW(0xE8)
	STS  2179,R30
; 0000 08BA // Fault detect events:
; 0000 08BB // Event channel 0: Off
; 0000 08BC // Event channel 1: Off
; 0000 08BD // Event channel 2: Off
; 0000 08BE // Event channel 3: Off
; 0000 08BF // Event channel 4: Off
; 0000 08C0 // Event channel 5: Off
; 0000 08C1 // Event channel 6: Off
; 0000 08C2 // Event channel 7: Off
; 0000 08C3 AWEXC.FDEVMASK=0b00000000;
	LDI  R30,LOW(0)
	STS  2178,R30
; 0000 08C4 // Make sure the fault detect flag is cleared
; 0000 08C5 AWEXC.STATUS|=AWEXC.STATUS & AWEX_FDF_bm;
	LDI  R26,LOW(2180)
	LDI  R27,HIGH(2180)
	MOV  R0,R26
	LD   R26,X
	LDS  R30,2180
	ANDI R30,LOW(0x4)
	OR   R30,R26
	MOV  R26,R0
	ST   X,R30
; 0000 08C6 
; 0000 08C7 // Clear the interrupt flags
; 0000 08C8 TCC0.INTFLAGS=TCC0.INTFLAGS;
	LDS  R30,2060
	STS  2060,R30
; 0000 08C9 // Set counter register
; 0000 08CA TCC0.CNT=0x0000;
	CALL SUBOPT_0x1D
; 0000 08CB // Set period register
; 0000 08CC TCC0.PER=0x00DF;
	LDI  R30,LOW(223)
	LDI  R31,HIGH(223)
	STS  2086,R30
	STS  2086+1,R31
; 0000 08CD // Set channel A Compare/Capture register
; 0000 08CE TCC0.CCA=0x0000;
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	STS  2088,R30
	STS  2088+1,R31
; 0000 08CF // Set channel B Compare/Capture register
; 0000 08D0 TCC0.CCB=0x0000;
	STS  2090,R30
	STS  2090+1,R31
; 0000 08D1 // Set channel C Compare/Capture register
; 0000 08D2 TCC0.CCC=0x0000;
	STS  2092,R30
	STS  2092+1,R31
; 0000 08D3 // Set channel D Compare/Capture register
; 0000 08D4 TCC0.CCD=0x0000;
	STS  2094,R30
	STS  2094+1,R31
; 0000 08D5 
; 0000 08D6 // Restore interrupts enabled/disabled state
; 0000 08D7 SREG=s;
	OUT  0x3F,R17
; 0000 08D8 }
_0x2060006:
	LD   R16,Y+
	LD   R17,Y+
	RET
;
;// Timer/counter TCC0 Overflow/Underflow interrupt service routine
;interrupt [TCC0_OVF_vect] void tcc0_overflow_isr(void)
; 0000 08DC {
_tcc0_overflow_isr:
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
; 0000 08DD // write your code here
; 0000 08DE     glcd_timer_isr();
	CALL _glcd_timer_isr
; 0000 08DF }
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
;// Timer/Counter TCC1 initialization
;void tcc1_init(void)
; 0000 08E3 {
_tcc1_init:
; 0000 08E4 unsigned char s;
; 0000 08E5 
; 0000 08E6 // Note: the correct PORTC direction for the Compare Channels outputs
; 0000 08E7 // is configured in the ports_init function
; 0000 08E8 
; 0000 08E9 // Save interrupts enabled/disabled state
; 0000 08EA s=SREG;
	ST   -Y,R17
;	s -> R17
	IN   R17,63
; 0000 08EB // Disable interrupts
; 0000 08EC #asm("cli")
	cli
; 0000 08ED 
; 0000 08EE // Disable and reset the timer/counter just to be sure
; 0000 08EF tc1_disable(&TCC1);
	LDI  R30,LOW(2112)
	LDI  R31,HIGH(2112)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _tc1_disable
; 0000 08F0 // Clock source: Peripheral Clock/1
; 0000 08F1 TCC1.CTRLA=(TCC1.CTRLA & (~TC1_CLKSEL_gm)) | TC_CLKSEL_DIV1_gc;
	LDS  R30,2112
	ANDI R30,LOW(0xF0)
	ORI  R30,1
	STS  2112,R30
; 0000 08F2 // Mode: Normal Operation, Overflow Int./Event on TOP
; 0000 08F3 // Compare/Capture on channel A: Off
; 0000 08F4 // Compare/Capture on channel B: Off
; 0000 08F5 TCC1.CTRLB=(TCC1.CTRLB & (~(TC1_CCAEN_bm | TC1_CCBEN_bm | TC1_WGMODE_gm))) |
; 0000 08F6 	TC_WGMODE_NORMAL_gc;
	LDS  R30,2113
	ANDI R30,LOW(0xC8)
	STS  2113,R30
; 0000 08F7 
; 0000 08F8 // Capture event source: None
; 0000 08F9 // Capture event action: None
; 0000 08FA TCC1.CTRLD=(TCC1.CTRLD & (~(TC1_EVACT_gm | TC1_EVSEL_gm))) |
; 0000 08FB 	TC_EVACT_OFF_gc | TC_EVSEL_OFF_gc;
	LDS  R30,2115
	ANDI R30,LOW(0x10)
	STS  2115,R30
; 0000 08FC 
; 0000 08FD // Overflow interrupt: Medium Level
; 0000 08FE // Error interrupt: Disabled
; 0000 08FF TCC1.INTCTRLA=(TCC1.INTCTRLA & (~(TC1_ERRINTLVL_gm | TC1_OVFINTLVL_gm))) |
; 0000 0900 	TC_ERRINTLVL_OFF_gc | TC_OVFINTLVL_MED_gc;
	LDS  R30,2118
	ANDI R30,LOW(0xF0)
	ORI  R30,2
	STS  2118,R30
; 0000 0901 
; 0000 0902 // Compare/Capture channel A interrupt: Disabled
; 0000 0903 // Compare/Capture channel B interrupt: Disabled
; 0000 0904 TCC1.INTCTRLB=(TCC1.INTCTRLB & (~(TC1_CCBINTLVL_gm | TC1_CCAINTLVL_gm))) |
; 0000 0905 	TC_CCBINTLVL_OFF_gc | TC_CCAINTLVL_OFF_gc;
	LDS  R30,2119
	ANDI R30,LOW(0xF0)
	STS  2119,R30
; 0000 0906 
; 0000 0907 // High resolution extension: Off
; 0000 0908 HIRESC.CTRL&= ~HIRES_HREN1_bm;
	LDS  R30,2192
	ANDI R30,0xFD
	STS  2192,R30
; 0000 0909 
; 0000 090A // Clear the interrupt flags
; 0000 090B TCC1.INTFLAGS=TCC1.INTFLAGS;
	LDS  R30,2124
	STS  2124,R30
; 0000 090C // Set counter register
; 0000 090D TCC1.CNT=0x0000;
	CALL SUBOPT_0x1E
; 0000 090E // Set period register
; 0000 090F TCC1.PER=0xFFFF;
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	STS  2150,R30
	STS  2150+1,R31
; 0000 0910 // Set channel A Compare/Capture register
; 0000 0911 TCC1.CCA=0x0000;
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	STS  2152,R30
	STS  2152+1,R31
; 0000 0912 // Set channel B Compare/Capture register
; 0000 0913 TCC1.CCB=0x0000;
	STS  2154,R30
	STS  2154+1,R31
; 0000 0914 
; 0000 0915 // Restore interrupts enabled/disabled state
; 0000 0916 SREG=s;
	OUT  0x3F,R17
; 0000 0917 }
_0x2060005:
	LD   R17,Y+
	RET
;
;unsigned int InterruptCounter = 0;
;// Timer/counter TCC1 Overflow/Underflow interrupt service routine
;interrupt [TCC1_OVF_vect] void tcc1_overflow_isr(void)
; 0000 091C {
_tcc1_overflow_isr:
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
; 0000 091D // write your code here
; 0000 091E     InterruptCounter++;
	LDS  R30,_InterruptCounter
	LDS  R31,_InterruptCounter+1
	ADIW R30,1
	STS  _InterruptCounter,R30
	STS  _InterruptCounter+1,R31
; 0000 091F }
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	RETI
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
;
;
;
;
;
;unsigned int CTRLA_value = 0x01;

	.DSEG
;
;inline void timer_stop (void)
; 0000 096D {

	.CSEG
_timer_stop:
; 0000 096E   TCC0.CNT = 0x0000;
	CALL SUBOPT_0x1D
; 0000 096F   TCC0.CTRLA = 0x00;
	LDI  R30,LOW(0)
	RJMP _0x2060004
; 0000 0970 }
;
;inline void timer_start (void)
; 0000 0973 {
_timer_start:
; 0000 0974   TCC0.CTRLA = CTRLA_value;
	LDS  R30,_CTRLA_value
_0x2060004:
	STS  2048,R30
; 0000 0975 }
	RET
;
;inline void set_7us (void)
; 0000 0978 {
_set_7us:
; 0000 0979   CTRLA_value = 0x01;
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	STS  _CTRLA_value,R30
	STS  _CTRLA_value+1,R31
; 0000 097A   TCC0.PER=0x00DF;
	LDI  R30,LOW(223)
	LDI  R31,HIGH(223)
	RJMP _0x2060003
; 0000 097B }
;
;inline void set_10ms (void)
; 0000 097E {
_set_10ms:
; 0000 097F   CTRLA_value = 0x04;
	LDI  R30,LOW(4)
	LDI  R31,HIGH(4)
	STS  _CTRLA_value,R30
	STS  _CTRLA_value+1,R31
; 0000 0980   TCC0.PER=0x9C3F;
	LDI  R30,LOW(39999)
	LDI  R31,HIGH(39999)
_0x2060003:
	STS  2086,R30
	STS  2086+1,R31
; 0000 0981 }
	RET
;
;void main(void)
; 0000 0984 {
_main:
; 0000 0985 // Declare your local variables here
; 0000 0986 unsigned char n;
; 0000 0987 unsigned char str[22];
; 0000 0988 
; 0000 0989 // Interrupt system initialization
; 0000 098A // Optimize for speed
; 0000 098B #pragma optsize-
; 0000 098C // Make sure the interrupts are disabled
; 0000 098D #asm("cli")
	SBIW R28,22
;	n -> R17
;	str -> Y+0
	cli
; 0000 098E // Low level interrupt: Off
; 0000 098F // Round-robin scheduling for low level interrupt: Off
; 0000 0990 // Medium level interrupt: On
; 0000 0991 // High level interrupt: On
; 0000 0992 // The interrupt vectors will be placed at the start of the Application FLASH section
; 0000 0993 n=(PMIC.CTRL & (~(PMIC_RREN_bm | PMIC_IVSEL_bm | PMIC_HILVLEN_bm | PMIC_MEDLVLEN_bm | PMIC_LOLVLEN_bm))) |
; 0000 0994 	PMIC_MEDLVLEN_bm | PMIC_HILVLEN_bm;
	LDS  R30,162
	ANDI R30,LOW(0x38)
	ORI  R30,LOW(0x6)
	MOV  R17,R30
; 0000 0995 CCP=CCP_IOREG_gc;
	LDI  R30,LOW(216)
	OUT  0x34,R30
; 0000 0996 PMIC.CTRL=n;
	STS  162,R17
; 0000 0997 // Set the default priority for round-robin scheduling
; 0000 0998 PMIC.INTPRI=0x00;
	LDI  R30,LOW(0)
	STS  161,R30
; 0000 0999 // Restore optimization for size if needed
; 0000 099A #pragma optsize_default
; 0000 099B 
; 0000 099C // System clocks initialization
; 0000 099D system_clocks_init();
	RCALL _system_clocks_init
; 0000 099E 
; 0000 099F // Ports initialization
; 0000 09A0 ports_init();
	RCALL _ports_init
; 0000 09A1 
; 0000 09A2 // Virtual Ports initialization
; 0000 09A3 vports_init();
	RCALL _vports_init
; 0000 09A4 
; 0000 09A5 // Timer/Counter TCC0 initialization
; 0000 09A6 tcc0_init();
	RCALL _tcc0_init
; 0000 09A7 timer_stop;
	LDI  R30,LOW(_timer_stop)
	LDI  R31,HIGH(_timer_stop)
; 0000 09A8 timer_interrupt_enable = (void (*)())(timer_start);
	LDI  R30,LOW(_timer_start)
	LDI  R31,HIGH(_timer_start)
	MOVW R4,R30
; 0000 09A9 timer_interrupt_disable = (void (*)())(timer_stop);
	LDI  R30,LOW(_timer_stop)
	LDI  R31,HIGH(_timer_stop)
	MOVW R6,R30
; 0000 09AA set_delay_7us = (void (*)())(set_7us);
	LDI  R30,LOW(_set_7us)
	LDI  R31,HIGH(_set_7us)
	MOVW R8,R30
; 0000 09AB set_delay_10ms = (void (*)())(set_10ms);
	LDI  R30,LOW(_set_10ms)
	LDI  R31,HIGH(_set_10ms)
	MOVW R10,R30
; 0000 09AC 
; 0000 09AD // Timer/Counter TCC1 initialization
; 0000 09AE tcc1_init();
	RCALL _tcc1_init
; 0000 09AF 
; 0000 09B0 // Globaly enable interrupts
; 0000 09B1 #asm("sei")
	sei
; 0000 09B2 delay_ms(500);
	LDI  R30,LOW(500)
	LDI  R31,HIGH(500)
	ST   -Y,R31
	ST   -Y,R30
	CALL _delay_ms
; 0000 09B3 glcd_define2(&(PORTE.OUT), &(PORTD.OUT), 1, &(PORTD.OUT), 4, &(PORTD.OUT), 5, &(PORTF.OUT), 1, &(PORTF.OUT), 2, &(PORTF.OUT), 3);
	LDI  R30,LOW(1668)
	LDI  R31,HIGH(1668)
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0x1F
	LDI  R30,LOW(1)
	ST   -Y,R30
	CALL SUBOPT_0x1F
	LDI  R30,LOW(4)
	ST   -Y,R30
	CALL SUBOPT_0x1F
	LDI  R30,LOW(5)
	CALL SUBOPT_0x20
	LDI  R30,LOW(1)
	CALL SUBOPT_0x20
	LDI  R30,LOW(2)
	CALL SUBOPT_0x20
	LDI  R30,LOW(3)
	ST   -Y,R30
	RCALL _glcd_define2
; 0000 09B4 glcd_init2();
	RCALL _glcd_init2
; 0000 09B5 TCC1.CNT = 0;
	CALL SUBOPT_0x1E
; 0000 09B6 InterruptCounter = 0;
	LDI  R30,LOW(0)
	STS  _InterruptCounter,R30
	STS  _InterruptCounter+1,R30
; 0000 09B7 glcd_putbmp2 (picture);
	LDI  R30,LOW(_picture*2)
	LDI  R31,HIGH(_picture*2)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _glcd_putbmp2
; 0000 09B8 delay_ms(1000);
	LDI  R30,LOW(1000)
	LDI  R31,HIGH(1000)
	ST   -Y,R31
	ST   -Y,R30
	CALL _delay_ms
; 0000 09B9 TCC1.CTRLA = 0x00;
	LDI  R30,LOW(0)
	STS  2112,R30
; 0000 09BA sprintf(str,"0x%04X%04X",InterruptCounter,TCC1.CNT);
	MOVW R30,R28
	ST   -Y,R31
	ST   -Y,R30
	__POINTW1FN _0x0,0
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_InterruptCounter
	LDS  R31,_InterruptCounter+1
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	LDS  R30,2144
	LDS  R31,2144+1
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	LDI  R24,8
	RCALL _sprintf
	ADIW R28,12
; 0000 09BB glcd_clear2();
	RCALL _glcd_clear2
; 0000 09BC glcd_puts_center2(0,str);
	LDI  R30,LOW(0)
	ST   -Y,R30
	MOVW R30,R28
	ADIW R30,1
	ST   -Y,R31
	ST   -Y,R30
	RCALL _glcd_puts_center2
; 0000 09BD 
; 0000 09BE 
; 0000 09BF while (1)
_0x14B:
; 0000 09C0       {
; 0000 09C1       // Place your code here
; 0000 09C2 
; 0000 09C3       }
	RJMP _0x14B
; 0000 09C4 }
_0x14E:
	RJMP _0x14E

	.CSEG
_put_buff_G100:
	ST   -Y,R17
	ST   -Y,R16
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	ADIW R26,2
	CALL __GETW1P
	SBIW R30,0
	BREQ _0x2000016
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	ADIW R26,4
	CALL __GETW1P
	MOVW R16,R30
	SBIW R30,0
	BREQ _0x2000018
	__CPWRN 16,17,2
	BRLO _0x2000019
	MOVW R30,R16
	SBIW R30,1
	MOVW R16,R30
	__PUTW1SNS 2,4
_0x2000018:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	ADIW R26,2
	CALL __GETW1P
	ADIW R30,1
	ST   X+,R30
	ST   X,R31
	SBIW R30,1
	LDD  R26,Y+4
	STD  Z+0,R26
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	CALL __GETW1P
	TST  R31
	BRMI _0x200001A
	CALL __GETW1P
	ADIW R30,1
	ST   X+,R30
	ST   X,R31
_0x200001A:
_0x2000019:
	RJMP _0x200001B
_0x2000016:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	ST   X+,R30
	ST   X,R31
_0x200001B:
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,5
	RET
__print_G100:
	SBIW R28,6
	CALL __SAVELOCR6
	LDI  R17,0
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	ST   X+,R30
	ST   X,R31
_0x200001C:
	LDD  R30,Y+18
	LDD  R31,Y+18+1
	ADIW R30,1
	STD  Y+18,R30
	STD  Y+18+1,R31
	SBIW R30,1
	LPM  R30,Z
	MOV  R18,R30
	CPI  R30,0
	BRNE PC+3
	JMP _0x200001E
	MOV  R30,R17
	CPI  R30,0
	BRNE _0x2000022
	CPI  R18,37
	BRNE _0x2000023
	LDI  R17,LOW(1)
	RJMP _0x2000024
_0x2000023:
	CALL SUBOPT_0x21
_0x2000024:
	RJMP _0x2000021
_0x2000022:
	CPI  R30,LOW(0x1)
	BRNE _0x2000025
	CPI  R18,37
	BRNE _0x2000026
	CALL SUBOPT_0x21
	RJMP _0x20000CF
_0x2000026:
	LDI  R17,LOW(2)
	LDI  R20,LOW(0)
	LDI  R16,LOW(0)
	CPI  R18,45
	BRNE _0x2000027
	LDI  R16,LOW(1)
	RJMP _0x2000021
_0x2000027:
	CPI  R18,43
	BRNE _0x2000028
	LDI  R20,LOW(43)
	RJMP _0x2000021
_0x2000028:
	CPI  R18,32
	BRNE _0x2000029
	LDI  R20,LOW(32)
	RJMP _0x2000021
_0x2000029:
	RJMP _0x200002A
_0x2000025:
	CPI  R30,LOW(0x2)
	BRNE _0x200002B
_0x200002A:
	LDI  R21,LOW(0)
	LDI  R17,LOW(3)
	CPI  R18,48
	BRNE _0x200002C
	ORI  R16,LOW(128)
	RJMP _0x2000021
_0x200002C:
	RJMP _0x200002D
_0x200002B:
	CPI  R30,LOW(0x3)
	BREQ PC+3
	JMP _0x2000021
_0x200002D:
	CPI  R18,48
	BRLO _0x2000030
	CPI  R18,58
	BRLO _0x2000031
_0x2000030:
	RJMP _0x200002F
_0x2000031:
	LDI  R26,LOW(10)
	MUL  R21,R26
	MOV  R21,R0
	MOV  R30,R18
	SUBI R30,LOW(48)
	ADD  R21,R30
	RJMP _0x2000021
_0x200002F:
	MOV  R30,R18
	CPI  R30,LOW(0x63)
	BRNE _0x2000035
	CALL SUBOPT_0x22
	LDD  R30,Y+16
	LDD  R31,Y+16+1
	LDD  R26,Z+4
	ST   -Y,R26
	CALL SUBOPT_0x23
	RJMP _0x2000036
_0x2000035:
	CPI  R30,LOW(0x73)
	BRNE _0x2000038
	CALL SUBOPT_0x22
	CALL SUBOPT_0x24
	CALL _strlen
	MOV  R17,R30
	RJMP _0x2000039
_0x2000038:
	CPI  R30,LOW(0x70)
	BRNE _0x200003B
	CALL SUBOPT_0x22
	CALL SUBOPT_0x24
	CALL _strlenf
	MOV  R17,R30
	ORI  R16,LOW(8)
_0x2000039:
	ORI  R16,LOW(2)
	ANDI R16,LOW(127)
	LDI  R19,LOW(0)
	RJMP _0x200003C
_0x200003B:
	CPI  R30,LOW(0x64)
	BREQ _0x200003F
	CPI  R30,LOW(0x69)
	BRNE _0x2000040
_0x200003F:
	ORI  R16,LOW(4)
	RJMP _0x2000041
_0x2000040:
	CPI  R30,LOW(0x75)
	BRNE _0x2000042
_0x2000041:
	LDI  R30,LOW(_tbl10_G100*2)
	LDI  R31,HIGH(_tbl10_G100*2)
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R17,LOW(5)
	RJMP _0x2000043
_0x2000042:
	CPI  R30,LOW(0x58)
	BRNE _0x2000045
	ORI  R16,LOW(8)
	RJMP _0x2000046
_0x2000045:
	CPI  R30,LOW(0x78)
	BREQ PC+3
	JMP _0x2000077
_0x2000046:
	LDI  R30,LOW(_tbl16_G100*2)
	LDI  R31,HIGH(_tbl16_G100*2)
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R17,LOW(4)
_0x2000043:
	SBRS R16,2
	RJMP _0x2000048
	CALL SUBOPT_0x22
	CALL SUBOPT_0x25
	LDD  R26,Y+11
	TST  R26
	BRPL _0x2000049
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	CALL __ANEGW1
	STD  Y+10,R30
	STD  Y+10+1,R31
	LDI  R20,LOW(45)
_0x2000049:
	CPI  R20,0
	BREQ _0x200004A
	SUBI R17,-LOW(1)
	RJMP _0x200004B
_0x200004A:
	ANDI R16,LOW(251)
_0x200004B:
	RJMP _0x200004C
_0x2000048:
	CALL SUBOPT_0x22
	CALL SUBOPT_0x25
_0x200004C:
_0x200003C:
	SBRC R16,0
	RJMP _0x200004D
_0x200004E:
	CP   R17,R21
	BRSH _0x2000050
	SBRS R16,7
	RJMP _0x2000051
	SBRS R16,2
	RJMP _0x2000052
	ANDI R16,LOW(251)
	MOV  R18,R20
	SUBI R17,LOW(1)
	RJMP _0x2000053
_0x2000052:
	LDI  R18,LOW(48)
_0x2000053:
	RJMP _0x2000054
_0x2000051:
	LDI  R18,LOW(32)
_0x2000054:
	CALL SUBOPT_0x21
	SUBI R21,LOW(1)
	RJMP _0x200004E
_0x2000050:
_0x200004D:
	MOV  R19,R17
	SBRS R16,1
	RJMP _0x2000055
_0x2000056:
	CPI  R19,0
	BREQ _0x2000058
	SBRS R16,3
	RJMP _0x2000059
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	LPM  R18,Z+
	STD  Y+6,R30
	STD  Y+6+1,R31
	RJMP _0x200005A
_0x2000059:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LD   R18,X+
	STD  Y+6,R26
	STD  Y+6+1,R27
_0x200005A:
	CALL SUBOPT_0x21
	CPI  R21,0
	BREQ _0x200005B
	SUBI R21,LOW(1)
_0x200005B:
	SUBI R19,LOW(1)
	RJMP _0x2000056
_0x2000058:
	RJMP _0x200005C
_0x2000055:
_0x200005E:
	LDI  R18,LOW(48)
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	CALL __GETW1PF
	STD  Y+8,R30
	STD  Y+8+1,R31
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ADIW R30,2
	STD  Y+6,R30
	STD  Y+6+1,R31
_0x2000060:
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	LDD  R26,Y+10
	LDD  R27,Y+10+1
	CP   R26,R30
	CPC  R27,R31
	BRLO _0x2000062
	SUBI R18,-LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	SUB  R30,R26
	SBC  R31,R27
	STD  Y+10,R30
	STD  Y+10+1,R31
	RJMP _0x2000060
_0x2000062:
	CPI  R18,58
	BRLO _0x2000063
	SBRS R16,3
	RJMP _0x2000064
	SUBI R18,-LOW(7)
	RJMP _0x2000065
_0x2000064:
	SUBI R18,-LOW(39)
_0x2000065:
_0x2000063:
	SBRC R16,4
	RJMP _0x2000067
	CPI  R18,49
	BRSH _0x2000069
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,1
	BRNE _0x2000068
_0x2000069:
	RJMP _0x20000D0
_0x2000068:
	CP   R21,R19
	BRLO _0x200006D
	SBRS R16,0
	RJMP _0x200006E
_0x200006D:
	RJMP _0x200006C
_0x200006E:
	LDI  R18,LOW(32)
	SBRS R16,7
	RJMP _0x200006F
	LDI  R18,LOW(48)
_0x20000D0:
	ORI  R16,LOW(16)
	SBRS R16,2
	RJMP _0x2000070
	ANDI R16,LOW(251)
	ST   -Y,R20
	CALL SUBOPT_0x23
	CPI  R21,0
	BREQ _0x2000071
	SUBI R21,LOW(1)
_0x2000071:
_0x2000070:
_0x200006F:
_0x2000067:
	CALL SUBOPT_0x21
	CPI  R21,0
	BREQ _0x2000072
	SUBI R21,LOW(1)
_0x2000072:
_0x200006C:
	SUBI R19,LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,2
	BRLO _0x200005F
	RJMP _0x200005E
_0x200005F:
_0x200005C:
	SBRS R16,0
	RJMP _0x2000073
_0x2000074:
	CPI  R21,0
	BREQ _0x2000076
	SUBI R21,LOW(1)
	LDI  R30,LOW(32)
	ST   -Y,R30
	CALL SUBOPT_0x23
	RJMP _0x2000074
_0x2000076:
_0x2000073:
_0x2000077:
_0x2000036:
_0x20000CF:
	LDI  R17,LOW(0)
_0x2000021:
	RJMP _0x200001C
_0x200001E:
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	CALL __GETW1P
	CALL __LOADLOCR6
_0x2060002:
	ADIW R28,20
	RET
_sprintf:
	PUSH R15
	MOV  R15,R24
	SBIW R28,6
	CALL __SAVELOCR4
	CALL SUBOPT_0x26
	SBIW R30,0
	BRNE _0x2000078
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	RJMP _0x2060001
_0x2000078:
	MOVW R26,R28
	ADIW R26,6
	CALL __ADDW2R15
	MOVW R16,R26
	CALL SUBOPT_0x26
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R30,LOW(0)
	STD  Y+8,R30
	STD  Y+8+1,R30
	MOVW R26,R28
	ADIW R26,10
	CALL __ADDW2R15
	CALL __GETW1P
	ST   -Y,R31
	ST   -Y,R30
	ST   -Y,R17
	ST   -Y,R16
	LDI  R30,LOW(_put_buff_G100)
	LDI  R31,HIGH(_put_buff_G100)
	ST   -Y,R31
	ST   -Y,R30
	MOVW R30,R28
	ADIW R30,10
	ST   -Y,R31
	ST   -Y,R30
	RCALL __print_G100
	MOVW R18,R30
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LDI  R30,LOW(0)
	ST   X,R30
	MOVW R30,R18
_0x2060001:
	CALL __LOADLOCR4
	ADIW R28,10
	POP  R15
	RET

	.CSEG

	.CSEG
_strlen:
    ld   r26,y+
    ld   r27,y+
    clr  r30
    clr  r31
strlen0:
    ld   r22,x+
    tst  r22
    breq strlen1
    adiw r30,1
    rjmp strlen0
strlen1:
    ret
_strlenf:
    clr  r26
    clr  r27
    ld   r30,y+
    ld   r31,y+
strlenf0:
	lpm  r0,z+
    tst  r0
    breq strlenf1
    adiw r26,1
    rjmp strlenf0
strlenf1:
    movw r30,r26
    ret

	.DSEG
_glcd_data_address_G000:
	.BYTE 0x2
_glcd_rs_address_G000:
	.BYTE 0x2
_glcd_rs_bit_msk_G000:
	.BYTE 0x1
_glcd_rw_address_G000:
	.BYTE 0x2
_glcd_rw_bit_msk_G000:
	.BYTE 0x1
_glcd_en_address_G000:
	.BYTE 0x2
_glcd_en_bit_msk_G000:
	.BYTE 0x1
_glcd_cs1_address_G000:
	.BYTE 0x2
_glcd_cs1_bit_msk_G000:
	.BYTE 0x1
_glcd_cs2_address_G000:
	.BYTE 0x2
_glcd_cs2_bit_msk_G000:
	.BYTE 0x1
_glcd_rst_address_G000:
	.BYTE 0x2
_glcd_rst_bit_msk_G000:
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
_InterruptCounter:
	.BYTE 0x2
_CTRLA_value:
	.BYTE 0x2

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 15 TIMES, CODE SIZE REDUCTION:221 WORDS
SUBOPT_0x0:
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
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 14 TIMES, CODE SIZE REDUCTION:36 WORDS
SUBOPT_0x1:
	CALL _PopCase
	MOV  R30,R13
	COM  R30
	CPI  R30,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 28 TIMES, CODE SIZE REDUCTION:105 WORDS
SUBOPT_0x2:
	MOV  R30,R13
	LDI  R31,0
	SUBI R30,LOW(-_CaseStack)
	SBCI R31,HIGH(-_CaseStack)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x3:
	LDS  R30,_glcd_en_bit_msk_G000
	__PUTB1PMNS _glcd_en_address_G000,2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x4:
	LDS  R30,_glcd_en_bit_msk_G000
	__PUTB1PMNS _glcd_en_address_G000,1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0x5:
	LDS  R30,_glcd_cs1_bit_msk_G000
	__PUTB1PMNS _glcd_cs1_address_G000,3
	LDS  R30,_glcd_cs2_bit_msk_G000
	__PUTB1PMNS _glcd_cs2_address_G000,3
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 15 TIMES, CODE SIZE REDUCTION:25 WORDS
SUBOPT_0x6:
	LDS  R26,_glcd_data_address_G000
	LDS  R27,_glcd_data_address_G000+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x7:
	STS  _i_S0000005000,R30
	LDS  R26,_i_S0000005000
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:27 WORDS
SUBOPT_0x8:
	LDS  R30,_glcd_rs_bit_msk_G000
	__PUTB1PMNS _glcd_rs_address_G000,2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:39 WORDS
SUBOPT_0x9:
	LDS  R30,_glcd_cs1_bit_msk_G000
	__PUTB1PMNS _glcd_cs1_address_G000,2
	LDS  R30,_glcd_cs2_bit_msk_G000
	__PUTB1PMNS _glcd_cs2_address_G000,1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xA:
	LDS  R30,_glcd_rst_bit_msk_G000
	__PUTB1PMNS _glcd_rst_address_G000,1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xB:
	LDS  R30,_glcd_rst_bit_msk_G000
	__PUTB1PMNS _glcd_rst_address_G000,2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0xC:
	LDS  R30,_glcd_rs_bit_msk_G000
	__PUTB1PMNS _glcd_rs_address_G000,1
	LDS  R30,_glcd_rw_bit_msk_G000
	__PUTB1PMNS _glcd_rw_address_G000,2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:21 WORDS
SUBOPT_0xD:
	LDS  R30,_glcd_rw_bit_msk_G000
	__PUTB1PMNS _glcd_rw_address_G000,2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0xE:
	LDS  R30,_glcd_cs1_bit_msk_G000
	__PUTB1PMNS _glcd_cs1_address_G000,1
	LDS  R30,_glcd_cs2_bit_msk_G000
	__PUTB1PMNS _glcd_cs2_address_G000,2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0xF:
	LDS  R30,_GlcdColumn
	SUBI R30,-LOW(1)
	STS  _GlcdColumn,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x10:
	LDS  R30,_GlcdChar
	LDI  R26,LOW(6)
	MUL  R30,R26
	MOVW R30,R0
	SUBI R30,LOW(-_glcd_font*2)
	SBCI R31,HIGH(-_glcd_font*2)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x11:
	LDS  R30,_i_S0000005000
	LDI  R31,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x12:
	LDS  R26,_GlcdString
	LDS  R27,_GlcdString+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x13:
	RCALL SUBOPT_0x12
	LD   R30,X+
	STS  _GlcdString,R26
	STS  _GlcdString+1,R27
	STS  _GlcdChar,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x14:
	STS  _i_S0000005000,R30
	LDI  R26,LOW(6)
	MULS R30,R26
	MOVW R30,R0
	STS  _i_S0000005000,R30
	RJMP SUBOPT_0x11

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x15:
	LDI  R26,LOW(128)
	LDI  R27,HIGH(128)
	CALL __SWAPW12
	SUB  R30,R26
	SBC  R31,R27
	RJMP SUBOPT_0x7

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x16:
	LDI  R27,0
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	CALL __DIVW21
	STS  _GlcdColumn,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x17:
	LDS  R30,_GlcdFlashString
	LDS  R31,_GlcdFlashString+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x18:
	RCALL SUBOPT_0x17
	LPM  R0,Z+
	STS  _GlcdFlashString,R30
	STS  _GlcdFlashString+1,R31
	STS  _GlcdChar,R0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x19:
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	ST   -Y,R31
	ST   -Y,R30
	JMP  _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x1A:
	ST   X,R30
	CALL _glcd_unlock_lock2
	RJMP SUBOPT_0x6

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x1B:
	RCALL SUBOPT_0x6
	ST   X,R30
	JMP  _glcd_unlock_lock2

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1C:
	ADD  R30,R26
	ADC  R31,R27
	LPM  R30,Z
	ST   -Y,R30
	JMP  _glcd_writebyte2

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1D:
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	STS  2080,R30
	STS  2080+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1E:
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	STS  2144,R30
	STS  2144+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1F:
	LDI  R30,LOW(1636)
	LDI  R31,HIGH(1636)
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x20:
	ST   -Y,R30
	LDI  R30,LOW(1700)
	LDI  R31,HIGH(1700)
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:21 WORDS
SUBOPT_0x21:
	ST   -Y,R18
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+17
	LDD  R31,Y+17+1
	ICALL
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x22:
	LDD  R30,Y+16
	LDD  R31,Y+16+1
	SBIW R30,4
	STD  Y+16,R30
	STD  Y+16+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x23:
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+17
	LDD  R31,Y+17+1
	ICALL
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x24:
	LDD  R26,Y+16
	LDD  R27,Y+16+1
	ADIW R26,4
	CALL __GETW1P
	STD  Y+6,R30
	STD  Y+6+1,R31
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x25:
	LDD  R26,Y+16
	LDD  R27,Y+16+1
	ADIW R26,4
	CALL __GETW1P
	STD  Y+10,R30
	STD  Y+10+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x26:
	MOVW R26,R28
	ADIW R26,12
	CALL __ADDW2R15
	CALL __GETW1P
	RET


	.CSEG
_delay_ms:
	ld   r30,y+
	ld   r31,y+
	adiw r30,0
	breq __delay_ms1
__delay_ms0:
	__DELAY_USW 0x1F40
	wdr
	sbiw r30,1
	brne __delay_ms0
__delay_ms1:
	ret

__ADDW2R15:
	CLR  R0
	ADD  R26,R15
	ADC  R27,R0
	RET

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

__GETW1P:
	LD   R30,X+
	LD   R31,X
	SBIW R26,1
	RET

__GETW1PF:
	LPM  R0,Z+
	LPM  R31,Z
	MOV  R30,R0
	RET

__PUTPARD1:
	ST   -Y,R23
	ST   -Y,R22
	ST   -Y,R31
	ST   -Y,R30
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

__SAVELOCR6:
	ST   -Y,R21
__SAVELOCR5:
	ST   -Y,R20
__SAVELOCR4:
	ST   -Y,R19
__SAVELOCR3:
	ST   -Y,R18
__SAVELOCR2:
	ST   -Y,R17
	ST   -Y,R16
	RET

__LOADLOCR6:
	LDD  R21,Y+5
__LOADLOCR5:
	LDD  R20,Y+4
__LOADLOCR4:
	LDD  R19,Y+3
__LOADLOCR3:
	LDD  R18,Y+2
__LOADLOCR2:
	LDD  R17,Y+1
	LD   R16,Y
	RET

;END OF CODE MARKER
__END_OF_CODE:
